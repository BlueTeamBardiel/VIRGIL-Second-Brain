# Compliance Auditing

## What it is
Think of it like a health inspector visiting a restaurant — not to fix problems, but to verify the kitchen meets documented standards and issue a grade. Compliance auditing is the systematic process of evaluating an organization's controls, policies, and procedures against a defined regulatory framework (PCI DSS, HIPAA, SOX, NIST) to verify requirements are being met. The output is evidence-backed confirmation of conformance — or a finding that triggers remediation.

## Why it matters
In 2019, Capital One suffered a breach exposing 100 million customer records, yet had passed multiple PCI DSS audits beforehand. This illustrates a critical gap: compliance auditing confirms controls *exist* at a point in time — it doesn't guarantee they're *effective* continuously. The breach drove regulators to push harder for continuous compliance monitoring rather than annual snapshot audits.

## Key facts
- **Gap analysis** compares current state against a compliance framework to identify what controls are missing or insufficient before a formal audit
- **PCI DSS** requires quarterly external vulnerability scans by an Approved Scanning Vendor (ASV) and annual penetration testing as auditable evidence
- **Audit trails** (logs) must demonstrate *non-repudiation* — an auditor needs proof actions were taken by specific identities at specific times
- **Internal audits** are conducted by the organization itself; **external audits** by a third party — external findings carry more weight with regulators and clients
- Compliance does **not** equal security — a system can be 100% compliant and still be breached if the framework doesn't cover the attack vector used

## Related concepts
[[Risk Assessment]] [[Security Controls]] [[Log Management]] [[PCI DSS]] [[Chain of Custody]]