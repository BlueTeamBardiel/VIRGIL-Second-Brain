# MITRE ATT&CK T1499 Resource Hijacking

## What it is
Like a squatter who sneaks into your warehouse at night to run their own manufacturing operation using your electricity, equipment, and labor — Resource Hijacking occurs when an adversary compromises a system and uses its CPU, GPU, network bandwidth, or cloud compute to generate profit for themselves, typically through cryptocurrency mining. The victim pays the operational costs while the attacker collects the rewards.

## Why it matters
In 2021, attackers compromised misconfigured Kubernetes clusters exposed to the internet, deploying XMRig miners that consumed 100% of CPU across hundreds of nodes, causing legitimate workloads to fail and generating massive cloud billing spikes before detection. Organizations discovered the breach not through alerts, but through unexpected AWS invoices exceeding $10,000 in a single week.

## Key facts
- **Sub-techniques include T1496.001 (Compute Hijacking)** — specifically targeting CPU/GPU for cryptomining using tools like XMRig or NiceHash
- **Detection signals**: sustained high CPU/GPU utilization, unusual outbound connections to mining pools (ports 3333, 4444, 14444), and unexpected cloud cost increases
- **Cloud environments are primary targets** — compromised IAM credentials or misconfigured container orchestration (Kubernetes, Docker) provide scalable compute at victim's expense
- **Cryptojacking is the dominant use case** — Monero (XMR) is preferred because its RandomX algorithm is CPU-friendly and transactions are privacy-shielded, reducing traceability
- **Persistence mechanisms matter** — attackers use cron jobs, systemd services, or container image backdoors to survive reboots and maintain mining continuity

## Related concepts
[[Cryptojacking]] [[Cloud Security Misconfiguration]] [[Container Security]] [[Persistence Mechanisms]] [[Anomaly-Based Detection]]