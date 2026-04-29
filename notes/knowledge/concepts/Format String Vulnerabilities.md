# Format String Vulnerabilities

## What it is
Imagine handing a photocopier a document that contains its own operating instructions — and it obeys them. A format string vulnerability occurs when user-supplied input is passed directly as the format argument to functions like `printf()` in C, allowing an attacker to inject format specifiers (`%x`, `%s`, `%n`) that the program executes rather than displays. This lets attackers read arbitrary memory or write values to arbitrary addresses.

## Why it matters
In 2000, the WU-FTPD daemon contained a format string bug that allowed remote attackers to gain root access by sending a malicious filename containing `%n` specifiers, which overwrote memory addresses controlling execution flow. This class of vulnerability was so impactful it drove the adoption of compiler warnings for unsafe `printf` usage and spawned hardened format string checks in modern glibc.

## Key facts
- The `%n` specifier is the most dangerous — it *writes* the number of bytes printed so far into a memory address, enabling attackers to overwrite return addresses or GOT entries
- Vulnerable pattern: `printf(user_input)` — Safe pattern: `printf("%s", user_input)`
- Attackers use `%x` or `%p` specifiers to *read* stack memory, leaking addresses, canaries, or sensitive data
- Unlike buffer overflows, format string attacks can both read and write memory without overflowing a buffer
- Modern mitigations include compiler flag `-Wformat-security`, FORTIFY_SOURCE, and RELRO (Relocation Read-Only) to protect the GOT

## Related concepts
[[Buffer Overflow]] [[Memory Corruption]] [[Address Space Layout Randomization]] [[Stack Canaries]]