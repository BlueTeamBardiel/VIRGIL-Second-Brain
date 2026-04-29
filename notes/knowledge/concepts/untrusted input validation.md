# untrusted input validation

## What it is
Think of a nightclub bouncer who checks every ID at the door — not because most people are dangerous, but because you can't know which ones are. Untrusted input validation is the practice of treating all externally supplied data (user forms, API calls, file uploads, URL parameters) as potentially malicious and systematically inspecting, sanitizing, or rejecting it before processing. Any data crossing a trust boundary — from user to application, from network to system — is untrusted by definition.

## Why it matters
In 2017, Equifax was breached via Apache Struts because a web application accepted unsanitized input in HTTP headers, allowing attackers to inject commands that executed on the server — exposing 147 million records. Proper input validation (rejecting unexpected characters in header fields) would have blocked the exploit before it ever reached the vulnerable parsing code.

## Key facts
- **Allowlist (whitelist) validation** is preferred over denylist (blacklist): explicitly permit known-good patterns rather than trying to block all known-bad ones
- **Server-side validation is mandatory** — client-side validation (JavaScript) is trivially bypassed with tools like Burp Suite and provides zero security guarantee
- Common attack classes enabled by missing validation: **SQL injection, XSS, command injection, path traversal, buffer overflow**
- **Parameterized queries / prepared statements** are the gold standard for database input handling — they separate code from data structurally, not textually
- Input validation failures map to **OWASP Top 10 A03:2021 (Injection)**, making this one of the highest-priority controls in web application security

## Related concepts
[[SQL injection]] [[cross-site scripting]] [[output encoding]] [[parameterized queries]] [[OWASP Top 10]]