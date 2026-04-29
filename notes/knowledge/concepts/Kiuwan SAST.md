# Kiuwan SAST

## What it is
Like a spell-checker that hunts for security mistakes instead of typos, Kiuwan SAST (Static Application Security Testing) scans source code *before* it ever runs, flagging vulnerabilities at the development stage. It is a commercial code analysis platform that inspects application source code, bytecode, or binaries without executing them, identifying weaknesses such as injection flaws, insecure cryptography, and hardcoded credentials across 30+ programming languages.

## Why it matters
In 2021, attackers exploited a SQL injection flaw in a financial application that had passed functional QA but never underwent static analysis — a tool like Kiuwan would have flagged the unparameterized query at commit time, before it reached production. This illustrates the core defense value: shifting security left means vulnerabilities are caught when they cost $80 to fix rather than $80,000 post-breach.

## Key facts
- Kiuwan integrates into CI/CD pipelines (Jenkins, GitHub Actions, Azure DevOps), enforcing security gates that block deployments when risk thresholds are exceeded
- It maps findings to CWE (Common Weakness Enumeration), OWASP Top 10, and SANS Top 25, making results directly actionable against recognized vulnerability taxonomies
- Kiuwan uses a **benchmark scoring model** that grades overall codebase security health, enabling trend tracking across releases — not just point-in-time scans
- Unlike DAST tools, Kiuwan requires no running application or network access; it analyzes code at rest, so it can catch vulnerabilities in internal logic unreachable by external probes
- Kiuwan offers two modules: **Code Analysis** (SAST) and **Insights** (SCA — Software Composition Analysis for third-party library risk), covering both custom and dependency vulnerabilities

## Related concepts
[[Static Application Security Testing]] [[Software Composition Analysis]] [[CI/CD Pipeline Security]] [[OWASP Top 10]] [[Shift-Left Security]]