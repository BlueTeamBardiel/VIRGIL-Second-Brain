# WLAN

## What it is
Like replacing a building's wired intercom system with walkie-talkies — convenient, but now anyone nearby can potentially listen in. A Wireless Local Area Network (WLAN) is a network that uses radio frequency (RF) signals, typically following IEEE 802.11 standards, to connect devices without physical cables, operating in the 2.4 GHz and 5 GHz bands.

## Why it matters
At a coffee shop, an attacker sets up a rogue access point named "Free_WiFi" that mimics the legitimate network — an evil twin attack. Customers connect automatically, and the attacker performs a man-in-the-middle attack, intercepting unencrypted credentials and session tokens in real time. This is why certificate validation and VPN use on public WLANs are critical defensive practices.

## Key facts
- **WPA3** is the current strongest WLAN security protocol; WPA2-Enterprise using 802.1X/EAP with RADIUS is the gold standard for corporate environments
- **WEP** (Wired Equivalent Privacy) is completely broken — IV reuse allows key recovery in minutes using tools like Aircrack-ng; never acceptable
- **802.11ac (Wi-Fi 5)** operates exclusively on 5 GHz; **802.11ax (Wi-Fi 6)** supports both bands and introduces OFDMA for efficiency
- Rogue access points and evil twin attacks are detected through **wireless intrusion prevention systems (WIPS)** that monitor for unauthorized BSSIDs
- **Deauthentication attacks** exploit the fact that 802.11 management frames are unauthenticated — 802.11w (Protected Management Frames) mitigates this, and is mandatory in WPA3

## Related concepts
[[WPA3]] [[Evil Twin Attack]] [[802.1X Authentication]] [[Rogue Access Point]] [[War Driving]]