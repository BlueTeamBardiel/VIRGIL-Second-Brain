# Network Authentication Protocols

## What it is
Think of network authentication like a bouncer checking IDs at a club — the protocol is the *rulebook* the bouncer follows to decide whether your ID is real, expired, or forged. Precisely, network authentication protocols are standardized systems that verify the identity of users, devices, or services before granting access to network resources. They define the challenge-response handshakes, credential formats, and cryptographic methods used to prove "you are who you claim to be."

## Why it matters
In 2017, attackers exploited weak NTLM authentication in Windows environments using **Pass-the-Hash** attacks — capturing hashed credentials from memory and replaying them without ever cracking the password. Organizations running Kerberos with proper ticket controls were significantly more resilient, since Kerberos tickets are time-limited and tied to session context, making raw hash replay ineffective.

## Key facts
- **Kerberos** uses a trusted third-party Key Distribution Center (KDC) and time-stamped tickets; clocks must be within **5 minutes** of each other or authentication fails (replay protection)
- **NTLM** is a challenge-response protocol that stores password hashes — vulnerable to Pass-the-Hash and relay attacks; Microsoft recommends disabling NTLMv1 entirely
- **RADIUS** centralizes authentication for network access (VPNs, Wi-Fi) and uses UDP ports **1812** (authentication) and **1813** (accounting)
- **TACACS+** encrypts the *entire* payload (unlike RADIUS which only encrypts the password), making it preferred for device administration (routers, switches)
- **EAP (Extensible Authentication Protocol)** is a framework — not a protocol itself — used within 802.1X to support methods like EAP-TLS (certificate-based) and PEAP (tunneled password)

## Related concepts
[[Kerberos Ticket Attacks]] [[Multi-Factor Authentication]] [[802.1X Port-Based Access Control]]