# transaction

## What it is
Like a vending machine that either gives you the snack AND takes your money, or does neither — a transaction is an all-or-nothing unit of work. Precisely, it's a sequence of database operations treated as a single atomic unit, governed by ACID properties (Atomicity, Consistency, Isolation, Durability) to ensure data integrity even when failures occur.

## Why it matters
SQL injection attacks frequently exploit transaction mechanics — an attacker can craft malicious input that piggybacks unauthorized operations onto a legitimate transaction, or force a rollback that leaves the system in an exploitable intermediate state. In financial systems, a failed transaction that debits an account without crediting the destination can also be weaponized through race conditions (TOCTOU attacks), where an attacker manipulates system state between the "check" and the "act" steps.

## Key facts
- **ACID** stands for Atomicity, Consistency, Isolation, Durability — the four guarantees a proper transaction must provide
- **Atomicity** means the entire transaction succeeds or the entire thing rolls back — no partial writes
- **Isolation** prevents concurrent transactions from reading each other's uncommitted data, mitigating race conditions
- **TOCTOU (Time-of-Check to Time-of-Use)** attacks exploit the gap between transaction validation and execution
- Database transaction logs are critical forensic artifacts — they record every committed and rolled-back operation, making them essential for incident response and audit trails
- Improper transaction handling (missing rollback on error) can cause data inconsistency that masks unauthorized modifications

## Related concepts
[[SQL injection]] [[TOCTOU]] [[ACID properties]] [[race condition]] [[database security]]