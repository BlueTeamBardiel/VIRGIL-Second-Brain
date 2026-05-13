# SDLC — Software Development Life Cycle

## What it is

In **Persona 5**, you don't walk into Kamoshida's Palace and start swinging at the king. You scout the building on day one, map the Safe Rooms, identify which Shadows you can fight and which will instakill you, grind your party in Mementos until your level matches the boss, then send the calling card *before* you breach the treasure room — because once that card goes out, security tightens and you only get one shot. Skip a phase and you wipe in the throne room with no Goho-M. That's exactly what SDLC does — it's the phase discipline that keeps software from shipping with a SQL injection in the login form because someone needed it live by Friday.

**Plain English:** the Software Development Life Cycle is the structured set of phases code passes through from "we need a feature" to "we're maintaining it in production." Security gets baked into every phase — not bolted on after launch.

**Technical:** SDLC is the framework of phases — Planning, Requirements, Design, Implementation, Testing, Deployment, Maintenance — that governs software delivery. **Secure SDLC (SSDLC)** integrates security controls at each phase: threat modeling in design, secure coding in implementation, [[SAST]]/[[DAST]] in testing, [[penetration testing]] before deployment, [[patch management]] in maintenance. CySA+ tests SDLC under Objective 2.5 because vulnerability response isn't just patching CVEs in prod — it's preventing the CVE from being written in the first place.

## Why it matters

Every vulnerability you triage in the SOC started life as a line of code. The industry rule of thumb: a bug caught in requirements costs ~$1, in testing ~$100, in production ~$10,000, post-breach ~$millions. The CySA+ analyst lives at the expensive end of that curve. Knowing SDLC lets you push fixes left — talk to dev leads about [[threat modeling]] before sprint planning instead of writing the same JIRA ticket every quarter.

Objective 2.5 expects you to know secure coding practices, control types, risk treatment options, and where [[attack surface management]] fits the pipeline. CompTIA folds SDLC into vulnerability management because the *response* to a class of vulns is often "fix the SDLC phase that lets this keep happening."

## Key facts

### The phases (CompTIA-aligned)

| Phase | What happens | Security activity |
|---|---|---|
| **Planning** | Business case, scope, budget | Risk appetite, [[compliance]] requirements (PCI, HIPAA, GDPR) |
| **Requirements** | Functional + non-functional specs | Security requirements, abuse cases, data classification |
| **Design** | Architecture, data flow, components | [[Threat modeling]] (STRIDE, PASTA, DREAD), trust boundaries |
| **Implementation** | Code gets written | Secure coding standards, [[SAST]], peer review, secrets scanning |
| **Testing** | QA, integration, UAT | [[DAST]], [[IAST]], [[SCA]], [[penetration testing]], fuzzing |
| **Deployment** | Promotion to prod | Config hardening, secrets management, [[change management]] |
| **Maintenance** | Operations, patching, EOL | [[Patch management]], vulnerability scanning, [[bug bounty]], decommissioning |

CompTIA may also reference simpler models (waterfall, iterative, agile, DevSecOps). DevSecOps is the modern answer — security is everyone's job, integrated into CI/CD, not a gate at the end.

### Secure coding best practices

- **Input validation** — never trust input from the user, the network, or another service. Allowlist > denylist. Validate type, length, format, range. Stops [[SQL injection]], [[XSS]], command injection, path traversal.
- **Output encoding** — encode data on the way *out* based on context (HTML, JS, URL, SQL). Defense-in-depth pair with input validation against [[XSS]].
- **Parameterized queries** — prepared statements. The database treats user input as data, not code. Single most effective control against [[SQL injection]]. Concatenating strings into SQL is malpractice.
- **Authentication** — strong password policies, [[MFA]], no hardcoded credentials, no credentials in source control (git history is forever).
- **Session management** — cryptographically random session IDs, secure + HttpOnly + SameSite cookie flags, idle and absolute timeouts, invalidate on logout, regenerate on privilege change.
- **Data protection** — encryption at rest and in transit, least-privilege access, masking/tokenization for PII, key management via [[HSM]] or KMS.
- **Error handling** — generic errors to the user, detailed errors to the log. Stack traces in HTTP responses are reconnaissance gold.

### Threat modeling

Design-phase activity. Pick one structured approach:

- **STRIDE** (Microsoft) — Spoofing, Tampering, Repudiation, Information disclosure, Denial of service, Elevation of privilege. Per-component checklist.
- **PASTA** — Process for Attack Simulation and Threat Analysis. Risk-centric, seven stages.
- **DREAD** — scoring model (Damage, Reproducibility, Exploitability, Affected users, Discoverability). Falling out of favor — subjective.

Output is a list of threats with mitigations, mapped to data flow diagrams. *If you've never sat in a threat model session and watched a senior dev realize the auth token is in the URL, you haven't seen security pay for itself in real time.*

### Security controls testing

| Test type | When | What it catches |
|---|---|---|
| **[[SAST]]** (static) | Implementation | Source code flaws — buffer overflows, injection sinks, hardcoded secrets |
| **[[DAST]]** (dynamic) | Testing | Runtime flaws — auth bugs, [[XSS]], misconfigs against running app |
| **[[IAST]]** (interactive) | Testing | Combines SAST/DAST via instrumentation; lower false positives |
| **[[SCA]]** (software composition) | Implementation/testing | Vulnerable third-party libraries (Log4Shell-class) |
| **[[Penetration testing]]** | Pre-deployment | Chained exploits, business logic, what a real attacker does |
| **Adversary emulation** | Maintenance | Specific TTPs (MITRE ATT&CK) against existing controls — red team exercise |
| **[[Bug bounty]]** | Post-deployment | Crowdsourced discovery — pay-per-valid-finding (HackerOne, Bugcrowd) |
| **Fuzzing** | Testing | Crashes from malformed input — memory corruption, parser bugs |

### Control types (Objective 2.5)

**By function:**
- **Preventative** — stops the event. Firewall, input validation, MFA.
- **Detective** — finds the event. SIEM, IDS, log review.
- **Corrective** — fixes after the event. Backup restore, patch deployment, re-imaging.
- **Responsive** — reacts to active events. IR playbook execution, [[SOAR]] automation.
- **Compensating** — alternative when the primary isn't feasible. Can't patch the legacy SCADA box? Segment it.

**By implementation:**
- **Technical** — hardware/software. EDR, WAF, encryption.
- **Operational** — humans doing things. Code review, security awareness training.
- **Managerial** — policy and oversight. Risk assessments, security policies, [[SLAs]].

### Risk treatment

- **Mitigate** — apply a control to reduce likelihood or impact. Patch, WAF rule, config change. Default answer.
- **Transfer** — shift the loss to someone else. Cyber insurance, third-party hosting with contractual liability. *Transfer never makes the risk disappear — residual risk still owns you, and insurance won't restore your reputation.*
- **Avoid** — stop doing the risky thing. Decommission the vulnerable service entirely.
- **Accept** — formally document that the business will live with it. Requires sign-off from a risk owner with authority. Goes in the **exceptions** register with an expiration date.

An exception without an expiration date is a permanent vulnerability with paperwork.

### Patching, deployment, and rollback

- **Patching and configuration** — vendor patches → test in staging → deploy via [[change management]] → verify → monitor.
- **Maintenance windows** — scheduled downtime negotiated with the business. Sunday 02:00–06:00 is the SOC's natural habitat.
- **Rollback** — every change needs a documented rollback path. *The patch that breaks production at 03:00 is not the emergency; the patch with no rollback plan is the emergency.*
- **Validation** — post-patch verification. Does the service work? Did the scan re-run clean? Did monitoring confirm no regression?

### Attack surface management

Maintenance-phase discipline of knowing what you actually expose:

- **Edge discovery** — what's reachable from outside. External scans, internet asset inventory (Shodan, Censys), DNS enumeration.
- **Passive discovery** — observing traffic and public sources without probing. Certificate transparency logs, passive DNS, OSINT.
- **Attack surface reduction** — close unused ports, decommission shadow IT, remove default credentials, disable unused features.

### Prioritization and escalation

Vulns get fixed in order of business risk, not CVSS. Factor [[CVSS]] base score + exploitability ([[EPSS]], CISA [[KEV]]) + asset criticality + exposure + compensating controls. Escalate via documented path — SOC L1 → L2 → vuln management → app owner → change board. Common SLO shape: Critical 7 days, High 30, Medium 90, Low 180.

### CompTIA exam traps

> **CompTIA exam trap:** *Compensating vs corrective control.* Compensating is an *alternative* when the primary control can't be implemented (segmentation around an unpatchable legacy host). Corrective *fixes the impact* after an event (restoring from backup). Both can apply to the same vuln, but they answer different questions.

> **CompTIA exam trap:** *Transfer ≠ eliminate.* Cyber insurance transfers financial loss. It does not transfer the breach, the regulator's fine schedule, or the brand damage.

> **CompTIA exam trap:** *Input validation vs output encoding.* Input validation rejects bad data on the way *in*. Output encoding makes data safe on the way *out* for a specific context. Use both. CompTIA loves to offer one as the "complete" answer when it isn't.

> **CompTIA exam trap:** *Parameterized queries* are the specific control for [[SQL injection]]. Input validation helps; WAF helps; only parameterized queries treat user input as non-executable data at the database driver level.

> **CompTIA exam trap:** *Exception ≠ acceptance.* Acceptance is a risk treatment decision. An exception is the documented, time-boxed, governance-approved record of it. An undocumented "we accept this" is just unfixed risk.

## SOC reality

- Monday morning the vuln scan ticket lands: 47 highs, 12 criticals. You don't patch in CVSS order — you pull KEV, EPSS, and asset criticality, and build a prioritized list the app owners will accept.
- When dev pushes code that fails [[SAST]] in CI, you're often the one explaining to the team lead why "we'll fix it next sprint" doesn't fly for a hardcoded API key. *The hill you die on is the secret in git history — once pushed, rotate it, don't just delete the commit.*
- CISO asks "what's our attack surface?" The honest answer is "smaller than last quarter, here's the trend." If you can't produce that number with sources, your edge discovery program isn't real.
- Change board on Wednesday: every patch with a rollback plan gets approved fast; every patch without one gets bounced.
- Never tell leadership "the vuln is mitigated" when you mean "we accepted it with an exception." Those are different states and the auditor will ask.

## Related concepts

[[Vulnerability Management]] · [[CVSS]] · [[KEV]] · [[EPSS]] · [[SAST]] · [[DAST]] · [[SCA]] · [[Penetration testing]] · [[Threat modeling]] · [[Bug bounty]] · [[Patch management]] · [[Change management]] · [[Attack surface management]] · [[SQL injection]] · [[XSS]] · [[MFA]] · [[SOAR]] · [[SLA]]

*Source: VIRGIL knowledge base — 2026-05-11*