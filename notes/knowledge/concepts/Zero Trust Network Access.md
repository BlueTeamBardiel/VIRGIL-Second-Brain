# Zero Trust Network Access

## What it is
Think of a medieval castle where even knights must show credentials at every inner door — being inside the walls doesn't grant access to the treasury. Zero Trust Network Access (ZTNA) is a security model that eliminates implicit trust based on network location, requiring continuous verification of identity, device health, and context before granting access to any resource, regardless of whether the request originates inside or outside the perimeter.

## Why it matters
In the 2020 SolarWinds breach, attackers moved laterally across networks for months after initial compromise because traditional perimeter models trusted internal traffic. A ZTNA architecture would have required the compromised service accounts to continuously re-authenticate and prove device posture at each resource boundary, dramatically limiting lateral movement and containing the blast radius of the intrusion.

## Key facts
- ZTNA operates on the principle of **"never trust, always verify"** — identity becomes the new perimeter, not the IP address
- Access is granted on a **least-privilege, per-session basis**, meaning credentials valid for one application don't automatically permit access to another
- ZTNA evaluates **contextual signals** including device health, geolocation, time-of-day, and user behavior before each access decision
- It replaces or supplements legacy VPNs, which grant broad network access once authenticated — ZTNA grants **application-level access only**
- ZTNA is a core pillar of **NIST SP 800-207**, the authoritative Zero Trust Architecture framework referenced on CompTIA exams

## Related concepts
[[Microsegmentation]] [[Identity and Access Management]] [[Software-Defined Perimeter]] [[Least Privilege]] [[Multi-Factor Authentication]]