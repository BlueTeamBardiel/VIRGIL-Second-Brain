# Arbitrary File Read

## What it is
Imagine a librarian who hands you any book in the archive — including the locked back room — just because you asked politely with a specific title. Arbitrary File Read is a vulnerability that allows an attacker to read files outside the intended scope of an application by manipulating user-controlled input (such as a filename parameter) to reference arbitrary paths on the server's filesystem. No code execution is required — just unauthorized disclosure of sensitive data.

## Why it matters
In 2021, attackers exploited an Arbitrary File Read in Pulse Secure VPN by sending a crafted URI containing path traversal sequences (`../`) to retrieve `/etc/passwd` and cached plaintext credentials — leading directly to network compromise without authentication. Defenders should sanitize all file path inputs, enforce allowlists over blocklists, and use chroot jails or containerization to limit what files an application can physically reach.

## Key facts
- **Path traversal is the most common delivery mechanism**: sequences like `../../../../etc/shadow` escape the web root by climbing directory levels.
- **Common targets**: `/etc/passwd`, `/etc/shadow`, SSH private keys (`~/.ssh/id_rsa`), application config files with database credentials, and AWS metadata endpoint responses stored in temp files.
- **XXE (XML External Entity) injection** is a frequent server-side vector for triggering Arbitrary File Read through XML parsers that resolve external file references.
- **Server-Side Template Injection (SSTI)** and **Local File Inclusion (LFI)** are closely related — LFI specifically triggers file read through PHP `include()`-style functions and can escalate to Remote Code Execution via log poisoning.
- On Windows, the equivalent targets include `C:\Windows\win.ini` and `C:\Windows\System32\drivers\etc\hosts`, often used as proof-of-concept in bug bounties.

## Related concepts
[[Path Traversal]] [[Local File Inclusion]] [[XML External Entity Injection]] [[Server-Side Request Forgery]] [[Information Disclosure]]