# CWE-20 Improper Input Validation

## What it is
Imagine a nightclub bouncer who waves everyone through without checking IDs — the club has a policy, but nobody enforces it at the door. Improper Input Validation occurs when software accepts data from an untrusted source without verifying that it conforms to expected type, length, format, or range before processing it. This failure is the root cause behind entire families of injection and overflow vulnerabilities.

## Why it matters
In 2017, the Apache Struts vulnerability (CVE-2017-5638) that led to the Equifax breach exploited improper validation of the `Content-Type` HTTP header — attackers injected an OGNL expression that the server executed directly. A single unvalidated header field exposed 147 million Americans' personal records. Had the input been validated against an allowlist of acceptable MIME types, the exploit chain would have broken immediately.

## Key facts
- CWE-20 is the **parent weakness** for many child CWEs including SQL Injection (CWE-89), Command Injection (CWE-78), and Buffer Overflow (CWE-120)
- **Allowlist (whitelist) validation** is the preferred defense — explicitly define what IS acceptable, rather than trying to block known bad input (denylist)
- Input should be validated for **all four properties**: type, length/size, format/syntax, and value range
- Validation must occur **server-side**; client-side validation alone is trivially bypassed using tools like Burp Suite
- CWE-20 consistently appears in the **OWASP Top 10** under A03 (Injection) and is ranked in MITRE's Top 25 Most Dangerous Software Weaknesses

## Related concepts
[[SQL Injection (CWE-89)]] [[Buffer Overflow]] [[Input Sanitization vs Validation]] [[Allowlist Filtering]] [[OWASP Top 10]]