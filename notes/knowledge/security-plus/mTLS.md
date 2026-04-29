# mTLS

## What it is
Like a nightclub where both the bouncer checks your ID *and* you check the bouncer's badge before entering, mTLS (Mutual TLS) requires **both** the client and server to present and verify X.509 certificates before a connection is established. Standard TLS only authenticates the server; mTLS adds bidirectional authentication, ensuring neither party is an impostor.

## Why it matters
In a microservices architecture, a compromised internal service could impersonate a legitimate API and harvest sensitive data from other services — a classic lateral movement scenario. With mTLS enforced between every service (as in a Zero Trust network), a rogue container without a valid certificate simply cannot open a connection, stopping credential harvesting before it starts. This is why platforms like Istio and Kubernetes service meshes enforce mTLS for all east-west traffic by default.

## Key facts
- mTLS uses **X.509 certificates on both sides** — the client holds a cert signed by a trusted CA, not just the server
- Defeats **machine-in-the-middle attacks** more robustly than server-only TLS because the attacker must possess a valid client certificate
- Certificate management burden is significantly higher — requires a **PKI to issue, rotate, and revoke** client certs at scale
- Common in **API security, Zero Trust architectures, and service mesh implementations** (Istio, Linkerd, Consul Connect)
- Client certificate verification happens during the **TLS handshake** — specifically, the server sends a `CertificateRequest` message and the client responds with its certificate before the session key is derived
- mTLS does **not** replace application-layer authentication (e.g., OAuth tokens); it authenticates the *machine*, not the *user*

## Related concepts
[[TLS Handshake]] [[X.509 Certificates]] [[Public Key Infrastructure]] [[Zero Trust Architecture]] [[Certificate Revocation]]