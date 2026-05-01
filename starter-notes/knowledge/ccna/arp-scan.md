# arp-scan

## What it is
Like a postal worker walking down every house on a street and shouting "Who lives here?" at each door, arp-scan broadcasts ARP requests to every IP on a subnet and listens for MAC address replies. It is a Layer 2 network discovery tool that identifies live hosts on a local network segment by leveraging the Address Resolution Protocol, bypassing firewalls that block ICMP ping sweeps.

## Why it matters
During a penetration test or incident response, arp-scan reveals every active device on a subnet — including hosts configured to silently drop ICMP traffic. A defender investigating a suspected rogue access point can run `arp-scan --localnet` and cross-reference discovered MAC addresses against an authorized device inventory, immediately flagging unknown hardware vendors through the OUI prefix in the MAC address.

## Key facts
- Operates at **Layer 2 (Data Link)**, making it invisible to host-based firewalls that filter Layer 3 and above — a device cannot ignore an ARP request without losing network functionality
- Syntax: `arp-scan --localnet` scans the entire local subnet; `arp-scan 192.168.1.0/24` targets a specific range
- Identifies **vendor/manufacturer** of NICs via the first 3 octets of the MAC address (OUI lookup), useful for fingerprinting device types
- Requires **root/administrator privileges** because it crafts raw Layer 2 frames directly
- Duplicate MAC address responses to the same IP can indicate **ARP spoofing / Man-in-the-Middle attacks** in progress
- Cannot cross **router boundaries** — ARP is non-routable, so arp-scan only discovers hosts within the same broadcast domain

## Related concepts
[[ARP Spoofing]] [[Network Reconnaissance]] [[MAC Address]] [[Passive vs Active Scanning]] [[Nmap]]
