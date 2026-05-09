# Protecting Data

## What it is

In Tomb Raider, Lara doesn't leave the Atlas of Mystery sitting on a museum pedestal in plain sight — she stashes it, encrypts the location in her journal, and only she knows how to read the markings. When Trinity raids the camp, they find boxes and gear, but the artifact's meaning is gibberish without Lara's notes. That's exactly what data protection does — it ensures that even when adversaries grab your data, they can't read it, can't alter it without you noticing, and can't tell what's sensitive from what's noise.

**Data protection** is the set of technical and administrative controls (encryption, masking, tokenization, classification, DLP, and rights management) applied to data at rest, in transit, and in use to preserve confidentiality, integrity, and availability across its lifecycle.

## Why it matters

Lose unencrypted PII and you trigger breach notification laws (GDPR Article 33, state laws, HIPAA), regulatory fines, civil suits, and the kind of news cycle that ends careers. Without data classification, every control you build is guessing — you can't protect what you haven't labeled. **Exam angle:** SY0-701 Objective 3.3 expects you to know data states (at rest / in transit / in use), data types (regulated, trade secret, IP, legal, financial, human-readable vs. non-human-readable), data classification levels, and the specific methods (geographic restrictions, encryption, hashing, masking, tokenization, obfuscation, segmentation, permission restrictions). **CompTIA's favorite trap:** confusing **tokenization** (substitutes data with a non-mathematically-related token, requires a vault) with **encryption** (mathematically reversible with a key) with **hashing** (one-way, not reversible) with **masking** (display-layer obfuscation, original still exists). They will absolutely give you a credit-card-processing scenario and watch which one you pick.

## Key facts

### Data states

| State | Meaning | Typical control |
|---|---|---|
| [[Data at rest]] | Stored on disk, in database, in backup | [[Full-disk encryption]] (FDE), [[Transparent data encryption]] (TDE), [[BitLocker]], [[LUKS]] |
| [[Data in transit]] | Moving across network | [[TLS]] 1.2/1.3, [[IPsec]], [[SSH]], [[VPN]] |
| [[Data in use]] | Loaded in RAM, being processed | [[Secure enclaves]], [[Confidential computing]], [[Intel SGX]], [[AMD SEV]] |

### Data types (Sec+ vocabulary)

- **[[Regulated data]]** — governed by law: [[PII]], [[PHI]] (HIPAA), [[PCI-DSS]] cardholder data, [[GDPR]]-scoped personal data.
- **[[Trade secret]]** — competitive value, e.g., the Coke formula.
- **[[Intellectual property]]** — patents, copyrights, source code.
- **[[Legal information]]** — privileged communications, litigation hold.
- **[[Financial information]]** — books, forecasts, account data.
- **[[Human-readable]]** vs **[[Non-human-readable]]** — a contract PDF vs. a serialized binary blob; classification still applies to both.

### Data classification

| Level (commercial) | Level (government) | Example |
|---|---|---|
| Public | Unclassified | Marketing site |
| Sensitive / Internal | Confidential | Org chart |
| Private | Secret | Employee salaries |
| Restricted / Critical | Top Secret | Encryption keys, M&A plans |

Classification drives **[[data labeling]]**, which drives policy enforcement in [[DLP]] and [[IRM]]/[[DRM]] systems.

### Methods of securing data

- **[[Encryption]]** — reversible with a key. [[AES-256]] for symmetric, [[RSA]]/[[ECC]] for asymmetric. Reversible by design.
- **[[Hashing]]** — one-way. [[SHA-256]], [[SHA-3]]. Used for integrity, not confidentiality. Not reversible.
- **[[Masking]]** — replaces characters in display: `**** **** **** 1234`. Original data still exists underneath.
- **[[Tokenization]]** — replaces sensitive value with a non-sensitive token; mapping lives in a secure **token vault**. Common in [[PCI-DSS]] environments to shrink scope. Token has no mathematical relationship to original.
- **[[Obfuscation]]** — generic term: makes data harder to interpret. Includes masking, steganography, code obfuscation.
- **[[Geographic restrictions]]** / **[[geofencing]]** — enforces [[data sovereignty]] requirements (e.g., EU data must stay in EU under GDPR).
- **[[Segmentation]]** — network or storage isolation so a breach in one zone doesn't reach another. Cardholder Data Environment (CDE) isolation is the canonical example.
- **[[Permission restrictions]]** — [[RBAC]], [[ABAC]], [[ACLs]], [[least privilege]], [[need-to-know]].

### Encryption-vs-tokenization-vs-hashing-vs-masking cheat table

| Method | Reversible? | Needs key? | Needs vault? | Typical use |
|---|---|---|---|---|
| Encryption | Yes (with key) | Yes | No | Files, disks, traffic |
| Hashing | No | No (optional salt/pepper) | No | Password storage, integrity |
| Tokenization | Yes (via vault lookup) | No | Yes | PCI cardholder data |
| Masking | Sometimes (display only) | No | No | Customer service screens |

### Supporting controls

- **[[DLP]]** — Data Loss Prevention. Inspects content against policy at endpoint, network, and cloud. Blocks or alerts on classified data leaving its zone.
- **[[IRM]]/[[DRM]]** — binds usage policy to the file itself (open, print, forward, expire).
- **[[Key management]]** — [[KMS]], [[HSM]], key rotation, key escrow. Lose the key, lose the data; leak the key, lose everything.
- **[[Backups]]** — encrypted, tested, off-site, immutable where possible. The [[3-2-1 rule]].
- **[[Data sovereignty]]** — legal jurisdiction follows where bytes physically rest.

### Exam traps to memorize

- Hashing is **not** encryption. If the question says "must be retrieved," hashing is wrong.
- Tokenization is preferred over encryption in **PCI-DSS scope reduction** scenarios.
- Masking protects the **view**, not the **data**. The database still holds the real value.
- FDE protects against device theft (powered off). It does **not** protect a running, logged-in machine.
- TLS protects data in transit; it does **nothing** for data at rest on the server after decryption.

## Related concepts

[[Data lifecycle]] · [[Data owner vs data custodian]] · [[Data steward]] · [[DLP]] · [[Encryption]] · [[Tokenization]] · [[Hashing]] · [[Key management]] · [[HSM]] · [[Data sovereignty]] · [[GDPR]] · [[PCI-DSS]] · [[Classification]]

---
*Source: VIRGIL knowledge base — 2026-05-08*