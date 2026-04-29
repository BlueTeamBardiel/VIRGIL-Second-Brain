# Firewall Architecture

## What it is
Like a medieval castle with a drawbridge, outer walls, and an inner keep — each layer forcing an attacker to breach multiple independent barriers — firewall architecture is the deliberate, layered placement of firewalls and network zones to control traffic flow between segments of different trust levels. It defines *where* filtering happens, *what* gets filtered, and *how many independent checkpoints* stand between an attacker and your crown jewels.

## Why it matters
In the 2013 Target breach, attackers pivoted from a compromised HVAC vendor's network directly into the cardholder data environment because no meaningful segmentation existed between third-party access zones and the POS network. A properly architected firewall deployment — with a DMZ isolating vendor traffic from internal systems — would have contained the breach before 40 million card numbers were stolen.

## Key facts
- **Three-legged / screened subnet DMZ**: Places public-facing servers (web, mail) in a DMZ between an *external* firewall (internet-facing) and an *internal* firewall (protecting LAN), requiring attackers to compromise two separate devices to reach internal systems.
- **Stateful vs. stateless**: Stateful firewalls track TCP session state (connection tables); stateless packet filters evaluate each packet in isolation — stateless is faster but blind to session-layer attacks.
- **East-West vs. North-South traffic**: Traditional perimeter firewalls only inspect North-South (in/out) traffic; modern architectures add internal segmentation firewalls (ISFWs) to stop lateral movement (East-West).
- **Implicit deny**: All well-designed firewall rule sets end with a "deny all" catch-all rule — anything not explicitly permitted is blocked.
- **Bastion host**: A hardened, single-purpose host exposed to untrusted networks, placed in the DMZ, minimizing attack surface by running only essential services.

## Related concepts
[[Network Segmentation]] [[DMZ (Demilitarized Zone)]] [[Stateful Inspection]] [[Zero Trust Architecture]] [[Defense in Depth]]