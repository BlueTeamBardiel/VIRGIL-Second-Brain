# IIS

## What it is
Think of IIS like a hotel concierge who answers the door, interprets guest requests, and serves up the right room — except the "guests" are HTTP requests and the "rooms" are web pages or application responses. Internet Information Services (IIS) is Microsoft's native web server platform, built into Windows Server, that handles HTTP/HTTPS traffic, hosts web applications, and manages services like FTP and SMTP. It competes directly with Apache and Nginx but lives natively in the Windows ecosystem.

## Why it matters
In 2021, attackers exploited the **ProxyLogon/ProxyShell** vulnerabilities in Microsoft Exchange — which runs on IIS — to drop web shells directly into IIS-accessible directories, giving persistent remote code execution. Defenders responding to these incidents learned to hunt for unexpected `.aspx` files in IIS virtual directories as a key indicator of compromise. Knowing IIS internals is essential for both offensive enumeration and defensive IR.

## Key facts
- IIS uses **application pools** to isolate web applications; a compromised app pool running as SYSTEM is catastrophic — least privilege here is critical
- Default IIS installation reveals version information in HTTP response headers (`Server: Microsoft-IIS/10.0`), aiding attacker fingerprinting — should be suppressed via `web.config`
- **Web.config** is IIS's per-directory configuration file; misconfigurations here (e.g., allowing script execution in upload folders) are a primary attack vector
- IIS supports multiple authentication methods: Anonymous, Basic, Windows (NTLM/Kerberos), and Digest — each with different security implications
- Common enumeration tools (Nikto, Nmap NSE scripts) actively probe IIS for exposed admin interfaces like `/iisadmin` and handler mappings

## Related concepts
[[Web Server Hardening]] [[Web Shells]] [[HTTP Response Headers]] [[Application Pool Security]] [[Directory Traversal]]