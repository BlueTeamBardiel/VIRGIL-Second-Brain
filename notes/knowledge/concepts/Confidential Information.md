# Confidential Information

## What it is
Think of confidential information like a doctor's patient chart — it belongs to a specific person, carries real-world consequences if exposed, and access is strictly need-to-know. Precisely defined, confidential information is data classified at a sensitivity level that restricts its disclosure to authorized individuals, where unauthorized exposure causes measurable harm to individuals, organizations, or national security. It sits within a formal data classification scheme, typically below "secret" or "top secret" in government frameworks but above "public" or "internal" in corporate ones.

## Why it matters
In the 2017 Equifax breach, attackers exfiltrated 147 million records containing Social Security numbers, birth dates, and addresses — all confidential PII under regulatory frameworks like GLBA and FCRA. The failure to properly segment and protect classified data cost Equifax over $700 million in settlements, demonstrating that mishandling confidential information carries both financial and legal consequences that directly follow from inadequate access controls and encryption.

## Key facts
- **Data classification levels** (government): Unclassified → Controlled Unclassified Information (CUI) → Confidential → Secret → Top Secret
- **Corporate equivalents**: Public → Internal → Confidential → Restricted/Proprietary — organizations must define these in a formal **Data Classification Policy**
- Confidential data requires controls including **encryption at rest and in transit**, access logging, and need-to-know enforcement via **least privilege**
- Regulatory frameworks like **HIPAA, PCI-DSS, and GDPR** legally mandate protection of specific confidential data categories (PHI, cardholder data, PII)
- **Data Loss Prevention (DLP)** tools enforce confidentiality by detecting and blocking unauthorized transmission of classified content

## Related concepts
[[Data Classification]] [[Personally Identifiable Information (PII)]] [[Data Loss Prevention]] [[Least Privilege]] [[Need to Know]]