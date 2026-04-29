# System File Checker

## What it is
Think of it as a pharmacist who memorizes the exact weight of every pill — if someone swaps a legitimate tablet for a counterfeit, the pharmacist catches the discrepancy immediately. System File Checker (SFC) is a built-in Windows utility (`sfc /scannow`) that compares critical OS files against a trusted cached baseline stored in the Windows Component Store, restoring any corrupted or altered files it detects.

## Why it matters
Rootkits and advanced malware frequently overwrite or patch core Windows binaries (like `ntoskrnl.exe` or `winlogon.exe`) to maintain persistence and hide their presence. A defender running SFC during incident response can quickly identify whether system files have been tampered with — though a sophisticated rootkit operating at the kernel level may intercept SFC's own reads, making the tool appear clean when the system is actually compromised.

## Key facts
- Run as **Administrator** with `sfc /scannow`; repairs files by pulling clean copies from `C:\Windows\WinSxS` (the Component Store)
- Logs results to `C:\Windows\Logs\CBS\CBS.log` — critical for forensic documentation during incident response
- **DISM** (`DISM /Online /Cleanup-Image /RestoreHealth`) should be run *before* SFC if the Component Store itself is corrupted, as SFC relies on it as its repair source
- SFC operates in **offline mode** (`/offbootdir`, `/offwindir`) to scan a non-running OS volume — useful when malware actively blocks repairs on a live system
- Cannot detect malware hiding *above* its scan layer; kernel-level rootkits can subvert SFC results, so a clean SFC report does **not** guarantee system integrity

## Related concepts
[[File Integrity Monitoring]] [[Rootkits]] [[Windows Defender]] [[DISM]] [[Persistence Mechanisms]]