# ARP

## What it is  
Imagine a town where everyone sends mail using only street names; the postal service must first translate each name to a specific mailbox number. ARP (Address Resolution Protocol) is that postal service for IP networks: it maps a 32‑bit IPv4 address to a device’s 48‑bit MAC address so that data frames can reach the correct hardware on a local segment.  

## Why it matters  
In a corporate LAN, an attacker can send forged ARP replies (ARP spoofing) to associate their MAC with the gateway’s IP, redirecting traffic to themselves for sniffing or man‑in‑the‑middle attacks. Defenders counter this by using static ARP entries, dynamic ARP inspection, or VLAN isolation to prevent malicious address mapping.  

## Key facts  
- ARP broadcasts: a host sends an ARP request to all nodes; only the matching IP replies.  
- Cache lifespan: entries are stored for ~1 hour, but can be refreshed or purged by the OS.  
- Gratuitous ARP: unsolicited replies used to announce a new IP/MAC mapping or detect duplicates.  
- Statelessness: ARP operates without a transport layer; it works directly on Ethernet frames.  
- Vulnerability vector: ARP cache poisoning can subvert routing tables, enabling traffic hijack or denial of service.  

## Related concepts  
[[ARP spoofing]] [[Dynamic ARP Inspection]] [[MAC address filtering]]
