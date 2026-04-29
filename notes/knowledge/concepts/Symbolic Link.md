# symbolic link

## What it is
Like a hotel room number on a door that redirects you to an entirely different physical room elsewhere in the building — a symbolic link (symlink) is a special filesystem entry that points to another file or directory by path. The OS transparently follows the pointer, so programs reading the symlink actually read the target, without knowing they've been redirected.

## Why it matters
Attackers exploit symlinks in **symlink races (TOCTOU attacks)**: a privileged process checks that a file is safe, then the attacker swaps it with a symlink to `/etc/shadow` before the process acts on it — causing the privileged program to read or overwrite a sensitive file it never intended to touch. This pattern has been used in real privilege escalation exploits against Linux package managers and temporary file handlers like those using `/tmp`.

## Key facts
- Symlinks store a **path string**, not inode data — deleting the target leaves a "dangling" symlink pointing to nothing
- Unlike hard links, symlinks **can cross filesystem boundaries** and point to directories
- **TOCTOU (Time-of-Check to Time-of-Use)** is the primary attack class enabled by symlinks in privileged processes
- Secure coding defense: use `O_NOFOLLOW` flag when opening files to prevent following symlinks, and avoid world-writable directories like `/tmp` for sensitive operations
- On Linux, `/proc/self/exe` and many entries under `/proc` are symlinks — attackers use them for process enumeration and sandbox escapes
- Windows equivalent: **junction points** (for directories) and **symbolic links** requiring `SeCreateSymbolicLinkPrivilege` — reducing, but not eliminating, the attack surface

## Related concepts
[[TOCTOU attack]] [[privilege escalation]] [[hard link]] [[file permissions]] [[path traversal]]