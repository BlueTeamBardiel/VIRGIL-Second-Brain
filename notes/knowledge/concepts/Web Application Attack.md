# Web Application Attack

## What it is
Like a thief who ignores the front door and instead crawls through an unlocked bathroom window, web application attacks bypass network defenses by exploiting flaws in the application layer itself. Precisely, these are attacks targeting vulnerabilities in web-hosted software — such as input handling errors, broken authentication, or misconfigured APIs — to steal data, hijack sessions, or gain unauthorized access. They operate at Layer 7 (HTTP/HTTPS), making traditional firewall rules largely ineffective.

## Why it matters
In 2017, the Equifax breach exposed 147 million records by exploiting an unpatched Apache Struts vulnerability (CVE-2017-5638) — a web application flaw, not a network intrusion. A Web Application Firewall (WAF) with virtual patching rules could have blocked the malicious HTTP requests while the organization applied the official patch, illustrating how application-layer defenses fill gaps that perimeter security cannot.

## Key facts
- The **OWASP Top 10** is the authoritative reference for web application attack categories, covering SQL Injection, XSS, Broken Access Control, and others — it's directly tested on Security+/CySA+
- **SQL Injection** remains the most critical injection attack: user input is interpreted as SQL commands, allowing attackers to dump, modify, or delete database contents
- **Cross-Site Scripting (XSS)** injects malicious scripts into pages served to other users, enabling session cookie theft via `document.cookie`
- **Broken Access Control** (OWASP #1) occurs when users can act outside their intended permissions — e.g., changing a URL parameter from `user_id=42` to `user_id=1` to access another account
- A **WAF** (Web Application Firewall) inspects HTTP traffic and blocks malicious patterns; it's a compensating control, not a substitute for secure coding practices

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting]] [[OWASP Top 10]] [[Web Application Firewall]] [[Broken Access Control]]