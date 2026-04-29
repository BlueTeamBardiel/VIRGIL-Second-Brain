# kernel information disclosure

## What it is
Imagine a bank vault that accidentally leaves its blueprints taped to the outside wall — attackers don't steal the gold yet, but now they know exactly where the guards stand. Kernel information disclosure is a vulnerability where the operating system kernel unintentionally leaks privileged memory addresses, internal structures, or other sensitive data to unprivileged userspace processes. This leak itself causes no immediate damage but is frequently the *prerequisite* that makes a separate exploit reliable.

## Why it matters
Modern exploit mitigations like KASLR (Kernel Address Space Layout Randomization) randomize where kernel code lives in memory, making blind exploitation nearly impossible. However, a single information disclosure bug — such as CVE-2017-5123 (waitid syscall) leaking kernel stack memory — hands an attacker the kernel base address, completely neutering KASLR and enabling a follow-on privilege escalation to root. This is why disclosure bugs are treated as critical stepping stones even when they appear "low severity" in isolation.

## Key facts
- **KASLR bypass** is the most common exploit chain use case — disclosure leaks the randomized base address, turning a "hard" exploit into a trivial offset calculation.
- **Spectre and Meltdown** (2018) are hardware-level kernel information disclosures that leak kernel memory contents to unprivileged processes via CPU speculative execution side channels.
- **proc filesystem** entries (e.g., `/proc/kallsyms`) historically exposed kernel symbol addresses; modern Linux restricts this with `kptr_restrict` sysctl.
- **Stack/heap memory leaks** in syscall return paths are a common source — uninitialized padding bytes in kernel structs written to userspace contain residual sensitive data.
- Mitigations include **SMEP, SMAP, kASLR, kernel pointer sanitization**, and restricting `/proc` and `/sys` permissions to root-only.

## Related concepts
[[KASLR bypass]] [[privilege escalation]] [[Spectre and Meltdown]] [[memory corruption]]