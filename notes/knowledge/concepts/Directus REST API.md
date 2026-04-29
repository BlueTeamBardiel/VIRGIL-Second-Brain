# Directus REST API

## What it is
Think of Directus like a universal remote control for any database — it wraps your raw SQL tables in a clean HTTP interface so applications can talk to data without writing queries directly. Precisely, Directus is an open-source headless CMS and data platform that auto-generates a REST (and GraphQL) API layer over any SQL database, exposing CRUD operations via standard HTTP endpoints with built-in role-based access control.

## Why it matters
In 2023, misconfigured Directus instances were found publicly exposing `/items/` collection endpoints without authentication, allowing unauthenticated attackers to exfiltrate entire database contents through simple GET requests. This is a textbook Broken Object Level Authorization (BOLA/IDOR) scenario — the API existed correctly, but access policies were never enforced, turning a convenience feature into a full data breach vector.

## Key facts
- Directus uses a **token-based authentication** system (static tokens or JWT Bearer tokens via `Authorization: Bearer <token>` headers) — missing token validation is the most common misconfiguration
- The **`/users/me`** endpoint reveals authenticated user details and is frequently targeted to enumerate privilege levels during reconnaissance
- **Public role permissions** in Directus default to *no access*, but administrators frequently over-grant them during development and forget to restrict before production deployment
- All collection endpoints follow predictable patterns: `GET /items/{collection}`, `POST /items/{collection}` — making automated discovery trivial with tools like `ffuf` or `dirsearch`
- Directus supports **field-level permissions**, meaning even authenticated users can be restricted from seeing specific columns — a defense-in-depth control often overlooked

## Related concepts
[[Broken Object Level Authorization]] [[API Security]] [[JWT Authentication]] [[Role-Based Access Control]] [[Headless CMS Attack Surface]]