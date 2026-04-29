# CWE-22

## What it is
Like a hotel guest who asks for room "../../manager/safe" instead of their assigned room number, path traversal tricks an application into stepping outside its intended directory. Precisely: CWE-22 (Improper Limitation of a Pathname to a Restricted Directory) occurs when user-supplied input is used to construct a file path without properly neutralizing sequences like `../` that can escape the intended root directory.

## Why it matters
In 2021, attackers exploited a path traversal vulnerability in Accellion FTA (CVE-2021-20090) to read sensitive configuration files containing credentials — bypassing authentication entirely. Had the application canonicalized paths and validated they remained within the designated document root, the attack chain would have been severed at the first step.

## Key facts
- The classic payload is `../` (dot-dot-slash) sequences, URL-encoded variants like `%2e%2e%2f`, or double-encoded forms like `%252e%252e%252f` to bypass naive filters
- Mitigations include: canonicalizing the resolved path (e.g., `realpath()`) and verifying it still starts with the allowed base directory *before* opening any file
- Path traversal is distinct from directory listing — traversal moves *outside* the web root; directory listing merely exposes contents *inside* it
- OWASP ranks it in the Top 10 under A01:2021 (Broken Access Control); it also appears in CWE Top 25 Most Dangerous Software Weaknesses
- Zip Slip is a related variant where malicious archive entries use `../` paths to overwrite arbitrary files during extraction

## Related concepts
[[Directory Traversal]] [[Input Validation]] [[CWE-36 Absolute Path Traversal]] [[Zip Slip]] [[Access Control]]