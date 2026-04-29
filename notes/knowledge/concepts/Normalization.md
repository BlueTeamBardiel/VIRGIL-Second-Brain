# Normalization

## What it is
Like a bouncer who checks every ID in the same format before letting anyone in, normalization converts varied data representations into a single, consistent form before processing. Precisely: normalization is the process of transforming input data into a canonical (standard) representation to ensure consistent interpretation and comparison. It strips away encoding tricks, alternate character sets, or redundant syntax that could confuse security controls.

## Why it matters
Attackers exploit normalization failures to bypass input validation — a classic example is path traversal using `..%2F..%2F` (URL-encoded slashes) to escape a web root directory. If the application checks for `../` but decodes `%2F` only *after* the security check, the malicious path slips through undetected. Double encoding attacks (e.g., `%252F` decoding to `%2F` then to `/`) exploit systems that normalize only once instead of iteratively until stable.

## Key facts
- **Double encoding bypass**: `%252F` → `%2F` → `/`; systems that decode only once miss the final dangerous form
- **Unicode normalization attacks**: equivalent Unicode characters (e.g., fullwidth `/` U+FF0F) can bypass filters that only block ASCII variants
- **Canonical path normalization**: web servers and file systems should resolve symbolic links and `../` sequences *before* applying access control checks
- **SQL context**: normalization in databases (1NF, 2NF, 3NF) reduces redundancy, indirectly reducing injection surface by enforcing structured schemas
- **Security+ relevance**: input validation failures, including normalization bypasses, fall under the **improper input handling** vulnerability class — a top OWASP category

## Related concepts
[[Input Validation]] [[Path Traversal]] [[Encoding and Obfuscation]] [[SQL Injection]] [[Cross-Site Scripting (XSS)]]