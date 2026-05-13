# Incident Severity Classification

## What it is

In **Street Fighter**, when Ryu eats a Shoryuken to the face, the game doesn't just say "you got hit." It tracks **damage scaling, stun meter, chip damage, juggle state, and round timer** all at once. A jab does 30 damage and barely moves the stun bar. A raw Critical Art with full meter drains half your health, breaks your guard, and pushes you into the corner where the next mixup kills you. Same hit category — "you took damage" — wildly different consequences. The ref doesn't stop the match for a jab. The announcer screams when the Critical Art lands.

That's exactly what incident severity classification does — it's the multi-dimensional damage calculator that decides whether the SOC takes a sip of coffee or wakes up the CISO.

**Plain English:** Not every incident is a fire. Severity classification is the structured process of measuring an incident across multiple impact dimensions so the response matches the actual harm — not the analyst's adrenaline level.

**Technical definition (CS0-003):** Incident severity classification is a documented scoring methodology applied during the **Detection and Analysis** phase that evaluates an incident across functional impact, economic impact, information (data) impact, and recoverability effort. The output drives playbook selection, escalation thresholds, notification timelines, and resource allocation per the **Incident Response Plan**.

## Why it matters

Severity classification is the load-bearing decision in IR. Misclassify low, and a ransomware foothold sits in the queue for six hours while the L1 analyst chases phishing tickets. Misclassify high, and you wake up the executive team at 2am for a tuned-out EDR false positive — do that twice and nobody answers the phone the night you actually need them.

CompTIA tests this under **Objective 3.3 (preparation and post-incident activity)** because severity classification is defined during **Preparation** — in the IR plan, in the playbooks, in the tabletops — long before the alert fires. You can't invent the severity scale at 3am. The classification also feeds **Post-incident Activity**: root cause analysis, lessons learned, and the BC/DR review all reference the original severity to ask *"did we respond proportionally?"*

In the real world, severity classification is what your compliance officer points to when regulators ask why GDPR notification went out on day 4 instead of day 2. It's the audit trail. *No documented severity, no defensible response.*

## Key facts

### The four dimensions (CompTIA's frame)

Severity is **never** a single number. It's a composite across four axes. Score each, then roll up.

| Dimension | What it measures | Example: low | Example: high |
|---|---|---|---|
| **Functional impact** | Degree of operational impairment to business processes | Single user can't access SharePoint | Production database offline, customer-facing app down |
| **Economic impact** | Direct and indirect financial loss | <$10K recovery cost | Revenue loss + regulatory fines + legal fees + ransom |
| **Information impact** | Sensitivity and volume of data exposed or altered | Public marketing content modified | PHI/PCI/PII exfiltrated, integrity loss on financial records |
| **Recoverability effort** | Time and resources to restore | Hours, in-house team | Weeks, vendor engagement, full BC/DR invocation |

The roll-up gives you a severity tier — typically **Critical / High / Medium / Low** or numbered **SEV-1 through SEV-4**. The exact labels are defined in the **Incident Response Plan**.

### Functional impact tiers (NIST SP 800-61 alignment)

- **None** — No effect on operations.
- **Low** — Minimal effect; can continue all critical services to all users but lost efficiency.
- **Medium** — Lost ability to provide a critical service to a subset of users.
- **High** — No longer able to provide critical services to any users.

### Information impact categories

- **None** — No information exfiltrated, changed, deleted, or otherwise compromised.
- **Privacy breach** — Sensitive PII accessed or exfiltrated.
- **Proprietary breach** — Unclassified proprietary information (trade secrets, source code) accessed or exfiltrated.
- **Integrity loss** — Sensitive or proprietary information altered or deleted.

### Recoverability effort tiers

- **Regular** — Time to recovery is predictable with existing resources.
- **Supplemented** — Predictable with additional resources.
- **Extended** — Unpredictable; additional resources and outside help required.
- **Not recoverable** — Recovery is not possible (data destroyed, irreversible damage); launch investigation.

### A worked example

Phishing email → user clicks → credential harvested → attacker logs into M365 → reads inbox → no lateral movement, no data exfil confirmed, MFA token expired after 8 hours.

- Functional: **Low** (one user account)
- Economic: **Low** (~$2K analyst time)
- Information: **Privacy breach — limited** (inbox contained some internal PII)
- Recoverability: **Regular** (password reset, token revocation, mailbox review)

Roll-up: **SEV-3 / Medium**. Playbook says: contain in 4 hours, notify privacy officer, no executive wake-up, document for monthly review.

Now change one variable — the inbox contained 50,000 customer records exported as a CSV attachment, and the attacker forwarded it externally. Information impact jumps to **privacy breach — major**. Roll-up: **SEV-1 / Critical**. GDPR 72-hour clock starts. CISO wakes up. Legal engages. Same initial alert, completely different response — *because the dimensions are scored independently.*

### Where severity lives in the IR lifecycle

**Preparation** — Define the scale, thresholds, escalation matrix, and notification timelines in the **Incident Response Plan**. Validate via **tabletop** exercises ("if a ransomware variant hits 200 endpoints, what's the SEV?"). Train L1/L2 analysts on the rubric.

**Detection and Analysis** — Apply the rubric to the live incident. Re-score as new evidence emerges. The initial severity is rarely the final severity.

**Containment, Eradication, Recovery** — Severity drives playbook selection. SEV-1 invokes BC/DR, vendor IR retainer, executive comms. SEV-4 stays in the queue.

**Post-incident Activity** — During **lessons learned** and **root cause analysis**, ask: was the severity accurate? Did we under- or over-respond? Update the rubric.

### CompTIA exam traps

> **CompTIA exam trap:** Severity classification is *not* the same as risk scoring or CVSS. CVSS measures vulnerability characteristics in the abstract; severity measures the actual impact of an active incident. A CVSS 9.8 on an unreachable internal asset can drive a SEV-3 incident. A CVSS 6.5 on a customer-facing payment system can drive a SEV-1. The exam will offer "use the CVSS score as the severity" as a distractor — it's wrong.

> **CompTIA exam trap:** Severity is multi-dimensional. If a question asks "what determines incident severity?" and one answer says "financial impact" and another says "functional impact, economic impact, information impact, and recoverability" — pick the composite. CompTIA tests whether you understand it's *never* a single axis.

> **CompTIA exam trap:** Severity is defined during **Preparation**, applied during **Detection and Analysis**, and reviewed during **Post-incident Activity**. If the question places severity definition during the incident itself, it's wrong — you'd be building the rubric while bleeding.

### Severity vs priority — not the same word

- **Severity** = how bad the impact is.
- **Priority** = the order in which we work it.

A SEV-2 incident on a system under active regulatory deadline can become **Priority 1** even though severity is medium. Most mature SOCs track both, and CompTIA occasionally uses them interchangeably in distractors — read carefully.

### What the playbook actually contains per severity

| Tier | Notification window | Escalation | BC/DR invoked? | External comms |
|---|---|---|---|---|
| **SEV-1 / Critical** | Immediate (<15 min) | CISO, CEO, Legal, PR | Yes | Customers, regulators, possibly press |
| **SEV-2 / High** | <1 hour | CISO, IR lead | Possibly | Affected stakeholders only |
| **SEV-3 / Medium** | <4 hours | IR lead, manager | No | Internal only |
| **SEV-4 / Low** | Next business day | Team lead | No | None |

These windows are organization-specific — but they exist *in writing*, *before the incident*. That's the **Preparation** payoff.

### Tooling support

SOAR platforms (Palo Alto XSOAR, Splunk SOAR, Tines) automate severity scoring by pulling asset criticality from the **CMDB**, data classification tags from the **DLP**, and exposure data from the **vulnerability scanner**. The analyst confirms; the platform routes. Good tooling cuts initial classification from 20 minutes to 90 seconds — *but bad asset inventory turns the automation into a confident liar.*

## SOC reality

- The alert fires at 3:14am with a generic title like "Suspicious PowerShell execution on FINANCE-DB-07." Your first job isn't to fix it — it's to score it. You pull the asset criticality from the CMDB (Tier 1, processes SOX-regulated data), check if the process tree shows lateral movement (it does), and check if EDR contained it (it did, but 90 seconds after spawn). Initial classification: **SEV-2**, pending data impact review.
- The IR lead's first question is always the same three words: **"scope, impact, evidence?"** Your severity score is the compressed answer. If you can't articulate why it's a SEV-2 and not a SEV-1, you're not done analyzing.
- Never tell leadership "it's contained" until containment is verified. Never tell them "it's a SEV-3" until you've checked the information impact dimension — that's the one analysts skip when they're tired, and it's the one that triggers regulatory clocks.
- Severity gets **re-scored** as the investigation matures. You'll open at SEV-3, escalate to SEV-2 when you find the second compromised host, then drop back to SEV-3 when forensics proves no exfil. Document every change with a timestamp and rationale — that's your audit trail.
- The handoff: L1 applies the rubric, L2 validates and may escalate, IR lead owns the final severity for SEV-1/2 incidents. Legal owns the regulatory-notification decision regardless of severity once data impact is confirmed.

## Related concepts

[[Incident Response Plan]] · [[Incident Response Lifecycle]] · [[Playbooks]] · [[Tabletop Exercises]] · [[Business Continuity and Disaster Recovery]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Chain of Custody]] · [[CVSS]] · [[Data Classification]] · [[Asset Criticality]] · [[SOAR]] · [[GDPR Breach Notification]] · [[CIRCIA]] · [[NIST SP 800-61]]

*Source: VIRGIL knowledge base — 2026-05-11*