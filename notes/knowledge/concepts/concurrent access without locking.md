# concurrent access without locking

## What it is
Imagine two bank tellers simultaneously reading the same account balance ($500), each approving a $400 withdrawal, and both writing back $100 — the bank just lost $300 that never existed. Concurrent access without locking (a **race condition**) occurs when multiple threads or processes read and modify shared resources simultaneously without synchronization controls, allowing interleaved execution to corrupt state or bypass logic. The window between a check and its corresponding action is called the **TOCTOU** (Time-of-Check to Time-of-Use) interval.

## Why it matters
The classic attack: a privilege escalation exploit replaces a temp file with a symlink to `/etc/shadow` *after* a setuid program checks the file is safe but *before* it opens and writes to it. The program, running as root, now writes attacker-controlled data to the shadow password file. This TOCTOU race has been weaponized in real Linux privilege escalation CVEs, including vulnerabilities in `sudo` and `pkexec`.

## Key facts
- **TOCTOU** is the most exam-tested form: the state checked is not the state used when the action executes
- Race conditions are a subclass of **CWE-362** (Concurrent Execution Using Shared Resource with Improper Synchronization)
- Mitigations include **mutexes/semaphores**, atomic operations, and opening files with `O_CREAT | O_EXCL` flags to prevent symlink substitution
- Race conditions can bypass **access controls** — an attacker doesn't break the lock, they slip through before it's applied
- Difficult to detect in static analysis alone; **dynamic analysis** and fuzzing tools (e.g., ThreadSanitizer) are used to expose timing windows

## Related concepts
[[TOCTOU vulnerability]] [[privilege escalation]] [[symlink attack]] [[mutex and semaphore]] [[CWE common weakness enumeration]]