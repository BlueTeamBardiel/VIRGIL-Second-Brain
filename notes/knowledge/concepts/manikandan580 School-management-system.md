# manikandan580 School-management-system

## What it is
Like a master key hidden under a school's front doormat, a vulnerable school management system exposes every classroom, record, and office to anyone who knows where to look. The `manikandan580/School-management-system` is a PHP-based open-source web application for managing students, teachers, and administrative records — documented to contain multiple critical vulnerabilities including SQL injection and Cross-Site Scripting (XSS).

## Why it matters
Attackers targeting under-resourced educational institutions frequently exploit vulnerable off-the-shelf school management software to exfiltrate student PII (names, grades, guardian contacts) and staff credentials. In a real scenario, an unauthenticated attacker could craft a malicious SQL payload in a login field (`' OR '1'='1`), bypass authentication entirely, and dump the entire student database — triggering FERPA violation liability for the institution.

## Key facts
- Contains **unauthenticated SQL injection** vulnerabilities in login and search parameters, allowing full database compromise without valid credentials
- Susceptible to **stored XSS**, meaning malicious scripts injected into student name fields execute in administrators' browsers on every page load
- Built on PHP without **prepared statements** or parameterized queries — the root cause of its SQL injection exposure (relevant to CWE-89)
- Classified under **CVE-documented educational software vulnerabilities**; schools using unpatched forks remain exposed in real deployments
- Demonstrates the danger of **trusting user-supplied input** directly into database queries — a foundational failure addressed by OWASP Top 10 A03:2021 (Injection)

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[OWASP Top 10]] [[Parameterized Queries]] [[CWE-89]]