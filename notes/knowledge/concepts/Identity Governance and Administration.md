# Identity Governance and Administration

## What it is
Think of IGA as the HR department for digital identities — it handles hiring (provisioning), transfers (access changes), and firing (deprovisioning) of user accounts across every system in an organization. Identity Governance and Administration (IGA) is a framework combining identity lifecycle management with policy enforcement and access certification, ensuring users have exactly the rights they need — no more, no less.

## Why it matters
In the 2020 SolarWinds breach, attackers leveraged over-privileged service accounts that had accumulated excessive permissions over years of "access creep" — no one had ever reviewed or revoked them. A mature IGA program with regular access certification campaigns (formal reviews where managers confirm who still needs what access) would have flagged those dormant, bloated accounts before attackers could weaponize them.

## Key facts
- **Joiner-Mover-Leaver (JML) process** is the core IGA workflow: provisioning access when hired, adjusting it when roles change, and revoking it immediately upon departure
- **Access certification (recertification campaigns)** are periodic reviews where managers attest that their team members still require current permissions — a key IGA control tested on CySA+
- **Role-Based Access Control (RBAC) with role mining** is how IGA systems discover and define job-function roles, replacing ad-hoc permission grants with structured entitlement sets
- **Segregation of Duties (SoD)** enforcement prevents one identity from holding conflicting privileges (e.g., the same account cannot both create and approve financial transactions)
- **Orphaned accounts** — accounts with no active owner — are a primary IGA target; unmanaged orphaned accounts were a vector in the Target 2013 breach via a compromised HVAC vendor account

## Related concepts
[[Privileged Access Management]] [[Zero Trust Architecture]] [[Role-Based Access Control]]