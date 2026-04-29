# captive portals

## What it is
Think of it like a velvet rope at a club — you're "inside" the network, but a bouncer blocks all your traffic until you show your ID (accept terms, pay, or authenticate). Technically, a captive portal is a web page that intercepts HTTP/HTTPS traffic from unauthenticated clients on a network, redirecting them to an authentication or acceptance page before granting full internet access. Common in hotel Wi-Fi, airports, and coffee shops.

## Why it matters
Attackers deploy rogue captive portals as part of evil twin attacks — they stand up a fake Wi-Fi access point mimicking "AirportFreeWiFi," and when victims connect, the captive portal harvests credentials or injects malware before granting internet access. A defender scenario: enterprises use captive portals with 802.1X fallback to force guest users into an isolated VLAN, preventing lateral movement into the corporate network.

## Key facts
- Captive portals work by hijacking DNS responses or using ARP manipulation to redirect all outbound traffic to the portal IP until the client is whitelisted by MAC address.
- HTTPS Everywhere and HSTS preloading can **break** captive portal redirection, since browsers refuse to accept the portal's certificate for preloaded domains — a known usability vs. security tension.
- Rogue captive portals are a primary delivery mechanism in **man-in-the-middle (MitM)** attacks on public Wi-Fi.
- Captive portals offer **no encryption** by default; all traffic before and sometimes after authentication may be transmitted in cleartext over the shared wireless medium.
- From a Security+ perspective, captive portals are classified under **network access control (NAC)** mechanisms — specifically as a compensating control for guest network segmentation.

## Related concepts
[[evil twin attack]] [[rogue access point]] [[network access control]] [[802.1X]] [[man-in-the-middle attack]]