# log availability

## What it is
Like a security camera whose footage gets recorded over every 24 hours, log availability refers to whether security logs exist, are accessible, and are retained long enough to be useful when you need them. Precisely: it is the assurance that audit and event logs are present, uncorrupted, and retrievable for investigation, compliance, or incident response within a defined retention window.

## Why it matters
During a breach investigation, analysts discovered that an attacker had spent 47 days moving laterally inside a network — but the firewall logs only retained 30 days of data. The critical early-stage evidence showing the initial intrusion vector was permanently gone, making root cause analysis impossible and leaving the organization exposed to repeat attacks. Log availability failures don't just slow investigations; they can make attribution and remediation practically impossible.

## Key facts
- **Retention requirements vary by framework**: PCI-DSS requires 12 months of log retention (3 months immediately available); HIPAA requires 6 years; NIST SP 800-92 guides general log management practices.
- **Attackers actively target logs**: Clearing Windows Event Logs (e.g., `wevtutil cl`) is a standard post-exploitation anti-forensics technique — MITRE ATT&CK T1070.001.
- **Centralized logging (SIEM/syslog) protects availability**: Logs stored only on compromised hosts can be deleted by attackers; remote forwarding preserves evidence integrity.
- **Log rotation without archiving is a silent killer**: Systems set to overwrite logs after size limits are hit will silently destroy evidence without any alert.
- **Availability ≠ Integrity**: Logs must also be tamper-evident — write-once storage or cryptographic hashing ensures logs haven't been modified after collection.

## Related concepts
[[SIEM]] [[log integrity]] [[log management]] [[data retention policy]] [[anti-forensics]]