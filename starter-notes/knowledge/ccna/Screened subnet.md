# Screened subnet

## What it is
Think of it like an airport's international terminal — a buffer zone where travelers (traffic) are checked before they can enter the country (internal network) or go back out. A screened subnet (formerly called a DMZ) is a network segment isolated between two firewalls, placing publicly accessible servers in a middle zone that is neither fully trusted nor fully exposed to the internet. Internal resources remain protected even if a host in the screened subnet is compromised.

## Why it matters
A company hosts a public-facing web server. Without a screened subnet, a successful SQL injection attack that achieves RCE could pivot directly into the internal corporate network. With a screened subnet, the attacker is trapped between two firewalls — the outer firewall restricts inbound internet traffic, and the inner firewall blocks the compromised web server from initiating connections to internal systems.

## Key facts
- Uses **two firewalls**: an outer firewall faces the internet; an inner firewall faces the internal network — the zone between them is the screened subnet.
- Hosts placed here typically include web servers, mail servers, DNS servers, and reverse proxies — services that *must* accept external connections.
- The inner firewall enforces **stricter rules** than the outer, treating the screened subnet itself as untrusted.
- A single firewall with three interfaces (one per zone) can *simulate* a screened subnet but is considered less secure because one device failure collapses all isolation.
- Security+ maps this to the **network segmentation** control family; it is a foundational architecture for defense-in-depth.

## Related concepts
[[DMZ]] [[Firewall]] [[Defense in Depth]] [[Network segmentation]] [[Bastion host]]
