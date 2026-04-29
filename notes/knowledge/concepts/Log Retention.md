# Log Retention

## What it is
Like a flight recorder that's only useful if it captured the moment before the crash, logs are only useful for investigations if you kept them long enough. Log retention is the policy and practice of defining how long system, application, and security event logs are stored before deletion or archival.

## Why it matters
In the 2020 SolarWinds supply chain attack, defenders needed months of historical logs to reconstruct attacker lateral movement — organizations that purged logs on short cycles couldn't trace the full breach timeline. Attackers who dwell inside networks for 200+ days rely on victims deleting the evidence of their early intrusion steps before anyone notices.

## Key facts
- **PCI DSS** requires a minimum of **12 months** of log retention, with at least **3 months** immediately available for analysis — a common exam benchmark
- **HIPAA** mandates audit log retention for **6 years** from creation or last effective date
- Logs should be stored in a **write-once, tamper-evident** location (e.g., WORM storage or a remote SIEM) so attackers who gain access cannot delete evidence of their presence
- The **three phases** of log lifecycle are: active storage (hot/searchable), archival (cold/compressed), and deletion — each governed by retention policy
- Insufficient retention violates the **detect** and **respond** functions of the NIST Cybersecurity Framework, directly undermining incident response capability

## Related concepts
[[SIEM]] [[Audit Logs]] [[Chain of Custody]] [[Incident Response]] [[Data Classification]]