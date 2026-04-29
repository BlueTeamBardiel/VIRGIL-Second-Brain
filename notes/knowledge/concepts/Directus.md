# Directus

## What it is
Think of Directus as a universal remote control for any database — it wraps an existing SQL database and instantly generates a REST and GraphQL API on top of it, plus an admin dashboard, without touching your data structure. Precisely, Directus is an open-source headless CMS and data platform that acts as a backend-as-a-service layer, allowing developers to manage and expose database content through standardized APIs.

## Why it matters
In 2023, misconfigured Directus instances were discovered publicly exposing admin panels with default or weak credentials, giving attackers full read/write access to underlying databases containing PII and business-critical data. Because Directus auto-generates API endpoints for every table in a connected database, a single misconfiguration — such as overly permissive role assignments or unauthenticated public access policies — can expose an entire database schema through predictable REST routes like `/items/{collection}`.

## Key facts
- Directus uses a **role-based access control (RBAC)** system; the built-in "Public" role can inadvertently grant unauthenticated API access if misconfigured
- Default admin credentials and exposed `/admin` login panels are a common misconfiguration vector catalogued in vulnerability databases
- Directus supports **JWT-based authentication** and OAuth2/SSO integrations — weak JWT secrets allow token forgery attacks
- The platform's auto-generated API exposes database schema structure, enabling **information disclosure** if endpoint access is not restricted
- Directus instances are often found via Shodan/Censys using fingerprints from the `/server/info` endpoint, which can leak version numbers enabling targeted CVE exploitation

## Related concepts
[[Headless CMS Security]] [[Role-Based Access Control]] [[API Security]] [[Information Disclosure]] [[JWT Authentication]]