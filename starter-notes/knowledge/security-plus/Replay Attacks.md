---
domain: "network-security"
tags: [replay-attack, authentication, cryptography, network-attacks, session-security, protocol-security]
---
# Replay Attacks

A **replay attack** is a form of network attack in which a valid data transmission is maliciously or fraudulently repeated or delayed by an adversary who has intercepted the original communication. The attacker does not need to decrypt the captured data — they simply **retransmit it verbatim** to trick a system into accepting it as legitimate. Replay attacks exploit the absence of [[Nonce|nonces]], [[Timestamps]], or other freshness mechanisms in [[Authentication Protocols]].

---

## Overview

Replay attacks belong to the broader category of **man-in-the-middle and passive interception attacks**, but they are distinct because the attacker need not understand the content of the captured message. The fundamental vulnerability is that many authentication systems historically treated a valid credential or token as perpetually valid — if you could produce the right bytes, you were granted access. This made captured packets a powerful weapon even without cryptanalysis.

The concept was formally analyzed in the 1980s as researchers began auditing early network authentication systems. The Needham-Schroeder protocol, published in 1978, was later shown to be vulnerable to replay attacks in 1981 by Denning and Sacco. This discovery drove the development of **timestamp-based** and **nonce-based** countermeasures, including the Kerberos protocol which directly addresses replay vulnerabilities through the use of short-lived tickets and authenticators.

In practice, replay attacks appear across a remarkably wide range of contexts: network authentication (capturing and reusing Kerberos tickets), web applications (replaying session tokens or OAuth tokens), wireless networks (replaying WPA2 handshake frames), automotive systems (replaying remote keyless entry signals), and industrial control systems (replaying SCADA command packets). The diversity of affected domains underscores that replay is a **fundamental protocol design flaw** rather than a technology-specific vulnerability.

The attack is particularly dangerous because it can succeed even when the underlying communication channel uses strong encryption. An attacker capturing a TLS-encrypted authentication exchange cannot read the credentials, but if the receiving server has no mechanism to detect that the exact same encrypted bytes were already processed, retransmitting them may still grant access. This is why **cryptographic freshness** — proving that a message was generated recently and specifically for this session — is a core requirement in modern protocol design.

Historical incidents include the 2011 compromise of RSA SecurID tokens (which enabled subsequent replay-style attacks against defense contractors), attacks against early 802.11 WEP implementations, and numerous documented attacks against Kerberos deployments in enterprise Active Directory environments where ticket lifetimes were misconfigured.

---

## How It Works

### Attack Flow (Step-by-Step)

Replay attacks follow a consistent pattern regardless of the target protocol:

**Phase 1: Interception**
The attacker positions themselves to capture network traffic. This may be accomplished via:
- ARP poisoning on a local network segment
- Passive packet capture on an unencrypted or poorly segmented network
- Compromising a network device that forwards traffic
- Capturing wireless frames with a monitor-mode adapter

```bash
# Capture traffic with tcpdump
sudo tcpdump -i eth0 -w captured.pcap port 88   # Kerberos
sudo tcpdump -i eth0 -w captured.pcap port 389  # LDAP
sudo tcpdump -i eth0 -w captured.pcap port 443  # HTTPS session tokens

# Wireless capture (monitor mode)
sudo airmon-ng start wlan0
sudo airodump-ng wlan0mon -w capture --output-format pcap
```

**Phase 2: Recording**
The attacker stores the captured packets — specifically authentication exchanges, session tokens, or command sequences. Modern tools like Wireshark allow precise filtering:

```bash
# Extract Kerberos AS-REQ packets from a pcap
tshark -r captured.pcap -Y "kerberos" -w kerberos_only.pcap

# Extract HTTP session cookies
tshark -r captured.pcap -Y "http.cookie" -T fields -e http.cookie
```

**Phase 3: Replay**
The captured data is retransmitted to the target server, impersonating the original sender:

```bash
# Replay packets using tcpreplay
sudo tcpreplay --intf1=eth0 captured.pcap

# Replay specific packets with delay modification
sudo tcpreplay --intf1=eth0 --pps=100 captured.pcap

# HTTP replay with curl (replaying a captured session token)
curl -H "Cookie: session=a1b2c3d4e5f6..." https://target.example.com/admin
```

**Phase 4: Exploitation**
If the server has no freshness validation, it processes the replayed message as legitimate, granting the attacker whatever privilege the original sender held.

### Kerberos-Specific Replay Example

Kerberos is a protocol specifically designed to resist replay attacks, but misconfiguration can expose it:

```
Client → KDC:  AS-REQ (timestamp encrypted with user's key)
KDC → Client:  AS-REP (TGT, session key)
Client → TGS:  TG-REQ (TGT + Authenticator with timestamp)
TGS → Client:  TG-REP (Service Ticket)
Client → Server: AP-REQ (Service Ticket + Authenticator)
```

The **Authenticator** contains a timestamp. The server maintains a **replay cache** of recently seen authenticators. If an identical authenticator arrives within the clock skew window (default ±5 minutes), it is rejected. An attacker must replay the ticket **within 5 minutes** and before the legitimate client presents the same authenticator — a narrow but real window in some attack scenarios.

### Pass-the-Hash as Replay

**Pass-the-Hash** (PtH) attacks against NTLM authentication are a direct form of replay attack:

```
Normal Flow:
Server → Client: Challenge (random nonce)
Client → Server: NTLM Response = HMAC-MD5(NT_Hash, Challenge)

Attack:
Attacker captures NT hash from SAM database or memory dump:
mimikatz # sekurlsa::logonpasswords

Attacker uses hash directly in authentication without cracking it:
pth-winexe -U DOMAIN/user%aad3b435b51404eeaad3b435b51404ee:ntlmhash //target cmd.exe
```

The hash *is* the credential — retransmitting it is a replay of the authentication proof.

### Session Token Replay

Web applications that issue non-expiring or long-lived session tokens are vulnerable:

```
1. Victim authenticates → Server issues: Set-Cookie: session=TOKEN
2. Attacker captures TOKEN via network sniffing, XSS, or log exposure
3. Attacker sends: GET /dashboard HTTP/1.1
                   Cookie: session=TOKEN
4. Server validates TOKEN, grants attacker full session access
```

---

## Key Concepts

- **[[Nonce]] (Number Used Once):** A random value included in a challenge that must be incorporated into the response. Since the nonce changes every session, a captured response cannot be replayed against a new challenge — the response would not match. Nonces are the primary cryptographic defense against replay attacks.

- **[[Timestamps]]:** Including the current time in an authentication message bounds its validity to a narrow window. If a message arrives outside the acceptable clock skew (typically ±5 minutes in Kerberos), it is rejected. Requires synchronized clocks across systems (see [[NTP Security]]).

- **Replay Cache:** A server-side data structure that stores the identifiers (nonces, authenticators, sequence numbers) of recently processed messages. Incoming messages are checked against this cache; duplicates are rejected. Kerberos KDCs and TGS servers maintain replay caches.

- **Sequence Numbers:** Used in protocols like [[TLS]] and [[IPsec]] to number each packet. Receiving systems reject packets with sequence numbers that have already been processed or fall outside the acceptable window. This prevents both replay and reordering attacks.

- **[[Challenge-Response Authentication]]:** An authentication paradigm in which the server sends a fresh, unpredictable challenge and the client must prove knowledge of a secret by transforming the challenge. Since the challenge is unique each time, replaying an old response fails because it would not match the current challenge.

- **[[Session Token]] Expiry:** Tokens that expire shortly after issuance or after a fixed inactivity period limit the window during which a captured token can be replayed. Combined with binding tokens to IP address or TLS session, this significantly reduces replay risk.

- **[[TLS]] Session Security:** TLS itself does not directly prevent application-layer replay but provides channel security. TLS 1.3 introduced 0-RTT data which has specific replay vulnerability considerations — replay protection for 0-RTT must be implemented at the application layer.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Threats, Attacks and Vulnerabilities (Domain 2); Implementation (Domain 3 — specifically cryptographic protocols)

**Key Exam Tips:**

- **Replay vs. Man-in-the-Middle:** The exam may try to conflate these. A replay attack does not require real-time interception or active session manipulation — the attacker captures, saves, and later retransmits. MitM implies active interception and often modification.

- **Nonces are the canonical answer** to "what prevents replay attacks?" If a question asks which mechanism specifically prevents replay, select nonce or challenge-response over encryption alone.

- **Kerberos clock skew:** The 5-minute default clock skew tolerance in Kerberos is a frequently tested detail. If clocks are not synchronized (NTP failure), Kerberos authentication breaks entirely — this is intentional to prevent replay.

- **Pass-the-Hash is a replay attack:** CompTIA may ask about PtH in the context of replay attacks. Understand that NTLM hashes function as the credential themselves, making their capture and retransmission a direct replay.

- **TLS 1.3 0-RTT:** Exam questions about TLS 1.3 may mention that 0-RTT session resumption data is vulnerable to replay attacks. Application-layer deduplication is required.

- **Common distractors:** "Encryption prevents replay attacks" — FALSE. Encryption alone does not prevent replaying ciphertext. "Digital signatures prevent replay attacks" — PARTIALLY TRUE, signatures authenticate origin but do not prove freshness unless a nonce/timestamp is included in the signed data.

- **Question pattern:** "An attacker captures an authentication packet and retransmits it later to gain access. What type of attack is this?" → Replay Attack. Distinguish from spoofing (forging identity) and session hijacking (taking over a live session).

---

## Security Implications

### Affected Protocols and CVEs

**NTLM / Pass-the-Hash:**
- MS-CHAP and NTLMv1 are fundamentally broken against replay. NTLMv2 improved resistance but hash capture attacks (Mimikatz) remain prevalent in enterprise environments.
- CVE-2019-1040: NTLM authentication bypass via NTLM reflection/relay, a variant of replay.

**Kerberos Ticket Attacks:**
- **Pass-the-Ticket (PtT):** Capturing a Kerberos TGT or service ticket from memory and injecting it into another session. Mimikatz's `kerberos::ptt` implements this directly.
- **Golden Ticket / Silver Ticket attacks:** Forged Kerberos tickets that can be replayed indefinitely if the KRBTGT key is not rotated.

**WPA2 KRACK (CVE-2017-13077):**
- Key Reinstallation Attacks against WPA2 exploit replay of handshake messages (specifically the 4-way handshake Message 3) to force nonce reuse, undermining the cryptographic security of the entire session. Affected virtually all WPA2 implementations at disclosure.

**Remote Keyless Entry Systems:**
- RollJam attack (2015, Samy Kamkar): Demonstrated capture and replay of rolling code signals from car key fobs. By jamming the signal during the first press and capturing both the first and second codes, an attacker retains a valid unused code for later replay.

**Session Token Theft:**
- Firesheep (2010): Firefox extension that captured unencrypted HTTP session cookies on open WiFi and allowed one-click session replay against Facebook, Twitter, and other major sites. Drove widespread HTTPS adoption.

**Industrial Control Systems:**
- Replay attacks against SCADA Modbus/DNP3 protocols (both unauthenticated) can retransmit control commands — opening valves, tripping breakers — captured from legitimate operator sessions.

### Detection Indicators

- Duplicate authentication attempts from different source IPs or at unusual times
- Kerberos Event ID 4769 with multiple identical ticket requests
- Session tokens appearing from geographically impossible locations (impossible travel)
- Identical sequence numbers or nonces appearing in protocol logs
- Network flow analysis showing retransmitted authentication byte sequences

---

## Defensive Measures

### Protocol-Level Defenses

**1. Enforce Nonce Usage**
Ensure all authentication protocols incorporate server-generated random challenges that must be incorporated into responses:

```python
import secrets
import hashlib

# Server generates nonce
nonce = secrets.token_hex(32)
# Client must HMAC the nonce with the shared secret
import hmac
response = hmac.new(shared_secret.encode(), nonce.encode(), hashlib.sha256).hexdigest()
# Server verifies and marks nonce as used — never reuse it
used_nonces.add(nonce)
```

**2. Implement Short Token Lifetimes**

```nginx
# Nginx — short session timeout
proxy_cookie_path / "/; Max-Age=3600; Secure; HttpOnly; SameSite=Strict";
```

```apache
# Apache session timeout
Session On
SessionMaxAge 3600
SessionCookieName session path=/;HttpOnly;Secure
```

**3. Kerberos Hardening**
```
# Group Policy: Maximum tolerance for computer clock synchronization
# Set to 5 minutes (default) — never increase this
Computer Configuration → Windows Settings → Security Settings →
  Account Policies → Kerberos Policy →
  Maximum tolerance for computer clock synchronization: 5 minutes

# Ensure NTP is synchronized
w32tm /query /status
w32tm /resync /force
```

**4. Disable NTLMv1, Enforce NTLMv2**
```powershell
# Registry: Force NTLMv2 only
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" `
  -Name "LmCompatibilityLevel" -Value 5
# Value 5 = Send NTLMv2 response only, refuse LM and NTLM
```

**5. Enable TLS for All Authentication Traffic**
Prevents packet capture of session tokens over the wire:
```bash
# Test for HTTP fallback that could expose tokens
curl -I http://target.example.com/login
# Should return 301/302 redirect to HTTPS, never serve auth over HTTP
```

**6. Implement Anti-Replay in IPsec**

```
# strongSwan IPsec configuration with replay window
conn secure-tunnel
    left=%defaultroute
    right=10.0.0.1
    ikelifetime=60m
    keylife=20m
    rekeymargin=3m
    replaywindow=32        # Anti-replay window size (packets)
    esp=aes256-sha256!
    ike=aes256-sha256-modp2048!
    auto=start
```

**7. Bind Session Tokens to Client Context**

```python
# Flask: Bind session to IP and User-Agent
from flask import request, session
import hashlib

def create_bound_session(user_id):
    binding = hashlib.sha256(
        f"{request.remote_addr}{request.headers.get('User-Agent')}".encode()
    ).hexdigest()
    session['user_id'] = user_id
    session['binding'] = binding

def validate_session():
    binding = hashlib.sha256(
        f"{request.remote_addr}{request.headers.get('User-Agent')}".encode()
    ).hexdigest()
    return session.get('binding') == binding
```

**8. Monitor and Alert on Replay Indicators**

```bash
# Splunk query for duplicate Kerberos TGT requests
index=windows Event