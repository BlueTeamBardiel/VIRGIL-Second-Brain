# CreateSymbolicLink

## What it is
Like a hotel room placard that redirects housekeeping to a *different* room than the one it's hanging on — a symbolic link (symlink) is a filesystem pointer that transparently redirects file operations to a target path elsewhere. `CreateSymbolicLink` is the Windows API function (and `mklink` command) that creates these redirecting pointers, requiring `SeCreateSymbolicLinkPrivilege` by default.

## Why it matters
Symlink attacks are a classic privilege escalation vector: a low-privileged attacker creates a symlink in a writable temp directory pointing to a sensitive file (e.g., `C:\Windows\System32\config\SAM`), then waits for a privileged process to write to the apparent path — actually overwriting the target. This technique was central to exploits like **CVE-2019-1069** (Windows Task Scheduler symlink bypass), where attackers manipulated scheduled task files to gain SYSTEM-level writes.

## Key facts
- **Privilege required**: On unmodified Windows, only administrators can create symlinks; Developer Mode removes this restriction, expanding the attack surface.
- **Symlink vs. Junction**: Symlinks work on files *and* directories; NTFS Junctions (directory symlinks) work only on directories but require no special privilege — making them the attacker's preferred alternative.
- **TOCTOU link**: Symlink attacks are frequently a **Time-of-Check to Time-of-Use (TOCTOU)** race condition — the attacker swaps a legitimate path for a symlink between check and use.
- **Oplock trick**: Attackers use Windows opportunistic locks (oplocks) to pause a privileged process mid-operation, buying time to plant the symlink before the write completes.
- **Detection**: Security tools monitor for symlink creation in world-writable directories (`%TEMP%`, `C:\ProgramData`) as a high-fidelity indicator of privilege escalation attempts.

## Related concepts
[[TOCTOU Race Condition]] [[Privilege Escalation]] [[NTFS Junctions]] [[SeCreateSymbolicLinkPrivilege]] [[Arbitrary File Write]]