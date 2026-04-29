# Microsegmentation

## What it is
Think of a hospital where every door requires a different keycard — even doctors can't wander freely between the ICU, pharmacy, and records room without explicit authorization for each. Microsegmentation works the same way: it divides a network into fine-grained, policy-enforced zones at the workload or application level, so that even traffic *inside* the network perimeter requires authentication and authorization. Unlike traditional VLANs that create broad segments, microsegmentation enforces controls down to individual virtual machines, containers, or users.

## Why it matters
During the 2013 Target breach, attackers pivoted from a compromised HVAC vendor's credentials to reach payment card systems because flat network architecture allowed lateral movement with minimal friction. Microsegmentation would have contained the breach by requiring explicit policy permission before any connection could cross from the vendor management zone to the POS environment — dramatically reducing the attacker's blast radius.

## Key facts
- Microsegmentation is a core technical control within **Zero Trust Architecture (ZTA)**, enforcing the principle of least privilege at the network level
- It is typically implemented via **Software-Defined Networking (SDN)** or hypervisor-based controls (e.g., VMware NSX, Illumio), not traditional hardware firewalls
- Policies are often **identity-aware and workload-aware**, not just IP-address-based, making them more resilient to IP spoofing
- Reduces **lateral movement** by attackers who have already breached the perimeter — directly countering techniques like Pass-the-Hash and credential pivoting
- Microsegmentation is distinct from **network segmentation**: traditional segmentation uses VLANs and subnets; microsegmentation enforces controls at the individual asset level, often east-west rather than north-south

## Related concepts
[[Zero Trust Architecture]] [[Network Segmentation]] [[Lateral Movement]] [[Software-Defined Networking]] [[Least Privilege]]