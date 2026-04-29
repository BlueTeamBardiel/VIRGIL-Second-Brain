# Wi-Fi Alliance

## What it is
Think of them as the FDA for wireless networking — they don't invent the food, but they certify it's safe and consistent before it reaches your table. The Wi-Fi Alliance is a nonprofit consortium of technology companies responsible for certifying that wireless devices comply with IEEE 802.11 standards and for developing security protocols like WPA, WPA2, and WPA3. They own the "Wi-Fi" trademark and ensure interoperability between devices from different manufacturers.

## Why it matters
When WPA2 was found vulnerable to the KRACK (Key Reinstallation Attack) in 2017, it was the Wi-Fi Alliance that coordinated the industry response, mandating patches and accelerating the push toward WPA3 certification. An attacker exploiting KRACK could force nonce reuse in the four-way handshake, decrypting traffic on a supposedly secure network — a direct consequence of a flaw in the protocol the Alliance had certified. Understanding the Alliance's role explains *why* WPA3 adoption timelines matter for enterprise security posture.

## Key facts
- The Wi-Fi Alliance introduced **WPA3** in 2018, which replaced PSK with **SAE (Simultaneous Authentication of Equals)**, eliminating offline dictionary attacks against the handshake
- **WPA2-Enterprise** (using 802.1X/EAP) is the Alliance-certified standard for corporate environments and is frequently tested on Security+
- The Alliance created **Wi-Fi Protected Setup (WPS)**, which was later found vulnerable to brute-force PIN attacks — a classic example of convenience undermining security
- **WPA3-Personal** provides forward secrecy; capturing today's handshake won't decrypt yesterday's traffic
- The Alliance's **Enhanced Open** certification uses Opportunistic Wireless Encryption (OWE) to encrypt open networks without requiring passwords

## Related concepts
[[WPA3]] [[Four-Way Handshake]] [[802.1X Authentication]] [[KRACK Attack]] [[Wireless Security Protocols]]