---
domain: "Security Operations & Administration"
tags: [configuration-management, hardening, compliance, automation, change-control, baseline]
---
# Configuration Management

**Configuration management (CM)** is the disciplined process of identifying, controlling, tracking, and auditing the settings, software, and hardware attributes of IT systems throughout their lifecycle. It enforces **baseline configurations** — documented, approved states — to maintain [[Security Posture]] and support [[Change Management]] processes. Configuration management is foundational to frameworks like [[NIST SP 800-53]], [[CIS Benchmarks]], and is explicitly tested on the [[CompTIA Security+ SY0-701]] exam.

---

## Overview

Configuration management emerged from software engineering and military systems management as a way to prevent "configuration drift" — the gradual divergence of a system's actual state from its intended, secure state. In an enterprise environment, hundreds or thousands of endpoints, servers, network devices, and cloud instances must be maintained in a known-good condition. Without CM, each system becomes a unique snowflake with an unpredictable attack surface, making vulnerability management, incident response, and compliance auditing nearly impossible.

At its core, CM answers four questions about every system: *What is it? What state should it be in? What state is it actually in? How do we reconcile differences?* This is operationalized through a **Configuration Management Database (CMDB)**, which catalogs every **Configuration Item (CI)** in the environment — from server hardware and OS versions to installed applications and network interface settings. The CMDB becomes the authoritative source of truth for operations and security teams alike.

Configuration management is deeply intertwined with security hardening. A **security baseline** is a minimum set of security controls applied to a system type — for example, disabling SMBv1, enforcing NTLMv2, and enabling Windows Defender are all baseline items for a Windows workstation. These baselines are derived from industry standards such as the CIS Benchmarks, DISA STIGs (Security Technical Implementation Guides), and NIST guidelines. Automated tools continuously compare live system state against these baselines and flag or remediate deviations.

In modern cloud and DevOps environments, CM has evolved into **Infrastructure as Code (IaC)**, where system configurations are stored in version-controlled code repositories. Tools like Ansible, Terraform, Puppet, and Chef define desired system states declaratively, and enforcement agents or pipelines apply those states automatically. This "shift left" approach embeds configuration security early in the development lifecycle, reducing the window of exposure from misconfigured systems.

The consequences of poor configuration management are well-documented. The 2017 Equifax breach was precipitated partly by an unpatched Apache Struts vulnerability on a system that had drifted out of patch management scope. The Capital One breach in 2019 involved a misconfigured AWS WAF. Every major cloud breach report from Verizon DBIR to Gartner identifies misconfiguration as a top cloud security threat, with some estimates attributing over 70% of cloud incidents to configuration errors.

---

## How It Works

### 1. Discovery and Inventory

Before you can manage configurations, you must know what exists. Discovery tools scan the environment to enumerate all assets and their current configurations.

```bash
# Nmap-based OS and service discovery
nmap -sV -O --script=default 192.168.1.0/24 -oX inventory.xml

# Use Ansible to collect facts from managed nodes
ansible all -m setup -i inventory.ini > facts_output.json
```

This produces a **CI inventory** — every device, OS version, open port, installed package, and running service.

### 2. Establishing Baselines

A **baseline** is the approved configuration for a system type. Baselines are derived from:
- **CIS Benchmarks** (cisecurity.org) — scored, community-vetted hardening guides
- **DISA STIGs** — DoD-specific technical implementation guides
- **Vendor security guides** — Microsoft Security Compliance Toolkit, Red Hat hardening guides

Example: A CIS Level 1 baseline for Ubuntu 22.04 might include:

```bash
# Disable unused filesystems
echo "install cramfs /bin/true" >> /etc/modprobe.d/hardening.conf
echo "install freevxfs /bin/true" >> /etc/modprobe.d/hardening.conf

# Ensure SSH root login is disabled
sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# Enable UFW and set default deny
ufw default deny incoming
ufw default allow outgoing
ufw enable

# Ensure auditd is installed and running
apt install auditd -y
systemctl enable auditd && systemctl start auditd
```

### 3. Applying Configurations with Automation Tools

**Ansible** is agentless and uses YAML playbooks over SSH (port 22) or WinRM (ports 5985/5986):

```yaml
# hardening_playbook.yml
---
- name: Apply CIS Baseline to Web Servers
  hosts: webservers
  become: yes
  tasks:
    - name: Disable root SSH login
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: '^PermitRootLogin'
        line: 'PermitRootLogin no'
        state: present
      notify: Restart SSH

    - name: Ensure auditd is running
      service:
        name: auditd
        state: started
        enabled: yes

    - name: Remove telnet package
      package:
        name: telnet
        state: absent

  handlers:
    - name: Restart SSH
      service:
        name: sshd
        state: restarted
```

**Puppet** uses a pull model — agents on managed nodes contact a Puppet Master (port 8140/TCP) every 30 minutes by default to retrieve and apply manifests:

```puppet
# site.pp — Puppet manifest
class hardening {
  service { 'telnet':
    ensure => stopped,
    enable => false,
  }
  file { '/etc/ssh/sshd_config':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('hardening/sshd_config.erb'),
  }
}
```

### 4. Continuous Compliance and Drift Detection

Tools like **OpenSCAP**, **Chef InSpec**, and **AWS Config** continuously scan for deviations:

```bash
# Run an OpenSCAP scan against CIS profile
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis \
  --results results.xml \
  --report report.html \
  /usr/share/xml/scap/ssg/content/ssg-ubuntu2204-ds.xml
```

AWS Config continuously evaluates resource configurations against managed or custom rules. For example, `restricted-ssh` verifies that no security groups allow unrestricted inbound SSH (port 22 from 0.0.0.0/0).

### 5. Change Control Integration

All configuration changes must flow through a **Change Advisory Board (CAB)** process or automated change pipeline:
1. **Request** — engineer submits a change request with justification
2. **Review** — security, ops, and business stakeholders approve
3. **Test** — change applied to staging/lab environment
4. **Deploy** — change pushed via automation tool
5. **Verify** — compliance scan confirms desired state
6. **Document** — CMDB and change log updated

---

## Key Concepts

- **Baseline Configuration**: The approved, documented minimum-security configuration for a given system type. Baselines are version-controlled, reviewed periodically, and serve as the benchmark against which drift is measured.

- **Configuration Item (CI)**: Any component that needs to be managed to deliver an IT service — servers, network devices, virtual machines, applications, certificates, and even documentation files. CIs are tracked in the CMDB.

- **Configuration Management Database (CMDB)**: The central repository that stores attributes and relationships of all CIs. Tools like ServiceNow, i-doit, and NetBox serve as CMDBs. The CMDB supports impact analysis, incident response, and audit reporting.

- **Configuration Drift**: The gradual deviation of a system's actual configuration from its approved baseline, caused by unauthorized changes, patches applied inconsistently, or manual "fixes." Drift increases attack surface and violates compliance controls.

- **Hardening**: The process of reducing the attack surface of a system by disabling unnecessary services, removing default accounts, applying security patches, and enforcing secure settings. Hardening produces a system that adheres to a security baseline.

- **Infrastructure as Code (IaC)**: Managing and provisioning infrastructure through machine-readable definition files rather than manual processes. Enables version control, peer review, automated testing, and repeatable deployments of configurations.

- **Immutable Infrastructure**: A pattern where servers are never modified after deployment; instead, new images are built with updated configurations and old instances are replaced. Eliminates configuration drift by design.

- **Change Management**: The formal process for controlling changes to the IT environment. Configuration management and change management are tightly coupled — CM detects unauthorized changes and change management governs how authorized changes are made.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Configuration management appears primarily in **Domain 4.0 — Security Operations** (specifically 4.1: Apply common security techniques to computing resources) and **Domain 5.0 — Security Program Management** (5.1: Summarize elements of effective security governance).

**High-frequency exam topics:**

- **Baseline vs. Hardening**: The exam distinguishes between a *baseline* (the approved configuration for a system type) and *hardening* (the act of implementing security controls to reach or exceed that baseline). Know that baselines can represent a *minimum* acceptable configuration.

- **Change Management vs. Configuration Management**: CM identifies *what* the configuration should be and detects drift; Change Management governs the *process* for making modifications. Questions often test whether candidates know that unauthorized changes are a CM concern, while approved changes flow through change management.

- **CMDB**: Know that a CMDB tracks all configuration items and their relationships. It is essential for impact analysis ("if I patch this server, what services are affected?").

- **Automation tools**: The exam may reference Ansible, Puppet, Chef, or similar tools in the context of automation, hardening, and reducing human error. Know that these tools enforce *desired state configuration*.

- **Common gotcha**: The exam sometimes conflates configuration management with patch management. They are related but distinct — patch management updates software versions, while configuration management controls settings and states. A system can be fully patched but still misconfigured.

- **Security implications of poor CM**: Questions may ask what results from the *absence* of configuration management — the answer is typically increased attack surface, configuration drift, compliance failure, and difficulty with incident response.

---

## Security Implications

**Misconfiguration as Attack Vector**: OWASP lists "Security Misconfiguration" as A05 in the OWASP Top 10 for web applications. Misconfigurations include default credentials left enabled, unnecessary services exposed, verbose error messages revealing stack traces, and overly permissive cloud storage policies.

**Notable incidents tied to misconfiguration:**
- **Equifax 2017**: Apache Struts CVE-2017-5638 exploited on a system that had fallen out of the patch/configuration management process. The vulnerability had a patch available for months before exploitation.
- **Capital One 2019**: Misconfigured AWS WAF allowed a Server-Side Request Forgery (SSRF) attack to access EC2 instance metadata, exposing IAM role credentials. The S3 bucket ACLs were also misconfigured.
- **SolarWinds 2020**: The attacker modified the Orion software build process — a configuration management artifact — to insert the SUNBURST backdoor. This shows that CM applies not just to deployed systems but to build pipelines.
- **Microsoft Exchange ProxyLogon 2021** (CVE-2021-26855 et al.): Mass exploitation succeeded partly because many organizations had not applied patches and had Exchange exposed without CMrestrictions on external access.

**Attack vectors enabled by poor CM:**
- **Default credentials**: Unmanaged systems often retain vendor-default passwords (e.g., `admin/admin`, `cisco/cisco`). Configuration management explicitly audits and rotates these.
- **Unnecessary services**: An unconfigured system might run FTP (port 21), Telnet (port 23), and SNMP v1/v2 (port 161 UDP), all of which are insecure. CM baselines disable these.
- **Overly permissive permissions**: World-writable files, sudoers with NOPASSWD, or S3 buckets with public-read policies are configuration failures.
- **Unenforced encryption**: Systems without CM may use TLS 1.0/1.1 or SSLv3, weak cipher suites, or self-signed certificates past expiry.

---

## Defensive Measures

**1. Adopt Industry Baselines**
Download and implement CIS Benchmarks for all system types. They are free, well-documented, and available for Windows, Linux, macOS, cloud platforms, network devices, and applications. DISA STIGs are mandatory for DoD and provide extreme detail for regulated environments.

**2. Deploy a Configuration Automation Tool**
- **Ansible**: Best for agentless environments; uses SSH/WinRM. Good starting point for homelabs.
- **Puppet/Chef**: Agent-based; ideal for large, heterogeneous environments.
- **SaltStack**: High-performance; supports both agentless (SSH) and agent-based modes.
- **Microsoft DSC (Desired State Configuration)**: Native Windows solution for enforcing PowerShell-defined configurations.

**3. Implement Continuous Compliance Scanning**
```bash
# Weekly OpenSCAP scan via cron
0 2 * * 0 /usr/bin/oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis \
  --results /var/log/scap/results-$(date +\%F).xml \
  /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml
```
Cloud alternatives: AWS Security Hub + AWS Config, Azure Security Center, GCP Security Command Center.

**4. Maintain a Version-Controlled Configuration Repository**
Store all configuration baselines, playbooks, and IaC code in Git. Require peer review (pull requests) for all changes. Use signed commits to ensure integrity.

```bash
# Enforce GPG-signed commits
git config --global commit.gpgsign true
git config --global user.signingkey YOUR_GPG_KEY_ID
```

**5. Implement a CMDB**
Even a homelab benefits from a lightweight CMDB. **NetBox** is an open-source DCIM/IPAM tool that tracks devices, IP addresses, configurations, and relationships. Run it in Docker:

```bash
git clone https://github.com/netbox-community/netbox-docker.git
cd netbox-docker
docker-compose up -d
```

**6. Enforce Change Control**
No production changes without a change ticket. Use tools like **Jira**, **ServiceNow**, or **GitLab merge requests** as the gate before any configuration change is deployed.

**7. Monitor for Drift with File Integrity Monitoring (FIM)**
Tools like **OSSEC**, **Wazuh**, and **Tripwire** detect unauthorized file and configuration changes in real time by comparing file hashes against a known-good baseline.

---

## Lab / Hands-On

### Lab 1: Build a Hardened Baseline with Ansible

**Prerequisites**: Debian/Ubuntu VM (target), control machine with Ansible installed.

```bash
# Install Ansible on control node
pip3 install ansible

# Create inventory file
cat > inventory.ini << EOF
[webservers]
192.168.10.20 ansible_user=labadmin ansible_ssh_private_key_file=~/.ssh/lab_key
EOF

# Test connectivity
ansible all -i inventory.ini -m ping

# Download and run dev-sec hardening role
ansible-galaxy install dev-sec.os-hardening
ansible-galaxy install dev-sec.ssh-hardening

# Create and run playbook
cat > lab_hardening.yml << EOF
---
- hosts: webservers
  become: yes
  roles:
    - dev-sec.os-hardening
    - dev-sec.ssh-hardening
EOF

ansible-playbook -i inventory.ini lab_hardening.yml
```

### Lab 2: OpenSCAP Compliance Scan

```bash
# Install OpenSCAP on target (RH