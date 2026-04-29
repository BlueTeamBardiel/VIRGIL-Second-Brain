# null pointer dereference

## What it is
Imagine a library index card pointing to shelf 7B, but shelf 7B doesn't exist — and instead of stopping, the librarian walks into a wall. A null pointer dereference occurs when a program follows a pointer containing the value NULL (0x00000000) as if it were a valid memory address, causing the process to crash or execute unintended behavior. In C/C++, this happens when a developer forgets to check if malloc() or a function return value succeeded before using the result.

## Why it matters
In the Linux kernel (CVE-2009-1897), attackers mapped page zero in user space, placed shellcode at address 0x0, then triggered a kernel null pointer dereference — causing the kernel to execute attacker-controlled code with ring-0 privileges. This technique, called "NULL pointer exploitation," turned a crash bug into a full privilege escalation. Modern OS mitigations like mmap_min_addr prevent user processes from mapping the zero page specifically to block this attack class.

## Key facts
- A null dereference is classified as **CWE-476** and can manifest as a denial of service (crash) or, in kernel/privileged contexts, code execution
- The **CVSS score** can reach Critical (9.x) when null dereferences occur in kernel or privileged drivers, not just Medium for userland crashes
- Mitigations include **compiler flags** (e.g., `-fno-delete-null-pointer-checks`), static analysis tools (Coverity, CodeQL), and runtime OS controls like `vm.mmap_min_addr`
- Unlike buffer overflows, null dereferences are often **exploitable only in low-level code** (C, C++, assembly); managed languages like Java throw `NullPointerException` instead of allowing memory corruption
- Secure coding practice: always validate pointer/return values before dereferencing — this is explicitly tested in **CERT C Coding Standard rule EXP34-C**

## Related concepts
[[buffer overflow]] [[use-after-free]] [[privilege escalation]] [[memory-safe languages]] [[input validation]]