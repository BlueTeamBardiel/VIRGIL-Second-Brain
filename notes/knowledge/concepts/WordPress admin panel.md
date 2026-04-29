# WordPress admin panel

## What it is
Think of it as the master control room of a ship — from one dashboard, a single operator can steer, adjust engines, and manage the whole crew. The WordPress admin panel (`/wp-admin`) is the web-based administrative interface that allows authenticated users to manage all aspects of a WordPress site, including content, plugins, themes, and user accounts. It runs on PHP and connects directly to a MySQL/MariaDB backend database.

## Why it matters
The `/wp-admin` login page is one of the most targeted endpoints on the internet — automated credential-stuffing tools like WPScan and Hydra routinely hammer it with breached username/password combinations. In the 2021 compromise of over 1.6 million WordPress sites, attackers exploited a vulnerable plugin accessible *through* the admin panel to inject malicious JavaScript, demonstrating that admin access equals full site takeover and often server-level code execution via malicious plugin uploads.

## Key facts
- Default login URL is `/wp-admin` or `/wp-login.php` — security hardening commonly involves moving or blocking this path via `.htaccess` rules or plugins like WPS Hide Login
- **XML-RPC** (`xmlrpc.php`) provides an alternative authentication pathway that bypasses traditional login protections, enabling brute-force and DDoS amplification attacks even when `/wp-admin` is IP-restricted
- Admin-level WordPress users can upload and activate plugins, which execute arbitrary PHP — this makes admin compromise equivalent to Remote Code Execution (RCE)
- WordPress uses **role-based access control** with five default roles: Subscriber, Contributor, Author, Editor, and Administrator — privilege escalation between these is a common attack objective
- Exposed `wp-config.php` (often via path traversal or misconfigured servers) reveals database credentials that grant backend access without ever touching the admin panel

## Related concepts
[[Credential Stuffing]] [[Remote Code Execution]] [[Privilege Escalation]]