---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 068
source: rewritten
---

# Data Types and Classifications
**Organizations must handle different categories of information with vastly different protection strategies based on regulatory requirements, sensitivity, and ownership rules.**

---

## Overview
Information assets represent one of an organization's most valuable possessions, yet not every piece of data demands identical safeguarding approaches. The Security+ exam expects you to understand how different data categories trigger different compliance obligations, threat models, and security controls. Misclassifying data can lead to inadequate protection, regulatory violations, and breach liability.

---

## Key Concepts

### Regulated Data
**Analogy**: Think of regulated data like prescription medication—the government doesn't care what color the bottle is, but it has very specific rules about how it must be stored, handled, and distributed. Break those rules and you face penalties.

**Definition**: Information that falls under third-party compliance frameworks where external authorities mandate specific security and handling procedures.

**Examples**:
- [[Payment Card Industry Data Security Standard (PCI-DSS)]] governs [[credit card data]]
- [[Health Insurance Portability and Accountability Act (HIPAA)]] controls [[patient health records]]
- [[General Data Protection Regulation (GDPR)]] regulates [[EU citizen personal data]]

| Regulation | Data Type | Key Control | Consequence |
|---|---|---|---|
| [[PCI-DSS]] | Payment cards | Encryption, tokenization | Fines, processing loss |
| [[HIPAA]] | Medical records | Access controls, audit logs | Civil penalties |
| [[GDPR]] | Personal data | Consent, deletion rights | % revenue fines |

---

### Trade Secrets
**Analogy**: Trade secrets are like a restaurant's secret recipe—everyone can taste the dish, but the ingredient list and proportions are jealously guarded because they're your competitive edge.

**Definition**: Proprietary processes, formulas, strategies, or methodologies unique to an organization that provide competitive advantage and would cause harm if disclosed.

**Characteristics**:
- Known only internally
- Generate business value through secrecy
- Require confidentiality agreements ([[NDAs]])
- Protected through [[access control]] rather than public registration
- Examples: manufacturing processes, customer lists, algorithms, pricing models

---

### Intellectual Property
**Analogy**: If trade secrets are locked diaries, intellectual property is a published book with your name on the cover—people can see it, but you legally own the right to distribute and profit from it.

**Definition**: Creations of the mind (inventions, designs, names, artistic works) that are protected through legal mechanisms rather than secrecy alone.

**Protection Methods**:
| IP Type | Protection Mechanism | Duration | Use Case |
|---|---|---|---|
| [[Copyright]] | Automatic upon creation | Life + 70 years | Software, written works, creative content |
| [[Trademark]] | Registration required | Indefinite (with renewal) | Brand names, logos, slogans |
| [[Patent]] | Patent office filing | 20 years (utility) | Novel inventions, processes |
| [[Trade Secret]] | Confidentiality controls | Indefinite (if secret maintained) | Proprietary methods, formulas |

---

### Legal Information
**Analogy**: Court proceedings are like a town hall meeting—the official discussion is open to the public, but certain private conversations (like attorney-client discussions) remain confidential to ensure justice works properly.

**Definition**: Data generated through legal proceedings that typically must remain publicly accessible, while simultaneously protecting sensitive personal or strategic information embedded within those records.

**Dual Nature**:
- **Public**: Court documents, judge identities, case outcomes, attorney records
- **Private**: [[Personally Identifiable Information (PII)]], sealed records, victim information, trade secrets mentioned in litigation

---

### Personally Identifiable Information (PII)
**Analogy**: PII is like a house address—it seems innocent on its own, but combined with other data points (phone, birthday, SSN), someone can unlock access to your entire life.

**Definition**: Any information that can be used to identify, contact, or locate an individual, either alone or in combination with other data.

**PII Categories**:
- Direct identifiers: Name, SSN, passport number, biometric data
- Quasi-identifiers: Birthdate, zip code, gender (dangerous in combination)
- Contact information: Email, phone, mailing address
- Sensitive attributes: Financial account numbers, medical conditions, religious affiliation

**Why it matters**: Breaching PII triggers [[notification laws]], regulatory fines, and reputational damage. Organizations must apply [[encryption]], [[access controls]], and [[data minimization]] principles.

---

## Exam Tips

### Question Type 1: Data Classification Matching
- *"Your organization stores patient medical histories. Which regulation mandates the handling of this data?"* → [[HIPAA]] (US healthcare) or [[GDPR]] (EU residents)
- **Trick**: The exam mixes similar-sounding regulations. HIPAA is US healthcare only; GDPR applies globally to EU citizens' data.

### Question Type 2: Control Selection by Data Type
- *"Which of the following is the BEST way to protect trade secrets?"* → [[Access control]] + [[confidentiality agreements]] (not public registration like patents)
- **Trick**: Don't confuse trade secrets (secrecy-based) with patents (registration-based protection).

### Question Type 3: PII in Mixed Scenarios
- *"A court filing contains a victim's address and SSN. What classification applies?"* → [[PII]] (even though it's in a legally public document, the information itself is still PII and may be subject to redaction laws)
- **Trick**: Public document ≠ public data. Sensitive information can be private within a public record.

---

## Common Mistakes

### Mistake 1: Assuming All Regulated Data Is Confidential
**Wrong**: "If it's regulated, it must be secret and encrypted."
**Right**: Regulated data can be public (court records are regulated yet open), confidential (medical records), or compartmentalized (legal information with mixed sensitivity).
**Impact on Exam**: You may incorrectly recommend encryption for data that must remain transparent for compliance, or fail to encrypt data you assume is already "regulated enough."

### Mistake 2: Confusing Trade Secrets with Intellectual Property
**Wrong**: "We'll patent our trade secret to protect it forever."
**Right**: Patents require public disclosure and offer 20-year protection; trade secrets remain secret indefinitely if kept confidential. These are inverse strategies.
**Impact on Exam**: Questions ask which protection method to use, and choosing patent for something you need to keep secret = wrong answer.

### Mistake 3: Treating All PII the Same
**Wrong**: "This is just a zip code and gender—it's not sensitive PII like SSN."
**Right**: Quasi-identifiers like zip code + DOB + gender can uniquely identify 87% of the US population. Context matters; combinations are dangerous.
**Impact on Exam**: Underestimating risk leads to wrong control recommendations. Many breach laws trigger on *any* PII, not just "sensitive" PII.

### Mistake 4: Ignoring Jurisdiction in Regulation Questions
**Wrong**: "GDPR applies to all customer data we store."
**Right**: GDPR applies only to data of EU residents, regardless of where the company is based. CCPA applies to California residents. Jurisdiction is the gating factor.
**Impact on Exam**: A question about a Toronto company storing data on California customers requires [[CCPA]] analysis, not just general principles.

---

## Related Topics
- [[Data Handling Procedures]]
- [[Encryption Standards for Regulated Data]]
- [[Retention Policies and Legal Holds]]
- [[Privacy by Design]]
- [[Data Breach Notification Laws]]
- [[Compliance Frameworks (HIPAA, PCI-DSS, GDPR)]]
- [[Access Control Models]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*