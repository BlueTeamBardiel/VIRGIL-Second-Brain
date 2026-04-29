# network segmentation

## What it is
Think of a naval warship divided into watertight compartments — if one section floods, the others stay dry and the ship stays afloat. Network segmentation is the practice of dividing a network into isolated subnetworks (segments or zones) using VLANs, firewalls, or routers, so that traffic between zones is controlled and a compromise in one segment cannot freely spread to others.

## Why it matters
During the 2013 Target breach, attackers pivoted from a compromised HVAC vendor's credentials directly into the payment card network because flat network architecture connected everything. Proper segmentation — isolating point-of-sale systems into a separate zone with strict ACLs — would have stopped lateral movement before 40 million card numbers were stolen.

## Key facts
- **VLANs** provide Layer 2 segmentation; they limit broadcast domains but require a firewall or ACL to enforce true security between segments — a misconfigured trunk port can defeat the entire design.
- **DMZ (Demilitarized Zone)** is a classic three-legged firewall segmentation pattern placing public-facing servers between two firewall interfaces, isolating them from both the internet and the internal LAN.
- **Microsegmentation** extends the concept to individual workloads or VMs using software-defined networking (SDN), enforcing east-west traffic policies inside a data center.
- **Zero Trust** architectures depend on segmentation as a foundational control — no segment is implicitly trusted, even internal ones.
- On the **Security+/CySA+** exam, network segmentation is the primary control for **containing lateral movement** and is directly associated with the principle of **least privilege** applied to network access.

## Related concepts
[[zero trust architecture]] [[VLAN]] [[DMZ]] [[lateral movement]] [[microsegmentation]]