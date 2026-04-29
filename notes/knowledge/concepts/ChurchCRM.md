# ChurchCRM

## What it is
Like a filing cabinet stuffed with congregation records left unlocked in a church lobby, ChurchCRM is an open-source web-based Customer Relationship Management system specifically designed to help religious organizations manage members, donations, events, and volunteer data. It runs on a LAMP stack (Linux, Apache, MySQL, PHP) and is self-hosted, meaning the organization controls — and is responsible for securing — all the data.

## Why it matters
ChurchCRM has been repeatedly flagged for critical vulnerabilities including SQL injection, stored Cross-Site Scripting (XSS), and broken access control flaws. In a real attack scenario, an unauthenticated or low-privileged attacker exploiting a stored XSS vulnerability could steal session cookies from an administrator, hijack their session, and exfiltrate the entire congregant database — including donation histories, addresses, and family details — creating significant GDPR and privacy exposure for the organization.

## Key facts
- ChurchCRM has multiple CVEs documenting SQL injection vulnerabilities, allowing attackers to dump entire MySQL databases through crafted input fields
- Stored XSS vulnerabilities have been found in member-facing input fields, enabling persistent payload delivery to any admin who views the affected record
- Broken Object Level Authorization (BOLA/IDOR) flaws have allowed lower-privileged users to access records belonging to other members
- As a self-hosted PHP application, patching is entirely the responsibility of the deploying organization — many installations run outdated, unpatched versions
- Often deployed by small nonprofits with minimal IT security staff, making it a high-value, low-resistance target in the "soft underbelly" of civil infrastructure

## Related concepts
[[SQL Injection]] [[Stored XSS]] [[Broken Access Control]]