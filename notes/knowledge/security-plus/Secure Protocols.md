# Secure Protocols

## What it is

In Overwatch, when Tracer says "Cheers, love!" your team hears it on voice comms — but the enemy Reaper flanking your backline doesn't. The audio is encrypted to your team's channel; opponents get nothing. That's exactly what secure protocols do — they take the same conversation an insecure protocol would broadcast in the clear and wrap it in cryptography so eavesdroppers get noise instead of payloads.

**Secure protocols** are network communication standards that provide confidentiality, integrity, and authentication — typically by layering [[TLS]], [[SSH]], or [[IPsec]] under or in place of legacy cleartext protocols.

## Why it matters

Cleartext protocols leak credentials, session tokens, DNS queries, email contents, and management commands to anyone with a [[packet sniffer]] and a [[SPAN port]]. Migrating to secure equivalents defeats [[on-path attack|on-path attacks]], [[credential harvesting]], and [[session hijacking]] — and it's a baseline expectation for [[PCI DSS]], [[HIPAA]], and most every other framework. SY0-701 Objective 4.5 explicitly requires you to "apply common security techniques to computing resources," which includes selecting secure protocols and their default ports. **CompTIA's favorite trap:** giving you a scenario, asking which protocol to use, and listing both the secure protocol AND its port — you must know both. Confusing **FTPS** (FTP over TLS, ports 989/990) with **SFTP** (FTP over SSH, port 22) is the classic gotcha.

## Key facts

### Secure vs. insecure protocol pairs

| Insecure | Port | Secure replacement | Port | Underlying tech |
|---|---|---|---|---|
| [[Telnet]] | 23 | [[SSH]] | 22 | SSH |
| [[FTP]] | 21 | [[SFTP]] | 22 | SSH |
| [[FTP]] | 21 | [[FTPS]] | 989/990 | TLS |
| [[HTTP]] | 80 | [[HTTPS]] | 443 | TLS |
| [[SMTP]] | 25 | [[SMTPS]] / SMTP+STARTTLS | 465 / 587 | TLS |
| [[POP3]] | 110 | [[POP3S]] | 995 | TLS |
| [[IMAP]] | 143 | [[IMAPS]] | 993 | TLS |
| [[LDAP]] | 389 | [[LDAPS]] | 636 | TLS |
| [[SNMPv1]]/v2c | 161 | [[SNMPv3]] | 161 | Built-in auth/priv |
| [[DNS]] | 53 | [[DNSSEC]] / [[DoH]] / [[DoT]] | 53 / 443 / 853 | Signing / TLS |
| [[NTP]] | 123 | [[NTS]] (Network Time Security) | 123 | TLS key exchange |
| [[RTP]] / [[SIP]] | 5060 | [[SRTP]] / [[SIPS]] | 5061 | TLS / SRTP |

### What each secure protocol actually provides

- **[[TLS]]** — Confidentiality (symmetric encryption after handshake), integrity ([[HMAC]] or [[AEAD]]), authentication (X.509 certificates). Current version: **TLS 1.3**. **TLS 1.0/1.1 are deprecated** — exam will test this.
- **[[SSH]]** — Encrypted remote shell, port forwarding, file transfer (SFTP/SCP). Authenticates with passwords or, preferably, **public key authentication**.
- **[[IPsec]]** — Network-layer protection. Two modes: [[Transport mode]] (payload only) and [[Tunnel mode]] (entire packet, used for [[site-to-site VPN]]). Two protocols: **AH** (integrity only, protocol 51) and **ESP** (integrity + confidentiality, protocol 50). [[IKE]]/[[IKEv2]] handles key exchange on UDP 500/4500.
- **[[S/MIME]]** — Email signing and encryption using X.509 certs.
- **[[DNSSEC]]** — Adds **origin authentication** and **integrity** to DNS via signed records (RRSIG, DNSKEY, DS). Does **not** provide confidentiality — that's [[DoH]]/[[DoT]]'s job.

### Email transport: the STARTTLS distinction

- **Implicit TLS** — TLS handshake first, then the protocol (e.g., SMTPS:465, IMAPS:993).
- **Opportunistic TLS / [[STARTTLS]]** — Connection starts in cleartext, then upgrades. Vulnerable to [[STARTTLS stripping]] if not enforced.

### Common exam pitfalls

- **SFTP ≠ FTPS.** SFTP rides SSH (22). FTPS rides TLS (989/990).
- **HTTPS does not imply trust** — only that the channel is encrypted to whoever holds the cert.
- **SNMPv2c is not secure** despite the "c" — it just adds community strings (cleartext passwords). Only **SNMPv3** offers authPriv.
- **Self-signed certs** encrypt fine but break authentication — clients can't verify identity.
- **Downgrade attacks** ([[POODLE]], [[BEAST]], stripping) target weak cipher negotiation; mitigate with strict version policies and [[HSTS]].

## Related concepts

[[TLS]] · [[SSH]] · [[IPsec]] · [[Certificate Authority]] · [[PKI]] · [[STARTTLS]] · [[DNSSEC]] · [[on-path attack]] · [[HSTS]] · [[Cipher suite]]

---
*Source: VIRGIL knowledge base — 2026-05-08*