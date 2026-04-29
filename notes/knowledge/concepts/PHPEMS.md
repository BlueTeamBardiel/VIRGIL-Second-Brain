# PHPEMS

## What it is
Like a filing cabinet left unlocked in a public hallway, PHPEMS is a PHP-based Exam Management System that handles sensitive student data, authentication, and test content through a web interface. Precisely, it is an open-source online examination platform written in PHP that manages user accounts, exam scheduling, question banks, and scoring — commonly deployed in educational institutions across China and beyond.

## Why it matters
PHPEMS has been repeatedly targeted by SQL injection and arbitrary file upload vulnerabilities, allowing attackers to dump entire user databases or upload web shells that grant remote code execution on the hosting server. In documented CVEs (e.g., affecting PHPEMS 6.x), unauthenticated attackers could bypass login controls and write malicious PHP files directly to the server, turning an exam portal into a persistent command-and-control foothold. Organizations running outdated PHPEMS instances without a WAF have had student PII and administrator credentials exfiltrated in bulk.

## Key facts
- PHPEMS has documented **SQL injection vulnerabilities** in its login and search parameters, enabling authentication bypass and data exfiltration without credentials
- **Arbitrary file upload flaws** in PHPEMS allow attackers to upload `.php` web shells disguised as image or document files
- The platform stores credentials and exam data in a **MySQL backend**, making database dumping via `sqlmap` a common exploitation path
- Default or weak administrative credentials (`admin/admin`) are frequently left unchanged in real-world deployments, compounding risk
- PHPEMS vulnerabilities are catalogued under **CVE assignments** and frequently appear in Chinese CTF competitions and penetration testing practice environments

## Related concepts
[[SQL Injection]] [[File Upload Vulnerability]] [[Web Shell]] [[Remote Code Execution]] [[CVE]]