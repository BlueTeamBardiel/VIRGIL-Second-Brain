# CMS

## What it is
Think of a CMS like a restaurant kitchen where multiple chefs can add, edit, and plate dishes without needing to know how the restaurant was built. A Content Management System (CMS) is a web application platform — like WordPress, Joomla, or Drupal — that lets non-technical users create and manage website content through a browser-based interface. It abstracts the underlying code, database, and server from the end user.

## Why it matters
WordPress alone powers ~43% of all websites, making it a massive attack surface. Threat actors routinely scan for outdated CMS plugins (e.g., the 2021 exploitation of vulnerable WordPress plugin "File Manager") to upload webshells, establish persistence, or pivot into backend databases. Defenders must treat CMS hardening — patching plugins, enforcing strong admin credentials, and disabling file editing via `wp-config.php` — as a critical control.

## Key facts
- **Plugin/theme vulnerabilities** are the #1 attack vector in CMS exploitation, not the core platform itself
- Default admin paths (`/wp-admin`, `/administrator`) are trivially guessable; relocating or restricting them is a baseline hardening step
- CMS databases store credentials as hashed values — a compromised database dump often leads to offline password cracking attacks
- **CVE tracking matters**: CMS components (plugins, themes, core) each carry their own CVEs, requiring independent patch management
- Misconfigured file permissions on CMS installs can allow remote file upload → webshell → RCE (Remote Code Execution) chain

## Related concepts
[[Web Application Vulnerabilities]] [[SQL Injection]] [[Webshell]] [[Patch Management]] [[Remote Code Execution]]