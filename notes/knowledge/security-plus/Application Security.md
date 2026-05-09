# Application Security

## What it is

In Fortnite, the **building mechanic** lets you instantly throw up wood, brick, or metal walls, ramps, and floors to defend yourself mid-fight. But veteran players know a single wall isn't enough — you need to **edit** the wall (cut a window, a doorway, a peek-hole), reinforce it with another layer, and check that no enemy is **piece-controlling** the structure beneath you. A wall that looked solid can crumble in two pump-shotgun blasts if it's only a tier-1 wood build that hasn't been edited or supported.

Application security works the same way. The application is your structure. Every input field, API endpoint, cookie, and dependency is a wall that an attacker is going to shotgun-test. You don't just "have a wall" (write the code) — you have to edit it (validate input), reinforce it (sandboxing, secure coding standards), and watch for piece-control (supply chain, dependencies). Drop one tier-1 wall and the whole base falls.

**Plain English**: Application security is the discipline of building, deploying, and maintaining software so attackers can't manipulate inputs, abuse logic, or exploit weaknesses to steal data or take over the system.

**Technical definition**: A set of practices, controls, and tools applied across the [[Software Development Lifecycle]] (SDLC) — from design through deprecation — to identify, mitigate, and prevent vulnerabilities in application code, configuration, dependencies, and runtime behavior. Per CompTIA Objective 4.1, it covers input validation, secure cookies, static and dynamic analysis, code signing, sandboxing, and monitoring.

## Why it matters

Web and mobile apps are the largest attack surface most organizations have. The OWASP Top 10 — injection, broken access control, cryptographic failures, [[SSRF]] — exists because apps are public-facing, complex, and frequently rushed to production. A single SQL injection on a customer-facing form can leak millions of records. A misconfigured cookie without the `Secure` flag can hand session tokens to anyone sniffing public Wi-Fi.

**Defensive scenario**: A bank deploys a new transfer feature. Before release, [[SAST|static analysis]] flags an unsanitized parameter. Developers patch it. After release, a [[WAF|web application firewall]] and runtime [[DAST|dynamic analysis]] catch a logic-flaw attempt — moving negative dollar amounts to bypass balance checks. Layered.

**Attack scenario**: A retailer skips dependency scanning. An attacker exploits a known CVE in an unpatched JavaScript library (a [[Supply Chain Attack]]) and skims credit cards via injected JavaScript — classic Magecart. The flaw was in code the retailer never wrote.

**Exam relevance**: Objective 4.1 explicitly tests application security as part of "applying security techniques to computing resources." Expect scenario questions where you must pick the *best* control for a described weakness — input validation vs. parameterized queries vs. WAF — and questions distinguishing SAST from DAST from IAST.

## Key facts

### Input Validation

The single most important application defense. Untrusted input is the root cause of injection, [[XSS]], buffer overflows, and command injection.

**Two strategies:**

| Approach | Description | When to use |
|----------|-------------|-------------|
| **Allow list (whitelist)** | Define exactly what input is permitted; reject everything else | Preferred — most secure |
| **Deny list (blacklist)** | Define forbidden patterns; allow everything else | Weak — attackers find encoding bypasses |

**Validation should occur:**
- **Server-side, always.** Client-side validation (JavaScript) is a UX feature, not a security control — attackers bypass it with Burp Suite or curl.
- At the **earliest trust boundary** the input crosses.
- For **type, length, format, and range.**

> **CompTIA exam trap**: If a question shows JavaScript validating a form and asks why an injection still succeeded, the answer is almost always "validation must be performed server-side." Client-side validation provides zero security guarantee.

### Secure Cookies

Cookies carry session tokens — steal them, and you've stolen the user's authenticated session ([[Session Hijacking]]).

**Required cookie attributes:**

| Attribute | Purpose |
|-----------|---------|
| `Secure` | Cookie only sent over HTTPS — prevents sniffing on plaintext channels |
| `HttpOnly` | Prevents JavaScript (`document.cookie`) from reading it — mitigates [[XSS]] token theft |
| `SameSite=Strict` or `Lax` | Prevents the browser from sending the cookie on cross-site requests — mitigates [[CSRF]] |
| `Domain` and `Path` | Scope the cookie tightly; never set `Domain=.example.com` if you only need `app.example.com` |
| Short `Expires`/`Max-Age` | Reduces the window of useful theft |

### Static Code Analysis (SAST)

**What it is**: Automated review of **source code** without executing it. Looks for insecure functions, tainted data flow, hardcoded secrets, and known anti-patterns.

**Strengths**:
- Runs early in the SDLC — cheapest place to fix a bug.
- Sees the entire codebase, including paths that may not be reached during testing.
- Integrates with CI/CD and IDEs.

**Weaknesses**:
- High false-positive rate.
- Cannot find runtime/configuration flaws (e.g., a misconfigured load balancer).
- Doesn't see binary or compiled third-party code.

### Dynamic Code Analysis (DAST)

**What it is**: Tests a **running application** by sending malicious inputs and observing responses. Treats the app as a black box.

**Strengths**:
- Finds runtime issues SAST misses — auth flaws, session handling, server misconfigurations.
- Low false-positive rate (if it broke the app, the bug is real).
- Language-agnostic.

**Weaknesses**:
- Requires a deployed, working app — late in the SDLC.
- Only finds bugs in code paths it actually exercises.
- Can damage live data if pointed at production carelessly.

### Fuzzing

A specialized form of dynamic testing that throws **massive volumes of malformed, random, or boundary-value input** at an application to provoke crashes, memory corruption, or unhandled exceptions. Excellent for finding [[Buffer Overflow]] and parsing flaws. Variants:

- **Mutation fuzzing** — alters valid inputs.
- **Generation fuzzing** — builds inputs from a grammar/specification.
- **Coverage-guided fuzzing** (e.g., AFL) — uses code coverage feedback to evolve inputs.

### IAST and RASP

Bonus terms CompTIA may surface:

- **Interactive Application Security Testing (IAST)** — instruments the running app to combine SAST visibility with DAST runtime context.
- **Runtime Application Self-Protection (RASP)** — sits inside the app at runtime, blocks attacks live (think: in-process WAF).

### Code Signing

**Definition**: Cryptographically signing executable code, scripts, or packages with a private key so consumers can verify authenticity and integrity using the corresponding certificate.

**What it provides**:
- **Authenticity** — proves the publisher.
- **Integrity** — proves the code wasn't tampered with after signing.

**What it does NOT provide**:
- **Confidentiality** — signed code is not encrypted.
- **Trustworthiness of the code itself** — Stuxnet was signed with stolen but valid certificates.

> **CompTIA exam trap**: Code signing answers integrity and authenticity. If a question asks about confidentiality of code, the answer is encryption, not signing.

### Sandboxing

Running code in an **isolated environment** with restricted access to the host OS, network, files, and system calls. Used for:

- **Malware analysis** — detonate samples in a VM/container.
- **Application isolation** — browsers run tabs in sandboxes; iOS apps each get a sandbox.
- **CI/CD build environments** — untrusted PRs build in ephemeral containers.

Implementation technologies: VMs, containers, [[seccomp]], AppArmor, SELinux, Windows AppContainer, Chrome's renderer sandbox.

### Secure Coding Practices

CompTIA-flavored checklist:

- **Parameterized queries / prepared statements** — defeats [[SQL Injection]] far better than escaping.
- **Output encoding** — encode for the context (HTML, JS, URL, SQL) to defeat [[XSS]].
- **Principle of least privilege** at the code/process level — the app's database account should not be `db_owner`.
- **Error handling** — don't leak stack traces, query strings, or DB errors to users. Log internally.
- **Secrets management** — no API keys in source code. Use a vault ([[HashiCorp Vault]], AWS Secrets Manager, [[Key Vault]]).
- **Memory-safe languages** where possible (Rust, Go) to eliminate whole classes of buffer overflows.

### Software Composition Analysis (SCA)

Modern apps are 70–90% third-party code. SCA tools (Snyk, Dependabot, OWASP Dependency-Check) inventory dependencies and flag known CVEs. Closely tied to the **Software Bill of Materials (SBOM)** — see [[SBOM]] — which post-Log4Shell and post-Executive Order 14028 is no longer optional for federal suppliers.

### Web Application Firewalls (WAF)

A reverse-proxy filter at Layer 7 that inspects HTTP/HTTPS traffic for malicious patterns: SQLi, XSS, path traversal, and known CVE signatures. Two modes:

| Mode | Behavior |
|------|----------|
| **Detection / monitor** | Logs and alerts but does not block |
| **Prevention / blocking** | Drops or rewrites malicious requests |

A WAF is a compensating control — it does **not** replace fixing the underlying code. CompTIA loves this distinction.

### Application Hardening

Reducing the attack surface of a deployed app:

- Remove default accounts and sample apps (e.g., Tomcat manager, phpMyAdmin in production).
- Disable unused HTTP methods (`TRACE`, `OPTIONS`, `PUT` if not needed).
- Apply security headers: `Content-Security-Policy`, `Strict-Transport-Security`, `X-Frame-Options`, `X-Content-Type-Options`.
- Patch the runtime, frameworks, and OS underneath.
- Disable verbose error messages and directory listings.

### Monitoring

Application security doesn't end at deploy. You need:

- **Application logs** shipped to a [[SIEM]].
- **Audit trails** of privileged operations (admin logins, role changes, data exports).
- **Anomaly detection** — sudden spikes in failed logins, 500 errors, or outbound traffic.
- **Integration with [[SOAR]]** for automated response.

### Comparing the Big Three Testing Approaches

| Property | SAST | DAST | IAST |
|----------|------|------|------|
| Code access required | Yes | No | Yes (instrumented binary) |
| Stage of SDLC | Build/commit | Test/staging | Test/staging |
| Finds runtime issues? | No | Yes | Yes |
| Finds dead-code issues? | Yes | No | Partially |
| False positives | High | Low | Low–medium |
| Language coverage | Per-language tooling | Any | Per-runtime/agent | Per-language tooling |

## Related concepts

[[Software Development Lifecycle]] · [[OWASP Top 10]] · [[SAST]] · [[DAST]] · [[IAST]] · [[Fuzzing]] · [[Code Signing]] · [[Sandboxing]] · [[Web Application Firewall]] · [[Software Composition Analysis]] · [[SBOM]] · [[Input Validation]] · [[Session Hijacking]] · [[XSS]] · [[CSRF]] · [[SQL Injection]] · [[Buffer Overflow]] · [[Supply Chain Attack]] · [[SIEM]] · [[SOAR]]

---
*Source: VIRGIL knowledge base — 2026-05-08*
ime/agent | Per-language tooling |

## Related concepts

[[Software Development Lifecycle]] · [[OWASP Top 10]] · [[SAST]] · [[DAST]] · [[IAST]] · [[Fuzzing]] · [[Code Signing]] · [[Sandboxing]] · [[Web Application Firewall]] · [[Software Composition Analysis]] · [[SBOM]] · [[Input Validation]] · [[Session Hijacking]] · [[XSS]] · [[CSRF]] · [[SQL Injection]] · [[Buffer Overflow]] · [[Supply Chain Attack]] · [[SIEM]] · [[SOAR]]

---
*Source: VIRGIL knowledge base — 2026-05-08*
