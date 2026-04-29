# IEEE 802.11 Wi-Fi Standard

## What it is
Think of 802.11 as the rulebook for a crowded restaurant where everyone shouts orders simultaneously — it defines exactly *how* wireless devices take turns transmitting over shared radio frequencies without stepping on each other. More precisely, IEEE 802.11 is a family of specifications governing wireless local area network (WLAN) communications, defining physical layer modulation, MAC-layer access control, and security protocols. Different amendments (a/b/g/n/ac/ax) define frequency bands, speeds, and capabilities.

## Why it matters
An attacker parked outside a corporate office can set up an **evil twin access point** — a rogue AP broadcasting the same SSID as the legitimate network — because 802.11 authentication by default verifies clients to APs but not APs to clients. Employees' devices auto-reconnect, funneling all traffic through the attacker's machine. Deploying 802.1X with certificate-based mutual authentication directly counters this by requiring the AP itself to prove its identity.

## Key facts
- **2.4 GHz vs. 5 GHz**: 2.4 GHz travels farther but has only 3 non-overlapping channels (1, 6, 11); 5 GHz offers more channels with less interference but shorter range
- **802.11i** is the security amendment that formalized WPA2, mandating AES-CCMP encryption — this is what replaced the broken WEP and transitional WPA/TKIP
- **WPA3** (introduced 2018) adds Simultaneous Authentication of Equals (SAE), replacing PSK handshakes vulnerable to offline dictionary attacks
- **CSMA/CA** (Collision Avoidance) governs channel access — devices *listen before transmitting* since wireless cannot detect collisions mid-transmission like wired Ethernet can
- **Beacon frames** are broadcast unencrypted by APs to advertise their SSID and capabilities — a passive scan captures these without ever connecting

## Related concepts
[[WPA2 and WPA3 Encryption]] [[Evil Twin Attack]] [[802.1X Network Access Control]]