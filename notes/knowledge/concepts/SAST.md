# SAST

## What it is
Like a grammar checker that reads your essay *before* you submit it, SAST scans source code, bytecode, or binaries for vulnerabilities without ever executing the program. Static Application Security Testing analyzes code at rest — examining logic, data flows, and patterns — to catch flaws like SQL injection, buffer overflows, and hardcoded credentials during development, not after deployment.

## Why it matters
In 2021, researchers found hardcoded AWS credentials in thousands of mobile app repositories — secrets that a SAST tool scanning pre-commit code would have flagged immediately. Catching this at the developer's workstation costs pennies to fix; catching it after breach costs millions. SAST is the "shift-left" control that moves security feedback to where code is actually written.

## Key facts
- SAST is a **white-box testing** technique — it requires access to source code or compiled artifacts, unlike DAST which tests running applications
- Primary weakness is **false positives** — SAST tools frequently flag non-exploitable code paths, requiring analyst triage to prioritize real findings
- SAST integrates into **CI/CD pipelines** (e.g., GitHub Actions, Jenkins) to automatically block pull requests containing vulnerable patterns
- Common findings include: SQL injection, XSS, insecure deserialization, hardcoded secrets, and path traversal vulnerabilities
- **Cannot detect runtime or environment-specific vulnerabilities** (e.g., misconfigured server permissions, race conditions under load) — that's DAST/IAST territory

## Related concepts
[[DAST]] [[IAST]] [[Software Development Life Cycle]] [[CI/CD Pipeline Security]] [[Code Review]]