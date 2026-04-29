# Content Security Policy

## What it is
Think of CSP like a strict nightclub bouncer with a VIP list — your browser only executes scripts, loads images, or connects to domains explicitly approved by the server, and everything else gets turned away at the door. Content Security Policy (CSP) is an HTTP response header that instructs browsers which content sources are trusted, effectively creating a whitelist-based execution policy for a web page. It is a defense-in-depth control implemented server-side but enforced client-side by the browser.

## Why it matters
In a reflected XSS attack, a malicious script injected via a URL parameter would normally execute in the victim's browser. With a properly configured CSP disallowing inline scripts (`unsafe-inline`) and restricting `script-src` to a trusted CDN, that injected code never runs — the browser blocks it before execution, turning a critical vulnerability into a harmless no-op.

## Key facts
- CSP is delivered via the `Content-Security-Policy` HTTP response header (or a `<meta>` tag as a fallback)
- The `script-src` directive controls JavaScript sources; `default-src` serves as a fallback for all resource types not explicitly specified
- `unsafe-inline` and `unsafe-eval` are dangerous CSP values — their presence largely defeats XSS protection
- CSP can operate in **report-only mode** (`Content-Security-Policy-Report-Only`) to log violations without blocking, useful during deployment testing
- Nonces and hashes allow specific inline scripts to be trusted without enabling `unsafe-inline`, providing surgical permission rather than blanket allowances

## Related concepts
[[Cross-Site Scripting (XSS)]] [[HTTP Security Headers]] [[Same-Origin Policy]]