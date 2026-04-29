# null byte

## What it is
Think of a null byte as a period that some programs treat as "end of sentence" while others read right past it — the same character, two completely different interpretations. Precisely, a null byte is the character represented by `\x00` (ASCII/Unicode value 0), which in C-based languages signals the termination of a string, but many web frameworks and higher-level languages treat it as ordinary data.

## Why it matters
A classic null byte injection attack targets file inclusion functions: an attacker appends `%00` (URL-encoded null byte) to a filename like `../../etc/passwd%00.jpg`, causing a C-based backend function to stop reading at `\x00` and open `/etc/passwd` while the application's extension whitelist check sees `.jpg` and approves it. This technique was widespread in PHP before version 5.3.4 fixed null byte handling in file functions. Modern defenses include input sanitization that strips or rejects null bytes and using language-native file handling rather than raw C library calls.

## Key facts
- Null byte is `\x00`, decimal 0, URL-encoded as `%00` — three representations to recognize
- C strings are null-terminated by design; null bytes in other languages (Python, Java) are just another character, creating interpreter discrepancy vulnerabilities
- Null byte injection is classified under **CWE-626** (Null Byte Interaction Error)
- Can bypass extension filters, truncate log entries (hiding injected commands), and corrupt binary parsing
- Patched in PHP 5.3.4 (2010); legacy systems running older PHP remain vulnerable — a common exam context
- OWASP lists null byte injection as a subset of input validation failures (formerly A1 in older Top 10 frameworks)

## Related concepts
[[input validation]] [[path traversal]] [[file inclusion vulnerability]] [[injection attacks]]