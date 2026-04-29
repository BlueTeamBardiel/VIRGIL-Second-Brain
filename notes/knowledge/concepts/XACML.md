# XACML

## What it is
Think of XACML as a universal legal contract language for access decisions — instead of each courthouse (application) writing its own laws, every system reads from the same standardized rulebook. XACML (eXtensible Access Control Markup Language) is an XML-based open standard that defines a policy language and request/response protocol for attribute-based access control (ABAC). It separates *who can access what* logic from the applications themselves, centralizing authorization decisions in a dedicated Policy Decision Point (PDP).

## Why it matters
In a large healthcare enterprise, a nurse's access to patient records might depend on their role, department, shift hours, patient consent status, and device location — too complex for simple role-based rules. XACML lets the organization define these multi-attribute policies centrally, so a single policy change (e.g., restricting after-hours access) applies instantly across every application. Without this, inconsistent per-app access rules create exploitable gaps where privilege escalation or unauthorized data access goes undetected.

## Key facts
- XACML uses four core components: **PEP** (Policy Enforcement Point), **PDP** (Policy Decision Point), **PAP** (Policy Administration Point), and **PIP** (Policy Information Point)
- Decisions return one of four results: **Permit, Deny, Indeterminate, or NotApplicable**
- XACML 3.0 is the current OASIS standard; it natively supports **ABAC** rather than simpler RBAC models
- Policies are written in XML and evaluate *subjects*, *resources*, *actions*, and *environments* — the four core attribute categories
- XACML enables **separation of duties** enforcement at scale by externalizing authorization logic from application code

## Related concepts
[[ABAC]] [[RBAC]] [[OAuth]] [[Policy Decision Point]] [[Zero Trust Architecture]]