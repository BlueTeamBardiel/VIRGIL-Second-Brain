# input validation

## What it is
Like a nightclub bouncer who checks IDs and turns away anyone who doesn't match the guest list, input validation is the process of inspecting data before it enters a system to ensure it conforms to expected type, length, format, and range. Any data that fails the check is rejected or sanitized before it can interact with backend logic or storage.

## Why it matters
In 2017, the Equifax breach stemmed partly from failure to validate and sanitize inputs in a web application framework (Apache Struts), allowing attackers to inject malicious data that triggered remote code execution. Had strict input validation been enforced, the crafted payload would have been rejected at the perimeter, preventing the exposure of 147 million records.

## Key facts
- **Allowlist (whitelist) validation** is preferred over denylist (blacklist) — explicitly permit known-good patterns rather than trying to block all known-bad ones
- **Server-side validation is mandatory** — client-side validation (JavaScript) can be bypassed trivially using Burp Suite or browser dev tools
- Input validation is the primary defense against **SQL injection, XSS, command injection, and path traversal** attacks
- **Canonicalization** must happen *before* validation — normalize encoding (e.g., URL encoding, Unicode) first or attackers can smuggle malicious input past filters using alternate representations
- OWASP lists improper input validation as a root cause in the majority of web application vulnerabilities; it maps to **CWE-20** in the Common Weakness Enumeration

## Related concepts
[[SQL injection]] [[cross-site scripting]] [[sanitization]] [[parameterized queries]] [[OWASP Top 10]]