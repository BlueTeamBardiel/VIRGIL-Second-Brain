# null pointer

## What it is
Like a library card that points to no book — it exists, but following it leads you to an empty shelf that crashes the entire library system. A null pointer is a reference variable set to zero (or NULL/nil) that points to no valid memory location; when a program attempts to dereference it (read/write through it), the operation accesses address 0x0, causing undefined behavior or an immediate crash.

## Why it matters
Attackers exploit null pointer dereferences to trigger denial-of-service conditions or, in kernel-level code, escalate privileges. On Linux systems before kernel 2.6.23, an attacker could `mmap()` memory at address 0, place malicious shellcode there, then trigger a kernel null pointer dereference — causing the kernel to execute attacker-controlled code with ring-0 privileges. This class of vulnerability has appeared in CVEs affecting the Windows kernel, Linux drivers, and embedded firmware.

## Key facts
- A null pointer dereference is classified under **CWE-476** and can result in crashes (DoS) or privilege escalation depending on context
- In kernel space, null pointer bugs are especially dangerous because kernel memory at address 0 may be mappable by unprivileged users on older systems (`mmap_min_addr` mitigation prevents this on modern Linux)
- Unlike buffer overflows, null pointer dereferences typically **crash** the process rather than redirect execution — unless combined with memory-mapping primitives
- Mitigations include **null pointer checks before dereference**, compiler flags (`-fsanitize=address`), and OS-level protections like SMEP/SMAP
- Static analysis tools (Coverity, CodeQL) and fuzzing commonly detect null dereference bugs before deployment

## Related concepts
[[memory corruption]] [[privilege escalation]] [[denial of service]] [[use-after-free]] [[buffer overflow]]