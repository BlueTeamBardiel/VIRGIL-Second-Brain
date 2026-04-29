# digital certificates

## What it is
Think of a digital certificate like a notarized passport — it's a document that a trusted authority has stamped to confirm "yes, this public key genuinely belongs to this entity." Precisely, a digital certificate is an X.509-formatted file that binds a public key to an identity (person, server, or organization), digitally signed by a Certificate Authority (CA) to prove its authenticity. Without that CA signature, anyone could forge a key pair and claim to be your bank.

## Why it matters
In 2011, attackers compromised Dutch CA DigiNotar and issued fraudulent certificates for Google.com, enabling man-in-the-middle attacks against ~300,000 Iranian Gmail users — their browsers trusted the fake cert because it bore a legitimate CA signature. This incident shows that the entire certificate trust model collapses the moment a CA is compromised, which is why certificate pinning and CT logs now exist as countermeasures.

## Key facts
- **X.509 standard** defines certificate structure: includes subject, issuer, validity period, public key, and CA digital signature
- **Chain of trust**: Root CA → Intermediate CA → End-entity certificate; browsers trust root CAs stored in their trust store
- **Certificate Revocation** is handled via CRL (Certificate Revocation List) or the faster OCSP (Online Certificate Status Protocol)
- **Wildcard certificates** (e.g., `*.example.com`) cover all subdomains but introduce broader exposure if the private key is compromised
- **Self-signed certificates** have no third-party CA validation — acceptable internally but trigger browser warnings and are prime MITM targets

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Certificate Authority]] [[Man-in-the-Middle Attack]] [[Certificate Transparency]] [[TLS handshake]]