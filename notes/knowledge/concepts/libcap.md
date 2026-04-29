# libcap

## What it is
Think of Linux capabilities like a hotel master keycard being cut into individual room keys — instead of one all-powerful root account, privileges are sliced into discrete, assignable units. `libcap` is the C library (and associated CLI tools like `getcap`, `setcap`, and `capsh`) that lets Linux programs query, set, and manipulate these POSIX capabilities on files and processes.

## Why it matters
Attackers routinely scan for misconfigured capabilities using `getcap -r / 2>/dev/null` during privilege escalation. A binary like `python3` granted `cap_setuid+ep` (effective + permitted) allows an unprivileged user to call `setuid(0)` and instantly become root — no SUID bit required and often overlooked by defenders auditing only SUID files.

## Key facts
- **Three capability sets matter most:** Permitted (what the process *can* use), Effective (what it's *currently* using), and Inheritable (what child processes can pick up).
- **`setcap` writes capabilities into ELF file extended attributes** — they survive across executions but are invisible to basic `ls -la` permission checks.
- **`cap_net_raw`** allows raw socket access; granting it to `tcpdump` avoids running it as root, but if misconfigured, enables packet sniffing by non-root users.
- **`+ep` flag** (effective + permitted) is the most dangerous combination — capability is active immediately upon execution without any code to explicitly raise it.
- **Dropping capabilities** (e.g., using `cap_drop` in Docker) is a defense-in-depth strategy; containers run with reduced capability sets by default since Docker 1.10.

## Related concepts
[[Linux Capabilities]] [[Privilege Escalation]] [[SUID Binaries]] [[Least Privilege]] [[Linux Process Hardening]]