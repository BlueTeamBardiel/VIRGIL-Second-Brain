# Segmentation

## What it is
Think of a naval warship with watertight compartments — if one section floods, the bulkheads prevent the whole ship from sinking. Network segmentation works the same way: dividing a network into isolated zones (using VLANs, firewalls, or subnets) so that a breach in one segment cannot freely spread to others.

## Why it matters
In the 2013 Target breach, attackers compromised an HVAC vendor's credentials and moved laterally from the vendor access zone straight into the point-of-sale network — because no meaningful segmentation existed between them. Proper segmentation with firewall rules between those zones would have contained the breach before 40 million card numbers were stolen.

## Key facts
- **VLANs** provide logical segmentation at Layer 2, but require inter-VLAN routing controls (ACLs or firewalls) to enforce actual security boundaries — VLANs alone are not a security control.
- **Zero Trust** architectures take segmentation to the extreme with **microsegmentation**, isolating individual workloads rather than just network zones.
- **DMZ (Demilitarized Zone)** is a classic segmentation pattern placing public-facing servers between two firewalls, separating them from the internal network.
- **Air gapping** is the most extreme form of segmentation — physically isolating a network with no logical connection to outside systems (used in ICS/SCADA and classified environments).
- On Security+/CySA+ exams, segmentation is listed as a primary control for **lateral movement prevention** and **blast radius reduction** during incidents.

## Related concepts
[[Zero Trust]] [[VLAN]] [[DMZ]] [[Microsegmentation]] [[Lateral Movement]]