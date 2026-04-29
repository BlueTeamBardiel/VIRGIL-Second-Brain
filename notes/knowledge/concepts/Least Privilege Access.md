# Least Privilege Access

## What it is
A surgeon gets a scalpel, not the keys to the entire hospital — they receive only the tools required for their specific task. Least Privilege Access is the security principle that every user, process, or system component should be granted the minimum permissions necessary to perform its function, and nothing more. It applies to human accounts, service accounts, applications, and network segments equally.

## Why it matters
In the 2020 SolarWinds breach, the malicious Orion software was granted broad network permissions during installation — because organizations routinely over-privilege software they trust. Had least privilege been enforced, the malware's lateral movement would have been severely constrained, limiting blast radius even after initial compromise. Least privilege is one of the most direct controls against privilege escalation and lateral movement attacks.

## Key facts
- **Principle of Least Privilege (PoLP)** is explicitly required by frameworks including NIST 800-53, CIS Controls, and PCI-DSS.
- Implemented through **Role-Based Access Control (RBAC)** or **Attribute-Based Access Control (ABAC)**, which assign permissions by job function rather than individual negotiation.
- **Just-in-Time (JIT) access** is a modern implementation where elevated privileges are granted temporarily and automatically revoked — reducing persistent attack surface.
- Violations are commonly detected through **user and entity behavior analytics (UEBA)**, which flags accounts accessing resources outside their normal scope.
- The opposite failure mode — **privilege creep** — occurs when users accumulate permissions over time through role changes; mitigated by periodic **access reviews (recertification campaigns)**.

## Related concepts
[[Role-Based Access Control]] [[Privilege Escalation]] [[Zero Trust Architecture]] [[Need-to-Know Principle]] [[Just-in-Time Access]]