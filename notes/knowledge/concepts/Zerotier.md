# Zerotier

## What it is
Think of it like a magic teleporter that makes your laptop in a coffee shop act as if it's physically plugged into your home office switch — regardless of firewalls, NAT, or geography. ZeroTier is a software-defined networking (SDN) platform that creates encrypted peer-to-peer virtual LANs over the internet, using a centralized control plane for network membership while data flows directly between peers.

## Why it matters
Attackers with a foothold inside a corporate network have weaponized ZeroTier to establish persistent, covert C2 channels — by enrolling a compromised host into an attacker-controlled ZeroTier network, they bypass egress firewall rules because ZeroTier traffic rides over UDP port 9993 and blends with normal encrypted traffic. Defenders hunting for this must monitor for unexpected ZeroTier processes (`zerotier-one`), unusual outbound UDP to ZeroTier root servers (`planet` files), or unauthorized virtual NIC creation on endpoints.

## Key facts
- ZeroTier operates on a **planet/moon/leaf** hierarchy: global root servers (planets) coordinate peer discovery, while data traverses directly between leaf nodes using a protocol similar to VXLAN over encrypted UDP.
- Uses **Curve25519** for key exchange and **AES-256-GCM** for data encryption — every node has a cryptographic identity (40-bit address derived from its public key).
- Network membership is controlled by a **Network ID** + controller authorization, meaning joining a network requires explicit admin approval (or a misconfigured public network).
- Threat actors (e.g., groups using tools like **ZeroT RAT** variants) abuse it because it **circumvents NAT traversal restrictions** that would block traditional reverse shells.
- From a compliance standpoint, unauthorized ZeroTier installation can violate **network segmentation controls** required by PCI-DSS and NIST SP 800-53 (SC-7).

## Related concepts
[[VPN Tunneling]] [[Software-Defined Networking]] [[C2 Infrastructure]] [[Network Segmentation]] [[Lateral Movement]]