# Security Baselines

## What it is
Like a doctor establishing your resting heart rate before a marathon, a security baseline captures the *normal* configuration state of a system so deviations can be detected and enforced. Precisely: a security baseline is a documented minimum set of security controls and configuration settings that a system must meet before deployment and maintain throughout its lifecycle. It serves as both a compliance floor and an anomaly-detection reference point.

## Why it matters
In 2020, the SolarWinds attackers succeeded partly because the malicious Orion updates blended into environments with no enforced configuration baselines — administrators had no documented "normal" to compare against. Had organizations applied and monitored CIS Benchmark baselines for their Windows servers, the unexpected new services and registry keys introduced by the malware would have triggered immediate alerts. Baselines transform vague "something feels wrong" intuition into measurable, auditable facts.

## Key facts
- **CIS Benchmarks** and **DISA STIGs** are the two dominant sources for pre-built security baselines used in enterprise and government environments respectively
- **Microsoft Security Compliance Toolkit** allows organizations to import, customize, and enforce Windows OS baselines via Group Policy
- A baseline must be **versioned and change-controlled** — an undocumented "improvement" to a baseline is indistinguishable from a configuration drift attack
- Security baselines apply to **multiple layers**: OS hardening, network device configs, cloud service settings (e.g., AWS CIS Foundations Benchmark), and application configurations
- On the Security+ exam, baselines are distinguished from **benchmarks** (industry-published reference standards) — an organization *adopts* a benchmark to *create* their baseline

## Related concepts
[[Configuration Management]] [[Hardening]] [[STIG]] [[CIS Benchmarks]] [[Vulnerability Scanning]]