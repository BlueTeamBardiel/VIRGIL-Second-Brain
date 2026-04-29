# microsegmentation-policies

## What it is
Like replacing one giant open-plan office with individual locked rooms where each employee only has keys to *their* room, microsegmentation divides a network into granular, isolated workload zones enforced by policy. Instead of flat east-west traffic flowing freely between systems, microsegmentation policies define explicit allow/deny rules at the workload or application level, often enforced by software-defined networking or host-based firewalls.

## Why it matters
During the 2020 SolarWinds breach, attackers moved laterally across flat enterprise networks for months after initial compromise because internal segments offered little resistance. With proper microsegmentation policies, a compromised build server would be walled off from domain controllers and email systems—limiting blast radius to a single zone rather than the entire enterprise. This is why CISA now explicitly recommends microsegmentation as a zero trust control.

## Key facts
- Microsegmentation enforces **least-privilege network access** at the workload level, distinct from traditional VLANs which only segment at Layer 2
- Policies are typically **identity-aware**: they attach to workloads or users, not just IP ranges, so they move with virtual machines across hosts
- Common enforcement points include **hypervisor-level firewalls** (VMware NSX), **host-based agents**, and **service meshes** (Istio for containers)
- Microsegmentation is a core pillar of **NIST SP 800-207 Zero Trust Architecture**, specifically addressing the "never trust, always verify" east-west traffic problem
- Misconfigured policies are the top failure mode—overly permissive rules created to "fix connectivity" gradually erode the segmentation model (policy sprawl)

## Related concepts
[[zero-trust-architecture]] [[east-west-traffic]] [[network-segmentation]] [[software-defined-networking]] [[least-privilege]]