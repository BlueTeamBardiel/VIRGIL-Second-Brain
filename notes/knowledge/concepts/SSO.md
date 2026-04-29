# SSO

## What it is
Think of SSO like a theme park wristband: you show ID once at the gate, get the band, and then ride any attraction all day without re-authenticating. Single Sign-On (SSO) is an authentication scheme that allows a user to log in once with a single set of credentials and gain access to multiple, independent applications or services. A central identity provider (IdP) issues tokens or assertions that downstream service providers (SPs) accept as proof of identity.

## Why it matters
SSO is a high-value target precisely because it collapses many trust relationships into one. In the 2020 SolarWinds supply chain attack, adversaries who compromised SAML token-signing certificates could forge authentication assertions and move laterally into cloud services like Microsoft 365 — no passwords required. This "Golden SAML" technique illustrates how a single compromised IdP can cascade into a total enterprise breach.

## Key facts
- SSO relies on federation protocols: **SAML 2.0** (XML-based, common in enterprise), **OAuth 2.0** (authorization framework), and **OpenID Connect** (identity layer on top of OAuth).
- The **Identity Provider (IdP)** authenticates the user; the **Service Provider (SP)** trusts the IdP's assertion — never seeing the raw password.
- **Golden SAML attack**: if an attacker steals the IdP's token-signing private key, they can forge SAML assertions for any user, including admins.
- SSO reduces password fatigue and attack surface (fewer passwords = fewer phishing targets), but creates a **single point of failure** — one compromised account unlocks everything.
- MFA should be enforced at the IdP level; MFA at individual SPs is often bypassed when SSO is in use.

## Related concepts
[[SAML]] [[OAuth]] [[Federation]] [[Identity Provider]] [[Kerberos]] [[MFA]]