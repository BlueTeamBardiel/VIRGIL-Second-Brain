# Web Application

## What it is
Think of a web application like a vending machine that lives in a browser — you interact with it through buttons and forms, it processes your input, and serves back dynamic results, all without you ever seeing the machinery inside. Precisely, a web application is a client-server software program that runs in a web browser, using HTTP/HTTPS to exchange data between a front-end user interface and a back-end server or database. Unlike static websites, web apps process user input, execute business logic, and query databases in real time.

## Why it matters
In 2017, the Equifax breach exposed 147 million records because attackers exploited a known vulnerability (CVE-2017-5638) in Apache Struts, a web application framework — the patch had been available for months. This illustrates why web applications are prime attack surfaces: they are internet-facing, accept untrusted user input, and often connect directly to sensitive databases. Defenders use Web Application Firewalls (WAFs) and regular patching cycles specifically to reduce this exposure.

## Key facts
- Web applications are the #1 attack vector for data breaches, according to Verizon DBIR reports
- The OWASP Top 10 is the authoritative list of critical web application security risks (e.g., Injection, Broken Access Control, XSS)
- HTTP is stateless, so web apps use sessions/cookies to maintain user context — making session hijacking a persistent threat
- Input validation is the foundational defense; all user-supplied data must be treated as untrusted
- Common vulnerability classes include SQL Injection, Cross-Site Scripting (XSS), Cross-Site Request Forgery (CSRF), and Insecure Direct Object References (IDOR)

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[OWASP Top 10]] [[Web Application Firewall (WAF)]] [[Session Hijacking]]