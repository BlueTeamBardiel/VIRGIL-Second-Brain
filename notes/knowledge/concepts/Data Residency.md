# Data Residency

## What it is
Like a diplomat who can only be questioned under their home country's laws, data residency defines the physical or geographic location where data must be stored and processed. It is a legal and compliance requirement specifying that certain data must remain within defined national or regional boundaries, governing which jurisdictions' laws apply to that data.

## Why it matters
A European healthcare company storing patient records on U.S.-based cloud servers triggered GDPR violations when American law enforcement issued a subpoena, forcing disclosure of data that EU law protected. Proper data residency controls — using EU-region cloud instances and contractual Standard Contractual Clauses (SCCs) — would have kept that data legally protected under European jurisdiction. This scenario appears regularly in cloud compliance audits and breach investigations.

## Key facts
- **GDPR Article 44** restricts transfer of EU personal data outside the European Economic Area (EEA) unless the destination country has "adequate" protection or approved safeguards are in place
- Data residency ≠ data sovereignty: residency specifies *where* data sits; sovereignty specifies *who has legal authority* over it
- Cloud providers address residency through **region-pinning** — customers select specific geographic regions (e.g., AWS eu-west-1) to guarantee physical storage location
- Failure to enforce data residency can constitute a **reportable data breach** under some regulations, even without a malicious actor
- Security+ and CySA+ frame data residency under **data classification, privacy regulations, and cloud security** domains — commonly paired with questions about compliance frameworks like GDPR, HIPAA, and FedRAMP

## Related concepts
[[Data Sovereignty]] [[Cloud Security]] [[GDPR Compliance]] [[Data Classification]] [[Privacy Regulations]]