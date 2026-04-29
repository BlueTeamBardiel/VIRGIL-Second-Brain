# Atomic Operations

## What it is
Like a bank vault door that can only be fully open or fully closed — never halfway — an atomic operation is one that completes entirely or not at all, with no observable intermediate state. In computing, it's an indivisible unit of work that executes without interruption, ensuring shared resources are never seen in a partially-modified state by concurrent threads or processes.

## Why it matters
Time-of-Check to Time-of-Use (TOCTOU) race conditions exploit the gap between when a program checks a condition and when it acts on it. In a classic attack, malware swaps a benign file for a malicious one in that tiny window — a vulnerability that atomic file operations (using OS-level syscalls like `rename()`) directly prevent by collapsing check and action into one uninterruptible step.

## Key facts
- **TOCTOU attacks** are the primary threat atomic operations defend against; they appear in privilege escalation exploits targeting setuid programs
- The x86 `LOCK` prefix (e.g., `LOCK XCHG`) makes CPU instructions atomic at the hardware level, preventing race conditions in multi-core systems
- **Mutex (mutual exclusion)** locks simulate atomicity at the software level — failure to use them correctly causes data races, a CWE-362 vulnerability
- Atomic operations are the foundation of thread-safe programming; many CVEs in web servers (Apache, nginx) stem from non-atomic counter or flag updates
- Databases use atomic transactions (the "A" in ACID) to prevent partial writes — a failed transaction must roll back completely, preventing exploitable inconsistent states

## Related concepts
[[Race Conditions]] [[TOCTOU Vulnerability]] [[Mutex and Semaphores]] [[Concurrency Attacks]] [[Privilege Escalation]]