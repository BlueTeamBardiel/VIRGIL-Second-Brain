# Evidence of Internal Audits

## What it is
Like a ship's captain keeping a logbook of every inspection, course correction, and crew incident — evidence of internal audits is the documented proof that an organization periodically reviews its own security controls, policies, and compliance posture. It includes audit reports, findings logs, remediation tickets, sign-off records, and corrective action plans that demonstrate due diligence occurred at a specific point in time.

## Why it matters
During a breach investigation at a healthcare company, regulators discovered the organization *claimed* quarterly access reviews but had zero documentation to prove it — resulting in HIPAA penalties not just for the breach, but for the compliance failure itself. Having timestamped audit evidence (who reviewed what, when, and what was fixed) can be the difference between demonstrating reasonable care and facing maximum liability. It also enables defenders to spot recurring control failures that attackers later exploit.

## Key facts
- Internal audit evidence supports **due care** and **due diligence** — two legally significant concepts in regulatory frameworks like HIPAA, PCI-DSS, and SOX
- Audit trails must demonstrate **who conducted the review**, **what controls were tested**, **findings identified**, and **remediation status**
- Lack of audit evidence is itself a finding during external audits and can trigger **audit failure** even if underlying controls are functioning
- CySA+ candidates should know that internal audits feed directly into the **risk management lifecycle** and inform vulnerability prioritization
- Audit logs must be **protected from tampering** — storing them in a WORM (Write Once, Read Many) system or SIEM ensures integrity of the evidence itself

## Related concepts
[[Due Diligence vs Due Care]] [[Compliance Frameworks]] [[Risk Management Lifecycle]] [[Security Information and Event Management (SIEM)]] [[Chain of Custody]]