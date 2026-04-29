# identity management

## What it is
Think of it as the bouncer, guest list, and VIP wristband system for every digital resource in your organization — all rolled into one. Identity management (IdM) is the discipline of creating, maintaining, and revoking digital identities and controlling what resources those identities can access. It encompasses authentication, authorization, and the full lifecycle of user accounts from provisioning to deprovisioning.

## Why it matters
In the 2020 SolarWinds breach, attackers forged SAML tokens to impersonate privileged accounts — bypassing passwords entirely because identity federation was misconfigured. A mature identity management system with strict token validation, privileged access reviews, and anomaly detection would have flagged the forged assertions before lateral movement occurred.

## Key facts
- **Identity lifecycle management** covers four phases: provisioning, maintenance, entitlement review, and deprovisioning — skipping deprovisioning is a leading cause of orphaned accounts exploited by attackers.
- **Least privilege** is a core IdM principle: users receive only the permissions necessary for their role, limiting blast radius if credentials are compromised.
- **Identity providers (IdPs)** like Azure AD or Okta centralize authentication, enabling Single Sign-On (SSO) and federation via protocols such as SAML 2.0 and OAuth 2.0/OIDC.
- **Privileged Identity Management (PIM)** enforces just-in-time (JIT) access for admin accounts, reducing the window of exposure for high-value credentials.
- **Attestation/recertification campaigns** periodically force managers to confirm employee access rights — a required control under frameworks like SOX and HIPAA.

## Related concepts
[[Zero Trust]] [[Multi-Factor Authentication]] [[Role-Based Access Control]] [[Privileged Access Management]] [[Federated Identity]]