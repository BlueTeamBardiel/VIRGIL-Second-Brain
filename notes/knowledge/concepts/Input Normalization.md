# Input Normalization

## What it is
Like a customs agent who converts all foreign currencies to dollars before checking if a payment is valid, input normalization converts data into a standard, canonical form before security checks are applied. Precisely, it is the process of transforming user-supplied input into a consistent representation — resolving encodings, character substitutions, and path aliases — so that validation logic sees a single, unambiguous form. Without it, security filters evaluate one representation while the application processes another.

## Why it matters
The IIS Unicode Directory Traversal vulnerability (CVE-2000-0884) is the textbook case: attackers bypassed path restrictions by encoding `../` as `..%c0%af`, which the security check failed to recognize but IIS decoded and executed. The server normalized the input *after* the security check, not before, allowing attackers to traverse directories and execute arbitrary commands. Normalizing first — then validating — would have collapsed both forms to the same string before the check ran.

## Key facts
- **Double encoding attacks** (e.g., `%252e%252e%252f` decoding twice to `../`) exploit applications that normalize only once; normalization must be applied iteratively until the output is stable.
- **Canonicalization** is the specific term for resolving a path or identifier to its simplest, authoritative form — `C:\folder\..\secret` becomes `C:\secret`.
- Failure to normalize before validation is classified as a **CWE-20 (Improper Input Validation)** and underlies many path traversal and filter-bypass vulnerabilities.
- Unicode normalization forms (NFC, NFD, NFKC, NFKD) matter for security — different forms of the same character can bypass regex filters checking for malicious strings.
- OWASP recommends a **"normalize, then validate, then use"** sequence as the correct order of operations for all untrusted input.

## Related concepts
[[Input Validation]] [[Path Traversal]] [[Canonicalization Attack]] [[Encoding Attacks]] [[Injection Vulnerabilities]]