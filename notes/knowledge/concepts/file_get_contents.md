# file_get_contents

## What it is
Like a postal worker who fetches any letter from any address you hand them — local mailbox or overseas — PHP's `file_get_contents()` reads the entire contents of a file or URL into a string. It accepts both local filesystem paths and remote HTTP/HTTPS URLs, making it a powerful but dangerous one-liner for retrieving data.

## Why it matters
When developers pass user-controlled input directly into `file_get_contents()`, attackers can exploit it to perform **Server-Side Request Forgery (SSRF)**. For example, an attacker submits `http://169.254.169.254/latest/meta-data/` as the URL parameter, and the vulnerable server dutifully fetches AWS EC2 instance metadata — including IAM credentials — on the attacker's behalf. This exact attack pattern was central to the 2019 Capital One breach.

## Key facts
- **SSRF vector**: `file_get_contents($_GET['url'])` is a textbook SSRF vulnerability; no sanitization means the server becomes a proxy for internal network requests
- **Local File Inclusion (LFI)**: When used with filesystem paths, unsanitized input like `../../etc/passwd` enables directory traversal and sensitive file disclosure
- **PHP wrappers amplify risk**: Attackers can use PHP stream wrappers (`php://filter`, `expect://`, `file://`) to encode output, read source code, or execute commands through this function
- **`allow_url_fopen` dependency**: Remote URL fetching only works when `allow_url_fopen = On` in `php.ini` — disabling it blocks remote requests but not local path attacks
- **Defense**: Validate and whitelist URLs against an allowlist, block internal RFC 1918 address ranges, and prefer `cURL` with explicit option hardening for remote fetches

## Related concepts
[[Server-Side Request Forgery]] [[Local File Inclusion]] [[PHP Stream Wrappers]]