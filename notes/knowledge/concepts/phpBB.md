# phpBB

## What it is
Think of phpBB as a pre-fabricated town square — a ready-to-deploy bulletin board that anyone can bolt onto their website without building from scratch. It is an open-source, PHP-based internet forum software that stores user posts, threads, and credentials in a backend database (typically MySQL), making it a fully functional community platform out of the box.

## Why it matters
Because phpBB is widely deployed and historically under-patched, it has been a frequent target for SQL injection and Remote Code Execution (RCE) attacks. In 2009, a critical vulnerability (CVE-2008-6506) allowed unauthenticated attackers to bypass authentication entirely by manipulating cookie values — a real-world case study in how trusting client-supplied data destroys authentication integrity. Defenders use phpBB's attack history as a textbook example of why third-party CMS platforms must be version-controlled and continuously patched.

## Key facts
- phpBB is written in **PHP** and commonly paired with **MySQL/MariaDB**, making it a classic LAMP stack component and a high-value SQL injection target
- Historical vulnerabilities include **authentication bypass, XSS, CSRF, and RCE** — covering nearly every OWASP Top 10 category
- Default installations expose an **admin control panel at `/adm/`**, a predictable path attackers enumerate during reconnaissance
- Outdated phpBB versions are routinely found via **Google dorking** (e.g., `inurl:phpBB` or `"Powered by phpBB"`) to identify vulnerable targets at scale
- Credential hashes in older phpBB versions used **MD5 without salting**, making harvested password databases trivially crackable with rainbow tables

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Content Management System Security]] [[Authentication Bypass]] [[Google Dorking]]