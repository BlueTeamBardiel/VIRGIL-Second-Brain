# Secure Communication

## What it is

In Persona 5, the Phantom Thieves communicate through the Metaverse Navigator app — outsiders see a regular phone, but the team has a private channel that authenticates members, hides their location, and lets them coordinate heists without the police intercepting a single word. That's exactly what **secure communication** does — it wraps your traffic in cryptography and authentication so eavesdroppers see nothing useful and impostors can't join the conversation.

Secure communication is the use of cryptographic protocols, tunneling, and authenticated channels to protect data in transit against interception, modification, and impersonation across untrusted networks.

## Why it matters

Without secure channels, every credential, session token, and confidential record traverses the wire in plaintext, making **on-path attacks**, **session hijacking**, and **credential theft** trivial. Compliance regimes — PCI DSS, HIPAA, GDPR — all mandate encryption in transit, so failure here is both a breach vector and an audit finding. Exam angle: SY0-701 Objective 3.2 expects you to know **VPN**, **TLS**, **IPSec**, **SD-WAN**, and **SASE**, plus the difference between tunnel and transport modes. CompTIA's favorite trap is conflating **IPSec AH** (integrity only, no confidentiality) with **ESP** (both) — memorize that one.

## Key facts

### Core protocols

| Protocol | Port | Purpose | Layer |
|---|---|---|---|
| [[TLS]] 1.3 | 443 (HTTPS) | Confidentiality + integrity for app traffic | Transport/Session |
| [[IPSec]] | 500/4500 UDP | Network-layer encryption + authentication | Network |
| [[SSH]] | 22 | Encrypted remote shell + tunneling | Application |
| [[DTLS]] | varies | TLS for UDP (VoIP, gaming, [[VPN]]s) | Transport |
| [[S/MIME]] | — | Signed/encrypted email | Application |
| [[HTTPS]] | 443 | HTTP over TLS | Application |

### IPSec components

- **[[AH]] (Authentication Header)** — integrity + authentication, **no encryption**. Protocol 51.
- **[[ESP]] (Encapsulating Security Payload)** — integrity + authentication + **encryption**. Protocol 50.
- **[[IKE]] (Internet Key Exchange)** — negotiates the **[[Security Association]]** (SA). IKEv2 preferred.
- **Transport mode** — encrypts payload only; endpoint-to-endpoint.
- **Tunnel mode** — encrypts entire packet including original header; site-to-site **VPN**.

### VPN architectures

- **[[Site-to-site VPN]]** — gateway-to-gateway, persistent, typically IPSec tunnel mode.
- **[[Remote-access VPN]]** — user device to corporate gateway; often **TLS-based** ([[SSL VPN]]) or IPSec.
- **[[Full tunnel]]** — all traffic routes through the VPN. Safer, slower.
- **[[Split tunnel]]** — only corporate traffic tunneled; rest goes direct. Faster, riskier.
- **[[Always-on VPN]]** — auto-connects whenever the device is online.
- **[[Clientless VPN]]** — browser-based TLS portal; no installed agent.

### Modern secure-edge architectures

- **[[SD-WAN]]** (Software-Defined WAN) — replaces MPLS with internet links plus encrypted overlays; centralized policy, application-aware routing.
- **[[SASE]]** (Secure Access Service Edge) — converges SD-WAN with cloud-delivered security: **[[CASB]]**, **[[SWG]]**, **[[ZTNA]]**, **FWaaS**. Pronounced "sassy" by people who shouldn't be allowed to name things.
- **[[ZTNA]]** (Zero Trust Network Access) — replaces flat VPN access with per-application, identity-aware micro-tunnels.

### Cryptographic foundations

- **[[Perfect Forward Secrecy]]** (PFS) — ephemeral keys ([[ECDHE]], DHE) so a compromised long-term key can't decrypt past sessions. TLS 1.3 mandates it.
- **[[Cipher suite]]** — combination of key exchange, authentication, bulk cipher, and MAC (e.g., `TLS_AES_256_GCM_SHA384`).
- **[[Certificate]] validation** — chain of trust to a [[Root CA]]; revocation via **[[CRL]]** or **[[OCSP stapling]]**.
- **[[Mutual TLS]]** (mTLS) — both client and server present certificates; common in zero-trust and service meshes.

### Common failures and attacks

- **[[Downgrade attack]]** — forcing TLS 1.0/SSLv3 (see POODLE). Defense: disable legacy protocols.
- **[[On-path attack]]** (formerly MITM) — intercepting unencrypted or improperly validated channels.
- **[[Certificate pinning]]** bypass — defeated by trusting attacker-controlled CAs.
- **Split-tunnel data leakage** — corporate data exfiltrated via the unprotected leg.
- **[[Replay attack]]** — defeated by sequence numbers and nonces in IPSec/TLS.

## Related concepts

[[TLS]] · [[IPSec]] · [[VPN]] · [[SD-WAN]] · [[SASE]] · [[ZTNA]] · [[Perfect Forward Secrecy]] · [[Mutual TLS]] · [[PKI]] · [[On-path attack]]

---
*Source: VIRGIL knowledge base — 2026-05-08*