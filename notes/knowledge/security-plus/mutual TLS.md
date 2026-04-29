# mutual TLS

## What it is
Like a nightclub where both the bouncer checks your ID *and* you check the bouncer's badge before entering, mutual TLS (mTLS) requires both the client and server to present and verify X.509 certificates during the TLS handshake. Standard TLS only authenticates the server; mTLS adds bidirectional cryptographic authentication, ensuring neither party is an impostor.

## Why it matters
In zero-trust microservice architectures, a compromised internal service could impersonate a legitimate API and harvest sensitive data from neighboring services — a classic lateral movement technique. With mTLS enforced between every service, an attacker who compromises one container still cannot forge a valid client certificate to communicate with other services, containing the blast radius. This is exactly why platforms like Istio and Kubernetes service meshes enforce mTLS between pods by default.

## Key facts
- Both client and server must possess certificates signed by a mutually trusted Certificate Authority (CA); without a valid cert, the TLS handshake fails entirely.
- mTLS prevents **machine-in-the-middle attacks** at the transport layer even if an attacker has network access, because they cannot forge a certificate signed by the trusted CA.
- Client certificates in mTLS contain a **Subject** field (often a service name or user identity) used for access control decisions after authentication.
- The handshake adds a **CertificateRequest** message from server to client — this is the distinguishing step absent in standard TLS.
- mTLS is a core enforcement mechanism in **zero-trust network architecture (ZTNA)**, replacing implicit trust based on network location (e.g., "it's inside the firewall, so it's trusted").

## Related concepts
[[TLS handshake]] [[X.509 certificates]] [[zero trust architecture]] [[certificate authority]] [[PKI]]