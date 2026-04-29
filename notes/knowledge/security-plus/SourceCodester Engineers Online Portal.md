# SourceCodester Engineers Online Portal

## What it is
Like a unlocked filing cabinet left in a public library, the SourceCodester Engineers Online Portal is a freely distributed PHP web application — available on SourceCodester.com — that allows organizations to manage engineering staff, projects, and credentials through a browser-based interface. It has become notorious in the CVE database as a recurring source of documented vulnerabilities in open-source, ready-to-deploy PHP software.

## Why it matters
In 2022–2023, multiple CVEs were published against this portal documenting SQL injection and unrestricted file upload vulnerabilities — meaning an attacker could upload a PHP web shell disguised as a profile image and gain remote code execution on the server. This mirrors real-world supply chain and third-party software risk: organizations deploying off-the-shelf code without auditing it inherit every flaw the developer left behind.

## Key facts
- **SQL Injection (CVE-2022-xxxx series):** Parameters like `id` in engineer profile pages were passed directly to MySQL queries without sanitization, enabling authentication bypass and data exfiltration.
- **Unrestricted File Upload:** The portal allowed upload of `.php` files through profile or document upload features, enabling web shell deployment and full RCE.
- **Default/Weak Authentication:** Admin credentials were often left at default values, requiring no exploitation of code flaws at all.
- **CVSS scores** on these vulnerabilities frequently ranged **7.5–9.8 (Critical)**, relevant for risk prioritization exercises on CySA+ exams.
- These flaws illustrate **OWASP Top 10** categories A03 (Injection), A04 (Insecure Design), and A05 (Security Misconfiguration) simultaneously in one application.

## Related concepts
[[SQL Injection]] [[Unrestricted File Upload]] [[Web Shell]] [[OWASP Top 10]] [[Remote Code Execution]]