# Bookly

## What it is
Like a busy hotel concierge who never checks IDs before handing out room keys, Bookly is a WordPress appointment booking plugin that has historically failed to properly validate and sanitize user input. Bookly is a widely-used scheduling and booking plugin for WordPress sites, enabling businesses to manage appointments — but its codebase has been repeatedly flagged for SQL injection, Cross-Site Scripting (XSS), and authorization bypass vulnerabilities.

## Why it matters
In documented real-world cases, unauthenticated attackers exploited Bookly's SQL injection flaws to dump WordPress database contents — including hashed admin credentials and customer PII — without needing any valid login. A threat actor targeting a medical clinic or law firm using Bookly could extract sensitive appointment data, then pivot to full site takeover by cracking the admin password hash offline.

## Key facts
- Bookly has been assigned multiple CVEs, including vulnerabilities allowing **unauthenticated SQL injection** via booking form parameters due to unsanitized `$_POST` input passed directly to database queries
- **Stored XSS** vulnerabilities have been found in the admin panel, allowing attackers who submit malicious booking requests to execute scripts when staff view appointments
- The plugin's **free and Pro versions** have both been affected; Pro versions with expanded features introduced additional attack surface
- Exploitation typically requires no authentication, making it accessible to **opportunistic attackers using automated scanners** like WPScan
- Remediation follows standard WordPress hardening: **update promptly, use a WAF, apply least-privilege database accounts**, and audit third-party plugins regularly

## Related concepts
[[SQL Injection]] [[Stored XSS]] [[WordPress Security]] [[Input Validation]] [[CVE]]