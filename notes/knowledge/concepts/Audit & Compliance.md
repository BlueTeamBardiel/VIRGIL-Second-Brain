# Audit & Compliance

## What it is
Think of it like a restaurant health inspection — an independent party walks through your kitchen, checks temperatures, examines licenses, and issues a score against a known standard. Audit & Compliance is the systematic process of reviewing an organization's security controls, policies, and practices against defined regulatory frameworks (PCI-DSS, HIPAA, SOC 2, ISO 27001) to verify requirements are actually met. Audits produce evidence-based findings; compliance is the ongoing state of satisfying those requirements.

## Why it matters
In 2013, Target was breached via a third-party HVAC vendor — investigators found Target was PCI-DSS compliant on paper yet had misconfigured network segmentation that allowed lateral movement to cardholder data. This illustrates the critical distinction between **compliance** (passing a checklist) and **security** (actual risk reduction) — a concept examiners love to test. Continuous monitoring and internal audits are the mechanisms that catch drift between assessments.

## Key facts
- **Internal audits** are conducted by the organization itself; **external audits** by independent third parties — external findings carry more weight for regulatory purposes
- **Due diligence** = researching and assessing risk *before* a decision; **due care** = ongoing actions taken to maintain security after — both are audit targets
- A **compliance gap analysis** compares current controls against a framework baseline to prioritize remediation efforts
- **Chain of custody** documentation is required during audits to ensure evidence integrity hasn't been compromised
- **SIEM logs** are primary audit artifacts — log retention requirements vary by framework (HIPAA requires 6 years; PCI-DSS requires 1 year minimum with 3 months immediately available)

## Related concepts
[[SIEM & Log Management]] [[Risk Management]] [[Data Classification]] [[Identity & Access Management]] [[Vulnerability Management]]