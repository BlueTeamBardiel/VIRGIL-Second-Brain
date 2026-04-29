# System Performance

## What it is
Like a car engine running rough when something is wrong under the hood, system performance metrics reveal the health of a machine by measuring how efficiently it uses its resources. Precisely, system performance refers to the measurable efficiency of a computing system across CPU utilization, memory consumption, disk I/O, and network throughput over time. Establishing a performance baseline lets analysts detect anomalies that may indicate compromise or failure.

## Why it matters
During a cryptojacking attack, an adversary hijacks CPU cycles to mine cryptocurrency — often the first detectable symptom is CPU utilization spiking to 90-100% on hosts with no legitimate heavy workload. A CySA+ analyst monitoring performance dashboards would flag this deviation from the baseline, triggering investigation before sensitive data is exfiltrated or the system collapses entirely.

## Key facts
- **Baseline establishment** is critical: you cannot detect abnormal performance without first documenting normal behavior during representative operating periods
- CPU, memory, disk I/O, and network bandwidth are the four core performance metrics monitored in security operations
- **Resource exhaustion** caused by DoS/DDoS attacks, malware loops, or ransomware encryption activity all manifest as dramatic, measurable performance degradation
- Performance data is a key input for **SIEM correlation rules** — thresholds trigger alerts when metrics exceed defined acceptable ranges
- Security+ exam distinguishes between performance issues caused by **misconfiguration**, **hardware failure**, and **active attack** — all require different remediation paths

## Related concepts
[[Baseline Configuration]] [[Log Analysis]] [[SIEM]] [[Denial of Service]] [[Continuous Monitoring]]