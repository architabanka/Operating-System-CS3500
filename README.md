# xv6 OS Labs

A collection of kernel-level programming labs done as part of **CS3500 (Operating System Engineering)**, based on the [MIT 6.1810](https://pdos.csail.mit.edu/6.1810/2025/overview.html) curriculum.

---

## Labs

| # | Folder | Topic | Key Concepts |
|---|--------|--------|--------------|
| 1 | [`lab-util`](./lab-util/) | **Unix Utilities** | `fork`, `exec`, pipes, file descriptors |
| 2 | [`lab-syscall`](./lab-syscall/) | **System Calls** | Kernel/user boundary, trap frame, new syscalls |
| 3 | [`lab-traps`](./lab-traps/) | **Traps & Interrupts** | RISC-V traps, signal-like alarm mechanism |
| 4 | [`lab-pgtbl`](./lab-pgtbl/) | **Page Tables** | Virtual memory, RISC-V MMU, kernel/user page tables |
| 5 | [`lab-cow-mmap`](./lab-cow-mmap/) | **COW Fork + mmap** | Copy-on-write, lazy allocation, page fault handling, `mmap` |
| 6 | [`lab-locks`](./lab-locks/) | **Concurrency & Locks** | Spinlocks, sleeplocks, lock granularity, memory allocator |
| 7 | [`lab-fs`](./lab-fs/) | **File System** | Inode layer, indirect blocks, symbolic links, large files |

---

## Lab Summaries

### Lab 1 — Unix Utilities (`lab-util`)
Implemented several POSIX-style user-space utilities from scratch inside the xv6 shell:
- `sleep` - pause for a given number of ticks
- `pingpong` — bidirectional pipe communication between parent and child
- `primes` — concurrent prime sieve using a pipeline of processes
- `find` — recursive directory search
- `xargs` — batch command execution from stdin

### Lab 2 — System Calls (`lab-syscall`)
Extended the xv6 kernel with new system calls, learning how the trap/syscall dispatch mechanism works at the kernel level:
- Added a `trace` system call to log which syscalls a process invokes
- Implemented `sysinfo` to report free memory and live process count

### Lab 3 — Traps (`lab-traps`)
Explored RISC-V traps, the trampoline page, and user-level interrupt handling:
- Implemented a `sigalarm`/`sigreturn` mechanism to periodically invoke a user-defined handler after a fixed number of CPU ticks
- Traced how the kernel saves/restores the trap frame across a user-space handler

### Lab 4 — Page Tables (`lab-pgtbl`)
Worked directly with xv6's three-level RISC-V page table structure:
- Sped up `getpid()` by mapping a shared user-kernel page (avoiding a full trap)
- Implemented `vmprint` to dump the full page table hierarchy for debugging
- Extended the kernel to give each process its own kernel-mode page table

### Lab 5 — Copy-on-Write Fork + mmap (`lab-cow-mmap`)
Two large virtual memory projects combined:
- **COW Fork**: Modified `fork()` to share physical pages read-only and copy lazily on write, using reference counting
- **mmap**: Implemented `mmap`/`munmap` to memory-map files into user address space with lazy page-fault-driven loading

### Lab 6 — Concurrency & Locks (`lab-locks`)
Improved kernel concurrency to reduce lock contention under multi-core workloads:
- Replaced the global `kmem` free-list with per-CPU free lists to eliminate `kalloc` contention
- Switched the buffer cache from a single global lock to a hash-table of fine-grained locks
- Implemented a buddy allocator (superpage support)

### Lab 7 — File System (`lab-fs`)
Extended the xv6 on-disk file system:
- Increased the maximum file size by adding doubly-indirect block pointers
- Implemented symbolic links (`symlink`, `O_NOFOLLOW`) with cycle detection

---

## Running a Lab

Each lab folder is a self-contained xv6 build. Requirements: `qemu-system-riscv64`, RISC-V GNU toolchain (`riscv64-unknown-elf-gcc`).

```bash
cd lab-util        # or any other lab folder
make qemu          # boots xv6 in QEMU
```

To run the autograder:
```bash
make grade
```


