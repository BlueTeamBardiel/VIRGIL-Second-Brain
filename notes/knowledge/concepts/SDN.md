# SDN

## What it is
Think of a traditional network like a building where every light switch is hardwired directly to its own breaker — to rewire anything, you touch physical infrastructure. SDN is like replacing all that with a smart building controller that programs every switch from a central app. Formally, Software-Defined Networking separates the **control plane** (routing decisions) from the **data plane** (packet forwarding), allowing centralized, programmable network management via software controllers like OpenFlow.

## Why it matters
In a cloud environment, an attacker who compromises the SDN controller gains the ability to reroute, mirror, or drop traffic across the *entire* network from a single point — a catastrophic blast radius impossible in traditional segmented hardware networks. Defenders leverage this same centralization to instantly quarantine compromised hosts by pushing new flow rules network-wide in milliseconds, far faster than manually reconfiguring physical switches.

## Key facts
- The **SDN controller** is the single pane of glass and the single point of failure — its compromise equals full network visibility and manipulation
- **OpenFlow** is the dominant southbound API protocol used between the controller and network devices
- SDN enables **microsegmentation**, dynamically isolating workloads to limit lateral movement during a breach
- Traditional networks embed intelligence in each device (distributed); SDN centralizes intelligence, making **north-south API communication** between controller and applications a critical attack surface
- SDN is foundational to **cloud and NFV (Network Functions Virtualization)** environments, appearing heavily in AWS VPC, Azure Virtual Networks, and software-defined WANs (SD-WAN)

## Related concepts
[[Microsegmentation]] [[Zero Trust Architecture]] [[Network Flow Analysis]]