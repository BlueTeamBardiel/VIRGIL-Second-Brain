# DLP — Data Loss Prevention

## What it is

In **The Witcher 3**, Geralt walks into a Novigrad fence's shop carrying a saddlebag full of stolen relics, monster trophies, and a few items the Eternal Fire would burn him for owning. The fence checks every item against what he's allowed to buy — flagged contraband gets refused, ordinary loot gets traded, and certain quest items can't leave Geralt's inventory at all because the game engine itself blocks the transfer. The shopkeeper is the policy engine, the inventory check is the inspection, and the refusal to trade is the enforcement action.

That's exactly what **DLP** does — it sits at the egress points of your environment, inspects data leaving the inventory, and refuses the transfer when the data matches a policy that says *this doesn't go out*.

**Technical definition:** Data Loss Prevention is a set of tools and policies that detect and prevent unauthorized exfiltration, leakage, or misuse of sensitive data — at rest, in motion, and in use — by inspecting content, context, and user behavior against defined rules, then enforcing actions ranging from log-only to block-and-alert.

## Why it matters

A single misrouted email with a customer CSV attached can be the difference between a quiet Tuesday and a regulatory disclosure. **CHD** (cardholder data) leaks trigger PCI DSS forensics and card-brand fines. **PII** leaks trigger GDPR 72-hour notification clocks and state breach laws. PHI leaks trigger HIPAA. Source code leaks trigger insurance arguments about whether trade secrets were ever really protected.

DLP is the control auditors point at when they ask *"how do you know your data isn't walking out the door?"* — and "we trust our employees" is not an acceptable answer.

Exam relevance: **Objective 1.1** — DLP is listed as a sensitive data protection control under system and network architecture. CySA+ tests where DLP sits in the stack, what it inspects, and which deployment mode catches which scenario.

## Key facts

### The three states DLP protects

| State | What it means | DLP placement |
|---|---|---|
| **Data at rest** | Stored on disk, in databases, in object storage, in SharePoint | Endpoint DLP agents, storage scanners, [[CASB]] for cloud buckets |
| **Data in motion** | Crossing the network — email, web upload, API call, file transfer | Network DLP at egress, mail gateway, [[SASE]] inspection, TLS-inspected web proxy |
| **Data in use** | Open in an application — being copied, printed, screenshotted, pasted into chat | Endpoint DLP with kernel/user-mode hooks, clipboard monitors, print spool inspection |

If your DLP only covers one state, you have a DLP-shaped poster on the wall. You don't have DLP.

### Deployment models

- **Network DLP** — inline appliance or virtual sensor at the perimeter. Inspects SMTP, HTTP/S, FTP. Requires TLS interception to see encrypted traffic — which means a [[PKI]] internal CA pushing certs to endpoints. Blind to anything you don't decrypt.
- **Endpoint DLP** — agent on the workstation. Sees clipboard, USB writes, print jobs, screenshots, application-to-application data movement. Works offline. Adds CPU overhead and a help-desk ticket queue.
- **Storage / Cloud DLP** — scans repositories. SharePoint, OneDrive, S3, Google Drive. Often delivered through a [[CASB]] sitting between users and SaaS apps in API mode (after-the-fact scanning) or inline mode (real-time block).
- **Email DLP** — almost always a separate gateway product or O365/Google policy. Highest-volume DLP channel by ticket count.

### How DLP recognizes sensitive data

Three detection techniques, usually layered:

1. **Pattern matching / regex** — Luhn-checked credit card numbers, SSN formats, phone numbers. Cheap, noisy, prone to false positives.
2. **Exact data match (EDM) / fingerprinting** — hash the actual customer database, alert when those hashes leave. Expensive to maintain, very low false positive rate.
3. **Classification / labels** — Microsoft Purview, Titus, Boldon James apply metadata labels (Public, Internal, Confidential, Restricted). DLP enforces on the label rather than re-scanning content. Pairs with [[Identity and access management]] and rights management.

### Enforcement actions

From least to most disruptive:

- **Log only** — record the event, don't tell the user. Tuning mode.
- **Notify user** — popup or banner: "this email contains what looks like 47 SSNs, are you sure?"
- **Justify / override** — user must type a business reason, which gets logged. Audit trail without blocking productivity.
- **Encrypt in transit** — automatically apply rights management before sending.
- **Quarantine** — hold the email/file pending manager approval.
- **Block** — drop the transfer, alert SOC, log the user.

> **CompTIA exam trap:** DLP "blocks data exfiltration" is the marketing answer. The exam answer is more careful — DLP *detects and responds to* policy violations. A determined insider with a phone camera defeats every DLP product ever shipped. DLP is one layer in a defense-in-depth stack alongside [[Zero trust]], [[Network segmentation]], encryption, and [[PAM]].

### What DLP integrates with

- **[[CASB]]** — extends DLP into SaaS. The CASB sees the Salesforce export, the OneDrive share-to-external-user, the Box public link. Without CASB, your DLP stops at the corporate egress and SaaS is a black hole.
- **[[SASE]]** — converged network + security at the cloud edge. DLP becomes a policy applied at the SASE PoP, inspecting traffic from any device anywhere.
- **SIEM / [[Log ingestion]]** — DLP alerts feed into SIEM with full content snippets (redacted) so analysts can triage without re-running queries.
- **[[Identity and access management]]** — DLP policies often vary by user role. A finance analyst can email cardholder data internally; a developer cannot.
- **Encryption** — DLP can trigger automatic encryption rather than block, turning a violation into a controlled transfer.
- **[[SDN]] inspection** — in cloud-native architectures, DLP rides on software-defined network flow inspection rather than physical taps.

### Data classification — the prerequisite nobody wants to do

DLP without classification is regex-only DLP, and regex-only DLP is a false-positive factory. The hard work is upstream:

1. Inventory data types (PII, PHI, CHD, IP, source code, contracts)
2. Classify by sensitivity (Public, Internal, Confidential, Restricted)
3. Label at creation — automated where possible, user-driven where necessary
4. Map labels to DLP policies

This is the part organizations skip. Then they buy a DLP product and wonder why it generates 4,000 alerts a day and the SOC stops looking.

> **CompTIA exam trap:** When CompTIA asks about the *first step* in deploying DLP, the answer is **data classification / discovery**, not "install the agent." DLP enforces policy; classification *is* the policy.

### DLP and TLS — the inspection problem

Most modern exfiltration rides over HTTPS. To inspect it, network DLP needs **TLS interception** — terminating the client TLS session at the proxy, inspecting plaintext, re-encrypting to the destination. This requires:

- Internal [[PKI]] root CA trusted by all endpoints
- Exception list for cert-pinned apps (banking, some mobile apps break)
- Legal and HR sign-off — employees must be notified
- Compliance carve-outs — you typically don't decrypt healthcare or banking traffic to/from named domains

Endpoint DLP sidesteps this by inspecting before encryption happens, but only on managed devices.

## SOC reality

- The DLP queue is loud. A typical mid-size enterprise generates hundreds to low thousands of DLP events per day. 90%+ are false positives or business-justified. The L1 analyst's job is to triage fast: legitimate business use → close; pattern of behavior → escalate; clear malicious intent or large-volume exfil → page IR.
- The 3am alert that matters looks like this: a user account that hasn't touched the customer database in 8 months runs a 40,000-row export at 2:47am, then a DLP event fires for a large upload to a personal Google Drive. That's the chain — not the single event, the sequence. SIEM correlation across DLP + EDR + [[IAM]] auth logs is what turns DLP from noise into signal.
- What the CISO actually asks during an incident: *"What data category? How many records? Was it encrypted in transit? Did the block fire or did we miss it? Are we in a notification window?"* If you don't know the data classification, you can't answer the regulatory questions.
- Never promise leadership "DLP would have caught it." DLP catches what you policy-defined and what crossed an inspected channel. The USB write to an unmanaged personal device while the agent was being upgraded — DLP didn't catch that, and the post-incident review will be ugly.
- Insider risk and DLP are converging products. The interesting alerts now combine DLP content events with user behavior anomalies — resignation letter draft + sudden archive of project files + USB insertion = a coordinated investigation, not three separate tickets.

*A DLP alert is not an exfiltration. A blocked event is not a contained user. The user who tripped the block ten times today is telling you something — go read the chain, not the single event.*

## Related concepts

[[CASB]] · [[SASE]] · [[Zero trust]] · [[Network segmentation]] · [[PKI]] · [[Identity and access management]] · [[PAM]] · [[Encryption]] · [[Log ingestion]] · [[SIEM]] · [[Sensitive data protection]] · [[PII]] · [[CHD]] · [[Insider threat]] · [[Cloud security]]

*Source: VIRGIL knowledge base — 2026-05-11*