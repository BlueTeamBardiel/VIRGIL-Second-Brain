---
domain: "governance-risk-compliance"
tags: [hardening, benchmarks, configuration-management, compliance, cis-controls, baseline-security]
---
# CIS Benchmarks

The **CIS Benchmarks** are a set of internationally recognized, consensus-based configuration guidelines published by the **Center for Internet Security (CIS)** to help organizations reduce their attack surface by securely configuring operating systems, applications, and network devices. Each benchmark provides prescriptive, actionable guidance developed through a community-driven process involving cybersecurity professionals, vendors, and government agencies. CIS Benchmarks are foundational to [[Security Hardening]], [[Configuration Management]], and compliance frameworks such as [[NIST SP 800-53]] and [[PCI DSS]].

---

## Overview

The Center for Internet Security (CIS) is a nonprofit organization founded in 2000 with a mission to make the connected world safer. The CIS Benchmarks program emerged from the recognition that default configurations of operating systems and software are almost universally insecure—vendors prioritize usability and broad compatibility over security, leaving unnecessary services enabled, weak authentication defaults in place, and verbose logging disabled. By establishing a community-vetted baseline, CIS Benchmarks give practitioners a concrete starting point for hardening any system rather than relying on tribal knowledge or vendor documentation alone.

CIS Benchmarks cover over 100 technology categories, including Windows Server and Desktop editions, Linux distributions (Ubuntu, RHEL, Debian, Amazon Linux), macOS, major cloud providers (AWS, Azure, GCP), network devices (Cisco, Juniper, Palo Alto), databases (MySQL, PostgreSQL, MSSQL, Oracle), web servers (Apache, NGINX, IIS), containers (Docker, Kubernetes), and middleware. Each benchmark is versioned and updated periodically as new vulnerabilities are discovered or as underlying platforms change. At the time of writing, benchmarks for Windows 11, Ubuntu 22.04, and Kubernetes 1.27 are among the most actively maintained.

Each benchmark is structured into two **profile levels**. **Level 1** recommendations provide baseline security improvements that have minimal impact on functionality and are considered broadly applicable. **Level 2** recommendations are intended for high-security environments where the extra restriction is justified and where some operational trade-offs are acceptable—for instance, disabling Bluetooth entirely on a server or enforcing stricter audit logging that may generate high volumes of events. Organizations typically apply Level 1 across the board and selectively apply Level 2 in sensitive environments such as financial transaction servers or medical record systems.

The benchmarks are developed through a **consensus process**: draft recommendations are published to a community of subject matter experts who debate, test, and validate each setting. This process distinguishes CIS Benchmarks from proprietary hardening guides because the rationale behind every recommendation is documented, including the potential impact of applying it. Each control includes a description of the setting, why it matters, how to audit its current state, and remediation instructions for multiple management interfaces (Group Policy, command line, registry, configuration file).

CIS Benchmarks align directly with the **CIS Controls** (formerly Critical Security Controls), a separate but complementary framework that describes *what* security capabilities organizations should have, while benchmarks describe *how* to configure specific technologies to support those capabilities. This makes benchmarks a practical implementation layer beneath higher-level frameworks like [[ISO 27001]], [[NIST Cybersecurity Framework]], and [[HIPAA]] security rules.

---

## How It Works

### Benchmark Structure

Every CIS Benchmark document is organized into numbered sections that mirror the configuration surface of the target technology. For a Linux benchmark, sections typically cover:

1. **Initial Setup** — filesystem configuration, software updates, mandatory access control
2. **Services** — disabling unnecessary services (inetd, avahi, cups, etc.)
3. **Network Configuration** — kernel parameters, firewall rules, wireless interfaces
4. **Logging and Auditing** — auditd rules, syslog configuration, log file permissions
5. **Access, Authentication, and Authorization** — PAM, SSH, sudo, password policies
6. **System Maintenance** — file permissions, user/group settings, root account restrictions

### Profile Levels in Practice

```
Level 1 Example (CIS Ubuntu 22.04, Section 5.2.7):
  Recommendation: Ensure SSH MaxAuthTries is set to 4 or fewer
  Rationale: Limits brute-force attempts per connection
  Audit:      sshd -T | grep maxauthtries
  Remediation: Edit /etc/ssh/sshd_config → MaxAuthTries 4
               systemctl restart sshd

Level 2 Example (CIS Ubuntu 22.04, Section 1.1.2):
  Recommendation: Ensure /tmp is configured as a separate partition
  Rationale: Prevents /tmp-based exploits (noexec,nosuid,nodev mount options)
  Impact: Requires disk re-partitioning, may disrupt some software installations
```

### Scoring: Scored vs. Unscored

CIS Benchmarks distinguish between **Scored** and **Not Scored** recommendations:
- **Scored**: Failure to comply automatically reduces the system's compliance score. These are objective, testable settings.
- **Not Scored**: Procedural or policy-based guidance that cannot be automatically verified (e.g., "ensure an asset inventory process exists").

### Assessment Tools

CIS provides **CIS-CAT Pro** (and the free **CIS-CAT Lite**) as the official assessment tool. It runs automated checks against a system and produces an HTML/CSV report showing pass/fail status for each recommendation.

```bash
# Running CIS-CAT Lite on Linux (example)
cd /opt/cis-cat-lite
./Assessor-CLI.sh -b benchmarks/CIS_Ubuntu_Linux_22.04_LTS_Benchmark_v1.0.0-xccdf.xml \
  -p "Level 1 - Server" \
  -rd /tmp/reports \
  -rp hostname_$(date +%F)
```

The output HTML report scores each section and provides a percentage compliance score (e.g., 78% compliant with Level 1).

### Manual Audit Workflow

For environments without CIS-CAT, benchmarks can be audited manually or with custom scripts:

```bash
# CIS Ubuntu 22.04 - Section 1.1.1.1: Ensure mounting of cramfs is disabled
# Audit
modprobe -n -v cramfs 2>&1 | grep -E "(install|Module)"
lsmod | grep cramfs

# Remediation: create a modprobe config file
echo "install cramfs /bin/true" >> /etc/modprobe.d/cramfs.conf
echo "blacklist cramfs" >> /etc/modprobe.d/blacklist.conf

# Verify
modprobe -n -v cramfs
# Expected: install /bin/true
```

```bash
# CIS Ubuntu 22.04 - Section 5.3.1: Ensure password creation requirements configured
grep -P "^password\s+requisite\s+pam_pwquality" /etc/pam.d/common-password
# Expected output: password requisite pam_pwquality.so retry=3

# Check /etc/security/pwquality.conf
grep -E "^minlen|^minclass|^dcredit|^ucredit|^ocredit|^lcredit" /etc/security/pwquality.conf
# CIS-recommended values:
# minlen = 14
# minclass = 4 (or individual credit values ≥ -1)
```

```powershell
# CIS Windows Server 2022 - Section 2.3.1.1: Accounts: Administrator account status
# PowerShell audit
Get-LocalUser -Name "Administrator" | Select-Object Name, Enabled
# Expected: Enabled = False

# Remediation
Disable-LocalUser -Name "Administrator"

# CIS Windows - Audit policy (Section 17.x)
auditpol /get /category:"Logon/Logoff"
# Expected: Success and Failure auditing enabled for Logon events
```

### Integration with Automation and IaC

CIS Benchmarks are widely integrated into:
- **Ansible**: community.general CIS roles and paid CIS Hardened Images
- **Chef InSpec**: CIS profiles available as InSpec compliance profiles
- **Terraform/Packer**: CIS Hardened Images available on AWS Marketplace, Azure Marketplace
- **OpenSCAP**: SCAP-formatted CIS content consumable by the `oscap` tool

```bash
# Using OpenSCAP with CIS SCAP content (RHEL 8 example)
oscap xccdf eval \
  --profile xccdf_org.cisecurity.benchmarks_profile_Level_1_-_Server \
  --results /tmp/scan-results.xml \
  --report /tmp/scan-report.html \
  /usr/share/xml/scap/ssg/content/ssg-rhel8-ds.xml
```

---

## Key Concepts

- **Benchmark Profile (Level 1 / Level 2)**: **Level 1** is a minimum baseline with low operational impact suitable for all systems; **Level 2** adds stronger restrictions intended for high-security environments where operational trade-offs are acceptable. Choosing the wrong level can break critical services.

- **Scored vs. Not Scored Controls**: **Scored** recommendations have objective, automatable pass/fail criteria and affect the numerical compliance score; **Not Scored** recommendations are procedural best practices that cannot be verified by an automated tool but are still important for organizational security posture.

- **CIS-CAT (Configuration Assessment Tool)**: The **official CIS assessment tool** available in Lite (free, limited) and Pro (paid, full) versions that scans a system against a benchmark and generates detailed compliance reports with remediation guidance. CIS-CAT Pro supports remote scanning and integration with SIEM platforms.

- **CIS Hardened Images**: Pre-configured virtual machine images (AMI, Azure VM, Google Compute) built by CIS and available through cloud marketplaces that ship with benchmark settings pre-applied, reducing the effort required to deploy compliant systems at scale.

- **XCCDF / OVAL / SCAP**: **eXtensible Configuration Checklist Description Format (XCCDF)** and **Open Vulnerability and Assessment Language (OVAL)** are XML-based standards that encode CIS Benchmark checks in a machine-readable format. Together they form the **Security Content Automation Protocol (SCAP)**, enabling interoperability between tools like OpenSCAP, CIS-CAT, and Nessus.

- **Consensus Community**: The **volunteer-driven review process** by which CIS Benchmark recommendations are created and updated. Draft controls are reviewed by hundreds of security professionals, vendors, and government agencies before publication, giving the benchmarks their authority and community trust.

- **Benchmark Versioning**: CIS Benchmarks are versioned (e.g., v1.0.0, v2.0.1) and must be matched to the specific software version being hardened. Applying a benchmark for Ubuntu 20.04 to an Ubuntu 22.04 system may produce inaccurate results or break configuration.

---

## Security Implications

### Why Default Configurations Are Dangerous

Default configurations are the leading cause of system compromise. Systems shipped with default credentials, open ports, and unused services present massive attack surfaces. The **2021 Colonial Pipeline ransomware attack** involved exploiting a legacy VPN account with no MFA—a condition that CIS benchmarks (Section 5 of relevant benchmarks) explicitly address through access control requirements. The **2020 SolarWinds compromise** involved Orion servers often running with weak baseline configurations; post-incident analysis cited misconfigured systems as enabling lateral movement.

### Common Misconfigurations Addressed by CIS Benchmarks

| Misconfiguration | CIS Benchmark Section | Real-World Impact |
|---|---|---|
| SSH PermitRootLogin yes | Linux §5.2.10 | Direct root brute-force |
| World-writable files | Linux §6.1.x | Privilege escalation |
| LLMNR/NBT-NS enabled | Windows §18.5.x | LLMNR poisoning (Responder) |
| NTLMv1 enabled | Windows §2.3.11.x | Pass-the-hash attacks |
| Audit logging disabled | Linux/Windows §17.x | No forensic visibility |
| Telnet service running | Network §x | Cleartext credential capture |
| AutoRun/AutoPlay enabled | Windows §18.9.8 | Malware autoexecution via USB |

### Attack Vectors Mitigated

- **Responder/LLMNR Poisoning**: Disabling LLMNR and NetBIOS Name Service (CIS Windows Benchmark sections 18.5.4 and 18.5.5) prevents attackers from poisoning name resolution to capture NTLMv2 hashes on local networks—a technique used in nearly every internal penetration test.
- **Weak Password Policies**: CIS password requirements (minimum length 14, complexity, lockout thresholds) directly mitigate credential stuffing and brute-force attacks.
- **Unpatched Kernel Modules**: Disabling unused filesystem modules (cramfs, freevxfs, jffs2, hfs, hfsplus, squashfs, udf) via modprobe blacklisting reduces kernel attack surface for CVEs targeting those subsystems (e.g., **CVE-2022-0847 "Dirty Pipe"** exploited a kernel pipe vulnerability on Linux systems that benchmarks push toward regular patching).
- **Unnecessary Services**: Running services like rsh, rlogin, rexec, and tftp create authentication bypass opportunities. CIS benchmarks explicitly require their removal.

### Compliance vs. Security Reality

It is critical to understand that **benchmark compliance does not equal security**. A system can score 95% on CIS Level 1 and still be vulnerable due to unpatched CVEs, misconfigured application logic, or insecure network architecture. Benchmarks address the configuration baseline, not the entire threat model. Security teams must layer benchmarks with [[Vulnerability Scanning]], [[Patch Management]], [[Network Segmentation]], and [[Threat Intelligence]].

---

## Defensive Measures

### Implementing CIS Benchmarks at Scale

**1. Establish a Baseline Assessment**
Before remediating anything, run CIS-CAT or an OpenSCAP scan to document current state. This creates a compliance baseline and identifies the highest-risk gaps.

```bash
# Quick OpenSCAP assessment on Ubuntu (using SSG content)
apt install ssg-debderived libopenscap8
oscap xccdf eval \
  --profile xccdf_org.cisecurity.benchmarks_profile_Level_1_-_Server \
  --report /tmp/baseline-report.html \
  /usr/share/scap-security-guide/ssg-ubuntu2204-ds.xml
```

**2. Prioritize by Risk**
Apply Scored recommendations first. Within those, focus on:
- Authentication controls (SSH, password policies, MFA)
- Logging and auditing (auditd, Windows event logging)
- Unused services and protocols
- Filesystem and permission hardening

**3. Use Configuration Management to Enforce Continuously**
One-time hardening is insufficient. Use tools to enforce configuration drift detection:

```yaml
# Ansible playbook snippet - enforce SSH MaxAuthTries (CIS Ubuntu)
- name: CIS 5.2.7 - Ensure SSH MaxAuthTries is set to 4 or fewer
  lineinfile:
    path: /etc/ssh/sshd_config
    regexp: '^#?MaxAuthTries'
    line: 'MaxAuthTries 4'
    state: present
  notify: restart sshd
```

**4. Use CIS Hardened Images in Cloud Environments**
Deploy from CIS Hardened Images available on AWS Marketplace, Azure Marketplace, and GCP Marketplace. These images ship with Level 1 controls pre-applied and are available for Amazon Linux 2, Windows Server 2019/2022, Ubuntu, RHEL, and others.

**5. Integrate Compliance Scanning into CI/CD**
Add benchmark scanning to infrastructure pipelines so new AMIs and container images are validated before deployment:

```bash
# Docker CIS Benchmark check using docker-bench-security
docker run --rm --net host --pid host --userns host --cap-add audit_control \
  -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
  -v /etc:/etc:ro \
  -v /usr/bin/containerd:/usr/bin/containerd:ro \
  -v /usr/bin/runc:/usr/bin/runc:ro \
  -v /usr/lib/