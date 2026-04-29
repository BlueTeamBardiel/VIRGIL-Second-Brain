# uploadfile

## What it is
Like a mail slot in a door — convenient for receiving packages, but a thief can also slide in something dangerous. File upload functionality is a web application feature allowing users to submit files to a server, which becomes a critical attack vector when the server fails to validate file type, content, or execution permissions.

## Why it matters
In 2017, attackers exploited unrestricted file upload vulnerabilities in countless CMS platforms by uploading PHP web shells disguised as image files (e.g., `shell.php.jpg`). Once uploaded, navigating directly to the file's URL executed server-side code, granting full remote command execution — turning a profile picture field into a backdoor.

## Key facts
- **MIME type spoofing**: Attackers change the `Content-Type` header to `image/jpeg` while the file contains executable code; servers trusting only MIME headers are trivially bypassed
- **Double extension bypass**: Filenames like `evil.php.jpg` exploit misconfigured servers that parse the first recognized extension rather than the last
- **Magic bytes validation**: Robust defenses check file headers (e.g., JPEG files begin with `FF D8 FF`) rather than relying solely on extensions or MIME types
- **Storage location matters**: Files stored in a web-accessible directory with execute permissions are far more dangerous than those stored outside the web root or in object storage (e.g., S3)
- **OWASP classification**: Unrestricted file upload is a subset of A03:2021 (Injection) and CWE-434; it's a direct path to Remote Code Execution (RCE)

## Related concepts
[[web shell]] [[MIME type]] [[remote code execution]] [[input validation]] [[directory traversal]]