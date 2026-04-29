# defense in depth

## What it is
Like a medieval castle with a moat, drawbridge, outer walls, inner walls, and a keep — each layer forces an attacker to defeat an entirely separate obstacle. Defense in depth is a security strategy that deploys multiple, overlapping layers of controls so that the failure of any single control does not result in a complete system compromise.

## Why it matters
In the 2013 Target breach, attackers compromised an HVAC vendor's credentials to reach the network — but a single perimeter firewall was the only meaningful barrier between that vendor access and payment card systems. Had network segmentation, internal monitoring, and endpoint controls all been layered, lateral movement to the POS systems would have required breaching several additional obstacles, dramatically increasing detection opportunity.

## Key facts
- Defense in depth applies across three control categories: **administrative** (policies, training), **physical** (locks, badges), and **technical** (firewalls, encryption, MFA)
- The core assumption is **"assume breach"** — no single control is treated as infallible
- Redundant controls are intentional; a firewall *and* an IDS *and* network segmentation all addressing the same threat vector is by design, not waste
- Maps directly to the **NIST Cybersecurity Framework** and is a foundational principle in DoD security architecture (originally derived from NSA guidance)
- On Security+ exams, defense in depth is often contrasted with **security through obscurity** — the former is considered robust; the latter is not a valid standalone strategy

## Related concepts
[[network segmentation]] [[zero trust architecture]] [[security controls]] [[layered security]] [[least privilege]]