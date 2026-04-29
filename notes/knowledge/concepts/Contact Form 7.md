# Contact Form 7

## What it is
Think of it as a mail slot built into a wall — convenient for receiving messages, but if the slot has no filter, someone can shove in anything, including something dangerous. Contact Form 7 is a widely-used WordPress plugin that allows website owners to embed customizable HTML contact forms; it processes user-submitted data server-side via PHP and delivers it via email.

## Why it matters
In 2020, a critical unrestricted file upload vulnerability (CVE-2020-35489) in Contact Form 7 allowed attackers to bypass filename sanitization by inserting special characters (e.g., `filename.php .jpg`), uploading executable PHP webshells and achieving Remote Code Execution (RCE) on the server. This affected over 5 million WordPress installations and became an active exploitation target within days of disclosure, illustrating how a single misconfigured input handler can compromise an entire web server.

## Key facts
- **CVE-2020-35489**: Critical unrestricted file upload flaw patched in version 5.3.2; exploited via double-extension bypass using special Unicode separators.
- Contact Form 7 has **5+ million active installations**, making it a high-value target for mass-exploitation campaigns targeting unpatched WordPress instances.
- Vulnerability class is **CWE-434 (Unrestricted Upload of Dangerous File Type)** — a recurring exam topic in web application security.
- Attackers commonly chain CF7 vulnerabilities with **privilege escalation** or **lateral movement** after dropping a webshell.
- Defense requires **input validation, file type whitelisting, upload directory restrictions** (deny script execution), and maintaining plugin updates — principles directly tied to CySA+ hardening objectives.

## Related concepts
[[Unrestricted File Upload]] [[Remote Code Execution]] [[WordPress Security]] [[Web Application Firewall]] [[Input Validation]]