# Password Security

## What it is

In Tetris, you can survive forever with a clean stack and good piece placement, but stack one S-piece wrong and you've buried a hole that will haunt you twenty pieces later until the screen tops out. That's exactly what password security does — every weak credential is a buried hole, invisible until the attacker drops the right block and the whole tower collapses.

**Password security** is the set of policies, controls, and cryptographic protections that govern how authentication secrets are created, stored, transmitted, rotated, and verified to prevent unauthorized account access.

## Why it matters

Compromised credentials remain the leading initial access vector in breach reports — phishing harvests them, dumps leak them, and weak hashes surrender them to GPU cracking rigs. SY0-701 Objective 4.6 ("Implement and maintain identity and access management") expects you to know password complexity, length, reuse, age, hashing, and managers as distinct controls. CompTIA's favorite trap: presenting **complexity** and **length** as interchangeable when length is mathematically the dominant factor, and confusing **hashing** (one-way) with **encryption** (reversible).

## Key facts

### Password composition controls

| Control | What it does | SY0-701 nuance |
|---|---|---|
| **[[Length]]** | Minimum character count | NIST SP 800-63B prefers length over complexity; 14+ for privileged accounts |
| **[[Complexity]]** | Required character classes (upper/lower/digit/symbol) | Diminishing returns; encourages predictable substitutions (P@ssw0rd) |
| **[[Password reuse]]** | History depth preventing recycling | Typical: last 5–24 passwords blocked |
| **[[Password age]]** | Maximum/minimum lifetime | Modern guidance: rotate only on suspected compromise, not arbitrary schedule |
| **[[Password expiration]]** | Forced change interval | Legacy 90-day rotation now considered counterproductive |

### Storage protections

- **[[Hashing]]** — one-way function; password is never stored, only its digest. Verification re-hashes input and compares.
- **[[Salting]]** — unique random value appended per-password before hashing; defeats **[[rainbow table]]** attacks.
- **[[Key stretching]]** — deliberately slow hash functions ([[bcrypt]], [[scrypt]], [[Argon2]], [[PBKDF2]]) that make brute-force economically painful.
- **[[Pepper]]** — a secret value stored separately (e.g., in an HSM) added to all hashes; if the database leaks, the pepper doesn't.

### Attacks against passwords

| Attack | Mechanism | Defense |
|---|---|---|
| **[[Brute force]]** | Try every combination | Length + key stretching + lockout |
| **[[Dictionary attack]]** | Try common words/phrases | Block common passwords, require length |
| **[[Password spraying]]** | One common password against many accounts | MFA, anomaly detection, lockout per-source |
| **[[Credential stuffing]]** | Reuse leaked username/password pairs | MFA, breach-corpus checking (HIBP-style) |
| **[[Rainbow table]]** | Precomputed hash lookups | Salting |
| **[[Phishing]]** | Trick user into typing it in | Phish-resistant MFA (FIDO2), training |
| **[[Shoulder surfing]]** | Watch them type it | Masked input, privacy screens |

### Defensive layers beyond the password itself

- **[[Multifactor authentication]] (MFA)** — adds something you have/are/do/are-located. Single most effective control against credential theft.
- **[[Password manager]]** — generates and stores unique high-entropy passwords; eliminates reuse. Local vaults vs. cloud-synced is an exam distinction.
- **[[Account lockout]]** — threshold of failed attempts triggers temporary or permanent lock. Tradeoff: lockout itself becomes a [[denial of service]] vector.
- **[[Passwordless authentication]]** — [[FIDO2]], [[passkeys]], certificate-based auth eliminate the shared secret entirely.
- **[[Single sign-on]] (SSO)** — fewer passwords to manage, but the one master credential becomes catastrophic if breached.

### What CompTIA wants you to recognize

- **Hashing ≠ encryption.** Hashing is one-way; encryption is reversible with a key.
- **Salt is per-password, pepper is system-wide and secret.**
- **MFA defeats credential stuffing and spraying** even if the password is known.
- **Long passphrases beat short complex passwords** in entropy and memorability.
- **Default credentials** on devices are an Objective 4.6 staple — change them immediately.

## Related concepts

[[Multifactor authentication]] · [[Hashing]] · [[Salting]] · [[Key stretching]] · [[Credential stuffing]] · [[Password spraying]] · [[Rainbow table]] · [[Password manager]] · [[FIDO2]] · [[Passkeys]] · [[Single sign-on]] · [[Account lockout]] · [[Default credentials]]

---
*Source: VIRGIL knowledge base — 2026-05-08*