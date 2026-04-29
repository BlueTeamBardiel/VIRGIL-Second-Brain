# web server

## What it is
Think of a web server like a librarian who listens for requests, finds the right book (file), and hands it across the counter — except it serves thousands of patrons simultaneously over TCP port 80 or 443. Precisely, a web server is software (e.g., Apache, Nginx, IIS) that accepts HTTP/HTTPS requests from clients, processes them, and returns responses — typically HTML, JSON, or static files.

## Why it matters
In 2021, attackers exploited a misconfigured Apache web server (CVE-2021-41773) via path traversal, allowing unauthenticated users to read files outside the web root — including `/etc/passwd`. This demonstrates why web server hardening (disabling directory listing, enforcing proper access controls, patching promptly) is a core defensive priority in any organization's attack surface management.

## Key facts
- Web servers commonly run on **port 80 (HTTP)** and **port 443 (HTTPS)**; unexpected open ports on a server are a red flag during reconnaissance
- **Apache, Nginx, and Microsoft IIS** are the three dominant web servers — each has platform-specific vulnerabilities and hardening guides
- Misconfigured web servers are a top attack vector: directory traversal, default credentials, and exposed admin panels are common findings
- Web servers are distinct from **application servers** (which execute business logic) — but both are often co-located, expanding the attack surface
- Security headers (e.g., `Content-Security-Policy`, `X-Frame-Options`, `Strict-Transport-Security`) are configured at the web server level and are frequently tested on Security+ exams

## Related concepts
[[HTTP vs HTTPS]] [[directory traversal]] [[TLS/SSL]] [[attack surface]] [[web application firewall]]