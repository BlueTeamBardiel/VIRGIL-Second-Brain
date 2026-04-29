# REST API

## What it is
Think of a REST API like a standardized drive-through menu: every customer (client) uses the same ordering window (HTTP), picks from a fixed set of actions (GET, POST, PUT, DELETE), and the kitchen (server) never remembers your last visit. REST (Representational State Transfer) is an architectural style for building web services that communicate over HTTP using stateless, resource-based requests, typically exchanging data in JSON or XML format.

## Why it matters
In 2019, the Facebook API exposed millions of user records because third-party apps were granted excessive permissions with no proper scope enforcement — a classic Broken Object Level Authorization (BOLA) flaw. Attackers can query `GET /api/users/1337` and then simply increment the ID to `1338` to access another user's data if the API doesn't validate that the requester owns that resource. This is consistently the #1 vulnerability in the OWASP API Security Top 10.

## Key facts
- REST APIs are **stateless** — each request must carry all authentication context (typically a JWT or API key); no session is stored server-side
- **BOLA (Broken Object Level Authorization)** is the most common REST API attack, exploiting missing resource-ownership checks
- APIs should enforce **rate limiting** to prevent enumeration and brute-force attacks against endpoints
- **HTTP methods matter for security**: GET should never modify data; misuse enables CSRF and unintended state changes
- REST APIs should use **HTTPS exclusively** — transmitting tokens over HTTP exposes credentials to interception even if the token itself is valid

## Related concepts
[[JWT Authentication]] [[OWASP API Security Top 10]] [[Authorization vs Authentication]] [[HTTPS]] [[Broken Access Control]]