# Static Code Analysis

## What it is
Like a grammar-checker that reads your essay before you submit it — catching dangling modifiers without ever running a single sentence aloud — static code analysis examines source code, bytecode, or binaries for vulnerabilities without executing the program. It automatically inspects code structure, data flows, and logic paths to flag issues like buffer overflows, SQL injection sinks, and hardcoded credentials at development time.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) existed in a widely-used Java library for years before discovery. Organizations with static analysis integrated into their CI/CD pipelines could identify the dangerous JNDI lookup pattern in dependency code before shipping products — organizations without it were scrambling to patch after exploitation began. This illustrates why "shift-left" security — catching flaws early — dramatically reduces remediation cost.

## Key facts
- Static analysis runs **without executing code** (contrast with dynamic analysis, which requires runtime); this makes it safe to run on untrusted or incomplete code
- Common tools include **Semgrep**, **Checkmarx**, **SonarQube**, and **Fortify**; many integrate directly into IDEs and CI/CD pipelines
- It produces **false positives** (flagging safe code as vulnerable) and **false negatives** (missing obfuscated or runtime-dependent flaws) — human triage is always required
- Effective at finding **CWE-class vulnerabilities**: CWE-89 (SQL Injection), CWE-79 (XSS), CWE-798 (Hardcoded Credentials), and CWE-120 (Buffer Overflow)
- On **Security+/CySA+**, static analysis is categorized under **SAST (Static Application Security Testing)** and is a core component of a **Secure SDLC** and **DevSecOps** practices

## Related concepts
[[Dynamic Code Analysis]] [[Software Composition Analysis]] [[Secure SDLC]] [[Fuzzing]] [[DevSecOps]]