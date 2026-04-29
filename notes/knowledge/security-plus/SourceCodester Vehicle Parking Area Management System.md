# SourceCodester Vehicle Parking Area Management System

## What it is
Like a cheap padlock on a bank vault door, this PHP-based open-source parking management application presents a polished interface hiding critically weak security internals. It is a web application hosted on SourceCodester — a repository of free student/hobbyist projects — that manages vehicle entry, exit, and slot allocation, but has been repeatedly documented with multiple CVEs due to poor input handling and authentication controls.

## Why it matters
Attackers actively scan for SourceCodester applications deployed on real production servers (schools, small businesses, municipal lots) because the source code is publicly available, making vulnerability research trivial. A known SQL injection flaw in the `login.php` parameter allows an unauthenticated attacker to bypass authentication entirely and dump the database — exposing license plates, user credentials, and payment records — without writing a single line of custom exploit code.

## Key facts
- **Multiple CVEs documented (2022–2024):** Vulnerabilities include SQL Injection (CWE-89), Cross-Site Scripting/XSS (CWE-79), and unrestricted file upload leading to Remote Code Execution (CWE-434).
- **Attack vector is Network, complexity is Low:** CVSS scores frequently rate 7.5–9.8 (High/Critical) because no authentication is required to trigger the flaws.
- **Root cause:** Unsanitized GET/POST parameters passed directly into MySQL queries — textbook failure to use prepared statements or parameterized queries.
- **File upload bypass:** The system fails to validate MIME types server-side, allowing `.php` webshells disguised as image uploads, achieving full server compromise.
- **Relevance to CySA+:** Represents the OWASP Top 10 trifecta — A01 (Broken Access Control), A03 (Injection), A05 (Security Misconfiguration) — in a single application.

## Related concepts
[[SQL Injection]] [[Unrestricted File Upload]] [[OWASP Top 10]] [[CVE Scoring CVSS]] [[Remote Code Execution]]