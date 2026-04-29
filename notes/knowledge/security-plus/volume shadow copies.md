# volume shadow copies

## What it is
Think of Volume Shadow Copies as the Windows OS quietly taking a photograph of your hard drive at regular intervals — so if you spill coffee on the album, you still have the photo. Technically, VSS (Volume Shadow Copy Service) is a Windows feature that creates point-in-time snapshots of files and volumes, even while they're in active use. These snapshots allow files to be restored to previous states without a full backup restore operation.

## Why it matters
Ransomware operators know that shadow copies are the fastest path to recovery without paying, so their first move is almost always deletion — commands like `vssadmin delete shadows /all /quiet` or `wmic shadowcopy delete` are now ransomware signatures that EDR tools specifically hunt for. Defenders monitor for these commands as high-confidence indicators of an active ransomware attack in progress. Conversely, forensic investigators use shadow copies as a goldmine for recovering deleted files, browsing history, and credential stores that attackers thought were gone.

## Key facts
- VSS snapshots are stored on the same volume by default, meaning ransomware encrypting that volume destroys the snapshots too unless they're offloaded
- `vssadmin list shadows` reveals all existing snapshots; forensic tools like Shadow Explorer can mount them for browsing
- Shadow copies are enabled automatically when System Protection is turned on in Windows; they're created before Windows Updates and driver installs
- Attackers can extract NTDS.dit (Active Directory database) and SAM hive credentials from shadow copies without touching live locked files — a classic credential theft technique
- Windows Volume Shadow Copy is distinct from cloud snapshots (AWS EBS snapshots, Azure disk snapshots), but the defensive concept is identical

## Related concepts
[[ransomware]] [[credential dumping]] [[NTDS.dit]] [[forensic artifacts]] [[backup and recovery]]