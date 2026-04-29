# WordPress

## What it is
Think of WordPress like a prefabricated house: the frame is solid, but you're handing out spare keys to dozens of contractors (plugins) you barely vetted. WordPress is an open-source Content Management System (CMS) that powers roughly 43% of all websites, built on PHP and MySQL, allowing non-developers to publish and manage web content through a browser-based dashboard.

## Why it matters
In 2023, a critical authentication bypass vulnerability (CVE-2023-2982) in the Social Login plugin allowed attackers to log in as any registered user, including administrators, simply by knowing their email address. This is a textbook example of why third-party plugin vetting is a critical hardening step — the WordPress core was fine; the plugin supply chain was the attack surface.

## Key facts
- **Attack surface is overwhelmingly plugin-driven**: Over 97% of WordPress vulnerabilities originate in plugins or themes, not the core CMS
- **Default install hardening**: The default admin username `admin` and the login URL `/wp-admin` are well-known targets for credential stuffing and brute-force attacks
- **XML-RPC abuse**: The `xmlrpc.php` endpoint enables remote publishing but is frequently exploited for brute-force amplification attacks (one request = hundreds of login attempts) and should be disabled if not needed
- **wp-config.php** contains database credentials in plaintext and must be protected via file permissions (440/400) and ideally moved above the web root
- **Enumeration risk**: WordPress exposes usernames by default via REST API (`/wp-json/wp/v2/users`) and author archive URLs, feeding attacker reconnaissance

## Related concepts
[[Content Management System (CMS)]] [[Plugin Vulnerabilities]] [[Brute Force Attack]] [[XML-RPC]] [[Web Application Hardening]]