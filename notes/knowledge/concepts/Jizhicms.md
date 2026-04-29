# Jizhicms

## What it is
Like a skeleton key copied from cheap metal that breaks inside the lock — Jizhicms is a PHP-based content management system (CMS) that became notorious for having structural security flaws baked into its codebase. Specifically, it is an open-source Chinese CMS platform repeatedly found vulnerable to SQL injection, file upload bypass, and cross-site scripting (XSS) vulnerabilities across multiple versions.

## Why it matters
In penetration testing exercises and real-world red team engagements, Jizhicms has been used as a case study for unrestricted file upload vulnerabilities — where an attacker uploads a PHP webshell disguised as an image, bypasses weak MIME-type validation, and achieves remote code execution (RCE) on the server. CVE entries against Jizhicms demonstrate how CMS platforms with inadequate input sanitization become immediate footholds for attackers targeting shared hosting environments.

## Key facts
- Jizhicms has documented vulnerabilities including **SQL injection in admin login panels**, allowing authentication bypass without valid credentials.
- **Unrestricted file upload** flaws allowed attackers to upload `.php` webshells by manipulating file extension or MIME-type checks — a classic CWE-434 pattern.
- Vulnerabilities have been found in both **front-end and back-end** components, meaning even unauthenticated users could exploit certain attack surfaces.
- Jizhicms weaknesses are frequently catalogued on **exploit-db.com** and used in CTF (Capture the Flag) challenges to teach real-world web exploitation.
- Reflects a broader pattern: **low-resource open-source CMS platforms** often lack security audits, making them disproportionately vulnerable compared to enterprise alternatives.

## Related concepts
[[SQL Injection]] [[Unrestricted File Upload (CWE-434)]] [[Remote Code Execution]] [[Webshell]] [[Content Management System Security]]