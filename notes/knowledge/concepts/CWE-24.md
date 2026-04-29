# CWE-24

## What it is
Like a hiker who steps off the marked trail by walking "up two levels" past the trailhead into restricted wilderness, this vulnerability lets an attacker traverse outside the intended directory. CWE-24 (Path Traversal: '../filedir') occurs when user-supplied input containing `../` sequences is not sanitized, allowing file system navigation above the application's root directory. It is a specific variant of path traversal where the literal string `../filedir` pattern is the attack vector.

## Why it matters
In 2021, attackers exploited path traversal in Accellion FTA servers using `../` sequences to reach configuration files containing credentials outside the web root — leading to data theft affecting dozens of organizations including government agencies. A properly configured web application should canonicalize file paths and validate that the resolved absolute path still begins with the intended base directory before opening any file.

## Key facts
- The canonical payload pattern is `../../../../etc/passwd` — each `../` moves one directory level up toward the filesystem root
- Vulnerable code often uses user input directly in `open()`, `fopen()`, or `include()` calls without stripping traversal sequences
- Blacklist filtering (blocking `../`) is insufficient — attackers bypass it with URL encoding (`%2e%2e%2f`), double encoding (`%252e%252e%252f`), or mixed slashes (`..\/`)
- The secure fix is **canonicalization + prefix check**: resolve the full absolute path, then assert it starts with the allowed base directory string
- CWE-24 is a child of CWE-22 (Improper Limitation of a Pathname to a Restricted Directory), which is the broader path traversal category

## Related concepts
[[CWE-22 Path Traversal]] [[CWE-23 Relative Path Traversal]] [[Input Validation]] [[Directory Traversal Attack]] [[File Inclusion Vulnerability]]