# WIPS

## What it is
Like a bouncer who not only checks IDs at the door but also scans the entire venue for anyone whispering suspicious code words, a Wireless Intrusion Prevention System actively monitors RF airspace and takes action to stop threats — not just log them. A WIPS continuously analyzes wireless traffic across all channels, detects unauthorized or malicious activity, and can automatically block rogue access points or de-authenticate suspicious clients in real time.

## Why it matters
During a rogue AP attack, an adversary plugs an unauthorized access point into a corporate network jack and broadcasts an SSID that mimics the legitimate network. A WIPS detects the MAC address and SSID spoofing, correlates the rogue device's signal to a physical location via triangulation, and sends de-authentication frames to sever clients before data exfiltration begins — something a passive WIDS alone cannot do.

## Key facts
- **WIPS vs. WIDS**: A WIDS (Detection System) only alerts; a WIPS (Prevention System) actively responds — the distinction mirrors IDS vs. IPS on wired networks
- **Rogue AP containment** is a primary WIPS function; it uses targeted de-authentication (802.11 management frames) to disconnect clients from unauthorized APs
- **Evil twin detection**: WIPS identifies duplicate SSIDs with mismatched BSSIDs (MAC addresses), a hallmark of evil twin and honeypot attacks
- **Deployment modes**: Dedicated sensor overlay (separate hardware), integrated AP mode, or hybrid — dedicated sensors offer the most comprehensive coverage without impacting throughput
- **False positive risk**: Neighboring legitimate APs can trigger rogue alerts; proper policy tuning and RF fingerprinting reduce noise

## Related concepts
[[Rogue Access Point]] [[Evil Twin Attack]] [[802.11 Security]] [[Network Access Control]] [[Wireless Site Survey]]