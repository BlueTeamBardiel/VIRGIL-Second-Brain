# Certificate Authority Compromise

## What it is
Imagine a corrupt notary public who stamps "identity verified" on forged documents — every institution that trusts that notary now unknowingly accepts the fakes. A Certificate Authority (CA) compromise occurs when an attacker gains unauthorized access to a CA's signing key or infrastructure, allowing them to issue fraudulent but cryptographically valid SSL/TLS certificates for any domain.

## Why it matters
In 2011, the Dutch CA DigiNotar was breached and attackers issued fraudulent certificates for google.com, enabling man-in-the-middle attacks against approximately 300,000 Iranian Gmail users. The incident ultimately destroyed DigiNotar as a business — browsers revoked trust in all their certificates, rendering every legitimate certificate they had ever issued useless overnight.

## Key facts
- A compromised CA can issue certificates for **any domain**, meaning attackers can intercept HTTPS traffic that victims believe is encrypted and authenticated
- **Certificate Transparency (CT) logs** are the primary modern defense — publicly append-only logs allow domain owners to detect unauthorized certificates issued for their domains
- **Certificate Revocation** mechanisms (CRL and OCSP) become the emergency brake, but browser vendors may resort to **hard-coding distrust** via updates when revocation is insufficient
- The **trust store** (list of trusted root CAs built into OSes and browsers) is the ultimate control point — removal from trust stores is effectively a death sentence for a CA
- Attackers targeting CAs often prioritize **offline root CA keys**; best practice is to keep root CAs air-gapped and use intermediate CAs for day-to-day signing

## Related concepts
[[Public Key Infrastructure]] [[Man-in-the-Middle Attack]] [[Certificate Transparency]] [[Certificate Revocation]] [[Chain of Trust]]