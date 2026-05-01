---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 098
source: rewritten
---

# Multifactor Authentication
**Combining multiple independent verification methods dramatically strengthens account security beyond single passwords.**

---

## Overview
Multifactor authentication (MFA) requires users to provide two or more distinct pieces of evidence to prove their identity during login. Rather than relying solely on a memorized password, MFA layers different authentication categories together, making unauthorized access significantly harder even if one factor is compromised. For Security+, understanding MFA architecture and implementation is critical because it represents modern identity verification best practices across enterprise environments.

---

## Key Concepts

### Authentication Factors
**Analogy**: Just like a bank requires both your card AND your PIN to access your account—neither alone is sufficient—MFA requires multiple different "keys" that prove who you are.

**Definition**: Distinct categories of evidence used to verify identity. Each factor must come from a different category so that compromising one doesn't automatically compromise others.

| Factor Category | Examples | Security Level |
|---|---|---|
| **Something You Know** ([[Knowledge Factor]]) | Password, PIN, security question | Vulnerable to guessing/brute force |
| **Something You Have** ([[Possession Factor]]) | Smart card, USB key, hardware token | Vulnerable to theft/loss |
| **Something You Are** ([[Biometric Factor]]) | Fingerprint, facial recognition, iris scan | Difficult to spoof; cannot be reset |
| **Somewhere You Are** ([[Location Factor]]) | GPS coordinates, IP geolocation | Can be spoofed with VPN/proxy |
| **Something You Do** ([[Behavioral Factor]]) | Typing pattern, mouse movement, gait | Emerging; context-dependent |

---

### Something You Know
**Analogy**: Imagine a secret handshake that only you and your friend know—no physical object needed, just information stored in your brain.

**Definition**: Authentication credentials based on information memorized by the user alone. This includes [[passwords]], [[PINs]], and unlock patterns on mobile devices. The security depends entirely on secrecy and the user's memory.

**Examples**:
- Password (string of characters/passphrase)
- PIN (typically 4-6 digits for ATM/mobile devices)
- Unlock pattern (dot-connection sequence on smartphones)
- Security question answers

---

### Something You Have
**Analogy**: Like needing a physical key to open a door—the attacker can't just guess the key; they must physically possess it.

**Definition**: Authentication credentials requiring physical ownership of a tangible device or token. The device generates, stores, or verifies credentials. Loss or theft directly compromises security.

**Examples**:
- [[Smart cards]] (embedded chip with credentials, requires PIN for full MFA)
- [[USB security keys]] (hardware tokens like YubiKey)
- [[Hardware tokens]] (time-based or challenge-response generators)
- Mobile phone (receives SMS codes or authenticator app push notifications)
- Proximity cards (RFID/NFC badges for physical access)

---

### Something You Are
**Analogy**: Your fingerprint is like a lock that only YOUR specific key can open—and you can never lose it or forget it because it's literally part of your body.

**Definition**: [[Biometric authentication]] uses unique physical or behavioral characteristics that are difficult or impossible to forge, steal, or replicate. These factors cannot be reset if compromised.

**Examples**:
- Fingerprint scanning
- Facial recognition
- Iris/retina scanning
- Voice recognition
- Vein pattern recognition

**Security Advantage**: Cannot be forgotten, lost, or guessed; highly resistant to social engineering.

---

### Somewhere You Are
**Analogy**: A store that only serves customers within a certain neighborhood—your location itself becomes part of your credentials.

**Definition**: [[Geolocation factors]] verify identity based on the user's physical location, typically using GPS coordinates or IP address validation. Context-aware authentication considers whether the login location matches expected patterns.

**Limitations**: Easily defeated with VPNs, proxy services, or GPS spoofing; should never be relied upon as a sole factor.

---

### Multifactor Authentication Implementation
**Analogy**: A bank's layered security approach—you need your card (something you have) AND your PIN (something you know) AND approval on your phone (somewhere you are)—each layer catches different attack types.

**Definition**: Combining two or more authentication factors from different categories. True MFA requires factors from *different* categories; two passwords do not constitute MFA.

**Common MFA Combinations**:
- Password + SMS code (something you know + something you have)
- Smart card + PIN (something you have + something you know)
- Password + biometric + location (combining three categories)
- Hardware token + facial recognition (something you have + something you are)

---

## Exam Tips

### Question Type 1: Factor Classification
- *"A user logs in with their password and then receives a code on their registered mobile phone. How many authentication factors are being used?"* → **Two factors** (password = something you know; mobile code = something you have)
- *"A system requires two different passwords. Is this multifactor authentication?"* → **No**—both factors are "something you know," so it's single-factor with redundancy.
- **Trick**: The exam tests whether you understand that MFA requires *different categories*, not just multiple credentials. Two passwords = still single-factor.

### Question Type 2: Factor Type Identification
- *"Which factor type is MOST resistant to being forgotten or lost?"* → **Something you are** (biometric); cannot be forgotten or lost since it's biological.
- *"A user loses their USB security key. What is the primary weakness this reveals?"* → **Something you have** is vulnerable to theft/loss; possession factors require recovery procedures.
- **Trick**: Don't confuse "hardest to compromise" with "best factor"—biometrics can't be reset if stolen, creating recovery problems.

### Question Type 3: Weakness Identification
- *"Which authentication factor is most vulnerable to social engineering?"* → **Something you know** (passwords/PINs can be tricked out of users verbally).
- *"GPS-based location verification can be defeated by which method?"* → **VPN or proxy services** can mask real location.
- **Trick**: Location factors are contextual security, not true authentication—never count as a primary MFA component on exam questions.

---

## Common Mistakes

### Mistake 1: Confusing "Multiple Credentials" with "Multifactor"
**Wrong**: "The user logged in with their password and their backup password—that's two-factor authentication."
**Right**: Both passwords are [[knowledge factors]] (something you know). This is single-factor authentication with password redundancy.
**Impact on Exam**: You'll incorrectly identify weak authentication schemes as strong MFA. Security+ expects you to recognize that true MFA requires *different categories*.

### Mistake 2: Misclassifying Behavioral Factors as Stronger Than Biometrics
**Wrong**: "Typing patterns are better than fingerprints because they're behavioral, not biological."
**Right**: Fingerprints are established [[biometric factors]] with proven security; typing patterns are emerging/contextual and shouldn't be relied upon as primary MFA.
**Impact on Exam**: Questions about "most secure factor" will have biometrics as stronger answers; behavioral factors are typically distractors.

### Mistake 3: Treating Location as a Full Authentication Factor
**Wrong**: "A login from an unexpected IP address requires geolocation verification—this adds a factor."
**Right**: Location is **contextual security**, not a true authentication factor. It supports risk assessment but cannot stand alone as MFA.
**Impact on Exam**: When asked "how many authentication factors," do NOT count location verification as an independent factor. Questions distinguish between "multi-factor" and "risk-based" or "adaptive" authentication.

### Mistake 4: Assuming All "Something You Have" Requires Physical Devices
**Wrong**: "A mobile phone authenticator app isn't 'something you have' because it's software."
**Right**: The mobile phone itself is the physical possession; the app is the mechanism running on that device. This is still [[possession factor]].
**Impact on Exam**: Recognize that SMS codes, authenticator apps (Google Authenticator, Microsoft Authenticator), and push notifications all count as "something you have" because they require ownership of the specific device.

---

## Related Topics
- [[Authentication Methods]]
- [[Password Security]]
- [[Biometric Authentication]]
- [[Smart Cards]]
- [[Hardware Tokens]]
- [[Access Control Models]]
- [[Identity and Access Management (IAM)]]
- [[Risk-Based Authentication]]
- [[Zero Trust Architecture]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*