# EAP

## What it is
Think of EAP like a *negotiation table* — before two parties agree on how to prove identity, they first agree on *which language they'll use to prove it*. Extensible Authentication Protocol (EAP) is a flexible authentication framework used in wireless and point-to-point connections that supports multiple authentication methods (called "types") rather than enforcing a single one. It is not a protocol itself but a *carrier* that transports whichever authentication method both sides agree to use.

## Why it matters
In a rogue access point attack, an adversary sets up a fake Wi-Fi network and waits for clients to connect. If the network uses a weak EAP type like LEAP, an attacker can capture the challenge-response exchange and crack the credentials offline using dictionary attacks — a real technique that forced Cisco to deprecate LEAP entirely. Choosing a strong EAP type like EAP-TLS (with mutual certificate authentication) closes this door because neither side can be impersonated without a valid certificate.

## Key facts
- **EAP-TLS** is the gold standard — uses mutual certificate authentication (both client and server present certs); most secure but hardest to deploy
- **PEAP** (Protected EAP) wraps the inner authentication in a TLS tunnel; commonly used with MS-CHAPv2 for username/password auth on enterprise Wi-Fi
- **EAP-TTLS** similar to PEAP but more flexible — allows non-Microsoft inner authentication methods
- **LEAP** (Cisco's old proprietary EAP) is considered broken and should never be used — vulnerable to offline dictionary attacks
- EAP operates over **802.1X** in enterprise wireless (WPA2-Enterprise), with the authenticator (AP) relaying EAP messages to a **RADIUS** server that makes the actual auth decision

## Related concepts
[[802.1X]] [[RADIUS]] [[WPA2-Enterprise]]