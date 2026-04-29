# Security Audit

## What it is
Like a financial auditor who checks every ledger entry against receipts to catch fraud or error, a security audit systematically examines an organization's controls, policies, and systems against a defined standard. It is a formal, evidence-based evaluation that determines whether security controls are implemented correctly, operating as intended, and producing the desired outcome.

## Why it matters
In 2013, Target's PCI DSS audit passed — yet attackers exfiltrated 40 million credit card numbers months later. The breach exposed how an audit can certify compliance on paper while missing third-party vendor access paths entirely. This case drove regulators to tighten supply-chain controls in audit frameworks and showed that compliance ≠ security.

## Key facts
- **Types:** Internal audits (self-assessment), external audits (third-party), and regulatory audits (mandated by law/standard like PCI DSS, HIPAA, SOX) each carry different authority and scope.
- **Audit vs. Assessment vs. Penetration Test:** Audits measure conformance to standards; assessments identify risk posture; pen tests actively exploit vulnerabilities — Security+ tests this distinction directly.
- **Evidence types include:** interviews, observation, document review, and configuration inspection — auditors use all four to avoid relying on a single source of truth.
- **Audit trail integrity** is critical: logs must be tamper-evident (write-once storage, cryptographic hashing) so the audit process itself cannot be undermined.
- **Common frameworks audits validate against:** ISO 27001, NIST SP 800-53, CIS Controls, PCI DSS, and SOC 2 Type II — each defines specific control objectives examiners verify.

## Related concepts
[[Compliance Frameworks]] [[Risk Assessment]] [[Log Management]] [[Penetration Testing]] [[Change Management]]