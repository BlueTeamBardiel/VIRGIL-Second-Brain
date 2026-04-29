# Manipulating Files

## What it is
Like a forger who alters a document's date, signature, and ink to make it look untouched, file manipulation is the deliberate modification, creation, deletion, or concealment of files to achieve an attacker's goal. It encompasses changing file contents, permissions, timestamps, attributes, or metadata to either execute an attack or erase evidence of one.

## Why it matters
After compromising a Linux web server, an attacker may modify `/etc/passwd` to add a backdoor root account, then use `touch` to reset the file's timestamps to match surrounding system files — making forensic timeline analysis fail to flag the change. Defenders counter this with file integrity monitoring (FIM) tools like Tripwire or AIDE, which hash critical files and alert on any deviation.

## Key facts
- **Timestomping** is the technique of altering MAC times (Modified, Accessed, Changed) to defeat timeline forensics — a key anti-forensics method tested on Security+
- **NTFS Alternate Data Streams (ADS)** allow attackers to hide malicious payloads inside legitimate files without changing the visible file size (e.g., `malware.exe` hidden in `readme.txt:malware.exe`)
- **File permissions manipulation** (e.g., `chmod 777` on sensitive files or modifying ACLs) is a common privilege escalation and persistence technique
- **Log file tampering** — deleting or editing `/var/log/auth.log` or Windows Event Logs — is a standard post-exploitation step to cover tracks
- FIM tools establish a **cryptographic baseline** (typically SHA-256 hashes) of critical files; any mismatch triggers an alert, making them essential for integrity verification under NIST 800-53 controls

## Related concepts
[[File Integrity Monitoring]] [[Timestomping]] [[Alternate Data Streams]] [[Anti-Forensics]] [[Privilege Escalation]]