# Policy Decision Point

## What it is
Think of a PDP as the judge in a courtroom: it hears the case (access request), consults the law (policy rules), and renders a verdict — but never physically opens or closes the door itself. A **Policy Decision Point (PDP)** is the logical component in an access control architecture that evaluates access requests against defined policies and returns an authorization decision (permit, deny, or indeterminate). It is functionally separate from the **Policy Enforcement Point (PEP)**, which actually carries out that decision.

## Why it matters
In a Zero Trust Architecture deployment, a compromised PEP (say, a misconfigured API gateway) that bypasses the PDP entirely is a critical failure — attackers can access resources without their requests ever being evaluated. Organizations implementing NIST SP 800-207's Zero Trust model must ensure the PDP (often called the "Policy Engine") remains authoritative and that no enforcement path exists that circumvents it.

## Key facts
- The PDP is a core component of the **XACML (eXtensible Access Control Markup Language)** standard, which formally separates decision from enforcement
- In NIST SP 800-207 Zero Trust Architecture, the PDP maps to the **Policy Engine + Policy Administrator** components
- PDPs consume inputs from **Policy Information Points (PIPs)** — sources of attributes like user identity, device health, and time-of-day
- A PDP returns one of four XACML decisions: **Permit, Deny, Indeterminate, or Not Applicable**
- Centralizing PDP logic enables **consistent, auditable policy enforcement** across heterogeneous environments (cloud, on-prem, hybrid)

## Related concepts
[[Policy Enforcement Point]] [[Zero Trust Architecture]] [[XACML]] [[Attribute-Based Access Control]] [[Policy Information Point]]