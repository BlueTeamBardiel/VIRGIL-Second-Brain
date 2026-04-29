# race condition

## What it is
Imagine two bank tellers simultaneously processing the same withdrawal slip before either updates the balance — both approve it, and you double your money. A race condition occurs when a system's behavior depends on the sequence or timing of uncontrollable events, and an attacker manipulates that timing window to cause unintended behavior. In software, this typically means two processes access or modify shared resources concurrently without proper synchronization.

## Why it matters
The classic TOCTOU (Time-of-Check to Time-of-Use) attack exploits race conditions in file operations: an attacker swaps a benign file for a malicious one in the microseconds between when a privileged process checks permissions and when it actually opens the file. This technique has been used to escalate privileges on Unix systems by replacing a checked symlink with one pointing to `/etc/passwd`. Defenses include atomic operations, file locking mechanisms, and avoiding reliance on file metadata checks before use.

## Key facts
- **TOCTOU** (Time-of-Check to Time-of-Use) is the canonical race condition attack pattern, explicitly tested on Security+ and CySA+
- Race conditions in web applications can allow double-spending attacks (e.g., redeeming a coupon twice simultaneously)
- Mutexes (mutual exclusion locks) and semaphores are the primary software controls to prevent concurrent access conflicts
- The 2016 Dirty COW vulnerability (CVE-2016-5195) was a Linux kernel race condition that allowed local privilege escalation — one of the most severe examples in history
- Race conditions are classified under **CWE-362** (Concurrent Execution Using Shared Resource with Improper Synchronization)

## Related concepts
[[TOCTOU]] [[privilege escalation]] [[mutex]] [[buffer overflow]] [[input validation]]