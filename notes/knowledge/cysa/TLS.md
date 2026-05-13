# TLS — Transport Layer Security

## What it is

In **Watch Dogs**, Aiden Pearce walks through downtown Chicago and his phone passively sniffs every unsecured channel around him — SMS messages, voice calls, private camera feeds, bank balances. The ctOS network treats most of that traffic like postcards. The few targets he can't crack on the fly are the ones running encrypted comms — those get a "decryption in progress" prompt, a minigame, and a time cost. That gap between "read it instantly" and "have to actually work for it" is the entire point of TLS.

In plain English: TLS is the lock on the pipe between two computers talking over a network. Without it, anyone sitting on the wire reads your traffic like Aiden reads a stranger's text messages. With it, they get ciphertext and a headache.

Technically: **Transport Layer Security** is a cryptographic protocol that provides **confidentiality**, **integrity**, and **authentication** for data in transit between a client and a server. It sits between the transport layer (TCP) and the application layer (HTTP, SMTP, IMAP, LDAP, etc.). It's the direct successor to [[SSL]] — SSL 2.0 and 3.0 are dead, TLS 1.0 and 1.1 are deprecated, and modern deployments run **TLS 1.2** or **TLS 1.3**.

When you see `https://` in a browser bar, that's HTTP wrapped in TLS. Same for SMTPS, IMAPS, LDAPS, FTPS, and the encrypted variants of every other plaintext protocol the 1990s gave us.

## Why it matters

TLS is the single most-deployed cryptographic control on the planet. Every web login, every API call, every SaaS sync, every cloud agent phoning home — TLS or nothing. For a SOC analyst, TLS is both a defender's best friend and an attacker's favorite hiding spot.

**Defender's friend:** TLS keeps credentials, session tokens, PII, CHD, and source code from being read off the wire by anyone with a tap.

**Attacker's hiding spot:** C2 traffic over HTTPS port 443 looks exactly like every other HTTPS connection in your NetFlow. Encrypted exfil to a Dropbox-lookalike domain blends into normal SaaS noise. The same protocol that protects you from passive sniffing also blinds your IDS to the payload.

**Exam relevance:** CS0-003 Objective 1.1 lists encryption, PKI, SSL, and network architecture under infrastructure concepts. TLS is the crossroads of all four. Expect questions on cert validation, cipher suite selection, deprecated versions, and how TLS interacts with [[SDN inspection]] and [[CASB]] visibility.

## Key facts

### The handshake — what actually happens

TLS 1.2 handshake (simplified, but the version CompTIA still loves):

1. **ClientHello** — client sends supported TLS versions, cipher suites, random nonce
2. **ServerHello** — server picks version + cipher, sends its certificate chain and random nonce
3. **Certificate validation** — client walks the chain to a trusted root CA, checks expiration, hostname (SAN/CN), revocation (OCSP/CRL)
4. **Key exchange** — typically ECDHE (Elliptic Curve Diffie-Hellman Ephemeral) to derive a shared session key with **forward secrecy**
5. **Finished** — both sides confirm, encrypted tunnel is up

TLS 1.3 collapses this into **one round trip** (1-RTT, or 0-RTT for resumed sessions), drops every weak primitive, and mandates forward secrecy. If a server still negotiates static RSA key exchange, it's TLS 1.2 or older — flag it.

### TLS 1.2 vs TLS 1.3

| Feature | TLS 1.2 | TLS 1.3 |
|---|---|---|
| Handshake RTTs | 2 | 1 (0 on resume) |
| Cipher suites | Hundreds, many weak | 5, all AEAD |
| Static RSA key exchange | Allowed | Removed |
| Forward secrecy | Optional | Mandatory |
| CBC mode ciphers | Allowed | Removed |
| Renegotiation | Allowed | Removed |
| SHA-1 | Allowed | Removed |

TLS 1.0 and 1.1 are deprecated as of **RFC 8996 (2021)**. PCI DSS forbids them for CHD. If your scanner finds them on a production endpoint, that's a finding, not a debate.

### Cipher suites — reading the string

A TLS 1.2 cipher suite like `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384` parses as:

- **ECDHE** — key exchange (ephemeral, has forward secrecy)
- **RSA** — authentication (server cert's key type)
- **AES_256_GCM** — bulk encryption (AEAD mode, good)
- **SHA384** — MAC / KDF hash

Red flags in cipher strings: `RC4`, `DES`, `3DES`, `MD5`, `EXPORT`, `NULL`, `anon`, `CBC` (in TLS 1.2 context). If you see these in a Qualys or Nessus scan output, they're remediation items.

### Certificates and PKI

TLS authentication rides on [[PKI]]. The chain:

- **Root CA** — self-signed, trusted by the OS/browser trust store, kept offline ideally
- **Intermediate CA** — signed by root, used for day-to-day issuance
- **Leaf certificate** — what your server actually presents

Validation checks the client runs every handshake:

- Chain terminates at a trusted root
- Not expired (`notBefore` / `notAfter`)
- Hostname matches the Subject Alternative Name (SAN — CN-only is dead)
- Not revoked — via **CRL** (Certificate Revocation List, batch) or **OCSP** (Online Certificate Status Protocol, real-time, often with stapling)
- Signature algorithm is acceptable (no SHA-1, no MD5)

When any of these fail, the browser throws a cert warning. Users click through them. *Train them not to, but assume they will.*

### Mutual TLS (mTLS)

Standard TLS authenticates the **server** to the client. **mTLS** also authenticates the **client** to the server via a client certificate. Heavy in [[zero trust]] architectures, service mesh (Istio, Linkerd), and API gateways. If your environment runs mTLS for service-to-service, a stolen bearer token isn't enough — the attacker also needs the client cert and key.

### TLS inspection — the defender's dilemma

You can't IDS what you can't read. Enterprises deploy **TLS interception** (also called SSL/TLS inspection, break-and-inspect) at the perimeter or via [[SASE]]/[[CASB]]:

1. The inspection proxy terminates TLS from the client
2. Decrypts, scans payload for malware/DLP signatures
3. Re-encrypts to the destination using its own internally-trusted CA

For this to work, every managed endpoint must trust the inspection CA. Unmanaged devices and certificate-pinned apps (banking apps, some mobile clients) break. Privacy and compliance carve-outs typically exempt healthcare, banking, and HR sites from inspection.

> **CompTIA exam trap:** TLS inspection is sometimes called "SSL inspection" or "deep packet inspection of TLS." All three refer to the same break-and-inspect pattern. CompTIA may also frame it as a control supporting [[DLP]] and [[CASB]] visibility — the right answer hinges on what visibility you lose without it, not on the protocol name.

### Common TLS-adjacent attacks

| Attack | What it does | Mitigation |
|---|---|---|
| **POODLE** | Forces downgrade to SSL 3.0, exploits CBC padding | Disable SSL 3.0 |
| **BEAST** | CBC IV reuse in TLS 1.0 | Disable TLS 1.0 / use AES-GCM |
| **CRIME / BREACH** | Compression-based info leak | Disable TLS compression |
| **Heartbleed (CVE-2014-0160)** | OpenSSL bug, leaks memory incl. private keys | Patch OpenSSL, rotate keys + certs |
| **Downgrade attacks** | Strip TLS or force weak version | HSTS, disable old versions, TLS_FALLBACK_SCSV |
| **Cert mis-issuance** | Rogue CA signs attacker's cert | Certificate Transparency logs, CAA records |

> **CompTIA exam trap:** After Heartbleed, the correct response was not "patch OpenSSL and move on." You also had to **revoke and reissue every cert** on affected servers, because the private keys were potentially exposed. CompTIA tests this — "patch the vulnerability" alone is the wrong answer when key material was compromised.

### Where TLS shows up in CySA+ ops

- **Log ingestion over the wire** — Syslog over TLS (RFC 5425) instead of UDP 514 plaintext. If your endpoints ship logs unencrypted, an attacker on the LAN can tamper with them in flight.
- **Time sync** — NTS (Network Time Security) wraps NTP in TLS-style auth. Stops attackers from spoofing time and breaking your [[chain of custody]] timeline.
- **Cloud agent comms** — every EDR, every cloud connector, every SaaS API call. Pinned certs preferred.
- **Sensitive data protection** — TLS protects PII, PHI, CHD in transit. At rest is a different control (disk encryption, field-level encryption). Exam: don't confuse the two.
- **PAM session brokering** — privileged session connections to jump hosts ride TLS or SSH. Plain RDP/HTTP on a jump host is a finding.

### Configuration hardening checklist

- Disable SSL 2.0, SSL 3.0, TLS 1.0, TLS 1.1
- Enable TLS 1.2 (with strong suites only) and TLS 1.3
- Disable RC4, 3DES, CBC suites, export ciphers, anonymous suites
- Require AEAD ciphers (GCM, ChaCha20-Poly1305)
- Enable HSTS with a long max-age on public-facing web
- Use OCSP stapling
- Publish CAA DNS records to constrain who can issue for your domain
- Monitor Certificate Transparency logs for unauthorized issuance
- Rotate certs before expiry — automate with ACME / Let's Encrypt / internal CA
- Use ECDSA or RSA-2048 minimum; RSA-1024 is dead

Tools the SOC and vuln-mgmt teams actually use: `sslscan`, `testssl.sh`, `nmap --script ssl-enum-ciphers`, Qualys SSL Labs (external), and whatever your scanner of choice surfaces.

## SOC reality

- The 3am alert is almost never "TLS is broken." It's "expired cert on a production endpoint, customer-facing app down, executive on the phone." Cert lifecycle hygiene is a boring P1 generator. Know where your CMDB tracks expirations or build the alerting yourself.
- When IR pulls PCAP during an incident, the analyst's first complaint is "everything is TLS, I can't see the payload." Decryption requires either pre-master keys logged via `SSLKEYLOGFILE` (browser/dev environments only), an inspection proxy's archived sessions, or endpoint telemetry that captured the plaintext before encryption. Plan for this *before* the incident.
- The CISO asks "are we exposed?" when a new TLS CVE drops. Real answer: "scan all listeners, prioritize internet-facing, identify which use the affected library, plan rotation if keys were exposed." Don't say "we're patched" until you've checked the library version *and* whether key material needs rotating.
- Never promise leadership that TLS-encrypted C2 is invisible to you. Modern EDR sees the process making the connection, the destination, the JA3/JA3S fingerprint, the cert hash. You don't need to decrypt to detect — you need to correlate.
- Handoff: vuln mgmt owns the scan finding. App team owns the cert and the config. SOC owns the C2 detection over TLS. PKI team (or whoever stole that hat) owns the CA. When the cert expires at 2am, everyone blames everyone — *write down ownership in the runbook before it matters*.

## Related concepts

[[PKI]] · [[SSL]] · [[Encryption]] · [[Zero Trust]] · [[CASB]] · [[SASE]] · [[SDN inspection]] · [[DLP]] · [[PAM]] · [[MFA]] · [[Log ingestion]] · [[Time synchronization]] · [[Network segmentation]] · [[Sensitive data protection]] · [[Cipher suites]] · [[Certificate Transparency]] · [[HSTS]]

*Source: VIRGIL knowledge base — 2026-05-11*