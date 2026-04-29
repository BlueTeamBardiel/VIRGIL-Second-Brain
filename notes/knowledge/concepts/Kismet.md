# Kismet

## What it is
Like a silent wildlife photographer hiding in tall grass, Kismet passively observes wireless traffic without ever disturbing the environment. It is an open-source wireless network detector, sniffer, and intrusion detection system (IDS) that captures 802.11 frames passively by placing the wireless adapter into monitor mode — never transmitting a single packet itself.

## Why it matters
During a red team engagement, an attacker parks outside a corporate campus running Kismet to enumerate all SSIDs — including hidden networks that don't broadcast their names — by capturing probe responses and beacon frames. This reveals rogue access points, misconfigured devices, and the full wireless attack surface before a single connection attempt is made, all without triggering standard intrusion detection systems that look for active scanning traffic.

## Key facts
- Kismet operates in **passive mode only**, making it invisible to wireless IDS tools that detect active probes (unlike active scanners like Netstumbler)
- It can detect **hidden/cloaked SSIDs** by capturing probe request/response frames even when beacon broadcast is disabled
- Supports **multiple wireless capture sources** simultaneously, including Wi-Fi, Bluetooth, and Zigbee with appropriate hardware
- Logs captures in **pcap format**, making output directly compatible with Wireshark for deep packet analysis
- Functions as a lightweight **wireless IDS**, alerting on deauthentication floods, rogue APs, and other 802.11 anomalies in real time

## Related concepts
[[Wireless Network Sniffing]] [[Monitor Mode]] [[Rogue Access Points]] [[Evil Twin Attack]] [[Airodump-ng]]