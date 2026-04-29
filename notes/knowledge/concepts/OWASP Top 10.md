# OWASP Top 10

## What it is
Think of it as the CDC's "Most Wanted" list for web application diseases — the ten most critical, most commonly exploited vulnerability classes threatening web apps. The Open Worldwide Application Security Project publishes this community-driven list roughly every four years, ranked by prevalence, exploitability, and business impact. It serves as the de facto baseline standard for secure web development and application security testing.

## Why it matters
In 2021, Equifax's catastrophic breach exposed 147 million records — rooted in an unpatched Apache Struts component, which maps directly to OWASP A06: Vulnerable and Outdated Components. Developers who had internalized the OWASP Top 10 would have recognized that unpatched third-party libraries are a primary attack vector, not just a maintenance nuisance. This list turns abstract risk into a concrete developer checklist.

## Key facts
- The **2021 edition** introduced three new categories: Insecure Design (A04), Software and Data Integrity Failures (A08), and Server-Side Request Forgery (A10).
- **A01: Broken Access Control** replaced Injection as the #1 risk in 2021 — 94% of applications tested showed some form of access control failure.
- **A03: Injection** (SQL, LDAP, OS command injection) was #1 for nearly a decade before dropping to third in 2021.
- The list is **not a compliance standard** by itself, but PCI-DSS and many regulatory frameworks explicitly reference it as a baseline requirement.
- **A02: Cryptographic Failures** (formerly "Sensitive Data Exposure") emphasizes that weak encryption implementation is as dangerous as no encryption at all.

## Related concepts
[[SQL Injection]] [[Broken Access Control]] [[Cross-Site Scripting (XSS)]] [[Vulnerability Management]] [[Secure SDLC]]