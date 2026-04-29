# CWE-434 Insecure File Upload

## What it is
Imagine a hospital mailroom that accepts any package without scanning it — someone ships in a box of grenades labeled "birthday cake." CWE-434 is the same failure in software: an application accepts file uploads without properly validating type, content, or destination, allowing attackers to upload and potentially execute malicious files on the server.

## Why it matters
In 2017, attackers exploited insecure file upload in a healthcare portal by uploading a PHP web shell disguised as a profile picture. The server executed it, granting full remote code execution and exposing 50,000 patient records. The defense was straightforward: store uploads outside the web root and never trust the client-supplied MIME type or file extension.

## Key facts
- **Extension validation alone is insufficient** — attackers rename `shell.php` to `shell.php.jpg`; servers misconfigured with double-extension parsing execute it anyway (Apache vulnerability CVE-2011-3368 pattern)
- **Content-type headers are attacker-controlled** — always validate file content server-side using magic bytes (file signatures), not the `Content-Type` HTTP header
- **Upload storage location is critical** — files stored inside the web root can be directly requested via URL; storing uploads outside the web root or in a CDN removes direct execution risk
- **Polyglot files** combine a valid image with embedded malicious code — a valid JPEG that is simultaneously valid PHP will pass naive image checks but execute if the server processes it as PHP
- **CWE-434 is distinct from CWE-22** (Path Traversal) but both often appear together when upload paths are manipulated

## Related concepts
[[Web Shell Attack]] [[MIME Type Validation]] [[Path Traversal CWE-22]] [[Unrestricted File Upload OWASP]] [[Magic Bytes File Signature Analysis]]