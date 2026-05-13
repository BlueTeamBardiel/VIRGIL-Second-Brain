# SSL — Secure Sockets Layer

## What it is

In **League of Legends**, when you ward a bush, you're not making the bush invisible — you're making sure *only your team* sees what's inside it. The enemy jungler walks through, your warding totem lights him up, but to him the bush still looks empty. Riot's servers also encrypt the client-server packets so a guy on your LAN can't sniff your champion select or your ranked match and grief you. That ward-and-tunnel discipline — "only the people who should see this, see this" — is what SSL does for network traffic.

**Plain English:** SSL is the encryption layer that turns "anyone on the wire can read this" into "only the two endpoints with the right keys can read this." Every time you see the lock icon in a browser, that's SSL's successor (TLS) doing its job.

**Technical:** **Secure Sockets Layer (SSL)** is a cryptographic protocol designed by Netscape in 1995 to provide confidentiality, integrity, and authentication for data in transit between two networked hosts. SSL has been formally **deprecated** — SSL 2.0 (RFC 6176, 2011) and SSL 3.0 (RFC 7568, 2015) are prohibited. The protocol family lives on as **Transport Layer Security (TLS)** — TLS 1.2 (RFC 5246) and TLS 1.3 (RFC 8446) are the currently acceptable versions. Industry still calls it "SSL" colloquially ("SSL certificate," "SSL inspection," "SSL VPN") even though the actual bytes on the wire are TLS. CompTIA tests both names.

## Why it matters

Encrypted traffic is now ~95% of web traffic. That's good for users and a nightmare for SOC analysts. Attackers know defenders can't read what they can't decrypt, so C2 traffic, exfil, and malware delivery all ride TLS now. If your SOC can't inspect TLS, you're triaging blind on the most-used channel in your environment.

**Exam relevance — Objective CS0-003 1.1:** infrastructure concepts. SSL/TLS shows up wherever encryption, PKI, [[CASB]], [[SASE]], and [[Zero Trust]] are tested. It is the glue protocol of modern network architecture. You will see it in questions about [[PKI]], certificate validation, SSL/TLS inspection, [[VPN]] termination, and sensitive data protection.

## Key facts

### Where SSL/TLS sits

| Layer | Protocol | Purpose |
|---|---|---|
| 7 Application | HTTP, SMTP, IMAP, FTP | The actual data |
| 6 Presentation | **TLS/SSL** | Encrypt before the OS sends it |
| 4 Transport | TCP | Reliable delivery |
| 3 Network | IP | Routing |

SSL/TLS rides on TCP. UDP gets **DTLS** (Datagram TLS) for things like WebRTC and some VPN protocols. The protocol does three jobs at once:

- **Confidentiality** — symmetric encryption (AES-GCM, ChaCha20) of the payload
- **Integrity** — MAC or AEAD construction so tampering is detected
- **Authentication** — X.509 certificates prove the server is who it claims (and optionally the client)

### Version reality (this is exam gold)

| Version | Year | Status | Notes |
|---|---|---|---|
| SSL 2.0 | 1995 | **Prohibited** | Broken; RFC 6176 |
| SSL 3.0 | 1996 | **Prohibited** | POODLE attack; RFC 7568 |
| TLS 1.0 | 1999 | **Deprecated** | Disabled by PCI DSS, browsers |
| TLS 1.1 | 2006 | **Deprecated** | Same as above |
| TLS 1.2 | 2008 | **Acceptable** | Still dominant; configure carefully |
| TLS 1.3 | 2018 | **Preferred** | Faster handshake, forward secrecy mandatory |

TLS 1.3 dropped the cruft: no RSA key exchange, no static DH, no CBC modes, no SHA-1, no compression. It also encrypts more of the handshake — which means **SNI (Server Name Indication)** can leak less if **ECH (Encrypted Client Hello)** is in play, and that has implications for [[DNS filtering]] and [[CASB]] visibility.

### The handshake (TLS 1.2 version, the one CompTIA still tests)

1. **ClientHello** — client lists supported ciphers, TLS versions, extensions
2. **ServerHello** — server picks a cipher suite, sends its certificate chain
3. **Client validates the cert** — chain to a trusted root, valid dates, not revoked ([[CRL]] / [[OCSP]]), matching hostname
4. **Key exchange** — usually ECDHE for [[forward secrecy]]
5. **Finished** — both sides switch to the negotiated symmetric cipher

TLS 1.3 collapses this to one round trip (1-RTT), with optional 0-RTT for resumed sessions. Faster, but 0-RTT data is replayable, which matters for some app designs.

### PKI — the trust spine

SSL/TLS leans on **[[Public Key Infrastructure (PKI)]]**:

- **Certificate Authority (CA)** issues certs. Public CAs (DigiCert, Let's Encrypt, Sectigo) are in browser trust stores. Internal CAs are trusted by your domain endpoints.
- **X.509 certificate** binds a public key to an identity (CN, SAN fields).
- **Chain of trust** — leaf cert → intermediate CA → root CA. If any link fails validation, the whole chain dies.
- **Revocation** — [[CRL]] (Certificate Revocation List, a download) or **[[OCSP]]** (Online Certificate Status Protocol, a real-time query). **OCSP stapling** lets the server include a fresh OCSP response in the handshake so the client doesn't have to call out.

### SSL/TLS inspection (the SOC's secret weapon and worst headache)

Encrypted traffic blinds defenders. The fix is **SSL/TLS inspection** (also called SSL decryption or break-and-inspect):

1. The perimeter device ([[NGFW]], [[proxy]], [[CASB]], [[SASE]] node) terminates the user's TLS session
2. Decrypts and inspects the cleartext for malware, DLP violations, policy hits
3. Re-encrypts with its own cert and forwards to the destination

For this to work, every endpoint trusts an **internal root CA** that the inspection device uses to mint on-the-fly certs. Without that root deployed, every browser screams certificate error.

**What you cannot inspect this way:**
- **Certificate pinning** — apps that hardcode the expected cert fingerprint (banking apps, some mobile apps, some auto-update channels) will refuse the swapped cert and fail. You have to bypass these by domain.
- **Mutual TLS (mTLS)** — if the client must present a cert too, the inspection box can't impersonate the client without holding the client cert.
- **Privacy-protected categories** — health, banking, legal. Most orgs configure bypass lists for these to avoid legal exposure.

> **CompTIA exam trap:** SSL inspection is sometimes called "man-in-the-middle as a service" — and that's literally what it is. The difference between a legitimate inspection deployment and an attack is **trust**: the endpoints explicitly trust the inspector's root CA. Without that trust pre-deployed, the inspection is an attack. CompTIA will test this distinction.

### Where SSL/TLS shows up in the CS0-003 architecture stack

- **[[Zero Trust]]** — every connection authenticated and encrypted, end to end. TLS everywhere, mTLS for service-to-service.
- **[[CASB]]** — sits between users and SaaS, often performs TLS inspection to enforce DLP and shadow IT controls.
- **[[SASE]]** — cloud-delivered SSE bundle (SWG + CASB + ZTNA + FWaaS) doing TLS inspection at the edge.
- **[[SDN]]** — control-plane traffic between SDN controller and switches must ride TLS; otherwise an attacker on the management network owns the network.
- **VPN** — SSL VPN (OpenVPN, AnyConnect) tunnels traffic over TLS instead of IPsec. Easier through firewalls, harder to detect malicious use of.
- **Sensitive data protection / [[PII]] / [[CHD]]** — PCI DSS req 4 mandates strong cryptography for cardholder data in transit. TLS 1.2+ with strong ciphers is the baseline.
- **Log ingestion** — your [[SIEM]] forwarders (syslog-ng, Splunk UF, Beats) should send over TLS. Cleartext syslog over UDP/514 is a holdover that still bites people.

### Common SSL/TLS attacks (know the names)

| Attack | Target | Fix |
|---|---|---|
| POODLE | SSL 3.0 CBC padding | Disable SSL 3.0 |
| BEAST | TLS 1.0 CBC | TLS 1.2+ with GCM |
| CRIME / BREACH | Compression oracle | Disable TLS compression |
| Heartbleed | OpenSSL heartbeat bug (CVE-2014-0160) | Patch OpenSSL |
| FREAK / Logjam | Export-grade cipher downgrade | Disable export ciphers |
| DROWN | SSLv2 cross-protocol | Disable SSLv2 everywhere |
| **Strip / SSL strip** | Force HTTP instead of HTTPS | HSTS header, HSTS preload list |

### CompTIA exam traps

> **Trap 1:** SSL ≠ TLS in the spec, but the industry treats them as synonymous in product names. If the question says "SSL VPN" or "SSL certificate," it almost always means TLS underneath. Don't get baited into picking "this is impossible because SSL is deprecated."

> **Trap 2:** A valid certificate does **not** mean a safe site. Let's Encrypt issues free DV certs in 90 seconds — phishing sites get them too. The cert proves "the domain owner authorized this key." It does not prove "the domain is benign." [[Threat intelligence]] and reputation feeds matter as much as cert validation.

> **Trap 3:** **Self-signed certs** are not inherently bad — they're appropriate for internal CAs, test environments, and any system where the trust is established out of band. The problem is *unexpected* self-signed certs in places where a CA-issued cert is expected. CompTIA tests the nuance.

> **Trap 4:** **Forward secrecy** (ECDHE, DHE) means compromising the server's private key later cannot decrypt past sessions. RSA key exchange does not have this property. TLS 1.3 mandates forward secrecy; TLS 1.2 allows it but doesn't require it. This is a frequent "which cipher suite is preferred" question.

## SOC reality

- At 3am the IDS lights up with "TLS handshake to known C2 domain." You can't read the payload — that's the whole point of TLS — but the SNI, JA3 fingerprint, certificate issuer, and destination IP are all visible and all useful. Modern SOC work on encrypted traffic is **metadata-driven**, not payload-driven, unless you've deployed inspection.
- The L1's first move on a suspicious TLS alert: pivot in the [[SIEM]] to find every other host that talked to that destination, pull the JA3/JA3S hash, check threat intel. Don't decrypt unless you have to — it's slow, legally fraught, and the inspection appliance may already be at capacity.
- The CISO question after a breach involving TLS exfil: *"Why didn't our DLP catch it?"* The honest answer is usually "because the C2 channel was TLS to a domain we don't inspect, and we don't inspect it because legal told us not to." Document those bypass decisions in writing — they will come up in the post-incident review.
- Never promise leadership "we have full visibility into encrypted traffic." You don't. You have visibility into the traffic you inspect, metadata for the rest, and a leap of faith for cert-pinned apps. *The lock icon is comfort for the user and a blindfold for the defender.*
- Handoff point: if the cert chain itself is the indicator (rogue CA, unexpected internal root pushed via GPO, cert from a CA you don't use), that's not an L1 ticket. Escalate to IR and the PKI team immediately — someone may have planted a trust anchor for long-term MITM.

## Related concepts

[[PKI]] · [[TLS]] · [[CASB]] · [[SASE]] · [[Zero Trust]] · [[SDN]] · [[CRL]] · [[OCSP]] · [[Certificate pinning]] · [[mTLS]] · [[HSTS]] · [[NGFW]] · [[SSL inspection]] · [[Forward secrecy]] · [[JA3 fingerprinting]] · [[PII]] · [[CHD]] · [[DLP]] · [[VPN]]

*Source: VIRGIL knowledge base — 2026-05-11*