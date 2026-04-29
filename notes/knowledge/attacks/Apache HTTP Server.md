# Apache HTTP Server

## What it is
Think of Apache like a postal sorting facility: incoming web requests arrive, get routed to the right handler (PHP, CGI, static files), and responses get packaged and shipped back — all according to rules defined in configuration files. Precisely, Apache HTTP Server is an open-source, modular web server software that processes HTTP/HTTPS requests and serves web content, running on the majority of Linux-based web infrastructure worldwide.

## Why it matters
In 2021, **CVE-2021-41773** exposed a path traversal and remote code execution vulnerability in Apache 2.4.49 — attackers could request `/../etc/passwd` through a crafted URL to read sensitive files outside the web root, and if `mod_cgi` was enabled, execute arbitrary commands. This was actively exploited in the wild within days of disclosure, demonstrating why patch management and module minimization are critical hardening practices for web servers.

## Key facts
- Apache uses **`.htaccess` files** for per-directory access control, which can be misconfigured to expose restricted content or allow dangerous overrides
- The **`mod_status`** module exposes server performance data at `/server-status` — if left publicly accessible, it leaks IP addresses, request URIs, and traffic patterns
- Apache runs with the principle of **least privilege** using a dedicated low-privilege user (`www-data` or `apache`) to limit damage from compromise
- Common hardening steps include disabling **directory listing** (`Options -Indexes`), hiding version info (`ServerTokens Prod`), and disabling unused modules
- Apache configuration files live in `/etc/apache2/` (Debian) or `/etc/httpd/` (RHEL) — misconfigurations here are a frequent audit finding

## Related concepts
[[Path Traversal]] [[Web Application Firewall]] [[TLS/SSL Configuration]] [[Least Privilege]] [[CVE Vulnerability Management]]