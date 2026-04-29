# server-side input validation

## What it is
Like a nightclub bouncer who checks IDs *at the door of the club itself* — not just trusting the wristband someone got from a third party — server-side input validation means the server independently inspects and sanitizes all incoming data before processing it, regardless of what any client-side check already did. It is the enforcement of data integrity rules (type, length, format, range, allowed characters) on the server, where the code cannot be bypassed by an attacker.

## Why it matters
In 2017, attackers exploited missing server-side validation in the Equifax Apache Struts vulnerability by sending a maliciously crafted Content-Type header — the application trusted incoming data without verifying it, enabling remote code execution that exposed 147 million records. Had the server validated and rejected the malformed input before parsing, the exploit chain would have broken at the first link.

## Key facts
- Client-side validation (JavaScript, HTML `maxlength`) is **convenience, not security** — any attacker can intercept and modify requests using Burp Suite before they reach the server
- Server-side validation must occur **before** the data touches a database query, shell command, or file system operation to prevent SQLi, command injection, and path traversal
- Allowlist (whitelist) validation — accepting only known-good patterns — is stronger than denylist (blacklist), which tries to block known-bad input
- OWASP maps input validation failures directly to **Injection (A03)** and **Security Misconfiguration (A05)** in the Top 10
- Validation alone is not sufficient; it must be paired with **output encoding** to fully prevent XSS, since different contexts (HTML, SQL, shell) require different defenses

## Related concepts
[[input sanitization]] [[SQL injection]] [[cross-site scripting (XSS)]] [[allowlist vs denylist]] [[parameterized queries]]