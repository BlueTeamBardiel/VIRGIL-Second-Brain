---
domain: "Security Operations & Monitoring"
tags: [baseline, monitoring, anomaly-detection, configuration-management, performance, hardening]
---
# Baseline

A **baseline** is a documented, measured snapshot of a system, network, or application's normal operating state, used as a reference point for detecting deviations, enforcing configuration standards, and evaluating the impact of changes. In cybersecurity, baselines serve two primary functions: **performance/behavior baselines** (what normal looks like for [[Anomaly Detection]]) and **configuration/security baselines** (what a hardened system should look like per policy). Both types are foundational to [[Security Monitoring]] and [[Vulnerability Management]].

---

## Overview

Baselines exist because security and operations teams cannot identify what is *abnormal* without first defining what is *normal*. A system generating 500 MB/hour of outbound traffic might be perfectly legitimate for a backup server and completely suspicious for a workstation. Without a documented baseline, every alert becomes a guess. Baselines transform ambiguous telemetry into actionable intelligence by providing quantitative thresholds and qualitative configuration expectations against which current state can be compared.

In the context of **performance and behavioral baselines**, organizations monitor metrics such as CPU utilization, network throughput, authentication rates, DNS query volumes, and process counts over a representative time period — typically two to four weeks — to capture normal variation across business cycles (weekdays vs. weekends, peak hours vs. off-hours). Statistical methods such as mean-plus-standard-deviation thresholds or machine learning models trained on this data then flag statistically significant deviations as potential indicators of compromise or operational anomalies.

**Configuration baselines** (also called security baselines or hardened images) define the exact software versions, registry settings, file permissions, enabled services, open ports, and security policy settings that a system *should* have. These are derived from frameworks such as the [[CIS Benchmarks]], [[DISA STIGs]], or organizational policy, and are enforced via [[Configuration Management]] tools. Any drift from the baseline — whether caused by unauthorized change, misconfiguration, or malware persistence — is flagged for remediation.

The concept is deeply embedded in compliance frameworks. [[NIST SP 800-53]] includes baseline configurations as control CM-2. [[PCI DSS]] Requirement 2 mandates that all system components have documented hardened baselines. [[ISO 27001]] Annex A.12.1.1 requires operational procedures including normal operating parameters. Regulators and auditors alike treat baselines as evidence of due diligence — the absence of a baseline is often cited as a finding during security assessments.

Baselines also play a role in **incident response**. When a security event occurs, responders compare the compromised system's current state to its known-good baseline to identify added files, changed registry keys, new scheduled tasks, unexpected network listeners, or modified user accounts. This forensic use of baselines dramatically accelerates the scope determination phase of incident response and is a core capability expected of mature [[Security Operations Center]] (SOC) teams.

---

## How It Works

### Performance / Behavioral Baseline Establishment

**Step 1: Define scope and metrics**
Determine what you are baselining. For a network segment, you might capture:
- Total bytes in/out per hour
- New TCP connections per minute
- DNS queries per host per hour
- Authentication events per user per day
- Top talkers by IP

For a single Windows server, relevant metrics include:
- CPU % (idle, user, kernel)
- Memory committed bytes
- Disk I/O read/write bytes per second
- Active network connections count
- Process list and associated parent PIDs

**Step 2: Collect data over a representative period**
Use monitoring tools to collect raw metrics. In a Linux environment using `sar` (sysstat):

```bash
# Install sysstat
sudo apt install sysstat

# Enable data collection (edit /etc/default/sysstat)
ENABLED="true"

# View CPU baseline data for the past 24 hours
sar -u 1 3600

# View network throughput baseline
sar -n DEV 1 3600

# Generate a daily report summary
sar -A > /tmp/daily_baseline_$(date +%F).txt
```

On Windows, using PowerShell to capture a process/port baseline:

```powershell
# Capture all listening ports and associated processes
Get-NetTCPConnection -State Listen |
  Select-Object LocalAddress, LocalPort,
  @{N='Process';E={(Get-Process -Id $_.OwningProcess).Name}} |
  Export-Csv -Path "C:\Baselines\listening_ports_$(Get-Date -Format yyyy-MM-dd).csv" -NoTypeInformation

# Capture running services state
Get-Service | Where-Object {$_.Status -eq 'Running'} |
  Export-Csv -Path "C:\Baselines\running_services_$(Get-Date -Format yyyy-MM-dd).csv" -NoTypeInformation
```

**Step 3: Calculate thresholds**
After two to four weeks of data, compute statistical thresholds:
- **Mean (μ)**: average value across the collection window
- **Standard deviation (σ)**: spread of values
- **Alert threshold**: typically μ + 2σ or μ + 3σ for high-sensitivity environments

Tools like [[Prometheus]] with [[Grafana]] can automate this with anomaly detection queries:

```promql
# Flag CPU usage that exceeds 2 standard deviations above the weekly mean
(
  instance:node_cpu_utilisation:rate5m
  - avg_over_time(instance:node_cpu_utilisation:rate5m[1w])
)
/ stddev_over_time(instance:node_cpu_utilisation:rate5m[1w]) > 2
```

**Step 4: Document and version-control the baseline**
Store baseline documents in a version-controlled repository (Git). Include:
- Date range of measurement
- Tool and collection method
- Statistical summary (min, max, mean, p95, p99)
- Environment description (patch level, active services)

---

### Configuration Baseline Establishment

**Step 1: Select a framework**
Choose CIS Benchmark Level 1 or Level 2, DISA STIG, or internal policy as the authoritative standard.

**Step 2: Audit current state**
Use tools like `Lynis` (Linux) or Microsoft Security Compliance Toolkit (Windows):

```bash
# Run Lynis hardening audit
sudo lynis audit system --quiet --no-colors > /tmp/lynis_baseline_$(hostname)_$(date +%F).txt

# Key sections to review in output:
# - System tools
# - Kernel hardening
# - Authentication
# - SSH configuration
# - File permissions
```

**Step 3: Apply hardening and re-audit**
Remediate findings, then re-run the audit tool to capture the hardened state. This second report *becomes* the baseline.

**Step 4: Export and compare future states**
Schedule regular re-audits and diff against the baseline:

```bash
# Compare new audit to baseline
diff /tmp/lynis_baseline_webserver01_2024-01-15.txt \
     /tmp/lynis_audit_webserver01_2024-06-01.txt
```

For Windows using CIS-CAT or `secedit`:

```cmd
:: Export current security policy to compare against baseline
secedit /export /cfg C:\Baselines\current_secpol.inf

:: Compare with baseline
fc C:\Baselines\baseline_secpol.inf C:\Baselines\current_secpol.inf
```

---

## Key Concepts

- **Performance Baseline**: A statistical characterization of a system or network's normal operational metrics (CPU, memory, bandwidth, connection rates) used by [[SIEM]] and monitoring tools to detect anomalous behavior indicative of attack, misconfiguration, or failure.

- **Configuration Baseline**: A documented, approved specification of software versions, security settings, enabled/disabled services, and access controls that defines the minimum-security posture for a system type. Deviations constitute **configuration drift** and must be remediated.

- **Configuration Drift**: The gradual divergence of a system's actual state from its approved baseline due to unauthorized changes, software updates, patches applied outside change control, or malware modifications. Detecting drift is a primary use case for [[File Integrity Monitoring]] tools like Tripwire or AIDE.

- **Hardened Image / Gold Image**: A pre-configured virtual machine or disk image that meets the configuration baseline and is used as the master template for deploying new instances, ensuring every deployed system starts in a known-good, compliant state.

- **Continuous Baseline Monitoring**: An operational practice where automated tools continuously compare live system state to the documented baseline and generate alerts or tickets when deviations exceed defined tolerances. This is a key component of [[Continuous Monitoring]] programs required by frameworks like [[FedRAMP]].

- **Behavioral Baseline vs. Signature Detection**: Unlike [[Signature-Based Detection]] which matches known-bad patterns, behavioral baselines detect unknown threats by identifying statistically abnormal behavior — making them effective against zero-days and insider threats where no signature exists.

- **Baseline Recalibration**: The process of intentionally updating a baseline after legitimate changes (hardware upgrades, new software deployments, organizational changes) to prevent alert fatigue from false positives. Recalibration must be change-controlled and documented.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Baselines appear primarily in **Domain 2: Threats, Vulnerabilities & Mitigations** (anomaly detection) and **Domain 4: Security Operations** (configuration management, monitoring).

**Common Question Patterns**:

1. *"A security analyst notices a workstation is sending 10x its normal DNS query volume. What type of detection identified this?"*
   → **Anomaly-based detection** using a behavioral baseline. (Not signature-based, which would match a known-bad pattern.)

2. *"Which control ensures systems are deployed in a consistent, hardened state?"*
   → **Configuration baseline / secure baseline image**

3. *"An auditor reviews a server and finds services enabled that are not in the approved configuration document. What type of finding is this?"*
   → **Configuration drift** from the baseline

4. *"What is the PRIMARY purpose of establishing a network traffic baseline?"*
   → To **detect anomalies** that may indicate compromise, not to block traffic or enforce policy.

**Gotchas**:
- The exam distinguishes between **creating** a baseline (a one-time configuration activity) and **continuous baseline monitoring** (an ongoing operational activity). Questions about *maintaining* security posture over time point to monitoring; questions about initial deployment point to baseline creation.
- Don't confuse a **security baseline** with a **performance baseline** — both are valid answers in different contexts. Read for keywords: "configuration," "hardening," "drift" → configuration baseline; "traffic," "behavior," "anomaly," "normal" → performance baseline.
- The Security+ exam frequently pairs baselines with **change management** — unauthorized deviations from baselines are detected through monitoring and must be addressed through the [[Change Management]] process.
- Know that **CIS Benchmarks** and **DISA STIGs** are the primary sources cited for configuration baselines in exam scenarios.

---

## Security Implications

**Without baselines, detection is blind**: Organizations lacking documented baselines are unable to reliably distinguish malicious activity from normal operations. This is exploited by **living-off-the-land (LotL) attacks**, where adversaries use legitimate system tools (PowerShell, WMI, certutil) that generate no malware signatures. Only a behavioral baseline reveals that `certutil.exe` downloading files is abnormal for a given host.

**Configuration baseline violations enabling attacks**: The 2017 Equifax breach (CVE-2017-5638, Apache Struts) was exploitable in part because the organization lacked consistent patch and configuration baselines, meaning a vulnerable version of Apache Struts remained deployed undetected. Configuration baselines with automated compliance scanning would have flagged the outdated component.

**Baseline poisoning**: An attacker with persistent access who operates *slowly and quietly* can manipulate behavior-based systems by gradually shifting what is considered "normal." If an attacker exfiltrates small amounts of data over weeks before a baseline is established, that volume becomes encoded into the baseline as normal. This is why baselines must be established on **clean, verified systems** and re-evaluated periodically with human oversight.

**Insider threat detection**: Behavioral baselines are among the few controls that reliably detect malicious insiders. A privileged user who begins accessing file shares they never previously accessed, or authenticating at 2 AM when their baseline shows 9 AM–6 PM activity, triggers anomaly alerts that signature detection would miss entirely.

**Configuration drift as attack surface**: The CIS Controls (Control 4) emphasizes that configuration drift is one of the most common precursors to successful compromise. Each deviation from baseline — an unnecessary open port, a disabled security tool, a weak password policy exception — represents an incremental expansion of attack surface.

---

## Defensive Measures

**1. Establish baselines on known-good systems only**
Never build a behavioral baseline on a system that may already be compromised. Use freshly imaged systems for configuration baselines and segregated, monitored segments for behavioral baseline collection.

**2. Use CIS Benchmarks as configuration baseline sources**
Download CIS Benchmark PDFs (free with registration) for your OS versions. Implement Level 1 as minimum; Level 2 where sensitivity warrants.

```bash
# CIS-CAT Lite (free) for Linux/Windows assessment
# Download from: https://www.cisecurity.org/cybersecurity-tools/cis-cat-lite
./CIS-CAT.sh -b benchmarks/CIS_Ubuntu_Linux_22.04_LTS_Benchmark.xml
```

**3. Deploy File Integrity Monitoring (FIM)**
Use AIDE (Linux) or Tripwire to detect configuration drift at the file level:

```bash
# Initialize AIDE database (this IS the baseline)
sudo aide --init
sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Run check against baseline
sudo aide --check
```

**4. Implement SIEM with baseline-driven alerting**
Configure your [[SIEM]] (Splunk, Elastic SIEM, Wazuh) to alert on statistical deviations. In **Wazuh**, rules can reference agent baselines to alert on new listening ports or new processes.

**5. Automate configuration compliance scanning**
Schedule regular scans with tools like **OpenSCAP**, **Ansible** (audit mode), or **Chef InSpec**:

```yaml
# Chef InSpec control example: verify SSH baseline settings
control 'ssh-baseline' do
  title 'SSH Configuration Baseline'
  desc 'Verify SSH daemon meets security baseline'

  describe sshd_config do
    its('PermitRootLogin') { should eq 'no' }
    its('PasswordAuthentication') { should eq 'no' }
    its('Protocol') { should eq '2' }
    its('MaxAuthTries') { should cmp <= 4 }
  end
end
```

**6. Integrate baselines into change management**
Every approved change must include a baseline update step. After patching, upgrading, or reconfiguring, re-run compliance tools and update the baseline document with a new version, date, and change ticket reference.

**7. Review and recalibrate quarterly**
Schedule quarterly baseline reviews to account for legitimate business changes. Use statistical process control charts to identify when recalibration is warranted vs. when variation indicates a security event.

---

## Lab / Hands-On

### Lab 1: Linux Behavioral Baseline with sysstat and sar

```bash
# 1. Install and enable sysstat on Ubuntu/Debian
sudo apt update && sudo apt install -y sysstat
sudo sed -i 's/ENABLED="false"/ENABLED="true"/' /etc/default/sysstat
sudo systemctl restart sysstat

# 2. Collect 1 week of data (runs automatically via cron)
# Default cron: /etc/cron.d/sysstat collects every 10 minutes

# 3. After collection, generate baseline report
# CPU utilization by hour
sar -u -f /var/log/sysstat/sa$(date +%d) | tee ~/baseline_cpu_$(date +%F).txt

# Network activity
sar -n DEV -f /var/log/sysstat/sa$(date +%d) | tee ~/baseline_net_$(date +%F).txt

# 4. Simulate anomaly: generate heavy traffic, compare
iperf3 -c <target_ip> -t 60 &
sar -n DEV 5 15  # observe deviation from baseline