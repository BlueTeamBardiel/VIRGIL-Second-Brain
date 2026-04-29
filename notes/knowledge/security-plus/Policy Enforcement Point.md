# Policy Enforcement Point

## What it is
Think of a PEP like the turnstile at a subway station — it physically stops you from passing until the ticket machine (the Policy Decision Point) signals "approved." A Policy Enforcement Point (PEP) is the component in an access control architecture that intercepts resource requests and enforces the access decisions made by a separate Policy Decision Point (PDP). It cannot decide on its own; it only acts on what the PDP tells it.

## Why it matters
In a Zero Trust Architecture deployment, a company places a PEP (such as an API gateway or next-gen firewall) in front of its internal payroll application. When an attacker steals valid credentials and attempts lateral movement, the PEP continuously re-evaluates each request against the PDP — catching anomalous access patterns mid-session rather than trusting the initial login, preventing credential-based breaches that perimeter firewalls alone would miss.

## Key facts
- The PEP/PDP split is fundamental to XACML (eXtensible Access Control Markup Language) and NIST SP 800-207 Zero Trust Architecture
- PEPs can be hardware (network firewall), software (reverse proxy, API gateway), or embedded (OS kernel security modules like SELinux)
- A PEP enforces but never decides — if the PDP is unreachable, the PEP defaults to either fail-open or fail-closed depending on policy configuration
- Fail-closed is the secure default: deny all requests when the PDP is unavailable, preventing bypass during outages
- In Zero Trust, the PEP is sometimes called a "policy enforcement point gateway" and sits between every subject and every resource, eliminating implicit trust zones

## Related concepts
[[Policy Decision Point]] [[Zero Trust Architecture]] [[XACML]] [[Attribute-Based Access Control]] [[Fail-Open vs Fail-Closed]]