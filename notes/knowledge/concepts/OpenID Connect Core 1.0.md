# OpenID Connect Core 1.0

## What it is
Think of it as a hotel concierge who not only unlocks your door (authentication) but also hands you a laminated card with your name, room number, and preferences — that card is the ID Token. OpenID Connect (OIDC) is an identity layer built on top of OAuth 2.0 that adds standardized user authentication and identity assertion via a signed JSON Web Token (JWT) called an ID Token. It answers the question OAuth 2.0 deliberately leaves unanswered: *who is this user?*

## Why it matters
In 2022, misconfigured OIDC implementations enabled account takeover attacks where attackers exploited missing `nonce` validation — replaying intercepted ID Tokens from previous sessions to hijack authenticated accounts. Properly validating the `nonce`, `iss` (issuer), `aud` (audience), and `exp` (expiration) claims in the ID Token is a mandatory defense against replay and token substitution attacks.

## Key facts
- **ID Token** is a signed JWT containing claims: `sub` (subject/user ID), `iss` (issuer), `aud` (intended audience), `exp` (expiration), and optionally `nonce`
- OIDC defines three flows: **Authorization Code** (most secure, server-side), **Implicit** (deprecated, token in URL fragment), and **Hybrid**
- The **UserInfo Endpoint** provides additional identity claims using the Access Token — separate from the ID Token
- OIDC uses **Discovery** (`/.well-known/openid-configuration`) to publish provider metadata including JWKS URI for public key retrieval
- Unlike SAML, OIDC is REST/JSON-native and designed for mobile and API contexts, making it the modern SSO standard for web apps

## Related concepts
[[OAuth 2.0]] [[JSON Web Token (JWT)]] [[SAML 2.0]] [[Single Sign-On (SSO)]] [[Token Replay Attack]]