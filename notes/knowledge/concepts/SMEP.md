# SMEP

## What it is
Like a museum rule that says "staff can walk the galleries but cannot touch the exhibits," SMEP (Supervisor Mode Execution Prevention) is a CPU hardware feature that prevents the kernel (running in ring 0) from executing code located in user-space memory pages. Introduced by Intel around 2011 and controlled by a single bit in the CR4 register, it stops a common privilege escalation trick dead in its tracks.

## Why it matters
Before SMEP, a classic kernel exploit technique was to write shellcode into user-space memory, then trick the kernel into jumping to that address during an exploit — a technique called "ret2usr." SMEP forces attackers to find and use code already residing in kernel space (like ROP gadgets), dramatically raising the complexity and cost of a successful privilege escalation. Modern Linux and Windows kernels enable SMEP by default when the hardware supports it.

## Key facts
- SMEP is enforced at the **hardware level** via bit 20 of the CR4 register; software cannot bypass it without first clearing that bit
- It only blocks **execution** of user-space pages from ring 0 — it does **not** block the kernel from **reading or writing** user-space memory (that's SMAP's job)
- Attackers can bypass SMEP by finding a way to clear CR4 bit 20, often via a kernel ROP chain targeting `native_write_cr4()`
- SMEP pairs with **SMAP** (Supervisor Mode Access Prevention), which blocks kernel reads/writes to user pages, forming a complementary defense duo
- Enabled by default in **Windows 8+** and **Linux kernel 3.0+** on supported Intel/AMD hardware

## Related concepts
[[SMAP]] [[Kernel Privilege Escalation]] [[Return-Oriented Programming]] [[Ring Protection Model]] [[Address Space Layout Randomization]]