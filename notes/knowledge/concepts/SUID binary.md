# SUID binary

## What it is
Think of a SUID binary like a valet key programmed to always start the CEO's car — no matter who holds it, the car runs with the CEO's authority. A **Set User ID (SUID)** binary is an executable file with a special permission bit set, causing it to run with the **file owner's privileges** (often root) rather than the privileges of the user who launched it. The classic example is `/usr/bin/passwd`, which must write to `/etc/shadow` even when run by an unprivileged user.

## Why it matters
Attackers routinely search for misconfigured SUID binaries as a **local privilege escalation** path. If an administrator mistakenly sets the SUID bit on an interpreter like `python3` or `vim`, any local user can invoke it and spawn a root shell — a technique documented extensively on GTFOBins. This transforms a low-privilege foothold into full system compromise in a single command.

## Key facts
- SUID bit is represented as **4** in octal permissions (e.g., `chmod 4755 binary`) and appears as **`s`** in the owner execute field (`-rwsr-xr-x`)
- Find all SUID binaries on a system with: `find / -perm -4000 -type f 2>/dev/null`
- SUID has **no effect on shell scripts** in most Linux kernels — only compiled binaries honor it
- The companion bit **SGID (2)** does the same thing but elevates to the **group owner's** privileges instead
- Legitimate SUID binaries include `passwd`, `ping`, `sudo`, and `su` — anything beyond a vetted list is a red flag during audits

## Related concepts
[[Privilege Escalation]] [[Linux File Permissions]] [[GTFOBins]] [[Least Privilege]] [[Capability-based Security]]