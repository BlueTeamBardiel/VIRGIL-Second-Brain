# SMAP

## What it is
Like a rule that says "even if you have the master key to the building, you cannot enter the employee break room" — Supervisor Mode Access Prevention (SMAP) is a CPU hardware feature that prevents the kernel (supervisor mode) from directly reading or writing data in user-space memory pages. If the kernel attempts to touch user memory without explicitly enabling it first, the CPU triggers a fault.

## Why it matters
Before SMAP, attackers used "ret2usr" techniques: they placed malicious shellcode in user-space memory, then exploited a kernel vulnerability to redirect execution there, hijacking the kernel by tricking it into running attacker-controlled code. SMAP defeats this by making user-space memory physically inaccessible to the kernel unless the kernel temporarily lowers the guard via the `STAC`/`CLAC` instructions — a narrow, auditable window that eliminates casual abuse.

## Key facts
- SMAP was introduced by Intel in Broadwell (2014) and AMD added support shortly after; it is paired with SMEP (Supervisor Mode Execution Prevention)
- SMEP blocks the kernel from *executing* user-space code; SMAP blocks the kernel from *reading or writing* user-space data — they are complementary
- Controlled by CR4 bit 21; the kernel sets this bit at boot to enable SMAP
- Linux, Windows, and macOS all enable SMAP/SMEP by default on supported hardware
- Bypass attempts often target the `STAC`/`CLAC` instruction windows or exploit copy-from-user primitives where access is legitimately granted

## Related concepts
[[SMEP]] [[Kernel Exploitation]] [[Address Space Layout Randomization]] [[Return-to-User Attack]] [[Control Register Security]]