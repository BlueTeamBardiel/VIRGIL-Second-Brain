# file locking

## What it is
Like a bathroom stall latch — only one person can use it at a time, and others must wait their turn. File locking is a mechanism that restricts concurrent access to a file, ensuring that only one process (or one authorized user) can read or write to it at a given moment to prevent data corruption or race conditions.

## Why it matters
TOCTOU (Time-of-Check to Time-of-Use) attacks exploit the gap between when a program checks a file's status and when it actually uses it — and improper file locking is exactly what makes this window exploitable. A classic example: a privileged process checks that `/tmp/datafile` is safe, then an attacker swaps it with a symlink to `/etc/shadow` before the process writes to it. Proper advisory or mandatory locking closes that window.

## Key facts
- **Advisory locking** (e.g., POSIX `flock()`) only works if all cooperating processes voluntarily check for locks — a malicious process can ignore it entirely.
- **Mandatory locking** is enforced by the kernel regardless of whether the process checks — far stronger but less commonly implemented (Linux supports it only with specific mount options).
- TOCTOU race conditions are classified under **CWE-367** and are directly enabled by missing or inadequate file locking.
- On Windows, files are locked **by default** when opened (opportunistic locking / oplocks), whereas Unix/Linux systems default to **no locking** — a key behavioral difference relevant to cross-platform security.
- Improper file locking in setuid programs is a common privilege escalation vector, because the elevated process can be manipulated into acting on attacker-controlled files.

## Related concepts
[[TOCTOU race condition]] [[symlink attacks]] [[privilege escalation]] [[access control]]