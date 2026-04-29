# Policy-Driven Access Control

## What it is
Think of it like a bouncer working from a printed rulebook rather than recognizing faces — the decision is made by consulting written rules, not individual identities. Policy-Driven Access Control (PDAC) enforces access decisions based on centrally defined, machine-readable policies that evaluate attributes, context, and rules rather than static permission lists. The policy engine evaluates requests at runtime, making it far more flexible than traditional ACLs.

## Why it matters
In a zero trust architecture deployment, a financial firm used PDAC via XACML to block a legitimate employee's database access because the request came from an unmanaged personal device at 2 AM — a scenario no static role assignment could have caught. The policy evaluated device health, time-of-day, location, and data sensitivity simultaneously, denying access before any credential abuse could succeed. This demonstrates how PDAC shrinks the attack surface even when credentials are valid.

## Key facts
- **ABAC (Attribute-Based Access Control)** is the most common implementation of PDAC, using subject, object, and environment attributes to evaluate policies
- **XACML (eXtensible Access Control Markup Language)** is the dominant standard for defining and exchanging PDAC policies between systems
- Policies are typically enforced by a **Policy Decision Point (PDP)** and executed by a **Policy Enforcement Point (PEP)** — know this split for exam questions
- PDAC supports **dynamic, context-aware decisions**, meaning the same user can be granted or denied access based on changing conditions without admin intervention
- Compared to RBAC, PDAC reduces **role explosion** — the problem where organizations create hundreds of granular roles to handle edge cases

## Related concepts
[[Zero Trust Architecture]] [[Attribute-Based Access Control]] [[Role-Based Access Control]] [[XACML]] [[Policy Enforcement Point]]