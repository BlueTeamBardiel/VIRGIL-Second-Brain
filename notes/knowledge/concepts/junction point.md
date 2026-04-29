# junction point

## What it is
Like a wormhole in a subway map that secretly routes you to a different station than the sign says, a junction point is a Windows NTFS filesystem object that acts as a pointer redirecting access from one directory path to another location on the same volume. Technically, it is a type of reparse point — metadata attached to a directory entry that tells the OS to transparently redirect I/O operations to a target path.

## Why it matters
Attackers abuse junction points in **symlink/TOCTOU (Time-of-Check/Time-of-Use) privilege escalation attacks**. A classic example: a low-privileged process creates a junction point in a writable temp folder pointing to `C:\Windows\System32`. When a privileged installer or service later writes files to that temp path, it unknowingly writes into System32, potentially replacing critical binaries. This technique was central to exploits like CVE-2019-1069 (Task Scheduler) on Windows.

## Key facts
- Junction points only work on **directories**, not individual files (unlike symbolic links, which can target files)
- They are created with `mklink /J` on Windows or via the `CreateSymbolicLink` API with directory flags
- Unlike symlinks, junction points **do not require elevated privileges** to create on most Windows configurations — making them a low-cost attacker primitive
- Junction points are **local-volume only** — they cannot redirect across network paths or different drive letters (use mount points or symbolic links for that)
- Windows security tools and AV scanners can be **bypassed or confused** by junction points when they resolve paths inconsistently vs. the actual I/O target

## Related concepts
[[symbolic link]] [[TOCTOU race condition]] [[privilege escalation]] [[NTFS alternate data streams]] [[reparse point]]