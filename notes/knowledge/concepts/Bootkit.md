# Bootkit

## What it is
Imagine a thief who doesn't break into your house — they replace your front door lock *before you move in*, so every time you come home, you're letting them in without knowing it. A bootkit is malware that infects the Master Boot Record (MBR), Volume Boot Record (VBR), or UEFI firmware, loading itself *before* the operating system starts so it operates beneath the reach of traditional antivirus tools.

## Why it matters
The 2011 TDL4 (TDSS) bootkit infected over 4.5 million Windows machines by rewriting the MBR, making it invisible to OS-level security tools because it loaded before Windows — and before any security software — ever ran. Defenders countered using out-of-band analysis, booting from clean media and inspecting the MBR directly with tools like `dd` or Autopsy to detect the tampered sectors.

## Key facts
- Bootkits persist across OS reinstalls because they live in the boot sector, not the OS partition — wiping the drive without zeroing the MBR leaves the infection intact
- UEFI Secure Boot is the primary modern defense: it cryptographically verifies each stage of the boot chain, rejecting unsigned bootloaders
- Detection requires comparing the MBR/VBR hash against a known-good baseline using forensic tools, since the infected OS cannot be trusted to report accurately
- Bootkits achieve **Ring -1 / hypervisor-level persistence** in advanced cases, running below the OS kernel (Ring 0)
- Measured Boot (used with TPM) logs each boot component's hash — a tampered bootloader produces a different PCR value, flagging the compromise

## Related concepts
[[Rootkit]] [[UEFI Secure Boot]] [[Trusted Platform Module (TPM)]] [[Master Boot Record (MBR)]] [[Persistence Mechanisms]]