# Bastion Host

## What it is
Like a castle drawbridge tower where every visitor must identify themselves before crossing the moat, a bastion host is a single, hardened server deliberately exposed to an untrusted network (typically the internet) that serves as the sole entry point into a protected internal network. It is stripped of all unnecessary services, tightly configured, and extensively logged — designed to absorb scrutiny and survive hostile environments.

## Why it matters
In a classic attack scenario, an adversary probing a corporate network discovers the bastion host is the only reachable system. Rather than finding an easy path inward, they face a hardened SSH gateway with key-based authentication only, fail2ban blocking repeated attempts, and no other services running — turning a potential breach into a dead end. Defenders use this chokepoint to funnel all administrative access through one audited, monitored system rather than leaving dozens of internal servers directly reachable.

## Key facts
- A bastion host is intentionally placed in a **DMZ** or at the network perimeter, accepting connections from untrusted zones
- Hardening steps include: removing all non-essential packages, disabling password authentication, enabling MFA, and running minimal services (often SSH only)
- All session activity should be **logged and forwarded** to a SIEM — the bastion host itself shouldn't be the sole record of access
- Commonly implemented in cloud environments (AWS, Azure) as a **jump server** or **jump box** — the only way to reach private subnet resources
- Compromise of a bastion host is a **critical incident**: it grants an attacker a trusted position inside the perimeter, making it a high-value target

## Related concepts
[[DMZ]] [[Jump Server]] [[Network Segmentation]] [[Hardening]] [[Least Privilege]]