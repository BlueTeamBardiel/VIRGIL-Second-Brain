# T1040 Network Sniffing

## What it is
Like a wiretapper clamping onto a phone line to hear both sides of a conversation, network sniffing places a NIC into **promiscuous mode** to capture all packets traversing a network segment — not just those addressed to that host. Attackers use this passive technique to harvest credentials, session tokens, and sensitive data flowing across the wire or airwaves.

## Why it matters
During the 2011 DigiNotar breach post-mortem, investigators found evidence of credential sniffing on internal segments, allowing lateral movement that went undetected for weeks. Defenders combat this by enforcing TLS everywhere and deploying **network detection tools** that alert on NICs unexpectedly entering promiscuous mode — a reliable indicator of compromise on endpoints.

## Key facts
- Requires either **physical access** to the network segment, a compromised host on that segment, or proximity to unencrypted Wi-Fi
- Switched networks limit sniffing scope to a single collision domain — attackers bypass this using **ARP poisoning (T1557)** to redirect traffic through their machine
- Tools commonly associated: **Wireshark**, **tcpdump**, **Ettercap**, **Dsniff** — all legitimate tools that dual-use as attack instruments
- Detected on endpoints by monitoring for **PCAP library calls** or NIC driver flags; detected on networks via **IDS signatures** looking for ARP anomalies
- Classified as **Discovery** and **Credential Access** tactic in MITRE ATT&CK, because harvested traffic often yields plaintext passwords from legacy protocols (FTP, Telnet, HTTP Basic Auth)

## Related concepts
[[T1557 Adversary-in-the-Middle]] [[ARP Poisoning]] [[Promiscuous Mode Detection]] [[Credential Sniffing]] [[Packet Analysis]]