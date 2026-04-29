# Qihui jtbc5 CMS

## What it is
Like a filing cabinet left unlocked in a public lobby, JTBC5 is a PHP-based Content Management System developed by Qihui that has been documented to contain multiple exploitable vulnerabilities in its web application layer. It is a Korean-origin CMS platform where inadequate input validation and improper access controls have exposed installations to SQL injection, file upload bypass, and remote code execution attacks.

## Why it matters
In documented exploitation scenarios, attackers targeting JTBC5 installations have leveraged unrestricted file upload vulnerabilities to upload PHP web shells, gaining persistent remote access to the underlying server. Once a web shell is planted, lateral movement across the hosting environment becomes trivial — a single compromised CMS becomes a pivot point into the entire network infrastructure.

## Key facts
- JTBC5 has publicly disclosed CVEs involving **SQL injection** in authentication endpoints, allowing authentication bypass without valid credentials
- **Unrestricted file upload** vulnerabilities (CWE-434) have been identified, enabling attackers to upload executable scripts disguised as image or document files
- Exploitation typically targets the **/admin** panel with default or weak credentials, reflecting poor credential hygiene practices
- Affected versions have been catalogued in exploit databases (Exploit-DB), making them accessible to script-kiddie-level threat actors, not just advanced adversaries
- Mitigations include input sanitization, enforcing file type whitelisting server-side (not just client-side), disabling PHP execution in upload directories, and applying vendor patches promptly

## Related concepts
[[SQL Injection]] [[Unrestricted File Upload]] [[Remote Code Execution]] [[Web Shell]] [[CMS Security]]