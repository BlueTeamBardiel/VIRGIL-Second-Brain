---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 004
source: rewritten
---

# Non-repudiation
**The cryptographic guarantee that a sender cannot deny having created or transmitted data.**

---

## Overview
Non-repudiation is a foundational principle in [[cryptography]] that prevents someone from falsely claiming they didn't send or create a message. Think of it like signing a legal document — once your signature is on it, you can't later claim you never agreed to it. For the Security+ exam, understanding non-repudiation means grasping how digital signatures and [[authentication]] mechanisms work together to create undeniable proof of origin and accountability.

---

## Key Concepts

### Proof of Integrity
**Analogy**: A tamper-evident seal on a package. If someone opens it, you immediately know something was disturbed.

**Definition**: The ability to verify that received data is identical to the original data transmitted, with no modifications, additions, or deletions. This is achieved using [[hash functions]], which create unique fingerprints of data.

**Related mechanisms**:
- [[Hash functions]] (MD5, SHA-256, SHA-3)
- [[Message digest]]
- [[Fingerprinting]]

| Characteristic | Hash Function |
|---|---|
| Output size | Fixed-length string |
| Deterministic | Same input = same output always |
| Sensitivity | One bit change = completely different hash |
| Purpose | Verify data hasn't been altered |

### Proof of Origin
**Analogy**: A notarized signature on a document. Not only can you see who signed it, an authority verified they actually did.

**Definition**: The ability to verify that data genuinely came from the claimed sender, not an impostor. This requires [[digital signatures]] and [[public key cryptography]] to link data to a specific individual's private key.

**Related mechanisms**:
- [[Digital signatures]]
- [[Public key infrastructure (PKI)]]
- [[Certificate authority (CA)]]
- [[Asymmetric encryption]]

| Element | Purpose |
|---|---|
| Sender's private key | Creates the signature (proves ownership) |
| Sender's public key | Allows receiver to verify sender's identity |
| Hash of message | Ensures message wasn't altered |
| Timestamp | Proves when signature was created |

### Non-repudiation vs. Integrity Alone
**Analogy**: A hash is like a security camera recording that proves something happened. A digital signature is that recording PLUS a sworn statement from the person in the video admitting they did it.

**Definition**: While [[hashing]] proves data integrity (nothing changed), it doesn't prove WHO sent it. Non-repudiation requires both integrity verification AND identity verification through [[digital signatures]].

| Property | Hash Only | Digital Signature |
|---|---|---|
| Detects tampering | ✓ | ✓ |
| Identifies sender | ✗ | ✓ |
| Sender can deny | Yes | No |
| Uses private key | No | Yes |
| Provides non-repudiation | No | Yes |

---

## Exam Tips

### Question Type 1: Integrity vs. Non-repudiation Distinction
- *"Which technology allows you to verify that an email message wasn't modified in transit?"* → [[Hashing]] (integrity only)
- *"Which technology prevents a user from denying they sent a financial transaction?"* → [[Digital signatures]] (non-repudiation)
- **Trick**: Questions may ask about "proving data wasn't changed" (that's just [[integrity]]) vs. "proving who sent it and they can't deny it" (that's [[non-repudiation]])

### Question Type 2: Non-repudiation Implementation
- *"A company needs to ensure employees cannot deny signing contracts. What should they implement?"* → [[Digital signatures]] with [[PKI]]
- *"What component of a digital signature prevents repudiation?"* → The sender's [[private key]] — only they have it
- **Trick**: Don't confuse [[symmetric encryption]] or [[hashing]] alone with non-repudiation; both require [[asymmetric cryptography]]

### Question Type 3: Real-world Scenarios
- *"An employee claims they never sent a confidential email. What proves they did?"* → [[Digital signature]] with timestamp from [[certificate authority]]
- **Trick**: Passwords don't provide non-repudiation because multiple people might know them

---

## Common Mistakes

### Mistake 1: Thinking Hash = Non-repudiation
**Wrong**: "We use [[MD5]] hashing, so we have non-repudiation."
**Right**: Hashing only proves [[data integrity]]. Non-repudiation requires [[digital signatures]] that tie data to a specific person's [[private key]].
**Impact on Exam**: You'll get questions asking which technology actually prevents denial of sending. Answer: [[digital signatures]], not hashes alone.

### Mistake 2: Confusing Symmetric and Asymmetric for Non-repudiation
**Wrong**: "We encrypted the message with [[AES]], so the sender can't deny it."
**Right**: [[Symmetric encryption]] requires a shared key — multiple people could have encrypted it. Only [[asymmetric encryption]] (where only the sender has their private key) provides non-repudiation.
**Impact on Exam**: Security+ heavily tests the difference. Only [[public key cryptography]] prevents repudiation.

### Mistake 3: Assuming Authentication = Non-repudiation
**Wrong**: "Our password-protected system has non-repudiation."
**Right**: Passwords provide [[authentication]] (proving who you are in the moment) but not [[non-repudiation]] (proving you created this specific message). Someone with your password could send messages claiming to be you.
**Impact on Exam**: Non-repudiation requires [[digital signatures]] with [[PKI]], not just username/password authentication.

### Mistake 4: Missing the Role of Timestamps
**Wrong**: "A digital signature proves when the message was sent."
**Right**: A [[digital signature]] proves WHO sent it, but a [[timestamp]] from a trusted [[certificate authority]] proves WHEN. Both together provide complete non-repudiation.
**Impact on Exam**: Look for questions about legal evidence — timestamps matter for proving "this was sent at this exact moment" in addition to the signature itself.

---

## Related Topics
- [[Digital signatures]]
- [[Public key infrastructure (PKI)]]
- [[Hash functions]]
- [[Asymmetric encryption]]
- [[Message authentication code (MAC)]]
- [[Certificate authority (CA)]]
- [[Data integrity]]
- [[Authentication vs. non-repudiation]]
- [[Cryptographic standards]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*