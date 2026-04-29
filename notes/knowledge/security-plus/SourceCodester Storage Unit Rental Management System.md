# Sourcecodester Storage Unit Rental Management System

## What it is
Like a spare key hidden under a doormat that anyone walking by can grab, this is a PHP-based web application distributed on Sourcecodester.com that contains multiple pre-authenticated and authenticated vulnerabilities — a ready-made, vulnerable codebase used in real deployments and penetration testing research. It is a rental management platform for storage facilities that has been documented with SQL injection, Cross-Site Scripting (XSS), and file upload bypass flaws in multiple CVE disclosures.

## Why it matters
Researchers and threat actors routinely target open-source management systems like this because small businesses deploy them without patching or hardening. In documented attacks, unauthenticated SQL injection in the `page` parameter allows an attacker to dump the entire user credential database — including admin passwords — without ever logging in, achieving full system compromise in minutes.

## Key facts
- **CVE-documented vulnerabilities** include SQL injection (unauthenticated), stored XSS, and unrestricted file upload leading to remote code execution (RCE).
- **SQL injection entry points** have been found in GET/POST parameters like `id` and `page`, exploitable via tools like sqlmap.
- **Unrestricted file upload** vulnerabilities allow attackers to upload PHP webshells disguised as image files, bypassing extension checks.
- **Stored XSS** persists in the database and executes in the admin panel, enabling session hijacking of privileged users.
- This software class (small-business PHP apps from code-sharing sites) represents a high-risk category because updates are rarely applied and input validation is consistently absent.

## Related concepts
[[SQL Injection]] [[Stored Cross-Site Scripting]] [[Unrestricted File Upload]]