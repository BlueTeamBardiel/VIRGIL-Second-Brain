# Integrity Baseline

## What it is
Like a jeweler photographing every piece before shipping — so any missing diamond is immediately obvious upon arrival — an integrity baseline is a documented, trusted snapshot of a system's known-good state. It captures file hashes, registry keys, configurations, and running processes at a moment when the system is verified clean. Any future deviation from this snapshot signals potential compromise or unauthorized change.

## Why it matters
During a ransomware investigation, a SOC analyst can compare current file hashes against the integrity baseline to identify exactly which executables were modified or dropped by the attacker — pinpointing patient zero and the attack timeline. Without the baseline, distinguishing malicious binaries from legitimate system files becomes guesswork. This is precisely how tools like Tripwire detect rootkits that modify system binaries to hide their presence.

## Key facts
- Integrity baselines are a core component of **configuration management** and **change management** programs under frameworks like NIST SP 800-53 (CM-3, SI-7).
- File integrity monitoring (FIM) tools continuously compare live system state against the baseline using cryptographic hashes (SHA-256 preferred over MD5).
- A baseline must be created **after** hardening and **before** production deployment — a baseline built on a compromised system is worthless.
- The **CIS Benchmarks** provide standardized configuration baselines for operating systems, applications, and network devices used as integrity references.
- On the CySA+ exam, integrity baselines appear in the context of **anomaly detection**, **host-based IDS (HIDS)**, and **incident response** — deviations trigger alerts.

## Related concepts
[[File Integrity Monitoring]] [[Configuration Management]] [[Change Management]] [[Host-Based IDS]] [[Hardening]]