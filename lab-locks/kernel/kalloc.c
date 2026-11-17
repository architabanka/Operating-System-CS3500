// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"

void freerange(void *pa_start, void *pa_end);

extern char end[]; // first address after kernel.
                   // defined by kernel.ld.

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  struct run *freelist;
  char name[8]; //holds dynamically generated lock names like kmem0
} kmem[NCPU];

void
kinit()
{
  for(int i=0;i<NCPU;i++){
    snprintf(kmem[i].name,8,"kmem%d", i);
    initlock(&kmem[i].lock, kmem[i].name);
  }
  freerange(end, (void*)PHYSTOP);
}

void
freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    kfree(p);
}

// Free the page of physical memory pointed at by pa,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
  r = (struct run*)pa;
  //calling push_off and pop_off to disable interrupts when getting cpuid
  push_off();
  int cpu=cpuid();
  
  acquire(&kmem[cpu].lock);
  //adding the new freed page to the freelist
  r->next=kmem[cpu].freelist;
  kmem[cpu].freelist=r;
  release(&kmem[cpu].lock);
  pop_off();

}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void 
*kalloc(void)
{
  struct run *r;

  push_off();
  int cpu = cpuid();

  //try to allocate from the current cpu's free list
  acquire(&kmem[cpu].lock);
  r=kmem[cpu].freelist;
  if(r)
    kmem[cpu].freelist=r->next;
  release(&kmem[cpu].lock);

  //if no page in current cpu's free list steal from another cpu
  if(!r){
    for(int i=0;i<NCPU;i++){
      if(i==cpu) continue; 
      
      acquire(&kmem[i].lock);
      r=kmem[i].freelist;
      if(r) {
        kmem[i].freelist = r->next;
        release(&kmem[i].lock);
        break; 
      }
      release(&kmem[i].lock);
    }
  }
  
  pop_off();
  if(r)
    memset((char*)r, 5, PGSIZE);
  return (void*)r;
}