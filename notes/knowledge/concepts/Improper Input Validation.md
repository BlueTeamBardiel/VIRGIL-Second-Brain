# improper input validation

## What it is
Imagine a bouncer who waves everyone into the club without checking IDs — that's a program accepting any data a user submits without verifying it first. Improper input validation occurs when an application fails to check that data received from users (or external systems) conforms to expected type, length, format, or range before processing it. This single failure class is the root cause of SQL injection, buffer overflows, XSS, and dozens of other vulnerability families.

## Why it matters
In 2017, the Equifax breach exposed 147 million records partly because an Apache Struts vulnerability allowed attackers to inject malicious serialized objects through an unvalidated HTTP header field. Had the application enforced strict input constraints on that parameter, the exploit payload would have been rejected before reaching the vulnerable code path. This illustrates how input validation is a primary defense layer, not just a coding hygiene suggestion.

## Key facts
- Listed as **CWE-20** (Improper Input Validation) and consistently ranks in OWASP Top 10 under "Injection" and "Security Misconfiguration" categories
- **Allowlist (whitelist) validation** is preferred over denylist (blacklist) because attackers can craft inputs that bypass known bad patterns
- Validation must occur **server-side**; client-side validation alone (JavaScript) is trivially bypassed with a proxy tool like Burp Suite
- Failure to validate **length** leads to buffer overflows; failure to validate **type/format** leads to injection attacks; failure to validate **range** leads to business logic abuse
- The fix includes input validation, **output encoding**, and parameterized queries working together — validation alone is not sufficient

## Related concepts
[[SQL injection]] [[cross-site scripting]] [[buffer overflow]] [[output encoding]] [[allowlist validation]]