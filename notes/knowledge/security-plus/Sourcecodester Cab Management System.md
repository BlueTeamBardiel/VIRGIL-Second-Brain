# Sourcecodester Cab Management System

## What it is
Like a taxi dispatcher's logbook left unlocked on a public counter, this is a freely downloadable PHP-based web application from Sourcecodester.com that manages cab bookings, drivers, and routes — built as a learning project but deployed carelessly in real environments. It is a known vulnerable-by-design application that has been the subject of multiple published CVEs documenting SQL injection, cross-site scripting (XSS), and authentication bypass flaws.

## Why it matters
Researchers and threat actors alike use CVEs against this system (e.g., CVE-2023 series entries) as case studies for exploiting poorly sanitized user input in PHP applications. An attacker can manipulate the login form's `username` parameter with a classic `' OR '1'='1` payload to bypass authentication entirely — a textbook SQL injection scenario directly tested on Security+ and CySA+ exams.

## Key facts
- Multiple CVEs document **unauthenticated SQL injection** in the login and search endpoints, allowing full database dumping via tools like SQLMap
- **Stored XSS** vulnerabilities exist in driver and booking management fields, enabling session hijacking of admin users
- The application uses **no prepared statements**, relying instead on raw string concatenation for database queries — the root cause of most flaws
- **Authentication bypass** is achievable without valid credentials, violating the most fundamental access control principle
- Classified under **CWE-89** (Improper Neutralization of Special Elements in SQL Commands) and **CWE-79** (XSS), making it a multi-vector vulnerable application

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Authentication Bypass]] [[CWE-89]] [[Prepared Statements]]