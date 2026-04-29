# FILE

## What it is
Like a labeled folder in a physical filing cabinet, a file is a named container of data stored on a medium — but unlike paper, files carry hidden metadata, permissions, and execution potential that make them attack surfaces in disguise. Precisely, a file is a discrete unit of data identified by a name and path within a filesystem, governed by access control attributes that determine who can read, write, or execute it.

## Why it matters
In the 2010 Stuxnet attack, malicious `.lnk` shortcut files exploited a Windows vulnerability — simply *viewing* the file in Explorer triggered payload execution without any user click. This demonstrates that file type, extension, and metadata can be weaponized independently of file content, making file-based threats one of the most persistent attack vectors defenders must monitor.

## Key facts
- **File extensions are not trusted indicators** of file type; attackers rename `malware.exe` to `invoice.pdf` to bypass naive filters — magic bytes (file signatures) are more reliable
- **NTFS Alternate Data Streams (ADS)** allow data to be hidden inside legitimate files (e.g., `readme.txt:malware.exe`) without affecting visible file size
- **SUID/SGID bits** on Unix/Linux files allow privilege escalation — a misconfigured SUID binary can grant root-level execution to unprivileged users
- **File integrity monitoring (FIM)** tools like Tripwire detect unauthorized changes by comparing cryptographic hashes against a known-good baseline
- **Polyglot files** are valid as two different file types simultaneously (e.g., a file that is both a valid PDF and a ZIP), used to evade content inspection tools

## Related concepts
[[File Permissions]] [[Magic Bytes]] [[Alternate Data Streams]] [[File Integrity Monitoring]] [[Privilege Escalation]]