# MFT API

## What it is
Think of the Master File Table as a library's card catalog — it records the location and metadata of every book (file) without containing the books themselves. The **MFT API** refers to the Windows NTFS interface that allows programs to directly query the Master File Table (`$MFT`) to enumerate files, timestamps, and attributes without traversing the directory tree. This bypasses the standard filesystem abstraction layer, enabling low-level, high-speed file enumeration.

## Why it matters
Attackers and forensic investigators both love the MFT API for opposite reasons. Malware such as **CARBANAK** and various ransomware strains use direct MFT access to rapidly enumerate target files for encryption or exfiltration while evading security tools that only hook higher-level filesystem APIs. Defenders and forensic analysts use MFT parsing to recover deleted file records, reconstruct timelines, and detect **timestomping** — the manipulation of $STANDARD_INFORMATION timestamps to obscure attacker activity.

## Key facts
- The MFT contains at least one record (1 KB each) for every file and directory on an NTFS volume, including hidden system files like `$MFT` itself.
- Direct MFT access requires **SeBackupPrivilege** or Administrator rights, making privilege escalation a prerequisite for attacker abuse.
- Timestamps appear in **two locations**: `$STANDARD_INFORMATION` (user-visible, easily modified) and `$FILE_NAME` (harder to modify, often forensically reliable) — discrepancies between them indicate timestomping.
- Tools like **Velociraptor**, **MFTECmd**, and **Autopsy** leverage MFT parsing to perform forensic triage without relying on the OS filesystem layer.
- MFT enumeration can bypass security products that rely on **FindFirstFile/FindNextFile** API hooks, since MFT access uses DeviceIoControl calls directly to the NTFS driver.

## Related concepts
[[NTFS Artifacts]] [[Timestomping]] [[Privilege Escalation]] [[Anti-Forensics]] [[Windows Forensic Artifacts]]