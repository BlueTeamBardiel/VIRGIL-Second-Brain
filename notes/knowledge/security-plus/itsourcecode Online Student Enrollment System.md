# itsourcecode Online Student Enrollment System

## What it is
Like a school registrar's office built from cardboard — it looks functional but collapses under the slightest pressure. The itsourcecode Online Student Enrollment System is a free, open-source PHP/MySQL web application distributed as a learning project, widely deployed by students and small institutions, but riddled with unpatched, publicly disclosed vulnerabilities including SQL injection, cross-site scripting (XSS), and unrestricted file upload flaws.

## Why it matters
Attackers actively search for deployments of this application using Google dorks and Shodan, then exploit its unauthenticated SQL injection endpoints to dump credential databases or achieve remote code execution via malicious file uploads. In 2022–2023, multiple CVEs were assigned to this single codebase, making it a live demonstration of what happens when educational sample code gets mistaken for production-ready software.

## Key facts
- Multiple CVEs assigned (e.g., CVE-2022-xxxxx series) covering SQL injection in parameters like `student_id` and `login` fields — classic unsanitized `$_GET`/`$_POST` inputs passed directly to MySQL queries
- Unrestricted file upload vulnerabilities allow attackers to upload PHP webshells disguised as profile images, achieving Remote Code Execution (RCE)
- Stored XSS vulnerabilities persist malicious scripts in the database, affecting every user who views the compromised page — relevant to session hijacking attacks
- Represents the **insecure design** and **vulnerable/outdated components** categories in the OWASP Top 10 (A04 and A06)
- Frequently appears in CTF challenges and OSCP-style practice labs, making it a benchmark example of poor input validation and lack of parameterized queries

## Related concepts
[[SQL Injection]] [[Unrestricted File Upload]] [[Cross-Site Scripting (XSS)]] [[OWASP Top 10]] [[Remote Code Execution]]