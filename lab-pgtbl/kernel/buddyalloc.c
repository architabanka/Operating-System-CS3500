#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "buddyalloc.h"
#include "defs.h"

#ifndef BUDDY_OFF

#define MAXORDER 9    // 2MB = 512 pages
#define MAXPAGES ((PHYSTOP - KERNBASE) / PGSIZE)

struct buddy_run {
  struct buddy_run *prev;
  struct buddy_run *next;
};

// The three states a page-aligned physical address can be in,
// as recorded by buddy_run_metadata[].
enum block_status {
  FREE      = 0x00,   // whole block of the stored order, on freelist[order]
  ALLOCATED = 0x10,   // whole block of the stored order, handed out by buddyalloc()
  SUBSUMED  = 0x20,   // part  of a bigger block whose base is at a lower address
};

struct {
  struct spinlock lock;

  // Physical range managed by the allocator, after superpage rounding.
  uint64 managed_start;
  uint64 managed_end;

  // Metadata[i] describes the page at pa = KERNBASE + i * PGSIZE.
  // Only addresses in [managed_start, managed_end) are valid allocator block
  // addresses; memory outside this range is not managed here.
  // For a FREE or USED entry, order is the size of the block beginning at pa.
  // For a SUBSUMED entry, order is the first block size that pa will
  // represent when its containing block is recursively split.
  // The status records whether the block is free, used, or part of a larger
  // block.

  uint8 buddy_run_metadata[MAXPAGES];

  // Freelist per order, freelist[i] consists of pointers to blocks of size ((1<<i) pages)
  struct buddy_run *freelist[MAXORDER + 1];
} buddymem;

static enum block_status get_status(uint64 pa);
static uint8 get_order(uint64 pa);
static void set_order(uint64 pa, uint8 new_order);
static void set_status(uint64 pa, enum block_status status);
static void set_meta(uint64 pa, uint8 order, enum block_status status);

// Freelist helpers.

static void remove_from_freelist(uint8 order, struct buddy_run *cur_run);
static void push_to_freelist(uint8 order, struct buddy_run *cur_run);
static struct buddy_run *pop_from_freelist(uint8 order);

// Buddy helpers.

// Convert an order into the size in bytes of a block at that order.
static uint64 order_size(uint8 order);

// Given the base address and order of a block, finds the base address of its
// adjacent buddy block of the same order. A different order means a
// different block size and may therefore mean a different buddy.
static uint64 get_buddy_address(uint64 pa, uint8 order);

void
buddyinit(uint64 pa_start, uint64 pa_end)
{
  initlock(&buddymem.lock, "buddymem");
  buddymem.managed_start = SUPERPGROUNDUP(pa_start);
  buddymem.managed_end = SUPERPGROUNDDOWN(pa_end);

  if(buddymem.managed_start >= buddymem.managed_end)
    panic("buddyinit: no usable physical memory");

  uint64 p;
  p = buddymem.managed_start;
  uint64 max_seen = buddymem.managed_start;
  for(; p + PGSIZE <= buddymem.managed_end; p += PGSIZE){
    for(int i = MAXORDER; i >= 0; i--){
      if((uint64)p % order_size(i) == 0 &&
         p + order_size(i) <= buddymem.managed_end){
        // The second check is guaranteed to be true as we have rounded down the end.
        set_order(p, i);
        break;
      }
    }
    if(p >= max_seen){
      max_seen = p + order_size(get_order(p));
      push_to_freelist(get_order(p), (struct buddy_run *)p);
      set_status(p, FREE);
    } else {
      set_status((uint64)p, SUBSUMED);
    }
  }
}

static void
prepare_block_for_free(uint64 pa, uint8 target_order)
{
  if(get_status(pa) == ALLOCATED && get_order(pa) == target_order){
    return;
  }

  if(get_status(pa) ==ALLOCATED &&  get_order(pa) > target_order){
    uint8 cur_order = get_order(pa);
    uint64 cur_pa = pa;
    while(cur_order > target_order){
      cur_order--;
      uint64 left = cur_pa;
      uint64 right = cur_pa + order_size(cur_order);
      set_meta(left, cur_order, ALLOCATED);
      set_meta(right, cur_order, ALLOCATED);
      cur_pa = left;
    }
    return;
  }
  //pa is currently marked SUBSUMED
  uint64 enc_pa = 0;
  uint8 enc_order = 0;
  int found = 0;

  for(int k = target_order + 1; k <= MAXORDER; k++){
    uint64 base = pa & ~(order_size(k) - 1);
    if(base >= buddymem.managed_start && base + order_size(k) <= buddymem.managed_end){
      if(get_status(base) == ALLOCATED && get_order(base) >= k){
        enc_pa = base;
        enc_order = get_order(base);
        found = 1;
        break;
      }
    }
  }

  if(!found){
    panic("BUDDYFREE: NO ENCLOSING ALLOCATED BLOCK FOUND");
  }

  uint64 cur_pa = enc_pa;
  uint8 cur_order = enc_order;
  while(cur_order > target_order){
    cur_order--;
    uint64 left = cur_pa;
    uint64 right = cur_pa + order_size(cur_order);
    set_meta(left, cur_order, ALLOCATED);
    set_meta(right, cur_order, ALLOCATED);
    if(pa < right){
      cur_pa = left;
    } else {
      cur_pa = right;
    }
  }
}

// Free npages starting at pa. The range must be aligned to npages, npages must
// be a supported power of two, and the range must lie within one allocated
// block. Partial frees split the enclosing block before freeing the range.
// The block may then be recursively coalesced with free buddies.
// Panic if any of these requirements is violated.
void
buddyfree(void *pa, int npages)
{
  if(npages <= 0){
    panic("buddyfree: invalid page count");
  }
  
  uint8 order = 0;
  for(; order <= MAXORDER; order++){
    if((1 << order) == npages) break;
  }
  if(order == MAXORDER + 1){
    panic("buddyfree: npages must be a power of 2 and no larger than (1<<MAXORDER)");
  }

  if((uint64)(pa) % (npages * PGSIZE)){
    panic("buddyfree: pa must be npages aligned");
  }
  if((uint64)(pa) < buddymem.managed_start ||
     (uint64)(pa) + npages * PGSIZE > buddymem.managed_end){
    panic("buddyfree: pa out of bounds");
  }
  
  acquire(&buddymem.lock);

  prepare_block_for_free((uint64)pa, order);

  uint64 cur_pa = (uint64)pa;
  uint8 cur_order = order;

  set_meta(cur_pa, cur_order, FREE);

  while(cur_order < MAXORDER){
    uint64 buddy_pa = get_buddy_address(cur_pa, cur_order);
    if(get_status(buddy_pa) != FREE || get_order(buddy_pa) != cur_order){
      break;
    }

    remove_from_freelist(cur_order, (struct buddy_run *)buddy_pa);

    uint64 parent_pa = (cur_pa < buddy_pa) ? cur_pa : buddy_pa;
    uint64 subsumed_pa = (cur_pa < buddy_pa) ? buddy_pa : cur_pa;

    set_meta(subsumed_pa, cur_order, SUBSUMED);

    cur_pa = parent_pa;
    cur_order++;
    set_meta(cur_pa, cur_order, FREE);
  }

  push_to_freelist(cur_order, (struct buddy_run *)cur_pa);

  release(&buddymem.lock);
}

// Allocate a block containing (1 << order) contiguous pages. Search the
// requested freelist first; if it is empty, split a larger free block until
// the requested order is reached. Return the block base, or 0 if unavailable.
void *
buddyalloc(uint8 order)
{
  if(order > MAXORDER){
    panic("buddyalloc: invalid order");
  }
  acquire(&buddymem.lock);

  int cur_order = order;
  while(cur_order <= MAXORDER && buddymem.freelist[cur_order] == 0){
    cur_order++;
  }

  if(cur_order > MAXORDER){
    release(&buddymem.lock);
    return 0;
  }

  struct buddy_run *run = pop_from_freelist(cur_order);
  uint64 pa = (uint64)run;

  while(cur_order > order){
    cur_order--;
    uint64 left = pa;
    uint64 right = pa + order_size(cur_order);

    set_meta(right, cur_order, FREE);
    push_to_freelist(cur_order, (struct buddy_run *)right);

    set_order(left, cur_order);
    pa = left;
  }

  set_meta(pa, order, ALLOCATED);
  release(&buddymem.lock);
  return (void*)pa;
}

#define STATUS_MASK  0x30
#define ORDER_MASK   0x0F

static uint64
order_size(uint8 order)
{
  if(order > MAXORDER)
    panic("order_size: invalid order");
  return (1UL << order) * PGSIZE;
}

static enum block_status
get_status(uint64 pa)
{
  if(pa % PGSIZE)
    panic("get_status: address not page aligned");
  if(pa < buddymem.managed_start || pa >= buddymem.managed_end)
    panic("get_status: address outside managed range");

  uint64 idx = (pa - KERNBASE) / PGSIZE;
  return (enum block_status)(buddymem.buddy_run_metadata[idx] & STATUS_MASK);
}

static uint8
get_order(uint64 pa)
{
  if(pa % PGSIZE)
    panic("get_order: address not page aligned");
  if(pa < buddymem.managed_start || pa >= buddymem.managed_end)
    panic("get_order: address outside managed range");

  uint64 idx = (pa - KERNBASE) / PGSIZE;
  return buddymem.buddy_run_metadata[idx] & ORDER_MASK;
}

static void
set_order(uint64 pa, uint8 new_order)
{
  if(new_order > MAXORDER)
    panic("set_order: invalid order");
  if(pa % PGSIZE)
    panic("set_order: address not page aligned");
  if(pa < buddymem.managed_start || pa + order_size(new_order) > buddymem.managed_end)
    panic("set_order: address outside managed range");


  uint64 idx = (pa - KERNBASE) / PGSIZE;
  buddymem.buddy_run_metadata[idx] =
      (buddymem.buddy_run_metadata[idx] & ~ORDER_MASK) |
      (new_order & ORDER_MASK);
}

static void
set_status(uint64 pa, enum block_status status)
{
  if(pa % PGSIZE)
    panic("set_status: address not page aligned");
  if(pa < buddymem.managed_start || pa >= buddymem.managed_end)
    panic("set_status: address outside managed range");

  uint64 idx = (pa - KERNBASE) / PGSIZE;
  buddymem.buddy_run_metadata[idx] =
      (buddymem.buddy_run_metadata[idx] & ~STATUS_MASK) |
      (status & STATUS_MASK);
}

static void
set_meta(uint64 pa, uint8 order, enum block_status status)
{
  set_order(pa, order);
  set_status(pa, status);
}

static void
remove_from_freelist(uint8 order, struct buddy_run *cur_run)
{
  if(order > MAXORDER)
    panic("remove_from_freelist: invalid order");
  if(cur_run == 0)
    panic("remove_from_freelist: null block");

  if(cur_run == buddymem.freelist[order]){
    struct buddy_run *next_run = cur_run->next;
    buddymem.freelist[order] = next_run;
    if(next_run)
      next_run->prev = 0;
  } else {
    struct buddy_run *prev_run = cur_run->prev;
    struct buddy_run *next_run = cur_run->next;

    if(prev_run)
      prev_run->next = next_run;
    if(next_run)
      next_run->prev = prev_run;
  }

  cur_run->prev = 0;
  cur_run->next = 0;
}

static void
push_to_freelist(uint8 order, struct buddy_run *cur_run)
{
  if(order > MAXORDER)
    panic("push_to_freelist: invalid order");
  if(cur_run == 0)
    panic("push_to_freelist: null block");

  cur_run->prev = 0;
  cur_run->next = buddymem.freelist[order];

  if(buddymem.freelist[order])
    buddymem.freelist[order]->prev = cur_run;

  buddymem.freelist[order] = cur_run;
}

static struct buddy_run *
pop_from_freelist(uint8 order)
{
  if(order > MAXORDER)
    panic("pop_from_freelist: invalid order");
  struct buddy_run *head_run = buddymem.freelist[order];
  if(head_run == 0)
    return 0;

  remove_from_freelist(order, head_run);
  return head_run;
}

static uint64
get_buddy_address(uint64 pa, uint8 order)
{
  if(pa < buddymem.managed_start ||
     pa + order_size(order) > buddymem.managed_end){
    panic("get_buddy_address: pa out of bounds");
  }

  uint64 buddy_address = pa ^ order_size(order);
  
  if(buddy_address < buddymem.managed_start ||
     buddy_address + order_size(order) > buddymem.managed_end){
    panic("get_buddy_address: buddy_address out of bounds");
  }
  return buddy_address;
}

#endif