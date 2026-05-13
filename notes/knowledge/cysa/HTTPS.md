# HTTPS — Hypertext Transfer Protocol Secure

## What it is

In **Pac-Man**, when you eat a power pellet the ghosts turn blue and you can't tell which one is Blinky and which one is Clyde — they all look the same, same color, same shape, same vector. You know *something* is moving through the maze, you just can't tell *what* or *who* until the effect wears off. That's exactly what HTTPS does to network traffic — the SOC can see the connection, the volume, the timing, the destination IP, but the payload is wrapped in TLS and the on-wire bytes are opaque. The packet capture shows you ghosts, not identities.

**Plain English:** HTTPS is HTTP wrapped in TLS. Same protocol, same verbs (GET, POST), same headers — except the whole conversation is encrypted end-to-end between the client and the server. Default port **TCP/443**.

**Technical:** HTTPS uses TLS (currently 1.2 and 1.3, with 1.0/1.1 deprecated) to provide confidentiality, integrity, and server authentication via X.509 certificates. The client and server negotiate a cipher suite, exchange keys (ECDHE for forward secrecy), validate the cert chain, and tunnel HTTP messages inside the encrypted session. From a SIEM perspective, the application layer is invisible without [[TLS Inspection]] or endpoint-side telemetry.

## Why it matters

By 2026, somewhere north of 95% of web traffic is HTTPS. That's a defender's win for users — and a defender's nightmare for the SOC. Every modern [[Command and Control]] channel rides HTTPS because it blends into the noise. Cobalt Strike beacons, Sliver, Mythic, Empire — all default to HTTPS C2. Malware downloads, data exfil, credential phishing — all HTTPS. Your firewall sees `443/tcp → CDN-edge-IP`. So does every legitimate browser tab on the network.

**Exam relevance:** CS0-003 Objective 1.3 covers tools and techniques for determining malicious activity. HTTPS is the protocol you spend the most time analyzing *around* — because you usually can't analyze *inside* it. You need to know which artifacts survive encryption (SNI, JA3/JA3S fingerprints, cert details, timing, volume, DNS) and which don't (URI paths, headers, body, cookies).

## Key facts

### The HTTPS handshake — what's visible on the wire

Even without decryption, [[Wireshark]] / [[Packet capture]] gives you forensic gold from the handshake:

| Field | Where | What it tells you |
|---|---|---|
| **SNI** (Server Name Indication) | ClientHello | The hostname the client *thinks* it's connecting to. Cleartext in TLS 1.2; encrypted in TLS 1.3 if ECH is negotiated. |
| **JA3** | ClientHello | Hash of the client's TLS fingerprint (version, ciphers, extensions). Identifies the *client software*, not the user. |
| **JA3S** | ServerHello | Server-side fingerprint. Useful for fingerprinting C2 infrastructure. |
| **Certificate** | Server cert chain | Issuer, subject, validity dates, SANs. Self-signed or Let's Encrypt cert on a "bank" domain = red flag. |
| **Cipher suite** | Negotiated | Weak/deprecated ciphers (RC4, 3DES, NULL) indicate misconfigured or hostile endpoints. |

*The handshake is the only part of HTTPS that talks to you for free. Learn to read it.*

### What survives encryption

- **DNS queries** — the client resolves the hostname before the TLS handshake. [[DNS]] logs are your first lookup point. Match the resolved IP to the 443 flow.
- **NetFlow / IPFIX** — source, dest, bytes, packets, duration. Beaconing pattern (regular interval, low volume, long-lived) is detectable here.
- **TLS metadata** — SNI, JA3/JA3S, cert fingerprint.
- **Destination reputation** — feed the IP/domain into [[VirusTotal]], [[AbuseIPDB]], [[WHOIS]], threat intel. New domain (< 30 days old), no reputation, registered through a privacy proxy = suspicious.

### What you lose without TLS inspection

- URI path, query string, headers (User-Agent, Referer, Cookie)
- Request body — POST data, exfil payloads, uploaded files
- Response body — downloaded malware, returned commands from C2

If you need any of those, you need either **TLS inspection at the perimeter** (corporate CA cert pushed to endpoints, MITM proxy decrypts and re-encrypts) or **endpoint telemetry** ([[EDR]] sees the process making the call and the cleartext buffer in memory before encryption).

### TLS inspection — where it works, where it doesn't

- **Works:** managed corporate endpoints with the inspection CA in their trust store. SSL forward proxies (Zscaler, Palo Alto, Bluecoat) decrypt-inspect-re-encrypt.
- **Breaks on:** certificate pinning (banking apps, Apple/Google services), client cert auth, TLS 1.3 with ECH, BYOD, contractors, IoT.
- **Legal/HR friction:** healthcare portals, banking, legal counsel sites — usually carved out of decryption policy. Threat actors know this and abuse it.

### Detecting malicious HTTPS without decryption

This is the bulk of real SOC work. You're not decrypting; you're profiling.

- **Beaconing detection** — regular interval connects to the same destination. Cobalt Strike default jitter, Empire, Metasploit reverse_https. SIEM rule: `count(distinct intervals) low + connection count high + bytes per connection low`.
- **JA3 hashing** — known-bad JA3s for Cobalt Strike, Sliver, etc. Maintained by communities (SaltStack JA3 repo, abuse.ch). Match against your TLS metadata feed.
- **Domain fronting** — SNI says `legitimate-cdn.com`, Host header (which you can't see) says `malicious-c2.com`. Detectable if you see traffic to a CDN edge with weird volume/timing.
- **Newly registered domains (NRD)** — pull WHOIS, flag domains < 30 days old. Phishing infrastructure churns fast.
- **Cert anomalies** — Let's Encrypt cert on a domain mimicking your brand, wildcard certs on suspicious infrastructure, mismatched SAN entries.
- **User-Agent absence in client fingerprint** — TLS clients that aren't browsers (curl, python-requests, PowerShell `Invoke-WebRequest`) have distinctive JA3s.

### Where HTTPS lies inside the kill chain

| Phase | HTTPS role |
|---|---|
| **Delivery** | Phishing link to HTTPS landing page (cert makes it look legit) |
| **Exploitation** | Malicious JS / drive-by from compromised HTTPS site |
| **Installation** | Stager downloads payload over HTTPS |
| **[[Command and Control]]** | HTTPS beacon to attacker infrastructure |
| **Exfiltration** | POST or chunked upload to attacker HTTPS endpoint |

*Every phase after delivery can ride HTTPS. The padlock icon is a transport guarantee, not a trust signal.*

### Tools you actually reach for

- **[[Wireshark]]** — TLS handshake inspection, cert extraction, JA3 calculation (with the JA3 plugin), flow reconstruction
- **tshark / tcpdump** — scripted capture, filter expressions for SNI extraction
- **Zeek (formerly Bro)** — generates `ssl.log` and `x509.log` automatically; the SOC's best friend for TLS metadata at scale
- **Suricata** — TLS rule matching, JA3 matching, alerts on cert anomalies
- **[[VirusTotal]]** — submit destination domain/IP, get reputation, related samples, passive DNS
- **[[AbuseIPDB]]** — community-reported abuse history for the destination IP
- **[[WHOIS]]** — registrar, creation date, registrant (often privacy-shielded but creation date is gold)
- **[[Joe Sandbox]] / [[Cuckoo Sandbox]]** — detonate a suspicious URL, watch the HTTPS traffic from inside a controlled environment where you *can* MITM it
- **curl / openssl s_client** — manually pull a cert, inspect SAN entries, check cipher support
- **JA3 lookup repos** — abuse.ch SSLBL, community JA3 fingerprint feeds

### CompTIA exam traps

> **CompTIA exam trap:** HTTPS does **not** authenticate the user — it authenticates the *server* (via cert) and optionally the client (via client cert, rare). Don't confuse HTTPS with user authentication. A phishing site over HTTPS is fully encrypted and fully malicious.

> **CompTIA exam trap:** TLS 1.3 encrypts the certificate exchange. In TLS 1.2 you can see the server cert in the clear during the handshake; in TLS 1.3 you can't (unless ECH isn't used, the cert appears after key exchange but encrypted). Exam may ask which version exposes cert details on the wire — answer: 1.2.

> **CompTIA exam trap:** **Port 443 is TCP.** QUIC/HTTP3 runs over UDP/443. If the exam asks "which port AND protocol" — TCP/443 for classic HTTPS, UDP/443 for HTTP/3. Easy point if you remember it.

> **CompTIA exam trap:** SNI is **cleartext by default in TLS 1.2 and 1.3**. ECH (Encrypted Client Hello) is the extension that encrypts SNI, and it's not universally deployed. Don't assume SNI is encrypted just because the rest of the handshake is.

## SOC reality

- **The 3am alert:** "Unusual outbound HTTPS to newly registered domain, 47 connections in 60 minutes from `WKSTN-FINANCE-12`, average 4KB per session, regular 90-second interval." That's beaconing. Doesn't matter that it's encrypted — the *pattern* is the IoC.
- **L1's first move:** pull the Zeek `ssl.log` entries, grab the SNI, run it through VirusTotal and AbuseIPDB, check domain creation date in WHOIS. If the domain is < 7 days old and has zero reputation, escalate to L2 immediately. Don't wait for the malware sample.
- **What the IR lead asks:** "Do we have endpoint visibility on that host? What process opened the socket? Pull EDR — show me the process tree. Is the cert pinned or did our proxy decrypt it? If decrypted, where's the request body?"
- **Never promise leadership:** "We've blocked it at the firewall." You blocked one IP. The C2 has 40 more. You blocked one domain. DGA generates 2000 a day. Block at the destination *and* contain the endpoint *and* hunt for lateral spread.
- **Handoff:** L1 triages the SIEM alert and enriches with TI. L2 confirms the beacon pattern, pulls EDR telemetry, validates the process. IR team isolates the host, captures memory, and starts scope analysis. If exfil is confirmed, legal gets the call for breach notification timelines.

## Related concepts

[[TLS]] · [[HTTP]] · [[DNS]] · [[Command and Control]] · [[Beaconing]] · [[Wireshark]] · [[Packet capture]] · [[VirusTotal]] · [[AbuseIPDB]] · [[WHOIS]] · [[JA3 Fingerprinting]] · [[TLS Inspection]] · [[Certificate Pinning]] · [[Domain Fronting]] · [[Newly Registered Domains]] · [[EDR]] · [[Zeek]] · [[Suricata]] · [[SIEM]] · [[NetFlow]] · [[Cyber Kill Chain]] · [[MITRE ATT&CK]]

*Source: VIRGIL knowledge base — 2026-05-11*