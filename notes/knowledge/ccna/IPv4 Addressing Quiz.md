# IPv4 Addressing Quiz

## What it is
Like a postal system where every house needs a unique street address to send and receive mail, IPv4 gives every device on a network a 32-bit numerical label so packets know exactly where to go and come from. IPv4 addresses are written in dotted-decimal notation (e.g., 192.168.1.1), divided into four octets ranging from 0–255, and split into network and host portions defined by a subnet mask.

## Why it matters
During a network reconnaissance attack, an adversary runs a tool like `nmap` against a target subnet (e.g., 10.0.0.0/24) to discover live hosts by sweeping all 254 usable addresses. Understanding IPv4 structure and CIDR notation lets defenders quickly identify which IP ranges belong to internal systems, spot rogue devices, and configure firewall ACLs to block unauthorized traffic before lateral movement occurs.

## Key facts
- **Classes (historical):** Class A (1–126), Class B (128–191), Class C (192–223) — still tested on Security+
- **Private ranges (RFC 1918):** 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 — these should never appear as source IPs on the public internet (if they do, suspect spoofing)
- **CIDR notation:** /24 = 255.255.255.0 = 256 addresses, 254 usable (subtract network and broadcast)
- **Special addresses:** 127.0.0.1 = loopback; 169.254.x.x = APIPA (link-local, assigned when DHCP fails — a red flag on a prod network)
- **Broadcast:** The last address in a subnet (e.g., 192.168.1.255 in a /24) — never assigned to a host; directed broadcast attacks exploit this

## Related concepts
[[Subnetting and CIDR]] [[NAT and PAT]] [[Network Reconnaissance]] [[IP Spoofing]] [[DHCP Starvation Attack]]