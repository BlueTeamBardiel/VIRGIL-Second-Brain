# Network Interface Controller

## What it is
Think of the NIC as your computer's postal worker — it knows your exact address (MAC address), handles all the mail coming in and going out, and decides which envelopes actually belong to you. Technically, a Network Interface Controller is a hardware component that connects a device to a network, operating at Layer 2 (Data Link) of the OSI model, translating digital data into electrical, optical, or radio signals for transmission.

## Why it matters
In a promiscuous mode attack, an adversary configures their NIC to accept *all* network frames — not just those addressed to their MAC — effectively turning their machine into a packet sniffer. Tools like Wireshark exploit this NIC capability to capture credentials traveling in cleartext across a network, making unencrypted protocols like Telnet and HTTP dangerously exposed on shared segments.

## Key facts
- Every NIC has a **burned-in MAC address** (48-bit, e.g., `00:1A:2B:3C:4D:5E`), though MAC spoofing allows software-level override using tools like `macchanger`
- NICs operating in **promiscuous mode** capture all frames on a network segment, regardless of destination MAC — the basis of passive sniffing attacks
- **Promiscuous mode detection** is possible: defenders can send ARP requests to non-broadcast addresses and watch which hosts respond (only promiscuous NICs respond)
- NIC **offloading features** (TCP Segmentation Offload, checksum offload) can interfere with IDS/IPS tools by moving packet processing off the CPU, potentially hiding malformed packets from inspection
- Modern NICs support **VLAN tagging (802.1Q)**, and misconfigured trunk ports can allow VLAN hopping attacks

## Related concepts
[[MAC Address Spoofing]] [[Promiscuous Mode]] [[Packet Sniffing]] [[ARP Poisoning]] [[VLAN Hopping]]