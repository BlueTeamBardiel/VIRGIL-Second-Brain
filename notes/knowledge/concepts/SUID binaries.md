# SUID binaries

## What it is
Like a master key left in a locked room that any employee can pick up and briefly become the building manager — a SUID (Set User ID) binary is an executable file with a special permission bit that causes it to run as its *owner* (often root) rather than the user who launched it. This allows unprivileged users to perform specific privileged operations without needing permanent elevated access.

## Why it matters
Attackers performing local privilege escalation routinely scan for misconfigured SUID binaries using `find / -perm -4000`. If a vulnerable or unexpected binary like `vim`, `cp`, or a custom application has the SUID bit set and belongs to root, an attacker can exploit it to spawn a root shell — a technique extensively documented on GTFOBins and commonly seen in CTF environments and real-world post-exploitation chains.

## Key facts
- SUID bit is represented as **4000** in octal; visible in `ls -l` as an `s` in the owner execute position (e.g., `-rwsr-xr-x`)
- Legitimate SUID binaries include `passwd`, `sudo`, and `ping` — these need root privileges for specific kernel-level operations
- The **sticky bit** (1000) and **SGID** (2000) are related special permissions; SGID runs as the file's *group* owner instead
- To find all SUID files: `find / -perm -u=s -type f 2>/dev/null` — a standard enumeration command in privilege escalation methodology
- Removing the SUID bit: `chmod u-s /path/to/binary`; hardening guides recommend auditing SUID binaries as part of CIS Benchmark compliance

## Related concepts
[[Privilege Escalation]] [[Linux File Permissions]] [[GTFOBins]] [[Principle of Least Privilege]]