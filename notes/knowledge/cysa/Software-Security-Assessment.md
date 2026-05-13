# Software Security Assessment

## What it is

In **Sonic the Hedgehog**, before you fight Robotnik you run the whole zone first — Green Hill, Marble, Spring Yard. You hit every loop, smash every monitor, find every hidden ring room, and learn where the spikes come up out of the floor on a timer. By the time you reach the boss arena, you've already mapped every trap the level can throw at you. The boss fight is just the final check. The real work was the run-through.

That's exactly what software security assessment does — you exercise the application through every path you can think of before an attacker does it for you in production.

**Technical definition:** Software security assessment is the structured evaluation of an application's code, runtime behavior, and configuration to identify vulnerabilities before deployment or after change. It combines **white-box** techniques (full code visibility) and **black-box** techniques (external behavior only), spans the entire [[Secure Software Development Lifecycle]] (SDLC), and produces findings that feed [[Vulnerability Management]] prioritization. Under CS0-003 Objective 2.5 it's framed as both a [[Preventative Control]] (catch bugs before they ship) and a [[Detective Control]] (find them in code that already shipped).

## Why it matters

Every web app, mobile app, and internal tool is attack surface. The [[OWASP Top 10]] exists because the same classes of bugs — [[SQL Injection]], [[Cross-Site Scripting]] (XSS), broken auth, broken access control — keep shipping into production a decade after they were named. Patching production is expensive. Patching a finding in a sprint backlog is cheap. The whole point of assessment is to **shift left** — push detection earlier in the SDLC where the fix costs hours, not incident response weekends.

For the CySA+ analyst, this topic shows up two ways:
- You receive SAST/DAST output and have to triage it against real risk (CVSS isn't the whole story — exploitability and exposure matter).
- You sit in the change-board meeting where dev wants to ship a feature that hasn't passed security regression testing, and you have to argue the [[Risk Management]] tradeoff.

Exam relevance: Objective 2.5 ties assessment techniques to **control types** (preventative/detective/corrective), **risk treatment** (accept/avoid/transfer/mitigate), and **secure coding best practices**.

## Key facts

### Static Application Security Testing (SAST)

Analyzes **source code, bytecode, or compiled binaries** without running them. White-box. Runs early in the SDLC — ideally in the IDE, pre-commit hook, or CI pipeline.

| Property | Detail |
|---|---|
| Visibility | Full — every code path, including unreachable ones |
| Detects | Logic flaws, dangerous functions (`strcpy`, `gets`), missing [[Input Validation]], hardcoded secrets, weak crypto APIs |
| Timing | Pre-deployment, every commit |
| Limitation | Can't see runtime behavior or env-specific bugs. High false-positive rate — "tainted data reaches sink" without knowing a sanitizer two functions over already cleaned it. |

SAST is the level-one scout pass. Cheap, fast, noisy.

### Dynamic Application Security Testing (DAST)

Tests the application **while it's running**. Sends crafted requests, watches responses. Black-box or gray-box (gray = some credentials provided).

| Property | Detail |
|---|---|
| Visibility | External — what an attacker would see |
| Detects | [[Authentication]] flaws, broken [[Session Management]], [[Authorization]] bypass, injection that actually reaches a sink, server misconfig |
| Timing | Staging environment, post-build, pre-prod |
| Limitation | Coverage depends on paths exercised. Won't find a bug in an admin function the scanner never authenticated into. |

DAST is the boss-fight rehearsal. You're throwing payloads at the live app and seeing what comes back.

### Fuzzing

Dynamic technique — feed the application **invalid, unexpected, malformed, or random input** and watch what breaks. Crashes are findings. Memory corruption is a finding. A 500 error spilling a stack trace is a finding.

- **Effective for:** input validation bugs, buffer overflows, parser crashes, deserialization issues, file format handlers
- **Variants:** mutation fuzzing (mutates known-good inputs), generation fuzzing (builds from a grammar), coverage-guided (AFL, libFuzzer — uses code coverage to evolve inputs)
- **Weakness:** terrible at business logic flaws. Fuzzers don't know that transferring -$500 should be illegal.

### Fault Injection

Deliberately introduce faults — corrupted memory, dropped packets, killed processes, simulated disk failure — and see how the system reacts. Surfaces unhandled exceptions, failure cascades, weak recovery, and race conditions that only appear under stress. Unhandled exceptions are a goldmine for attackers (info disclosure, crash-to-DoS).

### Mutation Testing

Different from mutation *fuzzing*. Mutation testing changes the **code** (flip a `<` to `<=`, delete a return statement) and re-runs the test suite. If tests still pass, the test suite has a gap. It measures how good your tests are, not how good your code is. Exam awareness only.

### Stress and Load Testing

| Type | What it does | Security relevance |
|---|---|---|
| **Load testing** | Exercises the system at expected production volume | Validates capacity planning |
| **Stress testing** | Pushes past the breaking point | Reveals DoS resilience, resource exhaustion, failure modes |

A web app that returns full stack traces under load is leaking information. A login service that locks out the entire userbase when stressed has a self-inflicted DoS.

### Security Regression Testing

After every patch, dependency update, or config change, re-run the security test suite to confirm **the fix didn't break something else and an old vulnerability didn't reappear**. Lives in CI/CD alongside functional regression. A patch that re-introduces a previously fixed CVE is a real outcome and it happens constantly without regression coverage.

### User Acceptance Testing (UAT)

Final validation by real users in a near-prod environment. Security-adjacent — UAT surfaces **role-based access control issues** ("why can the AP clerk see the salary table?") that scanners can't model.

### Penetration Testing and Adversary Emulation

Pen test = humans attempting controlled compromise within a defined scope. **Adversary emulation** mimics a specific threat actor's TTPs from [[MITRE ATT&CK]] (e.g., "act like FIN7 for two weeks"). Stresses detection and response, not just the app.

### Bug Bounty

External researchers find bugs for cash. [[HackerOne]], [[Bugcrowd]], or self-hosted. Pros: scale, diverse skill sets, real attacker mindset. Cons: scope discipline, triage overhead, paying for duplicates, legal hold on disclosure timelines.

### Secure Coding Best Practices

Findings from assessment map back to these baseline defenses:

- **[[Input Validation]]** — allowlist, not denylist. Validate at the boundary.
- **[[Output Encoding]]** — context-aware (HTML, JS, URL, SQL). Stops [[XSS]] cold.
- **[[Parameterized Queries]] / prepared statements** — the only correct answer to [[SQL Injection]]. String concatenation is a finding, period.
- **[[Session Management]]** — secure cookies (`HttpOnly`, `Secure`, `SameSite`), short timeouts, rotate on auth state change, invalidate on logout server-side.
- **[[Authentication]]** — MFA, no plaintext storage, bcrypt/Argon2 hashing, lockout policies that don't enable DoS.
- **Data protection** — encrypt in transit (TLS 1.2+), encrypt at rest, classify before you protect.

### Control type mapping

| Assessment activity | Control function | Control type |
|---|---|---|
| SAST in CI pipeline | Preventative | Technical |
| DAST in staging | Detective | Technical |
| Bug bounty program | Detective | Managerial |
| Secure SDLC policy | Preventative | Managerial |
| Patch + regression test | Corrective | Technical |
| Pen test schedule | Detective | Managerial |
| Security training for devs | Preventative | Operational |

### Risk treatment when assessment finds something

| Treatment | When to use |
|---|---|
| **Mitigate** | Patch the code, add a [[WAF]] rule, deploy a [[Compensating Control]] |
| **Accept** | Low CVSS, no exposure, signed off by risk owner with documented [[Exception]] |
| **Transfer** | Cyber insurance, contractual liability shift to vendor — residual risk still yours |
| **Avoid** | Decommission the feature, kill the endpoint, [[Attack Surface Reduction]] |

### CompTIA exam traps

> **CompTIA exam trap:** SAST vs DAST vs IAST. SAST = source code, no execution, white-box, early SDLC. DAST = running app, black-box, late SDLC. IAST (interactive) = instrumented agent inside the running app, combines both. If the question says "no source code available" the answer is DAST. If it says "earliest stage possible" the answer is SAST.

> **CompTIA exam trap:** Fuzzing vs mutation testing. **Fuzzing** mutates *inputs* to find bugs in code. **Mutation testing** mutates *code* to find gaps in tests. CompTIA will swap the definitions and dare you to read fast.

> **CompTIA exam trap:** "Transfer" doesn't make risk disappear. Cyber insurance transfers financial impact, not operational reality. The breach still happens. The brand damage still lands. Residual risk still owns you.

> **CompTIA exam trap:** Parameterized queries vs input validation for SQLi. Both help, but the correct primary control is **parameterized queries / prepared statements**. Input validation alone is defense-in-depth, not the fix.

## SOC reality

- The SAST report drops a 4,000-finding PDF into a Jira queue and the dev lead asks you to triage it by Friday. Real answer: filter by severity AND exploitability AND reachability. A "critical" finding in dead code is a paperwork ticket, not a P1.
- The DAST scan fires off in staging at 2am and takes down the auth service because it brute-forced the lockout policy. *You learn fast that scanners need their own test accounts and rate limits, and "staging mirrors prod" includes staging's failure modes.*
- The bug bounty inbox gets a report with a working PoC for an auth bypass on the customer portal. Clock starts. Triage, reproduce, scope blast radius, notify IR, coordinate with the researcher on disclosure timing. **Don't promise a fix date in the first reply.**
- The CISO asks "are we vulnerable to [news CVE]?" Real answer is never yes or no — it's "we're running version X, the CVE affects versions Y-Z, our exposure is [internet-facing / internal-only / not deployed], compensating controls are [WAF rule / segmentation / MFA], remediation ETA is [date]."
- Escalation: L1 triages scanner output and dedupes. L2 validates exploitability and assigns risk. AppSec engineer or IR lead owns remediation with engineering. Legal gets looped in on bug bounty disclosure and any finding touching regulated data.

## Related concepts

[[Vulnerability Management]] · [[Secure Software Development Lifecycle]] · [[OWASP Top 10]] · [[SQL Injection]] · [[Cross-Site Scripting]] · [[Input Validation]] · [[Output Encoding]] · [[Parameterized Queries]] · [[Session Management]] · [[Authentication]] · [[CVSS]] · [[Penetration Testing]] · [[MITRE ATT&CK]] · [[Compensating Control]] · [[Attack Surface Reduction]] · [[Risk Management]] · [[Patching]] · [[WAF]]

*Source: VIRGIL knowledge base — 2026-05-11*