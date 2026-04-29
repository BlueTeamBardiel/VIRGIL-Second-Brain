# EAP-TTLS

## What it is
Think of it like a two-way bank vault door: the bank verifies its identity to you first by showing credentials, then you submit yours through that secure channel. EAP-TTLS (Extensible Authentication Protocol - Tunneled Transport Layer Security) establishes a one-sided TLS tunnel using only a server-side certificate, then transmits client credentials securely inside that encrypted tunnel. Unlike EAP-TLS, clients don't need their own certificates — they can authenticate using legacy methods like PAP or MSCHAPv2 inside the tunnel.

## Why it matters
In enterprise Wi-Fi deployments, attackers set up rogue access points mimicking legitimate WPA2-Enterprise networks — an "evil twin" attack. If clients aren't configured to validate the server certificate, they'll happily connect to the attacker's RADIUS server, submit credentials inside a tunnel the attacker controls, and hand over domain passwords. Proper EAP-TTLS deployment *requires* clients to pin or validate the server certificate to prevent this credential harvesting.

## Key facts
- **Two phases**: Phase 1 builds the TLS tunnel (server cert only); Phase 2 transmits client authentication credentials through the tunnel
- **No client certificate required** — reduces PKI overhead compared to EAP-TLS, making it easier to deploy at scale
- **Inner authentication methods** can be PAP, CHAP, MSCHAPv2, or even another EAP type — this flexibility is both a strength and a risk
- **Server certificate validation is optional by default** in many supplicants — misconfiguration is the #1 real-world weakness
- Compared to PEAP, EAP-TTLS supports a wider range of inner protocols and is more common in non-Windows environments

## Related concepts
[[EAP-TLS]] [[PEAP]] [[802.1X]] [[RADIUS]] [[Evil Twin Attack]]