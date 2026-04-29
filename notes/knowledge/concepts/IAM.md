# IAM

## What it is
Think of IAM like a nightclub's entire operation: the bouncer checking IDs (authentication), the VIP list determining who gets backstage (authorization), and the manager who issues and revokes wristbands (administration). Identity and Access Management (IAM) is the framework of policies, processes, and technologies that controls who can access what resources, under what conditions, within an organization's systems.

## Why it matters
In the 2019 Capital One breach, an attacker exploited a misconfigured IAM role in AWS that granted excessive permissions — a classic case of over-privileged service accounts violating least privilege. Proper IAM hardening (scoping roles tightly, enforcing MFA, and auditing permissions) would have contained the blast radius to near zero.

## Key facts
- **Principle of Least Privilege (PoLP):** Users and systems should have only the minimum permissions required to perform their function — nothing more.
- **Authentication vs. Authorization:** Authentication verifies *who you are* (MFA, passwords, certificates); Authorization determines *what you can do* (ACLs, RBAC, ABAC).
- **RBAC vs. ABAC:** Role-Based Access Control assigns permissions to roles; Attribute-Based Access Control makes decisions based on user attributes, resource tags, and environmental context — more granular and flexible.
- **Provisioning and Deprovisioning:** Failure to remove access when employees leave is a leading cause of insider threat and credential abuse; automated lifecycle management mitigates this.
- **Federated Identity:** Standards like SAML 2.0, OAuth 2.0, and OpenID Connect allow IAM to extend across organizational boundaries, enabling SSO without sharing credentials between systems.

## Related concepts
[[Least Privilege]] [[Multi-Factor Authentication]] [[Role-Based Access Control]] [[Zero Trust]] [[Single Sign-On]]