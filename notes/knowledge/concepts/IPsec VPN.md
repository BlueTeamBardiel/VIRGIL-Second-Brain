# IPsec VPN

## What it is
Think of IPsec like a diplomatic pouch — ordinary mail can be opened and read at any checkpoint, but a sealed diplomatic pouch is authenticated, tamper-evident, and contents are invisible to border agents. IPsec (Internet Protocol Security) is a suite of protocols that authenticates and encrypts IP packets at the network layer (Layer 3), creating secure tunnels between endpoints across untrusted networks. Unlike SSL/TLS VPNs which operate at the application layer, IPsec secures all traffic regardless of application.

## Why it matters
In 2020, attackers exploited Pulse Secure IPsec VPN vulnerabilities (CVE-2019-11510) to steal credentials and pivot into corporate networks — demonstrating that a misconfigured or unpatched VPN gateway is a high-value target, not a guaranteed shield. Organizations using IPsec site-to-site tunnels between branch offices must patch aggressively and enforce strong IKE configurations, otherwise the tunnel itself becomes the attack surface.

## Key facts
- IPsec operates in two modes: **Transport mode** (encrypts payload only, headers visible) and **Tunnel mode** (encrypts entire original packet, wraps in new IP header — used in VPNs)
- Two core protocols: **AH (Authentication Header)** — provides integrity and authentication but *no encryption*; **ESP (Encapsulating Security Payload)** — provides encryption, integrity, and authentication
- **IKE (Internet Key Exchange)** handles key negotiation in two phases: Phase 1 establishes a secure channel (ISAKMP SA); Phase 2 negotiates the IPsec SA for actual data transfer
- **IKEv2** is preferred over IKEv1 — more efficient, supports MOBIKE for mobile roaming, and resists certain downgrade attacks
- IPsec uses **Security Associations (SAs)**, which are unidirectional — two SAs are required for bidirectional communication

## Related concepts
[[SSL/TLS VPN]] [[IKE Key Exchange]] [[Tunneling Protocols]] [[Network Layer Security]] [[AH and ESP Protocols]]