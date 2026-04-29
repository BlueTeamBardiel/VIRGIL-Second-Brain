# path traversal

## What it is
Imagine a hotel guest who, instead of going to their assigned room, follows the stairwell signs backwards — "up two floors, left, left, down three floors" — and ends up in the manager's private office. Path traversal works the same way: an attacker manipulates file path inputs using sequences like `../` ("dot-dot-slash") to climb out of the intended directory and access restricted files on the server's filesystem.

## Why it matters
In 2021, attackers exploited a path traversal vulnerability in Accellion's file-transfer appliance to read sensitive files outside the web root, leading to data theft at dozens of organizations including law firms and universities. A properly configured application would sanitize or canonicalize input paths and jail file access within a defined root directory, stopping the traversal cold.

## Key facts
- The classic payload is `../` repeated to climb directory levels (e.g., `../../../../etc/passwd` on Linux systems).
- URL-encoded variants (`%2e%2e%2f`) and double-encoded variants (`%252e%252e%252f`) are used to bypass naive input filters.
- CVE scoring frequently rates these as High/Critical because successful exploitation can expose credentials, config files, or private keys without authentication.
- Mitigation requires **canonicalization** — resolving the full absolute path before checking it against an allowlist — not just blacklisting `../` strings.
- Mapped to **OWASP A01:2021 (Broken Access Control)** and tested under **CWE-22 (Improper Limitation of a Pathname)**.

## Related concepts
[[directory traversal]] [[file inclusion]] [[input validation]] [[access control]] [[OWASP Top 10]]