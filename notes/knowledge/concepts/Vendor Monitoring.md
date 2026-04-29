# Vendor Monitoring

## What it is
Like a restaurant that checks health inspection scores before letting a supplier deliver ingredients, vendor monitoring is the ongoing process of evaluating third-party partners to ensure they maintain acceptable security postures. It goes beyond the initial contract — continuously assessing vendors through audits, questionnaires, security ratings, and incident disclosures throughout the business relationship.

## Why it matters
The 2020 SolarWinds attack demonstrated exactly what happens when vendor monitoring fails: attackers compromised SolarWinds' build pipeline, and roughly 18,000 organizations automatically trusted and installed the backdoored Orion updates because no continuous monitoring caught the anomalous software signing activity. Organizations with mature vendor monitoring programs that tracked unusual network behavior from SolarWinds infrastructure had earlier warning signals to act on.

## Key facts
- **Right-to-audit clauses** in vendor contracts give organizations the legal authority to inspect a vendor's security controls directly — critical for high-risk suppliers.
- Vendor monitoring feeds into **Supply Chain Risk Management (SCRM)**, which is explicitly tested on Security+ and CySA+ as a framework for managing third-party threats.
- **Security ratings services** (e.g., BitSight, SecurityScorecard) provide continuous, outside-in scoring of vendor security posture using passive data like exposed credentials and patching cadence.
- Vendors should be tiered by **data sensitivity and access level** — a vendor with access to PII or production systems requires more rigorous monitoring than one providing office supplies.
- **End-of-life (EOL) software** used by vendors is a key monitoring flag — unsupported systems in a vendor's environment become your attack surface through interconnected access.

## Related concepts
[[Supply Chain Risk Management]] [[Third-Party Risk Management]] [[Due Diligence]] [[Vendor Assessment]] [[Attack Surface Management]]