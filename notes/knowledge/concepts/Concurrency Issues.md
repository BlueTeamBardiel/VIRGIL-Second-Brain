# Concurrency Issues

## What it is
Imagine two bank tellers simultaneously reading the same account balance of $100, each processing a $80 withdrawal before either updates the ledger — suddenly $160 has left a $100 account. Concurrency issues occur when multiple processes or threads access shared resources simultaneously without proper synchronization, producing unpredictable, exploitable outcomes. The most dangerous variant is the **race condition**, where the security outcome depends on the precise timing of competing operations.

## Why it matters
The classic TOCTOU (Time-of-Check to Time-of-Use) attack exploits the gap between when a program checks a condition (e.g., "does this user have permission?") and when it acts on that check. An attacker can swap a legitimate file for a malicious one in that tiny window — this exact technique has been used to escalate privileges in Unix systems by replacing symlink targets between a permission check and a file write operation.

## Key facts
- **TOCTOU (Time-of-Check to Time-of-Use)** is the primary exam-tested concurrency vulnerability — know the name and the gap it exploits
- Race conditions in privileged processes are a common **local privilege escalation** vector on both Linux and Windows systems
- **Mutex (mutual exclusion locks)** and **semaphores** are the standard developer controls to prevent concurrent access conflicts
- Dirty COW (CVE-2016-5195) is a landmark real-world race condition that allowed unprivileged users to gain root on Linux — referenced frequently in security literature
- Concurrency bugs are classified under **CWE-362** (Race Condition) and are distinct from memory corruption bugs, though both stem from unsafe resource handling

## Related concepts
[[Race Conditions]] [[Privilege Escalation]] [[Time-of-Check to Time-of-Use]] [[Memory Safety]] [[Input Validation]]