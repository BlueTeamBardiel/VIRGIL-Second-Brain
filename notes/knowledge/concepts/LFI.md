# LFI

## What it is
Imagine a librarian who fetches any book you name — and you ask for the staff-only personnel files instead of the novel you were supposed to request. Local File Inclusion (LFI) is a web vulnerability where an application uses user-supplied input to construct a file path and then reads or executes that file, allowing an attacker to access arbitrary files on the server's local filesystem. It occurs when input is passed to functions like PHP's `include()` or `require()` without proper sanitization.

## Why it matters
In 2021, attackers exploited LFI in misconfigured PHP applications to read `/etc/passwd` and `/proc/self/environ`, then escalated to Remote Code Execution by injecting PHP code into server log files and including those logs — a technique called **log poisoning**. This turned a read-only file disclosure bug into full server compromise, demonstrating why LFI is rarely "just information disclosure."

## Key facts
- **Path traversal sequences** like `../../../etc/passwd` (dot-dot-slash) are the classic LFI payload; URL-encoded variants (`%2e%2e%2f`) bypass naive filters
- LFI can escalate to **Remote Code Execution (RCE)** via log poisoning, PHP session file inclusion, or `/proc/self/fd` abuse
- Common vulnerable PHP functions: `include()`, `require()`, `include_once()`, `require_once()`, `file_get_contents()`
- **Null byte injection** (`%00`) was historically used to truncate file extensions (e.g., `shell.php%00`) — patched in PHP 5.3.4+
- Mitigations include input whitelisting (not blacklisting), disabling `allow_url_include`, and using `realpath()` with strict base-directory checks

## Related concepts
[[Path Traversal]] [[Remote File Inclusion]] [[Remote Code Execution]]