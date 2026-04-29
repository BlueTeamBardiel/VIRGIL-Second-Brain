# Synchronization Primitives

## What it is
Like a bathroom with a single-occupancy sign — only one person holds the key at a time, and everyone else waits in line. Synchronization primitives are low-level mechanisms (mutexes, semaphores, spinlocks, condition variables) that coordinate access to shared resources in concurrent programs, ensuring threads don't simultaneously modify the same data in conflicting ways.

## Why it matters
When synchronization is absent or flawed, race conditions emerge — and attackers exploit them. The classic TOCTOU (Time-of-Check to Time-of-Use) attack abuses the gap between when a program checks a condition (e.g., "does this file belong to the user?") and when it acts on it. By swapping a symlink in that window, an attacker can trick a privileged process into writing to `/etc/passwd` instead of an innocent file — a privilege escalation with no memory corruption required.

## Key facts
- **Mutex (Mutual Exclusion):** Only one thread holds the lock at a time; others block. Failure to release causes deadlock.
- **Semaphore:** A counter-based primitive allowing N threads simultaneous access; binary semaphores behave like mutexes but lack ownership — a different thread can release them, creating security misuse opportunities.
- **Race condition vulnerability:** Occurs when security-relevant behavior depends on the uncontrolled timing of concurrent operations — directly exploitable in TOCTOU attacks.
- **Deadlock vs. Livelock:** Deadlock = threads frozen waiting on each other; Livelock = threads active but making no progress. Both are availability threats (DoS potential).
- **Atomic operations:** CPU-level instructions (e.g., CAS — Compare-And-Swap) that complete without interruption, the hardware foundation underneath all software primitives.

## Related concepts
[[Race Condition]] [[TOCTOU Attack]] [[Privilege Escalation]] [[Concurrency Vulnerabilities]] [[Memory Safety]]