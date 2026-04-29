# Symbolic Links

## What it is
Think of a symlink like a forwarding address at the post office — mail sent to your old address automatically gets delivered to your new one, and the sender never knows the difference. Precisely, a symbolic link is a special file system object that contains a path pointing to another file or directory, causing the OS to transparently redirect any access to the target location. Unlike hard links, symlinks can span file systems and can point to directories.

## Why it matters
Symlink attacks (also called TOCTOU — Time of Check to Time of Use attacks) are a classic privilege escalation vector. A low-privileged attacker creates a symlink in a world-writable directory (like `/tmp`) pointing to a sensitive file such as `/etc/shadow`, then tricks a privileged process into writing to that symlink target instead of the intended location — overwriting the password file and potentially gaining root access.

## Key facts
- Symlinks store only a **path string**, not inode data — they break if the target is moved or deleted (called a "dangling symlink")
- The `/tmp` directory is a notorious battleground: world-writable + race conditions + symlinks = privilege escalation recipe
- Linux systems can restrict cross-directory symlink following via the kernel sysctl `fs.protected_symlinks = 1` (enabled by default in modern distros)
- Windows equivalent is the **junction point** (directories) or **symbolic link** requiring SeCreateSymbolicLinkPrivilege — attackers use `mklink` to exploit misconfigured services
- Symlink attacks are a subset of **TOCTOU race conditions**, relevant to both CWE-61 and CWE-362 in vulnerability classification

## Related concepts
[[TOCTOU Race Condition]] [[Privilege Escalation]] [[File System Permissions]] [[Path Traversal]]