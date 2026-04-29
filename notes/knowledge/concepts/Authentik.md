# Authentik

## What it is
Think of Authentik as a master keycard system for an entire office building — one card grants access to every room, and security staff can revoke it instantly from a single console. Precisely, Authentik is an open-source Identity Provider (IdP) that centralizes authentication and authorization using protocols like OAuth2, OIDC, SAML, and LDAP. It allows organizations to implement Single Sign-On (SSO), Multi-Factor Authentication (MFA), and user lifecycle management without depending on commercial vendors.

## Why it matters
An attacker who compromises a single employee account in a fragmented authentication environment may pivot laterally across dozens of services. With Authentik acting as a centralized IdP, a security team can enforce MFA universally, detect anomalous login patterns from one dashboard, and immediately revoke all sessions across every integrated application when a credential compromise is detected — collapsing the attacker's window of opportunity from days to seconds.

## Key facts
- Authentik supports **SAML 2.0**, **OAuth2/OIDC**, **LDAP**, and **RADIUS** — making it compatible with both modern web apps and legacy enterprise infrastructure
- Implements **policy-based access control (PBAC)** with granular flow customization for authentication pipelines
- Provides **outpost proxies** that can enforce authentication in front of applications that don't natively support SSO
- **Audit logging** in Authentik captures authentication events, policy evaluations, and admin actions — directly supporting SIEM integration and incident response
- Self-hosted deployment means **credential data never leaves the organization's infrastructure**, reducing third-party breach exposure compared to cloud-only IdP vendors

## Related concepts
[[Single Sign-On (SSO)]] [[Identity Provider (IdP)]] [[OAuth2]] [[SAML]] [[Multi-Factor Authentication (MFA)]]