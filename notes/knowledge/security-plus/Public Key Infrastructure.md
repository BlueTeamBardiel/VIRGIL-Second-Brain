# Public Key Infrastructure

## What it is

In Civilization, when you send a Great Diplomat to another civilization, they carry your seal — a verifiable mark stamped by your government proving the message is genuinely from Gandhi and not from Genghis Khan wearing a fake mustache. The receiving civ trusts that seal because they recognize your government as a legitimate issuing authority. That's exactly what **Public Key Infrastructure** does — it's the system of authorities, certificates, and rules that proves a public key actually belongs to who it claims to belong to.

**PKI** is the framework of hardware, software, policies, and procedures that creates, manages, distributes, stores, and revokes digital certificates binding public keys to verified identities.

## Why it matters

Without PKI, every TLS handshake is theater — you'd be encrypting traffic to whoever answered the phone, including the attacker doing [[ARP poisoning]] on the coffee shop Wi-Fi. PKI failures enable [[on-path attacks]], [[impersonation]], code-signing fraud, and complete collapse of HTTPS trust. Objective 1.4 expects fluency in **CA hierarchy**, **certificate lifecycle**, **revocation mechanisms (CRL/OCSP)**, **key escrow**, and **trust models**. CompTIA's favorite trap: confusing **CRL** (a downloaded list) with **OCSP** (a real-time query), or asking which entity signs the **root CA's** certificate (answer: itself — that's the whole point of a root).

## Key facts

### The hierarchy

| Component | Role |
|---|---|
| **[[Root CA]]** | Self-signed top of trust. Kept offline. Compromise = burn it all down. |
| **[[Intermediate CA]]** | Signed by root. Issues certs day-to-day so the root stays cold. |
| **[[Registration Authority]] (RA)** | Verifies identity before the CA issues. The bouncer. |
| **[[Certificate Authority]] (CA)** | Actually signs and issues certificates. |
| **End entity** | The server, user, or device receiving the cert. |

### Certificate lifecycle

1. **[[Key generation]]** — subject creates keypair.
2. **[[Certificate Signing Request]] (CSR)** — public key + identity sent to RA/CA.
3. **Validation** — DV, OV, or EV depending on rigor.
4. **Issuance** — CA signs with its private key.
5. **Distribution & use** — embedded in TLS, S/MIME, code signing, etc.
6. **[[Revocation]]** or **expiration** — when compromised or aged out.

### Revocation mechanisms

| Mechanism | How it works | Weakness |
|---|---|---|
| **[[Certificate Revocation List]] (CRL)** | Client downloads signed list of revoked serials | Stale; large; slow |
| **[[OCSP]]** | Client asks responder in real time | Privacy leak; responder availability |
| **[[OCSP stapling]]** | Server attaches fresh OCSP response to TLS handshake | Requires server support |

### Trust models

- **Hierarchical** — single root, branching intermediates. The corporate norm.
- **[[Web of trust]]** — peers vouch for peers. PGP's model. Doesn't scale.
- **[[Bridge CA]]** — connects separate hierarchies (e.g., federal agencies).
- **Mesh** — multiple CAs cross-certify each other.

### Key concepts CompTIA loves

- **[[Key escrow]]** — third party holds a copy of the private key. Useful for recovery, terrifying for non-repudiation.
- **[[Certificate pinning]]** — app hardcodes which cert/CA to trust. Defeats rogue CA attacks.
- **[[Wildcard certificate]]** — `*.example.com`. Convenient; one stolen key compromises every subdomain.
- **[[SAN certificate]]** (Subject Alternative Name) — multiple specific hostnames in one cert.
- **[[Self-signed certificate]]** — no CA involved. Fine for internal labs, fatal for production.
- **Certificate formats** — **PEM** (Base64, `.pem`/`.crt`), **DER** (binary), **PFX/P12** (bundled with private key), **P7B** (chain, no private key).

### What breaks when PKI breaks

- **Stolen CA private key** → attacker mints valid certs for any domain (see: DigiNotar, 2011, dead within months).
- **Weak hashing (MD5, SHA-1)** → collision attacks forge certs.
- **No revocation checking** → stolen certs keep working until expiry.
- **Expired cert** → users trained to click through warnings, defeating the entire point.

## Related concepts

[[Asymmetric encryption]] · [[Digital signature]] · [[TLS]] · [[X.509]] · [[Hardware Security Module]] · [[Code signing]] · [[Certificate pinning]] · [[Key escrow]]

---
*Source: VIRGIL knowledge base — 2026-05-08*