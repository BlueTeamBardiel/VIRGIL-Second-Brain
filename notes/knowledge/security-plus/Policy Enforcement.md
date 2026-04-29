# Policy Enforcement

## What it is
Think of a bouncer at a club with a strict guest list — it doesn't matter how well-dressed you are, if your name isn't on the list with the right attributes, you don't get in. Policy enforcement is the technical mechanism that translates written security rules into automated, real-time controls that allow, deny, or restrict actions based on predefined conditions.

## Why it matters
In 2020, the SolarWinds breach succeeded partly because overprivileged service accounts operated without enforced least-privilege policies — they *had* policies on paper, but no technical enforcement prevented lateral movement. Had Group Policy Objects (GPOs) or PAM tools enforced those access restrictions automatically, the blast radius would have been significantly contained.

## Key facts
- **GPOs (Group Policy Objects)** in Active Directory are the primary Windows mechanism for enforcing security baselines across endpoints — password complexity, account lockout, and software restrictions all flow through GPOs
- **NAC (Network Access Control)** enforces policy at the network perimeter — a device failing a health check (missing patches, no AV) gets quarantined before it can touch production resources
- **XACML (eXtensible Access Control Markup Language)** is the standards-based language for defining and exchanging attribute-based access control policies in enterprise environments
- **Policy enforcement points (PEP)** sit between users and resources; they consult a **Policy Decision Point (PDP)** to get an allow/deny verdict — this split architecture is core to Zero Trust design
- Misconfigured or unenforced policies are classified as a **security control failure**, not a threat — important distinction for CySA+ incident categorization

## Related concepts
[[Access Control]] [[Group Policy Objects]] [[Network Access Control]] [[Zero Trust Architecture]] [[Least Privilege]]