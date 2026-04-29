# Static code analyzers

## What it is
Like a spell-checker that also flags grammatically correct sentences that *mean* something dangerous, a static code analyzer examines source code or compiled binaries without executing them, hunting for security flaws in structure and logic. It identifies vulnerabilities such as buffer overflows, SQL injection sinks, hardcoded credentials, and insecure function calls by parsing the codebase against rule libraries — all before a single line runs in production.

## Why it matters
In 2021, the Log4Shell vulnerability existed in Log4j's source code for years before exploitation. Organizations with static analysis integrated into their CI/CD pipelines — using tools like Semgrep or Checkmarx — could have flagged the dangerous JNDI lookup pattern during code review, potentially catching it before it ever shipped. This is why static analysis is a cornerstone of **shift-left security**: finding bugs when they're cheapest to fix.

## Key facts
- Static analysis occurs **without code execution** (contrast with dynamic analysis/fuzzing, which requires a running program)
- Common tools include **Bandit** (Python), **SonarQube** (multi-language), **Checkmarx**, **Fortify**, and **Semgrep**
- Produces **false positives** — flagging safe code as dangerous — requiring human triage; high false-positive rates reduce developer trust
- Detects vulnerability classes like **CWE-89** (SQL injection), **CWE-120** (buffer overflow), and **CWE-798** (hardcoded credentials)
- Fits into **SAST** (Static Application Security Testing) within the SDLC, distinct from **DAST** (Dynamic) and **IAST** (Interactive)
- Required by compliance frameworks like **PCI-DSS** (Requirement 6.3.2) for code review processes

## Related concepts
[[SAST vs DAST]] [[Software Development Life Cycle (SDLC)]] [[Fuzzing]] [[CVE and CWE]] [[DevSecOps]]