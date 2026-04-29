# httpd

## What it is
Think of httpd as the postal worker inside a server building — it listens at the door, reads incoming mail (HTTP requests), and hands back the right package (web content). Precisely, httpd (HTTP Daemon) is the background process that runs Apache HTTP Server, listening on TCP port 80 (HTTP) or 443 (HTTPS) to serve web content to clients. It's the actual running instance of the web server software, not the software itself.

## Why it matters
In the 2017 Equifax breach, attackers exploited CVE-2017-5638 in Apache Struts — a framework running on top of httpd — to gain remote code execution on web-facing servers. Understanding httpd configuration hardening (disabling directory listing, suppressing server version banners, restricting methods) is a frontline defense that directly limits attack surface on any Apache-based web infrastructure.

## Key facts
- httpd listens on **TCP 80** (HTTP) and **TCP 443** (HTTPS) by default; misconfiguring these exposes unintended services
- The **httpd.conf** file is the primary Apache configuration file — a common target for auditors checking for insecure directives like `Options Indexes` (enables directory traversal browsing)
- **ServerTokens Prod** directive in httpd.conf suppresses detailed version info, reducing reconnaissance value for attackers
- Apache httpd supports **.htaccess** files for per-directory access control — misconfigured .htaccess can bypass authentication entirely
- Running httpd as a **non-root user** (e.g., `apache` or `www-data`) is a critical privilege separation control; if httpd is compromised, root access isn't automatically granted

## Related concepts
[[Apache Web Server]] [[HTTP]] [[Web Application Firewall]] [[Directory Traversal]] [[TLS/SSL]]