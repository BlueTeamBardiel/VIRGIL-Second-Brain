# Sourcecodester Online Resort Management System

## What it is
Like a beach resort with beautiful lobbies but unlocked employee-only doors, this is a PHP-based web application distributed on Sourcecodester.com that manages hotel/resort bookings — and has become a recurring fixture in CVE databases due to multiple critical vulnerabilities discovered in its codebase. It serves as a real-world example of how open-source project code distributed for learning purposes often ships with exploitable security flaws baked in.

## Why it matters
Attackers targeting small hospitality businesses running this unpatched software can exploit documented SQL injection vulnerabilities to dump the entire guest and credential database — including plaintext or weakly hashed admin passwords — without authentication. CVE-2022-4049 and related advisories demonstrate how a single unsanitized `id` parameter in a GET request can expose complete backend database contents, enabling full account takeover.

## Key facts
- Multiple CVEs document **unauthenticated SQL injection** in parameters like `id`, `room_id`, and `booking_id` passed directly to MySQL queries without prepared statements
- Vulnerable to **Cross-Site Scripting (XSS)** via unsanitized user input stored in the database and rendered back to admin panels (stored XSS)
- **File upload vulnerabilities** allow attackers to upload PHP webshells disguised as image files, achieving Remote Code Execution (RCE)
- Sourcecodester applications are frequently used in penetration testing labs and CTF challenges precisely because their vulnerabilities are documented and reproducible
- These flaws map directly to **OWASP Top 10**: A03 (Injection), A07 (Authentication Failures), A05 (Security Misconfiguration)

## Related concepts
[[SQL Injection]] [[Stored Cross-Site Scripting]] [[Unrestricted File Upload]] [[Remote Code Execution]] [[OWASP Top 10]]