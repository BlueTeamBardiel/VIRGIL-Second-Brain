# Secure Coding Practices

## What it is
Like a surgeon who scrubs hands, uses sterile tools, and follows a checklist *before* cutting — not after the patient gets infected — secure coding means building safety into software during development, not patching it in afterward. It is a set of disciplined development practices that prevent common vulnerabilities (injection flaws, buffer overflows, broken authentication) from entering codebases in the first place.

## Why it matters
In 2017, Equifax exposed 147 million records because developers failed to validate and patch a deserialization vulnerability in Apache Struts (CVE-2017-5638) — a flaw that secure coding review and dependency management would have caught before deployment. Had developers applied input validation and maintained a software bill of materials (SBOM), attackers would have had no exploit surface to leverage.

## Key facts
- **Input validation** must occur server-side; client-side validation alone is trivially bypassed and is not a security control
- **Parameterized queries / prepared statements** are the primary defense against SQL injection — string concatenation of user input into SQL is never acceptable
- **Least privilege** applied to code means functions and services request only the permissions they need; a compromised module then has limited blast radius
- **OWASP Top 10** is the industry-standard reference list of critical web application security risks, directly referenced in Security+ and CySA+ objectives
- **Static Application Security Testing (SAST)** analyzes source code for vulnerabilities without executing it; **Dynamic Application Security Testing (DAST)** tests running applications — both are part of a secure SDLC

## Related concepts
[[OWASP Top 10]] [[Input Validation]] [[SQL Injection]] [[Buffer Overflow]] [[Software Development Life Cycle (SDLC)]] [[Static Application Security Testing]]