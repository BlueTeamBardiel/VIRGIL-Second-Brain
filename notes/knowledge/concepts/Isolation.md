# Isolation

## What it is
Like a hospital quarantine ward that keeps infected patients behind sealed doors so a single outbreak doesn't sweep the whole building, isolation in cybersecurity means placing a system, process, or network segment behind enforced boundaries so a compromise cannot spread. Technically, it is the enforcement of separation between computing environments so that a failure, infection, or breach in one domain cannot directly affect another.

## Why it matters
In 2017, the NotPetya ransomware propagated laterally through organizations at catastrophic speed precisely because internal network segments were flat — no isolation meant one infected endpoint could reach every other system. Organizations that had isolated their OT/ICS networks from corporate IT suffered dramatically less damage, demonstrating that isolation is often the difference between a contained incident and an enterprise-wide catastrophe.

## Key facts
- **Sandboxing** is a software-based isolation technique used by email gateways and browsers to execute untrusted code without touching the host OS
- **VLANs** provide Layer 2 network isolation but are not sufficient alone — inter-VLAN routing must be controlled by firewalls or ACLs to prevent VLAN hopping attacks
- **Air gaps** are the strongest form of isolation, physically separating a network from any external connection; still vulnerable to insider threats and removable media (see: Stuxnet)
- **Containers vs. VMs**: VMs provide stronger isolation via hypervisor hardware abstraction; containers share a kernel, making a kernel exploit a container escape risk
- On the **Security+ exam**, isolation appears in the context of incident response — isolating a compromised host is a key containment step before eradication

## Related concepts
[[Network Segmentation]] [[Sandboxing]] [[Zero Trust Architecture]] [[Defense in Depth]] [[Containment]]