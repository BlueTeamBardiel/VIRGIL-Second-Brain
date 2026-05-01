---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 047
source: rewritten
---

# Wireless Attacks
**Adversaries exploit unprotected wireless management communications to disrupt legitimate user connectivity and network access.**

---

## Overview
Wireless networks operate using standardized protocols that include behind-the-scenes management conversations between your device and the access point. These management frames handle connection requests, authentication handshakes, and disconnections—but early wireless standards left these critical communications vulnerable to tampering. For Security+, understanding wireless attack vectors is essential because Wi-Fi networks remain a primary target for [[Denial of Service]] attacks and credential theft.

---

## Key Concepts

### Deauthentication Attack
**Analogy**: Imagine someone forging a letter from your employer telling you to leave your job immediately—except there's no signature verification, so the letter looks completely legitimate. Your wireless device accepts a fake "please disconnect" message from an attacker and obeys it instantly, just like you'd follow what appears to be an official termination notice.

**Definition**: A [[DoS]] attack where an attacker transmits spoofed [[802.11]] management frames to disconnect legitimate users from a wireless network. The victim device loses connectivity without warning or ability to prevent it, and the attack can repeat continuously.

| Aspect | Details |
|--------|---------|
| **Attack Type** | [[Denial of Service]] |
| **Target** | [[802.11 Management Frames]] |
| **Effect** | Immediate disconnection from wireless network |
| **Repeatability** | Can occur repeatedly against same user |
| **User Awareness** | Typically silent; user only notices loss of service |

---

### 802.11 Management Frames
**Analogy**: Think of management frames as the invisible infrastructure of a concert venue—ushers silently checking tickets at entrances, security guards communicating about crowd control, and staff coordinating seating. You don't see these interactions, but they orchestrate everything that happens in the main hall where actual "concert" (data) occurs.

**Definition**: Control and administrative [[frame (networking)]] types used by wireless devices and [[Access Point]]s to handle [[Association]], [[Authentication]], and [[Deauthentication]] processes. These frames operate independently from encrypted user data traffic.

| Management Frame Type | Purpose | Security Risk |
|----------------------|---------|---------------|
| **Association Request/Response** | Device joins network | Spoofable; no authentication |
| **Authentication Request/Response** | Credential exchange initiation | Sent unencrypted in early standards |
| **Deauthentication** | Graceful disconnect | Easily forged by attackers |
| **Beacon** | Network advertisement | Source can be spoofed |

---

### Unencrypted Management Frame Vulnerability
**Analogy**: Early wireless standards were like a town with "Welcome Citizen" gates that check no credentials—anyone wearing the right costume could impersonate a town official and tell citizens to leave. There's no signature, no verification system, just trust that messages are legitimate.

**Definition**: The original [[802.11]] specification transmitted management frames "in the clear" without [[Encryption]] or authentication mechanisms. This allowed attackers with basic wireless sniffing capability to observe, capture, and forge these frames to manipulate wireless communications.

| Era | Standard | Management Frame Protection |
|-----|----------|----------------------------|
| **Early 2000s** | [[802.11a/b/g]] | None; frames unencrypted |
| **Mid 2000s** | [[802.11i]] / [[WPA2]] | Optional frame protection |
| **2020+** | [[802.11w]] / [[WPA3]] | Mandatory frame encryption |

---

## Exam Tips

### Question Type 1: Attack Identification
- *"A user's wireless connection repeatedly drops without notification, reconnects moments later, then disconnects again. Which attack best describes this scenario?"* → **Deauthentication Attack** ([[DoS]])

  **Trick**: Don't confuse with [[Weak Encryption]] or [[Evil Twin]]—those attacks sniff credentials or redirect traffic. Deauthentication is purely about connection disruption.

### Question Type 2: Vulnerability Root Cause
- *"Why were early 802.11 networks vulnerable to deauthentication attacks?"* → **Management frames were transmitted without [[Encryption]] or authentication, allowing any device to forge disconnect messages.**

  **Trick**: The question might mention [[WEP]] or [[WPA]] encryption—these only protected data frames, not management frames.

### Question Type 3: Mitigation Selection
- *"Which modern standard provides protection against wireless management frame attacks?"* → **[[802.11w]] (Management Frame Protection) and [[WPA3]]**

  **Trick**: [[WPA2]] alone does NOT protect management frames. You need [[802.11w]] explicitly enabled.

---

## Common Mistakes

### Mistake 1: Confusing Data Encryption with Management Frame Security
**Wrong**: "Our network uses [[WPA2]], so deauthentication attacks can't happen."
**Right**: [[WPA2]] encrypts user data frames but does NOT protect unencrypted [[802.11]] management frames. [[802.11w]] (Management Frame Protection) is the separate security layer for administrative communications.
**Impact on Exam**: You may see scenarios where a network appears secure due to strong data encryption, but management frames remain vulnerable. Security+ tests whether you understand these are separate attack surfaces.

### Mistake 2: Assuming Deauthentication Requires Physical Proximity
**Wrong**: "Deauthentication attacks only work if the attacker is near the access point."
**Right**: An attacker anywhere within wireless range of the target device can forge spoofed management frames and trigger disconnection.
**Impact on Exam**: Questions may present scenarios with distance details—don't let this distract you. Standard WiFi range is sufficient for this attack.

### Mistake 3: Treating Deauthentication as a [[Passive Attack]]
**Wrong**: "Deauthentication is just passive [[Network Sniffing]]."
**Right**: Deauthentication is an **active attack** because the attacker actively transmits forged frames to modify network behavior and cause service disruption.
**Impact on Exam**: Classification questions will test whether you know this is [[Active Attack]] causing [[Denial of Service]].

---

## Related Topics
- [[802.11 Standards]]
- [[Access Point]]
- [[Wireless Encryption]] ([[WEP]], [[WPA]], [[WPA2]], [[WPA3]])
- [[Management Frame Protection]] ([[802.11w]])
- [[Denial of Service]]
- [[Evil Twin]]
- [[Rogue Access Point]]
- [[Wireless Site Survey]]
- [[SSID Broadcast]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*