# VLANs

## What it is
Imagine a single office building where the finance team, HR department, and engineering floor each have their own locked hallway — physically sharing the same building but logically separated so you can't wander between floors without a key. A VLAN (Virtual Local Area Network) works exactly like that: it partitions a single physical network switch into multiple isolated logical networks, controlling which devices can communicate with which others at Layer 2 without requiring separate physical hardware.

## Why it matters
In 2021, researchers demonstrated how a misconfigured hospital network with flat (un-segmented) topology allowed a compromised IoT medical device to reach patient records servers directly. Had VLANs been implemented — separating medical devices, clinical workstations, and administrative systems — lateral movement would have been blocked at the switch level. VLANs are a foundational defense-in-depth control that contains breaches before they become enterprise-wide disasters.

## Key facts
- VLANs operate at **Layer 2 (Data Link)** and are defined by IEEE **802.1Q**, which tags Ethernet frames with a 12-bit VLAN ID (supporting up to 4,094 VLANs)
- **VLAN hopping** is the primary attack: an adversary either uses **switch spoofing** (pretending to be a trunk port) or **double tagging** (nesting 802.1Q tags) to jump from one VLAN to another
- To route traffic *between* VLANs, a Layer 3 device (router or Layer 3 switch) is required — VLANs alone do not provide inter-VLAN communication
- The **native VLAN** (default VLAN 1 on Cisco) should always be changed, as double-tagging attacks exploit the untagged native VLAN behavior
- VLANs support **network segmentation** compliance requirements found in PCI-DSS (isolating cardholder data environments) and HIPAA

## Related concepts
[[Network Segmentation]] [[802.1Q Trunking]] [[Lateral Movement]] [[Defense in Depth]] [[Switch Security]]