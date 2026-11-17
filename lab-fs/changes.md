Ran check git status
Ran check recent commits

Error: API error (attempt 1): request failed: Post "https://daily-cloudcode-pa.googleapis.com/v1internal:streamGenerateContent?alt=sse": write tcp 10.44.243.157:55946->172.217.115.4:443: write: broken pipe (Error ID: 66533813-7ab3-41b9-b1f2-474f1c8eccdc-5)

Error: API error (attempt 2): request failed: Post "https://daily-cloudcode-pa.googleapis.com/v1internal:streamGenerateContent?alt=sse": write tcp 10.44.243.157:55943->172.217.115.4:443: write: broken pipe (Error ID: 66533813-7ab3-41b9-b1f2-474f1c8eccdc-6)

Error: API error (attempt 3): request failed: Post "https://daily-cloudcode-pa.googleapis.com/v1internal:streamGenerateContent?alt=sse": dial tcp: lookup daily-cloudcode-pa.googleapis.com: no such host (Error ID: 66533813-7ab3-41b9-b1f2-474f1c8eccdc-7)

Ran check diff statistics
Ran inspect diff in kernel directory
Ran check diffs in user and syscall files
Ran check diffs for documentation files
Analyzed grade-results.json:L1-100

Here is a comprehensive summary of all changes made across the codebase, organized by file and the purpose behind each modification.

---

### 1. Large File Support (Doubly-Indirect Blocks)

#### [kernel/fs.h](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/kernel/fs.h)
* **Changes:**
  * Changed `NDIRECT` from `12` to `11`.
  * Updated `MAXFILE` to `(NDIRECT + NINDIRECT + NINDIRECT * NINDIRECT)`.
  * Changed `addrs[NDIRECT + 1]` in `struct dinode` to `addrs[NDIRECT + 2]`.
* **Why:**
  * Repurposed one direct block slot to serve as a **doubly-indirect block** pointer.
  * Preserved the total array length (`11 + 1 + 1 = 13` slots) so that the on-disk `dinode` size and layout stay constant while raising maximum file capacity from 268 blocks to **65,803 blocks** (11 direct + 256 singly-indirect + $256 \times 256$ doubly-indirect).

#### [kernel/file.h](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/kernel/file.h)
* **Changes:**
  * Updated in-memory `struct inode` address array to `uint addrs[NDIRECT + 2]`.
* **Why:**
  * Keeps the in-memory representation of an inode consistent with the on-disk `struct dinode`.

#### [kernel/fs.c](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/kernel/fs.c)
* **Changes:**
  * **In `bmap()`**: Extended block mapping to handle block numbers in the doubly-indirect range (`bn >= NINDIRECT && bn < NINDIRECT * NINDIRECT`). Computes `outer = bn / NINDIRECT` and `inner = bn % NINDIRECT`, allocating/fetching the doubly-indirect root block (`addrs[NDIRECT + 1]`), the outer singly-indirect block (`a[outer]`), and finally the data block (`a[inner]`). Properly checks for allocation failures and calls `log_write()` and `brelse()`.
  * **In `itrunc()`**: Added deallocation traversal for the doubly-indirect tree (`addrs[NDIRECT + 1]`). Iterates over all child singly-indirect blocks, frees each allocated data block, frees the singly-indirect blocks, and finally frees the doubly-indirect root block.
* **Why:**
  * Enables reading, writing, extending, and truncating files larger than 268 blocks without leaking blocks on truncation.

---

### 2. Inode Block Tree Inspection

#### [kernel/fs.c](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/kernel/fs.c)
* **Changes:**
  * Implemented `itreeprint(struct inode *ip)`.
  * Prints `inode <inum> type <type> size <size>`.
  * Prints direct blocks (`..0: <blk>`, etc.), singly-indirect blocks (`..indirect: <blk>` and its children `.. ..<idx>: <blk>`), and doubly-indirect blocks (`..double-indirect: <blk>`, outer pointers `.. ..<idx>: <blk>`, and inner leaf blocks `.. .. ..<idx>: <blk>`).
* **Why:**
  * Satisfies Section 3 requirement (`print_itree` utility / `iprint` syscall) to inspect and verify on-disk inode block structures without modifying or allocating disk blocks.

---

### 3. Symbolic Links Implementation

#### [kernel/stat.h](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/kernel/stat.h)
* **Changes:**
  * Added `#define T_SYMLINK 4`.
* **Why:**
  * Defines a distinct inode file type representing symbolic links.

#### [kernel/fcntl.h](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/kernel/fcntl.h)
* **Changes:**
  * Added `#define O_NOFOLLOW 0x800`.
* **Why:**
  * Adds an open flag allowing processes to open the symlink inode itself (to inspect or read its target) rather than following the link.

#### [kernel/syscall.h](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/kernel/syscall.h) & [kernel/syscall.c](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/kernel/syscall.c)
* **Changes:**
  * Added `#define SYS_symlink 25` to `kernel/syscall.h`.
  * Registered `extern uint64 sys_symlink(void);` and `[SYS_symlink] sys_symlink` in the system call dispatch table.
* **Why:**
  * Dispatches the `symlink` system call from user-space to kernel-space.

#### [user/user.h](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/user/user.h) & [user/usys.pl](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/user/usys.pl)
* **Changes:**
  * Added `int symlink(const char *target, const char *path);` declaration and entry stub.
* **Why:**
  * Exposes the `symlink()` C library function and generates the assembly stub for user programs.

#### [kernel/sysfile.c](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/kernel/sysfile.c)
* **Changes:**
  * **Implemented `sys_symlink()`**:
    * Extracts `target` and `path` arguments and verifies neither is empty and both fit within `MAXPATH`.
    * Allocates an inode of type `T_SYMLINK`.
    * Writes the null-terminated `target` string into the inode data via `writei()`.
    * Links the inode into the parent directory via `dirlink()` **only after** `writei()` succeeds.
    * In case of allocation or write failure, frees resources cleanly (`nlink = 0`, `iupdate`) before returning `-1`, preventing orphan directory entries or dangling inodes.
  * **Modified `sys_open()`**:
    * If `!(omode & O_NOFOLLOW)`, checks if `ip->type == T_SYMLINK`.
    * Loops through symlink chains with a maximum depth limit of 10 to prevent infinite recursion/loops.
    * Validates stored link target format (size within $[2, \text{MAXPATH}]$, reads exact size, ensures trailing null byte).
    * Computes relative paths with respect to the **containing directory of the symlink**, rather than process `cwd`.
    * Releases the current symlink's lock (`iunlockput(ip)`) before calling `namei()` on the next target to avoid deadlocks.
    * Ensures `O_TRUNC` is applied only to regular files (`T_FILE`) once resolved.
* **Why:**
  * Provides correct, safe symbolic link creation and path resolution adhering to POSIX symlink semantics and lab specifications.

---

### 4. Lab Documentation & Metadata

* **[answers-fs.txt](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/answers-fs.txt)**:
  * Contains answers for Section 2 (superblock fields, inode counts, offset calculations), Section 4 (pointer overhead calculations for 1 KB vs 4 KB blocks), and Section 5 (deadlock prevention and relative path resolution explanations).
* **[reference.txt](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/reference.txt)**:
  * Details reading references and AI prompt logs/guidance used during debugging.
* **[time.txt](file:///Users/architabanka/Desktop/Sem%20V/CS3500/OS%20lab/CS3500-File-System-Lab/time.txt)**:
  * Records the total hours spent on the lab (`7`).