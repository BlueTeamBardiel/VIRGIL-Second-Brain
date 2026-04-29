# OpenID Connect

## What it is
Think of OAuth 2.0 as a valet key that lets someone park your car without accessing your glove box — it handles *authorization* but doesn't tell the valet *who you are*. OpenID Connect (OIDC) is the layer bolted on top of OAuth 2.0 that adds an identity card to that valet key, allowing a third-party application to verify *who* the user is. Technically, OIDC is an authentication protocol built on OAuth 2.0 that introduces an **ID Token** (a signed JWT) containing verified claims about the user's identity.

## Why it matters
A poorly implemented OIDC flow is a common target for token substitution attacks, where an attacker intercepts or replays an ID Token from one application and presents it to a different relying party that fails to validate the `aud` (audience) claim. This is why OIDC requires applications to verify that the token's `aud` claim matches their own client ID before trusting the identity assertion. Skipping this check has led to real authentication bypasses in enterprise SSO deployments.

## Key facts
- OIDC adds an **ID Token** (JWT format) to OAuth 2.0's access token — the ID Token contains claims like `sub` (subject/user ID), `iss` (issuer), `aud` (audience), and `exp` (expiration)
- Uses a **UserInfo Endpoint** that a relying party can query with an access token to retrieve additional user attributes
- Supports multiple **flows**: Authorization Code (most secure, server-side), Implicit (deprecated, browser-only), and Hybrid
- The **nonce** parameter binds an ID Token to a specific client session, preventing replay attacks
- OIDC is the backbone of most modern **SSO** implementations, including "Sign in with Google/Apple/GitHub" buttons

## Related concepts
[[OAuth 2.0]] [[JSON Web Token]] [[SAML]] [[Single Sign-On]] [[Federation]]