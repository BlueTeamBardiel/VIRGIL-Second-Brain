# symlink following

## What it is
Imagine a hotel concierge who delivers room service to whatever door a room number placard points to — even if someone secretly moved the placard to the manager's office. A symlink (symbolic link) is a filesystem pointer to another file or directory; **symlink following** is when a privileged process blindly follows that pointer without verifying the destination, allowing an attacker to redirect file operations to sensitive targets the attacker couldn't normally access.

## Why it matters
A classic attack: a program running as root creates a temp file at `/tmp/output.log`. An attacker races to delete it and replace it with a symlink pointing to `/etc/shadow`. The root process then writes into `/etc/shadow`, corrupting or exposing password hashes. This **TOCTOU (time-of-check to time-of-use)** race condition is the engine behind many local privilege escalation CVEs, including multiple Linux kernel and sudo vulnerabilities.

## Key facts
- Symlink attacks are a subset of **TOCTOU race conditions** — the window between checking a path and using it is the attack surface.
- Mitigations include using `O_NOFOLLOW` flag when opening files, and `openat()` with directory file descriptors to prevent mid-path redirection.
- `/tmp` directories are the most common staging ground because they are world-writable, making symlink planting trivial.
- Linux introduced **fs.protected_symlinks** (sysctl) as a kernel-level defense: symlinks in sticky world-writable directories are only followed if the owner matches the follower.
- CVE-2021-3156 (sudo "Baron Samedit") involved argument processing that could be chained with symlink manipulation to achieve root escalation.

## Related concepts
[[TOCTOU race condition]] [[privilege escalation]] [[file permission hardening]]