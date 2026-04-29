# Linux File System Hierarchy

## What it is
Think of it like a hospital: the ER (`/etc`) holds critical configurations, the pharmacy (`/usr`) stores installed software, and the morgue (`/var/log`) keeps records of everything that's happened. The Linux File System Hierarchy Standard (FHS) is a defined directory structure that specifies where specific types of files live across Unix-like operating systems, ensuring consistency across distributions.

## Why it matters
During incident response, knowing the FHS is the difference between finding a rootkit in minutes versus hours. Attackers frequently hide malicious binaries in `/tmp`, `/dev/shm`, or masquerade them inside `/usr/bin` because these locations are either world-writable or trusted by administrators — a defender who doesn't know what *shouldn't* be in `/etc/cron.d` will miss scheduled persistence mechanisms entirely.

## Key facts
- `/etc` stores system-wide configuration files (e.g., `/etc/passwd`, `/etc/shadow`, `/etc/sudoers`) — primary target for credential harvesting
- `/var/log` contains system logs; attackers routinely clear or tamper with `/var/log/auth.log` and `/var/log/syslog` to cover tracks
- `/tmp` and `/dev/shm` are world-writable and non-persistent — common staging areas for malware payloads and memory-based exploits
- `/proc` and `/sys` are virtual filesystems exposing kernel and process information at runtime — useful for live forensics and detecting process injection
- SUID/SGID binaries in `/usr/bin` or `/usr/sbin` are frequent privilege escalation vectors; the `find / -perm -4000` command enumerates them

## Related concepts
[[File Permissions and SUID/SGID]] [[Linux Privilege Escalation]] [[Log Analysis and SIEM]]