# Tailscale

## What it is
Think of it like a bouncer who recognizes every face at the door — no VPN gateway bouncer to overwhelm, just peers vouching directly for each other. Tailscale is a mesh VPN service built on WireGuard that uses a coordination server (control plane) to distribute public keys, while actual traffic flows peer-to-peer between authenticated devices. Each node gets a stable 100.x.x.x address in a private "tailnet," regardless of what NAT or firewall sits in front of it.

## Why it matters
A SOC analyst working remotely can access internal dashboards and SIEM tools without exposing those services to the public internet at all — the attack surface is reduced to zero publicly visible ports. Conversely, an attacker who compromises a developer's laptop with Tailscale installed gains direct routable access to every other node on that tailnet, potentially bypassing all perimeter firewalls entirely. This makes endpoint protection and identity provider (IdP) integration critical in Tailscale deployments.

## Key facts
- Uses **WireGuard** as the underlying tunneling protocol, inheriting its minimal attack surface (~4,000 lines of code vs. OpenVPN's ~600,000)
- Authentication is delegated to an **external IdP** (Google, Okta, GitHub), meaning Tailscale itself never stores passwords — compromise the IdP, compromise the tailnet
- **MagicDNS** assigns stable hostnames to nodes, enabling zero-config service discovery without split-horizon DNS setup
- **ACLs (Access Control Lists)** are defined in HuJSON and enforced by the coordination server, allowing zero-trust micro-segmentation within the tailnet
- Tailscale nodes use **DERP (Designated Encrypted Relay for Packets)** servers as fallback when direct peer-to-peer NAT traversal fails, which introduces a relay the organization does not control

## Related concepts
[[WireGuard]] [[Zero Trust Architecture]] [[Network Access Control]] [[VPN Split Tunneling]] [[Identity Provider Federation]]