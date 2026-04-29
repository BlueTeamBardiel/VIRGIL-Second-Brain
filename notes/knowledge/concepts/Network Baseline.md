# Network Baseline

## What it is
Think of a network baseline like a doctor's chart showing your resting heart rate — without knowing what "normal" looks like, you can't tell when something is dangerously wrong. A network baseline is a documented snapshot of typical network behavior: traffic volume, protocol distribution, connection patterns, bandwidth usage, and active hosts measured over a representative time period. It becomes the reference standard against which all future activity is compared.

## Why it matters
In 2020, the SolarWinds attackers stayed hidden for months partly because defenders had no reliable baseline — the malware's beacon traffic blended into normal HTTPS patterns that no one had formally characterized. A well-established baseline would have flagged the unusual outbound connections to novel domains as statistically anomalous, triggering investigation weeks earlier. This is why CISOs now treat baseline documentation as a prerequisite for any meaningful anomaly detection program.

## Key facts
- A baseline should be collected during a **representative normal period** — avoiding holidays, patching windows, or major deployments that would skew the data
- Key metrics to capture include: bandwidth utilization (by hour/day), top talkers, protocol ratios (TCP/UDP/ICMP), DNS query rates, and average session durations
- Baselines must be **periodically updated** (typically quarterly) to account for infrastructure changes — a stale baseline is nearly as dangerous as having none
- On the **Security+ and CySA+ exams**, network baselines are directly tied to anomaly-based detection, as opposed to signature-based detection
- Tools used to establish baselines include **SNMP**, **NetFlow/sFlow**, **PRTG**, **SolarWinds NTA**, and **Wireshark** for packet-level granularity

## Related concepts
[[Anomaly-Based Detection]] [[NetFlow Analysis]] [[SIEM]] [[Continuous Monitoring]] [[Threat Hunting]]