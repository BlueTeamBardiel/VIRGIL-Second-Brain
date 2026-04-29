# Supplicant

## What it is
Like a traveler presenting their passport at a border checkpoint before being allowed entry, a supplicant is the device or client that requests access to a network and must prove its identity first. Precisely, it is the entity in the IEEE 802.1X authentication framework that initiates the authentication process and provides credentials to the authenticator. The supplicant software runs on the end-user device (e.g., a laptop or smartphone) and communicates using the Extensible Authentication Protocol (EAP).

## Why it matters
In a rogue access point attack, an adversary sets up a fake WAP mimicking a legitimate network. When a user connects, their supplicant software automatically submits credentials to the attacker's authenticator, potentially exposing EAP identity information or even password hashes depending on the EAP method in use. Deploying mutual authentication EAP methods (like EAP-TLS) ensures the supplicant also verifies the authenticator, breaking this attack chain.

## Key facts
- The 802.1X framework has three roles: **Supplicant** (client), **Authenticator** (switch/WAP), and **Authentication Server** (typically RADIUS)
- The supplicant communicates with the authenticator using **EAPOL** (EAP over LAN) at Layer 2
- Until authenticated, the supplicant is restricted to an **uncontrolled port** — it cannot access network resources
- Windows, macOS, and Linux all have **built-in supplicant software**; enterprise environments may deploy dedicated supplicants (e.g., Cisco AnyConnect)
- Weak EAP methods (e.g., LEAP, EAP-MD5) expose supplicants to **offline dictionary attacks**; EAP-TLS with certificates is the gold standard

## Related concepts
[[802.1X]] [[RADIUS]] [[Extensible Authentication Protocol (EAP)]] [[Authenticator]] [[Network Access Control]]