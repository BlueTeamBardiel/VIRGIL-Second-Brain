# PHP

## What it is
Think of PHP as a waiter who reads your order (the URL), runs back to the kitchen (the server), and returns with a freshly cooked HTML page — unlike a static menu that never changes. PHP (Hypertext Preprocessor) is a server-side scripting language embedded in HTML, executed on the web server before the response is sent to the client's browser.

## Why it matters
PHP powers roughly 77% of server-side websites, making it a prime attack surface. A classic scenario: an attacker exploits a poorly written PHP file upload function, uploading a **web shell** (e.g., `shell.php`) that executes arbitrary OS commands through the browser — achieving Remote Code Execution (RCE) with no credentials required. This exact technique was used in numerous WordPress and Joomla breaches.

## Key facts
- **Remote File Inclusion (RFI)** and **Local File Inclusion (LFI)** are PHP-specific vulnerabilities where unsanitized `include()` or `require()` calls allow attackers to execute malicious files
- `$_GET`, `$_POST`, and `$_REQUEST` are user-controlled input superglobals — the most common injection entry points
- **`eval()`** and **`system()`** functions are dangerous sinks; user input reaching these functions typically results in RCE
- PHP configuration file `php.ini` controls security-critical settings: `allow_url_include`, `display_errors`, and `open_basedir` restrictions
- **Type juggling vulnerabilities** occur because PHP loosely compares values (e.g., `"0e123" == "0e456"` evaluates TRUE), enabling authentication bypasses

## Related concepts
[[Web Application Vulnerabilities]] [[Remote Code Execution]] [[File Inclusion Attack]] [[SQL Injection]] [[Web Shell]]