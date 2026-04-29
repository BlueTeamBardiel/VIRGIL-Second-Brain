# OpenFlow

## What it is
Think of OpenFlow as a remote control that separates the TV's "what to show" decisions from the physical screen itself — the controller decides, the hardware just displays. OpenFlow is a communications protocol that enables a Software-Defined Networking (SDN) controller to programmatically manage the forwarding rules on network switches and routers by decoupling the control plane from the data plane.

## Why it matters
In an SDN environment, if an attacker compromises the centralized OpenFlow controller, they gain the ability to reprogram every switch in the network simultaneously — redirecting traffic, creating backdoor paths, or silently mirroring flows to an exfiltration endpoint. Conversely, defenders leverage this same centralized control to instantly quarantine a compromised host by pushing a "drop all traffic" rule to every switch at once, far faster than manual ACL updates.

## Key facts
- OpenFlow communicates over TCP port **6633** (legacy) or **6653** (IANA-assigned standard); unencrypted channels are a known misconfiguration risk
- The protocol defines **flow tables** on switches — each entry has a match field, priority, counters, and an action (forward, drop, modify)
- **Controller compromise = network-wide compromise**: the single controller is a high-value target representing a critical single point of failure
- TLS is *optional* in the OpenFlow spec but strongly recommended; many real-world deployments skip it, leaving control-plane traffic exposed to interception
- OpenFlow is the foundational protocol behind major SDN platforms including **OpenDaylight** and early Google B4 WAN deployments

## Related concepts
[[Software-Defined Networking]] [[Network Segmentation]] [[Man-in-the-Middle Attack]] [[Control Plane Security]]