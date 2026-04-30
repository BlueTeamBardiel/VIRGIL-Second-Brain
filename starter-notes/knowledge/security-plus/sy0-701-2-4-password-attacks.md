---
domain: "2.0 - Threats, Vulnerabilities, and Mitigations"
section: "2.4"
tags: [security-plus, sy0-701, domain-2, password-attacks, authentication, threat-analysis]
---

# 2.4 - Password Attacks

Password attacks are adversarial techniques used to compromise user credentials and gain unauthorized access to systems and accounts. This topic covers how attackers target weak password storage mechanisms, exploit authentication processes, and leverage computational resources to crack credentials. Understanding password attack vectors is critical for the Security+ exam because password compromise remains one of the most common entry points for attackers in real-world breaches, and sysadmins must implement controls to defend against them.

---

## Key Concepts

- **Plaintext/Unencrypted Passwords**: Passwords stored in clear text with no [[Encryption]] or [[Hashing]]; anyone with file/database access can immediately read credentials. This represents the worst-case password storage scenario and should never occur in production systems.

- **Hashing**: A one-way cryptographic function that converts a password into a fixed-length "fingerprint" or message digest (e.g., [[SHA-256]]). Hashing is irreversible—you cannot recover the original password from a hash, making it the standard method for secure password storage.

- **Hash Collision**: A scenario where two different inputs produce the same hash output. Cryptographically secure hashing algorithms should have no collisions, ensuring unique fingerprints for unique passwords.

- **Password File/Database**: Operating system and application-level storage of user credentials. Different platforms use different [[Hashing]] algorithms and formats (e.g., Linux `/etc/shadow`, Windows SAM, [[Active Directory]] hashed credentials).

- **Brute Force Attack (Online)**: Repeatedly attempting to log in with different password combinations against an active authentication service. Very slow and typically prevented by account lockout policies after N failed attempts.

- **Brute Force Attack (Offline)**: An attacker obtains a database of usernames and hashes (via breach or compromise), then attempts to compute password hashes locally and compare them to stolen hashes. No lockout mechanisms apply; success depends on computational resources and hash strength.

- **Password Spraying Attack**: A horizontal attack strategy where an attacker tries one or a small set of common passwords (e.g., "password123", "letmein", "admin") across many accounts rather than trying many passwords on a single account. This avoids triggering account lockouts because failed attempts are distributed.

- **Dictionary Attack**: A variant of brute force that uses a pre-compiled list of common words and passwords rather than generating all possible combinations, significantly speeding up the attack.

- **Rainbow Tables**: Pre-computed hash tables mapping common passwords to their hash values, allowing attackers to instantly match a stolen hash without computational overhead (defeated by [[Salting]] and strong hashing).

- **Salting**: Adding random data to a password before hashing, ensuring identical passwords produce different hashes and rendering rainbow tables useless. A critical defense against offline hash attacks.

---

## How It Works (Feynman Analogy)

**The Bank Vault Analogy:**

Imagine a bank stores customer account information in a vault. In the plaintext scenario, the vault door is open and customer passwords are written on cards anyone can read. In the hashing scenario, each password goes through a special one-way shredder: the password is destroyed, but a unique "damage pattern" (the hash) is recorded. To verify a customer's password, you run it through the same shredder and compare the new pattern to the stored one—if they match, the password is correct.

Now, imagine a thief steals the vault records containing damage patterns. A **brute force online attack** is like the thief trying to break into the vault repeatedly with different keys (accounts), but a security guard locks the vault after 5 failed attempts. A **brute force offline attack** is the thief setting up their own shredder at home, running thousands of candidate passwords through it per second, and comparing the results to stolen patterns—no guard to stop them. A **password spray** is the thief trying the same 3 "master keys" (common passwords) on many different vaults, never trying enough keys on one vault to trigger a lockout.

**Technical Reality:** [[Hashing]] prevents plaintext exposure, but weak hashes (MD5, unsalted algorithms) are vulnerable to offline attacks using commodity hardware or GPU clusters. Strong algorithms like [[bcrypt]], [[scrypt]], or [[Argon2]] add intentional computational delay, making brute force exponentially slower.

---

## Exam Tips

- **Distinguish Online vs. Offline Brute Force**: The exam will test your understanding that online attacks are slow and defended by lockout policies, while offline attacks require stolen hashes but have no rate limiting. Know when each applies.

- **Password Spraying is NOT Traditional Brute Force**: A common trap—spraying distributes attack attempts horizontally (many accounts, few passwords) and deliberately avoids account lockout, whereas brute force tries many passwords on one account. The exam may present a scenario and ask you to identify the attack type.

- **Plaintext Passwords Still Appear in Legacy Systems**: While rare, the exam may include questions about identifying plaintext password storage in legacy applications or misconfigured systems. The answer is always "replace the application or implement [[Hashing]]."

- **Hashing ≠ Encryption**: [[Hashing]] is one-way (for password verification), while [[Encryption]] is reversible (for data protection). The exam will test this distinction—never confuse them. Only hashing is appropriate for password storage.

- **Salting and Slow Hashing are Critical Defenses**: Understand that [[Salting]] defeats rainbow tables and that algorithms like [[bcrypt]] add intentional CPU cost, slowing brute force. These are frequently tested as security best practices.

---

## Common Mistakes

- **Confusing Hashing with Encryption**: Candidates often say passwords should be "encrypted" when the correct answer is "hashed." [[Encryption]] implies recovery; [[Hashing]] implies one-way storage. On the exam, eliminate encryption-based answers for password storage questions.

- **Underestimating Offline Attack Speed**: While brute force is "slow," modern GPU clusters can test billions of weak hashes per second. Candidates sometimes assume offline attacks are impractical, missing the importance of strong hashing algorithms and salting. The exam tests whether you understand computational feasibility.

- **Ignoring Account Lockout as a Control**: Some candidates forget that lockout policies are the primary defense against online brute force. When asked what prevents repeated login attempts, "account lockout after N failures" is often the correct answer—not password complexity alone.

---

## Real-World Application

In your [YOUR-LAB] homelab, [[Active Directory]] should be configured with account lockout policies (e.g., 5 failed attempts = 30-minute lockout) to defend against online brute force on domain accounts. Simultaneously, [[Wazuh]] should monitor failed authentication attempts and alert on patterns consistent with spraying attacks (many failed logins from a single source across different accounts). If a password database is ever compromised, weak hashing would expose the entire fleet; implementing [[bcrypt]] or [[Argon2]] with proper salting ensures that stolen hashes remain computationally infeasible to crack, even if attackers obtain them.

---

## [[Wiki Links]]

**Core Security Concepts:**
- [[CIA Triad]] — password attacks compromise confidentiality
- [[Authentication]] — password verification is the primary authentication mechanism
- [[Hashing]] — cryptographic one-way function for secure password storage
- [[SHA-256]] — common hashing algorithm, though not ideal for passwords
- [[Encryption]] — distinct from hashing; used for data protection, not password storage
- [[Salting]] — random data added to passwords before hashing
- [[bcrypt]] — slow, salted hashing algorithm designed for passwords
- [[scrypt]] — key derivation function resistant to brute force
- [[Argon2]] — modern password hashing algorithm with memory hardness
- [[Rainbow Tables]] — pre-computed hash lookup tables (defeated by salting)
- [[MFA]] — multi-factor authentication; reduces impact of password compromise

**Attack Types:**
- [[Brute Force Attack]] — exhaustive password guessing
- [[Dictionary Attack]] — password guessing using word lists
- [[Password Spraying]] — distributed horizontal attack using common passwords
- [[Credential Stuffing]] — using leaked passwords from other breaches

**Systems & Platforms:**
- [[Active Directory]] — Windows domain credential storage and authentication
- [[LDAP]] — directory service authentication protocol
- [[SAM]] — Windows Security Accounts Manager database
- [[Wazuh]] — SIEM for monitoring failed authentication attempts
- [[SIEM]] — log aggregation and alerting for security events

**Related Threat Topics:**
- [[Phishing]] — often precedes credential compromise
- [[Man-in-the-Middle (MITM)]] — can intercept plaintext passwords
- [[Malware]] — credential-stealing malware (e.g., keyloggers, info-stealers)
- [[Incident Response]] — procedures for password compromise
- [[Forensics]] — analyzing password breach evidence

**Operational Security:**
- [[Zero Trust]] — assumes password compromise; requires additional verification
- [[Principle of Least Privilege]] — limits damage if a password is compromised
- [[Account Lockout Policy]] — blocks repeated login attempts
- [[Password Policy]] — enforces complexity and rotation requirements

---

## Tags

#domain-2 #security-plus #sy0-701 #password-attacks #authentication #threat-vector #offline-attack #online-attack #hashing #credential-protection

---
_Ingested: 2026-04-15 23:48 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
