# Network Hardening

## What it is
Think of a medieval castle: you don't just build walls — you fill the moat, raise the drawbridge, post guards at every gate, and eliminate secret passages enemies could exploit. Network hardening is the systematic process of reducing a network's attack surface by disabling unnecessary services, enforcing least privilege, segmenting traffic, and applying security configurations across all devices and infrastructure.

## Why it matters
In the 2013 Target breach, attackers pivoted from a compromised HVAC vendor's credentials through a flat, poorly segmented network straight to point-of-sale systems — stealing 40 million credit card numbers. Proper network hardening, specifically network segmentation and strict access control lists (ACLs) between vendor-access zones and payment systems, would have contained the breach before it reached cardholder data.

## Key facts
- **Disable unused ports and protocols**: Close unnecessary TCP/UDP ports and disable legacy protocols like Telnet, FTP, and SNMPv1 that transmit credentials in plaintext.
- **Network segmentation**: Use VLANs and firewalls to isolate sensitive systems (e.g., OT/ICS networks, payment systems) from general corporate traffic.
- **Implicit deny**: Default firewall rule sets should deny all traffic not explicitly permitted — not the reverse.
- **Change default credentials**: Routers, switches, and APs ship with known default usernames/passwords that attackers enumerate first; changing them is non-negotiable.
- **802.1X port-based authentication**: Prevents unauthorized devices from connecting to the network by requiring authentication before granting LAN access.

## Related concepts
[[Network Segmentation]] [[Firewall ACLs]] [[Zero Trust Architecture]] [[VLAN]] [[Principle of Least Privilege]]