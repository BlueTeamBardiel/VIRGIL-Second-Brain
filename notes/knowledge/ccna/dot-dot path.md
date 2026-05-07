# dot-dot path

## What it is
Like a building elevator with no floor restrictions — if you know the button sequence, you can reach floors you were never supposed to access. A dot-dot path (also called a path traversal sequence) uses `../` (or `..\ ` on Windows) to navigate *up* directory levels, allowing an attacker to escape a designated folder and access arbitrary files on the filesystem.

## Why it matters
In 2001, the **Code Red II** worm exploited IIS's failure to sanitize `../` sequences, allowing attackers to traverse outside the web root and execute arbitrary commands via `scripts/../../winnt/system32/cmd.exe`. Proper input validation — canonicalizing paths and rejecting sequences that escape the intended root — would have blocked this class of attack entirely.

## Key facts
- The core sequence is `../` on Unix/Linux and `..\` on Windows; both mean "go up one directory level"
- URL-encoded variants (`%2e%2e%2f`, `%252e%252e%2f` — double encoded) are used to bypass naive string-matching filters
- The vulnerability is categorized as **CWE-22** (Improper Limitation of a Pathname to a Restricted Directory)
- Defense requires **canonicalization** first: resolve the full absolute path *before* checking whether it falls within the allowed directory
- OWASP lists path traversal as a subcategory of **Injection** (A03:2021) — it's an input-validation failure, not a permissions failure

## Related concepts
[[directory traversal]] [[input validation]] [[file inclusion vulnerability]]