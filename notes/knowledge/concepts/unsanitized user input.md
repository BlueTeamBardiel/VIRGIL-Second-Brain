# unsanitized user input

## What it is
Like a bouncer who lets anyone into the club without checking IDs, unsanitized user input is data accepted from a user and passed directly into backend processes without validation, filtering, or encoding. Any character, command, or payload the attacker types gets treated as trusted and executed. This is the root cause behind entire vulnerability classes — SQL injection, XSS, command injection, and more.

## Why it matters
In 2017, Equifax's breach exposed 147 million records partly because a web application passed unsanitized input into a server-side process without validation, allowing attackers to execute arbitrary commands. Had input been stripped of shell metacharacters and validated against an allowlist, the attack surface would have collapsed. This single failure pattern accounts for the majority of OWASP Top 10 vulnerabilities year after year.

## Key facts
- **Allowlist validation** (only permit known-good characters) is stronger than **denylist validation** (blocking known-bad characters), because attackers constantly find new bypass techniques
- SQL injection, reflected XSS, stored XSS, command injection, path traversal, and LDAP injection are all direct consequences of unsanitized input
- **Input validation** happens at the boundary (checking data type, length, format); **output encoding** happens at the destination (escaping before rendering in HTML, SQL, shell, etc.) — both are required
- Parameterized queries / prepared statements eliminate SQL injection by separating code from data, regardless of what characters the user submits
- Security+ and CySA+ treat improper input handling as a **coding/application vulnerability**, distinct from misconfigurations — remediation is in the software, not the firewall

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Input Validation]] [[Command Injection]] [[OWASP Top 10]]