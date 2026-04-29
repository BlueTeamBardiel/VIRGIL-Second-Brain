# inotify

## What it is
Like a motion-sensor alarm wired directly into a building's walls rather than the doors — inotify is a Linux kernel subsystem that notifies applications of filesystem events (file creation, deletion, modification, access) in real time without polling. Programs register "watches" on files or directories, and the kernel delivers event notifications through a file descriptor.

## Why it matters
Defenders use inotify as the backbone of file integrity monitoring (FIM) tools like auditd and OSSEC — any modification to `/etc/passwd` or `/etc/sudoers` triggers an immediate alert rather than a scheduled scan catching it hours later. Attackers also abuse inotify-aware tools: a malicious process can watch `/tmp` for new SUID binaries dropped by a privileged process and race to exploit them before cleanup occurs (a classic inotify-assisted TOCTOU race condition).

## Key facts
- inotify replaced the older `dnotify` interface in Linux kernel 2.6.13; it watches individual files, not just directories
- Events include `IN_CREATE`, `IN_DELETE`, `IN_MODIFY`, `IN_OPEN`, `IN_CLOSE_WRITE`, `IN_ATTRIB` (permission changes), and `IN_MOVED_FROM`/`IN_MOVED_TO`
- Each inotify instance has a kernel-enforced watch limit (`/proc/sys/fs/inotify/max_user_watches`; default often 8,192–524,288); exhausting it causes FIM tools to silently miss events — an attacker can weaponize this as a DoS against monitoring
- inotify is the engine behind `auditd` watches (`-w` flag), `incron`, and many EDR agents on Linux
- It does **not** work across network filesystems (NFS, CIFS) — file changes on remote mounts go undetected by local watchers

## Related concepts
[[File Integrity Monitoring]] [[auditd]] [[TOCTOU Race Condition]] [[Linux Privilege Escalation]] [[Host-Based Intrusion Detection]]