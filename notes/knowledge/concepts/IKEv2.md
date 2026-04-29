# IKEv2

## What it is
Like two diplomats agreeing on a secret language before exchanging classified cables, IKEv2 is the handshake protocol that negotiates and establishes the Security Associations (SAs) used by IPsec. It handles mutual authentication and key exchange so that IPsec can encrypt and authenticate the actual traffic — IKEv2 sets the terms, IPsec does the work.

## Why it matters
In a VPN credential-stuffing attack, an adversary targeting an IKEv2/IPsec endpoint can attempt to exploit weak pre-shared keys (PSKs) because IKEv2 in PSK mode leaks enough handshake material for offline dictionary attacks. Switching to certificate-based authentication eliminates this surface entirely — a critical hardening step for enterprise VPN gateways running protocols like IKEv2 on UDP port 500.

## Key facts
- IKEv2 operates over **UDP port 500** (and port 4500 for NAT traversal), replacing the older IKEv1 with a simpler, faster two-exchange process
- It supports **EAP (Extensible Authentication Protocol)**, enabling integration with RADIUS/Active Directory for user-level authentication — common in enterprise "road warrior" VPNs
- IKEv2 provides **MOBIKE** (Mobility and Multihoming Protocol), allowing VPN sessions to survive IP address changes — key for mobile devices switching between Wi-Fi and cellular
- Supports **Perfect Forward Secrecy (PFS)**: each session generates ephemeral Diffie-Hellman keys, so compromising long-term keys doesn't decrypt past sessions
- IKEv2 uses a **cookie mechanism** to defend against denial-of-service attacks by requiring the initiator to prove its IP address before the responder commits resources

## Related concepts
[[IPsec]] [[Perfect Forward Secrecy]] [[IKEv1]] [[VPN]] [[Diffie-Hellman]]