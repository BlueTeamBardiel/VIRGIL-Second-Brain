# Sensitive Information Handling

## What it is
Think of sensitive data like radioactive material in a lab — it needs specific containers, labeled warnings, restricted access, and documented chain of custody at every step. Sensitive information handling is the set of policies, technical controls, and procedures that govern how organizations collect, store, transmit, and destroy data classified as confidential, PII, PHI, or otherwise regulated. The goal is ensuring data is protected commensurate with its classification level throughout its entire lifecycle.

## Why it matters
In 2017, an Equifax breach exposed 147 million records because unencrypted PII sat in systems with excessive access permissions and no proper data classification controls. If Equifax had enforced need-to-know access, encrypted data at rest, and applied proper data retention policies, the blast radius of the breach would have been dramatically reduced. This is the direct consequence of treating sensitive data like ordinary data.

## Key facts
- **Data classification tiers** (Public → Internal → Confidential → Restricted) determine which controls apply — misclassifying data upward wastes resources; downward creates exposure
- **Data at rest** must be encrypted (AES-256 is the benchmark); **data in transit** requires TLS 1.2+ minimum per current compliance frameworks
- **PII vs. PHI vs. PCI** are distinct regulatory buckets — GDPR/CCPA govern PII, HIPAA governs PHI, PCI-DSS governs cardholder data — each carries separate breach notification timelines
- **Secure disposal** is mandatory: paper requires cross-cut shredding, drives require degaussing or physical destruction — "delete" is not compliant destruction
- **Data minimization** (collecting only what you need) is a foundational GDPR principle and reduces attack surface by shrinking what adversaries can steal

## Related concepts
[[Data Classification]] [[Data Loss Prevention (DLP)]] [[Encryption at Rest and in Transit]] [[Privacy Regulations and Compliance]] [[Least Privilege]]