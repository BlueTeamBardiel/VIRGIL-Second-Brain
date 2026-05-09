# Email Security

## What it is

In Cyberpunk 2077, every shard you pick up in Night City could be legit corpo intel, a Maelstrom virus that bricks your cyberdeck, or a phishing message from some fixer pretending to be Rogue. V doesn't blindly jack into every datashard — and your mail server shouldn't blindly accept every message claiming to be from Arasaka. That's exactly what email security does — it verifies who sent the message, whether anyone tampered with it, and whether the contents are safe to open.

Email security is the layered set of authentication, encryption, and content-filtering controls (SPF, DKIM, DMARC, S/MIME, gateways, sandboxing) that protect message confidentiality, integrity, and authenticity across SMTP transit.

## Why it matters

Email is the #1 initial-access vector. Phishing, business email compromise (BEC), and malware-laden attachments cost organizations billions per year — the FBI's IC3 consistently ranks BEC as the costliest cyber-crime category. SY0-701 Objective 4.5 requires you to know **DKIM, SPF, DMARC, gateway, and email security** mechanisms by name and function. CompTIA's favorite trap: confusing which protocol does what — SPF authorizes *senders*, DKIM signs *messages*, DMARC tells receivers *what to do* when SPF/DKIM fail. Memorize the division of labor or you will lose easy points.

## Key facts

### Sender Authentication Trio

| Protocol | DNS Record | What it does | What it doesn't do |
|---|---|---|---|
| **[[SPF]]** (Sender Policy Framework) | TXT `v=spf1 ...` | Lists IP addresses authorized to send mail for a domain | Doesn't sign content; breaks on forwarding |
| **[[DKIM]]** (DomainKeys Identified Mail) | TXT with public key under `selector._domainkey` | Cryptographically signs message headers/body with sending domain's private key | Doesn't say what to do on failure |
| **[[DMARC]]** (Domain-based Message Authentication, Reporting & Conformance) | TXT `v=DMARC1; p=...` | Policy: `none`, `quarantine`, or `reject` when SPF/DKIM fail; provides reporting (`rua`, `ruf`) | Doesn't authenticate by itself — relies on SPF/DKIM alignment |

**Alignment** is the gotcha: DMARC requires the `From:` domain to align with the SPF-authenticated or DKIM-signed domain. Pass without alignment = DMARC fail.

### Message-Level Encryption & Signing

- **[[S/MIME]]** — uses [[X.509]] certificates and [[PKI]] for end-to-end signing/encryption. Requires CA-issued certs.
- **[[PGP]] / [[OpenPGP]] / [[GPG]]** — web-of-trust model, not PKI. Same goals: confidentiality, integrity, non-repudiation.
- **[[STARTTLS]]** — opportunistic TLS upgrade for SMTP transit (port 25 or 587). Protects server-to-server, *not* end-to-end.
- **[[MTA-STS]]** and **[[DANE]]** — enforce TLS so attackers can't downgrade to plaintext.

### Ports to Memorize

| Port | Protocol | Use |
|---|---|---|
| 25 | SMTP | Server-to-server relay |
| 587 | SMTP submission | Authenticated client send (with STARTTLS) |
| 465 | SMTPS | Implicit TLS submission (legacy/reintroduced) |
| 110 / 995 | POP3 / POP3S | Mail retrieval (plain / TLS) |
| 143 / 993 | IMAP / IMAPS | Mail retrieval (plain / TLS) |

### Email Gateway Defenses

- **[[Secure Email Gateway]] (SEG)** — inline filter: anti-spam, anti-malware, URL rewriting, attachment sandboxing, DLP.
- **[[Sandboxing]]** — detonate attachments/URLs in isolated VM before delivery.
- **[[URL Rewriting]] / Time-of-click protection** — re-checks links when user clicks, not just at delivery.
- **[[DLP]]** — outbound scanning to block exfiltration of regulated data.
- **[[Banner / Warning tags]]** — "[EXTERNAL]" markers on inbound messages to reduce [[impersonation]] success.

### Attacks Email Security Defends Against

- **[[Phishing]]**, **[[Spear phishing]]**, **[[Whaling]]**
- **[[Business Email Compromise]] (BEC)** — often pure social engineering, no malware; gateways alone won't stop it without DMARC + user training.
- **[[Spoofing]]** — forged `From:` header; DMARC kills this when configured to `reject`.
- **[[Email-borne malware]]** — attachments and embedded links.
- **[[Spam]]** — volume attacks; reputation-based blocking ([[RBL]] / [[DNSBL]]).

### Common Exam Traps

- **SPF alone ≠ anti-spoofing.** Attacker can pass SPF with their own domain while spoofing the visible `From:` header. DMARC alignment closes that gap.
- **DKIM doesn't encrypt.** It signs. Confidentiality requires S/MIME, PGP, or TLS.
- **STARTTLS is opportunistic.** A MITM stripping the STARTTLS command downgrades to cleartext unless MTA-STS/DANE is enforced.

## Related concepts

[[Phishing]] · [[DMARC]] · [[SPF]] · [[DKIM]] · [[S/MIME]] · [[PGP]] · [[Secure Email Gateway]] · [[STARTTLS]] · [[MTA-STS]] · [[Business Email Compromise]] · [[DLP]] · [[Sandboxing]] · [[Social Engineering]] · [[PKI]]

---
*Source: VIRGIL knowledge base — 2026-05-08*