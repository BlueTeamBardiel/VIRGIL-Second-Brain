# Identity

## What it is
Think of identity like a passport: it's not *who you are*, it's the **claim you make about who you are** — which must then be verified. In security, identity is the set of attributes (username, certificate, biometric) that uniquely represents a subject (user, device, or service) within a system before authentication can occur.

## Why it matters
In the 2020 SolarWinds breach, attackers forged SAML tokens to impersonate privileged identities inside Microsoft 365 — bypassing passwords entirely. This is why modern Zero Trust architecture treats identity as the new perimeter: if you can forge an identity token, you own the kingdom without ever touching a firewall.

## Key facts
- **Identity ≠ Authentication**: Identity is the *claim*; authentication is the *proof*. Conflating them is a classic exam trap.
- **Identity providers (IdPs)** like Okta, Azure AD, or an on-premises Active Directory are the authoritative sources that issue and manage identities.
- **Non-repudiation** depends on strong identity — if identities are shared or spoofable, audit logs become legally worthless.
- **Federated identity** allows a single identity (via SAML or OIDC) to be trusted across multiple organizations or systems without re-authenticating.
- **Privileged identities** (admin accounts, service accounts) are the highest-value targets; CySA+ expects you to know that service accounts are frequently exploited because they rarely have MFA enforced.

## Related concepts
[[Authentication]] [[Authorization]] [[Federated Identity Management]] [[Zero Trust Architecture]] [[Privileged Access Management]]