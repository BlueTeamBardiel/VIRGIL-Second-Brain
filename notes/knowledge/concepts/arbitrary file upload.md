# arbitrary file upload

## What it is
Imagine a post office that accepts any package without scanning it — a bomb labeled "birthday gift" gets delivered straight inside. Arbitrary file upload is a vulnerability where a web application allows users to upload files without properly validating type, content, or destination, enabling an attacker to upload malicious files (like a web shell) that the server then executes. The critical failure is when the server treats attacker-supplied files as trusted, executable content.

## Why it matters
In 2021, attackers exploited arbitrary file upload in vulnerable WordPress plugins to upload PHP web shells, gaining persistent remote code execution on thousands of sites. Once a web shell is planted, the attacker can run system commands, pivot laterally, exfiltrate data, and establish backdoors — all through a browser. A single misconfigured upload endpoint can collapse an entire server's security perimeter.

## Key facts
- **Web shells are the primary payload**: PHP, ASP, JSX files uploaded and accessed via URL give the attacker an interactive command interface on the server
- **Bypass techniques include**: changing file extension (`.php` → `.php5`, `.phtml`), manipulating MIME type in the Content-Type header, or appending a null byte (`shell.php%00.jpg`)
- **Defense requires multiple layers**: validate file extension AND magic bytes (file signature), store uploads outside the web root, strip execute permissions, and serve files through a dedicated handler — not directly
- **OWASP categorizes this under A04:2021 (Insecure Design) and A05:2021 (Security Misconfiguration)**, making it highly relevant to security exams
- **Content-Disposition and MIME sniffing** can allow browsers to execute files the server intends as benign, especially without `X-Content-Type-Options: nosniff`

## Related concepts
[[web shell]] [[file inclusion vulnerability]] [[input validation]] [[MIME type spoofing]] [[remote code execution]]