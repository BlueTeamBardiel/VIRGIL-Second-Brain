# PHP Local File Inclusion

## What it is
Imagine a librarian who fetches any book you request by name — including the staff-only backroom files — without ever checking your credentials. PHP Local File Inclusion (LFI) is exactly that: a vulnerability where a PHP application dynamically includes files based on user-supplied input without proper validation, allowing an attacker to force the server to load and execute arbitrary files already present on the local filesystem.

## Why it matters
In a classic LFI attack, an adversary manipulates a URL parameter like `?page=../../../../etc/passwd` to traverse directory boundaries and read sensitive system files. More dangerously, attackers chain LFI with log poisoning — injecting PHP code into Apache access logs via a crafted User-Agent header, then including the log file to achieve Remote Code Execution (RCE), turning a read vulnerability into full shell access.

## Key facts
- **Vulnerable pattern**: `include($_GET['page']);` — any unsanitized user input fed into `include()`, `require()`, `include_once()`, or `require_once()` creates LFI exposure.
- **Directory traversal sequences** (`../`, URL-encoded as `%2e%2e%2f`) are the primary delivery mechanism; null byte injection (`%00`) was historically used to truncate file extensions in PHP < 5.3.4.
- **High-value target files** on Linux systems: `/etc/passwd`, `/etc/shadow`, `/proc/self/environ`, and application config files containing credentials.
- **Log poisoning** (Apache: `/var/log/apache2/access.log`; SSH: `/var/log/auth.log`) escalates LFI to RCE without uploading any file.
- **Mitigations**: whitelist allowable filenames, set `open_basedir` in `php.ini` to restrict filesystem scope, disable `allow_url_include`, and avoid passing user input directly to file-inclusion functions.

## Related concepts
[[Directory Traversal]] [[Remote File Inclusion]] [[Log Poisoning]] [[Path Canonicalization]] [[Remote Code Execution]]