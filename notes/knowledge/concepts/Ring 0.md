# Ring 0

## What it is
Think of a nuclear power plant's control room: only authorized engineers with the highest clearance can touch the reactor controls directly. Ring 0 is the CPU's "control room" — **kernel mode** — where code executes with unrestricted access to hardware, memory, and all system resources. It sits at the innermost layer of the x86 protection ring architecture, with Rings 1–3 progressively limiting privileges outward to user applications.

## Why it matters
Rootkits like **TDL4 (TDSS)** deliberately target Ring 0 by exploiting kernel vulnerabilities to install malicious drivers. Once code runs in Ring 0, it can intercept system calls, hide processes and files from security tools, and disable antivirus — all invisibly from the perspective of user-space defenses. This is why kernel integrity features like **Windows Kernel Patch Protection (PatchGuard)** exist specifically to prevent unauthorized Ring 0 modifications.

## Key facts
- **Ring 0 = Kernel Mode**: Operating system kernel, device drivers, and hardware abstraction layers execute here
- **No restrictions**: Code in Ring 0 can execute any CPU instruction, including privileged instructions like `HLT` (halt) and direct I/O port access
- **Rings 1 & 2 are mostly unused** in modern OS design — the practical split is Ring 0 (kernel) vs. Ring 3 (user)
- **Ring 3 → Ring 0 transitions** happen via system calls (`syscall`/`sysenter`), strictly controlled by the kernel to prevent privilege escalation
- **Hypervisors operate at Ring -1** (VMX root mode), below Ring 0, allowing them to control guest OS kernels — this is the basis of Virtual Machine Based Security (VBS)

## Related concepts
[[Privilege Escalation]] [[Rootkits]] [[Kernel Exploitation]] [[Hypervisor Security]] [[Secure Boot]]