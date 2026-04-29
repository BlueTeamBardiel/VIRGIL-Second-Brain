# X-API-Key

## What it is
Like a VIP wristband at a concert — it doesn't prove *who* you are, just that you have access — an `X-API-Key` is a custom HTTP request header used to transmit a pre-shared secret token that authenticates a client to an API. It is a non-standard header (the `X-` prefix historically denoted experimental/custom headers) carrying a static credential that the server validates before processing the request.

## Why it matters
In 2022, attackers scraped GitHub repositories and found hardcoded `X-API-Key` values embedded in developers' source code, granting unauthorized access to backend services and cloud resources. This is a classic **secret exposure** scenario — because API keys don't expire automatically and often carry broad permissions, a single leaked key can result in full API compromise, data exfiltration, or cloud billing fraud.

## Key facts
- `X-API-Key` is **not standardized by RFC** — servers define their own validation logic, making security entirely implementation-dependent
- API keys transmitted in headers are **less exposed than query string parameters** (which appear in server logs and browser history), but are still vulnerable to interception without TLS
- Unlike OAuth tokens, API keys typically **lack built-in expiration or scope granularity**, making them higher risk if compromised
- Keys should be stored using **secrets management tools** (e.g., HashiCorp Vault, AWS Secrets Manager) — never hardcoded in source code
- Security controls should include **key rotation, rate limiting, and IP allowlisting** to limit blast radius from key exposure

## Related concepts
[[API Security]] [[HTTP Headers]] [[Authentication Tokens]] [[Secrets Management]] [[Transport Layer Security]]