# path traversal bypass

## What it is
Like a hotel guest who, instead of using the elevator to reach their floor, finds a hidden stairwell that leads them into the basement server room — path traversal bypass is when an attacker manipulates file path inputs to escape the intended directory and access restricted files. Specifically, it involves encoding or mutating `../` sequences (dot-dot-slash) to evade input validation filters and navigate the filesystem hierarchy. The "bypass" element means the attacker defeats a defensive control that was supposed to block basic traversal attempts.

## Why it matters
In 2001, the IIS Unicode vulnerability (CVE-2001-0333) allowed attackers to bypass path traversal protections by encoding `../` as `..%c0%af`, tricking the server into decoding it after validation checks had already passed. This enabled remote command execution on millions of Windows web servers worldwide. Defenders must apply decoding and normalization *before* input validation, not after.

## Key facts
- Common bypass encodings include URL encoding (`%2e%2e%2f`), double URL encoding (`%252e%252e%252f`), and Unicode/UTF-8 variants (`..%c0%af`)
- Filters that only strip `../` once are defeated by nested sequences like `....//` — removing the inner `../` reconstructs the original attack string
- The root cause is **validation before normalization** — input must be canonicalized first, then validated against an allowlist
- On Windows, both `/` and `\` are valid path separators, doubling the bypass surface compared to Unix systems
- OWASP categorizes this under **A01:2021 Broken Access Control**; it maps to CWE-22 (Improper Limitation of a Pathname)

## Related concepts
[[directory traversal]] [[input validation]] [[file inclusion vulnerability]] [[URL encoding]] [[access control]]