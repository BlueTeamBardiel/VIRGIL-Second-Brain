# Vvveb

## What it is
Like a LEGO kit for building websites — drag, drop, and assemble without touching code — Vvveb is an open-source PHP-based website builder and CMS (Content Management System) that provides a visual, component-driven interface for constructing and managing web pages. It runs server-side and exposes an admin panel, template engine, and plugin architecture that administrators use to deploy and customize web applications.

## Why it matters
In penetration testing engagements, CMS platforms like Vvveb represent high-value attack surfaces because their admin panels, file upload features, and plugin systems are common vectors for remote code execution (RCE). A misconfigured or outdated Vvveb installation could allow an attacker to upload a PHP webshell disguised as a template or component, achieving full server compromise — a scenario directly relevant to web application assessments documented in CVE disclosures against similar PHP CMS platforms.

## Key facts
- Vvveb is written in **PHP** and follows an MVC architecture, meaning vulnerabilities in its routing or input handling can expose server-side logic directly
- Like WordPress or Joomla, its **plugin and theme system** expands attack surface — malicious or vulnerable plugins can introduce SQL injection or file inclusion flaws
- **Unauthenticated admin panel exposure** (default credentials, no login enforcement) is a common misconfiguration finding during CySA+ style vulnerability assessments
- File upload functionality within builders is a classic **unrestricted file upload** vulnerability (mapped to OWASP A03:2021 – Injection category and CWE-434)
- Security hardening steps include: disabling directory listing, enforcing authentication, restricting upload MIME types, and applying least privilege to the web server process

## Related concepts
[[Content Management System (CMS) Security]] [[Remote Code Execution (RCE)]] [[Unrestricted File Upload]] [[PHP Webshell]] [[OWASP Top 10]]