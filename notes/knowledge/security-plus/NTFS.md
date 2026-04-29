# NTFS

## What it is
Think of NTFS like a library that doesn't just track where books are shelved, but also logs who touched each book, when, and whether they're allowed to read it at all. New Technology File System (NTFS) is the default file system for Windows, providing fine-grained access controls, journaling, encryption support, and metadata tracking. It replaced FAT32 as the standard for modern Windows installations due to these security-critical capabilities.

## Why it matters
Attackers frequently abuse NTFS Alternate Data Streams (ADS) to hide malware inside legitimate files — a payload can be embedded in `readme.txt:malware.exe`, invisible to normal directory listings but fully executable. Defenders use NTFS audit policies and the Security Event Log (Event ID 4663) to detect unauthorized file access, making proper NTFS permissions and auditing a core part of data loss prevention. Misconfigured NTFS permissions are a classic privilege escalation vector in penetration tests.

## Key facts
- **Alternate Data Streams (ADS):** Files can contain hidden streams (e.g., `file.txt:hidden.exe`) — a common malware concealment technique detectable with `dir /r` or Sysinternals Streams
- **NTFS Permissions vs. Share Permissions:** When both apply (network access), the *most restrictive* permission wins — a critical concept for access control questions
- **EFS (Encrypting File System):** Built into NTFS; encrypts files per-user with certificates — losing the certificate means permanent data loss
- **Journaling:** NTFS maintains a transaction log ($LogFile) that enables recovery after crashes, also useful for forensic timeline reconstruction
- **ACLs on every object:** Every file and folder has a Discretionary ACL (DACL) and System ACL (SACL) — SACL controls auditing, DACL controls access

## Related concepts
[[Access Control Lists]] [[Alternate Data Streams]] [[Encrypting File System]] [[Windows Privilege Escalation]] [[File System Forensics]]