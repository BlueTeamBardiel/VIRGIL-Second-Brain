# X.509 Certificates

## What it is
Think of an X.509 certificate like a notarized passport for a server — it proves identity, carries credentials, and has an expiration date, all stamped by a trusted authority. Precisely, X.509 is an ITU-T standard defining the format of public key certificates used in PKI to bind a public key to an entity's identity. A Certificate Authority (CA) digitally signs the certificate, making it verifiable by anyone who trusts that CA.

## Why it matters
In 2011, the Dutch CA DigiNotar was compromised and issued fraudulent X.509 certificates for google.com, allowing Iranian attackers to perform man-in-the-middle attacks against ~300,000 users — intercepting encrypted Gmail traffic transparently. This attack exposed how a single rogue or compromised CA can undermine the entire trust chain, because browsers trusted DigiNotar by default. The incident led directly to DigiNotar's bankruptcy and accelerated adoption of Certificate Transparency logs.

## Key facts
- **Fields that matter:** Subject, Issuer, Subject Alternative Name (SAN), Public Key, Validity Period, Serial Number, and Signature Algorithm
- **Version 3** introduced extensions including SAN, Key Usage, and Basic Constraints — the version used in virtually all modern TLS deployments
- Certificates use a **chain of trust**: Root CA → Intermediate CA → End-entity certificate; browsers validate the entire chain
- Revocation is checked via **CRL (Certificate Revocation List)** or **OCSP (Online Certificate Status Protocol)**; OCSP stapling improves performance by having the server pre-fetch revocation status
- A **self-signed certificate** has the same entity as both subject and issuer — valid for internal testing but never trusted by public browsers without manual installation

## Related concepts
[[Public Key Infrastructure]] [[Certificate Authority]] [[TLS/SSL]] [[Certificate Transparency]] [[OCSP Stapling]]