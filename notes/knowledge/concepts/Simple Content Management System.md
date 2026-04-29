# Simple Content Management System

## What it is
Think of a CMS like a shared apartment building where tenants can redecorate their own rooms — but a bad landlord leaves the master key under the doormat. A Content Management System (CMS) is software that allows non-technical users to create, manage, and publish web content through a browser-based interface without writing code directly. Popular examples include WordPress, Joomla, and Drupal.

## Why it matters
In 2017, a Drupal vulnerability called "Drupalgeddon2" (CVE-2018-7600) allowed unauthenticated remote code execution, enabling attackers to fully compromise servers by sending a single malicious HTTP request. Because CMS platforms are widely deployed and often left unpatched, they represent a massive, high-value attack surface — a single unpatched plugin on WordPress can expose millions of sites simultaneously.

## Key facts
- **Plugin/extension attack surface**: Most CMS compromises occur through third-party plugins, not the core platform — WordPress alone hosts 60,000+ plugins, many unmaintained.
- **Default credentials**: Admin panels (e.g., `/wp-admin`, `/administrator`) are well-known paths; default or weak credentials enable brute-force and credential-stuffing attacks.
- **Privilege escalation risk**: CMS role misconfigurations can allow low-privilege users (Contributor → Admin) to escalate access and inject malicious content.
- **SQL injection vectors**: CMS search boxes, comment fields, and URL parameters are classic SQLi entry points if input sanitization is absent.
- **File upload vulnerabilities**: Unrestricted file upload features can allow attackers to plant web shells, achieving persistent remote access.

## Related concepts
[[SQL Injection]] [[Remote Code Execution]] [[Web Application Firewall]] [[Privilege Escalation]] [[File Upload Vulnerability]]