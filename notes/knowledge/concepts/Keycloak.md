# Keycloak

## What it is
Think of Keycloak as a bouncer who works every door in the city simultaneously — you prove your identity to him once, and he hands you wristbands recognized by every club on the strip. Keycloak is an open-source Identity and Access Management (IAM) solution that provides Single Sign-On (SSO), OAuth 2.0, OpenID Connect, and SAML 2.0 support for applications and services. Organizations self-host it to centralize authentication rather than baking login logic into every individual application.

## Why it matters
In 2022, misconfigured Keycloak instances exposed administrative consoles to the public internet, allowing attackers to create rogue admin accounts and pivot into internal systems — a classic case of an identity provider becoming the master key to the kingdom. Defenders use Keycloak's centralized audit logs and role-based access control (RBAC) policies to detect anomalous login patterns and enforce least privilege across dozens of microservices from a single control plane.

## Key facts
- Keycloak uses **Realms** as isolated administrative domains — each Realm manages its own users, roles, clients, and SSO sessions independently
- Supports **Social Login** and **Identity Brokering**, federating external IdPs (Google, GitHub, LDAP/Active Directory) into a single auth flow
- **Client scopes** and **mappers** control exactly which claims appear in issued JWTs, making misconfiguration a common source of privilege escalation
- Default installation exposes the `/auth/admin` console — leaving this internet-accessible is a critical misconfiguration flagged in penetration tests
- Keycloak tokens are **JWTs signed with RS256 or HS256** — token validation relies on fetching public keys from the `/.well-known/openid-configuration` endpoint

## Related concepts
[[OAuth 2.0]] [[OpenID Connect]] [[SAML]] [[JSON Web Tokens]] [[Single Sign-On]]