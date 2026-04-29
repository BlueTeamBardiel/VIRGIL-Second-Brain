# Site Survey

## What it is
Like a detective walking through a building before installing a security camera system — checking blind spots, signal strength, and interference — a site survey is a systematic physical and wireless assessment of an environment before deploying or auditing a network. It maps existing access points, signal coverage, channel utilization, and potential RF interference to design or validate a secure, efficient wireless infrastructure.

## Why it matters
An attacker performing a **rogue access point** attack first conducts their own informal site survey — identifying coverage gaps, weak signal zones, and SSID names — to position an evil twin AP where legitimate users are most likely to connect. Defenders use formal site surveys to detect these rogue APs and ensure authorized access points provide full coverage, eliminating the dead zones attackers exploit.

## Key facts
- A **passive survey** listens for existing RF signals without transmitting; an **active survey** connects to APs and measures throughput — passive is preferred for stealth auditing.
- Site surveys identify **channel overlap** (e.g., 2.4 GHz has only 3 non-overlapping channels: 1, 6, 11), which can cause interference and performance degradation.
- **Heat maps** are the primary deliverable — visual overlays showing signal strength across a floor plan, used to justify AP placement decisions.
- Tools like **Ekahau**, **AirMagnet**, and **WiFi Analyzer** are industry-standard site survey platforms; Wireshark can supplement with packet-level wireless analysis.
- Site surveys are a required step in **WLAN security audits** and are referenced in frameworks like NIST SP 800-153 (Guidelines for Securing WLANs).

## Related concepts
[[Rogue Access Point]] [[Evil Twin Attack]] [[Wireless Security Protocols]] [[RF Interference]] [[Network Mapping]]