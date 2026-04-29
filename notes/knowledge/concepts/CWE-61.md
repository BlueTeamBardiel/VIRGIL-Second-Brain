# CWE-61

## What it is
Like a contractor who follows a forwarding address to deliver materials to the *actual* building rather than the decoy lobby — a program that resolves a symlink before checking permissions is operating on the real target, not the name it was given. CWE-61 is UNIX Symbolic Link (Symlink) Following: a vulnerability where software follows a symlink to access a file without verifying that the resolved path is the intended, authorized target. An attacker plants a symlink in a writable location, pointing it to a sensitive file, and a privileged process blindly operates on that target.

## Why it matters
A classic exploitation scenario: a system backup utility runs as root and archives files in `/tmp`. An attacker creates `/tmp/backupfile` as a symlink pointing to `/etc/shadow`. The root process follows the link and either reads or overwrites the shadow file, enabling credential theft or system corruption. Defense requires using `O_NOFOLLOW` flags or checking file ownership before operating on any path in a shared-writable directory.

## Key facts
- The vulnerability requires a **writable directory** (like `/tmp`) where the attacker can place the symlink before the privileged process uses it — this is often a **TOCTOU (Time-of-Check to Time-of-Use)** race condition
- Mitigation involves opening files with `O_NOFOLLOW` (Linux) or using `lstat()` to detect symlinks before processing
- Commonly affects **SUID/SGID binaries**, daemons, and backup/logging utilities that operate on user-controlled paths
- CWE-61 is a child of **CWE-59 (Improper Link Resolution Before File Access)**, which covers the broader link-following class
- On Linux, `/proc/PID/fd/` can sometimes be used to detect whether an fd resolved through a symlink as a defensive check

## Related concepts
[[CWE-59]] [[TOCTOU Race Condition]] [[Privilege Escalation]] [[Insecure Temporary File]] [[SUID Binaries]]