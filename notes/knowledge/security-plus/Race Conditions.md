# Race Conditions

## What it is

In Stardew Valley, you walk into Pierre's shop at exactly 9:00 AM as he's flipping the "Open" sign. For one frame, the shop counter is interactable but Pierre's inventory hasn't loaded — click in that gap and the game gets confused about what state the shop is in. That's exactly what a race condition is — two operations happen in an order the developer didn't expect, and the system briefly holds an inconsistent view of reality.

A **race condition** is a software flaw where the security or correctness of an operation depends on the timing or sequence of multiple concurrent processes accessing shared resources, allowing an attacker to exploit the gap between *check* and *use*.

## Why it matters

Race conditions enable privilege escalation, authentication bypass, and double-spend attacks — the Dirty COW (CVE-2016-5195) Linux kernel flaw and countless web banking "transfer twice before balance updates" exploits live here. SY0-701 Objective 2.3 lists race conditions explicitly under application vulnerabilities, with **TOCTOU (Time-of-Check to Time-of-Use)** as the named subtype you must recognize. The CompTIA trap: they'll describe a scenario where a file's permissions are validated, then the file is opened a moment later — and offer "buffer overflow" or "improper input validation" as distractors. The answer is TOCTOU. Always.

## Key facts

### The two flavors

| Type | What happens | Example |
|---|---|---|
| **TOCTOU** | Resource state changes between validation and use | Check file permissions → attacker swaps file via symlink → privileged process opens attacker's file |
| **Concurrency race** | Two threads modify shared data without locking | Two withdrawals read balance=$100 simultaneously, both succeed, balance goes to -$100 |

### Attack mechanics

- **[[TOCTOU]]** — the canonical race condition exam term. *Time-of-Check to Time-of-Use.*
- **[[Symbolic link attack]]** — classic TOCTOU vector on Unix systems; swap a file for a symlink during the check-use window.
- **[[Double-fetch vulnerability]]** — kernel reads user-space memory twice; attacker changes it between reads.
- **[[Double-spend attack]]** — financial/blockchain variant; same funds spent in parallel transactions.
- **Window of opportunity** — usually milliseconds to microseconds; attackers use automation and CPU contention to widen it.

### Defenses

| Defense | How it works |
|---|---|
| **[[Mutex]] / [[Semaphore]]** | Lock the resource so only one thread accesses it at a time |
| **[[Atomic operations]]** | Combine check-and-act into a single uninterruptible CPU instruction |
| **File descriptors over paths** | Operate on an opened handle, not a re-resolvable filename |
| **Database transactions** | ACID guarantees with row-level locking and isolation levels |
| **[[Idempotency keys]]** | Web APIs reject duplicate requests with the same key |

### Real-world cases

- **[[Dirty COW]]** (CVE-2016-5195) — Linux kernel race in copy-on-write memory; local privilege escalation, unpatched for nine years.
- **Meltdown / Spectre** — speculative execution races leaking memory across security boundaries.
- **Starbucks gift card double-load** (2015) — concurrent transfers between two cards generated free balance.

### Exam shortcuts

- See "check ... then use" → **TOCTOU**.
- See "two threads, shared variable, inconsistent result" → **race condition / concurrency flaw**.
- Defense answer is almost always **locking**, **atomic operations**, or **proper synchronization**.

## Related concepts

[[TOCTOU]] · [[Concurrency]] · [[Memory injection]] · [[Buffer overflow]] · [[Privilege escalation]] · [[Dirty COW]] · [[Mutex]] · [[Atomic operations]] · [[Secure coding practices]]

---
*Source: VIRGIL knowledge base — 2026-05-08*