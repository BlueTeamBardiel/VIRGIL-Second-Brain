# IPsec

## What it is
Think of IPsec like a armored postal truck — not just sealing the letter inside an envelope, but encrypting the entire vehicle, verifying the driver's identity, and ensuring nothing was tampered with in transit. IPsec is a suite of protocols that operates at Layer 3 (Network layer) to provide authentication, integrity, and encryption for IP packets. It can protect entire network paths transparently, without requiring applications to be modified.

## Why it matters
A corporate VPN connecting remote offices over the public internet relies on IPsec to prevent a man-in-the-middle attacker on the ISP backbone from reading or injecting traffic. Without IPsec, an attacker with access to a BGP router along the path could silently capture credentials or modify financial data flowing between sites — and neither endpoint would notice.

## Key facts
- IPsec has two core protocols: **AH (Authentication Header)** provides integrity and authentication but *no encryption*; **ESP (Encapsulating Security Payload)** provides integrity, authentication, *and* encryption — ESP is what you almost always use
- **Tunnel mode** encapsulates the *entire original IP packet* (used for VPNs between gateways); **Transport mode** only encrypts the payload, leaving the original header intact (used for host-to-host)
- **IKE (Internet Key Exchange)** — specifically IKEv2 — handles the negotiation of Security Associations (SAs) and key exchange before encrypted traffic flows
- A **Security Association (SA)** is a one-way logical connection storing the agreed algorithms, keys, and parameters; a bidirectional session requires *two* SAs
- IPsec operates entirely at Layer 3, making it **application-agnostic** — it protects all traffic (TCP, UDP, ICMP) without changes to higher-layer protocols

## Related concepts
[[VPN]] [[IKE]] [[TLS]] [[AH Protocol]] [[ESP Protocol]] [[Security Association]]