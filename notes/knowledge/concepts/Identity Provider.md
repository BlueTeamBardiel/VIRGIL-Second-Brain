# identity provider

## What it is
Think of an identity provider (IdP) as a bouncer who holds the master guest list — when you want to enter any club in town, you don't prove yourself to each door separately; you show the bouncer your verified wristband and every club accepts it. Precisely: an Identity Provider is a trusted system that creates, maintains, and manages digital identity credentials, then asserts that identity to relying party applications via protocols like SAML, OAuth, or OpenID Connect. The IdP handles authentication so individual applications can focus solely on authorization.

## Why it matters
In 2020, the SolarWinds attackers forged SAML tokens after compromising an organization's on-premises Active Directory Federation Services (ADFS) server — effectively impersonating the IdP itself to gain persistent, undetected access to cloud resources including Microsoft 365. This "Golden SAML" attack illustrates that the IdP is a crown jewel: compromise it and every relying party application trusts the attacker's forged assertions without question.

## Key facts
- Common IdP examples include Microsoft Azure AD (Entra ID), Okta, Ping Identity, and on-premises ADFS
- IdPs issue **assertions** (SAML) or **tokens** (JWT via OAuth/OIDC) that relying parties validate using the IdP's public key
- **Single Sign-On (SSO)** is the primary user-facing benefit of IdP federation — one authentication event grants access to multiple services
- A compromised IdP private key allows an attacker to forge valid tokens indefinitely (Golden SAML / Pass-the-Assertion attack)
- IdPs typically enforce MFA, conditional access policies, and session lifetimes centrally, making them a critical security control point

## Related concepts
[[SAML]] [[OAuth]] [[Single Sign-On]] [[federation]] [[Active Directory Federation Services]]