# Password Attacks

## What it is

In Helldivers 2, when you encounter a Hellbomb terminal, you have to input the directional code — Up, Down, Left, Right — under fire from a horde of Terminids. A bot scripted to hammer every possible four-arrow combination until the bomb arms would be the gaming equivalent of a password attack. That's exactly what password attacks do — automated guessing, theft, or cracking of credentials to authenticate as someone who isn't you.

**Password attacks** are techniques that compromise authentication credentials through online guessing, offline hash cracking, theft, or human manipulation, thereby defeating the "something you know" factor.

## Why it matters

Stolen and cracked credentials remain the leading initial access vector for breaches — Verizon DBIR puts them in roughly half of all confirmed intrusions. A successful password attack collapses confidentiality, enables lateral movement, and torches compliance regimes (PCI DSS 8.x, NIST 800-63B). For SY0-701, **Objective 2.4** explicitly lists *password attacks* under "Indicators of malicious activity" — expect questions distinguishing **spraying** from **brute force** from **dictionary** from **rainbow table**. CompTIA's favorite trap: confusing **spraying** (one password, many accounts — defeats lockout) with **brute force** (one account, many passwords — triggers lockout).

## Key facts

### Online attacks (against a live system)

| Attack | Mechanic | Detection signal |
|---|---|---|
| [[Brute Force]] | Try every password against one account | Repeated failed logins on single account → lockout |
| [[Password Spraying]] | One common password against many accounts | Single failure on many accounts in short window |
| [[Dictionary Attack]] | Wordlist of likely passwords (rockyou.txt, etc.) | Failed logins matching common-password patterns |
| [[Credential Stuffing]] | Reuse breached username/password pairs from other sites | Login attempts from unusual geos using valid-looking creds |

### Offline attacks (against a stolen hash)

- **[[Hash Cracking]]** — attacker has obtained password hashes (e.g., from `/etc/shadow`, NTDS.dit, SAM) and computes guesses locally. No lockout applies.
- **[[Rainbow Table]]** — precomputed hash→plaintext lookup tables. Defeated by **[[Salting]]** (per-user random value added before hashing).
- **[[Hashcat]]** and **[[John the Ripper]]** — the standard tools. GPU-accelerated; modern rigs do billions of MD5 guesses per second.

### Theft and bypass

- **[[Phishing]]** / **[[Spear Phishing]]** — harvest creds via fake login pages.
- **[[Keylogger]]** — capture keystrokes at endpoint.
- **[[Pass-the-Hash]]** — authenticate using the hash itself, no plaintext needed (NTLM weakness).
- **[[Shoulder Surfing]]** — yes, CompTIA still asks about this.

### Defenses (know these cold)

| Defense | What it stops |
|---|---|
| **[[Multifactor Authentication]] (MFA)** | Most online attacks even with valid password |
| **[[Account Lockout]]** policy | Brute force (not spraying) |
| **[[Password Complexity]]** + length | Dictionary, brute force time-cost |
| **[[Salting]]** | Rainbow tables, hash precomputation |
| **[[Key Stretching]]** (bcrypt, scrypt, Argon2, PBKDF2) | Offline cracking speed |
| **[[Password Manager]]** | Reuse → credential stuffing |
| **[[Conditional Access]]** / impossible-travel detection | Credential stuffing from foreign IPs |
| **[[Passkeys]]** / FIDO2 | Phishing entirely (no shared secret to steal) |

### NIST 800-63B current guidance (exam-relevant)

- Minimum 8 characters, support up to 64+.
- **No** mandatory periodic rotation unless compromise suspected.
- **No** composition rules (the "1 uppercase, 1 symbol" theater).
- Screen against known-breached password lists.
- Allow paste into password fields (helps password managers).

## Related concepts

[[Authentication]] · [[Hashing]] · [[Multifactor Authentication]] · [[Kerberoasting]] · [[Credential Harvesting]] · [[Identity and Access Management]] · [[Privileged Access Management]]

---
*Source: VIRGIL knowledge base — 2026-05-08*