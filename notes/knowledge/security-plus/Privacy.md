# Privacy

## What it is

In Tekken, every character has a movelist — but a skilled player hides which strings they'll throw, mixes up Heihachi's Hellsweep with his Demon Uppercut, and never lets you read their inputs through the controller cam. **Privacy** does the same thing: it's the principle that personal data should only be visible to those who need it, in the form they need, and never broadcast to the whole arcade.

**Privacy** in SY0-701 terms is the legal, ethical, and technical requirement to control how personally identifiable information ([[PII]]) and sensitive data are collected, processed, stored, transferred, and disposed of, in alignment with applicable regulations and the data subject's rights.

## Why it matters

Privacy failures detonate companies. A single mishandled dataset can trigger [[GDPR]] fines of 4% of global annual revenue, class-action lawsuits, and irreversible brand damage — see Equifax, Marriott, Meta. Objective **5.4** explicitly tests **data subject rights**, **controller vs. processor responsibilities**, and the distinction between **right to be forgotten** and routine data retention. CompTIA's favorite trap: confusing **privacy** (the rights and obligations around personal data) with **confidentiality** (a CIA-triad property meaning "unauthorized parties can't read it"). Confidentiality is a *control*; privacy is a *legal regime*. Encrypting data does not make you GDPR-compliant.

## Key facts

### Privacy vs. Confidentiality

| Property | Scope | Driven by |
|---|---|---|
| [[Confidentiality]] | All sensitive data, any type | CIA triad / security policy |
| **Privacy** | Personal data about identifiable humans | Law, regulation, ethics |

You can have confidentiality without privacy (encrypted but unlawfully collected) and privacy without confidentiality (lawful collection that gets breached).

### Roles in the data ecosystem

- **[[Data Subject]]** — the human the data is about. Has rights.
- **[[Data Owner]]** — senior business role accountable for data classification and use.
- **[[Data Controller]]** — entity that decides *why* and *how* personal data is processed (legal liability sits here).
- **[[Data Processor]]** — entity that processes data on the controller's behalf (cloud provider, payroll vendor).
- **[[Data Custodian]]** / **[[Data Steward]]** — technical handler; implements controls, enforces policy.
- **[[Data Protection Officer]] (DPO)** — required role under GDPR for certain organizations; oversees compliance.

### Data subject rights (GDPR-style, exam-relevant)

- **Right to access** — "show me what you have on me"
- **[[Right to be Forgotten]]** (erasure) — delete my data
- **Right to rectification** — fix incorrect data
- **Right to data portability** — export in usable format
- **Right to object** — opt out of certain processing
- **Right to restrict processing**

### Key regulations to recognize

| Regulation | Jurisdiction | Focus |
|---|---|---|
| [[GDPR]] | EU | Comprehensive personal data protection |
| [[CCPA]] / CPRA | California | Consumer data rights, sale of data |
| [[HIPAA]] | US (healthcare) | Protected health info ([[PHI]]) |
| [[GLBA]] | US (finance) | Financial customer privacy |
| [[COPPA]] | US (children under 13) | Parental consent |
| [[PCI DSS]] | Global (card industry) | Cardholder data — contractual, not law |

### Data types under privacy scrutiny

- **[[PII]]** — personally identifiable information (name, SSN, address, biometrics)
- **[[PHI]]** — protected health information
- **[[Financial Information]]** — account numbers, transactions
- **[[Sensitive PII]]** — religion, sexual orientation, political views, genetic data

### Privacy-supporting controls

- **[[Data Classification]]** — public, private, confidential, restricted
- **[[Data Minimization]]** — collect only what you need
- **[[Purpose Limitation]]** — use data only for stated purposes
- **[[Anonymization]]** — irreversibly strip identifiers
- **[[Pseudonymization]]** — replace identifiers with tokens (reversible with key)
- **[[Tokenization]]** — substitute sensitive values with non-sensitive tokens
- **[[Data Masking]]** — obscure data in non-production environments
- **[[Encryption]]** — at rest, in transit, in use
- **[[Data Retention]]** policies — keep only as long as legally needed
- **[[Privacy Notice]]** / **[[Consent Management]]**

### CompTIA exam traps

- **Anonymization is irreversible; pseudonymization is reversible.** They are not synonyms.
- **Right to be forgotten ≠ data retention deletion.** One is a subject's request; the other is a scheduled purge.
- **The processor is not the controller.** The controller bears primary legal responsibility.
- **PCI DSS is contractual,** not legislation. Don't pick it as "the law."

## Related concepts

[[PII]] · [[GDPR]] · [[Data Classification]] · [[Right to be Forgotten]] · [[Tokenization]] · [[Anonymization]] · [[Data Controller]] · [[Data Processor]] · [[Data Retention]] · [[Confidentiality]] · [[HIPAA]] · [[Data Minimization]]

---
*Source: VIRGIL knowledge base — 2026-05-08*