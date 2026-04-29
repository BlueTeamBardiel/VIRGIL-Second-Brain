# Certificate Lifecycle Management

## What it is
Think of a digital certificate like a carton of milk — it has an expiration date stamped on it, and letting it sit too long causes real problems. Certificate Lifecycle Management (CLM) is the systematic process of provisioning, deploying, monitoring, renewing, and revoking X.509 digital certificates from issuance through expiration across an organization's infrastructure.

## Why it matters
In 2020, Microsoft Teams went down globally for hours because an SSL/TLS certificate expired without automated renewal — a classic lifecycle failure. Attackers also exploit orphaned certificates (forgotten, still-valid certs tied to decommissioned services) to impersonate legitimate services or intercept traffic through man-in-the-middle attacks.

## Key facts
- The full lifecycle includes: **Request → Issuance → Deployment → Monitoring → Renewal → Revocation**
- Certificate revocation is handled via **CRL (Certificate Revocation List)** or **OCSP (Online Certificate Status Protocol)**; OCSP is preferred for near-real-time status checks
- **Certificate pinning** is a hardening technique that locks an application to a specific certificate or public key, reducing substitution risk but complicating legitimate renewals
- Most organizations set renewal thresholds at **30–90 days before expiration** to avoid service disruption; Let's Encrypt certificates expire every **90 days** by design to force automation
- Failure to revoke certificates after an employee departure or key compromise creates **zombie certificates** — valid credentials that can be weaponized long after the asset is gone

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Certificate Authority (CA)]] [[OCSP Stapling]] [[Transport Layer Security (TLS)]] [[Key Management]]