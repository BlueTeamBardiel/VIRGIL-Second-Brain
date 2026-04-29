# Server-Side Attack

## What it is
Like a thief who bypasses the store's customers entirely and picks the lock on the back stockroom door, a server-side attack targets the infrastructure hosting a service rather than the end users consuming it. Precisely, it exploits vulnerabilities in server software, frameworks, or services (web servers, databases, APIs) to gain unauthorized access, execute code, or exfiltrate data directly from the backend. The attacker never needs a victim to click anything — the server itself is the target.

## Why it matters
In the 2017 Equifax breach, attackers exploited CVE-2017-5638, an unpatched Apache Struts vulnerability on a public-facing web server. Without any user interaction, they achieved remote code execution, ultimately exfiltrating 147 million records. This illustrates why unpatched server software is one of the highest-priority attack surfaces in any organization.

## Key facts
- **Remote Code Execution (RCE)** is the crown jewel of server-side attacks — successful exploitation often yields full system compromise
- Common vectors include SQL injection, Server-Side Request Forgery (SSRF), XML External Entity (XXE) injection, and unpatched CVEs in web frameworks
- Server-Side Request Forgery (SSRF) specifically weaponizes the server to make internal network requests on the attacker's behalf, bypassing perimeter firewalls
- Unlike client-side attacks, server-side attacks do **not** require user interaction — patch cadence and attack surface reduction are the primary defenses
- WAFs (Web Application Firewalls) can mitigate many server-side attack vectors but are not a substitute for patching; defense-in-depth applies

## Related concepts
[[Remote Code Execution]] [[SQL Injection]] [[Server-Side Request Forgery]] [[CVE]] [[Attack Surface]]