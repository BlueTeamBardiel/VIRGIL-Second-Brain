# local file inclusion

## What it is
Imagine a librarian who fetches any book you request by name — and you ask for the staff-only personnel records instead of a novel. Local File Inclusion (LFI) is a web vulnerability where an application uses user-controlled input to load files from the server's own filesystem without proper validation, potentially exposing sensitive files or executing malicious content.

## Why it matters
An attacker targeting a PHP application might manipulate a URL parameter like `?page=../../../../etc/passwd` to read the server's user account list. More dangerously, if the attacker can write to a log file first (a technique called log poisoning), they can inject PHP code into `/var/log/apache2/access.log` and then include that file via LFI to achieve Remote Code Execution — turning a read vulnerability into full shell access.

## Key facts
- LFI occurs when `include()`, `require()`, or similar functions in PHP (and equivalents in other languages) accept unsanitized user input
- The classic traversal payload uses `../` sequences (dot-dot-slash) to escape the intended directory — e.g., `../../../../etc/shadow`
- **Null byte injection** (`%00`) was historically used to truncate file extensions (e.g., `file.php%00`) bypassing extension whitelists — patched in PHP 5.3.4+
- LFI can be escalated to **Remote Code Execution (RCE)** via log poisoning, `/proc/self/environ` injection, or PHP session file inclusion
- Mitigations include input whitelisting (allow-list of valid filenames), disabling `allow_url_include`, and using `realpath()` to canonicalize paths before validation

## Related concepts
[[path traversal]] [[remote file inclusion]] [[remote code execution]]