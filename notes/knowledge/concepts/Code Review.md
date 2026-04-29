# Code Review

## What it is
Like a surgeon scrubbing in to inspect another surgeon's stitches before the patient is closed up, code review is a systematic examination of source code by someone other than its author to catch defects before they ship. Precisely: it is a manual or automated process where developers (or security analysts) inspect code for vulnerabilities, logic errors, and deviations from secure coding standards prior to deployment.

## Why it matters
The 2017 Equifax breach stemmed from an unpatched Apache Struts vulnerability — but the *application-level* input handling that made exploitation catastrophic could have been caught during a security-focused code review. A reviewer scanning for improper deserialization or missing input validation before production would have dramatically reduced the blast radius, potentially preventing the exposure of 147 million records.

## Key facts
- **SAST (Static Application Security Testing)** automates code review by analyzing source code without executing it — tools like Bandit (Python) or SonarQube flag issues like SQL injection sinks and hardcoded credentials
- Code review is a primary defense against **CWE Top 25** weaknesses including buffer overflows, injection flaws, and use-after-free errors
- **Peer review** (four-eyes principle) is a compensating control for insider threat — no single developer can unilaterally introduce malicious code undetected
- Security-focused code review explicitly checks for **OWASP Top 10** categories: broken access control, cryptographic failures, and injection are most commonly missed
- On CySA+/Security+ exams, code review is classified under **proactive/preventive controls** and falls within the **SDLC (Software Development Life Cycle)** security phase

## Related concepts
[[Static Application Security Testing]] [[OWASP Top 10]] [[Secure SDLC]] [[Input Validation]] [[Threat Modeling]]