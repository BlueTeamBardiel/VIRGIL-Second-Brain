# Data Retention

## What it is
Like a hospital that must keep patient records for 7 years before shredding them — but faces liability if they keep them too long — data retention is the formal policy governing *how long* an organization stores specific types of data before secure deletion. It defines minimum and maximum storage periods for data based on legal, regulatory, and business requirements.

## Why it matters
In the 2017 Equifax breach, attackers exfiltrated 145 million records — many of which Equifax had no legitimate business reason to still possess. Proper retention policies enforce deletion of aged PII, shrinking the blast radius of a breach. Conversely, deleting logs too early can destroy forensic evidence needed to reconstruct an incident timeline.

## Key facts
- **Legal hold** overrides normal retention schedules — when litigation is anticipated, data destruction must immediately pause regardless of policy
- HIPAA requires medical records retention for a **minimum of 6 years** from creation or last use; state laws may extend this further
- Security logs (SIEM, firewall, IDS) are commonly retained for **90 days online / 1 year archived** as a baseline, but PCI-DSS mandates at least **12 months** of audit log retention
- Failure to enforce **maximum** retention limits violates GDPR's storage limitation principle (Article 5), creating regulatory exposure even without a breach
- Data retention policies must address **all media types**: cloud storage, backups, physical drives, email archives, and removable media

## Related concepts
[[Data Classification]] [[Legal Hold]] [[Data Destruction]] [[GDPR Compliance]] [[Log Management]]