---
domain: "attack-techniques"
tags: [rootkit, malware, persistence, privilege-escalation, stealth, kernel]
---
# Rootkits

A **rootkit** is a collection of malicious software designed to provide continued privileged access to a compromised system while actively concealing its presence from users, administrators, and security tools. The term combines "root" (the Unix superuser account) with "kit" (a set of tools), reflecting the original purpose of maintaining covert root-level control. Rootkits represent some of the most sophisticated [[Malware]] on the threat landscape, often requiring specialized tools like [[Integrity Checkers]] or [[Memory Forensics]] techniques to detect.

---

## Overview

Rootkits emerged in the early 1990s as attackers sought ways to maintain persistent access to compromised Unix systems after initial exploitation. Early rootkits simply replaced system binaries (like `ls`, `ps`, and `netstat`) with trojaned versions that hid the attacker's files and processes. Over the decades, rootkits have evolved to operate at progressively deeper layers of the operating system, culminating in firmware and hardware-level implants that survive OS reinstallation and even disk replacement.

The defining characteristic of a rootkit is **stealth**. Unlike a simple backdoor that merely provides re-entry, a rootkit actively subverts the visibility mechanisms that defenders rely upon. It hides files, network connections, running processes, registry keys, and loaded modules. By operating below or within the trusted components of the OS, it ensures that the compromised system reports a false reality to any monitoring tool that runs within that same compromised environment. This is the fundamental epistemological challenge rootkits pose: you cannot trust the tools on a compromised host to report the truth.

Rootkits serve a secondary purpose beyond persistence — they protect other malicious payloads. A rootkit may conceal a keylogger harvesting credentials, a cryptocurrency miner consuming CPU cycles, a botnet agent awaiting commands, or a data exfiltration tool quietly staging stolen files. The rootkit is the guardian; the other malware is the payload. This layered architecture makes rootkits central components of [[Advanced Persistent Threat (APT)]] toolkits.

Several landmark incidents have cemented rootkits in security history. In 2005, Sony BMG shipped audio CDs with a user-mode rootkit (developed by First 4 Internet) that hid DRM software using techniques identical to malicious rootkits. The `$sys$` file-hiding mechanism it employed was subsequently exploited by actual malware authors within weeks of disclosure. In 2011, the Alureon/TDL4 bootkit infected the Master Boot Record of millions of systems, surviving OS reinstalls and achieving persistence that puzzled victims who believed a fresh install would clean the infection. In 2022, the CosmicStrand UEFI rootkit was discovered targeting home routers and PCs, surviving even full drive replacements.

The security community categorizes rootkits by the **privilege ring** or abstraction layer at which they operate — user space, kernel space, bootloader, firmware — with deeper implants being harder to detect and remove. Understanding these categories is foundational to understanding both detection methodology and the limits of conventional antivirus solutions.

---

## How It Works

### Infection Vector

Rootkits do not spread autonomously in most cases; they require a delivery mechanism. Common vectors include:

- **Exploit chains**: A vulnerability (e.g., a browser exploit followed by a privilege escalation) grants the attacker sufficient privilege to install the rootkit.
- **Trojanized software**: Legitimate-looking installers bundle rootkit components.
- **Supply chain compromise**: Rootkit code is injected into legitimate software during the build or distribution process.
- **Physical access**: Bootkit-class rootkits can be installed via USB boot media.
- **Phishing + dropper**: A phishing email delivers a dropper that downloads and installs the rootkit after achieving initial access.

### User-Mode Rootkits

User-mode rootkits operate in Ring 3, within the user space of the operating system. They work by subverting the API calls that applications use to query system state.

**Windows mechanism — DLL injection and API hooking:**

```c
// Conceptual: Hooking NtQueryDirectoryFile to hide files
// Attacker replaces the IAT entry for NtQueryDirectoryFile
// in targeted processes with a pointer to their own function

NTSTATUS HookedNtQueryDirectoryFile(...) {
    NTSTATUS status = OriginalNtQueryDirectoryFile(...);
    // Iterate results, remove entries matching hidden filenames
    FilterResults(FileInformation, hidden_names);
    return status;
}
```

The rootkit injects a DLL into processes like `explorer.exe` or security tools and hooks functions from `ntdll.dll` or `kernel32.dll`. When `dir` or a file manager calls `FindFirstFile`, the hooked function intercepts the results and removes entries for hidden files before returning them to the caller.

**Linux mechanism — LD_PRELOAD hijacking:**

```bash
# Attacker adds malicious library to LD_PRELOAD
echo "/usr/lib/libmalicious.so" >> /etc/ld.so.preload

# The malicious library wraps readdir():
# int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result) {
#     // call real readdir_r, filter results
# }
```

### Kernel-Mode Rootkits (Ring 0)

Kernel rootkits load as device drivers or kernel modules, operating in Ring 0 with unrestricted hardware access.

**Linux Loadable Kernel Module (LKM) rootkit — system call table hooking:**

```c
// Save original sys_getdents64
original_getdents64 = sys_call_table[__NR_getdents64];

// Replace with our hook
sys_call_table[__NR_getdents64] = hooked_getdents64;

// In hook: iterate kernel dirent structures, unlink entries for hidden files
asmlinkage long hooked_getdents64(unsigned int fd,
    struct linux_dirent64 __user *dirent, unsigned int count) {
    long ret = original_getdents64(fd, dirent, count);
    // Walk dirent buffer, remove hidden entries, adjust sizes
    return modified_ret;
}
```

The sys_call_table lives in kernel memory. To write to it, the rootkit must first disable write-protect on that page (clearing CR0 bit 16 on x86), write the new pointer, then re-enable protection.

**Windows kernel rootkit — DKOM (Direct Kernel Object Manipulation):**

Rather than hooking functions, DKOM directly edits kernel data structures. Every running process has an `EPROCESS` structure linked in a doubly-linked list (`ActiveProcessLinks`). By unlinking a target process from this list:

```
Process A <-> Rootkit Process <-> Process C
                    ↓ DKOM
Process A <-> Process C
(Rootkit process removed from list but still running)
```

Tools like `PsList` that enumerate `ActiveProcessLinks` will not see the hidden process, but the process continues executing.

### Bootkits

Bootkits infect the **Master Boot Record (MBR)** or **Volume Boot Record (VBR)**, executing before the OS loader. Since they run before Windows, they can patch the OS kernel in memory as it loads, achieving kernel-level stealth without loading a traditional driver.

```
Power-on → BIOS/UEFI → [Bootkit MBR code] → patches kernel as it loads → 
OS boots with pre-infected kernel → rootkit hooks installed transparently
```

TDL4/Alureon used an encrypted virtual filesystem in the last sectors of the physical disk to store its components, invisible to the OS partition table.

### UEFI/Firmware Rootkits

The most persistent class. Rootkit code is written into the SPI flash chip that stores UEFI firmware. Examples include **LoJax** (2018, attributed to APT28) and **CosmicStrand** (2022). These survive:

- OS reinstallation
- Hard drive replacement
- BIOS "reset to defaults"

Detection requires reading the SPI flash directly (using tools like `chipsec`) and comparing against a known-good firmware image.

```bash
# Using chipsec to dump UEFI firmware for analysis
sudo python chipsec_main.py -m tools.uefi.get_biosregion
sudo python chipsec_main.py -m common.bios_wp  # Check BIOS write protection
```

---

## Key Concepts

- **Ring 0 / Ring 3 distinction**: x86 CPUs implement privilege rings. Ring 0 (kernel mode) has unrestricted hardware access; Ring 3 (user mode) is restricted. Kernel rootkits operating in Ring 0 can subvert any Ring 3 detection tool because they have higher privilege than the detector.

- **Hooking**: The technique of intercepting function calls by replacing a pointer in a function table (IAT, SSDT, IDT) with a pointer to malicious code. The hook calls the original function, modifies the results, and returns the altered data to the caller, maintaining apparent functionality while hiding malicious artifacts.

- **DKOM (Direct Kernel Object Manipulation)**: A stealthy technique where a rootkit directly modifies in-memory kernel data structures (such as `EPROCESS` linked lists or `_DRIVER_OBJECT` tables) rather than hooking API calls. Because no code is intercepted, function-call-based detection methods miss DKOM-hidden objects.

- **Bootkit**: A subtype of rootkit that persists in the boot sector (MBR/VBR) or UEFI firmware, executing before the operating system loads. Bootkits defeat OS-level detection and survive reinstallation, requiring out-of-band analysis or hardware-based remediation.

- **Hypervisor/Virtual Machine-Based Rootkit (VMBR)**: A theoretical and practically demonstrated rootkit class that installs a thin hypervisor beneath the running OS, causing the legitimate OS to run as a guest VM. Because the rootkit operates below the OS, it has complete visibility and control. SubVirt (2006) and Blue Pill (2006) demonstrated this concept.

- **Kernel Patch Protection (KPP / PatchGuard)**: Microsoft's Windows 64-bit protection that periodically checks critical kernel structures (SSDT, IDT, GDT, DKOM structures) for unauthorized modification, triggering a BSOD (bug check 0x109) if tampering is detected. Rootkit authors have developed bypasses through timing attacks and patching PatchGuard itself.

- **Persistence mechanism**: The technique by which a rootkit survives reboots. User-mode rootkits may use registry Run keys or DLL hijacking. Kernel rootkits register as services or boot drivers. Bootkits infect disk boot sectors. UEFI rootkits write to firmware flash.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Rootkits appear primarily under Domain 2.0 (Threats, Vulnerabilities & Mitigations) and connect to Domain 4.0 (Security Operations) through detection and response.

**Key exam facts to memorize:**

- Rootkits are classified by **type** on the exam: **user-mode**, **kernel-mode**, **bootloader**, **firmware/UEFI**, and **hypervisor-based**.
- The **defining characteristic** the exam tests is concealment/stealth — rootkits hide their presence. This distinguishes them from simple backdoors or RATs.
- The **recommended remediation** for a rootkit-infected system on the exam is typically **reimaging** (wiping and restoring from known-good media), not disinfection. For bootkits/UEFI rootkits, this extends to reflashing firmware.
- Rootkits often appear in questions about **indicators of compromise (IOCs)** — look for answers involving unexpected system behavior that tools cannot explain, processes consuming resources that don't appear in the task manager, or network connections without visible source processes.
- **Anti-forensics** questions may reference rootkits as examples of malware that defeats standard investigation techniques.

**Common question patterns:**

> *"A security analyst notices outbound connections on port 443 but cannot find any process responsible when using built-in OS tools. What type of malware is most likely present?"* → **Rootkit** (process hiding via DKOM or API hooking)

> *"After reimaging a workstation, the malware infection returns within minutes of the machine connecting to the network. What type of malware has likely persisted?"* → **Bootkit or firmware rootkit** (survived reimaging)

> *"Which of the following is the BEST approach to detect a rootkit?"* → **Boot from trusted external media and scan the filesystem offline**

**Gotchas:**
- Don't confuse rootkits with [[RAT (Remote Access Trojan)]]s — RATs provide remote control but don't necessarily hide themselves. A rootkit may *include* a RAT but the defining property is concealment.
- Exam may use "stealth virus" language — these are older terms for similar concepts; modern terminology is rootkit.

---

## Security Implications

### Attack Surface

Any system with exploitable privilege escalation vulnerabilities is susceptible to rootkit installation. The attack surface includes:

- **Unpatched kernel vulnerabilities**: CVE-2021-4034 (Polkit pkexec, Linux), CVE-2020-0787 (Windows BITS), and hundreds of similar LPE bugs enable attacker code to reach the privilege level needed to install kernel rootkits.
- **Boot process integrity**: Systems without Secure Boot or with Secure Boot disabled/bypassed are vulnerable to MBR/UEFI bootkits.
- **Signed driver abuse**: CVE-2022-21971 and the broader "Bring Your Own Vulnerable Driver" (BYOVD) technique allow attackers to load a legitimate, signed but vulnerable driver, then exploit it to achieve Ring 0 code execution. Tools like **KDU (Kernel Driver Utility)** automate BYOVD attacks.

### Notable Real-World Incidents

| Rootkit | Year | Type | Notable Feature |
|---|---|---|---|
| **Sony BMG XCP** | 2005 | User-mode | DRM rootkit; `$sys$` prefix hiding |
| **Rustock** | 2006–2010 | Kernel (driver) | Spam botnet, NTFS alternate data stream hiding |
| **TDL4 / Alureon** | 2008–2011 | Bootkit (MBR) | Encrypted virtual FS, survived reinstall |
| **Stuxnet** | 2010 | Kernel (driver) | Signed rootkit components, targeted ICS/SCADA |
| **LoJax** | 2018 | UEFI firmware | First in-the-wild UEFI rootkit, APT28 |
| **CosmicStrand** | 2022 | UEFI firmware | Targeted home router firmware images |
| **BlackLotus** | 2023 | UEFI bootkit | First UEFI bootkit bypassing Secure Boot on fully patched Windows 11 |

### Detection Challenges

Rootkits create a **trust gap**: the operating system cannot be trusted to report accurate information about itself. A file-hiding rootkit means `dir` lies; a process-hiding rootkit means `tasklist` lies; a network-hiding rootkit means `netstat` lies. This invalidates the fundamental assumption of most endpoint security tools — that the OS will accurately report what is running.

**Cross-view detection** exploits the fact that a rootkit hiding at one layer may not be able to hide at all layers simultaneously. For example, a user-mode rootkit hiding a process from the Win32 API may still be visible through direct kernel object enumeration. Tools like **GMER**, **Rootkit Revealer**, and **Volatility** perform cross-view analysis.

---

## Defensive Measures

### Prevention

1. **Patch aggressively**: Most rootkit installation requires a privilege escalation vulnerability. Maintaining a patched kernel eliminates the most common escalation paths.
   ```bash
   # Linux: automatic security updates
   sudo apt install unattended-upgrades
   sudo dpkg-reconfigure unattended-upgrades
   
   # Check for kernel updates specifically
   apt list --upgradable 2>/dev/null | grep linux-image
   ```

2. **Enable and configure Secure Boot**: Secure Boot with a correct key hierarchy prevents unsigned bootloaders and OS loaders, blocking bootkit-class infections.
   ```bash
   # Verify Secure Boot status on Linux
   mokutil --sb-state