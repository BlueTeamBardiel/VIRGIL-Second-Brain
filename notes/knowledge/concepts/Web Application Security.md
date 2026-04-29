# web application security

## What it is
Think of a web application like a bank's drive-through teller window — it's a controlled interface between the public and sensitive internal systems, but a clever attacker can slip malicious notes through the slot that the teller misreads as legitimate instructions. Web application security is the practice of identifying and mitigating vulnerabilities in browser-based software that processes user input, manages sessions, and communicates with backend databases and APIs. It addresses threats that arise specifically from the HTTP/HTTPS layer and application logic, not just the network beneath it.

## Why it matters
In 2017, Equifax suffered a breach exposing 147 million records because attackers exploited **CVE-2017-5638**, an unpatched Apache Struts vulnerability in a public-facing web application — a failure of patch management at the application layer, not the firewall. Defenders could have mitigated this with a Web Application Firewall (WAF) and a rigorous software inventory program to catch outdated components before attackers did.

## Key facts
- The **OWASP Top 10** is the industry-standard reference for web application risks; current critical entries include Broken Access Control (#1) and Injection (#3)
- **Input validation** (allowlisting acceptable input) is the primary control against injection attacks including SQLi and XSS
- **Session tokens** must be long, random, and invalidated server-side on logout to prevent session hijacking
- A **WAF** operates at Layer 7 (Application) and inspects HTTP traffic for malicious patterns — it is a compensating control, not a replacement for secure coding
- **HTTPS with TLS 1.2+** is required to protect data in transit; HTTP Strict Transport Security (HSTS) prevents protocol downgrade attacks

## Related concepts
[[SQL injection]] [[cross-site scripting]] [[OWASP Top 10]] [[session hijacking]] [[input validation]]