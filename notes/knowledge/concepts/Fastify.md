# Fastify

## What it is
Like a Formula 1 pit crew that validates your tire specs *before* the car even enters the pit lane, Fastify pre-compiles schema validation so requests are checked at maximum speed. Fastify is a high-performance Node.js web framework built around JSON Schema validation and serialization, designed to handle HTTP routing with minimal overhead compared to alternatives like Express.

## Why it matters
Fastify's strict JSON Schema validation can prevent injection-style attacks by rejecting malformed or unexpected input before it reaches application logic — but misconfigured schemas with overly permissive `additionalProperties: true` can nullify this protection entirely. In a 2023-style API attack scenario, an attacker sending unexpected fields in a JSON payload could exploit a loose schema to smuggle malicious data past input filtering, leading to prototype pollution or downstream logic flaws in the Node.js application.

## Key facts
- Fastify uses **ajv** (Another JSON Validator) under the hood for schema-based input validation, which can act as a first-line defense against malformed payloads
- Default behavior serializes responses using schemas, which can **prevent accidental data leakage** by stripping undeclared fields from output
- Fastify plugins use a **scoped encapsulation model** (via Avvio), meaning a misconfigured plugin in one scope doesn't automatically expose vulnerabilities across the entire application
- Like Express, Fastify can be vulnerable to **HTTP parameter pollution** and **request smuggling** if deployed behind a misconfigured reverse proxy (e.g., nginx with inconsistent chunked encoding handling)
- Fastify's `Content-Type` parsing is strict by default — unexpected MIME types return `415 Unsupported Media Type`, reducing attack surface compared to frameworks that silently coerce content types

## Related concepts
[[Input Validation]] [[JSON Injection]] [[API Security]] [[Prototype Pollution]] [[HTTP Request Smuggling]]