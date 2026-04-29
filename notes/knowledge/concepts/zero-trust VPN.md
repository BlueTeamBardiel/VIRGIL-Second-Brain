# zero-trust VPN

## What it is
Think of a traditional VPN like a hotel key card — once you're inside the building, you can wander every hallway freely. A zero-trust VPN is more like a museum with individual locked rooms: your key only opens the specific exhibit you have a ticket for, re-verified at every door. Technically, it combines encrypted tunnel technology with continuous identity verification and least-privilege access controls, granting per-session, per-resource access rather than broad network admission.

## Why it matters
In the 2021 Pulse Secure VPN breach, attackers who compromised credentials gained lateral movement across entire corporate networks because traditional VPN architecture placed trusted users "inside the perimeter." A zero-trust VPN model would have contained the blast radius — even with stolen credentials, the attacker could only reach resources explicitly authorized for that identity, dramatically limiting exfiltration paths.

## Key facts
- Zero-trust VPN enforces **identity-aware proxying**: access decisions are made per request, not per session, using attributes like device posture, user role, time, and location.
- Implements **microsegmentation** at the application layer — users connect to specific apps, not network segments.
- Relies on a **Policy Enforcement Point (PEP)** and **Policy Decision Point (PDP)** architecture (per NIST SP 800-207) to evaluate each access request dynamically.
- Device health checks (MDM compliance, patch level, certificate validation) are prerequisites — a clean credential on a compromised device is still denied.
- Contrasted with legacy VPN: traditional VPN operates at **Layer 3** (network access); zero-trust VPN operates at **Layer 7** (application access), reducing attack surface significantly.

## Related concepts
[[Zero Trust Architecture]] [[microsegmentation]] [[Software-Defined Perimeter]] [[identity and access management]] [[NIST SP 800-207]]