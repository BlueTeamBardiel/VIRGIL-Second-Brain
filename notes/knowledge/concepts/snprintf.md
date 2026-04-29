# snprintf

## What it is
Like a bartender who only fills your glass to the brim and stops — no overflow, no mess — `snprintf` is the size-aware version of `sprintf` that writes formatted output to a buffer but stops at a specified maximum number of bytes, including the null terminator. It is a C standard library function with signature `int snprintf(char *buf, size_t n, const char *format, ...)` that prevents writes beyond the declared boundary.

## Why it matters
The classic `sprintf` function was a primary enabler of stack-based buffer overflow attacks — an attacker supplies a long format string or argument, the buffer overflows, and return addresses get overwritten with shellcode. Replacing `sprintf` with `snprintf` (and verifying its return value) is a foundational defensive coding practice; the 2003 OpenSSH vulnerability CVE-2003-0693 involved unsafe string functions that `snprintf` would have constrained.

## Key facts
- `snprintf` returns the number of characters that *would have been written* if the buffer were large enough — a return value ≥ `n` means truncation occurred, which itself can be a logic vulnerability if unchecked.
- Unlike `strncpy`, `snprintf` **always** null-terminates the output (when `n > 0`), making it more predictable for safe string handling.
- The `n` parameter counts the **null terminator**, so a buffer of size 8 safely holds only 7 printable characters.
- Format string vulnerabilities (`%x`, `%n` exploitation) can still occur with `snprintf` if the format string itself is attacker-controlled — size limiting does not sanitize format specifiers.
- OWASP and CERT C Secure Coding Standard (STR07-C) explicitly recommend `snprintf` over `sprintf` as a mitigation for CWE-121 (Stack-based Buffer Overflow).

## Related concepts
[[Buffer Overflow]] [[Format String Vulnerability]] [[Stack Smashing Protection]] [[Input Validation]] [[Memory Safety]]