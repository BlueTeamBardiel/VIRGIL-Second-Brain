# WordPress Admin Takeover

## What it is
Like a janitor who finds a master key left in a door, an attacker gains full administrative control of a WordPress site by exploiting weak credentials, vulnerable plugins, or misconfigurations — without ever breaking the lock. It refers to any attack chain that results in unauthorized access to the WordPress `/wp-admin` dashboard with administrator-level privileges, enabling complete site compromise.

## Why it matters
In 2021, a vulnerability in the Fancy Product Designer plugin (installed on 17,000+ sites) allowed unauthenticated file uploads, letting attackers drop a PHP web shell and create rogue admin accounts silently. From there, attackers redirected visitors to malware distribution sites and harvested credentials — all while the legitimate owner saw nothing unusual in their front-end.

## Key facts
- **Default attack surface**: WordPress login at `/wp-login.php` is publicly accessible by default, making brute-force and credential stuffing trivial without lockout controls
- **Privilege escalation path**: Attackers often compromise a lower-privilege account first (Subscriber/Contributor), then exploit a plugin CVE to escalate to Administrator
- **wp_users table**: Attackers with database access (via SQLi) can directly insert a new admin user or change the password hash in this table — bypassing authentication entirely
- **XML-RPC abuse**: The `xmlrpc.php` endpoint allows thousands of login attempts in a single HTTP request, bypassing per-request rate limiting
- **Indicator of compromise**: Unexpected entries in `wp_users` with admin role, or unknown admin email addresses, are key forensic signals during incident response

## Related concepts
[[Credential Stuffing]] [[Privilege Escalation]] [[Remote Code Execution]] [[SQL Injection]] [[Web Shell]]