# password policy

## What it is
Like a bouncer with a checklist — minimum height, no sneakers, must show ID — a password policy defines the exact rules a password must satisfy before the system lets it through the door. It is an administrative or technical control that enforces password complexity, length, expiration, reuse restrictions, and account lockout thresholds across an organization. These rules are codified in Group Policy (Windows), PAM modules (Linux), or identity provider settings.

## Why it matters
In the 2012 LinkedIn breach, attackers cracked millions of SHA-1 hashed passwords quickly because users had short, simple passwords — a direct consequence of no enforced complexity requirements. A policy mandating a minimum of 12 characters and prohibiting dictionary words would have dramatically increased attacker effort and time. NIST SP 800-63B later revised guidance, prioritizing length and breach-list checking over forced complexity and arbitrary rotation.

## Key facts
- **NIST SP 800-63B** recommends passwords of at least 8 characters (12+ preferred), no mandatory periodic rotation unless compromise is suspected — a major shift from legacy advice.
- **Account lockout policy** (e.g., 5 failed attempts → 30-minute lockout) mitigates online brute-force and password spraying attacks.
- **Password history enforcement** (e.g., remember last 10 passwords) prevents users from cycling back to a compromised credential immediately.
- **Complexity requirements** (uppercase, number, symbol) are still common on Security+ exams but are now considered secondary to length per current NIST guidance.
- **Password managers** are the NIST-recommended solution to support long, unique passwords without user memory burden — policies should not punish paste functionality.

## Related concepts
[[multi-factor authentication]] [[credential stuffing]] [[account lockout policy]] [[password spraying]] [[NIST SP 800-63B]]