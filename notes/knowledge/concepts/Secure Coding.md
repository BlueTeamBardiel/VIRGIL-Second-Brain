# secure coding

## What it is
Like a surgeon who scrubs in before operating — not because they're already dirty, but because preventing contamination is cheaper than treating infection — secure coding bakes security into software during construction rather than patching it afterward. It is the practice of writing source code that is resistant to exploitation by following established guidelines that prevent common vulnerability classes like injection, buffer overflows, and broken authentication.

## Why it matters
In 2017, Equifax suffered a breach exposing 147 million records because developers failed to sanitize input and left Apache Struts unpatched — a textbook failure of secure coding discipline. Had developers validated and parameterized database inputs and maintained a dependency review process, the SQL injection and deserialization vulnerabilities would have had no foothold. This single coding culture failure cost over $575 million in settlements.

## Key facts
- **Input validation** is the #1 defensive control — never trust user-supplied data; validate type, length, format, and range on the server side
- **OWASP Top 10** is the canonical reference for secure coding threats, covering injection, broken access control, cryptographic failures, and more — memorize it for CySA+
- **Parameterized queries (prepared statements)** eliminate SQL injection by separating code from data, making attacker-supplied strings inert
- **Least privilege in code**: functions and services should request only the permissions they need; over-privileged code turns bugs into breaches
- **Static Application Security Testing (SAST)** analyzes source code before execution to catch vulnerabilities at commit time, part of a shift-left security strategy

## Related concepts
[[input validation]] [[OWASP Top 10]] [[SQL injection]] [[buffer overflow]] [[static analysis]]