# CouchCMS

## What it is
Think of CouchCMS like a key duplicator bolted onto the side of a building — it lets administrators copy and manage content, but if the duplicator itself is compromised, anyone can copy the master key. CouchCMS is a flat-file, PHP-based content management system designed to be layered onto existing HTML sites, giving non-technical users editing capabilities without rebuilding the site. It operates by embedding special template tags into HTML files that the CMS engine parses and renders dynamically.

## Why it matters
CouchCMS versions prior to 2.0 contained a known remote code execution (RCE) vulnerability (CVE-2018-14858) where authenticated attackers could upload malicious PHP files disguised as templates, achieving full server compromise. In a penetration test scenario, an attacker discovering a CouchCMS login panel via directory enumeration could brute-force weak admin credentials and leverage this upload flaw to plant a web shell, pivoting deeper into the network infrastructure.

## Key facts
- **CVE-2018-14858**: Authenticated RCE via arbitrary file upload in CouchCMS ≤ 2.0; CVSS score 8.8 (High)
- CouchCMS uses a **single `couch/` directory** as its admin panel — predictable path makes it easy to discover via tools like `gobuster` or `dirbuster`
- Authentication bypass and SQL injection vulnerabilities have been documented in older versions, making patch management critical
- Because it sits atop existing HTML files, it often **escapes standard CMS security audits** that focus on WordPress/Joomla signatures
- Default installation leaves the admin panel at `/couch/index.php` with weak default credentials if not hardened post-install

## Related concepts
[[Remote Code Execution]] [[File Upload Vulnerability]] [[Web Shell]] [[Content Management System Security]] [[Directory Enumeration]]