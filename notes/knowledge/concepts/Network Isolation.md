# Network Isolation

## What it is
Like a hospital's infection ward with sealed doors and separate ventilation, network isolation physically or logically separates systems so that compromise of one segment cannot spread to others. It is the practice of dividing a network into distinct zones — using VLANs, air gaps, or firewalls — to contain traffic, limit lateral movement, and enforce least-privilege communication between hosts.

## Why it matters
During the 2017 NotPetya attack, the malware spread laterally across flat corporate networks with devastating speed because no meaningful segmentation existed between workstations and critical servers. Organizations that had isolated their OT/ICS networks from corporate IT suffered dramatically less damage, demonstrating that isolation is often the difference between a contained incident and a catastrophic outage.

## Key facts
- **Air gap** is the strongest form of isolation — a system with no physical or wireless connection to untrusted networks (common in classified and ICS environments)
- **VLANs** provide logical isolation at Layer 2 but are vulnerable to VLAN hopping attacks if switch ports are misconfigured
- **DMZ (Demilitarized Zone)** is a classic isolation pattern placing public-facing servers between two firewalls, limiting exposure of the internal network
- **Microsegmentation** (used in zero-trust architectures) isolates individual workloads rather than just network zones, enforced via software-defined networking
- Network isolation directly supports **containment** in the NIST incident response framework by preventing lateral movement during an active breach

## Related concepts
[[Network Segmentation]] [[Zero Trust Architecture]] [[DMZ]] [[VLAN Hopping]] [[Lateral Movement]]