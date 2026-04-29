# OAuth

## What it is
Like a hotel valet key that only unlocks the car door (not the glove box or trunk), OAuth lets a third-party app access *specific* resources on your behalf without ever seeing your actual password. It is an open authorization framework (RFC 6749) that issues scoped access tokens so services can delegate limited resource access to other applications.

## Why it matters
In 2022, attackers exploited misconfigured OAuth scopes in third-party integrations to pivot from a low-privilege app into cloud storage buckets containing sensitive customer data — a technique called OAuth token abuse. Defenders must audit granted scopes aggressively, since users routinely click "Allow" granting far broader permissions than an app actually needs, creating persistent backdoors that survive password changes.

## Key facts
- OAuth 2.0 issues **access tokens** (short-lived) and **refresh tokens** (long-lived); compromising a refresh token gives attackers persistent access without credentials
- The **authorization code flow** is the most secure grant type — it never exposes tokens in the browser URL, unlike the deprecated implicit flow
- OAuth is **authorization-only**, not authentication — using it for login requires the **OpenID Connect (OIDC)** extension layer on top
- Redirect URI validation is a critical control; loose wildcard redirects enable **open redirect attacks** that steal authorization codes
- The `state` parameter functions as a CSRF token during the OAuth handshake — omitting it enables cross-site request forgery against the auth flow

## Related concepts
[[OpenID Connect]] [[JSON Web Tokens]] [[CSRF]] [[Privilege Escalation]] [[API Security]]