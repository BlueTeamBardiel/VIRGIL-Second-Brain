---
domain: "governance-risk-compliance"
tags: [framework, cis-controls, hardening, compliance, risk-management, best-practices]
---
# CIS Controls

The **CIS Controls** (formerly known as the **SANS Critical Security Controls**) are a prioritized set of 18 safeguard categories published by the **Center for Internet Security (CIS)** designed to defend organizations against the most common and impactful cyber attacks. Rooted in real-world threat data, the controls provide actionable guidance that maps to attack patterns seen in the wild, making them one of the most practically oriented frameworks in cybersecurity. They complement broader frameworks like [[NIST Cybersecurity Framework]] and [[ISO 27001]] while serving as a concrete implementation guide.

---

## Overview

The CIS Controls were originally developed in 2008 through a collaborative effort between U.S. government agencies, defense contractors, and security researchers who analyzed actual attacker techniques to derive the defenses most likely to prevent successful intrusions. The controls were initially maintained by SANS Institute before being transferred to CIS in 2015. The current version, **CIS Controls v8**, released in May 2021, restructured the controls from 20 to 18, shifting from an asset-centric to an **activity-centric** model that better reflects cloud, mobile, and remote work environments.

CIS Controls v8 introduced the concept of **Implementation Groups (IGs)**, which tier the controls into three progressively comprehensive groupings based on organizational size, resources, and risk tolerance. IG1 contains 56 safeguards considered essential cyber hygiene for small organizations with limited IT staff. IG2 adds 74 additional safeguards targeting organizations with dedicated IT and security teams managing sensitive data. IG3 encompasses all 153 safeguards and is aimed at mature security programs managing critical infrastructure or regulated data. This tiered model solves the long-standing problem of organizations feeling overwhelmed by attempting to implement every control simultaneously.

The controls are explicitly mapped to real threat data through **CIS Community Defense Model (CDM)** analysis. CIS analyzed the most prevalent attack patterns from the **MITRE ATT&CK** framework and demonstrated that IG1 safeguards alone would defend against approximately 77% of the top attack techniques observed in actual incidents, including phishing, drive-by compromise, and exploitation of public-facing applications. This data-driven justification distinguishes CIS Controls from more abstract compliance frameworks.

CIS Controls also map directly to major compliance standards including **NIST SP 800-53**, **PCI DSS**, **HIPAA**, and **SOC 2**, allowing organizations to use CIS implementation as a pathway to regulatory compliance. CIS publishes official mapping documents for these crosswalks. For Security+ SY0-701 candidates, CIS Controls represent a key example of a prescriptive, implementation-focused framework as opposed to the more process-oriented NIST CSF, and understanding both the tiered IG model and the 18 control categories is examined content.

The controls have been adopted globally across sectors including healthcare, finance, education, and government. The CIS publishes free resources including the full controls document, implementation guides called **CIS Benchmarks** for specific technologies (Windows Server, Linux, AWS, Azure, etc.), and the **CIS-CAT Pro** tool for automated assessment. This ecosystem makes CIS Controls highly actionable for practitioners at every level.

---

## How It Works

### The 18 CIS Controls (v8)

The 18 controls are organized as follows, with their Implementation Group availability noted:

| # | Control Name | IG1 | IG2 | IG3 |
|---|---|---|---|---|
| 1 | Inventory and Control of Enterprise Assets | ✓ | ✓ | ✓ |
| 2 | Inventory and Control of Software Assets | ✓ | ✓ | ✓ |
| 3 | Data Protection | ✓ | ✓ | ✓ |
| 4 | Secure Configuration of Enterprise Assets and Software | ✓ | ✓ | ✓ |
| 5 | Account Management | ✓ | ✓ | ✓ |
| 6 | Access Control Management | ✓ | ✓ | ✓ |
| 7 | Continuous Vulnerability Management | ✓ | ✓ | ✓ |
| 8 | Audit Log Management | ✓ | ✓ | ✓ |
| 9 | Email and Web Browser Protections | ✓ | ✓ | ✓ |
| 10 | Malware Defenses | ✓ | ✓ | ✓ |
| 11 | Data Recovery | ✓ | ✓ | ✓ |
| 12 | Network Infrastructure Management | — | ✓ | ✓ |
| 13 | Network Monitoring and Defense | — | ✓ | ✓ |
| 14 | Security Awareness and Skills Training | ✓ | ✓ | ✓ |
| 15 | Service Provider Management | — | ✓ | ✓ |
| 16 | Application Software Security | — | ✓ | ✓ |
| 17 | Incident Response Management | — | ✓ | ✓ |
| 18 | Penetration Testing | — | — | ✓ |

### Implementation Workflow

The typical adoption process follows a structured lifecycle:

**Step 1 – Determine Implementation Group**
Assess your organization based on: number of employees, IT staff size, presence of sensitive or regulated data, and risk profile. A small medical office would likely start at IG1; a hospital network managing PHI would target IG2.

**Step 2 – Asset Inventory (Controls 1 & 2)**
Before any other control can be meaningfully implemented, you must know what assets exist. Use discovery tools to enumerate hardware and software:

```bash
# Nmap network sweep for asset discovery (Control 1)
nmap -sn 192.168.1.0/24 -oX assets.xml

# Parse discovered hosts
nmap -sV -O 192.168.1.0/24 --open -oN asset_inventory.txt

# On Linux: list installed software (Control 2)
dpkg --get-selections | awk '{print $1}' > software_inventory.txt

# On Windows (PowerShell): enumerate installed software
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
  Select-Object DisplayName, DisplayVersion, Publisher |
  Export-Csv -Path C:\Inventory\software.csv -NoTypeInformation
```

**Step 3 – Secure Configuration (Control 4)**
Apply CIS Benchmarks to harden systems. Benchmarks are published for:
- Windows 10/11, Windows Server 2019/2022
- Ubuntu Linux, RHEL/CentOS
- AWS Foundations, Azure CIS Benchmark
- Apache HTTP Server, Microsoft SQL Server, etc.

```bash
# Download and run CIS-CAT Lite for automated benchmark assessment
# After extracting CIS-CAT Lite:
./CIS-CAT.sh -b benchmarks/CIS_Ubuntu_Linux_22.04_LTS_Benchmark_v1.0.0-xccdf.xml \
  -a -rd /reports/

# Check SSH hardening against CIS benchmark manually (Control 4, IG1)
grep -E "^PermitRootLogin|^PasswordAuthentication|^X11Forwarding|^MaxAuthTries" \
  /etc/ssh/sshd_config
# Expected: no, no, no, 4 (or lower)
```

**Step 4 – Account and Access Management (Controls 5 & 6)**

```powershell
# Windows: Audit local admin accounts (Control 5)
Get-LocalGroupMember -Group "Administrators" | Select-Object Name, PrincipalSource

# Disable unused accounts (Control 5.3)
Disable-LocalUser -Name "Guest"
Disable-LocalUser -Name "DefaultAccount"

# Enforce MFA requirement via Group Policy path:
# Computer Config > Windows Settings > Security Settings >
# Account Policies > Password Policy
```

**Step 5 – Vulnerability Management (Control 7)**
Establish scanning cadences: weekly internal scans at IG1, continuous scanning at IG3. Remediation SLAs per severity:
- Critical: 15 days
- High: 30 days
- Medium: 90 days

```bash
# OpenVAS/Greenbone CLI scan
gvm-cli socket --gmp-username admin --gmp-password password \
  --xml "<create_task><name>Weekly_Scan</name>...</create_task>"

# Nessus CLI (if installed)
nessuscli scan --new --name "CIS_Control7_Scan" --policy-id 1 \
  --targets "192.168.1.0/24"
```

**Step 6 – Audit Logging (Control 8)**

```bash
# Linux: Enable auditd (Control 8)
systemctl enable auditd && systemctl start auditd

# Add rules to audit sensitive file access
auditctl -w /etc/passwd -p wa -k identity_changes
auditctl -w /etc/sudoers -p wa -k privilege_escalation
auditctl -a always,exit -F arch=b64 -S execve -k process_execution

# Forward logs to central SIEM (rsyslog to Wazuh/Graylog)
echo "*.* @192.168.1.100:514" >> /etc/rsyslog.conf
systemctl restart rsyslog
```

---

## Key Concepts

- **Implementation Groups (IGs):** Three tiers (IG1, IG2, IG3) that allow organizations to adopt a subset of safeguards proportional to their size, resources, and risk profile, preventing the "boiling the ocean" failure mode common with monolithic compliance frameworks.

- **Safeguard:** The individual, actionable task within each control. CIS Controls v8 defines 153 total safeguards across all 18 controls, each with asset type, security function, and IG applicability clearly stated.

- **CIS Benchmarks:** Companion documents to the CIS Controls that provide specific, vendor-level hardening guidance for operating systems, applications, and cloud platforms. Benchmarks are available in two profile levels — Level 1 (essential, minimal performance impact) and Level 2 (defense-in-depth, may impact usability).

- **CIS-CAT Pro/Lite:** Automated assessment tools published by CIS that scan systems against Benchmark configurations and produce HTML reports with pass/fail results and remediation guidance. CIS-CAT Lite is free; CIS-CAT Pro requires CIS membership.

- **Community Defense Model (CDM):** CIS's analytical methodology that maps each control safeguard to MITRE ATT&CK techniques, providing quantitative evidence that implementing IG1 safeguards prevents the majority of observed attack sub-techniques in real-world breach data.

- **Asset Types:** CIS Controls v8 classifies safeguards by what they protect — Devices, Software, Data, Users, or Networks — making it easier to assign ownership and accountability within an organization.

- **Security Functions:** Each safeguard is tagged with one of five NIST-aligned security functions: Identify, Protect, Detect, Respond, or Recover, enabling alignment with the [[NIST Cybersecurity Framework]].

---

## Security Implications

### Attack Patterns Addressed

The CIS Community Defense Model analysis against MITRE ATT&CK data identified the top five attack patterns most responsible for breaches:
1. Web Application Hacking
2. Insider and Privilege Misuse
3. IT Control Failure (misconfiguration)
4. Lost and Stolen Assets
5. Social Engineering / Phishing

Gaps in CIS Controls directly correlate to exploited weaknesses documented in major incidents:

**Missing Asset Inventory → Shadow IT Exploitation**
The 2021 Colonial Pipeline ransomware attack succeeded partly due to a forgotten VPN account — a direct failure of Control 1 (asset inventory) and Control 5 (account management). Attackers used legitimate credentials (CVE-adjacent: credential stuffing) against an account nobody knew existed.

**Lack of Secure Configuration → Rapid Exploitation**
The 2021 Microsoft Exchange Server exploitation (ProxyLogon, **CVE-2021-26855**, **CVE-2021-26857**) affected tens of thousands of organizations. Organizations that had implemented Control 4 (secure configuration) and Control 7 (patch management) with IG2 cadences were either unaffected or patched before exploitation.

**No Audit Logging → Undetected Dwell Time**
The SolarWinds supply chain attack (2020) had an average dwell time exceeding 200 days. Organizations without robust audit logging (Control 8) and network monitoring (Control 13) had no visibility into the lateral movement occurring across their environments.

**Phishing Defense Gaps**
Control 9 (Email and Web Browser Protections) specifically addresses email filtering, anti-spoofing (SPF/DKIM/DMARC), and browser hardening. The 2016 DNC breach began with a spear-phishing email that would have been blocked by properly configured SPF/DMARC records — a Control 9 safeguard explicitly included in IG1.

### Common Implementation Failures

- Organizations performing one-time compliance snapshots rather than continuous monitoring (violates Control 7 intent)
- Logging enabled but never reviewed or centralized — "log theater"
- CIS Benchmarks applied uniformly without testing, causing application breakage that leads to rollback of security settings
- IG3 controls attempted before IG1 is mature, creating gaps in foundational hygiene

---

## Defensive Measures

### Control 1 & 2 — Asset Management
Deploy an enterprise asset management tool. For homelabs and small organizations:
- **Lansweeper** (free tier) for hardware/software discovery
- **OCS Inventory NG** (open source) with GLPI for CMDB integration
- **Snipe-IT** (open source) for asset tracking

```bash
# Deploy OCS Inventory agent on Debian/Ubuntu
apt-get install ocsinventory-agent
dpkg-reconfigure ocsinventory-agent
# Point to OCS server: http://192.168.1.50/ocsinventory
```

### Control 4 — Secure Configuration
Implement configuration management to enforce and maintain baselines:
- **Ansible** with CIS hardening roles (available on Ansible Galaxy)
- **Chef InSpec** with CIS profiles for continuous compliance validation
- **Group Policy** (Windows) aligned to CIS Benchmark recommendations

```bash
# Apply CIS Ubuntu hardening role via Ansible
ansible-galaxy install dev-sec.os-hardening
# In your playbook:
# - hosts: all
#   roles:
#     - dev-sec.os-hardening
ansible-playbook -i inventory.ini harden.yml --check  # Dry run first
```

### Control 5 & 6 — Account and Access Management
- Enforce **MFA** on all administrative accounts (Control 6.3, IG1)
- Implement **PAM (Privileged Access Management)** for admin credential vaulting
- Quarterly access reviews for all privileged accounts
- Deploy **LAPS (Local Administrator Password Solution)** on Windows endpoints to eliminate shared local admin passwords

```powershell
# Enable LAPS via PowerShell (Windows)
Import-Module AdmPwd.PS
Update-AdmPwdADSchema
Set-AdmPwdComputerSelfPermission -Identity "OU=Workstations,DC=lab,DC=local"
```

### Control 7 — Vulnerability Management
- **OpenVAS/Greenbone** for open-source vulnerability scanning
- **Tenable Nessus Essentials** (free for up to 16 IPs) for homelab/small org scanning
- Integrate scan results into a ticketing system (Jira, RT) with SLA enforcement
- Subscribe to **CISA KEV (Known Exploited Vulnerabilities)** catalog for priority patching

### Control 8 — Audit Log Management
- Centralize logs with **Wazuh** (open source SIEM/XDR), **Graylog**, or **Elastic SIEM**
- Minimum log retention: 90 days online, 1 year archived (IG2+)
- Enable Windows Event Forwarding (WEF) for Windows