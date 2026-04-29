# data sanitization

## What it is
Like a chef scrubbing a cutting board used for raw chicken before prepping vegetables, data sanitization strips dangerous characters or structures from user input before the system acts on it. Precisely, it is the process of inspecting, cleaning, or transforming untrusted input to remove or neutralize content that could be interpreted as executable code, commands, or malicious instructions.

## Why it matters
In 2017, Equifax suffered a breach affecting 147 million people partly because their Apache Struts application failed to sanitize user-supplied input, allowing attackers to inject commands through an HTTP header field. Proper sanitization—rejecting or encoding that input—would have interrupted the exploit chain before any code executed on the server.

## Key facts
- **Sanitization ≠ Validation**: Validation checks *if* input is acceptable (whitelist/blacklist); sanitization *transforms* it to make it safe—both layers are necessary.
- **Output context matters**: The same string requires different sanitization depending on destination—HTML output needs HTML encoding, SQL queries need parameterized statements, shell commands need argument escaping.
- **Allowlist over blocklist**: Blocking known-bad characters (blocklist) is fragile; permitting only known-good characters (allowlist) is the stronger, more testable control.
- **Parameterized queries are the gold standard** for SQL sanitization—they separate data from code structurally, not textually, making injection logically impossible.
- **CWE-20 (Improper Input Validation)** consistently ranks in the OWASP Top 10 and MITRE's most dangerous software weaknesses; sanitization directly mitigates SQL injection (CWE-89), XSS (CWE-79), and command injection (CWE-78).

## Related concepts
[[input validation]] [[SQL injection]] [[cross-site scripting]] [[parameterized queries]] [[output encoding]]