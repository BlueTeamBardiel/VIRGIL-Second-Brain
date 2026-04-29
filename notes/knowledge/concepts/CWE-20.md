# CWE-20

## What it is
Like a nightclub bouncer who waves everyone through without checking IDs, improper input validation means an application accepts data without verifying it meets expected format, type, length, or range. Precisely: CWE-20 occurs when software fails to validate or incorrectly validates input, allowing attackers to craft malicious data that alters program logic, corrupts memory, or manipulates backend systems.

## Why it matters
In 2017, the Equifax breach stemmed from Apache Struts failing to properly validate a Content-Type header — malformed input triggered remote code execution, exposing 147 million records. Had the application rejected input that didn't conform to expected MIME type values, the attack surface disappears entirely. Input validation is the first gate; everything downstream depends on it holding.

## Key facts
- CWE-20 is the **root cause** of dozens of child vulnerabilities: SQL injection (CWE-89), XSS (CWE-79), buffer overflows (CWE-119), and path traversal (CWE-22) all share improper validation as their ancestor
- **Allowlist validation** (only permit known-good values) is stronger than **denylist validation** (block known-bad values) — attackers routinely bypass denylists with encoding tricks
- Validation must occur **server-side**; client-side validation (JavaScript) is trivially bypassed with Burp Suite or browser dev tools
- CWE-20 consistently appears in MITRE's **CWE Top 25 Most Dangerous Software Weaknesses** — ranked #6 in the 2023 list
- Mitigation involves validating **type, length, format, and range** before any processing — not just stripping special characters after the fact

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting]] [[Buffer Overflow]] [[Input Sanitization]] [[Defense in Depth]]