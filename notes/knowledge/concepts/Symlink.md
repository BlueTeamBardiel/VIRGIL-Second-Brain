# symlink

## What it is
Like a sticky note on your desk that says "the real file is in the cabinet down the hall" — your OS follows the note transparently. A symbolic link (symlink) is a special filesystem object that points to another file or directory by path, causing any operation on the symlink to redirect to the target. Unlike a hard link, it can cross filesystems and point to nonexistent targets.

## Why it matters
Symlink attacks (also called TOCTOU — Time-of-Check to Time-of-Use races) are a classic privilege escalation vector: a low-privileged attacker creates a symlink in a world-writable directory (like `/tmp`) pointing to a sensitive file like `/etc/shadow`, then tricks a root-privileged process into writing to what it thinks is a temporary file — instead overwriting the sensitive target. This was the mechanism behind CVE-2015-1328 (Ubuntu overlayfs local privilege escalation) and countless other Linux LPEs.

## Key facts
- Symlinks are created with `ln -s target linkname` on Linux/macOS; Windows equivalent is `mklink` (requires elevated privileges by default)
- A **TOCTOU race condition** exploits the gap between when a program checks a file's properties and when it actually uses it — a symlink swap in that window redirects the operation
- Sticky bit (`+t`) on directories like `/tmp` partially mitigates symlink attacks by preventing users from deleting or renaming files they don't own
- Linux kernels ≥ 3.6 include **fs.protected_symlinks** (`sysctl`) which restricts symlink following in world-writable directories to the link's owner
- On Windows, creating symlinks requires `SeCreateSymbolicLinkPrivilege` — this limitation reduces (but doesn't eliminate) symlink abuse on that platform

## Related concepts
[[TOCTOU Race Condition]] [[Privilege Escalation]] [[File Permissions]] [[Directory Traversal]]