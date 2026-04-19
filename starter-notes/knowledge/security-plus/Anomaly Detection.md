---
domain: "Security Operations & Monitoring"
tags: [anomaly-detection, siem, threat-detection, behavioral-analysis, machine-learning, network-security]
---

# Anomaly Detection

**Anomaly detection** is the process of identifying patterns, events, or observations that deviate significantly from expected baseline behavior within a system, network, or dataset. It forms a cornerstone of modern [[Intrusion Detection Systems]] (IDS) and [[Security Information and Event Management]] (SIEM) platforms by enabling security teams to surface threats that evade [[Signature-Based Detection]]. Unlike rule-based approaches, anomaly detection learns what "normal" looks like and alerts on deviations — making it powerful against zero-day exploits and insider threats.

---

## Overview

Anomaly detection exists because traditional security tools are fundamentally reactive. Signature-based antivirus and firewall rules can only catch known-bad patterns — they are useless against novel malware, living-off-the-land (LotL) attacks, or a malicious insider using legitimate credentials. Anomaly detection inverts this problem: instead of cataloging what is bad, it models what is normal and flags everything that falls outside acceptable variance. This shift from blacklisting to baselining is philosophically significant and explains why anomaly detection is a foundational element of modern [[Zero Trust Architecture]].

The technique emerged from statistics and quality control (where it is known as "outlier detection") but was rapidly adopted by the information security community in the 1980s and 1990s alongside the first academic work on intrusion detection by Dorothy Denning. Her 1987 paper "An Intrusion Detection Model" explicitly proposed building statistical profiles of user behavior and generating alerts when those profiles were violated — a framework still in use today. Modern implementations have layered machine learning, deep learning, and graph analytics on top of these original statistical foundations.

In practice, anomaly detection operates across multiple layers of the IT stack simultaneously. At the **network layer**, it might flag a workstation that suddenly begins scanning internal subnets — consistent with lateral movement. At the **host layer**, it might detect a process spawning an unusual child process (e.g., `winword.exe` spawning `cmd.exe` — a classic macro exploitation pattern). At the **user/identity layer**, User and Entity Behavior Analytics ([[UEBA]]) tracks login times, geographic locations, data access volumes, and privilege escalation attempts against established user baselines. Each layer catches a different class of threat.

The central challenge of anomaly detection is managing the **signal-to-noise ratio**. Because normal behavior is inherently variable — users travel, businesses have seasonal load spikes, sysadmins run scripts during maintenance windows — naive anomaly detection systems generate enormous volumes of false positives. This problem has driven decades of research into better baselining algorithms, contextual enrichment, and alert tuning. A well-tuned anomaly detection pipeline in a mature SOC might produce a handful of high-fidelity alerts per day from millions of daily events; a poorly tuned one produces thousands of alerts that analysts learn to ignore, recreating the blind spot the system was meant to eliminate.

Real-world deployments tie anomaly detection output into a broader detection-and-response workflow. Alerts feed into [[SIEM]] correlation rules, trigger [[SOAR]] playbooks for automated investigation, or surface in [[XDR]] dashboards for analyst triage. The 2020 SolarWinds SUNBURST attack is a canonical example of why this matters: the threat actor operated for months within victim environments using legitimate credentials and tooling, generating no signature matches. Behavioral anomalies — particularly unusual authentication patterns from service accounts — were the primary forensic signal that post-incident analysis revealed, and which better-tuned anomaly detection could have surfaced in real time.

---

## How It Works

Anomaly detection is not a single algorithm but a family of techniques applied to a pipeline of data collection, modeling, scoring, and alerting.

### Phase 1: Data Collection

Raw telemetry is ingested from diverse sources:
- **Network flows**: NetFlow/IPFIX records from routers and switches (UDP port 2055 for NetFlow v5/v9)
- **Endpoint telemetry**: Windows Event Logs (Sysmon, Security, PowerShell), Linux auditd, EDR agent data
- **Authentication logs**: Active Directory event IDs 4624 (logon), 4625 (failed logon), 4768/4769 (Kerberos), 4776 (NTLM)
- **DNS logs**: Queries, responses, NXDOMAIN rates (critical for detecting [[DNS Tunneling]] and C2 beaconing)
- **Proxy/web logs**: URLs, user agents, bytes transferred, response codes

### Phase 2: Baseline Modeling

A baseline is established over a training period (typically 30–90 days). Common modeling approaches:

**Statistical methods:**
```
Mean (μ) and Standard Deviation (σ) of a metric
Alert threshold = μ ± (n × σ)   # n = 2 or 3 for 95%/99.7% confidence
```

**Time-series decomposition**: Separate signal into trend, seasonality, and residual components. Alert when the residual exceeds a threshold. Python example with `statsmodels`:

```python
from statsmodels.tsa.seasonal import seasonal_decompose
import pandas as pd

df = pd.read_csv('network_bytes_per_hour.csv', parse_dates=['timestamp'], index_col='timestamp')
result = seasonal_decompose(df['bytes'], model='additive', period=24)  # 24-hour seasonality

residual = result.resid.dropna()
threshold = residual.mean() + 3 * residual.std()
anomalies = residual[residual.abs() > threshold]
print(anomalies)
```

**Machine learning models:**
- **Isolation Forest**: Isolates anomalies by recursively partitioning features; anomalies require fewer splits. Works well on high-dimensional data.
- **Autoencoders**: Neural networks trained to reconstruct normal data; high reconstruction error = anomaly
- **LSTM (Long Short-Term Memory)**: Recurrent networks that model temporal sequences; effective for time-series network traffic

```python
from sklearn.ensemble import IsolationForest
import numpy as np

# Features: bytes_out, conn_count, unique_dst_ips, failed_auths
X = np.array([[...]])  # shape (n_samples, 4)

clf = IsolationForest(contamination=0.01, random_state=42)
clf.fit(X_train)
scores = clf.decision_function(X_test)  # More negative = more anomalous
predictions = clf.predict(X_test)       # -1 = anomaly, 1 = normal
```

### Phase 3: Real-Time Scoring

Each incoming event is scored against the baseline model. In a SIEM like Elasticsearch/OpenSearch with the ML module:

```
PUT _ml/anomaly_detectors/network_exfil_detector
{
  "description": "Detect unusual outbound data volumes",
  "analysis_config": {
    "bucket_span": "15m",
    "detectors": [{
      "detector_description": "high bytes_out by src_ip",
      "function": "high_sum",
      "field_name": "bytes_out",
      "partition_field_name": "src_ip"
    }]
  },
  "data_description": {
    "time_field": "@timestamp"
  }
}
```

### Phase 4: Alert Enrichment and Triage

Raw anomaly scores are enriched with:
- **Threat intelligence**: Is the anomalous destination IP in a blocklist? (via [[Threat Intelligence Platforms]])
- **Asset context**: Is the flagged host a server (expected high traffic) or a standard workstation?
- **User context**: Is the user a sysadmin with a maintenance window ticket open?
- **Historical context**: Has this host triggered anomalies before?

### Phase 5: Tuning

Analysts feed back false-positive dispositions to retrain models or adjust thresholds. This is an ongoing operational process, not a one-time configuration.

---

## Key Concepts

- **Baseline**: The statistical model of normal behavior for a given entity (user, host, subnet) over a defined observation window. Baselines must account for daily, weekly, and seasonal cycles to avoid alerting on predictable variation like Monday-morning login spikes.

- **False Positive (FP)**: An alert generated for a benign event incorrectly classified as anomalous. High FP rates cause alert fatigue and are one of the primary failure modes of anomaly detection deployments. Contextual enrichment and tuning exist specifically to reduce FPs.

- **False Negative (FN)**: A genuinely malicious event that the detection system fails to flag. Adversaries who understand behavioral baselines can perform **low-and-slow** attacks — exfiltrating data in small chunks over many days — specifically to evade anomaly detection thresholds.

- **Detection Rate / Recall**: The percentage of actual anomalies that the system correctly identifies. Calculated as TP / (TP + FN). Security teams must balance this against precision (TP / (TP + FP)) — improving one often degrades the other.

- **UEBA (User and Entity Behavior Analytics)**: A specialized class of anomaly detection focused on human and machine identities. UEBA systems build per-user profiles encompassing login patterns, data access, application usage, and peer-group comparison. Vendors include Splunk UBA, Microsoft Sentinel UEBA, and Exabeam.

- **Concept Drift**: The phenomenon where the underlying distribution of "normal" behavior shifts over time (e.g., business acquisitions, remote work policies), causing previously accurate baselines to generate excessive FPs or FNs. Models must be periodically retrained to compensate.

- **Anomaly Score**: A numerical value representing how far a data point deviates from the baseline. Different systems use different scales (e.g., 0–100, Z-scores, -1 to 1). Scores must be interpreted in context — a score of 90/100 on a trivial metric may be less actionable than a score of 70/100 on a critical authentication metric.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Anomaly detection primarily appears in **Domain 4: Security Operations** (28% of exam), specifically under monitoring activities, IDS/IPS analysis, and threat detection.

**Key exam patterns and gotchas:**

- **Anomaly-based vs. Signature-based IDS**: This is a high-frequency comparison question. Remember: **anomaly-based** = detects unknown threats, higher false positives, requires training period. **Signature-based** = detects known threats, lower false positives, blind to zero-days. Expect questions asking which is better for detecting a *novel* or *zero-day* attack — the answer is always anomaly-based.

- **Heuristic detection** is sometimes presented as a third option alongside signature and anomaly. In CompTIA's framing, heuristic detection is a hybrid — it uses rules derived from behavioral patterns. Don't confuse it with pure statistical anomaly detection.

- **Behavior-based detection** is often used interchangeably with anomaly-based in exam questions. Both terms point to the same concept: modeling normal behavior and alerting on deviations.

- **UEBA** questions are increasingly common on SY0-701. Know that UEBA is specifically designed to detect **insider threats** and **compromised credentials** — scenarios where the attacker has valid authentication and thus bypasses perimeter controls.

- **Alert fatigue** is a Security+ topic. If a question describes a SOC where analysts are overwhelmed and ignoring alerts, the solution involves tuning, SOAR automation, or SIEM correlation — not deploying more detection tools.

- **Know the terminology trap**: "False positive" means the system cried wolf (benign event flagged). "False negative" means the wolf got through (malicious event missed). Exam questions sometimes describe a scenario and ask which type of error occurred.

---

## Security Implications

### Adversarial Evasion of Anomaly Detection

Sophisticated threat actors actively study and evade anomaly detection systems:

**Low-and-slow exfiltration**: Instead of extracting 10 GB in one session (easily detected), an attacker exfiltrates 50 MB per day for 200 days, staying within normal variance. The APT41 group was documented using this technique against healthcare targets.

**Living off the Land (LotL)**: Using built-in OS tools (`certutil.exe`, `bitsadmin.exe`, PowerShell) rather than custom malware means the *processes* themselves are normal; only their *behavior* is anomalous. Requires careful baselining of command-line arguments, not just process names.

**Mimicking peer behavior**: An attacker who has studied the environment can time their actions to coincide with legitimate high-activity periods (e.g., backup windows, patch cycles) to mask anomalous traffic in normal variance.

**Model poisoning**: In machine learning-based systems, an attacker with long-term access can deliberately behave in the malicious way repeatedly over weeks, gradually shifting the baseline to accept the behavior as normal. This is an active area of academic research.

### Real-World Incidents

**SolarWinds SUNBURST (2020)**: SUNBURST performed extensive environment fingerprinting and deliberately avoided triggering anomaly detection by using legitimate SolarWinds processes, communicating to C2 via DNS (mimicking normal update traffic), and inserting randomized delays. Behavioral analytics of Kerberos delegation patterns was ultimately what FireEye used to identify the breach in their own environment.

**Capital One Breach (2019)**: The attacker (a former AWS employee) leveraged a misconfigured WAF to obtain IAM credentials, then performed extensive S3 bucket enumeration. Anomaly detection on the IAM credential's behavior — particularly the volume and pattern of S3 API calls against buckets not normally accessed by that service role — could have flagged the exfiltration.

**Insider Threat at Tesla (2018)**: A disgruntled employee exfiltrated gigabytes of proprietary manufacturing data by altering code to send large amounts of data to unknown external recipients. DLP systems with volume-based anomaly detection were the appropriate control.

### Weaknesses and Attack Surfaces

- **Training data poisoning**: If an attacker is present during the baselining period, they can normalize malicious behaviors
- **Threshold gaming**: Attackers who know threshold values can operate just below them indefinitely
- **Blind spots in encrypted traffic**: Anomaly detection on payload content is impossible for TLS-encrypted traffic without [[SSL/TLS Inspection]]; only metadata (flow volume, timing, certificate details) is available

---

## Defensive Measures

### 1. Establish Robust, Multi-Dimensional Baselines

Do not baseline a single metric. Build composite profiles:
```
User baseline dimensions:
  - Typical working hours (e.g., 08:00–18:00 local time)
  - Source IP ranges (corporate office, known VPN range, home ISP)
  - Systems accessed (list of specific servers/shares)
  - Data volume accessed per day (mean: 200 MB, σ: 50 MB)
  - Authentication method (password, MFA, certificate)
  - Privileged command usage (sudo, net user, etc.)
```

### 2. Implement Tiered Detection

Layer multiple detection approaches so that what evades one is caught by another:
- **Signature-based IDS** (Snort/Suricata) for known threats
- **Anomaly-based behavioral analytics** (SIEM ML, Elastic SIEM, Splunk UBA) for unknown threats  
- **Deception technology** ([[Honeypots]] and honeytokens) that require zero baselining — any access is an alert

### 3. Deploy Network Behavior Analysis (NBA)

Configure NetFlow collection on all core switches and edge routers:
```bash
# Cisco IOS NetFlow export configuration
interface GigabitEthernet0/0
 ip flow ingress
 ip flow egress

ip flow-export version 9
ip flow-export destination 192.168.10.50 2055  # SIEM collector IP, UDP 2055
ip flow-export source Loopback0
ip flow-cache timeout active 1
ip flow-cache timeout inactive 15
```

### 4. Tune Aggressively and Continuously

Establish a feedback loop:
- **Weekly**: Review top alert generators; suppress confirmed FPs with contextual exceptions
- **Monthly**: Retrain ML models with new labeled data
- **Quarterly**: Full baseline review to account for business changes (new applications, remote work expansion)
- **After incidents**: Analyze what the anomaly detection missed and why; adjust models accordingly

### 5. Enrich Context at Alert Time