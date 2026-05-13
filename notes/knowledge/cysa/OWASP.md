# OWASP — Open Web Application Security Project

## What it is

In **Grand Theft Auto V**, when you plan the Pacific Standard heist, Lester walks you through the same vulnerabilities every bank has: the side door the guards forgot to lock, the skylight nobody's watching, the armored car route that hasn't changed in six years. He doesn't invent these — he's been casing banks long enough to know the *same ten weaknesses* show up everywhere. Cash in transit, predictable shift changes, single-key vaults. That's exactly what **OWASP** does — it's the Lester Crest of web application security, publishing the recurring weaknesses that every web app keeps shipping with, so defenders know what to look for before the crew rolls up.

In plain English: OWASP is a nonprofit community that publishes free, vendor-neutral guidance on web application security. The thing you care about for CySA+ is the **OWASP Top 10** — a ranked list of the most critical web application security risks, refreshed every few years from real-world breach data.

Technical definition: The Open Web Application Security Project is a community-driven open-source foundation producing methodologies, documentation, tools, and standards for web application security. For the exam, OWASP sits in Domain 2.0 as an **industry framework** that guides vulnerability scanning scope, web app pentesting methodology, and secure-coding standards.

## Why it matters

Web apps are where the money lives. Every breach headline you read — Equifax, Capital One, the 2023 MOVEit mess — traces back to a web-facing application or API. OWASP is the framework that says *here are the categories of mistake developers keep making*, and your scanner — Burp, ZAP, Acunetix, Nessus web-app module — is configured against it.

On CS0-003, Objective 2.1 lists OWASP explicitly under **industry frameworks** for vulnerability scanning. CompTIA wants you to know:

- What OWASP is (the org and the Top 10)
- Where it fits relative to CIS Benchmarks, ISO 27000, and PCI DSS
- How OWASP-aligned scans differ from infrastructure scans (Nessus against a server farm vs. ZAP against a login page)
- That OWASP guides **dynamic application security testing (DAST)** and **static application security testing (SAST)** scope

Career-wise: if you can't talk Top 10 fluently in a SOC interview, you're going to lose the web-app questions. AppSec is the gap most CySA+ candidates have, and OWASP is the cheapest way to close it.

## Key facts

### The OWASP Top 10 (2021 — current at exam time)

CompTIA tests the categories, not the rankings. Memorize the names and what each one means.

| # | Category | What it is |
|---|---|---|
| A01 | **Broken Access Control** | User can access data or functions they shouldn't — IDOR, path traversal, force-browsing to `/admin` |
| A02 | **Cryptographic Failures** | Sensitive data exposed — weak ciphers, plaintext storage, no TLS, hardcoded keys |
| A03 | **Injection** | SQLi, command injection, LDAP injection, OS injection — untrusted input reaches an interpreter |
| A04 | **Insecure Design** | Threat modeling was skipped — the app is broken by architecture, not implementation |
| A05 | **Security Misconfiguration** | Default creds, verbose errors, unpatched components, open S3 buckets, debug mode in prod |
| A06 | **Vulnerable and Outdated Components** | Log4j, Struts, jQuery 1.x — using libraries with known CVEs |
| A07 | **Identification and Authentication Failures** | Credential stuffing works, no MFA, weak password reset, session fixation |
| A08 | **Software and Data Integrity Failures** | Unsigned updates, untrusted CI/CD, insecure deserialization (SolarWinds shape) |
| A09 | **Security Logging and Monitoring Failures** | The breach happened in March, you found out in November because nobody logged auth failures |
| A10 | **Server-Side Request Forgery (SSRF)** | App fetches a URL the attacker controls — Capital One 2019, the SSRF-to-IMDS pivot |

### OWASP vs. the other frameworks CompTIA cares about

The exam loves to make you pick which framework applies. Know the lanes.

| Framework | Scope | Use case |
|---|---|---|
| **OWASP** | Web applications, APIs | DAST/SAST scanning, secure code review, web app pentest scoping |
| **CIS Benchmarks** | OS, network device, cloud platform hardening | Configuration baseline scanning — "is this Windows Server hardened?" |
| **ISO 27000 series** | Information security management system (ISMS) | Governance, certification, organization-wide program |
| **PCI DSS** | Cardholder data environment | Required if you store/process/transmit payment cards; mandates quarterly ASV scans |
| **NIST 800-53 / CSF** | Federal + critical infrastructure controls | Government, contractors, broad risk framework |

OWASP is the only one in this list that is **purely web/API focused**. CIS hardens the server; OWASP hardens the app running on it.

### Where OWASP fits in vulnerability scanning

CompTIA 2.1 asks you about scanning concepts. OWASP maps to these directly:

- **Static vs. dynamic** — SAST analyzes [[source code]] for OWASP issues without running it (catches injection patterns, hardcoded secrets); DAST runs against a live app (catches misconfig, SSRF, auth failures). OWASP defines what both look for.
- **Credentialed vs. non-credentialed** — DAST against an authenticated app catches A01 broken access control (privilege escalation between user roles); non-credentialed only sees what an anonymous attacker sees.
- **Active vs. passive** — passive web scanning watches traffic without sending payloads (proxy mode in [[Burp Suite]]); active fires injection strings, fuzzed inputs, traversal attempts. OWASP Top 10 mostly needs active to confirm.
- **Fuzzing** — automated malformed-input generation; OWASP's recommended technique for finding A03 injection and input-validation bugs.
- **Reverse engineering** — for mobile apps and compiled binaries, OWASP MASVS (Mobile App Security Verification Standard) guides what to look for after decompilation.
- **Scheduling and performance** — DAST is *expensive*. A full ZAP active scan against a large app can take 12+ hours and break the app. Schedule it like a vuln scan — off-hours, against staging when possible.

### Other OWASP projects worth knowing

The Top 10 is famous, but OWASP publishes more:

- **OWASP ZAP (Zed Attack Proxy)** — free DAST tool, the open-source Burp
- **OWASP ASVS (Application Security Verification Standard)** — three levels of web app security requirements; used to *specify* security in contracts
- **OWASP API Security Top 10** — separate list focused on REST/GraphQL API risks; CompTIA may reference it
- **OWASP Mobile Top 10** — mobile-specific risks
- **OWASP SAMM (Software Assurance Maturity Model)** — measure your SDLC maturity
- **OWASP Cheat Sheets** — the actually-useful developer-facing guidance for every Top 10 item

### CompTIA exam traps

> **CompTIA exam trap:** OWASP vs. CIS Benchmarks. CIS hardens the *host* (Windows Server, Ubuntu, AWS account). OWASP hardens the *application*. If the question is "harden the operating system to a known baseline," answer CIS. If it's "test the login page for injection," answer OWASP. Same vendor-neutral structure, different layer of the stack.

> **CompTIA exam trap:** OWASP is not a regulation. It's a *framework*. PCI DSS is the regulation that may *require* OWASP-aligned testing (PCI DSS 6.2.4 references OWASP), but OWASP itself has no legal force. CompTIA will offer "OWASP compliance" as a distractor on regulatory questions — there is no such thing as OWASP compliance.

> **CompTIA exam trap:** The Top 10 changes. CS0-003 references the 2021 list. Don't memorize the 2017 list (Injection was #1, XSS was its own category). In 2021, XSS got absorbed into A03 Injection, and SSRF was promoted to its own slot at A10.

> **CompTIA exam trap:** "Insecure Design" (A04) is *not* the same as "Security Misconfiguration" (A05). Design means the architecture is broken — you can't patch your way out. Misconfig means the architecture is fine but somebody left the default password. The exam loves this distinction.

### Special considerations

- **OT/ICS/SCADA web interfaces** — modbus historians and HMI web consoles run web apps too, often unpatched and ancient. OWASP scans against these can *crash the controller*. Coordinate with operations; never active-scan production OT.
- **Internal vs. external** — external-facing apps get attacked first; scan them first. Internal apps still need OWASP review because [[lateral movement]] post-compromise hits internal portals next.
- **Segmentation** — even with internal scanning, network segmentation determines what your scanner can *reach*. Scope your DAST to actual asset inventory.
- **Sensitivity levels** — apps handling PHI, PCI, or PII get prioritized. Map OWASP findings to data sensitivity, not raw CVSS.

## SOC reality

- The DAST scanner fires off Sunday 0200 and by Monday standup there are 1,400 findings against the marketing CMS. About 30 are real. The L1's job is triage — anything tagged A01, A03, A07, or A10 gets escalated; A05 misconfig findings get bundled into a weekly ticket to the platform team.
- When AppSec finds an A03 injection in a payment flow, the CISO's first question is not "is it patched" — it's *"is there evidence it was exploited?"* You pull WAF logs, app logs, and database query logs for the last 90 days. If logging was off (A09), you cannot answer, and that's its own incident.
- Never tell the CFO "we're OWASP compliant." There is no such state. Say "our SDLC includes OWASP ASVS Level 2 verification and quarterly DAST" — that's a defensible sentence.
- Handoff: L1 triages scanner output → L2 confirms exploitability with [[Burp Suite]] or manual testing → AppSec engineer works with dev team on fix → change management schedules the deploy → L1 verifies the finding closes on rescan. A finding isn't fixed until the rescan is clean.
- The Log4j moment (A06) is the one that wakes everyone at 2am. Vulnerable component disclosures hit Twitter before they hit your scanner's signature feed. *The scanner is a lagging indicator; threat intel is the leading one.*

## Related concepts

[[Vulnerability Scanning]] · [[SAST]] · [[DAST]] · [[Burp Suite]] · [[Nessus]] · [[CIS Benchmarks]] · [[PCI DSS]] · [[ISO 27001]] · [[NIST CSF]] · [[SQL Injection]] · [[Cross-Site Scripting]] · [[SSRF]] · [[Log4j]] · [[CVSS]] · [[Threat Modeling]] · [[Secure SDLC]] · [[Fuzzing]] · [[Web Application Firewall]]

*Source: VIRGIL knowledge base — 2026-05-11*