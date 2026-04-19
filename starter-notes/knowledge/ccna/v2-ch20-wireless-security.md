# Wireless LAN Security
**Why this matters:** Wireless signals broadcast openly through the air, making security exponentially harder than wired networks. Without proper encryption and authentication, attackers can eavesdrop, steal credentials, and modify data in transit—understanding WPA/WPA2/WPA3 is essential to passing the CCNA exam and securing real networks.

---

## 20.1 Wireless LAN Security Concepts

### The CIA Triad in Wireless LANs

The **[[CIA Triad]]** (Confidentiality, Integrity, Availability) applies to wireless just like wired networks—but wireless makes each pillar exponentially harder to achieve.

#### Confidentiality: Encryption is Non-Negotiable

**Simple explanation:** Wired networks are private because signals stay inside cables. Wireless signals broadcast everywhere—anyone with a radio receiver can pick them up. Imagine shouting your password across a crowded room instead of whispering it to one person.

**Technical detail:** Unencrypted wireless frames can be captured by any device within RF range. Attackers use packet sniffers (like [[Wireshark]]) to collect cleartext credentials, session tokens, and sensitive data. Encryption converts plaintext into unintelligible ciphertext that only the intended recipient can decrypt.

**Key terms:**
- **Cleartext:** Data that will never be encrypted
- **Plaintext:** Data waiting to be encrypted
- **Ciphertext:** Encrypted data

#### Integrity: Detecting Tampering

**Simple explanation:** Encryption keeps people from reading your message, but a clever attacker can still flip individual bits in the encrypted message, causing predictable changes when decrypted. Like changing one digit in a check without the bank noticing.

**Technical detail:** A **checksum** (cryptographic hash) is calculated from the message before encryption. This small block of data is appended to the plaintext. When the receiver decrypts, they recalculate the checksum. If checksums match → data wasn't altered. If they don't match → message is discarded.

**Important caveat:** Checksums *detect* tampering but don't *prevent* it. They're a verification mechanism, not a barrier.

#### Availability: The DoS Problem

**Simple explanation:** Availability attacks are the easiest wireless attacks to execute. An attacker doesn't need hacking skills—just a signal generator.

**Technical detail:** **RF Jamming attacks** flood the 802.11 frequency bands (2.4 GHz or 5 GHz) with noise, preventing legitimate devices from communicating. The only solution is physical security—locate and remove the jamming device. Prevention requires controlling who has access to your physical premises. CCNA exam typically ignores DoS for wireless (it's considered unsolvable at the exam level).

---

### Legacy 802.11 Security: WEP (Wired Equivalent Privacy)

**Status:** Obsolete. Do not use. Included here only for historical context and exam understanding.

#### WEP Authentication Methods

| Method | How It Works | Security Level |
|--------|-------------|-----------------|
| **Open System** | AP approves all auth requests (no credentials checked) | None—just verifies device is 802.11-compatible |
| **Shared Key** | Client and AP share static WEP key; AP sends challenge phrase, client encrypts and returns it | Weak—static keys never rotate; vulnerable to cryptanalysis |

**Shared Key Authentication Process:**
1. Client sends authentication request
2. AP responds with unencrypted challenge phrase
3. Client encrypts challenge phrase using static WEP key
4. Client sends ciphertext back to AP
5. AP decrypts using its WEP key
6. AP compares decrypted challenge to original
7. If match → authentication success; if no match → failure

**Why WEP Failed:**
- Static keys meant once compromised, all traffic was exposed
- 24-bit initialization vector (IV) was too short → keys repeated frequently
- Vulnerable to bit-flipping attacks despite use of checksums
- Various cryptanalytic attacks could recover the WEP key in minutes with captured traffic

---

## 20.2 WPA, WPA2, and WPA3 Security Protocols

### WPA Fundamentals

**WPA** = **[[Wi-Fi Protected Access]]**, a set of security certification programs from the **[[Wi-Fi Alliance]]**. Devices earning "Wi-Fi Certified" status must comply with WPA standards. Three generations exist:

| Protocol | Year Released | Encryption | Key Management | Status |
|----------|---------------|-----------|-----------------|--------|
| **WPA** | 2003 | TKIP | PSK or 802.1X | Deprecated |
| **WPA2** | 2004 | AES-CCMP | PSK or 802.1X | Current Standard |
| **WPA3** | 2018 | AES-CCMP-192 | PSK or 802.1X; SAE | Next Generation |

### WPA and TKIP (Temporal Key Integrity Protocol)

**[[TKIP]]** was WPA's attempt to fix WEP's flaws without requiring new hardware.

**Key improvements over WEP:**
- **Per-packet key derivation:** Each frame gets a unique encryption key (unlike WEP's static key)
- **48-bit IV:** Larger initialization vector reduces key repetition
- **Message Integrity Check (MIC):** Stronger than WEP's checksum; catches tampering attempts
- **Key mixing function:** Makes cryptanalysis harder

**Weakness:** TKIP still used RC4 stream cipher (same as WEP). Modern attacks can still break it. **TKIP is deprecated; avoid it.**

### WPA2: The CCNA Standard

**[[WPA2]]** introduced **[[AES-CCMP]]** (Advanced Encryption Standard with Counter Mode CBC-MAC Protocol), which addressed all WPA/WEP weaknesses.

**Why WPA2 is secure:**
- **AES (Advanced Encryption Standard):** Unbreakable with current technology. Uses 128-bit keys (WPA2) or 192-bit keys (WPA3)
- **CCMP (Counter Mode CBC-MAC Protocol):** Combines encryption + authentication in one algorithm
  - **Counter Mode:** Encrypts each frame with unique keystream
  - **CBC-MAC:** Provides message authentication code (detects tampering)
- **Unique key per frame:** Derived from master key + frame number
- **802.1X or PSK:** Flexible authentication options (covered below)

### WPA3: Forward-Looking Security

**[[WPA3]]** (released 2018) addresses modern threats:

**Key WPA3 advantages:**
- **SAE (Simultaneous Authentication of Equals):** Replaces Pre-Shared Key (PSK) handshake vulnerability
  - **PSK weakness:** Vulnerable to dictionary attacks and brute-force in offline mode
  - **SAE solution:** Uses elliptic-curve cryptography; even with weak passwords, attackers can't precompute hashes
- **192-bit AES-CCMP:** For enterprise networks (vs. 128-bit in WPA2)
- **Individualized Data Encryption (OWE):** Encrypts even open networks
- **Protection against KRACK attacks:** More robust key derivation prevents known-plaintext attacks

**WPA3 still uses AES-CCMP at its core**—the encryption mechanism is proven.

---

## 20.3 Authentication Methods: PSK vs. 802.1X

Both WPA2 and WPA3 support two authentication architectures:

### Personal Mode: Pre-Shared Key (PSK)

**Use case:** Small office, home, coffee shop (SMB/SOHO)

**How it works:**
1. Admin configures same password on AP and clients (the "Wi-Fi password")
2. All clients use this PSK to derive a **Pairwise Master Key (PMK)**
3. PMK is used to derive **Pairwise Transient Key (PTK)** for each session
4. PTK encrypts all unicast traffic

**Weakness:** If PSK is compromised, all past and future traffic is compromised (no forward secrecy). Dictionary attacks can brute-force weak passwords offline.

**CCNA context:** This is what you use in home labs.

### Enterprise Mode: 802.1X Authentication

**Use case:** Corporate networks requiring per-user authentication

**How it works:**
- AP acts as **[[Authenticator]]** (enforcer)
- Client acts as **[[Supplicant]]** (requester)
- **Authentication Server** (typically [[RADIUS]] server) verifies credentials
- User authenticates with username + password (or certificate)
- Each user gets unique PMK → unique PTK

**Process:**
1. Client sends 802.1X request with credentials
2. AP forwards to RADIUS server
3. RADIUS validates (checks AD/LDAP database)
4. If valid → server sends PMK to AP
5. AP and client derive PTK from PMK
6. Traffic encrypted with PTK (different per user)

**Advantage:** If one user's account is compromised, only their traffic is at risk. Other users unaffected.

**CCNA scope:** Understand the architecture; detailed RADIUS config is beyond CCNA.

---

## 20.4 The Four-Way Handshake (WPA2/WPA3)

This is the **key derivation process** that establishes encryption keys between AP and client.

**Participants:**
- **Authenticator:** AP (has PMK)
- **Supplicant:** Client (has PMK)
- Both derive same PTK through cryptographic handshake

**Simplified four-way process:**

| Step | Direction | Purpose |
|------|-----------|---------|
| 1 | AP → Client | AP sends random nonce (ANonce) |
| 2 | Client → AP | Client sends random nonce (SNonce); derives PTK; sends MIC of EAPOL frame |
| 3 | AP → Client | AP derives PTK; verifies MIC; sends MIC of EAPOL frame; loads PTK for encryption |
| 4 | Client → AP | Client acknowledges; both now use PTK to encrypt traffic |

**Why it's "four-way":** Four EAPOL (EAPoL = Extensible Authentication Protocol over LAN) frames exchanged.

**Critical point:** Attackers cannot derive PTK without both nonces. Each nonce is random and single-use.

---

## Lab Relevance

Wireless security configuration is typically examined through **Cisco AP configuration commands** (not exhaustively tested on CCNA, but understanding the concepts is essential):

### Cisco IOS Wireless Configuration

**Enable WPA2-PSK on Access Point:**
```
(config)# interface dot11Radio 0
(config-if)# encryption mode ciphers aes-ccm
(config-if)# encryption key 1 size 256 type hex 1234567890ABCDEF...
(config-if)# security wpa version 2
(config-if)# security wpa psk set-key ascii MySecurePassword123
(config-if)# security wpa psk ascii MySecurePassword123
```

**Enable 802.1X (Enterprise):**
```
(config-if)# security authentication type 802.1x
(config-if)# security wpa version 2
(config-if)# radius-server host 192.168.1.100 auth-port 1812
(config-if)# radius-server key RadiusSharedSecret123
```

**Verify Wireless Security Configuration:**
```
# show ap interface summary
# show wpa psk configured-keys
# show dot11 associations
# show interface dot11Radio 0 config encryption
```

**CCNA note:** You won't configure wireless APs from scratch on the exam, but understanding the WPA/802.1X/PSK terminology and conceptual flow is testable.

---

## Exam Tips

### What the CCNA Exam Specifically Tests

1. **CIA Triad Application to Wireless**
   - Why encryption is essential in wireless (signal broadcast nature)
   - Integrity mechanisms (checksums/MIC) don't prevent tampering, only detect it
   - Availability attacks (RF jamming) are difficult to prevent

2. **WEP vs. WPA/WPA2 Evolution**
   - **Expect a question like:** "What was the primary weakness of WEP that WPA addressed?"
   - **Answer:** Static encryption keys; WPA introduced per-packet key derivation
   - Memorize: WEP used RC4, TKIP still used RC4 (

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 20 | [[CCNA]]*
