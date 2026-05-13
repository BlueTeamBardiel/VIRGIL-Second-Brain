# CA — Certificate Authority

## What it is

In **Sekiro: Shadows Die Twice**, the merchants in Ashina Castle won't talk to Wolf until he flashes the right token — Robert's Firecrackers, the Lump of Fat Wax, whatever proves he belongs. The Sculptor vouches for him at the dilapidated temple; without the Sculptor's introduction, the merchants and NPCs treat him like any other masterless shinobi crawling through the bamboo. The Sculptor is the trust anchor. His word converts a stranger into someone the village will deal with.

That's exactly what a **Certificate Authority** does — it's the trust anchor that vouches for a public key so the rest of the network will deal with it.

Technically: a **Certificate Authority (CA)** is an entity within a [[PKI]] that issues, signs, and revokes digital certificates binding a public key to an identity (a hostname, a user, a device, a code-signing publisher). The CA signs the certificate with its own private key. Every relying party already trusts the CA's public key (it's baked into the OS or browser trust store), so the signature converts "here's a public key claiming to be google.com" into "google.com's key, vouched for by an authority I already trust."

CAs come in flavors: **public CAs** (DigiCert, Let's Encrypt, Sectigo — trusted globally by browsers and OS vendors), **private/internal CAs** (your enterprise's Active Directory Certificate Services, vouching for internal hosts), and **intermediate CAs** (signed by a root, doing the day-to-day issuing so the root can stay offline in a safe).

## Why it matters

Every [[TLS]] handshake on your network depends on CA trust. Every code-signed binary your EDR whitelists trusts a CA. Every smart card login, every [[802.1X]] cert-based network auth, every [[mTLS]] microservice handshake, every [[VPN]] client cert — all of it collapses if the CA is compromised or misconfigured.

For the SOC analyst, CAs are infrastructure you inherit and inspect, rarely build. But you triage their failures constantly: expired certs taking down production, rogue certs issued by a compromised internal CA, phishing sites with valid Let's Encrypt certs that fool users into clicking, certificate pinning breaking legit traffic. The 2011 DigiNotar breach — attackers issued fraudulent Google certs and used them to intercept Iranian Gmail users — is the canonical "the CA was the attack surface" story. DigiNotar went bankrupt three months later. Trust, once lost, doesn't come back.

**CS0-003 Objective 1.1** covers PKI, encryption, identity infrastructure, and certificate-based authentication as core architecture concepts you must understand to defend. CAs sit at the bottom of that stack.

## Key facts

### The trust chain

A certificate doesn't stand alone. It's part of a **chain of trust**:

| Tier | Role | Where it lives |
|---|---|---|
| **Root CA** | Self-signed, ultimate trust anchor | Offline, air-gapped, in a safe. Used rarely. |
| **Intermediate CA** | Signed by root, signs end-entity certs | Online, doing daily issuance |
| **End-entity cert** | The actual cert on a server, user, or device | On the load balancer, in the user's keystore |

When a browser validates `mail.example.com`, it walks the chain: end-entity → intermediate → root. If every signature validates and the root is in the trust store, the cert is trusted. Break any link — expired intermediate, missing chain file on the server, untrusted root — and the connection fails with the cert error users have been trained to click through.

### Certificate lifecycle

1. **CSR (Certificate Signing Request)** — the entity generates a keypair, sends the public key + identity info to the CA
2. **Validation** — CA verifies the requester actually owns the domain/identity. DV (domain validation, automated), OV (organization validation), EV (extended validation, the green-bar legacy)
3. **Issuance** — CA signs the cert with its private key
4. **Distribution** — cert deployed to the endpoint, chain file included
5. **Renewal** — before expiration. [[ACME]] protocol automates this for Let's Encrypt
6. **Revocation** — when the private key is compromised or the cert is no longer valid

### Revocation — the part that's always broken

When a cert needs to die before its expiration, the CA revokes it. Two mechanisms:

- **CRL (Certificate Revocation List)** — a signed list of revoked cert serial numbers, published by the CA. Clients download it periodically. Doesn't scale well; lists get huge.
- **OCSP (Online Certificate Status Protocol)** — client asks the CA in real time "is serial number X still good?" Lower latency than CRLs, but creates a privacy problem (the CA sees who's visiting what) and an availability problem (if OCSP responder is down, what does the client do?). **OCSP stapling** fixes both — the server fetches its own OCSP response and staples it to the TLS handshake.

In practice, browsers often **soft-fail** on revocation checks — if OCSP can't be reached, the connection proceeds. Which means revocation is, charitably, advisory. This is why short-lived certs (Let's Encrypt's 90-day default, increasingly 7-day for some use cases) matter — the cert expires before revocation matters.

### Internal vs public CAs

| Concern | Public CA | Internal CA |
|---|---|---|
| **Trust scope** | Global (browser/OS trust stores) | Your org only |
| **Use case** | Public-facing services, [[TLS]], code signing | Internal services, user auth, device auth, [[802.1X]] |
| **Cost** | Free (Let's Encrypt) to thousands/year | Cost of running the infrastructure |
| **Issuance speed** | Seconds to days | Whatever your PKI team's SLA is |
| **Compromise blast radius** | Catastrophic, global | Catastrophic, internal |

Most enterprises run both. Internal CA (typically [[Active Directory Certificate Services]] or HashiCorp Vault PKI) handles employee auth, device certs, internal mTLS. Public CA handles anything customers see.

### Where CAs touch the rest of Objective 1.1

The objective bullets aren't random — they all hinge on cert trust:

- **[[Zero Trust]]** — every workload presents a cert; mTLS replaces network-perimeter trust. The CA is the trust root.
- **[[Identity and Access Management]] / [[Passwordless]] / [[MFA]]** — smart cards, [[FIDO2]] tokens, certificate-based auth all need a CA backing the cert.
- **[[SSO]] / [[Federation]] / [[SAML]]** — SAML assertions are signed by the IdP's cert, trusted via CA chain.
- **[[CASB]] / [[SASE]] / [[SDN]]** — TLS inspection at the proxy requires the proxy to hold a CA cert trusted by every endpoint (you push your internal CA root to every managed device).
- **[[Encryption]] in transit** — TLS, IPsec with cert auth, SSH cert auth, all rooted in CAs.
- **Code signing** — Windows trusts signed drivers/binaries via code-signing CAs. EDR whitelists by publisher signature.

### CA compromise — the nightmare scenario

If an attacker compromises a CA's signing key, they can issue valid certs for any identity the CA can attest to. Real incidents:

- **DigiNotar (2011)** — Dutch public CA breached. Attackers issued fraudulent *.google.com cert. Used to MITM ~300,000 Iranian Gmail users. DigiNotar was distrusted by all major browsers; bankrupt within months.
- **Comodo (2011)** — RA compromise, nine fraudulent certs issued including login.live.com and mail.google.com.
- **Symantec (2017)** — distrusted by Chrome after years of mis-issuance, forced sale of CA business to DigiCert.

Defenses: **Certificate Transparency** (CT logs — all public CA issuance is logged to append-only public logs; you can monitor for certs issued in your name you didn't request), **CAA records** (DNS record telling CAs "only this CA may issue for my domain"), **HPKP** (deprecated — pinning was too fragile), short-lived certs, hardware-backed CA keys ([[HSM]]).

### CompTIA exam traps

> **CompTIA exam trap:** **CA vs RA.** The Registration Authority verifies the requester's identity; the Certificate Authority issues the cert. CompTIA will give you a scenario where someone validates a CSR and ask who did it — that's the RA, not the CA. In small PKIs they're the same entity; on the exam they're separate roles.

> **CompTIA exam trap:** **CRL vs OCSP.** CRL is a list, downloaded periodically, scales poorly. OCSP is real-time, one cert at a time, scales better but has privacy/availability tradeoffs. **OCSP stapling** puts the response in the TLS handshake — server fetches, not client. If the question says "real-time, single cert lookup" it's OCSP. "Published list" is CRL.

> **CompTIA exam trap:** **Root vs Intermediate CA.** Root CAs are offline. The intermediate does day-to-day issuance. If a question asks why an enterprise wouldn't use the root to issue end-entity certs directly, the answer is **blast radius** — if the issuing CA is compromised, you can revoke an intermediate without burning the root and rebuilding every trust store on earth.

> **CompTIA exam trap:** **Self-signed vs CA-signed.** Self-signed certs provide encryption but no trust verification — there's no third party vouching. Fine for internal dev; never acceptable on internet-facing systems. CompTIA loves to phrase this as "the connection is encrypted but the user gets a warning, why?" — the cert isn't chained to a trusted CA.

## SOC reality

- **The 3am alert is almost always expiration.** Cert expired on a load balancer, monitoring went red, on-call gets paged. First action: confirm the cert, find the owner of record (PKI team or the app team that issued the CSR), escalate. Don't try to renew someone else's cert at 3am without authorization.
- **CT log monitoring catches CA abuse early.** Tools like Facebook's CT monitor, Cert Spotter, or commercial offerings alert you when a cert is issued for your domain that didn't come from your pipeline. A cert for `login.yourcompany.com` from a CA you don't use is a phishing infrastructure indicator — escalate to threat intel and IR immediately.
- **"It works in my browser" is a chain problem.** Server admins forget to install the intermediate cert. Chrome on the admin's machine has the intermediate cached from another site, so it works for them; mobile clients with no cache fail. Always validate with `openssl s_client -connect host:443 -showcerts` from a clean box, not the admin's browser.
- **The CISO will ask: who can issue certs in our name?** Real answer requires inventorying your CAA records, your internal CA permissions, every public CA you've ever used, and any third-party SaaS that issues certs on your behalf (CDNs, load balancer providers). Most orgs can't answer this. The ones that can sleep better.
- **Never tell leadership "we revoked it" and stop there.** Revocation is advisory. Browsers soft-fail. The right answer is "we revoked it AND rotated the underlying key AND audited what that cert was used for AND checked CT logs for related issuance." Anything less and you'll be having the same conversation in six months.

## Related concepts

[[PKI]] · [[TLS]] · [[mTLS]] · [[OCSP]] · [[CRL]] · [[Certificate Transparency]] · [[CAA records]] · [[HSM]] · [[Active Directory Certificate Services]] · [[ACME]] · [[Zero Trust]] · [[Identity and Access Management]] · [[SSO]] · [[Federation]] · [[SAML]] · [[Passwordless]] · [[MFA]] · [[FIDO2]] · [[CASB]] · [[SASE]] · [[Encryption]] · [[Code Signing]] · [[802.1X]]

*Source: VIRGIL knowledge base — 2026-05-11*