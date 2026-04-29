# WADA

## What it is
Like a locksmith who uses a master key to open any lock in a building, WADA (Windows Authenticode and Digital Signatures / more precisely: **Write Anything Do Anything**) — but most critically in security contexts, **WADA** refers to **Web Application Denial of Authorization**, or is most commonly encountered as shorthand for weaknesses in **WAF (Web Application Firewall) Detection Avoidance**. *Clarifying the dominant usage:* In exploit and CTF communities, WADA typically refers to techniques that bypass authorization controls entirely — executing privileged actions as an unauthenticated or low-privileged user by manipulating request parameters, HTTP verbs, or path traversal patterns.

Think of it as sneaking into a VIP section by using the service entrance — the bouncer (WAF or access control) only watches the front door, so attackers route around it entirely.

## Why it matters
In 2021, attackers exploited authorization bypass flaws in multiple healthcare APIs — sending HTTP `PUT` requests to endpoints that only validated `GET` requests — to exfiltrate patient records without authentication. WADA-class vulnerabilities frequently appear in OWASP API Security Top 10 (Broken Object Level Authorization / Broken Function Level Authorization) and are notoriously under-detected by signature-based tools.

## Key facts
- WADA-style attacks exploit **missing server-side authorization checks**, not broken encryption or network flaws
- Common vectors: **HTTP verb tampering** (GET→PUT), **parameter pollution**, forced browsing to unlinked admin endpoints
- Distinct from **authentication bypass** — the user may be legitimately logged in but accesses resources beyond their privilege level
- **OWASP API3 and API5** directly address these authorization weaknesses
- Detected through **behavioral analysis and access control auditing**, not purely signature-based WAF rules

## Related concepts
[[Broken Access Control]] [[HTTP Verb Tampering]] [[OWASP Top 10]] [[Forced Browsing]] [[Privilege Escalation]]