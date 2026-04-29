# Content Injection

## What it is
Imagine a forger slipping counterfeit pages into an official government document before it reaches the reader — the cover looks legitimate, but the content has been tampered with. Content injection is an attack where an adversary inserts unauthorized data or code into an application's output, tricking users or systems into treating malicious content as legitimate.

## Why it matters
In 2019, attackers exploited content injection vulnerabilities in misconfigured Elasticsearch instances exposed to the internet, inserting fake records and ransom notes directly into databases. Defenders must validate and sanitize all data at input *and* output boundaries — not just one side — to close this attack surface.

## Key facts
- Content injection differs from **code injection** in that injected content manipulates *what users see or data stores contain*, while code injection manipulates *what the server executes* — though both exploit insufficient input validation.
- **HTTP response splitting** is a classic content injection technique: an attacker injects CRLF characters (`\r\n`) into HTTP headers to inject fake response headers or bodies.
- Content injection can enable **phishing within trusted domains** — attackers inject fake login prompts into legitimate-looking pages, harvesting credentials without ever owning the domain.
- Stored content injection (persisted to a database) is more dangerous than reflected injection because it affects every subsequent user who retrieves that data, not just the initial victim.
- Mitigations include **output encoding**, **Content Security Policy (CSP)** headers, strict input validation using allowlists, and parameterized queries for database-bound content.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[HTTP Response Splitting]] [[Input Validation]] [[Content Security Policy]] [[SQL Injection]]