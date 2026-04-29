# Cryptographic Protocols

## What it is
Think of a cryptographic protocol like a carefully choreographed diplomatic handshake ceremony — both parties must perform specific moves, in exact order, with verified credentials, before any real conversation begins. Precisely defined, a cryptographic protocol is a step-by-step procedure that uses cryptographic algorithms to achieve security goals such as authentication, confidentiality, or key exchange between two or more parties.

## Why it matters
In 2014, the POODLE attack exploited a flaw in SSL 3.0's protocol design — not its underlying cipher — forcing browsers to "fall back" to an older, weaker protocol version that attackers could then decrypt. This demonstrated that even mathematically sound ciphers fail when the surrounding protocol logic is flawed, allowing attackers to strip away encryption entirely through manipulation of the handshake process.

## Key facts
- **TLS 1.3** (current standard) eliminates weak cipher suites, removes RSA key exchange, and mandates Perfect Forward Secrecy — exam favorite for "most secure transport protocol"
- **SSL 2.0/3.0** are deprecated and should never be enabled; their presence is a configuration vulnerability, not just an outdated preference
- **Kerberos** is an authentication protocol using tickets and a trusted Key Distribution Center (KDC) — common in Active Directory environments
- **IPSec** operates at Layer 3 and uses two modes: **Transport** (encrypts payload only) and **Tunnel** (encrypts the entire packet, used in VPNs)
- Protocol downgrade attacks (POODLE, DROWN) force negotiation to weaker protocol versions — mitigated by disabling legacy protocol support entirely

## Related concepts
[[TLS/SSL]] [[Key Exchange Algorithms]] [[Authentication Protocols]] [[Perfect Forward Secrecy]] [[IPSec]]