# Packet Injection

## What it is
Like a forger slipping counterfeit letters into a postal system mid-route — making them look like they came from a trusted sender — packet injection is the act of crafting and inserting fabricated or modified network packets into an active communication stream without authorization. The attacker's packets carry spoofed headers to impersonate legitimate endpoints, allowing them to manipulate, hijack, or disrupt ongoing sessions at the network or transport layer.

## Why it matters
In a **TCP session hijacking** attack, an adversary uses packet injection to insert commands into an already-authenticated SSH or Telnet session — effectively issuing commands as the legitimate user without ever knowing their password. This was the mechanism behind early BGP hijacking attacks, where injected route announcements redirected internet traffic through attacker-controlled infrastructure, enabling mass surveillance or service disruption.

## Key facts
- **Raw sockets** are the primary OS-level mechanism attackers use; tools like Scapy, hping3, and Aircrack-ng's `aireplay-ng` enable injection in practice
- **Sequence number prediction** is the prerequisite for TCP injection — an attacker must guess or observe the correct sequence number to insert a packet the receiver accepts
- **ARP injection** (a subset) poisons local caches to redirect Layer 2 traffic, enabling Man-in-the-Middle positioning on LAN segments
- **Wireless packet injection** (802.11) allows deauthentication floods and WEP/WPA handshake capture — a core step in Wi-Fi cracking workflows
- **Defenses** include TLS/IPSec (encrypted + authenticated sessions make injected plaintext packets useless), strict firewall ingress/egress filtering, and network intrusion detection signatures for malformed or out-of-state packets

## Related concepts
[[TCP Session Hijacking]] [[ARP Spoofing]] [[Man-in-the-Middle Attack]] [[Replay Attack]] [[Network Sniffing]]