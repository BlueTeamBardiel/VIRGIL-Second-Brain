# CSP

## What it is
Think of CSP like a strict nightclub bouncer who holds a whitelist — only pre-approved guests (scripts, styles, images) from specific origins get in, everyone else is turned away at the door. Content Security Policy is an HTTP response header that instructs browsers to only execute or render resources from explicitly trusted sources, effectively breaking the attack chain for injection-based attacks.

## Why it matters
In 2014, Twitter's mobile site lacked adequate CSP headers, allowing attackers to inject malicious `<script>` tags via XSS vulnerabilities that could steal session tokens. A properly configured CSP with `script-src 'self'` would have caused the browser to silently refuse to execute any injected inline script, neutralizing the attack before any damage occurred.

## Key facts
- CSP is delivered via the `Content-Security-Policy` HTTP response header (or a `<meta>` tag, though headers are preferred and more powerful)
- `default-src 'self'` is the foundational directive — it restricts all resource types to the same origin unless overridden by more specific directives
- `script-src 'unsafe-inline'` and `script-src 'unsafe-eval'` are dangerous exceptions that effectively defeat XSS protection; their presence is a red flag in security audits
- **Nonces** (`script-src 'nonce-randomvalue'`) allow specific inline scripts to run without opening the door to all inline scripts — the gold standard for balancing functionality and security
- CSP Reporting Mode (`Content-Security-Policy-Report-Only`) lets defenders monitor violations without blocking, useful during policy development and threat hunting
- Violations can be reported to a collector endpoint via the `report-uri` or `report-to` directive, enabling detection of active injection attempts

## Related concepts
[[Cross-Site Scripting (XSS)]] [[HTTP Security Headers]] [[Same-Origin Policy]] [[Clickjacking]] [[Subresource Integrity]]