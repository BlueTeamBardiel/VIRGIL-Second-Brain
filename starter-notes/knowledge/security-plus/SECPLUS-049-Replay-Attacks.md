---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 049
source: rewritten
---

# Replay Attacks
**An attacker intercepts legitimate network communications and resends them later to impersonate the original user without needing to break encryption.**

---

## Overview
Replay attacks exploit the fact that legitimate network traffic flowing between clients and servers often contains sensitive authentication or transaction data that attackers can capture and reuse. An attacker intercepts valid network communications, stores them, and then replays these captured packets back to the server to perform unauthorized actions while impersonating the original user. Understanding replay attacks is critical for Security+ because they represent a unique threat vector where the attacker doesn't need to crack encryption—they just need to copy and paste legitimate traffic.

---

## Key Concepts

### Packet Capture and Interception
**Analogy**: Think of it like recording someone's voice saying "approve this transaction," then playing that recording back later to the bank. The bank hears the exact same voice saying the exact same thing.

**Definition**: The attacker uses various methods to obtain copies of legitimate network traffic containing authentication credentials or transaction data. This is typically the first step and often involves [[network sniffing]] or [[man-in-the-middle attacks]].

**Capture Methods**:

| Method | Description | Detection Difficulty |
|--------|-------------|----------------------|
| [[Physical Network Tap]] | Hardware device placed on network cable to duplicate traffic | High—physical access required |
| [[ARP Poisoning]] | Redirects traffic through attacker's machine using fake ARP responses | Medium—creates unusual traffic patterns |
| [[Malware on Endpoint]] | Spy software captures traffic directly from victim's system | High—difficult to detect if well-hidden |
| Wireless Eavesdropping | Passive capture on unencrypted WiFi networks | Medium—requires proximity |

---

### Pass-the-Hash Attack
**Analogy**: Instead of stealing a password itself, you steal the unique fingerprint (hash) that the password creates. You can use that fingerprint to prove you are the user, just like showing someone a photocopy of a driver's license instead of the original.

**Definition**: A specific type of replay attack where an attacker captures a [[password hash]] used during [[authentication]] and replays it directly to the server. The attacker doesn't need the plaintext password—the hash itself is the credential.

**How Pass-the-Hash Works**:

| Stage | What Happens |
|-------|--------------|
| Capture | Attacker intercepts the username + hashed password sent during legitimate login |
| Storage | The captured hash is stored for later use |
| Replay | Attacker sends the same username + hash to the server |
| Success | Server validates the hash and grants access—it's identical to the original |

**Key Point**: The server never receives the plaintext password; it only sees the hash. If the attacker has the hash, they can authenticate without ever knowing the actual password.

---

### Distinction from Man-in-the-Middle
**Analogy**: A man-in-the-middle is like a translator standing between two people, reading and modifying each message. A replay attack is like someone reading one conversation and then reciting it verbatim to someone else days later.

**Definition**: While replay attacks frequently follow a [[man-in-the-middle attack]], they are not the same thing. The replay itself is asynchronous—the attacker doesn't need to be actively intercepting traffic when the replay occurs.

| Characteristic | Replay Attack | Man-in-the-Middle |
|---|---|---|
| Real-time interaction required | No—replay happens later | Yes—must intercept actively |
| Attacker position | Can be anywhere with captured data | Must be between client & server |
| Encryption bypass | Not needed—uses legitimate traffic | Often requires decryption |
| Detection | Difficult—traffic looks legitimate | Easier—unusual latency or anomalies |

---

## Exam Tips

### Question Type 1: Identifying Replay Attack Scenarios
- *"A user authenticates to the network Monday morning. An attacker who captured the authentication handshake replays it Wednesday evening. Which attack is this?"* → **Replay Attack**
- **Trick**: The exam might describe [[pass-the-hash]] specifically and ask you to identify it as a *type* of replay attack, not a separate category.

### Question Type 2: Capture Methods
- *"An attacker places a device directly on a network cable to copy traffic. What is this called?"* → **Physical Network Tap**
- **Trick**: Don't confuse this with [[packet sniffing]] on wireless—a tap requires physical access to wired infrastructure.

### Question Type 3: Mitigations
- *"Which of these BEST prevents replay attacks? A) Encryption B) Firewalls C) Session tokens with timestamps D) Strong passwords"* → **C) Session tokens with timestamps**
- **Trick**: Encryption alone doesn't stop replays—attackers replay the encrypted data anyway. You need [[nonce]] values or [[timestamped tokens]] that invalidate old copies.

---

## Common Mistakes

### Mistake 1: Confusing Replay Attacks with Brute-Force Attacks
**Wrong**: "A replay attack means the attacker is trying many passwords until one works."
**Right**: A replay attack means the attacker already has a valid credential (or its hash) and simply resends it. No guessing involved.
**Impact on Exam**: You might select "strong password policy" as a mitigation when the answer is actually "implement session replay detection" or "use nonces."

### Mistake 2: Thinking Encryption Prevents Replay Attacks
**Wrong**: "If we encrypt all traffic with TLS/SSL, replay attacks are impossible."
**Right**: Encryption protects the *content* of the traffic, but the attacker can still capture and resend the encrypted packet. The server has no way to know if the encrypted data is fresh or a replay.
**Impact on Exam**: When asked "Which prevents replay attacks?" don't automatically choose "encryption." Look for [[anti-replay tokens]], [[sequence numbers]], or [[timestamp validation]].

### Mistake 3: Thinking the Attacker Must Be on the Network When Replaying
**Wrong**: "The attacker has to be sitting on the network to replay a captured packet."
**Right**: Once captured, the attacker can replay from anywhere—a different network, days later, from a completely different location.
**Impact on Exam**: The exam might ask about the timing or location of the replay—don't assume the attacker must still be in a position to perform a [[man-in-the-middle attack]].

### Mistake 4: Confusing Pass-the-Hash with Password Cracking
**Wrong**: "In a pass-the-hash attack, the attacker cracks the hash to recover the password."
**Right**: The attacker doesn't need to crack the hash. They use the hash directly as a credential. The hash itself IS the proof of authentication.
**Impact on Exam**: Questions asking "What must the attacker do in a pass-the-hash attack?" will not include "crack the hash"—they'll ask about *capturing* or *replaying* the hash.

---

## Related Topics
- [[Man-in-the-Middle Attack]]
- [[Network Sniffing]]
- [[ARP Poisoning]]
- [[Password Hash]]
- [[Session Token]]
- [[Nonce (Number Used Once)]]
- [[Authentication Protocol]]
- [[Encryption vs. Authentication]]
- [[Network Tap]]
- [[Replay Detection]]
- [[Kerberos]] (includes built-in replay protection)
- [[TLS/SSL Handshake]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*