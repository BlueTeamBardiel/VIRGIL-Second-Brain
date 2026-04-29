# OWASP Path Traversal

## What it is
Like a hotel guest who, instead of using their room key, starts trying doors in the basement and maintenance corridors by following the "go back one floor" stairwell signs repeatedly — path traversal tricks a web server into serving files outside its intended web root by injecting sequences like `../` into file path inputs. Precisely defined, it is an injection vulnerability where an attacker manipulates file path parameters to access arbitrary files on the server's filesystem, bypassing access controls. It is catalogued as part of OWASP's A01:2021 (Broken Access Control).

## Why it matters
In 2020, attackers exploited path traversal in Pulse Secure VPN (CVE-2019-11510) to read sensitive files including `/etc/passwd` and cached plaintext credentials — without authentication — compromising thousands of enterprise networks. Defenders mitigate this by canonicalizing file paths server-side and comparing the resolved absolute path against an allowed base directory before opening any file.

## Key facts
- The classic payload is `../` (or URL-encoded `%2e%2e%2f`) repeated to climb directory levels toward filesystem root
- Also called "directory traversal" or "dot-dot-slash attack" — all refer to the same vulnerability class
- URL encoding bypasses naive string filters: `%2e%2e%2f` = `../`; double encoding `%252e%252e%252f` bypasses a second layer
- Secure mitigation requires **canonicalization** (resolving symlinks and `..` references via functions like `realpath()`) then validating the result starts with the approved base path
- Common targets include `/etc/passwd`, `web.config`, `.env` files, and application source code — anything readable by the web server process

## Related concepts
[[Directory Indexing]] [[Local File Inclusion (LFI)]] [[OWASP Broken Access Control]] [[Input Validation]] [[Server-Side Request Forgery (SSRF)]]