// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "buddyalloc.h"
#include "defs.h"

void freerange(void *pa_start, void *pa_end);

extern char end[]; // first address after kernel.
                   // defined by kernel.ld.

#ifdef BUDDY_OFF
struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  struct run *freelist;
} kmem;

struct {
  struct spinlock lock;
  int allocated[NSUPERPG];
} supermem;

void
superinit(void)
{
  initlock(&supermem.lock, "supermem");
  for(int i = 0; i < NSUPERPG; i++){
    supermem.allocated[i] = 0;
  }
}
#endif

void
kinit()
{
#ifdef BUDDY_OFF
  superinit();
  initlock(&kmem.lock, "kmem");
  freerange(end, (void*)SUPER_BASE);
#endif
#ifndef BUDDY_OFF
  buddyinit((uint64)end, PHYSTOP);
#endif
}

#ifdef BUDDY_OFF
//assumption - this is called only in kinit()
void
freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE){
    kfree(p);
}
}
#endif

// Free the page of physical memory pointed at by pa,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
#ifdef BUDDY_OFF
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);

  r = (struct run*)pa;

  acquire(&kmem.lock);
  r->next = kmem.freelist;
  kmem.freelist = r;
  release(&kmem.lock);
#endif

#ifndef BUDDY_OFF
  buddyfree(pa, 1);
#endif
}

void 
superfree(void* pa){
#ifdef BUDDY_OFF
  // YOUR CODE HERE - needed for the superpage lab
  uint64 addr = (uint64)pa;
  if(addr < SUPER_BASE || addr >= PHYSTOP || (addr % SUPERPGSIZE) != 0)
    panic("superfree: invalid pa");

  int i = (addr - SUPER_BASE) / SUPERPGSIZE;
  acquire(&supermem.lock);
  if(!supermem.allocated[i])
    panic("superfree: double free");
  supermem.allocated[i] = 0;
  release(&supermem.lock);
#endif

#ifndef BUDDY_OFF
  if(((uint64)pa % SUPERPGSIZE) != 0)
    panic("superfree: not superpage aligned");
  buddyfree(pa, SUPERPGSIZE / PGSIZE);
#endif
}

#ifndef BUDDY_OFF
// Frees buddy allocated npages contiguous pages with start at pa
// npages should be a power of 2
void
kfree_contig(void* pa,int npages){
  buddyfree(pa, npages);
}
#endif

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
#ifdef BUDDY_OFF
  struct run *r;

  acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  release(&kmem.lock);

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
  return (void*)r;
#endif

#ifndef BUDDY_OFF
  void *pa = buddyalloc(0);
  if(pa)
    memset(pa, 5, PGSIZE); // fill with junk
  return pa;
#endif
}

void*
superalloc(void)
{
#ifdef BUDDY_OFF
  // YOUR CODE HERE - needed for the superpage lab
  acquire(&supermem.lock);
  for(int i = 0; i < NSUPERPG; i++){
    if(!supermem.allocated[i]){
      supermem.allocated[i] = 1;
      release(&supermem.lock);
      uint64 pa = SUPER_BASE + ((uint64)i * SUPERPGSIZE);
      memset((void*)pa, 0, SUPERPGSIZE);
      return (void*)pa;
    }
  }
  release(&supermem.lock);
  return 0;
#endif

#ifndef BUDDY_OFF
  uint8 order = 0;
  while(((uint64)1 << order) * PGSIZE < SUPERPGSIZE)
    order++;

  void *pa = buddyalloc(order);
  if(pa)
    memset(pa, 0, SUPERPGSIZE);
  return pa;
#endif
}

#ifndef BUDDY_OFF
// Allocate npages contiguous pages. npages must be a power of two
// no larger than the maximum buddy block.
void* 
kalloc_contig(int npages)
{
  if(npages <= 0 || (npages & (npages - 1)) != 0 ||
     npages > SUPERPGSIZE / PGSIZE)
    panic("kalloc_contig: invalid page count");

  uint8 order = 0;
  while((1 << order) < npages)
    order++;

  char* mem = buddyalloc(order);
  if(mem)
    memset(mem, 5, npages * PGSIZE); // fill with junk
  return mem;
}
#endif
