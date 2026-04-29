# Virtual networks

## What it is
Like building separate lanes on the same highway using painted lines and traffic rules — cars share the same asphalt but can't cross into other lanes. A virtual network is a logical network constructed on top of shared physical infrastructure, using software to enforce separation between traffic flows. Technologies like VLANs, VPNs, and SDN achieve this by tagging, encrypting, or programmatically routing packets so distinct networks coexist on the same hardware.

## Why it matters
In 2013, attackers breached Target through an HVAC vendor with network access — a failure of virtual network segmentation. Proper VLAN segmentation would have isolated the point-of-sale network from vendor-accessible systems, containing the breach before 40 million card numbers were stolen. This is exactly why microsegmentation and network isolation are now foundational defense strategies in modern enterprise architecture.

## Key facts
- **VLANs** operate at Layer 2 and use 802.1Q tagging to segment broadcast domains; a misconfigured trunk port can allow **VLAN hopping** attacks
- **VLAN hopping** via double-tagging or switch spoofing allows an attacker to send frames to a VLAN they shouldn't reach — mitigated by disabling DTP and setting native VLANs to unused IDs
- **SDN (Software-Defined Networking)** separates the control plane from the data plane, centralizing routing decisions — powerful but creates a high-value single point of failure
- **Network segmentation** limits lateral movement; PCI-DSS explicitly requires isolating cardholder data environments using segmentation controls
- **East-west traffic** (server-to-server within a datacenter) is where virtual network controls matter most, as traditional firewalls focused on north-south perimeter traffic miss internal threats

## Related concepts
[[VLANs]] [[Network Segmentation]] [[Software-Defined Networking]] [[Microsegmentation]] [[Zero Trust Architecture]]