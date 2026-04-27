Here is the raw Markdown output for your Obsidian knowledge base:

---
domain: "cryptography"
tags: [downgrade-attack, tls, cryptography, mitm, protocol-security, network-attack]
---
# Downgrade Attack

A **downgrade attack** (also called a **version rollback attack** or **bidding-down attack**) is a form of cryptographic or protocol attack in which a [[Man-in-the-Middle|man-in-the-middle]] adversary coerces two communicating parties into abandoning a strong security mode in favor of a weaker, older, or deprecated one that both endpoints still support for backward compatibility. Rather than breaking strong cryptography directly, the attacker exploits **negotiation logic** and **legacy fallback** mechanisms to trick the client and server into speaking an inferior dialect — such as **SSL 3.0 instead of TLS 1.2**, **export-grade RSA instead of modern RSA**, or **HTTP instead of HTTPS** — which the attacker can then passively decrypt, tamper with, or brute-force. Downgrade attacks are a central topic in [[TLS]] security, [[Wireless Security|wireless authentication]], and [[Email Security|email transport encryption]], and they appear explicitly in the CompTIA Security+ SY0-701 objectives under cryptographic attacks.

---

## Overview

Downgrade attacks exist because real-world protocols must interoperate with a long tail of older clients, servers, and devices. When a modern TLS 1.3 browser connects to a legacy server that only speaks TLS 1.0, the handshake must negotiate a common version. This negotiation — typically unauthenticated or only weakly authenticated in its earliest phases — is where the downgrade happens. An attacker sitting on the network path (for example, on an open Wi-Fi network, a compromised router, or via [[ARP Spoofing|ARP spoofing]]) modifies handshake messages or injects errors that cause one side to retry with a weaker configuration. Once the connection is established over the weaker primitive, the attacker can mount a secondary attack — padding-oracle, factoring, dictionary, or plaintext interception.

The concept predates TLS. It appears in the history of [[SSL]] (the 1996 SSL 2.0 rollback attack described by Wagner and Schneier), in **cellular networks** where rogue base stations force phones from 4G/5G down to 2G GSM to intercept calls and SMS, in **Wi-Fi** where WPA3 transition mode can be coerced into WPA2 four-way handshakes capturable by [[Hashcat]], and in **SMTP** where **STRIPTLS** attacks remove the `STARTTLS` capability advertisement so mail is sent in cleartext. The attack family therefore spans multiple OSI layers and has driven many modern protocol redesigns.

Historically, the most influential public demonstrations were **POODLE** (2014, CVE-2014-3566), which forced browsers to fall back to SSL 3.0 and exploited its CBC padding; **FREAK** (2015, CVE-2015-0204), which tricked servers into negotiating 512-bit "export-grade" RSA keys that could be factored in hours on cloud hardware; and **Logjam** (2015, CVE-2015-4000), which downgraded Diffie-Hellman to 512-bit export parameters. These attacks were made possible by **1990s-era U.S. export controls** that required weak "export ciphers" in shipped software; the code paths remained in servers for two decades after the controls were lifted.

Modern protocols explicitly defend against downgrade. TLS 1.3 embeds a **downgrade sentinel** in the server's random value (`DOWNGRD\x01` / `DOWNGRD\x00`) so a client that supports 1.3 will detect if an MITM forced it to 1.2 or lower. WPA3 specifies that devices in transition mode must include a **Transition Disable** indication once a pure WPA3 network is confirmed. HTTP Strict Transport Security ([[HSTS]]) tells browsers to refuse plaintext HTTP entirely for a given origin, neutralizing tools like `sslstrip`. These defenses illustrate a general design principle: **every negotiated parameter must be authenticated by the final session key** so that retroactive tampering is detectable.

In operational security, downgrade attacks are a reminder that **"supports strong crypto" is not the same as "uses strong crypto"**. A server can advertise TLS 1.3 and AES-256-GCM but still accept TLS 1.0 with RC4 for a legacy client — and an attacker will always choose the weakest option the server permits. Hardening therefore means **removing** weak options, not merely preferring strong ones.

## How It Works

The canonical downgrade attack targets the **protocol version negotiation** of TLS. In a normal TLS handshake, the client sends a `ClientHello` containing the highest version it supports and a list of cipher suites; the server replies with a `ServerHello` selecting the highest mutually supported version. An on-path attacker who can modify packets executes the following steps:

1. **Intercept the ClientHello.** The attacker sits between client and server, typically achieved through [[ARP Spoofing]], [[DNS Spoofing]], a rogue Wi-Fi AP, or BGP hijack.
2. **Trigger fallback.** The attacker either drops the handshake (causing the browser's **insecure fallback** logic to retry with a lower version) or edits the `ClientHello` to advertise only older versions or weaker cipher suites.
3. **Complete the weakened handshake.** Client and server finish the negotiation using, e.g., SSL 3.0 with RC4 or CBC, or TLS 1.0 with an export-grade cipher.
4. **Exploit the weak primitive.** Depending on what was negotiated, the attacker runs a follow-on attack: POODLE's padding oracle, BEAST's chosen-plaintext CBC attack, FREAK's offline RSA-512 factorization, or Logjam's precomputed Diffie-Hellman discrete log.

A simplified `sslstrip`-style HTTPS→HTTP downgrade looks like this on the wire:

```
Victim ──GET http://bank.example──► [Attacker] ──GET https://bank.example──► Server
Victim ◄──200 OK (cleartext HTML)── [Attacker] ◄──200 OK (TLS ciphertext)── Server
```

The attacker terminates TLS with the server and serves plaintext HTTP to the victim, rewriting `https://` links in responses to `http://`. The victim's browser shows no lock icon, but users often miss this.

A TLS cipher downgrade using a tampered `ClientHello` in Python-like pseudocode:

```python
# Attacker on path rewrites ClientHello
original_ciphers = [
    0x1301,  # TLS_AES_128_GCM_SHA256      (TLS 1.3)
    0xC02F,  # ECDHE-RSA-AES128-GCM-SHA256 (TLS 1.2)
    0x000A,  # TLS_RSA_WITH_3DES_EDE_CBC_SHA
]
tampered_ciphers = [0x000A]  # force weak, non-PFS, 3DES-CBC
client_hello.cipher_suites = tampered_ciphers
client_hello.supported_versions = [0x0301]  # TLS 1.0
forward(client_hello)
```

For **POODLE** specifically, the attacker uses JavaScript in the victim's browser to generate many HTTPS requests, kills each TLS handshake until the browser retries with SSL 3.0, then exploits SSL 3.0's non-deterministic CBC padding to recover one plaintext byte per ~256 requests. Recovering a session cookie of 16 bytes takes roughly 4,096 requests.

**STARTTLS stripping** in SMTP works at port 25. When the client sends `EHLO`, the server replies with capabilities including `250-STARTTLS`. An MITM rewrites that line — for example to `250-XXXXXXXX` — so the client never attempts to upgrade, and the mail flows in cleartext.

**Kerberos** has a historical downgrade path: a client requesting a service ticket may be issued one encrypted with **RC4-HMAC** (RC4 being weak) if the KDC or service account is configured to allow it. Attackers abuse this in **[[Kerberoasting]]** to crack service account passwords offline.

**Cellular IMSI catchers** ("Stingrays") broadcast a rogue 2G base station with a stronger signal than legitimate towers. Phones honor the base station's instructions and drop to GSM, where the A5/1 cipher is broken and authentication is one-way.

In each case, the common thread is: **negotiation occurs before authentication of the peer and before strong keys are in place**, so the negotiation itself can be tampered with.

## Key Concepts

- **Version Rollback**: Forcing endpoints to use an older, weaker protocol version (e.g., TLS 1.2 → SSL 3.0). Mitigated by TLS 1.3's downgrade sentinel bytes in `ServerHello.random`.
- **Cipher Suite Downgrade**: Restricting negotiation to weak ciphers such as RC4, 3DES, export RSA-512, or anonymous Diffie-Hellman. Detected by modern clients refusing to negotiate suites below a policy floor.
- **Insecure Fallback**: Legacy client behavior where, after a handshake failure, the client retries with a weaker configuration — the attacker exploits this by inducing deliberate failures. Mitigated by **TLS_FALLBACK_SCSV** (RFC 7507).
- **STRIPTLS / Opportunistic Encryption Stripping**: Removing the advertisement of optional encryption upgrades (STARTTLS, `Upgrade: h2c`) in cleartext control channels. Defended by [[MTA-STS]], [[DANE]], and HSTS.
- **Transition Mode Abuse**: In WPA3-Transition and mixed WPA2/WPA3 deployments, an attacker forces clients onto the WPA2 SAE-less path, enabling PMKID capture. Known as **Dragonblood** (CVE-2019-9494).
- **Export-Grade Cryptography**: Artificially weakened ciphers (≤512-bit RSA/DH, 40-bit symmetric) mandated for 1990s U.S. export; residual server support enabled FREAK and Logjam.
- **Downgrade Sentinel**: A construction (e.g., TLS 1.3's `44 4F 57 4E 47 52 44 01`) embedded in authenticated handshake material so the final session key binds the chosen version, making silent downgrades detectable.

## Exam Relevance

For **SY0-701**, downgrade attacks appear under **Domain 2.0 (Threats, Vulnerabilities, and Mitigations)**, specifically the **cryptographic attacks** sub-objective. Expect questions that:

- Ask you to identify a scenario ("an attacker forces the connection to SSL 3.0") and choose `Downgrade attack` from options including collision, birthday, and replay attacks.
- Pair downgrade with a named CVE. Know **POODLE (SSL 3.0)**, **FREAK (export RSA)**, and **Logjam (export DH)** by name.
- Test the mitigation: disable SSLv2, SSLv3, TLS 1.0, TLS 1.1; enforce **TLS 1.2+** or **TLS 1.3**; implement **HSTS**; use **TLS_FALLBACK_SCSV**.
- Contrast downgrade with **replay** (retransmission of valid captured data) and **on-path/MITM** (a downgrade is a *technique used by* an on-path attacker, not a synonym for one).

**Gotchas:**
- A downgrade attack requires an **active MITM position**; it is not purely passive eavesdropping.
- The vulnerability is in the **protocol negotiation**, not necessarily in the cryptography itself — strong crypto with weak negotiation still fails.
- **SSL stripping** is a form of downgrade even though it is often listed separately in study materials.
- WPA3's transition mode is a downgrade vector even on networks running "modern" Wi-Fi hardware.
- TLS 1.2 is currently acceptable; TLS 1.0 and 1.1 are deprecated per RFC 8996 (2021).

## Security Implications

Downgrade attacks undermine the confidentiality and integrity guarantees of transport-layer cryptography. Notable incidents and CVEs:

| CVE | Name | Mechanism | Impact |
|---|---|---|---|
| CVE-2014-3566 | POODLE | Forced SSL 3.0 fallback; CBC padding oracle | Plaintext cookie recovery |
| CVE-2015-0204 | FREAK | Export-grade RSA-512 forced | Key factorization in ~7 hours for $100 |
| CVE-2015-4000 | Logjam | Export DH-512 shared primes | State-level passive decryption of HTTPS/IPsec |
| CVE-2016-0800 | DROWN | Modern TLS downgraded via shared SSLv2 key | Cross-protocol session decryption |
| CVE-2019-9494 | Dragonblood | WPA3 SAE downgrade to WPA2 | PMKID capture, offline cracking |

**Detection** is difficult from the endpoints because a successful downgrade looks like a normal handshake. Network-level indicators include:

- TLS versions below 1.2 appearing in connection logs (`ssl.version` in Zeek or Suricata rule matches).
- `TLS_RSA_*` or `TLS_DHE_EXPORT_*` cipher suite IDs in ServerHello records.
- SMTP conversations that reach `EHLO` and `QUIT` without ever issuing `STARTTLS`.
- Unexpected cellular handovers to 2G detected via a mobile intrusion detection system or baseband debugger.
- HTTP traffic to domains known to enforce HSTS (indicates the browser's HSTS store may have been bypassed or the victim visited for the first time — the "trust on first use" window).

## Defensive Measures

**Protocol hardening — servers and endpoints:**

Disable SSLv2, SSLv3, TLS 1.0, and TLS 1.1 in all services. Require **TLS 1.2+**, prefer **TLS 1.3**. On nginx:

```nginx
ssl_protocols       TLSv1.2 TLSv1.3;
ssl_ciphers         ECDHE+AESGCM:ECDHE+CHACHA20:!aNULL:!MD5:!3DES:!RC4:!EXPORT;
ssl_prefer_server_ciphers on;
ssl_session_tickets off;
```

On Apache httpd:

```apache
SSLProtocol         all -SSLv2 -SSLv3 -TLSv1 -TLSv1.1
SSLCipherSuite      ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305
SSLHonorCipherOrder on
SSLSessionTickets   off
```

Remove export-grade ciphers and anonymous DH. Use only AEAD suites (AES-GCM, ChaCha20-Poly1305). Generate unique, ≥2048-bit DH parameters or use ECDHE exclusively:

```bash
openssl dhparam -out /etc/ssl/dhparams.pem 2048
```

Enforce `TLS_FALLBACK_SCSV` — set automatically by OpenSSL ≥ 1.0.1j; this signals to servers that a ClientHello is a fallback retry, so the server can reject it if it supports higher versions.

**Application layer:**

- Deploy **[[HSTS]]** with `max-age=63072000; includeSubDomains; preload` and submit the domain to