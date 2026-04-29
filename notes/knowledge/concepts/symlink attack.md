# symlink attack

## What it is
Imagine a post office worker who delivers mail to whatever address is written on the envelope — even if someone secretly replaced the address label with a new one pointing to your house. A symlink attack exploits symbolic links (filesystem shortcuts) to trick a privileged process into reading from or writing to a file the attacker controls, rather than the intended target. The attacker typically creates the symlink in a race window between when a program checks a path and when it actually uses it.

## Why it matters
A classic example: many Linux daemons write temporary files to `/tmp`. An attacker can predict the filename, delete it, and replace it with a symlink pointing to `/etc/passwd`. If the daemon runs as root and writes to that path, the attacker can corrupt or overwrite a critical system file — potentially enabling privilege escalation without ever having write permission to `/etc/passwd` directly.

## Key facts
- Symlink attacks are a specific form of **TOCTOU (Time-of-Check to Time-of-Use)** race condition vulnerabilities
- The `/tmp` directory is the most common attack surface because it is world-writable and filenames are often predictable
- Mitigations include using `O_NOFOLLOW` flag when opening files, `mkstemp()` for secure temp file creation, and sticky bits (`chmod +t /tmp`) to prevent deletion of others' files
- Linux kernel feature **protected symlinks** (`/proc/sys/fs/protected_symlinks = 1`) blocks following symlinks in sticky world-writable directories when the owner doesn't match
- Exploitation requires the attacker to have local filesystem access — this is typically a **local privilege escalation** technique, not a remote attack vector

## Related concepts
[[TOCTOU race condition]] [[privilege escalation]] [[file permission vulnerabilities]] [[directory traversal]]