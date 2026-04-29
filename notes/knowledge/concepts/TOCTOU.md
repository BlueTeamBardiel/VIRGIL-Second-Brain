# TOCTOU

## What it is
Imagine you check that a seat is empty, turn around to grab your coat, and when you sit down someone else has taken it — that gap between checking and acting is the vulnerability. Time-of-Check to Time-of-Use (TOCTOU) is a race condition attack where an attacker modifies a resource *after* it has been validated but *before* it is actually used, causing the system to operate on different data than it authorized.

## Why it matters
A classic exploit targets Unix `access()` followed by `open()`: a program checks if a user has permission to read `/tmp/file`, then the attacker swaps `/tmp/file` for a symlink pointing to `/etc/shadow` before `open()` executes — the program then reads the privileged file with its elevated permissions. This class of vulnerability led to real privilege escalation exploits in Linux kernels and macOS installers.

## Key facts
- TOCTOU is a subcategory of **race condition** vulnerabilities, which fall under the broader class of concurrency flaws
- The attack window is called the **"race window"** — attackers must win the race between check and use, often requiring repeated attempts
- Common in **setuid programs**, file system operations, and multi-threaded applications where shared state exists
- **Mitigations** include atomic operations, using file descriptors instead of filenames after validation, and `O_NOFOLLOW` flags to prevent symlink attacks
- On Security+/CySA+, TOCTOU appears under **application vulnerabilities** and is associated with improper input validation and insecure coding practices

## Related concepts
[[Race Condition]] [[Privilege Escalation]] [[Symlink Attack]] [[Concurrency Vulnerabilities]]