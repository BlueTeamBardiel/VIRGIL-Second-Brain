# Server-Side Code Execution

## What it is
Like a restaurant patron who, instead of ordering from the menu, walks into the kitchen and starts cooking their own meal on the restaurant's stoves — server-side code execution occurs when an attacker causes a web server to run arbitrary code they've supplied, using the server's own processing environment. This is distinct from client-side attacks; the malicious instructions execute with the server's privileges, not the victim's browser.

## Why it matters
In 2021, the Apache Log4Shell vulnerability (CVE-2021-44228) allowed attackers to craft a malicious string in a log message that triggered the server to fetch and execute remote Java code — no authentication required. Organizations running Log4j-dependent applications faced complete server compromise, lateral movement, and data exfiltration within hours of disclosure.

## Key facts
- **Remote Code Execution (RCE)** is the most dangerous form, allowing attackers to run commands across a network without physical or authenticated access
- Common injection vectors include **deserialization flaws, file upload vulnerabilities, template injection (SSTI), and command injection**
- A successful server-side execution attack typically grants attacker access at the **web server process privilege level** (e.g., `www-data` on Linux), which can be escalated further
- **Server-Side Template Injection (SSTI)** is a subtle variant where user input is embedded directly into a template engine (Jinja2, Twig), which then evaluates it as code
- Mitigation relies on **input validation, least privilege, sandboxing, patching**, and blocking outbound connections from web server processes to limit callback exploitation

## Related concepts
[[Remote Code Execution]] [[Command Injection]] [[Server-Side Template Injection]] [[Deserialization Vulnerabilities]] [[Privilege Escalation]]