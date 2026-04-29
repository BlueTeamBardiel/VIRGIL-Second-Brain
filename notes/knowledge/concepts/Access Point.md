# Access Point

## What it is
Think of it as a wireless mailroom in an office building — every Wi-Fi device in the area drops off and picks up its network traffic there. An Access Point (AP) is a networking device that creates a wireless local area network (WLAN) by bridging wireless clients to a wired network infrastructure. Unlike a router, an AP itself doesn't route traffic — it simply provides the wireless on-ramp.

## Why it matters
A classic attack involves standing up a **rogue access point** — an unauthorized AP that mimics a legitimate corporate SSID. Employees connect automatically (especially if their devices have auto-join enabled), and the attacker intercepts all traffic in a man-in-the-middle position, harvesting credentials and session tokens without anyone noticing. Defending against this requires wireless intrusion detection systems (WIDS) and 802.1X authentication, which prevents clients from associating with APs that can't present valid credentials.

## Key facts
- **Evil twin attacks** use an AP broadcasting the same SSID as a legitimate network, often with higher signal strength to force client association
- **802.11 standards** define AP behavior: 802.11ac (Wi-Fi 5) and 802.11ax (Wi-Fi 6) are current enterprise standards; knowing protocol generations appears on Security+ exams
- **WPA3** is the current recommended encryption standard for APs, replacing the vulnerable WPA2-PSK (susceptible to offline dictionary attacks)
- A **fat AP** contains its own management logic; a **thin AP** relies on a wireless controller — a key architecture distinction in enterprise environments
- **Disassociation attacks** exploit the unprotected 802.11 management frames to forcibly disconnect clients from legitimate APs (mitigated by 802.11w Management Frame Protection)

## Related concepts
[[Evil Twin Attack]] [[Rogue Access Point]] [[WPA3]] [[802.1X Authentication]] [[Man-in-the-Middle Attack]]