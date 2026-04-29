# NDC

## What it is
Like a library's card catalog that tells you *where* data lives without showing you the data itself, a Network Data Classifier (NDC) is a system or policy framework that categorizes data based on sensitivity, type, and handling requirements as it traverses a network. NDC enables organizations to enforce data handling rules — encryption, access control, DLP triggers — based on what the data *is*, not just where it's going.

## Why it matters
During a data exfiltration attempt, an attacker may successfully bypass perimeter controls but still trigger an NDC-integrated DLP solution that recognizes outbound traffic as PII or PCI-scoped card data. In the 2013 Target breach, the absence of properly tuned data classification controls allowed credit card data to flow from POS systems to attacker-controlled servers undetected — a gap NDC frameworks are specifically designed to close.

## Key facts
- NDC works alongside **Data Loss Prevention (DLP)** tools; classification labels tell DLP engines *how aggressively* to act on a data stream
- Common classification tiers: **Public → Internal → Confidential → Restricted/Top Secret** — knowing your org's taxonomy is mandatory before policy enforcement
- NDC policies can be triggered by **content inspection** (regex patterns for SSNs, card numbers), **context** (user role, time of access), or **labels** (metadata tags applied at creation)
- Misclassification is a leading audit failure: over-classification creates friction; under-classification exposes regulated data to unauthorized access
- Under frameworks like **NIST SP 800-60** and **FIPS 199**, data classification directly maps to required security controls — making NDC a compliance mechanism, not just a technical one

## Related concepts
[[Data Loss Prevention]] [[Data Classification]] [[Information Rights Management]] [[FIPS 199]] [[Network Security Monitoring]]