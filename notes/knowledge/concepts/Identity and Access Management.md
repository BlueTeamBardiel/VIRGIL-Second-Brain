# Identity and Access Management

## What it is
Think of IAM as a nightclub with a bouncer (authentication), a VIP list (authorization), and a manager who revokes wristbands when someone gets kicked out (lifecycle management). IAM is the framework of policies, processes, and technologies that ensures the right people access the right resources at the right times — and that access is revoked when no longer needed. It encompasses identity provisioning, authentication, authorization, and auditing across an organization's systems.

## Why it matters
In the 2020 SolarWinds breach, attackers used compromised service accounts with excessive privileges to move laterally across networks for months undetected. A mature IAM program enforcing least privilege and regular access reviews would have limited the blast radius significantly — service accounts shouldn't have domain-wide read access just because it's convenient to configure them that way.

## Key facts
- **Least Privilege** is the core IAM principle: users and systems receive only the minimum permissions necessary to perform their function, nothing more.
- **Provisioning vs. Deprovisioning**: Failing to remove access when employees leave (orphaned accounts) is one of the most common audit findings and attack vectors.
- **Federation** allows identity trust across organizational boundaries using standards like SAML 2.0, OAuth 2.0, and OpenID Connect — enabling SSO across enterprises.
- **Privileged Access Management (PAM)** is a sub-discipline focused specifically on high-risk accounts (admins, service accounts) often requiring just-in-time access and session recording.
- **Directory Services** (e.g., Active Directory, LDAP) are the backbone of most enterprise IAM implementations, storing identity attributes and group memberships.

## Related concepts
[[Least Privilege]] [[Multi-Factor Authentication]] [[Privileged Access Management]] [[Single Sign-On]] [[Zero Trust Architecture]]