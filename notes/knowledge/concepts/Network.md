# network

## What it is
Like a postal system where every building has an address and letters travel through sorting hubs, a network is a collection of interconnected devices that share data using standardized addressing and routing protocols. Precisely, it is two or more computing devices linked together via wired or wireless media to exchange resources, governed by the TCP/IP protocol suite.

## Why it matters
In the 2013 Target breach, attackers entered through a third-party HVAC vendor's network credentials, then pivoted laterally across Target's flat internal network to reach point-of-sale systems and steal 40 million credit card numbers. Proper network segmentation — isolating vendor access from payment systems — would have contained the breach and prevented lateral movement entirely.

## Key facts
- Networks are classified by scope: **LAN** (local), **WAN** (wide-area), **MAN** (metropolitan), and **PAN** (personal, e.g., Bluetooth)
- The **OSI model** has 7 layers; most attacks target Layer 3 (Network/IP spoofing), Layer 4 (TCP SYN floods), and Layer 7 (application exploits)
- **Network segmentation** using VLANs limits blast radius — compromising one segment doesn't automatically expose others
- **Subnetting** divides IP space into smaller ranges; knowing CIDR notation (e.g., /24 = 255 hosts) is essential for firewall rule writing
- The difference between **routers** (Layer 3, connect different networks) and **switches** (Layer 2, connect devices within a network) matters for placing security controls like ACLs vs. port security

## Related concepts
[[firewall]] [[network segmentation]] [[OSI model]] [[VLAN]] [[lateral movement]]