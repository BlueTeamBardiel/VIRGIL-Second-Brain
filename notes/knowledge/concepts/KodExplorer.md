# KodExplorer

## What it is
Think of it as a filing cabinet that lives on a web server — anyone with the URL and credentials can browse, upload, edit, and delete files through a browser, no FTP client needed. KodExplorer is a PHP-based open-source web file manager and code editor that provides a full desktop-like GUI accessible entirely through HTTP. It is commonly self-hosted for managing server files remotely without SSH access.

## Why it matters
Attackers targeting misconfigured or unpatched KodExplorer installations can exploit path traversal vulnerabilities (e.g., CVE-2018-18893) or authentication bypasses to upload a PHP web shell, instantly converting a file manager into persistent remote code execution. In penetration tests, exposed KodExplorer panels with default credentials (`admin/admin`) have served as initial footholds that led to full server compromise — all through port 80/443 without triggering firewall alerts.

## Key facts
- KodExplorer has been affected by **stored XSS**, **path traversal**, and **arbitrary file upload** vulnerabilities — all critical categories for web application security assessments
- Default installation ships with weak credentials (`admin/admin`), making credential stuffing trivially effective against exposed instances
- Because it runs entirely in PHP over HTTP/HTTPS, malicious activity blends into normal web traffic, evading many IDS signatures
- CVE-2018-18893 specifically allows **unauthenticated path traversal**, enabling attackers to read sensitive files like `/etc/passwd` without logging in
- Classified as a **web-exposed attack surface** — organizations should restrict access via IP allowlisting or VPN rather than public exposure

## Related concepts
[[Path Traversal]] [[Web Shell]] [[Arbitrary File Upload]] [[Default Credentials]] [[CVE Vulnerability Management]]