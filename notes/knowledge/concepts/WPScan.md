# WPScan

## What it is
Like a home inspector who knows every quirk of a specific house model — knowing exactly which floorboards creak and which locks are weak — WPScan is a black-box vulnerability scanner built exclusively for WordPress installations. It enumerates WordPress-specific weaknesses: outdated plugins, vulnerable themes, weak credentials, and exposed configuration files.

## Why it matters
A penetration tester assessing a corporate WordPress site runs WPScan to discover that the site is using an unpatched version of a contact-form plugin with a known CVE allowing unauthenticated SQL injection. Without WPScan, manually identifying which of hundreds of installed plugins are vulnerable would take hours; WPScan cross-references its findings against the WPVulnDB database in seconds.

## Key facts
- WPScan is written in Ruby and maintained as an open-source tool; a commercial API key unlocks full vulnerability database access against WPVulnDB
- It performs **user enumeration** by default (via author archive requests), revealing valid WordPress usernames that can be targeted in credential-stuffing or brute-force attacks
- The `--enumerate p` flag scans for vulnerable plugins, `--enumerate t` for themes, and `--enumerate u` for users — each a distinct attack surface
- WPScan is included in **Kali Linux** and is commonly referenced in OSCP/penetration testing contexts, but understanding its outputs is equally relevant for defenders hardening WordPress deployments
- Defensive countermeasures include disabling user enumeration via REST API restrictions, keeping plugins/themes updated, enforcing MFA on wp-admin, and using a WAF to detect WPScan's characteristic HTTP request patterns

## Related concepts
[[WordPress Security Hardening]] [[Vulnerability Scanning]] [[Enumeration]] [[Credential Brute Forcing]] [[CVE Database]]