# authenticated remote code execution

## What it is
Like a trusted locksmith who, once inside your house, starts drilling through your safe — authenticated RCE occurs when an attacker who has *already* obtained valid credentials or a session uses that access to execute arbitrary commands on a remote system. It sits one step past unauthenticated RCE in the attack chain, meaning the vulnerability lies in what the application *does with* your legitimate access, not in how it verifies you.

## Why it matters
In the 2021 GitLab CVE-2021-22205, an authenticated user could upload a crafted image that triggered an ExifTool parsing flaw, resulting in OS-level command execution on the server. This class of vulnerability is particularly dangerous because security controls focused on perimeter authentication (MFA, strong passwords) provide no protection once valid credentials are compromised or phished — the exploit only requires a logged-in session.

## Key facts
- Authenticated RCE often exploits features that *require* login, such as file upload handlers, template engines, or admin consoles — making them harder to discover via unauthenticated scanning
- CVSS scores for authenticated RCE are typically lower than unauthenticated variants, but they remain Critical when paired with privilege escalation (chaining attacks)
- Common root causes: insecure deserialization, OS command injection, Server-Side Template Injection (SSTI), and unrestricted file upload with server-side execution
- Threat actors often acquire credentials first (via phishing or credential stuffing) specifically to trigger authenticated RCE for persistent access or ransomware deployment
- Defense requires input validation and least-privilege execution *after* authentication — WAF rules, sandboxed parsing, and restricting which users can access dangerous functionality

## Related concepts
[[remote code execution]] [[privilege escalation]] [[insecure deserialization]] [[server-side template injection]] [[credential stuffing]]