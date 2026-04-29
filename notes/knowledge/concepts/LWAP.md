# LWAP

## What it is
Think of a Lightweight Access Point like a puppet with no brain — it does exactly what the puppetmaster (a wireless controller) tells it to do, handling none of the heavy processing itself. Precisely: a Lightweight Access Point (LWAP) is a wireless access point that offloads most management, security, and routing functions to a centralized Wireless LAN Controller (WLC), communicating via the CAPWAP tunneling protocol. Unlike autonomous APs, LWAPs cannot function independently — they are deliberately "dumb" endpoints.

## Why it matters
In enterprise environments, this centralized architecture is both a strength and a single point of failure. If an attacker compromises the WLC, they gain control over every LWAP tunneling traffic through it — potentially enabling rogue AP injection, traffic interception, or mass de-authentication across the entire wireless network. Defenders leverage this same centralization to push uniform security policies and instantly detect rogue APs from a single console.

## Key facts
- LWAPs use **CAPWAP** (Control and Provisioning of Wireless Access Points) to communicate with the WLC — UDP port **5246** (control) and **5247** (data)
- All 802.11 frame processing, encryption enforcement, and SSID management happen at the **WLC**, not the AP itself
- LWAPs are the dominant model in enterprise Wi-Fi deployments (Cisco, Aruba, Ruckus all use this architecture)
- A compromised or spoofed WLC can redirect LWAP tunnels, enabling **man-in-the-middle attacks** at scale
- LWAPs automatically download their configuration from the WLC on boot — meaning zero manual per-AP configuration but total dependency on WLC availability

## Related concepts
[[CAPWAP]] [[Wireless LAN Controller]] [[Rogue Access Point]] [[Evil Twin Attack]] [[Network Segmentation]]