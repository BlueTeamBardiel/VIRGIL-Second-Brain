# SourceCodester Payroll Management and Information System

## What it is
Like a cheap padlock on a bank vault, this is a free open-source PHP/MySQL web application for managing employee payroll that ships with well-documented, publicly exploitable vulnerabilities. It is a concrete example of an insecure-by-default web application frequently cited in CVEs for SQL injection, cross-site scripting (XSS), and unrestricted file upload flaws.

## Why it matters
Attackers routinely scan for installations of known-vulnerable software like this one using tools like Shodan or Google dorks, then chain a SQL injection vulnerability to dump credential hashes, escalate privileges, and pivot into internal HR or financial systems. In penetration testing labs and CTF environments, this application serves as a realistic target for practicing OWASP Top 10 exploits without legal risk.

## Key facts
- Multiple CVEs have been assigned to this software covering **SQL injection via unsanitized GET/POST parameters**, allowing authentication bypass and full database extraction
- **Unrestricted file upload vulnerabilities** allow attackers to upload PHP web shells disguised as legitimate files (e.g., profile pictures), achieving Remote Code Execution (RCE)
- **Stored XSS flaws** exist in employee name and record fields, enabling session hijacking of admin accounts
- The software is built with **no prepared statements or parameterized queries**, making it a textbook case of CWE-89 (SQL Injection)
- Classified under **CVSS scoring** — several vulnerabilities score 9.8 (Critical), reflecting network-exploitable, low-complexity, no-privilege-required attack vectors

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Unrestricted File Upload]] [[Remote Code Execution]] [[OWASP Top 10]]