# PCI DSS

## What it is
Think of it like a health inspection code for restaurants — if you want to legally serve food (process card payments), you must meet a specific checklist of safety standards or face fines and lose your license. PCI DSS (Payment Card Industry Data Security Standard) is a contractual security framework created by major card brands (Visa, Mastercard, etc.) that mandates how organizations must protect cardholder data during storage, processing, and transmission. It is enforced through merchant agreements, not law, but non-compliance can result in fines and loss of payment processing privileges.

## Why it matters
In the 2013 Target breach, attackers compromised an HVAC vendor's credentials to pivot into Target's network and exfiltrate ~40 million credit card numbers. This directly violated multiple PCI DSS requirements — including network segmentation (Requirement 1) and third-party vendor access controls (Requirement 12.8) — resulting in over $200 million in fines and settlements.

## Key facts
- **12 core requirements** organized around six goals: build a secure network, protect cardholder data, manage vulnerabilities, control access, monitor networks, and maintain an information security policy
- **Cardholder Data Environment (CDE)** is the defined scope — organizations must isolate and shrink it using network segmentation to reduce compliance burden
- **Four merchant levels** exist based on annual transaction volume; Level 1 (6M+ transactions/year) requires an annual on-site audit by a Qualified Security Assessor (QSA)
- **Requirement 3** prohibits storing sensitive authentication data (CVV, full magnetic stripe) after authorization — full PANs must be rendered unreadable via hashing, truncation, or encryption
- **Requirement 11** mandates quarterly external vulnerability scans by an Approved Scanning Vendor (ASV) and annual penetration testing

## Related concepts
[[Network Segmentation]] [[Data Encryption]] [[Vulnerability Scanning]] [[Third-Party Risk Management]] [[Tokenization]]