# Legal Holds & Preservation

## What it is

In **Civilization**, the moment you declare war on Gandhi, the game freezes the diplomatic state — every treaty you signed, every promise you broke, every border agreement gets locked into the historical record. You can't go back and edit the turn where you stationed troops next to his border "just to look." The autosave from turn 184 is sitting there forever. When the AI civilizations later vote on whether you're a warmonger, they pull receipts from saves you forgot existed. *That autosave you can't delete is a legal hold.*

That's exactly what a legal hold does — it freezes the evidentiary state of your environment the moment litigation, regulatory action, or an insider incident becomes reasonably foreseeable. Normal retention policies that would have aged data off in 90 days? Suspended. The mailbox cleanup job that runs every Sunday? Disabled for the custodians on the hold. The endpoint that would have been re-imaged and handed to the next employee? Quarantined.

Technical definition: a **legal hold** (also called a **litigation hold** or **preservation order**) is a formal, organizationally-issued directive that suspends normal data destruction, retention, and rotation policies for specific custodians, systems, or data sets in anticipation of, or in response to, legal or regulatory proceedings. **Preservation** is the broader IR and forensic discipline of maintaining evidence in an unaltered, defensible state from the moment of identification through disposition.

Legal hold is the *policy instrument*. Preservation is the *operational practice*. You need both.

## Why it matters

Failing a legal hold is one of the few SOC mistakes that ends with a federal judge personally upset with your company. Spoliation — the destruction or alteration of evidence after a duty to preserve attaches — gets you **adverse inference instructions** (the jury is told to assume the missing evidence was bad for you), **monetary sanctions**, and in egregious cases **default judgment**. Zubulake v. UBS Warburg is the case every IR lead should know by name.

For the CySA+ analyst, this maps to **Objective 3.2** — incident response activities, specifically evidence acquisition, chain of custody, validating data integrity, and preservation. CompTIA treats legal hold as a control that sits *across* the IR lifecycle: it can trigger during detection (insider tip), bind containment decisions (you cannot wipe that drive), and dominate post-incident activity (you keep the artifacts for years).

Career relevance: the analyst who understands legal hold is the analyst who doesn't accidentally torch the case. The analyst who re-images an endpoint under hold becomes the cautionary tale in next quarter's all-hands.

## Key facts

### When a legal hold triggers

A duty to preserve attaches when litigation is **reasonably anticipated** — not when the lawsuit is filed. That's the trap. The trigger events:

- **Litigation** — a lawsuit filed, a credible threat letter, a subpoena, a discovery request
- **Regulatory investigation** — SEC inquiry, FTC action, state AG investigation, HIPAA breach probe, GDPR supervisory authority engagement
- **Insider incidents** — suspected employee theft of IP, harassment claims, whistleblower complaints, fraud allegations
- **Criminal matters** — law enforcement subpoena, search warrant, grand jury request
- **Contractual disputes** — breach of contract claims where data may be discoverable
- **Internal investigations** — HR matters that may escalate, board-level inquiries

The legal team issues the hold. The SOC and IT execute it. *The moment counsel says "preserve," the deletion jobs stop — even if the lawsuit never materializes.*

### What gets preserved

| Data class | Examples | Preservation challenge |
|---|---|---|
| Structured data | Databases, CRM records, financial systems | Backup snapshots, point-in-time recovery |
| Unstructured data | Email, files, chat (Slack/Teams), SharePoint | Mailbox holds, eDiscovery tooling |
| Endpoint data | Local files, browser history, deleted-but-recoverable artifacts | Forensic imaging, [[Write Blockers]] |
| Cloud data | SaaS tenants, IaaS storage, audit logs | API-level legal hold flags (M365, Google Workspace) |
| Network telemetry | Firewall logs, NetFlow, proxy logs, [[SIEM]] data | Extend retention, freeze rotation |
| Ephemeral data | RAM, running processes, network connections | Live acquisition — see [[Volatility Order]] |
| Physical media | Backup tapes, USB drives, printed material | Chain of custody, secure storage |
| Communications metadata | Call records, Teams meeting metadata, badge access logs | Often forgotten — counsel asks for it later |

### Custodians

A **custodian** is a person whose data is subject to the hold. The custodian list is built by counsel + HR + IT — names, roles, date ranges, data sources. Each custodian gets a **hold notice** they must acknowledge in writing. Repeat the notice quarterly while the hold is active. *The acknowledgment trail is itself evidence — that the organization issued the hold and the employee understood it.*

When a custodian leaves the company, their data does not. Mailboxes get converted to **inactive holds**, their endpoint gets imaged before recycling, their access tokens get revoked but the account stays in scope.

### Preservation vs retention vs backup

These get conflated on the exam. They are not the same.

- **Retention** — normal policy lifecycle. "Keep email 7 years, then delete." Routine, scheduled, defensible because it's policy.
- **Backup** — operational recovery. Designed to restore service after failure. Not designed for evidence preservation; backup rotation may overwrite the only copy of relevant data.
- **Preservation** — evidentiary state maintenance. Suspends retention. Often requires *additional* copies beyond backup, with chain of custody.
- **Archive** — long-term storage of inactive data, usually for compliance. Closer to preservation but not the same — archives can still be deleted on schedule unless a hold attaches.

> **CompTIA exam trap:** "We have backups" is not preservation. Backups rotate. Backups are designed to restore systems, not defend evidence in court. If the question describes a scenario where backup tapes were overwritten after a litigation hold was issued — that's **spoliation**, not "we tried." The correct control is suspending the rotation policy.

### Legal hold in the IR lifecycle

Walking through the four CompTIA / NIST SP 800-61 phases:

**Preparation** — the legal hold *playbook* lives here. Who has authority to issue a hold? (General Counsel, usually.) What systems have hold capability built in? (M365, Google Workspace, most modern EDRs, most enterprise SIEMs.) What's the runbook for suspending backup rotation? Tabletop exercises should include a hold scenario.

**Detection and Analysis** — when an alert may indicate an insider incident, fraud, or anything counsel might care about, the analyst's job is to *escalate, not delete*. Preserve initial artifacts in their original state. [[Chain of Custody]] starts here.

**Containment, Eradication, and Recovery** — this is where legal hold collides with operational instinct. The instinct is to re-image the compromised endpoint and get the user back to work. The hold says: *image the drive forensically first, store the image, then re-image the working copy.* Use **[[Compensating Controls]]** (network isolation, account disablement, monitoring) to manage risk while the original artifact sits frozen.

**Post-incident Activity** — the hold often outlives the incident by years. Litigation is slow. The artifacts you acquired in week one may be subpoenaed three years later. Storage budget needs to account for this.

### Validating data integrity

Preservation without integrity validation is a paperweight. The defensible chain:

1. **Acquire** the evidence with forensically sound tools — `dd`, FTK Imager, EnCase, [[Write Blockers]] on physical media
2. **Hash** the original and the copy — SHA-256 minimum, MD5 still seen in case law for legacy reasons
3. **Document** the hash in the chain of custody form
4. **Verify** the hash matches at every handoff and before any analysis
5. **Work on copies only** — the original sits in evidence storage, never touched again

If the hash changes between acquisition and court, the evidence is dead. *The hash is your alibi.*

### Scope and impact considerations

**Scope** of the hold should be tight — over-preserving creates discovery cost (every preserved document is a document opposing counsel can request) and storage burden. But under-preserving creates spoliation risk. Counsel makes the call; the SOC executes.

**Impact** to operations is real:
- Backup retention extensions cost money
- Suspended deletion jobs grow storage indefinitely
- Custodian accounts can't be deprovisioned normally
- Endpoint refreshes slow down
- Cloud storage costs balloon

The CISO will ask: *"What's the cost of the hold per month?"* Have the number ready.

> **CompTIA exam trap:** Re-imaging an endpoint that is subject to a legal hold — *without first acquiring a forensic image* — is the wrong answer even if re-imaging is the standard remediation step. The exam will offer "re-image the device" as a tempting choice. The correct order is **preserve, then remediate**.

## Inhibitors to preservation

CompTIA tests inhibitors to remediation; the same inhibitors apply to preservation:

- **Legacy systems** — old mainframes, custom apps with no hold capability
- **Third-party SaaS** — vendor controls the data; you need a contractual hold provision in the [[MOU]] or DPA
- **BYOD** — personal devices may hold business data; legal hold on a personal phone is a minefield
- **Ephemeral infrastructure** — containers, serverless, auto-scaling groups that vanish after use
- **Encrypted data** — key escrow matters; preserving ciphertext without the key is preserving nothing
- **Cross-border data** — GDPR, data localization laws may prohibit moving preserved data to a US discovery platform

## SOC reality

- **The 3am alert** — analyst sees suspicious data staging by a senior engineer. Instinct is to disable the account and wipe the box. Correct move: escalate to IR lead, who escalates to GC, who issues a hold within hours. The endpoint stays online but network-isolated. *Containment without destruction.*
- **The L1 first action** — when an alert touches anything HR-adjacent (departing employee, harassment context, fraud signal), the L1 ticket gets tagged "potential legal hold candidate" and routed to L2 immediately. L1 does not act alone on these.
- **What the CISO asks** — "Is counsel aware? Have we preserved the original artifacts? What's the chain of custody status? Are backups still rotating on the affected systems?" If you can't answer all four cleanly, the next call is uncomfortable.
- **What never to promise** — "We have everything." You don't. There's always ephemeral data, RAM that wasn't captured, a Slack DM that aged out before the hold attached. *Tell counsel what you have and what you don't, in writing.*
- **The handoff** — SOC preserves and hands to IR/forensics → forensics images and hands to legal → legal hands to outside counsel → outside counsel hands to opposing party in discovery. Every transfer is a chain-of-custody event. Every transfer is a place the case can break.

## Related concepts

[[Chain of Custody]] · [[Evidence Acquisition]] · [[Write Blockers]] · [[Volatility Order]] · [[Forensic Imaging]] · [[Data Integrity Validation]] · [[Compensating Controls]] · [[Incident Response Lifecycle]] · [[Containment Strategies]] · [[MOU]] · [[Regulatory Reporting]] · [[Insider Threat]] · [[eDiscovery]] · [[Spoliation]]

*Source: VIRGIL knowledge base — 2026-05-11*