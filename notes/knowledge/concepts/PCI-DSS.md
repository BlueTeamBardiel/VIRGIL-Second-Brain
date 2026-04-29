# PCI-DSS

## What it is
Think of it like a health code inspection for restaurants — except instead of checking kitchen temperatures, auditors verify how you handle credit card data. PCI-DSS (Payment Card Industry Data Security Standard) is a private regulatory framework created by the major card brands (Visa, Mastercard, Amex, etc.) that mandates specific security controls for any organization that stores, processes, or transmits cardholder data. Compliance is contractually required, not law — but non-compliance can result in fines and loss of payment processing privileges.

## Why it matters
In 2013, Target suffered a breach where attackers pivoted from a third-party HVAC vendor to compromise point-of-sale systems, stealing ~40 million credit card numbers. PCI-DSS Requirement 12.8 mandates managing third-party vendor risk — had Target enforced network segmentation and vendor access controls per PCI-DSS guidelines, lateral movement would have been dramatically harder. This breach directly accelerated PCI-DSS enforcement scrutiny across retail.

## Key facts
- **12 core requirements** organized around 6 goals: build/maintain a secure network, protect cardholder data, manage vulnerabilities, control access, monitor/test networks, and maintain an information security policy
- **4 merchant compliance levels** based on annual transaction volume — Level 1 (>6M transactions/year) requires an annual on-site audit by a **Qualified Security Assessor (QSA)**
- **Requirement 3** mandates that stored PANs (Primary Account Numbers) be rendered unreadable via hashing, truncation, or encryption — storing raw CVV data is prohibited under any circumstance
- **Requirement 11** requires quarterly external vulnerability scans by an **Approved Scanning Vendor (ASV)** and annual penetration testing
- PCI-DSS is **not a law** — it's a contractual standard enforced through merchant agreements with card brands

## Related concepts
[[Data Encryption]] [[Network Segmentation]] [[Vulnerability Scanning]] [[Third-Party Risk Management]] [[Tokenization]]