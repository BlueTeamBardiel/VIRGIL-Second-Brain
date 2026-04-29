# Volume Shadow Copy

## What it is
Think of Volume Shadow Copy as Windows quietly taking a photograph of your hard drive at regular intervals — even while files are open and in use. Technically, it is a Windows service (VSS) that creates point-in-time snapshots of volumes, allowing files and system states to be restored without taking the system offline.

## Why it matters
Ransomware attackers almost universally target VSS as part of their kill chain — executing `vssadmin delete shadows /all /quiet` immediately after encryption to destroy recovery options and force victims to pay. Defenders monitor for this specific command as a high-confidence indicator of ransomware activity, and EDR tools frequently alert on any process touching `vssadmin.exe` with delete arguments.

## Key facts
- VSS snapshots are stored in the `System Volume Information` folder and are accessible via `vssadmin list shadows` or the `Previous Versions` tab in Windows Explorer
- Ransomware families including Ryuk, Conti, and LockBit all include VSS deletion as a standard pre-encryption step
- VSS is leveraged in **credential theft**: attackers copy `NTDS.dit` (Active Directory database) from a shadow copy where the file is not locked by the OS
- Shadow copies are **not a substitute for offsite backups** — they reside on the same volume and can be deleted by any process with sufficient privileges
- The `diskshadow.exe` tool is a living-off-the-land binary (LOLBIN) that can be abused to access shadow copies while evading some security controls

## Related concepts
[[Ransomware]] [[NTDS.dit Extraction]] [[Living Off the Land Binaries]] [[Windows Backup and Recovery]] [[Credential Dumping]]