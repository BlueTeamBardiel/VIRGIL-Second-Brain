# Mark-of-the-Web Bypass

## What it is
Like a customs officer stamping your passport to flag you came from abroad, Windows stamps downloaded files with a hidden "Zone.Identifier" NTFS Alternate Data Stream (ADS) to mark them as untrusted internet content. A Mark-of-the-Web (MotW) bypass is any technique that strips, prevents, or circumvents this stamp so malicious files execute without triggering SmartScreen warnings or Protected View in Office.

## Why it matters
In 2022–2023, threat actors distributed malicious `.iso` and `.zip` files because containers mounted as virtual drives or extracted by certain archivers (7-Zip prior to 22.00) did not propagate the MotW tag to their contents — allowing macro-laden Office documents inside to open with full trust. This technique was central to campaigns distributing Qakbot and Emotet, bypassing the very defense Microsoft introduced to kill macro-based malware delivery.

## Key facts
- MotW is stored as an NTFS Alternate Data Stream named `Zone.Identifier` with `ZoneId=3` (Internet Zone); it only works on NTFS volumes, not FAT32/exFAT.
- `.iso`, `.vhd`, and `.img` files mount as separate volumes, historically not passing MotW to enclosed files — a key bypass vector patched by Microsoft in late 2022 (CVE-2022-41091).
- 7-Zip did not propagate MotW to extracted files until version 22.00 (July 2022), making it a reliable bypass tool for attackers.
- Microsoft's November 2022 Patch Tuesday hardened MotW propagation and began blocking Office macros in internet-sourced files by default.
- Defenders can audit MotW presence using `Get-Item -Stream Zone.Identifier` in PowerShell or `streams.exe` from Sysinternals.

## Related concepts
[[Alternate Data Streams]] [[SmartScreen]] [[Protected View]] [[Macro Security Controls]] [[Living Off the Land Binaries]]