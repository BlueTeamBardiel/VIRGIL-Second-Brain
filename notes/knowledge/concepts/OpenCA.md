# OpenCA

## What it is
Think of OpenCA as the DMV for digital identities — it issues, tracks, and revokes the "driver's licenses" (certificates) that prove who you are online. More precisely, OpenCA is an open-source Public Key Infrastructure (PKI) management framework that implements X.509 certificate lifecycle management, including issuance, renewal, and revocation through Certificate Revocation Lists (CRLs).

## Why it matters
In enterprise environments, a misconfigured or unpatched OpenCA deployment can allow an attacker to issue rogue certificates, enabling man-in-the-middle attacks against internal HTTPS traffic. In 2011-style CA compromise scenarios, attackers who gain access to a CA's signing infrastructure can mint certificates for any domain — making OpenCA's access controls and HSM integration critical defensive chokepoints.

## Key facts
- OpenCA implements the full X.509 PKI stack: Root CA, Intermediate CA, and end-entity certificate issuance — mirroring the chain-of-trust model tested on Security+
- Supports OCSP (Online Certificate Status Protocol) and CRL publication for certificate revocation — both are exam-relevant revocation methods
- Written in Perl with a web-based interface (OpenCA OPENCA-RA), allowing Registration Authority (RA) roles to be separated from the actual CA signing function
- Uses OpenSSL as its cryptographic backend, meaning OpenSSL vulnerabilities (e.g., Heartbleed) directly impact OpenCA deployments
- Certificate templates in OpenCA enforce key usage extensions — critical for ensuring certificates aren't misused across roles (e.g., a TLS cert used for code signing)

## Related concepts
[[Public Key Infrastructure]] [[X.509 Certificates]] [[Certificate Revocation List]] [[OCSP]] [[Certificate Authority]]