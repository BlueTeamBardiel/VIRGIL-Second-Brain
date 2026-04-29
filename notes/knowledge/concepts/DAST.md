# DAST

## What it is
Like a red team hacker who only sees your application from the outside — no blueprints, no source code — DAST (Dynamic Application Security Testing) probes a *running* application by sending malicious inputs and observing real responses. It tests the live system in real-time, simulating what an external attacker would actually encounter.

## Why it matters
In 2021, attackers exploited an unpatched SQL injection flaw in a healthcare portal that a DAST scanner would have caught during staging — because DAST fires actual SQL payloads and watches for database errors or abnormal response times. Had security teams run automated DAST scans before deployment, the injection point would have returned a tell-tale error revealing the vulnerability before production.

## Key facts
- DAST is **black-box testing** — it requires no access to source code, making it ideal for testing third-party applications and APIs
- Common findings include SQLi, XSS, authentication bypasses, and insecure direct object references (IDOR)
- DAST tools (e.g., OWASP ZAP, Burp Suite) work by **crawling** the application and **fuzzing** inputs with known attack payloads
- Because it tests a running application, DAST can catch **runtime and environment-specific** vulnerabilities that static analysis misses (e.g., misconfigured server headers)
- DAST has a **higher false-positive rate** than SAST for logic flaws but a **lower false-negative rate** for injection vulnerabilities
- In the **SDLC**, DAST fits best in the **testing/staging phase**, after code is deployed but before production release

## Related concepts
[[SAST]] [[IAST]] [[Fuzzing]] [[Penetration Testing]] [[OWASP Top 10]]