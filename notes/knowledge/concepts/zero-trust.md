# zero-trust

## What it is
Think of a hospital where every staff member must badge in to *each room individually* — even the surgeon can't wander freely after entering the front door. Zero-trust is exactly that model applied to networks: **no user, device, or system is implicitly trusted after authentication, regardless of whether they're inside or outside the network perimeter.** Every access request is continuously verified against identity, device health, and least-privilege policies.

## Why it matters
In the 2020 SolarWinds breach, attackers with valid credentials moved laterally across dozens of government networks because perimeter-based trust treated internal traffic as safe. A zero-trust architecture would have enforced micro-segmentation and re-verification at each resource boundary, dramatically limiting lateral movement and containing the blast radius of the compromise.

## Key facts
- Core principle: **"never trust, always verify"** — authentication is continuous, not one-time at login
- Built on three pillars: **strong identity verification**, **device health validation**, and **least-privilege access control**
- Uses **micro-segmentation** to divide the network into isolated zones, preventing lateral movement even with valid credentials
- **NIST SP 800-207** is the authoritative framework document defining zero-trust architecture components
- Zero-trust is a *strategy/architecture*, not a single product — it combines MFA, IAM, EDR, and network controls working together
- Contrasts directly with the legacy **"castle-and-moat"** (perimeter-based) model, where everything inside the firewall was implicitly trusted

## Related concepts
[[least privilege]] [[micro-segmentation]] [[multi-factor authentication]] [[identity and access management]] [[lateral movement]]