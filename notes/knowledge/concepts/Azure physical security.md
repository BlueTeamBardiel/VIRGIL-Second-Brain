# Azure Physical Security

## What it is
Think of Azure datacenters like nuclear vaults wrapped in a bank — multiple hardened perimeters, each requiring separate authorization to breach. Precisely, Azure physical security is Microsoft's layered defense strategy protecting the physical infrastructure hosting Azure cloud services, encompassing facility access controls, environmental safeguards, and hardware lifecycle management across globally distributed datacenters.

## Why it matters
In 2016, a disgruntled employee at a cloud provider facility was able to walk out with decommissioned drives containing residual customer data because disposal procedures were inconsistent. Azure addresses this directly: all decommissioned storage media undergoes DoD 5220.22-M-compliant destruction, and customers receive attestation certificates — meaning even if a threat actor bribes an insider, cryptographically wiped and physically shredded drives yield nothing usable.

## Key facts
- Azure datacenters use **multi-factor physical authentication**: security personnel, badge readers, biometrics, and PIN entry are required in sequence — no single credential grants access
- Microsoft employs **two-person integrity rules** in sensitive areas, meaning no single employee can access critical hardware zones alone, mitigating insider threat
- Physical access logs are retained and regularly audited; access is granted on **least-privilege, just-in-time** basis even for Microsoft employees
- Azure datacenters hold certifications including **ISO 27001, SOC 1/2, and FedRAMP**, all of which include physical security controls as audit requirements
- Hardware Supply Chain integrity is enforced through **Project Cerberus** — a custom security chip that validates firmware authenticity at boot, protecting against supply chain attacks even before software loads

## Related concepts
[[Defense in Depth]] [[Supply Chain Security]] [[Zero Trust Architecture]] [[Insider Threat]] [[Data Destruction Standards]]