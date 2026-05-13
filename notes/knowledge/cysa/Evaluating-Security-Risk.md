# Evaluating Security Risk

## What it is

In **FIFA**, before kickoff you stare at the opponent's formation card. Mbappé on the left wing, pace 97, finishing 93. Your right back is a 78-rated journeyman with 71 pace. That's a **vulnerability** (slow defender), a **threat** (a striker who will exploit it), and the **risk** is the goal you concede in the 23rd minute if you don't switch to a deeper line or double-team the flank. The pre-match screen is a risk matrix. The tactical adjustment is your control.

That's exactly what evaluating security risk does — you inventory your weaknesses, identify who's coming for them, and decide what to fix before the whistle blows.

**Technical definition (CS0-003 1.1):** Risk evaluation is the structured process of identifying threats, mapping them to vulnerabilities in the system and network architecture, estimating likelihood and impact, and prioritizing treatment. The equation CompTIA wants you to recite:

> **Risk = Threat × Vulnerability × Impact** (some sources collapse this to Threat × Vulnerability, with Impact as a multiplier on the output).

Without a vulnerability, a threat has nothing to bite. Without a threat, a vulnerability sits there harmlessly. Without impact, neither matters.

## Why it matters

The SOC doesn't have infinite analysts, infinite scan windows, or infinite change-board approvals. Risk evaluation is how you decide which of the 4,000 open findings in [[Vulnerability Management]] gets worked this sprint and which gets a risk-acceptance memo. Get this wrong and you patch a CVSS 9.8 on a sandboxed lab box while the CVSS 6.5 on the internet-facing payroll server rots for 90 days.

This is **Objective 1.1** — CompTIA frames it under system and network architecture because where the asset lives (on-prem, cloud, hybrid, [[Serverless]]) and how it's segmented changes the risk calculus completely. A SQL injection on a [[Network Segmentation|segmented]] internal app with no PII is annoying. The same flaw on a [[Cloud]]-hosted customer portal handling [[Cardholder Data (CHD)]] is a PCI DSS breach notification.

Career relevance: every SOC L2+ role expects you to write a risk statement that a non-technical executive can act on. "CVSS 9.8" doesn't move budget. "$4M regulatory exposure if exploited, 72-hour [[GDPR]] clock starts the moment we confirm" moves budget.

## Key facts

### The four threat categories CompTIA tests

| Category | Source | Examples |
|---|---|---|
| **Adversarial** | Intentional human actors | Nation-state APTs, ransomware crews, insiders going rogue, hacktivists |
| **Accidental** | Unintentional human action | Misconfigured S3 bucket, admin emails a password list to the wrong DL, dev pushes secrets to public GitHub |
| **Structural** | Equipment/software failure | Disk failure, RAID controller dies, software bug, expired cert nobody renewed |
| **Environmental** | Outside org control | Flood, fire, regional power outage, ISP fiber cut, pandemic-era staffing collapse |

CompTIA loves the distinction between **accidental** and **structural**. A human typo is accidental. A library bug that crashes under load is structural. Same downtime, different category, different control.

### The risk equation — what each term actually means

- **Threat** — a factor with the capability and (sometimes) intent to exploit a vulnerability. Threats have *actors* (who) and *vectors* (how).
- **Vulnerability** — a weakness. Missing patch, weak [[Encryption]] cipher, no [[MFA]], unsegmented flat network, a privileged account with a 2018 password.
- **Likelihood** — probability the threat actually fires against this asset, this quarter. A CVE on a niche library used by 12 orgs worldwide has lower likelihood than a CVE in Log4j.
- **Impact** — what breaks if it does. Data loss, revenue loss, regulatory fines, brand damage, life safety for OT environments.
- **Risk** — the product. Often expressed qualitatively (low/medium/high/critical) on a 5×5 matrix.

### Risk matrix — the 5×5 CompTIA expects you to read

|  | **Negligible Impact** | **Minor** | **Moderate** | **Major** | **Catastrophic** |
|---|---|---|---|---|---|
| **Almost Certain** | Medium | High | High | Critical | Critical |
| **Likely** | Low | Medium | High | High | Critical |
| **Possible** | Low | Medium | Medium | High | High |
| **Unlikely** | Low | Low | Medium | Medium | High |
| **Rare** | Low | Low | Low | Medium | Medium |

The matrix is a forced-prioritization tool. Two findings rated "High" by CVSS can land in completely different cells once you overlay business impact.

### Architecture changes the risk — Objective 1.1 in action

Same vulnerability, different placements, wildly different risk:

- **On-premises**, behind a segmented VLAN, no internet exposure → likelihood drops hard.
- **Cloud** IaaS with a public-facing load balancer → likelihood spikes; impact depends on what data the workload touches.
- **Hybrid** with a misconfigured site-to-site VPN → you've extended the on-prem blast radius into the cloud and vice versa. Worst of both.
- **Serverless** function with overly broad IAM role → small attack surface, but if popped, the role might have access to the whole data lake.
- **Containerization** without image scanning → one compromised base image multiplies across hundreds of pods.

Controls that change the equation:

- **[[Zero Trust]]** — assumes breach, forces re-authentication per resource. Drops likelihood of [[Lateral Movement]] succeeding.
- **[[Network Segmentation]]** — limits blast radius. Drops impact.
- **[[SASE]]** (Secure Access Service Edge) — combines network + security at the cloud edge for remote workforces. Reduces exposure of internal services.
- **[[CASB]]** (Cloud Access Security Broker) — sits between users and cloud apps, enforces DLP, encryption, access policy. Critical for [[Sensitive Data Protection]] when shadow IT is real.
- **[[SDN]]** inspection — programmable traffic steering, enables granular east-west inspection that legacy switches can't.
- **[[PAM]]** (Privileged Access Management) — vaults admin creds, session recording, just-in-time elevation. Drops likelihood that a popped workstation = domain admin.
- **[[IAM]]** + **[[MFA]]** + **[[SSO]]** + **[[Federation]]** + **[[Passwordless]]** — identity is the new perimeter. Each layer drops likelihood of credential-based intrusion.
- **[[PKI]]** + **[[SSL]]/TLS** — encryption in transit. Drops impact of network-tier interception.
- **[[DLP]]** — drops impact by catching exfil of [[PII]] / CHD before it leaves.
- **[[System Hardening]]** — registry lockdown, service minimization, baseline configs. Drops vulnerability count.
- **[[Log Ingestion]]** + **time sync** (NTP) — doesn't drop risk directly but makes detection and forensics actually work. A SIEM with drifted clocks is a SIEM that lies to you.

### Quantitative vs qualitative risk

CompTIA wants both vocabularies:

- **Qualitative** — low/medium/high. Fast, subjective, good for executive reporting.
- **Quantitative** — dollar figures.
  - **SLE** (Single Loss Expectancy) = Asset Value × Exposure Factor
  - **ARO** (Annualized Rate of Occurrence) = how many times per year
  - **ALE** (Annualized Loss Expectancy) = SLE × ARO

Example: a customer database worth $2M, 30% exposure factor on a breach, expected once every 5 years. SLE = $600K. ARO = 0.2. ALE = $120K/year. If a control costs $40K/year and reduces ARO to 0.05, the math works.

### Risk treatment options — the four verbs

| Treatment | What it means | Real example |
|---|---|---|
| **Mitigate** | Apply controls to reduce likelihood or impact | Patch the CVE, add MFA, segment the network |
| **Transfer** | Push the financial consequence to someone else | Cyber insurance, contractual indemnity, outsource to a managed provider |
| **Accept** | Acknowledge the risk, document it, move on | Legacy ICS box that can't be patched, residual risk after controls |
| **Avoid** | Stop doing the risky activity | Decommission the app, refuse to enter the market, don't store the data |

> **Transfer doesn't make risk disappear.** Insurance pays out after the breach — the brand damage, the regulator's attention, and the 3am IR call still own you.

### CompTIA exam traps

> **Exam trap — Threat vs Risk vs Vulnerability:** CompTIA will give you a scenario and ask which term applies. *A hurricane* is a threat. *A datacenter in a flood zone* is a vulnerability. *Losing the datacenter to a hurricane* is the risk. Memorize the shape.

> **Exam trap — Accept vs Avoid:** Accept means you keep doing the thing and live with the consequences. Avoid means you stop doing the thing entirely. CompTIA tests this with scenarios like "the company decided not to launch the product in that country" — that's avoid, not accept.

> **Exam trap — Quantitative formula order:** SLE comes from AV × EF. ALE comes from SLE × ARO. Don't multiply AV × ARO directly — you'll get a number that looks right and is wrong.

> **Exam trap — Inherent vs residual risk:** Inherent risk is what exists before any controls. Residual risk is what's left after controls are applied. The control's job is to shrink the delta. You never get to zero.

## SOC reality

- The **risk register** is a living spreadsheet (or a GRC tool like Archer/ServiceNow) — every accepted risk has an owner, an expiration date, and a compensating control. When the auditor shows up, this is the first artifact they ask for.
- L1 analysts don't *evaluate* risk for the org — they triage alerts against a pre-built severity matrix. Risk evaluation is L2/L3 and GRC work. But L1 sees the downstream effect: which alerts get auto-closed, which get paged out, which sit in the queue for 8 hours.
- The CISO's question is never "what's the CVSS?" It's **"what's the business risk, what's the residual after controls, and what does it cost to drop it another tier?"** Translate or get translated for.
- The fight you'll lose most often: a high-risk finding sitting open because the business owner won't approve the maintenance window. The finding doesn't go away — it gets a risk-acceptance memo signed by someone with enough title to own the consequences. *Document everything. The memo is what saves your career when it gets exploited 14 months later.*
- Risk evaluation feeds [[Incident Response]] prioritization directly. When three alerts fire at once, the one touching the CHD-tagged asset wins. The asset inventory and data-classification work that nobody wants to do is what makes that triage possible at 3am.

## Related concepts

[[Threat Modeling]] · [[Vulnerability Management]] · [[CVSS Scoring]] · [[Asset Inventory]] · [[Network Segmentation]] · [[Zero Trust]] · [[PAM]] · [[IAM]] · [[Data Classification]] · [[DLP]] · [[CASB]] · [[SASE]] · [[Cloud Security]] · [[Incident Response]] · [[Risk Register]] · [[Business Impact Analysis]] · [[Compensating Controls]]

*Source: VIRGIL knowledge base — 2026-05-11*