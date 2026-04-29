# semaphores

## What it is
Like a traffic light controlling access to a one-lane bridge — only a fixed number of cars can cross at once, and everyone else waits. A semaphore is a synchronization primitive that controls how many threads or processes can simultaneously access a shared resource, using a counter that increments on release and decrements on acquire.

## Why it matters
Improper semaphore implementation is a classic root cause of race conditions and TOCTOU (Time-of-Check to Time-of-Use) vulnerabilities. An attacker who can manipulate the timing between a permission check and resource access — exploiting the window when a semaphore isn't properly held — can escalate privileges or corrupt data. The 1988 Morris Worm famously exploited timing flaws in Unix daemons rooted in similar concurrency logic.

## Key facts
- A **binary semaphore** (0 or 1) behaves like a mutex — only one thread enters at a time; a **counting semaphore** allows N concurrent accessors
- Failure to release a semaphore causes **deadlock**; a process holds the lock and never lets go, starving all waiters
- **Semaphore abuse** is a known privilege escalation vector — if a low-privilege process can signal a semaphore watched by a high-privilege process, it may trigger unintended behavior
- Unlike mutexes, semaphores have **no ownership concept** — any thread can signal (release) one, making them vulnerable to spoofing if not carefully designed
- Named semaphores persist in the OS and can be targeted by attackers who enumerate `/dev/shm` or similar IPC namespaces on Linux

## Related concepts
[[race condition]] [[mutex]] [[TOCTOU vulnerability]]