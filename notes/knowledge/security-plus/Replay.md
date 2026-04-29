---
domain: "network-security"
tags: [replay-attack, authentication, cryptography, network-attacks, session-security, protocol-exploitation]
---
# Replay

A **replay attack** is a form of network attack in which a valid, previously captured data transmission is **maliciously retransmitted** to deceive a target system into accepting it as a legitimate new communication. These attacks exploit the fact that a credential or message may be cryptographically valid even when sent outside its original context, making them particularly dangerous against [[Authentication]] systems. Replay attacks are closely related to [[Man-in-the-Middle Attack]] techniques and represent a fundamental threat to [[Session Management]] and [[Cryptographic Protocols]].

---

## Overview

Replay attacks belong to a class of vulnerabilities where the **integrity and freshness of a message** are not properly verified. A captured authentication token, session cookie, Kerberos ticket, or signed message retains its cryptographic validity after the original exchange — unless the receiving system has mechanisms to detect stale or duplicate transmissions. Because the attacker does not need to break the underlying encryption, replay attacks can bypass strong encryption schemes entirely, attacking the *protocol layer* rather than the *cryptographic layer*.

The concept has been recognized since the earliest days of network security. Needham and Schroeder's 1978 authentication protocol was famously shown to be vulnerable to replay attacks by Denning and Sacco in 1981, leading directly to the development of **nonce-based** and **timestamp-based** defenses. This historical example underscores that even carefully designed cryptographic protocols can fail if message freshness is not explicitly addressed.

In practice, replay attacks manifest across a wide range of contexts: **Kerberos ticket theft**, **OAuth token replay**, **WPA2 four-way handshake capture and replay**, **RADIUS authentication replay**, and even **physical systems** such as rolling-code garage door openers. The 2011 compromise of RSA SecurID tokens, while primarily a seed value breach, illustrated downstream risks of authentication token replay in enterprise environments. More recently, relay/replay variants have featured prominently in **Active Directory (AD) attacks**, particularly with NTLM relay attacks and Pass-the-Hash.

The distinction between a **relay attack** and a **replay attack** is worth noting for precision. A relay attack forwards a live challenge-response in real time (as seen in NFC/RFID key fob attacks on vehicles), whereas a replay attack retransmits a previously captured complete message at a later time. In practice, the boundary blurs — NTLM relay attacks, for instance, combine elements of both. Both classes rely on the target system failing to distinguish between original and duplicated sessions.

Replay attacks are particularly impactful against **stateless protocols** and **legacy systems**. HTTP-based APIs that rely on static API keys, older SNMP v1/v2c implementations, and systems using only symmetric shared secrets without session identifiers are all prime targets. Modern defenses such as TLS with session tickets, JWT with short expiration, and Kerberos with clock synchronization have dramatically reduced exposure — but misconfigurations and legacy deployments keep replay attacks operationally relevant.

---

## How It Works

### General Attack Flow

Replay attacks follow a consistent pattern regardless of the specific protocol being targeted:

```
[Legitimate Client] --(Authentication Request)--> [Server]
        |
        | (Attacker intercepts/sniffs traffic via Wireshark, tcpdump, etc.)
        v
[Attacker captures: auth token / session data / signed message]
        |
        | (Later, attacker retransmits the same captured data)
        v
[Attacker] --(Replayed Auth Request)--> [Server]
[Server validates cryptographic signature — PASSES]
[Attacker gains unauthorized access]
```

### Step-by-Step Breakdown

**Step 1: Traffic Capture**

The attacker positions themselves to capture network traffic. This can be done on an untrusted network, via ARP poisoning on a LAN, or by compromising a network device. Tools include:

```bash
# Passive capture on an interface
tcpdump -i eth0 -w capture.pcap

# Or with Wireshark (GUI) filtering for specific protocols
# Filter: kerberos || ntlmssp || radius
```

**Step 2: Identify Replayable Credential Material**

Not all captured traffic is replayable. The attacker identifies:
- **NTLM hashes** from SMB authentication
- **Kerberos TGTs or service tickets** (valid within clock skew window)
- **Session cookies** or **Bearer tokens** (JWT, OAuth)
- **RADIUS Access-Request packets** with authenticators
- **WPA2 EAPOL handshake frames**

**Step 3: Retransmit the Captured Material**

```bash
# NTLM relay example using Responder + ntlmrelayx (Impacket)
# Step 1: Poison LLMNR/NBT-NS to capture NTLM hashes
sudo python3 Responder.py -I eth0 -wrd

# Step 2: Relay the captured NTLM authentication to a target
sudo python3 ntlmrelayx.py -t smb://192.168.1.100 -smb2support

# Kerberos ticket replay using Impacket's ticketer + psexec
export KRB5CCNAME=/tmp/stolen_ticket.ccache
python3 psexec.py -k -no-pass domain.local/user@target.domain.local
```

**Step 4: Server-Side Validation Failure**

If the server does not implement:
- **Nonce checking** (one-time-use random value)
- **Timestamp validation** with tight expiration windows
- **Sequence number tracking**
- **Session binding** (tying tokens to IP/TLS session)

...then the replayed credential is accepted as valid.

### Protocol-Specific Examples

**Kerberos Replay Window:**
Kerberos uses timestamps to prevent replay attacks, but only allows a 5-minute clock skew by default. A ticket captured within that window *can* be replayed unless the KDC maintains a replay cache:

```
# Kerberos replay cache is maintained in:
# /var/lib/krb5kdc/principal (MIT Kerberos)
# Default replay window: ±5 minutes (configurable in krb5.conf)

[libdefaults]
    clockskew = 300   # 5 minutes in seconds
```

**JWT Replay:**
A JSON Web Token without an `exp` claim or with a long expiration can be replayed indefinitely:

```json
// Vulnerable JWT payload (no expiration)
{
  "sub": "user123",
  "role": "admin",
  "iat": 1700000000
}

// Secure JWT payload
{
  "sub": "user123",
  "role": "admin",
  "iat": 1700000000,
  "exp": 1700003600,   // 1 hour expiry
  "jti": "a1b2c3d4"   // JWT ID — unique nonce, checked server-side
}
```

**WPA2 Replay Attack (KRACK — CVE-2017-13077):**
The Key Reinstallation Attack exploited the WPA2 four-way handshake by replaying message 3, forcing nonce reuse in CCMP/TKIP, enabling decryption of traffic.

---

## Key Concepts

- **Nonce (Number Used Once):** A random or pseudo-random value included in a message that must be unique per transaction. If a server validates that each nonce has never been seen before, replayed messages containing old nonces are rejected.

- **Timestamp-Based Freshness:** A mechanism where messages include the current time and the receiver rejects any message older than a defined threshold (e.g., Kerberos's 5-minute window). Requires synchronized clocks — [[NTP]] poisoning can undermine this defense.

- **Challenge-Response Authentication:** A protocol pattern where the server sends a unique challenge (nonce) and the client must respond with a value derived from that challenge. Since the challenge is unique per session, captured responses cannot be replayed against a new challenge. Used in [[NTLM]] and modern [[Digest Authentication]].

- **Sequence Numbers:** Used in protocols like [[TLS]] and [[IPsec]] to ensure messages arrive in order and are not duplicated. IPsec's Anti-Replay window tracks received sequence numbers and discards packets outside the valid window.

- **Token Binding:** A mechanism that cryptographically binds security tokens (like OAuth access tokens) to the TLS layer's keying material, making captured tokens useless outside their original TLS session.

- **Pass-the-Hash (PtH):** A specific form of replay attack against [[NTLM]] authentication where the attacker replays the captured NTLM hash directly — without cracking it — to authenticate to services. The hash *is* the credential in NTLM, making capture equivalent to plaintext credential theft.

- **Anti-Replay Window:** The sliding window mechanism used in IPsec (defined in RFC 4303) that tracks received packet sequence numbers. Packets with sequence numbers falling outside the acceptable window or that have already been received are dropped.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Replay attacks appear primarily in:
- **Domain 1.0 – General Security Concepts** (attack types)
- **Domain 2.0 – Threats, Vulnerabilities, and Mitigations** (protocol weaknesses)
- **Domain 4.0 – Security Operations** (detection/response)

**Common Question Patterns:**

1. **"What type of attack involves capturing and retransmitting authentication credentials?"** → Replay attack. Distinguish from [[Man-in-the-Middle Attack]] (which *intercepts and modifies* live traffic) and [[Pass-the-Hash]] (a subtype of replay specific to NTLM).

2. **"Which mechanism BEST prevents replay attacks?"** → Nonces / challenge-response. Timestamps alone are weaker (require clock sync). Encryption alone does NOT prevent replay — this is a common gotcha.

3. **"A user's Kerberos ticket was stolen and used hours later. What attack occurred?"** → Replay attack (specifically Kerberos ticket replay / Pass-the-Ticket).

4. **"What does IPsec use to prevent replay attacks?"** → Sequence numbers with an anti-replay window.

**Critical Gotchas:**
- **Encryption ≠ replay protection.** A fully encrypted NTLM exchange can still be replayed. Encryption protects confidentiality, not message freshness.
- **HTTPS alone does not prevent session cookie replay** if the cookie is stolen (e.g., via XSS) and replayed from another client.
- **Timestamps require NTP.** If the exam question mentions NTP or clock synchronization in the context of authentication, think Kerberos and replay prevention.
- The Security+ exam may use **"session replay"** to describe cookie/token replay in web contexts and **"credential replay"** for network protocol contexts — both are instances of the same fundamental attack.

---

## Security Implications

### Vulnerabilities and Attack Vectors

**CVE-2017-13077 (KRACK):** The Key Reinstallation Attack against WPA2 demonstrated that replaying cryptographic handshake messages could force nonce reuse in AES-CCMP, allowing an attacker within wireless range to decrypt, replay, and potentially forge traffic on WPA2 networks. This affected virtually all WPA2 implementations and required patches across hundreds of vendors.

**CVE-2014-6321 / MS14-068:** A Kerberos privilege escalation vulnerability in Windows where a forged Privilege Attribute Certificate (PAC) could be included in a Kerberos ticket, and that ticket could be replayed to gain Domain Admin privileges. This is effectively a ticket forgery + replay attack.

**NTLM Relay (Ongoing):** NTLM relay/replay attacks remain one of the most commonly used techniques in internal network penetration testing and real-world breaches. The 2020 Zerologon vulnerability (CVE-2020-1472) combined with NTLM relay allowed attackers to compromise domain controllers. Microsoft's continued deprecation of NTLM is driven substantially by relay/replay risks.

**OAuth Token Replay:** Bearer tokens in OAuth 2.0 are inherently replayable if intercepted. The "bearer" semantic means *possession equals authorization*. Misconfigured APIs with long-lived tokens, absence of PKCE, or lack of token binding are frequent findings in API security assessments.

### Detection Indicators

- Multiple authentication attempts with identical session tokens or ticket hashes from different source IPs
- Kerberos TGT requests occurring outside the expected clock skew window
- NTLM authentication events (Event ID 4776) from unexpected hosts
- Duplicate packet sequence numbers detected by IDS/IPS (Snort/Suricata rules for replay)
- JWT `jti` (JWT ID) collision detected in token validation logs

---

## Defensive Measures

### Protocol-Level Controls

**1. Implement Nonce-Based Authentication**
Every authentication challenge should include a server-generated, cryptographically random nonce. The server must track used nonces and reject any repeat:
```python
import secrets
import redis

def generate_nonce():
    return secrets.token_hex(32)

def validate_nonce(nonce, redis_client):
    # Returns False if nonce was already used
    if redis_client.exists(f"used_nonce:{nonce}"):
        return False
    redis_client.setex(f"used_nonce:{nonce}", 300, 1)  # 5-min TTL
    return True
```

**2. Enforce Short Token Lifetimes**
```json
// JWT configuration best practice
{
  "exp": "<issue_time> + 900",   // 15-minute max for access tokens
  "jti": "<uuid4>",               // Unique ID tracked server-side
  "nbf": "<issue_time>"           // Not-before claim
}
```

**3. Kerberos Hardening**
```ini
# /etc/krb5.conf — tighten replay window
[libdefaults]
    clockskew = 60          # Reduce from 300s to 60s where clock sync permits
    no_addresses = false    # Bind tickets to IP addresses
```

**4. Enable IPsec Anti-Replay**
```bash
# Verify anti-replay is enabled on Linux IPsec SA
ip xfrm state show
# Look for: replay-window 32 (or higher)

# In strongSwan ipsec.conf
connections {
    host-host {
        replay_window = 32   # Minimum; 64 or 128 recommended
    }
}
```

**5. Enforce MutualTLS (mTLS) for API Authentication**
Binding authentication to the TLS session certificate eliminates token portability:
```nginx
# nginx mTLS configuration
server {
    ssl_client_certificate /etc/ssl/ca.crt;
    ssl_verify_client on;
    ssl_verify_depth 2;
}
```

**6. Disable NTLM Where Possible (Active Directory)**
```powershell
# GPO: Computer Configuration > Windows Settings > Security Settings
# > Local Policies > Security Options
# "Network security: Restrict NTLM: NTLM authentication in this domain"
# Set to: Deny all

# Or via PowerShell (audit mode first)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" `
    -Name "RestrictReceivingNTLMTraffic" -Value 2
```

**7. Network-Level Controls**
- Deploy [[IDS/IPS]] (Snort/Suricata) with rules for duplicate sequence numbers and authentication anomalies
- Implement [[Network Segmentation]] to limit the blast radius of captured credentials
- Enable SMB signing to prevent NTLM relay (which relies on captured and replayed NTLM exchanges):
```powershell
Set-SmbServerConfiguration -RequireSecuritySignature $true -Force
```

---

## Lab / Hands-On

### Lab 1: NTLM Relay/Replay Demonstration (Isolated Lab Only)

**Prerequisites:** Kali Linux attacker VM, Windows Server/workstation target, isolated VLAN

```bash
# On Kali — Step 1: Disable SMB and HTTP in Responder to enable relay
nano /etc/responder/Responder.conf
# Set: SMB = Off, HTTP = Off

# Step 2: Start