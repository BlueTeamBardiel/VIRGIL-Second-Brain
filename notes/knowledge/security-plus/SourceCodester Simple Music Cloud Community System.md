# SourceCodester Simple Music Cloud Community System

## What it is
Like a community bulletin board where anyone can pin a note — but the board also executes whatever you write on it — this is a PHP-based open-source web application for sharing and streaming music that has been repeatedly identified as vulnerable to SQL injection and cross-site scripting (XSS). It is a freely downloadable project from SourceCodester frequently used in academic settings, making it a recurring target in CVE disclosures due to minimal input validation.

## Why it matters
Multiple CVEs (e.g., CVE-2023-series entries) document that an unauthenticated attacker can manipulate the `id` parameter in file endpoints to perform blind SQL injection, dumping user credentials from the backend database without ever logging in. In a real scenario, a music-sharing community could have all user passwords and emails harvested silently, enabling credential-stuffing attacks across other platforms.

## Key facts
- Vulnerable parameters include unsanitized GET/POST inputs (e.g., `?id=1'`) that are passed directly into MySQL queries without prepared statements
- Affected functionality includes file upload endpoints that lack MIME-type validation, enabling potential webshell uploads
- XSS vulnerabilities allow stored payloads in music titles or user profiles, executing malicious scripts for every visitor who loads that page
- Classified under **CWE-89** (SQL Injection) and **CWE-79** (XSS) — both testable concepts on Security+ and CySA+ exams
- Serves as a textbook case of **insecure-by-design** academic code shipped without security controls, relevant to OWASP Top 10 A03 (Injection) and A07 (Authentication failures)

## Related concepts
[[SQL Injection]] [[Stored XSS]] [[File Upload Vulnerability]] [[CWE-89]] [[OWASP Top 10]]