# Encryption & PKI

## What it is

In **Pac-Man**, the maze has four ghost-house gates and a center pen where Blinky, Pinky, Inky, and Clyde spawn. The gates only open for ghosts — Pac-Man can't pass through. The maze trusts the gate's behavior because the gate was built that way at the factory; nobody verifies it mid-game. Now imagine a hostile arcade cabinet where someone swapped the ROM and now Pac-Man can walk through the ghost gate, or worse — a fake Pinky comes out of the pen wearing Pinky's sprite but running Blinky's aggressive chase AI. You'd never know until you got cornered.

That's the problem **encryption and PKI** solve on a network. Encryption scrambles the data so the bad sprite can't read it in transit. PKI — Public Key Infrastructure — is the factory stamp on the gate that proves the sprite coming out of the pen is the real Pinky, signed by an authority both sides trust.

Technical definition: **Encryption** is the use of cryptographic algorithms (symmetric like AES, asymmetric like RSA/ECC) to transform plaintext into ciphertext such that only a holder of the correct key can reverse the operation. **PKI** is the framework of certificate authorities, registration authorities, certificate stores, revocation mechanisms, and policy that binds a public key to a verified identity using digital certificates (X.509). Together they give you the four properties the SOC actually cares about: **confidentiality, integrity, authentication, and non-repudiation**.

## Why it matters

Every TLS handshake on your network, every signed PowerShell script, every code-signing chain on a Windows installer, every S/MIME email, every smart card, every Kerberos ticket lean on this plumbing. When PKI breaks — expired cert, revoked CA, mis-issued wildcard, weak cipher — outages and incidents follow. The 2011 DigiNotar breach took down a national CA and let attackers issue valid certs for Google domains to spy on Iranian dissidents. That's the worst case: the trust anchor itself goes rotten.

CySA+ Objective 1.1 wants you to explain encryption and PKI as **architectural components** of a defensible network — not as cryptographer math. The exam tests whether you know what a CA does, what CRL/OCSP are for, why expired ≠ revoked, and why "encrypted in transit" doesn't mean "encrypted at rest." Career-wise: every SOC analyst who escalates a "weird TLS error" ticket and can't read a cert chain ends up sitting on it for two days. Don't be that analyst.

## Key facts

### The four jobs PKI does

| Property | What it means | Mechanism |
|---|---|---|
| **Confidentiality** | Nobody reads the data in flight | Symmetric encryption (AES-256) negotiated via asymmetric key exchange |
| **Integrity** | Nobody modifies the data without detection | Hash + signature (SHA-256 + RSA/ECDSA) |
| **Authentication** | The endpoint is who it claims to be | Certificate signed by a trusted CA |
| **Non-repudiation** | The sender can't deny they sent it | Private-key signature only the sender could produce |

### Symmetric vs asymmetric — and why TLS uses both

**Symmetric** (AES, ChaCha20): one shared key, fast, used for bulk data. Problem: how do you share the key over an untrusted network without giving it to the eavesdropper first?

**Asymmetric** (RSA, ECDSA, ECDH): keypair — public key encrypts, private key decrypts (or vice versa for signatures). Slow, but solves key distribution.

TLS uses asymmetric to *agree on* a per-session symmetric key, then switches to symmetric for the actual data. Best of both. This is why a TLS handshake is expensive (asymmetric math) but the rest of the session is cheap.

### Core PKI components

- **Certificate Authority (CA)** — the trust anchor. Signs certificates with its private key. Browsers/OSes ship with a trust store of root CAs. A **root CA** signs **intermediate CAs**, which sign **end-entity (leaf) certs**. Root keys live offline in an HSM and only come out for ceremony.
- **Registration Authority (RA)** — verifies identity before the CA issues a cert. "Are you really google.com? Prove it." For public CAs this is DV/OV/EV validation. For internal CAs it's whoever the certificate policy says.
- **Certificate store / directory** — where issued certs and their public keys live so relying parties can find them. Active Directory in Windows enterprises (NTAuth store, AIA, CDP). Browser/OS trust stores on endpoints.
- **Certificate policy (CP) and Certification Practice Statement (CPS)** — the rulebook. Who can request what, validation requirements, key lengths, revocation procedures.
- **Management system** — issuance, renewal, rotation, revocation workflow. Lifecycle management is where most PKI shops fall over because nobody owns it.

### The X.509 certificate — what's actually inside

- **Subject** — who the cert is for (CN=login.example.com, plus SAN entries)
- **Issuer** — which CA signed it
- **Validity period** — Not Before / Not After (max 398 days for public TLS certs since 2020)
- **Public key** — the bound key
- **Serial number** — unique per issuer, used for revocation lookups
- **Extensions** — Key Usage, Extended Key Usage (serverAuth, clientAuth, codeSigning), SAN, AIA (where to fetch issuer cert), CDP (where to fetch the CRL)
- **Signature** — the issuer's signature over everything above

### Revocation — CRL vs OCSP vs OCSP stapling

A cert can be revoked before its expiration: key compromise, employee leaves, CA mis-issuance. **Expired is not the same as revoked.** An expired cert hit its natural end of life. A revoked cert was killed early — usually because something went wrong.

| Mechanism | How it works | Tradeoff |
|---|---|---|
| **CRL (Certificate Revocation List)** | CA publishes a signed list of revoked serials at a URL in the cert's CDP extension | Bulky, cached, can be hours stale |
| **OCSP (Online Certificate Status Protocol)** | Client queries the CA's OCSP responder per cert | Real-time but creates a privacy leak (CA sees what you're browsing) and a CA availability dependency |
| **OCSP Stapling** | Server fetches its own OCSP response and "staples" it to the TLS handshake | Best of both — fresh status, no client-side CA call |

Browsers also use proprietary mechanisms (Chrome's CRLSets, Firefox's OneCRL) because traditional revocation is famously unreliable. **Soft-fail** is the dirty secret: if the OCSP responder is down, most browsers proceed anyway. An attacker who can block OCSP traffic can use a revoked cert.

### Where encryption lives in your stack

- **In transit** — TLS 1.2/1.3 for HTTPS/SMTPS/LDAPS, IPsec for site-to-site VPN, SSH for admin sessions, WPA3 on wireless
- **At rest** — BitLocker / FileVault / LUKS for full-disk, TDE for databases, S3 server-side encryption, SED drives at the hardware layer
- **In use** — confidential computing, Intel SGX / AMD SEV enclaves, homomorphic encryption (mostly research)

The CySA+ exam loves the trap that "we have HTTPS" answers in-transit *only*. The database dump sitting on a misconfigured S3 bucket is at-rest and has nothing to do with TLS.

### SSL vs TLS — and why nobody should say SSL anymore

SSL 2.0 and 3.0 are dead (POODLE killed 3.0 in 2014). TLS 1.0 and 1.1 are deprecated. **TLS 1.2** is the floor for compliance; **TLS 1.3** is current and drops weak ciphers, removes RSA key exchange, mandates forward secrecy. People still say "SSL certificate" out of habit — it's a TLS cert. The product names lag the protocol.

### CompTIA exam traps

> **CompTIA exam trap:** Expired ≠ revoked. An expired certificate hit its end of life on schedule. A revoked certificate was killed early because something went wrong — key compromise, employee termination, CA error. Both fail validation, but the *reason* matters for incident response. If a cert was revoked, ask why.

> **CompTIA exam trap:** The CA's *private* key signs certificates. The CA's *public* key (in the root cert) verifies them. Reverse it on the exam and you fail the question. Encryption uses the recipient's public key; signatures use the sender's private key.

> **CompTIA exam trap:** "Encryption" without qualifier is vague. CompTIA tests whether you know **in transit** (TLS, IPsec), **at rest** (BitLocker, TDE), and **in use** (enclaves) are three different problems with three different controls. A breach of at-rest data on a stolen laptop has nothing to do with your TLS configuration.

> **CompTIA exam trap:** A self-signed certificate is not the same as an untrusted CA. Self-signed = the cert signs itself; useful for internal testing, untrusted by default everywhere. An internal Enterprise CA is technically trusted by your domain-joined endpoints because the root is pushed via Group Policy — that's still PKI, just private.

### How this fits the broader architecture

PKI underpins [[Zero Trust]] (every connection must authenticate, certificates are how machines do it), [[MFA]] (smart cards, FIDO2 keys), [[Identity and Access Management]] (SAML/OIDC assertions are signed with PKI), [[Passwordless]] authentication (certificate-based or WebAuthn), [[SSO]] and [[Federation]] (signed assertions across trust boundaries), [[Network Segmentation]] (mutual TLS between segments), and [[Data Loss Prevention]] (encrypted file containers, IRM). Pull PKI out and most modern security architecture collapses.

## SOC reality

- **The 3am cert alert** is almost always one of three things: a cert expired and nobody owns the renewal, a scanner flagged a self-signed cert on an internal service, or someone stood up a service with the wrong SAN. Pull the cert with `openssl s_client -connect host:443 -showcerts` and read it. Don't escalate until you've looked at the chain.
- **When a vendor breach hits the news and a CA is named**, your job is to inventory: do we trust this CA? What certs in our environment chain to it? Can we pull them from the trust store without breaking production? This is a documented IR playbook in mature shops. In immature shops, it's a 4am scramble.
- **Leadership will ask "are we encrypted?"** The honest answer is never yes. The answer is "in transit on these paths with TLS 1.2+; at rest on endpoints with BitLocker and on databases with TDE; not in use, and not on these three legacy systems we have compensating controls for." If you say "yes," you're lying.
- **Never trust a green padlock as evidence of safety.** Phishing sites get DV certs in minutes. The padlock means the channel to that server is encrypted. It says nothing about whether the server is the one you wanted.
- **The handoff:** L1 confirms the cert chain and expiration. L2 reads the cert policy and confirms whether revocation is real or scanner noise. PKI team or IR owns CA-level events. Legal gets called when revocation involves a customer-facing service and disclosure may apply.

*An expired cert is an outage. A revoked cert is an incident. Never confuse the two on a status call.*

## Related concepts

[[Zero Trust]] · [[Identity and Access Management]] · [[MFA]] · [[Passwordless]] · [[SSO]] · [[Federation]] · [[Network Segmentation]] · [[CASB]] · [[SASE]] · [[Data Loss Prevention]] · [[Sensitive Data Protection]] · [[System Hardening]] · [[Cloud Architecture]] · [[Log Ingestion]] · [[Privileged Access Management]]

*Source: VIRGIL knowledge base — 2026-05-11*