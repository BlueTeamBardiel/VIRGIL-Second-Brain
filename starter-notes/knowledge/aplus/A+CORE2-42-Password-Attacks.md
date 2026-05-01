---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 42
source: rewritten
---

# Password Attacks
**Protecting credential storage is foundational to system security, and understanding attack vectors helps you defend against unauthorized access.**

---

## Overview

Every system needs a way to verify that users are who they claim to be, and that verification relies on protecting login credentials—especially passwords. On the A+ exam, you need to understand how attackers target passwords and why proper storage methods matter. The difference between a poorly secured system and a hardened one often comes down to how (or whether) passwords are encrypted and hashed.

---

## Key Concepts

### Plaintext Password Storage

**Analogy**: Imagine storing the master keys to your house in a glass cabinet in your front yard—anyone walking by can see them and grab what they need. That's what plaintext password storage does: it leaves credentials completely visible and grabbable.

**Definition**: [[Plaintext]] refers to passwords and credentials stored in human-readable format with no encryption or [[Hashing|hashing]]. If an attacker accesses the file, they immediately have every username and password.

**Why This Fails**:
- Single file compromise = total credential loss
- No computational barrier to reading data
- Violates basic [[Security Principle|security principles]]

---

### Hashing: The Defense Layer

**Analogy**: Think of hashing like a fingerprint scanner at a bank. Your actual fingerprint never gets stored—only a unique mathematical summary that can't be reversed. If someone steals the summary, it's useless without your actual finger.

**Definition**: [[Hashing]] transforms passwords into fixed-length strings (called [[Message Digest|message digests]] or fingerprints) using one-way mathematical algorithms. The hash cannot be reversed to reveal the original password.

| Aspect | Plaintext | Hashed |
|--------|-----------|--------|
| Readability | Instant | Impossible |
| Reversal | N/A | One-way only |
| Breach Impact | Catastrophic | Mitigated |
| Storage Method | Direct copy | Algorithm output |

**Common Hashing Algorithms**:
- [[MD5]] (legacy, not recommended)
- [[SHA-1]] (legacy, deprecated)
- [[SHA-256]] (modern standard)
- [[bcrypt]] (password-specific, with salt)

---

### Rainbow Tables & Dictionary Attacks

**Analogy**: Instead of cracking a safe yourself, you buy a pre-made catalog of thousands of safes that have already been cracked. You flip through until you find a match.

**Definition**: [[Rainbow Table|Rainbow tables]] are pre-computed databases of password hashes paired with their plaintext values. An attacker compares stolen hashes against the table to find matches instantly—bypassing the need to crack anything.

**Defense**: [[Salt|Salting]] adds random data to each password before hashing, making pre-computed tables useless.

---

### Brute Force & Dictionary Attacks

**Analogy**: One person tries every combination on a lock (brute force). Another person tries only common key cuts they've seen before (dictionary).

**Definition**: 
- [[Brute Force Attack]]: Systematically trying every possible password combination
- [[Dictionary Attack]]: Trying only common passwords from wordlists

**Computational Reality**:
```
8-character lowercase password: ~208 billion combinations
With modern GPU: cracked in hours
Salted bcrypt hash: significantly delayed due to intentional slowness
```

---

### Credential Compromise Routes

**Definition**: Attackers target passwords through:
- [[Database Breach|Database breaches]] (stolen hash files)
- [[Phishing]] (tricking users into revealing passwords)
- [[Keylogger|Keylogging]] (capturing what users type)
- [[Man-in-the-Middle Attack|MITM attacks]] (intercepting unencrypted traffic)

---

## Exam Tips

### Question Type 1: Password Storage Vulnerability
- *"A company discovers an application stores all user passwords in a single readable text file. What is the PRIMARY security risk?"* → Complete credential loss upon file discovery; no computational barrier to attackers
- **Trick**: Exam may ask "which is LEAST secure" and list plaintext alongside weak hashing—plaintext is always worse

### Question Type 2: Hash vs. Encryption
- *"Which process creates a one-way mathematical representation of a password?"* → [[Hashing]] (NOT [[Encryption]], which is reversible)
- **Trick**: "Encrypted passwords" suggests reversibility—hashing is the one-way function for storage

### Question Type 3: Defending Against Precomputed Tables
- *"Rainbow tables are defeated by using what security measure?"* → [[Salt|Salting]] (random data added to each password before hashing)
- **Trick**: Students confuse salt with pepper—salt is random per-user, pepper is a secret application-wide constant

### Question Type 4: Attack Speed & Algorithm Choice
- *"Why is bcrypt preferred over SHA-256 for password hashing?"* → bcrypt includes intentional computational delay (configurable rounds), making brute force exponentially slower
- **Trick**: "Faster hashing" is NOT better for passwords; intentional slowness is a feature

---

## Common Mistakes

### Mistake 1: Confusing Hashing with Encryption
**Wrong**: "We encrypted all passwords so they can't be stolen"
**Right**: Passwords should be hashed (one-way), not encrypted (two-way). Encryption is reversible if the key is compromised.
**Impact on Exam**: Core distinction on Core 2—multiple questions test this conceptually

### Mistake 2: Assuming All Hashes Are Equal
**Wrong**: "We use SHA-256, so our passwords are safe from brute force"
**Right**: Raw SHA-256 is fast to compute (bad for passwords). Bcrypt, scrypt, and Argon2 intentionally slow down the process, defeating attackers.
**Impact on Exam**: Questions about "modern password hashing" expect knowledge that speed matters—slower is better for this use case

### Mistake 3: Believing Salting Encrypts Passwords
**Wrong**: "We salt passwords so attackers can't see them"
**Right**: Salt prevents rainbow table attacks but doesn't stop brute force. Salt + slow hash + strong password = proper defense layering.
**Impact on Exam**: Salting is a specific countermeasure; don't overstate its capabilities

### Mistake 4: Overlooking Plaintext in Logs & Memory
**Wrong**: "Only our database stores passwords, so we're safe"
**Right**: Passwords can leak through unencrypted logs, memory dumps, network traffic, and backup files
**Impact on Exam**: A+ expects end-to-end thinking—storage is one piece of a larger security posture

---

## Related Topics
- [[Authentication]]
- [[Encryption]]
- [[Access Control]]
- [[Data Protection]]
- [[Security Best Practices]]
- [[Vulnerability Assessment]]
- [[Incident Response]]

---

*Source: Rewritten from CompTIA A+ Core 2 (220-1202) | [[A+]] | VIRGIL Study Companion*