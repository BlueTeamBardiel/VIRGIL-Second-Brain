# CodeAstro Simple Attendance Management System v1.0

## What it is
Like leaving a master key under the doormat of a school office, this PHP-based web application ships with multiple unpatched vulnerabilities baked directly into its v1.0 release. CodeAstro Simple Attendance Management System is a freely distributed open-source attendance tracking application that contains documented SQL injection and Cross-Site Scripting (XSS) vulnerabilities in its default state.

## Why it matters
In 2023, security researchers published CVEs against this application demonstrating that an unauthenticated attacker could craft a malicious login request, bypass authentication entirely via SQL injection in the login parameter, and gain administrative access to all student and staff attendance records. This mirrors real-world scenarios where schools and small organizations deploy unvetted open-source software without patch validation, exposing sensitive personal data to trivial exploitation.

## Key facts
- **CVE-2023-46477** and related CVEs document stored XSS vulnerabilities allowing persistent script injection through attendance record fields
- SQL injection vulnerabilities exist in the login form, enabling authentication bypass using classic payloads like `' OR '1'='1`
- The application fails to implement **prepared statements** or **parameterized queries**, the primary defense against SQL injection
- Stored XSS in this system persists in the database and executes for every user who views the attendance report — multiplying the attack surface
- Classified under **CWE-89** (SQL Injection) and **CWE-79** (Improper Neutralization of Input During Web Page Generation)

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Authentication Bypass]] [[CVE]] [[Input Validation]]