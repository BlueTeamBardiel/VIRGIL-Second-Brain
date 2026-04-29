# Craftql

## What it is
Like a lockpick set designed specifically for GraphQL doors, CraftQL is an open-source penetration testing tool built to enumerate, fingerprint, and exploit vulnerabilities in GraphQL APIs. It automates the tedious process of introspection querying, field fuzzing, and injection testing against GraphQL endpoints.

## Why it matters
During a red team engagement against a modern web application, an attacker can point CraftQL at an exposed `/graphql` endpoint to silently dump the entire API schema via introspection — revealing hidden mutations, admin fields, and internal data objects that developers never intended to be public. This reconnaissance can surface unprotected mutation endpoints that allow unauthorized data modification or privilege escalation without triggering standard WAF rules tuned for REST-style attacks.

## Key facts
- CraftQL automates **GraphQL introspection queries**, which return the full schema of all types, queries, mutations, and subscriptions — essentially a blueprint of the backend
- It can detect **batch query abuse** and **deeply nested query attacks** (also called query complexity attacks) that can cause Denial of Service against GraphQL servers
- The tool tests for **GraphQL injection**, including SQL injection and NoSQL injection passed through query arguments
- Many GraphQL deployments leave **introspection enabled in production** — a misconfiguration CraftQL specifically targets; disabling introspection is a primary hardening recommendation
- CraftQL is written in **Go**, making it a fast, portable single-binary tool commonly used in bug bounty and CTF environments

## Related concepts
[[GraphQL Security]] [[API Security Testing]] [[Introspection Abuse]] [[Injection Attacks]] [[Information Disclosure]]