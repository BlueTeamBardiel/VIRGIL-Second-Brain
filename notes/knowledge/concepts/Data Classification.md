# Data classification

## What it is
Think of a hospital triage system: not every patient gets the ICU — severity determines resources. Data classification works the same way, sorting organizational data into labeled tiers based on sensitivity and required protection, so security controls and access privileges scale proportionally to the actual risk of exposure.

## Why it matters
In 2017, an Equifax contractor accidentally left a misconfigured server exposing 147 million Social Security Numbers — data that should have been classified as highly sensitive with strict access controls. A mature classification scheme would have triggered mandatory encryption, access logging, and network segmentation requirements before that data ever touched an internet-facing system, dramatically shrinking the attack surface.

## Key facts
- **Common government tiers**: Unclassified → Confidential → Secret → Top Secret (each tier requires progressively strict handling, storage, and clearance levels)
- **Common commercial tiers**: Public → Internal/Private → Confidential → Restricted (or equivalent four-level frameworks)
- **Data owners** assign classification labels; **data custodians** (often IT) implement the technical controls that enforce them — Security+ distinguishes these roles explicitly
- **DLP (Data Loss Prevention)** tools rely entirely on classification labels to identify what to block, quarantine, or encrypt in transit
- **PII, PHI, and PCI-DSS data** are legally-mandated classification categories — mishandling them triggers regulatory fines (HIPAA, GDPR), not just internal policy violations
- Reclassification must occur when data context changes — a public earnings report is public after release, but strictly confidential the day before

## Related concepts
[[Data Loss Prevention]] [[Access Control]] [[Information Rights Management]] [[PII and PHI]] [[Data Governance]]