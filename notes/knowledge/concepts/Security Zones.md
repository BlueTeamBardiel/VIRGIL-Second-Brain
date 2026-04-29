# Security Zones

## What it is
Think of a hospital: the public lobby, nurse stations, ICU, and operating theater each have different access rules — you don't walk straight from the parking lot into surgery. Security zones apply that same logic to networks, segmenting infrastructure into areas with distinct trust levels and enforced boundaries between them.

## Why it matters
In the 2013 Target breach, attackers pivoted from a compromised HVAC vendor's credentials into the payment card network — two systems that should have been in completely separate zones with no direct communication path. Proper zone segmentation with enforced firewall policies between the vendor-access zone and the POS network would have contained the breach before card data was ever reached.

## Key facts
- The classic three-zone model includes: **Trusted** (internal LAN), **Untrusted** (internet), and **DMZ** (demilitarized zone hosting public-facing services like web and email servers)
- Traffic flowing **from a lower-trust zone to a higher-trust zone** requires explicit, restrictive policy approval — default posture is deny
- A **DMZ** prevents direct internet-to-intranet paths: external users reach the web server in the DMZ, never the internal database directly
- **Extranet zones** extend controlled access to partners/vendors — functionally a zone between DMZ and full internal trust
- Zone enforcement is typically implemented via **stateful firewalls, ACLs, and VLANs** working together; VLANs alone without firewall enforcement are insufficient for security boundaries

## Related concepts
[[DMZ (Demilitarized Zone)]] [[Network Segmentation]] [[Firewall Policy]] [[VLAN]] [[Defense in Depth]]