# Memory Protection

## What it is
Think of RAM like a apartment building where each tenant (process) has their own locked unit — memory protection is the building management system that physically prevents tenant A from wandering into tenant B's apartment. Precisely, memory protection is a set of hardware and OS-enforced mechanisms that restrict how processes can read, write, or execute memory regions, preventing unauthorized access between processes or between user-space and kernel-space.

## Why it matters
Buffer overflow attacks like the classic Morris Worm (1988) and modern heap spraying attacks succeed specifically by *defeating* memory protection — writing past a buffer's boundary to overwrite adjacent memory and hijack execution flow. Mitigations like Data Execution Prevention (DEP) and Address Space Layout Randomization (ASLR) were built precisely to restore those boundaries: DEP marks data segments as non-executable, while ASLR randomizes where code lives so attackers can't predict jump targets.

## Key facts
- **DEP/NX bit**: Hardware feature marking memory pages as either executable (code) or writable (data), but not both — directly counters shellcode injection
- **ASLR**: Randomizes base addresses of stack, heap, and libraries on each execution; defeated by information leaks that reveal actual addresses
- **Stack Canaries**: Sentinel values placed before return addresses; a changed canary signals a buffer overflow before execution is redirected
- **Segmentation vs. Paging**: Modern systems use paging with page tables to enforce per-page permissions (Read/Write/Execute flags) at the CPU level
- **SMEP/SMAP**: Intel CPU features preventing the kernel from executing or accessing user-space memory pages, closing a common privilege escalation path

## Related concepts
[[Buffer Overflow]] [[Address Space Layout Randomization]] [[Data Execution Prevention]] [[Privilege Escalation]]