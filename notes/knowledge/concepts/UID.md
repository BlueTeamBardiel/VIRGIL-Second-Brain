# UID

## What it is
Think of a UID like a Social Security Number for every user account on a Linux/Unix system — it's the number the kernel actually uses to make decisions, not the username you type. A User Identifier (UID) is a unique integer assigned to each user account that the operating system uses internally to determine file ownership and access permissions. The username is just a human-friendly label; the UID is what the kernel trusts.

## Why it matters
A classic privilege escalation attack exploits UID 0 equivalence: if an attacker can create or modify any account to have UID 0, that account gains full root privileges regardless of its username. This is why defenders audit `/etc/passwd` for unexpected UID 0 entries — a hidden "backdoor" account named `syslog` or `daemon` with UID 0 is a textbook persistence technique used after initial compromise.

## Key facts
- **UID 0** is root — any account with UID 0 has full system privileges, regardless of account name
- UIDs **0–999** (or 0–499 on older systems) are reserved for system/service accounts; UIDs **1000+** are typically assigned to human users
- The mapping between username and UID lives in `/etc/passwd`; permissions in the filesystem are stored as UID integers, not names
- **SUID bit** (Set User ID) causes an executable to run with the file *owner's* UID rather than the caller's — a common privilege escalation vector (`find / -perm -4000`)
- On Windows, the functional equivalent is the **SID (Security Identifier)**, not a simple integer

## Related concepts
[[SUID/SGID]] [[Privilege Escalation]] [[/etc/passwd]] [[Linux File Permissions]] [[Access Control]]