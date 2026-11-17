Ran command: `git status`
Ran command: `git log -n 10 --oneline`
Ran command: `git branch -a`
Ran command: `git show 9dbd536 --stat`
Ran command: `git diff 9dbd536..HEAD --stat`
Viewed references.txt:1-35
Viewed grade-lab-cowmmap:1-100
Ran command: `find . -maxdepth 3 -name "*.pdf" -o -name "*.md" -o -name "*lab*"`
Ran command: `git log 9dbd536..HEAD --oneline`
Ran command: `git show --stat 5648f64`
Ran command: `git show --stat 75675cd`
Ran command: `git show --stat c7c3a2e`
Ran command: `git show --stat f1f5a47`
Ran command: `git show --stat 1e9d372`
Ran command: `git diff f1f5a47..1e9d372`
Ran command: `git diff f1f5a47..1e9d372 kernel/`
Ran command: `git diff f1f5a47..1e9d372 kernel/kalloc.c kernel/proc.c kernel/proc.h kernel/defs.h kernel/riscv.h`
Viewed riscv.h:355-370
Viewed kalloc.c:20-132
Viewed proc.h:80-120
Ran command: `git diff 9dbd536..HEAD kernel/trap.c`
Viewed trap.c:55-85

Here is the complete breakdown of which files were edited and what code was added for each section of the **Copy-on-Write (COW) & Mmap Lab**.

---

### **Section 1: Copy-on-Write (COW) Fork**

The goal of this section is to eliminate deep-copying memory during `fork()`. Instead, parent and child share physical pages as read-only marked with a `PTE_COW` bit, copying only when either process attempts a write.

#### 1. [kernel/riscv.h](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/riscv.h#L363)
* **Lines 363:**
  ```c
  #define PTE_COW (1L << 8) // copy-on-write page
  ```
  * Added the software-defined `PTE_COW` flag (using bit 8, reserved for software use in RISC-V PTEs) to identify COW-shared pages.

#### 2. [kernel/defs.h](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/defs.h#L69-L71)
* **Lines 69–71:**
  ```c
  void kref_inc(void *);
  void kref_dec(void *);
  int  kref_get(void *);
  ```
  * Declared reference counting functions for tracking physical page sharing across processes.

#### 3. [kernel/kalloc.c](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/kalloc.c#L26-L126)
* **Lines 26–56:**
  * Defined spinlock-protected reference counting table `kref` with index macro `PA2IDX(pa)`:
    ```c
    struct {
      struct spinlock lock;
      int count[(PHYSTOP - KERNBASE) / PGSIZE];
    } kref;
    ```
  * Added helper implementations:
    * [`kref_inc(void *pa)`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/kalloc.c#L34-L39): Increments reference count.
    * [`kref_dec(void *pa)`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/kalloc.c#L41-L47): Decrements reference count.
    * [`kref_get(void *pa)`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/kalloc.c#L49-L56): Reads current reference count.
* **Lines 62–67 in [`kinit()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/kalloc.c#L59-L69):**
  * Initialized `kref.lock` and set initial reference counts to 1 so initial `freerange()` calls can safely decrement and free memory.
* **Lines 92–97 in [`kfree()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/kalloc.c#L85-L108):**
  * Decrements `kref.count[PA2IDX(pa)]`. If count > 0, returns immediately without adding the page back to the free list.
* **Lines 122–125 in [`kalloc()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/kalloc.c#L114-L131):**
  * Sets `kref.count[PA2IDX(r)] = 1` for newly allocated pages.

#### 4. [kernel/vm.c](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/vm.c#L314-L490)
* **Lines 314–322 in [`uvmcopy()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/vm.c#L299-L327):**
  * Replaced physical memory allocation (`kalloc`) and byte-copying (`memmove`).
  * If the page was writable (`PTE_W`), clears `PTE_W` and sets `PTE_COW`.
  * Maps the child page table to the **same** physical address `pa` and increments its reference count via [`kref_inc((void*)pa)`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/defs.h#L69).
* **Lines 358–369 in [`copyout()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/vm.c#L349-L382):**
  * Intercepts kernel writes into user space (e.g., `read()` syscall). If destination page is marked `PTE_COW`, proactively calls [`vmfault()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/vm.c#L460-L537) to duplicate the page before writing.
* **Lines 471–490 in [`vmfault()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/vm.c#L460-L537):**
  * Handles COW write faults (`pte && (*pte & PTE_V) && (*pte & PTE_COW)`):
    * If `kref_get(pa) == 1`: Re-enables write permission directly (`*pte |= PTE_W; *pte &= ~PTE_COW;`).
    * If `kref_get(pa) > 1`: Allocates a new physical page with `kalloc()`, copies contents with `memmove()`, updates PTE to point to new page with `PTE_W`, and decrements old page's refcount with `kfree((void*)pa)`.

---

### **Section 2: Memory-Mapped Files (`mmap` & `munmap`)**

The goal of this section is to implement memory-mapped files: lazily mapping file regions into user virtual memory and writing dirty pages back on unmap or exit.

#### 1. [kernel/proc.h](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/proc.h#L84-L119)
* **Lines 84–94:**
  * Defined [`struct vma`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/proc.h#L86-L94) tracking virtual address range, file pointer, protection (`prot`), and mapping flags (`flags`):
    ```c
    #define NVMA 16
    struct vma {
      int used;
      uint64 addr;
      uint64 len;
      int prot;
      int flags;
      uint64 offset;
      struct file *file;
    };
    ```
* **Line 119 in [`struct proc`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/proc.h#L97-L120):**
  * Added `struct vma vma[NVMA];` array to keep track of per-process VMAs.

#### 2. [kernel/proc.c](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/proc.c#L153-L399)
* **Lines 8–11:** Included `fs.h`, `sleeplock.h`, `fcntl.h`, `file.h`.
* **Lines 153–155 in [`allocproc()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/proc.c#L123-L158):** Initialized `p->vma[i].used = 0` for new processes.
* **Lines 180–185 in [`freeproc()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/proc.c#L160-L188):** Closes file descriptors and resets VMAs when process is destroyed.
* **Lines 371–399 in [`kexit()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/proc.c#L361-L417):**
  * Loops through all VMAs on process exit.
  * For writable `MAP_SHARED` VMAs, writes back dirty resident pages to the underlying inode using `begin_op()`, `ilock()`, [`writei()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/defs.h#L162), and unmaps pages using `uvmunmap()`.

#### 3. [kernel/sysfile.c](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/sysfile.c#L507-L634)
* **Lines 507–519 (`find_free_vm_region`):**
  * Scans active VMAs to find a free virtual address region starting from `0x40000000`.
* **Lines 521–566 ([`sys_mmap()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/sysfile.c#L521-L566)):**
  * Validates arguments (`len > 0`, verifies file is open for writing if `MAP_SHARED` + `PROT_WRITE`).
  * Finds an unused slot in `p->vma[]`.
  * Assigns address via `find_free_vm_region`, stores metadata, and increments file reference count with `filedup(f)`.
* **Lines 568–634 ([`sys_munmap()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/sysfile.c#L568-L634)):**
  * Finds matching VMA covering `[addr, addr + len)`.
  * For each page in the range: if present and `MAP_SHARED` + writable, flushes modified bytes back to disk with [`writei()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/defs.h#L162); then unmaps and frees the page using `uvmunmap(p->pagetable, va, 1, 1)`.
  * Shrinks or deallocates the VMA (handles complete unmap, prefix unmap, or suffix unmap).

#### 4. [kernel/vm.c](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/vm.c#L493-L520)
* **Lines 493–520 in [`vmfault()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/vm.c#L460-L537):**
  * Checks if faulting address falls within an active VMA.
  * Validates read/write access against `v->prot`.
  * Allocates a physical page (`kalloc()`), reads page content from file using [`readi()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/defs.h#L163), and maps it into the user page table with appropriate permissions (`PTE_U | PTE_R | (v->prot & PROT_WRITE ? PTE_W : 0)`).

---

### **Section 3: Integration (COW + Mmap Across `fork`)**

This section makes sure `fork()` correctly handles both `MAP_SHARED` and `MAP_PRIVATE` mappings.

#### 1. [kernel/proc.c](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/proc.c#L292-L315)
* **Lines 292–315 in [`kfork()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/proc.c#L273-L344):**
  * Copies each active VMA from parent `p` to child `np` and increments file reference count via `filedup(p->vma[i].file)`.
  * For resident pages already faulted in:
    * **`MAP_SHARED`**: Maps the page table entry directly in the child with same permissions and increments physical page refcount (`kref_inc`).
    * **`MAP_PRIVATE`**: Marks resident pages as **COW** in both parent and child (clears `PTE_W`, sets `PTE_COW`), maps to child, and increments refcount (`kref_inc`). When either parent or child writes to it later, [`vmfault()`](file:///Users/architabanka/CS3500-COW-Mmap-Lab/kernel/vm.c#L460-L537) creates a private copy.