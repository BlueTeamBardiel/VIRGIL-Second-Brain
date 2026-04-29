# Concurrency

## What it is
Imagine two cashiers simultaneously reaching into the same cash drawer — each checks the balance, sees $100, and both authorize a $90 withdrawal, leaving the drawer $80 in the hole. Concurrency is the condition where multiple processes or threads access shared resources simultaneously, and without proper controls, the ordering of operations becomes unpredictable. In computing, this creates **race conditions** — exploitable windows where an attacker can slip between the "check" and the "use" of a resource.

## Why it matters
The classic **TOCTOU (Time-of-Check to Time-of-Use)** attack exploits concurrency directly: an attacker replaces a legitimate file with a malicious symlink in the milliseconds between when a privileged process checks the file's safety and when it actually opens it. This technique has been used to escalate privileges on Linux systems by targeting `sudo` and `setuid` binaries. Proper file locking, atomic operations, and randomized delays are defensive mitigations.

## Key facts
- **Race condition** is the primary security vulnerability arising from improper concurrency control
- **TOCTOU** (Time-of-Check Time-of-Use) is the canonical concurrency attack pattern — appears on Security+
- **Mutex (mutual exclusion locks)** are the standard defense: only one thread can hold the lock and access the resource at a time
- **Deadlock** occurs when two threads each hold a lock the other needs — a denial-of-service risk in itself
- Concurrency bugs are notoriously hard to reproduce because they depend on precise timing, making them difficult to detect in code review and testing
- Thread-safe programming and **atomic operations** prevent race conditions at the CPU instruction level

## Related concepts
[[Race Condition]] [[TOCTOU]] [[Privilege Escalation]] [[Mutex]] [[Buffer Overflow]]