# CWE-59

## What it is
Like a valet who follows a sign saying "keys in box" but the sign secretly points to a thief's pocket — a program follows a symbolic link (symlink) to a location the attacker controls instead of the intended target. CWE-59 is **Improper Link Resolution Before File Access ("Link Following")**, where software fails to verify that a resolved path leads to the intended resource before performing operations on it.

## Why it matters
The classic attack: a privileged process (running as root) writes a log file to `/tmp/app.log`. An attacker creates a symlink: `ln -s /etc/passwd /tmp/app.log`. The privileged process follows the link and overwrites `/etc/passwd`, corrupting the system or enabling privilege escalation. This pattern affected numerous Unix daemons and package managers historically, including early versions of `rpm` and various syslog implementations.

## Key facts
- Symlink attacks are most dangerous when a **high-privilege process** acts on attacker-influenced paths in world-writable directories like `/tmp`
- The TOCTOU (Time-of-Check to Time-of-Use) race condition is a close cousin — an attacker substitutes a symlink between the check and the use
- Mitigations include using `O_NOFOLLOW` flag in `open()` syscalls, `lstat()` to detect symlinks before acting, and **avoiding world-writable directories** for privileged operations
- On Windows, the equivalent vectors include junction points and hard links, making this cross-platform
- CWE-59 is a child of CWE-706 (Use of Incorrectly-Resolved Name) and a frequent root cause in **CVE-filed local privilege escalation** vulnerabilities

## Related concepts
[[TOCTOU Race Condition]] [[CWE-61 UNIX Symbolic Link Following]] [[Principle of Least Privilege]] [[Path Traversal]] [[Local Privilege Escalation]]