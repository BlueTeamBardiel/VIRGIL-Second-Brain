# site-to-site VPN

## What it is
Think of it as a permanent, invisible pneumatic tube connecting two office buildings — packets shoot through the public internet but travel inside a sealed, encrypted tunnel neither side has to think about. A site-to-site VPN is a persistent, gateway-to-gateway encrypted tunnel that connects two entire networks across an untrusted medium, so hosts on each side communicate as if they share the same local network — without individual devices needing VPN clients.

## Why it matters
A manufacturing company with a headquarters in Chicago and a factory in Guadalajara needs constant, low-friction access between their ERP systems. Without a site-to-site VPN, that traffic crosses the public internet in plaintext — a perfect target for a man-in-the-middle attack harvesting proprietary production data. With IPsec in tunnel mode between the two edge routers, the payload is encrypted and the internal IP addresses are hidden inside new headers, eliminating that exposure entirely.

## Key facts
- **IPsec is the dominant protocol stack** — typically using IKEv2 for key exchange, AES-256 for encryption, and SHA-2 for integrity in modern deployments.
- **Tunnel mode vs. transport mode**: Site-to-site uses *tunnel mode*, which encapsulates the entire original IP packet (including headers), hiding internal network topology.
- **Always-on by design**: Unlike remote-access VPNs, no user authentication triggers the tunnel — it's established automatically between gateway devices (routers or firewalls).
- **Split tunneling doesn't apply** in the traditional sense; all traffic between the two subnets flows through the tunnel by routing table design.
- **Authentication uses pre-shared keys (PSK) or digital certificates** — certificates are preferred in high-security environments because PSK compromise exposes the entire tunnel.

## Related concepts
[[IPsec]] [[IKEv2]] [[tunnel mode vs transport mode]] [[remote-access VPN]] [[split tunneling]]