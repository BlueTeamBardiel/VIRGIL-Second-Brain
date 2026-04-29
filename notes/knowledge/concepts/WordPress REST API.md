# WordPress REST API

## What it is
Think of it as a drive-through window bolted onto the side of a restaurant — customers can order food (data) without ever walking through the front door (the traditional web interface). The WordPress REST API is a programmatic interface introduced in WordPress 4.7 that allows external applications to read and write WordPress content (posts, users, settings) via HTTP requests using JSON-formatted data, bypassing normal authentication flows if misconfigured.

## Why it matters
In 2017, a critical unauthenticated content injection vulnerability (CVE-2017-1001000) in the REST API allowed attackers to modify any post or page on millions of WordPress sites without logging in — enabling mass defacement campaigns that hit over 1.5 million pages in days. Defenders must ensure the API is patched, restrict unnecessary endpoints, and enforce authentication (application passwords or OAuth) on sensitive routes.

## Key facts
- The REST API is enabled by default in WordPress 4.7+; the `/wp-json/wp/v2/users` endpoint publicly enumerates usernames, aiding brute-force attacks
- Unauthenticated access to certain endpoints violates the principle of least privilege — a common misconfiguration finding in web app assessments
- Application Passwords (introduced in WP 5.6) are the preferred auth mechanism for REST API integrations, separate from login credentials
- Disabling the REST API entirely breaks many plugins (Gutenberg editor depends on it), making full lockdown operationally impractical
- Security scanners like WPScan specifically probe REST API endpoints to fingerprint WordPress version, installed plugins, and user accounts

## Related concepts
[[API Security]] [[Authentication Bypass]] [[Information Disclosure]] [[Content Management System Hardening]] [[CVE Exploitation]]