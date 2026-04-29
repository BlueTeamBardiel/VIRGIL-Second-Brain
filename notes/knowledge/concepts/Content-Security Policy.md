# Content-Security Policy

## What it is
Think of CSP like a nightclub bouncer with a strict guest list — your browser is the door, and CSP tells it exactly which sources of scripts, styles, and media are allowed inside. Content-Security Policy (CSP) is an HTTP response header that instructs browsers to only execute or render resources from explicitly approved origins. It serves as a declarative allowlist that browsers enforce client-side, independent of server-side filtering.

## Why it matters
In a classic Cross-Site Scripting (XSS) attack, an attacker injects a malicious `<script>` tag that phones home to their server to steal session cookies. A properly configured CSP with `script-src 'self'` would cause the browser to silently block that injected script from executing — even if the server failed to sanitize the input — breaking the attack chain before any damage occurs.

## Key facts
- CSP is delivered via the `Content-Security-Policy` HTTP response header or a `<meta>` tag; the header is preferred and more powerful
- The `default-src` directive acts as the fallback for all resource types not explicitly defined by other directives
- `'unsafe-inline'` and `'unsafe-eval'` are CSP directives that **weaken** policy by allowing inline scripts/styles and `eval()` — avoid them
- **Report-only mode** (`Content-Security-Policy-Report-Only`) logs violations without blocking, useful for testing policies before enforcement
- Nonces and hashes (`'nonce-abc123'` or `'sha256-...'`) allow specific trusted inline scripts without enabling `'unsafe-inline'`

## Related concepts
[[Cross-Site Scripting (XSS)]] [[HTTP Security Headers]] [[Same-Origin Policy]]