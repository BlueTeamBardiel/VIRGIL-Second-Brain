# OAuth 2.0

## What it is
Think of it like a hotel key card system: instead of giving a guest your master key, the front desk issues a limited-access card that opens only specific doors for a set time. OAuth 2.0 is an open authorization framework that allows a third-party application to obtain limited access to a user's resources on another service — without ever receiving the user's password.

## Why it matters
In 2022, attackers exploited misconfigured OAuth flows to perform **account takeover attacks** by intercepting authorization codes via open redirectors — redirecting the code to an attacker-controlled URL instead of the legitimate app. A properly implemented OAuth flow uses **PKCE (Proof Key for Code Exchange)** and strict redirect URI validation to prevent this exact interception, making configuration hygiene critical.

## Key facts
- OAuth 2.0 defines four grant types: **Authorization Code**, **Implicit** (deprecated), **Client Credentials**, and **Resource Owner Password Credentials**
- The **Authorization Code flow** is the most secure for web apps; it separates the authorization code from the access token to prevent exposure
- OAuth 2.0 issues short-lived **access tokens** and longer-lived **refresh tokens** — access tokens are bearer tokens, meaning possession alone grants access
- OAuth 2.0 handles **authorization only**, not authentication — **OpenID Connect (OIDC)** is the identity layer built on top for authentication
- Common misconfigurations include open redirectors, overly broad token scopes, and missing **state parameter** validation (which prevents CSRF attacks on the auth flow)

## Related concepts
[[OpenID Connect]] [[JWT (JSON Web Token)]] [[CSRF (Cross-Site Request Forgery)]]