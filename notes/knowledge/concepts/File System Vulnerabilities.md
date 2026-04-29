# File System Vulnerabilities

## What it is
Like a careless librarian who hands out books from restricted sections just because someone asks nicely using a confusing call number, file systems can be tricked into granting access to files outside their intended boundaries. File system vulnerabilities are weaknesses in how operating systems and applications handle file paths, permissions, and storage structures — allowing attackers to read, write, or execute files they should never touch.

## Why it matters
In 2019, a path traversal vulnerability in Pulse Secure VPN (CVE-2019-11510) allowed unauthenticated attackers to send crafted HTTP requests with `../` sequences to read arbitrary files — including cached plaintext credentials — from the server. This led to widespread ransomware deployments against government and enterprise targets because the exposed credentials unlocked VPN access.

## Key facts
- **Path traversal (directory traversal)** uses sequences like `../../../etc/passwd` to escape the intended root directory and access sensitive files
- **Symlink attacks** trick privileged processes into following symbolic links to unintended targets, enabling privilege escalation (common in `/tmp` races)
- **TOCTOU (Time-of-Check to Time-of-Use)** race conditions exploit the gap between permission verification and file operation execution
- **Improper permissions** (e.g., world-writable `/etc/passwd` or SUID binaries) are a leading cause of local privilege escalation on Linux/Unix systems
- **Alternate Data Streams (ADS)** in NTFS allow malware to hide executable code inside legitimate files, invisible to standard directory listings — a key defense evasion technique

## Related concepts
[[Path Traversal]] [[Privilege Escalation]] [[TOCTOU Race Conditions]] [[Symlink Attacks]] [[Access Control Lists]]