# MITRE ATT&CK T1496

## What it is
Like a squatter secretly running a food truck out of your restaurant kitchen at 3 AM — using your gas, your electricity, your equipment — Resource Hijacking is when an adversary covertly commandeers a victim's compute, network, or cloud resources to generate value for themselves. The most common form is cryptojacking: silently deploying cryptocurrency mining software to harvest CPU/GPU cycles at the victim's expense.

## Why it matters
In 2019, attackers compromised misconfigured Kubernetes clusters at Tesla and injected XMRig (a Monero miner) into pods, causing cloud bill spikes that triggered the initial investigation — not a security alert. This illustrates the key detection signal: **anomalous resource consumption** (CPU pegged at 90%+, unexpected cloud spend) often reveals the compromise before any traditional IOC fires.

## Key facts
- **Primary goal is financial gain**, not data theft — attackers monetize access without stealing sensitive data, making detection harder and urgency feel lower
- **XMRig** is the most commonly observed cryptomining tool; Monero (XMR) is the preferred currency due to its privacy features
- **Cloud environments are high-value targets** — autoscaling means victims may unknowingly pay for attacker-provisioned instances before noticing
- Detection relies on **behavioral baselines**: sustained high CPU, unexpected outbound traffic to mining pools (port 3333, 4444, 14444), or abnormal cloud billing
- Overlaps with **T1059 (Command and Scripting Interpreter)** and **T1053 (Scheduled Task/Job)** since miners are often deployed via scripts and persist via cron jobs or startup tasks

## Related concepts
[[Cryptojacking]] [[Cloud Security Misconfigurations]] [[Behavioral Anomaly Detection]] [[Defense Evasion]] [[Container Security]]