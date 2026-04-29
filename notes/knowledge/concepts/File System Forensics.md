# File System Forensics

## What it is
Like an archaeologist sifting through soil layers to reconstruct a civilization's history, file system forensics examines the digital strata of storage media — timestamps, metadata, deleted file remnants, and allocation structures — to reconstruct what happened on a system. It is the disciplined analysis of file systems (NTFS, ext4, FAT32, APFS) to recover evidence of user activity, malicious actions, or data exfiltration, even when perpetrators believe they've erased their tracks.

## Why it matters
In a ransomware investigation, attackers often delete their dropper executables and batch scripts after encryption completes, assuming cleanup destroys the evidence. File system forensics recovers these artifacts from unallocated clusters using tools like Autopsy or FTK, revealing the initial access vector, lateral movement timestamps, and staging directories — often enough to attribute the attack and prevent reinfection.

## Key facts
- **MFT (Master File Table)** in NTFS stores metadata for every file including MAC times (Modified, Accessed, Created) — attackers manipulate these via timestomping to confuse investigators
- **File carving** recovers files from unallocated space by identifying file headers/footers (magic bytes), bypassing file system structures entirely — critical when directory entries are wiped
- **Slack space** — the gap between a file's logical size and its allocated cluster size — can contain remnants of previously stored data, a hiding spot for data or evidence
- **Write blockers** (hardware or software) must be used before imaging drives to preserve forensic integrity and chain of custody
- **$LogFile and $UsnJrnl** in NTFS are change journals that log file operations, often surviving even after file deletion — gold mines for reconstructing attacker timelines

## Related concepts
[[Digital Forensics and Incident Response]] [[Chain of Custody]] [[Timestomping]] [[Steganography]] [[Volatile vs Non-Volatile Evidence]]