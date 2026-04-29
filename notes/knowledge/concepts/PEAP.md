# PEAP

## What it is
Think of PEAP like a secret diplomatic pouch: the outer envelope (a TLS tunnel) is visible to everyone, but the sensitive credentials inside are completely hidden from eavesdroppers. Protected Extensible Authentication Protocol (PEAP) is a wireless authentication framework that wraps EAP inside an encrypted TLS tunnel, allowing inner authentication methods (typically MSCHAPv2) to run securely without exposing credentials in plaintext.

## Why it matters
In a rogue access point attack, an adversary sets up an evil twin Wi-Fi network to intercept authentication attempts. Without proper server certificate validation configured on clients, PEAP users will happily complete the TLS handshake with the attacker's fake RADIUS server — handing over MSCHAPv2 challenge-response hashes that can then be cracked offline with tools like Hashcat to recover plaintext passwords. This is why certificate validation is the critical defense in any PEAP deployment.

## Key facts
- PEAP uses a **server-side certificate only** — the client authenticates inside the tunnel, so no client certificate is required (unlike EAP-TLS)
- The most common PEAP inner method is **PEAPv0/EAP-MSCHAPv2**, developed by Microsoft and Cisco; PEAPv1 uses EAP-GTC
- PEAP is defined in an **IETF Internet Draft** (not a formal RFC), yet it dominates enterprise Wi-Fi deployments
- Without configuring clients to **validate the RADIUS server certificate**, PEAP provides nearly no protection against evil twin/man-in-the-middle attacks
- Operates within the **802.1X authentication framework**, requiring a RADIUS server (authenticator) between the wireless client (supplicant) and the network

## Related concepts
[[EAP-TLS]] [[802.1X]] [[RADIUS]] [[MSCHAPv2]] [[Evil Twin Attack]]