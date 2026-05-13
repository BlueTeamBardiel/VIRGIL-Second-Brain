# PKI — Public Key Infrastructure

## What it is

In **Assassin's Creed**, every Assassin carries a hidden blade keyed to the Brotherhood and a Creed only initiates know. When Altaïr or Ezio passes another robed figure in the street, the recognition isn't a password shouted across the rooftops — it's the signet, the gait, the order's mark. A Templar in stolen robes might fool a guard, but the Brotherhood knows its own because every initiate was vouched for by a mentor who was vouched for by a mentor, all the way back to the Mentor. Break the chain at any point — a corrupted mentor like Al Mualim — and every blade beneath that name becomes suspect.

That's exactly what PKI does — it's the system that lets two parties who've never met trust each other's identity because somebody trusted vouches for the key.

**Technical definition:** Public Key Infrastructure is the framework of hardware, software, policies, and trusted third parties that issue, manage, distribute, store, and revoke **digital certificates** binding a public key to an identity. The trust anchor is the **Certificate Authority (CA)**. Certificates use **X.509** format. The math underneath is asymmetric cryptography — a key pair where the private key signs and decrypts, the public key verifies and encrypts.

## Why it matters

PKI is the substrate under HTTPS, code signing, S/MIME email, VPN client certs, smart card login, mTLS in zero-trust architectures, and signed Windows drivers. If PKI breaks, the web breaks. If a CA gets compromised — DigiNotar 2011, Comodo 2011 — every certificate it issued becomes untrustworthy and the cleanup is global.

For CySA+ this lives in **Objective 1.1** (system and network architecture) and threads into 1.2 (TLS inspection, certificate-based auth), 2.5 (vulnerability response when a cert expires or a CA gets popped), and 3.0 (IR when you find a malicious code-signing cert in the wild).

In the SOC, PKI failures don't look like cryptographic attacks. They look like expired certificates taking down production at 2am, rogue internal CAs nobody documented, certificate pinning blocking your TLS inspection, and threat actors signing malware with stolen certs from a real vendor.

## Key facts

### The components

| Component | Role |
|---|---|
| **Certificate Authority (CA)** | Issues and signs certificates. The trust anchor. |
| **Root CA** | Top of the chain. Self-signed. Kept offline in a vault. |
| **Intermediate / Subordinate CA** | Signs end-entity certs on behalf of the root. Online. If popped, you revoke the intermediate, not the root. |
| **Registration Authority (RA)** | Verifies identity before the CA issues. The vetting desk. |
| **Validation Authority (VA)** | Answers "is this cert still valid?" via CRL or OCSP. |
| **End entity** | The user, server, device, or service the cert is bound to. |

The root CA being offline is non-negotiable. The root signs the intermediates once, then sits in a Faraday cage. If your root is online and reachable, you've built a single point of catastrophic failure — Al Mualim with internet access.

### The chain of trust

A browser trusts `mail.company.com` because:

1. The server cert is signed by an **intermediate CA**.
2. The intermediate is signed by a **root CA**.
3. The root is in the browser's or OS's **trusted root store** — Microsoft, Apple, Mozilla, Google curate these lists.

The chain validates if every signature checks out, no cert is expired, no cert is revoked, and the leaf cert's Subject Alternative Name matches the hostname. Break any link and the whole chain fails closed. *A cert that fails validation but the browser warns through is a cert the user clicks past — half your phishing investigations end here.*

### X.509 fields you'll be asked about

- **Subject** — who the cert identifies
- **Issuer** — which CA signed it
- **Validity period** — Not Before / Not After
- **Public Key** — the half that gets shared
- **Subject Alternative Name (SAN)** — additional hostnames/IPs. Modern browsers ignore CN and use SAN exclusively.
- **Signature Algorithm** — SHA-256 with RSA is the modern floor. SHA-1 is dead. MD5 has been dead longer.
- **Key Usage / Extended Key Usage** — what the cert is allowed to do (server auth, client auth, code signing, email)
- **Thumbprint / Fingerprint** — hash of the cert, useful for pinning and IoC matching

### Certificate types

| Type | Validation / Use case |
|---|---|
| **DV (Domain Validated)** | Proves domain control only. Let's Encrypt default. Public web. |
| **OV (Organization Validated)** | Validates the legal organization. Corporate web presence. |
| **EV (Extended Validation)** | Heavy vetting. Browsers killed the green-bar UI. Banks, regulated industries. |
| **Wildcard** | `*.company.com`. One cert, every subdomain. Pop one server and you have the wildcard private key. |
| **SAN / Multi-domain** | Multiple specific hostnames in one cert. |
| **Self-signed** | Signed by its own private key. No chain. Internal lab use only. |
| **Code signing** | Signs executables and drivers. Stolen code-signing certs are gold to attackers. |
| **Client cert** | Authenticates a user or device to a server (mTLS, smart card login). |

### Revocation — the part that breaks

Certs get revoked when the private key leaks, the subject changes, the CA was compromised, or the cert was misissued. Two mechanisms:

- **CRL (Certificate Revocation List)** — the CA publishes a signed list of revoked serials. Clients download it. Lists get huge. Cached aggressively. Stale CRLs are a real-world failure mode.
- **OCSP (Online Certificate Status Protocol)** — the client asks the CA "is this serial revoked?" in real time. Faster but a privacy leak (the CA sees every site you visit) and a latency cost.
- **OCSP Stapling** — the server fetches its own OCSP response periodically and staples it to the TLS handshake. Fixes both problems. The right default.

**Certificate Transparency (CT) logs** — public append-only logs where every publicly trusted cert gets recorded. Monitor CT logs for certs issued for your domain by CAs you don't use. This is how you catch a rogue cert before the attacker uses it.

### Asymmetric vs symmetric in practice

PKI uses asymmetric crypto (RSA, ECDSA, Ed25519) for **identity and key exchange**. Bulk data is encrypted with a **symmetric** session key (AES-256) derived during the TLS handshake. Asymmetric is slow; symmetric is fast. PKI's job is to bootstrap trust so the fast crypto can take over.

### Where PKI shows up in the CySA+ stack

- **TLS/SSL** — every HTTPS connection. TLS 1.2 minimum, TLS 1.3 preferred. SSL is dead.
- **mTLS** — both sides present certs. Core to **zero trust** — the device cert proves the endpoint is enrolled before any traffic flows.
- **Code signing** — Windows Authenticode, Apple notarization, signed kernel drivers
- **S/MIME** — signed and encrypted email
- **VPN / 802.1X** — certificate-based auth instead of passwords
- **Smart cards / PIV / CAC** — federal and DoD identity
- **Container and service mesh** — image signing (Sigstore, Notary), service-to-service mTLS
- **CASB and SASE** — TLS inspection requires the inspection proxy's CA to be trusted by every endpoint. Deploy that root via GPO or MDM or nothing works.

### CompTIA exam traps

> **CompTIA exam trap:** SSL vs TLS. The objectives still say "SSL" because the term stuck. SSL 2.0 and 3.0 are dead (POODLE killed SSL 3.0). Production uses **TLS 1.2 or 1.3**. If the question asks about "SSL certificates" they mean TLS certificates. If it asks which protocol to deploy, the answer is TLS, never SSL.

> **CompTIA exam trap:** CRL vs OCSP vs OCSP stapling. CRL is a downloaded list. OCSP is a real-time query per cert. OCSP stapling is the server pre-fetching and attaching. If the question emphasizes **performance and privacy together**, the answer is stapling. If it emphasizes **offline operation**, CRL. Pure real-time check, OCSP.

> **CompTIA exam trap:** Self-signed vs CA-signed. Self-signed certs aren't insecure cryptographically — they're untrusted because no chain. Internal CA-signed is fine for internal use *if* the internal root is deployed to endpoints. CompTIA likes to ask which is appropriate for internal services with managed endpoints — the answer is internal CA, not self-signed and not public CA.

> **CompTIA exam trap:** Root vs intermediate compromise. If a **root** CA is compromised, every cert it ever signed is suspect and you have a crisis. If an **intermediate** is compromised, you revoke the intermediate and reissue under a new one — bad day, not extinction event. This is why roots stay offline.

> **CompTIA exam trap:** Key escrow vs key recovery. **Escrow** = a third party holds a copy of the private key. **Recovery** = the technical process of getting a key back. Escrow is policy; recovery is mechanism.

## SOC reality

- **The 2am page is almost always expiration.** Production cert expired, app stopped trusting the upstream, half the microservices fail health checks. Real PKI attacks are rare; expired certs are the daily bread. Push for automated renewal — ACME, cert-manager, internal ADCS auto-enrollment — and a dashboard showing every cert in the estate with days-to-expiry.

- **"Why is the browser showing a warning on our internal site?"** — the user opened a thing on a VLAN whose cert is signed by an internal CA the laptop doesn't trust. Either the root isn't deployed (GPO/MDM gap) or they're on a BYOD that never got the root. L1 verifies the cert chain in the browser and checks the trusted root store on the endpoint.

- **CT log monitoring is free threat intel.** Tools like crt.sh and Cert Spotter will tell you when *any* publicly trusted CA issues a cert for your domain. If you didn't request it, somebody is staging something — phishing, MITM, or a misconfigured internal team using the wrong CA. Set this up before you need it.

- **Code-signing cert theft is the high-impact incident.** When a threat actor signs malware with a stolen cert from a real vendor, EDR confidence drops and AV may whitelist the binary. Stuxnet had stolen Realtek and JMicron certs. If your org publishes signed software, the signing key lives in an HSM or it lives nowhere safe.

- **Never promise leadership "we rotated the cert."** Promise "the new cert is deployed and validated end-to-end across the load balancer, all backend nodes, and the CDN edge." A rotation that missed one node behind a load balancer creates intermittent failures that look like a flaky network for a week.

## Related concepts

[[TLS]] · [[Encryption]] · [[Zero Trust]] · [[Identity and Access Management]] · [[Multifactor Authentication]] · [[Passwordless]] · [[Single Sign-On]] · [[Federation]] · [[Cloud Access Security Broker]] · [[SASE]] · [[Hardware Security Module]] · [[Code Signing]] · [[Certificate Transparency]] · [[OCSP Stapling]] · [[mTLS]] · [[System Hardening]]

*Source: VIRGIL knowledge base — 2026-05-11*