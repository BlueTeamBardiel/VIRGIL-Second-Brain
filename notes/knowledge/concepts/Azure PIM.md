# Azure PIM

## What it is
Think of it like a valet key for a luxury car — it unlocks only specific functions, only for a limited time, and only when explicitly handed over. Azure Privileged Identity Management (PIM) is a Microsoft Entra ID service that enables **just-in-time (JIT) privileged access**, allowing users to *activate* elevated roles (like Global Administrator) only when needed, for a defined time window, rather than holding them permanently.

## Why it matters
In the 2020 SolarWinds breach, attackers moved laterally through cloud environments by compromising accounts with persistent administrative privileges — standing access that never expired. Had PIM been enforced, those admin roles would have required explicit activation with MFA and justification, dramatically shrinking the attacker's window. PIM transforms "always-on" privilege into an auditable, time-boxed event.

## Key facts
- **Eligible vs. Active roles**: PIM distinguishes between users *eligible* for a role (can activate it) versus those with the role *active* (currently holding it) — minimizing permanent privilege exposure.
- **Activation requirements** can include MFA, business justification, and approval workflows before elevated access is granted.
- **Time-bound access**: Admin roles can be activated for a maximum configurable duration (e.g., 1–8 hours), after which they automatically expire.
- **Access reviews**: PIM supports periodic reviews to certify whether users still need eligible role assignments — supporting least-privilege hygiene.
- **Audit logs**: Every activation, approval, and denial is logged, supporting forensic investigation and compliance requirements (SOC 2, ISO 27001, etc.).

## Related concepts
[[Just-In-Time Access]] [[Principle of Least Privilege]] [[Role-Based Access Control]] [[Multi-Factor Authentication]] [[Zero Trust Architecture]]