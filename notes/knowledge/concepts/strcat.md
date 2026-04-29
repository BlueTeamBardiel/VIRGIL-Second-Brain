# strcat

## What it is
Imagine pouring water from one cup into another without checking if the second cup has room — it overflows onto the table. `strcat` is a C standard library function that appends one string to the end of another, but it performs **no bounds checking**, blindly writing bytes wherever memory sits after the destination buffer.

## Why it matters
The 2003 Slapper worm exploited an OpenSSL vulnerability rooted in unsafe string concatenation — unchecked `strcat`-style operations allowed attackers to overflow heap buffers and achieve remote code execution on Apache servers. Understanding `strcat` teaches defenders exactly where to audit legacy C codebases and why modern replacements exist.

## Key facts
- `strcat(dest, src)` appends `src` to `dest` and adds a null terminator, but trusts the programmer to ensure `dest` has enough space — it won't stop at the buffer boundary
- The safe replacement is `strncat(dest, src, n)`, which limits the number of bytes appended; even safer is `strlcat()` on BSD systems, which guarantees null-termination and returns the intended length
- Misuse enables **stack-based buffer overflows**, potentially overwriting saved return addresses and enabling control-flow hijacking
- MITRE CWE-120 ("Buffer Copy without Checking Size of Input") directly covers `strcat` misuse; it appears on OWASP's list of dangerous C functions to avoid
- Modern compilers (GCC, Clang) with `-D_FORTIFY_SOURCE=2` can replace `strcat` calls with hardened versions that detect overflows at runtime via `__strcat_chk()`

## Related concepts
[[Buffer Overflow]] [[Stack Smashing]] [[CWE-120]] [[Memory-Safe Languages]] [[Address Space Layout Randomization]]