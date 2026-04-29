# file upload

## What it is
Like a mailroom that accepts packages without checking if they contain explosives, a file upload feature accepts user-supplied files without verifying their true nature. Precisely, it is a web application functionality that allows users to transfer files to a server — and becomes a critical attack surface when the server fails to validate file type, content, size, or destination path. Attackers exploit this to plant malicious code directly onto target infrastructure.

## Why it matters
In 2017, attackers exploited an unrestricted file upload vulnerability in a healthcare portal to upload a PHP web shell disguised with a `.jpg` extension; once uploaded, they browsed to the file's URL and executed arbitrary OS commands, achieving full server compromise. Defenders counter this by validating MIME type server-side (not just the extension), storing uploads outside the web root, and stripping executable permissions from upload directories.

## Key facts
- **Extension spoofing**: Renaming `shell.php` to `shell.php.jpg` bypasses naive extension-only filters on misconfigured servers
- **MIME type confusion**: Browsers and servers can be fooled by manipulating the `Content-Type` header; true validation requires **magic byte** (file signature) inspection
- **Web shell delivery**: Successful exploitation typically results in a web shell — a remote code execution backdoor accessible via HTTP
- **Stored vs. reflected impact**: Unlike XSS, malicious uploads persist on disk and can be triggered repeatedly, making them a persistent threat
- **Defense in depth**: OWASP recommends randomizing uploaded filenames, enforcing allowlists (not blocklists), and using a dedicated object store (e.g., S3) isolated from the application server

## Related concepts
[[web shell]] [[input validation]] [[MIME type]] [[unrestricted file upload]] [[remote code execution]]