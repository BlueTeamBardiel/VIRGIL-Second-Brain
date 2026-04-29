# Race Condition Attacks

## What it is
Imagine two bank tellers both processing your withdrawal simultaneously — each checks your balance, sees $500, and hands you cash before the other's transaction posts, netting you $1000 from a $500 account. A race condition attack exploits the gap between when a system *checks* a condition and when it *acts* on it (TOCTOU: Time-of-Check to Time-of-Use). An attacker manipulates shared resources or timing windows to force unintended behavior before the system can enforce its intended logic.

## Why it matters
The 2018 Dirty COW (CVE-2016-5195) Linux kernel vulnerability is a textbook race condition — attackers exploited a race in the copy-on-write memory mechanism to write to read-only root-owned files, achieving local privilege escalation on millions of Android and Linux systems. It was exploitable with a small C program and required no special privileges, making it devastatingly accessible.

## Key facts
- **TOCTOU** is the canonical race condition subtype: the state changes between the security check and the operation that depends on it
- Race conditions are classified as **CWE-362** (Concurrent Execution Using Shared Resource with Improper Synchronization)
- Common targets: file system operations, session tokens, database transactions, and multi-threaded authentication routines
- Mitigations include **mutex locks**, **atomic operations**, and **semaphores** to enforce exclusive resource access
- In web contexts, race conditions can bypass rate-limiting or duplicate financial transactions (e.g., withdrawing the same funds twice in parallel requests)

## Related concepts
[[TOCTOU Vulnerability]] [[Privilege Escalation]] [[Mutex and Synchronization]] [[Insecure Concurrency]] [[Memory Corruption]]