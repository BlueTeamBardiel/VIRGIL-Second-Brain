# PAC4J

## What it is
Think of pac4j like a universal TV remote that works with any brand — instead of building separate authentication logic for Google, SAML, LDAP, and JWT, your application uses one consistent API to talk to all of them. Precisely, pac4j is an open-source Java security framework that provides a unified authentication and authorization engine supporting over 40 protocols and identity providers, including OAuth2, OIDC, SAML2, CAS, and HTTP Basic Auth.

## Why it matters
In 2021, misconfigured pac4j SAML integrations were exploited in enterprise Java applications where developers incorrectly disabled XML signature validation, allowing attackers to forge SAML assertions and authenticate as arbitrary users — a classic authentication bypass. Proper pac4j configuration enforces strict credential validation across all supported protocols, making it a critical component to audit during application security reviews.

## Key facts
- **Supports 40+ authentication mechanisms** including OAuth2 (Google, GitHub), SAML2, OpenID Connect, JWT, LDAP, and Kerberos through a single `Client` interface
- **Three core concepts**: *Clients* (authentication mechanisms), *Authorizers* (access control rules), and *Profiles* (authenticated user data containers)
- **Framework-agnostic**: integrates with Spring Security, Shiro, Vertx, Play Framework, and JAX-RS via dedicated extension modules
- **Common misconfiguration risk**: disabling `wantsAssertionsSigned` in SAML config or skipping `callbackUrl` validation can lead to open redirects and assertion forgery
- **Stateless support**: pac4j natively handles stateless REST APIs using JWT or HTTP signature clients, relevant for zero-trust architectures

## Related concepts
[[SAML Authentication]] [[OAuth2]] [[OpenID Connect]] [[JWT Security]] [[Authentication Bypass]]