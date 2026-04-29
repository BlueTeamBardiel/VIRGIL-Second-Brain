# Okta

## What it is
Think of Okta as a master key ring for the digital enterprise — instead of carrying hundreds of separate keys, employees authenticate once and Okta silently unlocks every door behind the scenes. Precisely, Okta is a cloud-based Identity-as-a-Service (IDaaS) platform that provides Single Sign-On (SSO), Multi-Factor Authentication (MFA), and lifecycle management across applications and infrastructure. It acts as a centralized identity provider (IdP) using protocols like SAML 2.0 and OAuth 2.0/OIDC.

## Why it matters
In 2022, the LAPSUS$ group compromised a third-party Okta support contractor (Sitel), gaining access to Okta's internal support tools and affecting approximately 366 customer tenants. Because Okta sits at the authentication chokepoint for thousands of organizations, a single breach of the IdP cascades into unauthorized access across every downstream application — making it an extraordinarily high-value target and illustrating why identity infrastructure must be treated as Tier-0 critical assets.

## Key facts
- Okta uses **SAML 2.0** for enterprise SSO and **OpenID Connect (OIDC)/OAuth 2.0** for modern API-based authentication
- The **Okta Verify** app provides push-based MFA; it supports TOTP, hardware tokens (FIDO2/WebAuthn), and biometrics
- **Universal Directory** in Okta allows centralized user attribute management, replacing or federating with Active Directory/LDAP
- Attackers target Okta via **session token hijacking** — stealing session cookies post-authentication bypasses MFA entirely (as seen in LAPSUS$ and Scattered Spider attacks)
- Okta generates detailed **System Log** events (`/api/v1/logs`) critical for threat hunting — analysts look for anomalous `user.session.impersonation` or `policy.evaluate_sign_on` events

## Related concepts
[[Single Sign-On (SSO)]] [[Multi-Factor Authentication (MFA)]] [[SAML]] [[Identity Provider (IdP)]] [[Session Hijacking]]