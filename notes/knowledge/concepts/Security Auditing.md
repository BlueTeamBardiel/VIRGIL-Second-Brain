# security auditing

## What it is
Like a restaurant health inspector who shows up unannounced and checks every walk-in fridge and prep surface against a checklist — not to cook the food, but to verify standards are being met — a security audit is a systematic, evidence-based evaluation of an organization's security controls, policies, and practices against a defined standard or baseline. It produces a documented record of what exists, what's missing, and what's broken, independent of day-to-day operations.

## Why it matters
In 2013, Target passed a PCI DSS compliance audit shortly before attackers exfiltrated 40 million credit card numbers through a third-party HVAC vendor. The audit had verified controls on paper, but failed to catch network segmentation gaps between vendor access and payment systems — illustrating that audits are only as good as their scope and methodology. This drove industry adoption of continuous auditing and vendor risk assessments as audit components.

## Key facts
- **Types**: Internal audits (performed by staff), external audits (independent third party), and regulatory audits (mandated by law, e.g., SOX, HIPAA, PCI DSS)
- **Audit trail**: A tamper-evident chronological log of system events; auditors verify these logs exist, are protected, and meet retention requirements
- **Due diligence vs. due care**: Audits verify *due diligence* (researching proper controls) and *due care* (actually implementing them) — both tested on Security+
- **Common frameworks**: NIST SP 800-53, ISO/IEC 27001, CIS Controls, and COBIT are standard audit baselines
- **Audit vs. assessment vs. pentest**: Audits measure compliance against a standard; assessments identify risks; pentests actively exploit vulnerabilities — these are distinct and often confused on exams

## Related concepts
[[compliance frameworks]] [[log management]] [[risk assessment]] [[change management]] [[chain of custody]]