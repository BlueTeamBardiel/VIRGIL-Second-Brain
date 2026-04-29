# Trust Management

## What it is
Like a bouncer with a guest list who also checks whether the list itself was signed by the club owner — trust management is the systematic process of establishing, validating, and maintaining the trustworthiness of entities, credentials, and relationships within a system. It defines *who* trusts *whom*, *how much*, and *under what conditions*, using policies to govern those decisions dynamically.

## Why it matters
In 2011, the Dutch certificate authority DigiNotar was compromised, and attackers issued fraudulent SSL certificates for Google.com. Browsers trusted DigiNotar because it sat in their trusted root store — a trust management failure. Once discovered, vendors revoked DigiNotar's root certificate, instantly untrusting every certificate it had ever signed, demonstrating how trust management decisions cascade across entire ecosystems.

## Key facts
- **Trust anchors** are the root entities (e.g., root CAs) that a system inherently trusts; all other trust is derived from them
- **Transitive trust** means if A trusts B and B trusts C, A may implicitly trust C — a common attack vector in federated identity systems
- **Zero Trust Architecture** explicitly rejects implicit trust, requiring continuous verification of every user, device, and session regardless of network location
- **Certificate Revocation** (via CRL or OCSP) is a trust management mechanism that withdraws previously granted trust before expiration
- Trust relationships in PKI can be structured as **hierarchical** (single root CA), **mesh** (cross-certified CAs), or **web of trust** (PGP model — peer vouching)

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Zero Trust Architecture]] [[Certificate Revocation]] [[Federation and SSO]] [[Chain of Trust]]