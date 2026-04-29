# null byte injection

## What it is
Imagine slipping a "stop reading here" sticky note into the middle of a library catalog card — the librarian halts, but the shelf-stacking robot behind her ignores it and keeps going. A null byte (`%00` or `\x00`) is the ASCII character with value zero, and in C-based systems it terminates strings; injecting it exploits the mismatch between how a high-level language (like PHP) and the underlying C runtime interpret where a string ends.

## Why it matters
Classic PHP file inclusion vulnerabilities used null byte injection to bypass extension filters: if an app appended `.php` to user input before opening a file, an attacker could request `../../../../etc/passwd%00` — the C `fopen()` call would stop at the null byte, opening `/etc/passwd` while PHP's validation layer never saw the stripped extension. This was patched in PHP 5.3.4, but the same pattern resurfaces in any language that passes user-controlled strings to C libraries or OS calls.

## Key facts
- The null byte (`0x00`) is a **string terminator in C**; languages built on C runtimes are vulnerable when they pass unsanitized input to underlying system calls.
- URL-encoded form is `%00`; in raw input it appears as `\x00` or a literal zero byte.
- **PHP versions < 5.3.4** are textbook examples; the vulnerability class persists in native extensions and custom C bindings even in modern languages.
- Defense: validate and sanitize input **before** passing to OS/file functions; use `strlen()` checks in C; reject strings containing null bytes at input boundaries.
- Appears on Security+/CySA+ under **injection attacks** and **improper input validation** (CWE-158: Improper Neutralization of Null Byte).

## Related concepts
[[path traversal]] [[file inclusion vulnerability]] [[input validation]] [[injection attacks]] [[CWE-20]]