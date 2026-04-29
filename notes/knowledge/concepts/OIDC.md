# OIDC

## What it is
Think of OIDC as OAuth 2.0's passport office — OAuth hands you a ticket to access resources, but OIDC staples a verified photo ID to that ticket so apps know *who you actually are*. OpenID Connect (OIDC) is an identity layer built on top of OAuth 2.0 that allows clients to verify end-user identity via a digitally signed **ID token** (a JWT), in addition to obtaining basic profile information through a standardized endpoint.

## Why it matters
In 2023, attackers targeting GitHub's OAuth/OIDC integrations attempted token injection attacks where a forged or stolen ID token could impersonate a developer and gain access to CI/CD pipelines and source repositories. Proper validation of the ID token's `iss` (issuer), `aud` (audience), and `exp` (expiration) claims is the primary defensive control — skipping any of these checks opens the door to token replay and cross-tenant impersonation attacks.

## Key facts
- OIDC introduces the **ID Token** (a JWT) distinct from OAuth's Access Token — the ID token proves identity, the access token proves authorization
- The **`/.well-known/openid-configuration`** endpoint is the discovery document where OIDC providers publish their public keys and supported capabilities
- Three core flows: **Authorization Code** (most secure, used for web apps), **Implicit** (deprecated, browser-only), and **Hybrid**
- Critical JWT claims to validate: `iss` (issuer), `sub` (subject/user ID), `aud` (intended audience), `exp` (expiration), and `nonce` (replay prevention)
- OIDC enables **Single Sign-On (SSO)** across multiple applications with one centralized Identity Provider (IdP) such as Okta, Azure AD, or Google

## Related concepts
[[OAuth 2.0]] [[JWT]] [[SAML]] [[Single Sign-On]] [[Federation]]