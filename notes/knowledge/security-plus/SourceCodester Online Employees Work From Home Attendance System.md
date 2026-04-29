# SourceCodester Online Employees Work From Home Attendance System

## What it is
Like a digital sign-in sheet posted on an unlocked bulletin board, this is a PHP-based web application built for tracking remote employee attendance — but shipped with critical unpatched vulnerabilities. It is an open-source HR management tool from SourceCodester that has been repeatedly catalogued in CVE databases for SQL injection and cross-site scripting (XSS) flaws in its login and attendance tracking parameters.

## Why it matters
Attackers actively probe vulnerable instances of this application because its authentication bypass via SQL injection allows unauthenticated access to employee records, schedules, and admin panels. In a real-world scenario, a threat actor could exploit the `?id=` parameter with a crafted payload like `1' OR '1'='1` to extract the entire employee database, exposing PII and enabling further lateral movement into corporate HR infrastructure.

## Key facts
- Multiple CVEs (e.g., CVE-2023-series) document SQL injection vulnerabilities in the `login.php` and attendance record endpoints, rated CVSS 9.8 (Critical) in some cases.
- The application fails to implement parameterized queries/prepared statements, the #1 defense against SQL injection per OWASP Top 10 (A03:2021).
- Stored XSS vulnerabilities allow malicious scripts injected into attendance fields to execute in admin browsers, enabling session hijacking.
- SourceCodester applications are frequently used in academic and small-business environments, making them high-value soft targets due to limited patch management.
- Exploitation requires no authentication in several reported variants, classifying the attack vector as **Network** with **No privileges required** in CVSS scoring.

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[CVSS Scoring]] [[OWASP Top 10]] [[Prepared Statements]]