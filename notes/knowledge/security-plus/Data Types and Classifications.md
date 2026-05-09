# Data Types and Classifications

## What it is

In Apex Legends, loot drops in tiers — white, blue, purple, gold — and you instinctively know that scooping up a gold helmet matters more than a stack of common shield cells. The game color-codes value so you protect what's rare and ignore what's replaceable. That's exactly what data classification does — it labels information by sensitivity so you know what to guard with your life and what to leave on the ground.

**Data classification** is the formal process of categorizing data based on sensitivity, regulatory requirements, and business impact, then applying handling controls appropriate to each tier.

## Why it matters

Without classification, every byte gets treated identically — meaning either you over-spend protecting cafeteria menus or under-spend protecting PII, and one of those gets you fined under [[GDPR]], [[HIPAA]], or [[PCI DSS]]. SY0-701 Objective 3.3 explicitly lists *data types* (regulated, trade secret, intellectual property, legal information, financial information, human- and non-human-readable) and *data classifications* (sensitive, confidential, public, restricted, private, critical) as required knowledge. CompTIA's favorite trap: confusing **data types** (what the data *is*) with **data classifications** (how sensitive it *is*) — and giving you a scenario answer that requires picking the right label, not the right control.

## Key facts

### Data Classifications (sensitivity tiers)

| Classification | Meaning | Example |
|---|---|---|
| **Public** | No harm if disclosed | Marketing material, press releases |
| **Private** | Internal use; mild harm if leaked | Employee directories, internal memos |
| **Sensitive** | Umbrella term; harm if disclosed | [[PII]], [[PHI]] |
| **Confidential** | Significant harm; restricted access | Contracts, salary data |
| **Restricted** | Severe harm; tight need-to-know | [[Trade secrets]], merger plans |
| **Critical** | Mission-essential; loss = business failure | Encryption keys, core IP |

Government variant: **Unclassified → Confidential → Secret → Top Secret**, with optional **SCI** ([[Sensitive Compartmented Information]]) overlays.

### Data Types (what the data is about)

- **[[Regulated data]]** — governed by law/standard. Includes [[PII]], [[PHI]] ([[HIPAA]]), cardholder data ([[PCI DSS]]), [[GDPR]]-protected personal data.
- **[[Trade secret]]** — proprietary info with economic value derived from secrecy (Coca-Cola formula energy).
- **[[Intellectual property]] (IP)** — patents, copyrights, trademarks; legally protected creative/inventive output.
- **[[Legal information]]** — contracts, litigation hold data, attorney-client privileged material.
- **[[Financial information]]** — ledgers, transactions, [[SOX]]-relevant records.
- **[[Human-readable]]** — plaintext documents, spreadsheets, emails.
- **[[Non-human-readable]]** — binaries, encoded payloads, database blobs, machine-only formats.

### Data States (know these — they're tested together)

| State | Where it lives | Primary control |
|---|---|---|
| **Data at rest** | Disks, backups, archives | [[Full disk encryption]], [[AES-256]] |
| **Data in transit** | Network wire, wireless | [[TLS]] 1.3, [[IPsec]], [[VPN]] |
| **Data in use** | RAM, CPU, active processes | [[Secure enclave]], [[TEE]], memory encryption |

### Roles tied to classification (Objective 5.1 crossover)

- **[[Data owner]]** — senior exec accountable; sets the classification.
- **[[Data controller]]** — determines purpose and means of processing ([[GDPR]] term).
- **[[Data processor]]** — processes on behalf of controller.
- **[[Data custodian]]/[[steward]]** — implements the controls; day-to-day handling.
- **[[Data Protection Officer]] (DPO)** — compliance oversight under GDPR.

### Handling controls that map to classification

- **Labeling/tagging** — metadata or visual marking driving downstream policy.
- **[[DLP]] (Data Loss Prevention)** — enforces rules per classification at endpoint, network, and cloud.
- **[[Access control]]** — [[RBAC]]/[[ABAC]] gates by clearance and need-to-know.
- **[[Encryption]]** — required for restricted/critical at rest and in transit.
- **[[Data retention]] / disposal** — schedules and destruction methods ([[crypto-shredding]], [[degaussing]], physical destruction) scale with sensitivity.
- **[[Data sovereignty]]** — geographic storage restrictions tied to regulated data.

### Common exam traps

- "Sensitive" is a *category*, not a synonym for "Confidential" — read the scenario.
- **PII vs PHI vs cardholder data** — same idea, different regulators.
- A trade secret is **not** the same as a patent; patents are public, trade secrets die when disclosed.
- Classification is set by the **owner**, enforced by the **custodian** — don't swap them.

## Related concepts

[[Data Loss Prevention (DLP)]] · [[PII]] · [[PHI]] · [[GDPR]] · [[HIPAA]] · [[PCI DSS]] · [[Data sovereignty]] · [[Data retention]] · [[Encryption at rest]] · [[Data owner]] · [[RBAC]] · [[Crypto-shredding]]

---
*Source: VIRGIL knowledge base — 2026-05-08*