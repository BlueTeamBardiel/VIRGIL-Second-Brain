# Sourcecodester Computer and Mobile Repair Shop Management System

## What it is
Like a neighborhood repair shop with a broken lock on the back door, this is a PHP-based web application for managing repair orders, customers, and technicians — riddled with documented, exploitable vulnerabilities. It is a specific open-source management system distributed via Sourcecodester that has been repeatedly catalogued in CVE databases for SQL injection, Cross-Site Scripting (XSS), and unrestricted file upload flaws.

## Why it matters
A threat actor targeting a small repair shop running this software can exploit its SQL injection vulnerabilities to dump the customer database — extracting names, device details, and payment information — without any authentication. Real CVEs (e.g., CVE-2023-series entries) confirm unauthenticated attackers can manipulate database queries through unsanitized input fields like search bars and login forms, leading to full database compromise.

## Key facts
- **SQL Injection (SQLi)** vulnerabilities exist in multiple parameters, allowing attackers to bypass authentication or extract sensitive data using tools like SQLMap.
- **Stored XSS** flaws allow malicious scripts injected into customer name or repair description fields to execute in admin browsers.
- **Unrestricted File Upload** vulnerabilities permit uploading PHP web shells disguised as image files, enabling Remote Code Execution (RCE).
- Multiple CVEs have been assigned to this single application, making it a high-value case study in **insecure-by-design** legacy PHP software.
- Demonstrates why **input validation**, **parameterized queries**, and **file type whitelisting** are non-negotiable security controls (OWASP Top 10 directly applies).

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Unrestricted File Upload]] [[Remote Code Execution]] [[OWASP Top 10]]