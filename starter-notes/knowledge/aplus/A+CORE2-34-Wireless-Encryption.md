---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 34
source: rewritten
---

# Wireless Encryption
**Radio waves broadcast openly to anyone nearby—we need encryption to keep eavesdroppers out.**

---

## Overview

Since [[802.11]] wireless signals travel through the air freely, any device with a radio can intercept them. Without protection, attackers can passively listen to all network traffic without ever connecting. The A+ exam demands you understand how [[encryption protocols]] secure wireless communications and verify data hasn't been tampered with during transmission.

---

## Key Concepts

### The Eavesdropping Problem

**Analogy**: Imagine shouting secrets across a crowded room without a code—everyone hears them. Wireless networks do exactly this: they broadcast data to the air where anyone with a receiver can listen in.

**Definition**: [[Wireless eavesdropping]] occurs when unauthorized devices intercept unencrypted radio signals. Unlike wired networks (where you must physically tap into cables), wireless requires zero physical access—just proximity and a protocol analyzer.

### Authentication vs. Encryption

**Analogy**: A bouncer (authentication) checks your ID at the club door, but once inside, your conversations are still audible to everyone else (no encryption). You need both the bouncer AND soundproof booths.

**Definition**: [[Authentication]] controls *who* connects to the network (username/password), while [[encryption]] controls *what* they can read. Both are mandatory for wireless security.

| Layer | Purpose | Example | Prevents |
|-------|---------|---------|----------|
| Authentication | Access control | WPA2-PSK passphrase | Unauthorized connection |
| Encryption | Data confidentiality | AES encryption | Eavesdropping on traffic |
| Integrity Check | Tamper detection | MIC validation | Modified packets |

### Message Integrity Check (MIC)

**Analogy**: A tamper-evident seal on a package—if someone opens and reseals it, you'll know. A MIC is a cryptographic fingerprint proving the data arrived unchanged.

**Definition**: A [[Message Integrity Check (MIC)]] is a small piece of data appended to encrypted frames that verifies the original message hasn't been altered in transit. If an attacker modifies even one bit, the MIC fails validation and the frame is dropped.

### WPA2 (Wi-Fi Protected Access 2)

**Analogy**: The industry-standard fortress for wireless security from 2004–2020. Think of it as the "steel door" everyone uses.

**Definition**: [[WPA2]] uses [[AES-CCMP]] encryption (Advanced Encryption Standard with Counter Mode with CBC-MAC Protocol) to encrypt individual frames and includes built-in [[MIC]] validation. It replaced the broken [[WEP]] standard.

**Key Details**:
- Uses **Pre-Shared Key (PSK)** mode for home/small office networks
- Uses **802.1X/EAP** mode for enterprise environments
- All modern devices support it

### WPA3 (Wi-Fi Protected Access 3)

**Analogy**: WPA2's successor with modern security patches—like upgrading from a steel door to a titanium door with biometric locks.

**Definition**: [[WPA3]], released in 2018, improves upon [[WPA2]] with stronger encryption algorithms ([[192-bit AES]] for enterprise), protection against brute-force password attacks ([[Simultaneous Authentication of Equals - SAE]]), and better protection on open networks ([[Opportunistic Wireless Encryption - OWE]]).

**Key Advantages**:
- Protects against password-cracking attacks on weak passphrases
- Works on open networks without pre-shared keys
- Requires newer hardware (post-2018 devices)

| Standard | Release | Encryption | Vulnerabilities | Enterprise Support |
|----------|---------|------------|-----------------|-------------------|
| [[WEP]] | 1997 | 40-bit RC4 | **BROKEN** (cracked in hours) | ✗ |
| [[WPA]] | 2003 | TKIP | Weak; deprecated | Limited |
| [[WPA2]] | 2004 | AES-CCMP | KRACK (2017) | ✓ |
| [[WPA3]] | 2018 | AES-192 (ent.) | None known yet | ✓ |

### Why Wireless Needs Extra Protection

**Analogy**: A wired network is like a locked mailbox—you need keys to access it. Wireless is like postcards in the open—anyone can read them without opening anything.

**Definition**: [[Passive eavesdropping]] via [[protocol analyzer]] tools allows attackers to collect encrypted frames, attempt decryption offline, or analyze traffic patterns without triggering any alerts or requiring authentication.

---

## Exam Tips

### Question Type 1: Identifying Encryption Standards
- *"A company wants to migrate from WPA2 to a more modern standard with stronger password protection. Which should they choose?"* → **WPA3**
- *"Which wireless encryption uses AES-CCMP?"* → **WPA2**
- *"Which standard is completely broken and should never be used?"* → **WEP**
- **Trick**: The exam may list "WPA" alone (the original 2003 version)—don't confuse it with WPA2. WPA is deprecated; focus on WPA2/WPA3.

### Question Type 2: MIC/Integrity Questions
- *"What wireless security feature detects if data has been modified in transit?"* → **Message Integrity Check (MIC)**
- *"A wireless frame fails validation. What most likely happened?"* → **The frame was modified (tampering) OR encryption key mismatch**
- **Trick**: Don't confuse MIC with authentication. MIC checks *integrity*, not identity.

### Question Type 3: Enterprise vs. Personal
- *"What authentication method does WPA2-Enterprise use?"* → **802.1X/EAP (RADIUS)**
- *"Which mode requires a pre-shared passphrase?"* → **WPA2/WPA3-Personal (PSK)**
- **Trick**: "Enterprise" = RADIUS server required. "Personal" = simple password.

---

## Common Mistakes

### Mistake 1: Thinking WEP is Still Usable
**Wrong**: "WEP is old but still works for basic networks."
**Right**: WEP is cryptographically broken. It can be cracked in minutes. The A+ exam treats it as "never use."
**Impact on Exam**: You'll lose points if you recommend WEP or fail to identify it as compromised.

### Mistake 2: Confusing Authentication with Encryption
**Wrong**: "If I set a WiFi password, my traffic is encrypted."
**Right**: The password provides authentication (access control) only. Encryption is a separate setting. Both must be enabled.
**Impact on Exam**: Questions ask which protects against eavesdropping—the answer is **encryption**, not authentication.

### Mistake 3: Forgetting MIC is Required
**Wrong**: "WPA2 uses AES encryption; that's all we need."
**Right**: WPA2 uses AES-CCMP, which includes both encryption (AES) and integrity checking (CBC-MAC, which produces the MIC).
**Impact on Exam**: Questions may ask what detects tampering—don't say "encryption." Say "MIC" or "integrity check."

### Mistake 4: Not Knowing WPA3's Key Advantage
**Wrong**: "WPA3 is just WPA2 with a slightly stronger cipher."
**Right**: WPA3's biggest feature is SAE (Simultaneous Authentication of Equals), which protects against brute-force attacks even with weak passwords.
**Impact on Exam**: If the scenario mentions "weak passwords" or "brute-force protection," WPA3 is the answer.

### Mistake 5: Mixing Up Enterprise Authentication Methods
**Wrong**: "WPA2-Personal uses RADIUS."
**Right**: WPA2-Personal (PSK) uses pre-shared keys. WPA2-Enterprise uses 802.1X/RADIUS/EAP.
**Impact on Exam**: Enterprise questions always involve a RADIUS server. Personal questions mention passwords or passphrases.

---

## Related Topics
- [[802.11 Wireless Standards]]
- [[RADIUS and 802.1X Authentication]]
- [[Cryptography Basics (Symmetric vs. Asymmetric)]]
- [[Network Protocol Analyzers]]
- [[VPN and Tunnel Encryption]]
- [[Certificate-Based Authentication]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*