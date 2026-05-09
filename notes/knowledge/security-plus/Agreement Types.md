# Agreement Types

## What it is

In Final Fantasy, before you can summon Bahamut you don't just whistle — you complete a specific covenant: defeat the trial, prove your worth, and the Eidolon agrees to terms. The pact spells out what the summon does, what you owe, and when the relationship ends. That's exactly what **agreement types** do — they are the written contracts that define what each party in a business or vendor relationship will do, will not do, and is liable for.

Technically: agreement types are formal documents used in third-party risk management to establish the legal, operational, and security obligations between organizations and their vendors, partners, or internal teams.

## Why it matters

Vendors are the soft underbelly of every breach report — Target, SolarWinds, Kaseya all came in through someone else's contract. Without the right agreement, you have no legal recourse when a vendor leaks your data, no defined uptime when their service dies, and no audit rights when regulators ask who touched the PII. SY0-701 Objective **5.3** explicitly lists the agreement types below, and CompTIA's favorite trap is making you distinguish **MOU vs. MOA vs. MSA vs. SLA** on a single question — they sound interchangeable, they are not.

## Key facts

### The agreement types you must know cold

| Acronym | Name | What it actually does |
|---|---|---|
| **SLA** | [[Service-Level Agreement]] | Defines measurable performance: uptime %, response time, support tiers. Has teeth — credits or penalties for breach. |
| **MOU** | [[Memorandum of Understanding]] | Non-binding "we intend to cooperate" letter. A handshake on paper. |
| **MOA** | [[Memorandum of Agreement]] | More formal than MOU — defines specific roles and responsibilities, often binding. |
| **MSA** | [[Master Service Agreement]] | Umbrella contract covering general terms; specific work is added via [[Statement of Work]] (SOW). |
| **SOW** | [[Statement of Work]] | The deliverables, timeline, and price under an MSA. The "what we're actually building." |
| **NDA** | [[Non-Disclosure Agreement]] | Legal gag order on confidential information. Mutual or one-way. |
| **BPA** | [[Business Partners Agreement]] | Defines profit sharing, decision authority, and exit terms between partners. |

### The binding spectrum

- **Non-binding (intent only):** [[MOU]]
- **Conditionally binding:** [[MOA]], [[BPA]]
- **Fully binding with measurable obligations:** [[SLA]], [[MSA]], [[SOW]], [[NDA]]

### SLA specifics CompTIA loves

- **Uptime tiers:** 99.9% ("three nines") = 8.76 hours downtime/year. 99.99% = 52.6 minutes. 99.999% = 5.26 minutes.
- **MTTR** (Mean Time To Repair) and **MTBF** (Mean Time Between Failures) are common SLA metrics.
- SLA breach typically triggers **service credits**, not termination.

### MSA + SOW pattern

The MSA is signed once. Every new project drops in as a new SOW under it. This is why enterprise vendors don't re-negotiate boilerplate every quarter — the MSA already handles indemnification, IP ownership, and dispute resolution.

### The exam trap

CompTIA will describe a scenario — "two universities agree to share research data with no legal penalty for withdrawal" — and force you to pick between MOU and MOA. **No legal penalty = MOU.** "Defines specific responsibilities" = MOA. "Includes uptime guarantees" = SLA. Read for the keyword.

### Adjacent agreements worth knowing

- **[[Data Processing Agreement]] (DPA):** Required under GDPR when a processor handles controller data.
- **[[Interconnection Security Agreement]] (ISA):** Specifies technical and security requirements when two networks connect directly — common in federal/government contexts.
- **[[Acceptable Use Policy]] (AUP):** Internal, not vendor-facing, but often referenced in agreements.

## Related concepts

[[Third-Party Risk Management]] · [[Vendor Assessment]] · [[Supply Chain Attack]] · [[Due Diligence]] · [[Right-to-Audit Clause]] · [[Service-Level Agreement]] · [[Statement of Work]] · [[Non-Disclosure Agreement]]

---
*Source: VIRGIL knowledge base — 2026-05-08*