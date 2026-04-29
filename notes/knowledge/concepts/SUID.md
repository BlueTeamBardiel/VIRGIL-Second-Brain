# SUID

## What it is
Imagine a master key hidden inside a regular door — anyone who touches that door temporarily gains the locksmith's access, not their own. SUID (Set User ID) is a Linux/Unix file permission bit that, when set on an executable, causes it to run with the privileges of the **file's owner** (often root) rather than the user who launched it. This is how `passwd` lets ordinary users modify `/etc/shadow` without being root themselves.

## Why it matters
Attackers routinely search for misconfigured SUID binaries as a local privilege escalation path — if a vulnerable or unintended binary (like `vim`, `find`, or a custom script) has the SUID bit set, a low-privileged user can spawn a root shell. This technique appears in almost every CTF privilege escalation challenge and real-world post-exploitation workflow (e.g., GTFOBins catalogs dozens of SUID-abusable binaries).

## Key facts
- SUID is represented as **4** in octal permissions (`chmod 4755 file`) and displays as **`s`** in the owner execute position (`-rwsr-xr-x`)
- To find all SUID binaries on a system: `find / -perm -4000 -type f 2>/dev/null`
- Legitimate SUID binaries include `/usr/bin/passwd`, `/usr/bin/sudo`, and `/bin/ping`
- Scripts with SUID set are **ignored** by the Linux kernel — only compiled binaries honor the bit
- GUID (Set Group ID) is the parallel concept for group-level privilege elevation, represented by **2** in octal

## Related concepts
[[Privilege Escalation]] [[Linux File Permissions]] [[GTFOBins]] [[Least Privilege]]