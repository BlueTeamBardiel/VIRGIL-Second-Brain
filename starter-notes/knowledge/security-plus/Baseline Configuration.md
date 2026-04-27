---
domain: "Security Operations & Architecture"
tags: [baseline, configuration-management, hardening, compliance, change-management, vulnerability-management]
---
# Baseline Configuration

A **baseline configuration** is a documented, approved snapshot of a system's settings, software, hardware inventory, and security controls at a specific point in time, serving as the authoritative reference for that system's expected state. It forms the foundation of [[Configuration Management]] and [[Change Management]] processes, enabling organizations to detect unauthorized modifications and enforce consistent security postures across their infrastructure. Baselines are tightly coupled to concepts like [[Security Hardening]], [[Continuous Monitoring]], and [[Vulnerability Management]].

---

## Overview

A baseline configuration captures everything that defines a system at a known-good state: installed software and versions, enabled services, open ports, registry keys, file permissions, user accounts, security policy settings, and network configuration. Once established, this snapshot becomes the benchmark against which all future states of the system are compared. Any deviation — whether deliberate (a patched vulnerability) or unexpected (a compromised configuration) — becomes immediately visible when the current state is measured against the baseline.

The concept emerged from the discipline of **configuration management (CM)**, which itself grew out of software engineering and military standards like the U.S. DoD's MIL-HDBK-61. In modern IT security, frameworks such as [[NIST SP 800-53]] (specifically the CM control family), the [[CIS Benchmarks]], and [[DISA STIGs]] all mandate the establishment and maintenance of secure baseline configurations. The rationale is straightforward: you cannot protect what you cannot define, and you cannot detect change if you have no reference point.

Baselines exist at multiple levels of an organization's infrastructure. At the **host level**, a baseline covers a single operating system instance — its kernel version, installed packages, local firewall rules, and user accounts. At the **network level**, baselines define acceptable traffic flows, firewall rule sets, and router configurations. At the **application level**, baselines document expected configuration files, database settings, web server directives, and API endpoints. Each of these layers must be independently baselined to provide comprehensive coverage.

Maintaining an accurate baseline requires discipline because systems change constantly. Patches are applied, software is installed, configurations drift. This natural entropy — called **configuration drift** — is one of the most common root causes of security incidents and compliance failures. Without a rigorously maintained baseline, organizations cannot distinguish between an authorized change (a sysadmin enabling a new service) and an unauthorized one (an attacker installing a backdoor). The baseline process therefore must be integrated with formal change control: every approved change triggers a baseline update, and any undocumented change triggers an investigation.

Regulatory frameworks universally require baseline configuration management. PCI DSS Requirement 2.2 mandates system configuration standards. HIPAA's Security Rule requires technical safeguard policies that implicitly depend on baselines. CMMC Level 2 explicitly requires configuration management practices aligned with NIST 800-171. In practice, organizations that audit well-defined baselines consistently demonstrate shorter mean time to detect (MTTD) for intrusions and significantly lower rates of compliance findings.

---

## How It Works

### Step 1 — Define Scope and Select a Reference Framework

Before capturing any state, you must decide which systems require baselining and what security standard you will reference. Common reference frameworks include:

- **CIS Benchmarks** — Community-developed hardening guides for Windows, Linux, network devices, cloud platforms, and applications. Available at [cisecurity.org](https://www.cisecurity.org/cis-benchmarks/).
- **DISA STIGs (Security Technical Implementation Guides)** — DoD-mandated configuration standards, extremely granular, publicly available.
- **NIST National Checklist Program (NCP)** — Repository of government-approved checklists at [nvd.nist.gov/ncp](https://nvd.nist.gov/ncp/repository).
- **Vendor Security Guides** — Microsoft Security Baseline (via Security Compliance Toolkit), CIS for Ubuntu, Red Hat hardening guides.

### Step 2 — Harden the System Before Baselining

A baseline should capture a *hardened* state, not a default installation. Hardening steps typically include:

```bash
# Ubuntu/Debian example — pre-baseline hardening steps

# 1. Remove unnecessary packages
sudo apt purge telnet rsh-client rsh-redone-client nis talk -y
sudo apt autoremove -y

# 2. Disable unused services
sudo systemctl disable avahi-daemon
sudo systemctl disable cups
sudo systemctl disable isc-dhcp-server

# 3. Set filesystem mount options (add to /etc/fstab)
# /tmp    tmpfs    defaults,nodev,nosuid,noexec    0 0
# /var    /dev/sdb1    ext4    defaults,nodev,nosuid    0 0

# 4. Configure password policy in /etc/security/pwquality.conf
sudo sed -i 's/# minlen = 8/minlen = 14/' /etc/security/pwquality.conf
sudo sed -i 's/# dcredit = 0/dcredit = -1/' /etc/security/pwquality.conf

# 5. Set SSH hardening in /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd
```

### Step 3 — Capture the Baseline State

Use automated tools to take a comprehensive snapshot. Below are examples using common tools:

**Using OpenSCAP (Linux — SCAP-compliant scanning):**
```bash
# Install OpenSCAP
sudo apt install libopenscap8 ssg-debderived -y

# Run a CIS benchmark evaluation against Ubuntu 22.04
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis_level1_server \
  --results /var/baseline/ubuntu22-baseline-$(date +%Y%m%d).xml \
  --report /var/baseline/ubuntu22-baseline-$(date +%Y%m%d).html \
  /usr/share/xml/scap/ssg/content/ssg-ubuntu2204-ds.xml
```

**Using PowerShell DSC / Microsoft Security Compliance Toolkit (Windows):**
```powershell
# Download and apply the Windows Server 2022 Security Baseline
# From Microsoft Security Compliance Toolkit

# Export current policy to compare against baseline
secedit /export /cfg C:\Baseline\current_policy.inf /areas SECURITYPOLICY GROUPMGMT REGKEYS

# Compare with baseline using Policy Analyzer (GUI tool from SCT)
# Or use PowerShell to query specific values:
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" `
  -Name "SMB1" | Select-Object SMB1

# Check currently open ports
netstat -an | Select-String "LISTENING"
Get-NetTCPConnection -State Listen | Sort-Object LocalPort
```

**Capturing package inventory (Linux):**
```bash
# Capture installed packages for baseline record
dpkg --get-selections > /var/baseline/packages-$(date +%Y%m%d).txt
pip freeze > /var/baseline/python-packages-$(date +%Y%m%d).txt

# Capture running services
systemctl list-units --type=service --state=running > /var/baseline/services-$(date +%Y%m%d).txt

# Capture open ports (requires root)
ss -tulnp > /var/baseline/network-$(date +%Y%m%d).txt

# Capture file integrity hashes (critical system files)
find /etc /usr/bin /usr/sbin -type f | xargs sha256sum > /var/baseline/hashes-$(date +%Y%m%d).txt
```

### Step 4 — Store and Version-Control the Baseline

Store baseline artifacts in a version-controlled repository (Git, or a CMDB like [[ServiceNow]] or [[Ansible]] AWX). This creates an audit trail of every authorized change.

```bash
# Initialize a git repo for baseline storage
mkdir -p /srv/baselines && cd /srv/baselines
git init
git add .
git commit -m "Initial baseline: ubuntu22-webserver-01 - $(date +%Y%m%d)"
```

### Step 5 — Continuous Comparison and Drift Detection

Schedule automated scans to compare current state against the stored baseline:

```bash
# Cron job to run weekly SCAP scan and email delta report
0 2 * * 0 root oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis_level1_server \
  --results /var/baseline/weekly-scan.xml \
  /usr/share/xml/scap/ssg/content/ssg-ubuntu2204-ds.xml && \
  mail -s "Baseline Drift Report $(date)" security@company.local < /var/baseline/weekly-scan.html
```

Tools like **[[AIDE (Advanced Intrusion Detection Environment)]]**, **Tripwire**, **Auditd**, and **[[Wazuh]]** can perform real-time or scheduled file integrity monitoring (FIM) against the baseline hashes.

---

## Key Concepts

- **Configuration Drift** — The gradual divergence of a system's actual state from its approved baseline, caused by patches, ad-hoc changes, software installations, or attacker modifications. Drift that is not reconciled against change records is a security finding.
- **Approved Baseline vs. Actual State** — The baseline represents the *should be* condition; the actual state is the *is* condition. The gap between them, when undocumented, represents either an unauthorized change or a compliance failure.
- **Gold Image / Golden Master** — A pre-hardened, pre-baselined system image (VM template, AMI, container image) used as the starting point for deploying new systems, ensuring every instance begins in a known-good baseline state.
- **Configuration Item (CI)** — Any component tracked within a [[Configuration Management Database (CMDB)]] that has a baseline associated with it: hardware, software, firmware, documentation, or network device configuration.
- **Continuous Monitoring** — The ongoing, automated comparison of live systems against their approved baselines, feeding alerts into a [[SIEM]] when deviations are detected. Mandated by [[NIST RMF]] (NIST SP 800-137) as a core component of the risk management lifecycle.
- **Remediation Workflow** — When drift is detected, the organization must determine whether the change was authorized (update the baseline) or unauthorized (incident response). The formal process for this is driven by [[Change Management]] and [[Incident Response]] procedures.
- **Immutable Infrastructure** — A modern architectural pattern where servers are never modified after deployment; instead, new baseline images are built and old instances are destroyed. Used in containerized and cloud-native environments to eliminate drift entirely.

---

## Exam Relevance

**Security+ SY0-701 Domain Mapping:** Domain 4.0 — Security Operations (4.1: Apply common security techniques to computing resources; 4.3: Explain various activities associated with vulnerability management).

**Key exam tips:**

- **Baseline vs. Benchmark:** The exam may use these interchangeably but technically a *benchmark* (like a CIS Benchmark) is the *standard* used to *create* a baseline. Know both terms and their relationship.
- **Configuration Management is the parent discipline.** Questions about baselines will often appear in the context of CM, change management, or the [[NIST RMF]] cycle.
- **Common distractors:** The exam may present scenarios where a system behaves unexpectedly and ask what process would *detect* the issue — the answer is baseline comparison / continuous monitoring, not necessarily a vulnerability scan.
- **Drift detection questions** will typically point to baselines as the mechanism. If a question asks "how do you know a system was modified without authorization?" — the answer is baseline configuration comparison or file integrity monitoring.
- **Know the tools:** SCAP, OVAL, and XCCDF are exam-relevant standards. Know that SCAP (Security Content Automation Protocol) is the NIST framework that standardizes baseline scanning. OVAL defines vulnerability conditions; XCCDF defines checklists.
- **Gotcha:** Don't confuse a *security baseline* with a *performance baseline*. Performance baselines measure CPU/memory/network throughput. Security baselines measure configuration state. The exam will likely not confuse these, but candidates sometimes do.
- **Common question pattern:** "A company wants to ensure all servers are deployed with the same security settings and any unauthorized changes are detected automatically. What should they implement?" → Baseline configurations + continuous monitoring / FIM.

---

## Security Implications

### Configuration Drift as an Attack Vector
Attackers actively exploit configuration drift. A common technique is to modify a configuration subtly — enabling a dormant service, adding a local user, weakening a firewall rule — and rely on the organization's lack of baseline monitoring to avoid detection. This is a key tactic in **living off the land (LotL)** attacks, where adversaries use legitimate system tools and modify legitimate configurations rather than dropping malware.

### Notable Incidents
- **SolarWinds SUNBURST (2020):** Attackers modified build pipeline configurations and DLL files. Organizations with rigorous software supply chain baselines and file integrity monitoring had a better chance of detecting the tampered Orion software before deployment.
- **Capital One breach (2019):** A misconfigured AWS WAF — a deviation from the expected secure baseline for the cloud environment — allowed an SSRF attack that accessed S3 buckets. A cloud security posture management (CSPM) tool comparing configurations against a baseline would have flagged the WAF misconfiguration.
- **EternalBlue / WannaCry (2017):** Systems that had not disabled SMBv1 — a deviation from hardened baselines specified in Microsoft's security guidance and CIS Benchmarks for years prior — were exploited en masse. Organizations with enforced baselines that disabled SMBv1 were immune.

### Vulnerabilities Introduced by Absent Baselines
- **Default credentials left active** (CVE patterns like CVE-2022-40684 in FortiGate, where default or weak auth configs were exploited)
- **Unnecessary open ports** creating attack surface (e.g., port 23/Telnet, port 512-514/r-services)
- **Overly permissive file permissions** allowing privilege escalation
- **Disabled security features** (SELinux, AppArmor, Windows Defender) that baseline enforcement would mandate

### Detection Failures Without Baselines
Without a baseline, a [[SIEM]] has no authoritative reference for what "normal" looks like. [[Threat Hunting]] becomes guesswork. [[Incident Response]] teams cannot quickly determine what changed on a compromised system because there is no pre-incident snapshot to compare against.

---

## Defensive Measures

### 1. Adopt a Framework-Based Baseline Standard
Choose CIS Benchmarks Level 1 or 2 for your OS and application stack. Download the appropriate benchmark PDF and corresponding CIS-CAT (CIS Configuration Assessment Tool) for automated assessment.

### 2. Implement File Integrity Monitoring (FIM)
```bash
# AIDE (Advanced Intrusion Detection Environment) setup on Ubuntu
sudo apt install aide -y

# Initialize the baseline database (run AFTER hardening, before production)
sudo aideinit
sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Check for changes against baseline
sudo aide --check

# Automate daily check via cron
echo "0 3 * * * root /usr/bin/aide --check | mail -s 'AIDE Report' security@company.local" \
  | sudo tee /etc/cron.d/aide-daily
```

### 3. Use Infrastructure as Code (IaC) to Enforce Baselines
Tools like **Ansible**, **Puppet**, **Chef**, and **Terraform** encode the baseline as code, enforcing it continuously and making drift immediately correctable.

```yaml
# Ansible playbook snippet — enforce SSH baseline
- name: Enforce SSH baseline configuration
  hosts: all
  become: yes
  tasks:
    - name: Disable root SSH login
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: '^PermitRootLogin'
        line: 'PermitRootLogin no'
        state: present
      notify: Restart SSH

    - name: Disable password authentication
      lineinfile: