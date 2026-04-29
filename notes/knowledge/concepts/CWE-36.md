# CWE-36

## What it is
Like a hiker who ignores the "stay on the trail" signs and cuts straight through the forest to reach a restricted area, this vulnerability lets attackers bypass intended directory boundaries. CWE-36 (Absolute Path Traversal) occurs when software uses external input to construct a file path but fails to restrict that path, allowing attackers to supply an absolute path (e.g., `/etc/passwd` or `C:\Windows\System32\config\SAM`) that points entirely outside the intended directory.

## Why it matters
In 2021, attackers exploited absolute path traversal in misconfigured file-download endpoints to retrieve `/etc/shadow` directly from Linux web servers — bypassing the relative-path sanitization that developers had implemented, because it only checked for `../` sequences, not absolute paths starting with `/`. A simple input of `filename=/etc/shadow` sailed straight through the filter. The fix requires validating that the *resolved* canonical path starts with the expected base directory, not just checking the raw input string.

## Key facts
- **Distinct from CWE-22** (relative path traversal using `../`): CWE-36 uses a fully qualified absolute path, bypassing defenses that only strip dot-dot sequences
- The attack string doesn't need `../` — just `/etc/passwd` or `C:\boot.ini` is sufficient
- Common in file download, file inclusion, and log-viewer features that naively pass user input to `open()` or `fopen()`
- **Defense**: canonicalize the path first (`realpath()` in C, `Path.resolve()` in Node.js), then assert it begins with the allowed base directory
- On Windows, attackers can use both `C:\` and UNC paths (`\\server\share`) as absolute path vectors

## Related concepts
[[CWE-22 Path Traversal]] [[Input Validation]] [[Directory Traversal]] [[File Inclusion Vulnerability]] [[Least Privilege]]