# OAuth 2.0 access token

## What it is
Think of it like a valet key — it lets someone drive your car to park it, but can't open the trunk or drive to another city. An OAuth 2.0 access token is a short-lived credential issued by an authorization server that grants a third-party application limited, scoped access to a user's resources — without ever exposing the user's actual password. It represents delegated authorization, not authentication.

## Why it matters
In 2022, attackers targeting Slack and GitHub users stole OAuth tokens from third-party integrations to access private repositories — bypassing MFA entirely, since the token itself was the credential. This is the core danger: a stolen access token grants immediate resource access within its scope and lifetime, with no password required and often no alerting mechanism triggered.

## Key facts
- Access tokens are **bearer tokens** — whoever holds one can use it; possession equals permission
- Tokens carry a defined **scope** (e.g., `read:email`) limiting what the holder can actually do
- Standard lifetime is **short** (typically 1 hour) to limit the blast radius of theft; **refresh tokens** extend sessions without re-authentication
- Tokens are validated by the **resource server**, not the authorization server, on every API request
- OAuth 2.0 is an **authorization framework**, not an authentication protocol — misusing it for login (without OpenID Connect) is a common design vulnerability

## Related concepts
[[Bearer Token]] [[OAuth 2.0 Authorization Code Flow]] [[OpenID Connect]] [[Refresh Token]] [[JWT (JSON Web Token)]]