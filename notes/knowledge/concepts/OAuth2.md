# OAuth2

## What it is
Think of OAuth2 like a hotel key card system: instead of giving a valet your master house key, you hand them a temporary card that only opens the parking garage. OAuth2 is an authorization framework that lets users grant third-party applications limited access to their resources on another service — without ever sharing their actual credentials. It delegates access through short-lived tokens rather than passwords.

## Why it matters
In 2022, attackers exploited misconfigured OAuth2 implementations to perform account takeovers by manipulating the `redirect_uri` parameter — sending authorization codes to attacker-controlled servers instead of legitimate applications. This "redirect URI hijacking" attack is a textbook OAuth2 threat that organizations must defend against by enforcing strict redirect URI allowlists and using PKCE (Proof Key for Code Exchange) to bind authorization codes to specific clients.

## Key facts
- OAuth2 defines four roles: **Resource Owner** (user), **Client** (app), **Authorization Server** (issues tokens), and **Resource Server** (hosts protected data)
- The most common grant type is **Authorization Code Flow** — ideal for server-side apps; **Implicit Flow** is deprecated due to token exposure in browser URLs
- Access tokens are typically **short-lived JWTs**; refresh tokens allow obtaining new access tokens without re-authenticating
- **PKCE** (RFC 7636) is required for public clients (mobile/SPAs) to prevent authorization code interception attacks
- OAuth2 handles **authorization only** — it does not authenticate users; OpenID Connect (OIDC) layers identity/authentication on top of OAuth2

## Related concepts
[[OpenID Connect]] [[JWT]] [[Authorization Code Flow]] [[PKCE]] [[Session Hijacking]]