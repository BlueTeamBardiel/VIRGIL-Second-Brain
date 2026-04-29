# File System

## What it is
Think of a file system as the Dewey Decimal System of your hard drive — a structured cataloging method that tells the OS exactly where every piece of data lives on physical storage. Precisely, a file system is the layer of abstraction that manages how data is stored, organized, retrieved, and named on a storage device. Common examples include NTFS (Windows), ext4 (Linux), and APFS (macOS).

## Why it matters
During forensic investigations, the file system is the first battlefield — attackers who delete files don't actually erase data immediately; they simply remove the directory entry, leaving the raw data recoverable until overwritten. Tools like Autopsy or FTK exploit this by carving deleted files from unallocated space, which is how investigators recover evidence even after suspects think they've covered their tracks. Understanding file system internals directly enables both offense (hiding malware in alternate data streams) and defense (integrity monitoring).

## Key facts
- **NTFS Alternate Data Streams (ADS)** allow data to be hidden inside a file without changing its visible size — a classic malware hiding technique (`malware.exe:hidden.exe`)
- **MFT (Master File Table)** in NTFS records metadata for every file; forensic analysis of the MFT can reveal deleted files, timestamps, and access patterns
- **Slack space** — the unused space between end-of-file and end-of-cluster — can contain residual data from previously stored files, a goldmine for forensics
- **Journaling** (used by NTFS, ext4) logs changes before committing them, aiding recovery but also leaving an audit trail attackers may want to clear
- **File permissions** (NTFS ACLs, Linux DAC) are enforced at the file system level — misconfiguration is a primary privilege escalation vector

## Related concepts
[[Access Control Lists]] [[Digital Forensics]] [[Steganography]] [[Privilege Escalation]] [[Data Carving]]