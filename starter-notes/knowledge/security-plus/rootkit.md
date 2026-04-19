---
domain: "cybersecurity/attacks"
tags: [rootkit, malware, persistence, privilege-escalation, stealth, kernel]
---
# rootkit

A **rootkit** is a class of malicious software designed to provide **persistent, privileged access** to a system while actively concealing its own presence from the operating system, administrators, and security tools. The name derives from Unix terminology where **"root"** is the superuser account and **"kit"** refers to the software tools used to maintain that access. Rootkits are closely related to [[persistence mechanisms]], [[privilege escalation]], and [[stealth malware]] techniques.

---

## Overview

Rootkits represent one of the most sophisticated and dangerous categories of malware because their defining characteristic is not merely what they *do*, but what they *hide*. Unlike ransomware or spyware that operate openly within the OS, a rootkit subverts the operating system itself — the very infrastructure an administrator would use to detect and remove it. This makes rootkits the preferred tool of advanced persistent threat (APT) actors, nation-state attackers, and professional cybercriminals who require long-term, undetected access to high-value targets.

The concept of the rootkit predates modern cybersecurity. Early rootkits appeared on Unix systems in the early 1990s as collections of Trojanized binaries — replacements for standard tools like `ls`, `ps`, `netstat`, and `passwd` that would omit attacker-controlled processes, files, and network connections from their output. An attacker who had obtained root access would install these modified binaries to preserve their foothold. These are now classified as **userland rootkits** and are considered relatively easy to detect compared to modern variants.

The evolution of rootkits accelerated dramatically with the development of **kernel-mode rootkits** in the late 1990s and 2000s. Rather than replacing user-space binaries, these rootkits insert code directly into the operating system kernel — either by loading a malicious **kernel module** (on Linux) or a **device driver** (on Windows). Operating at kernel privilege (Ring 0 on x86 systems), they can intercept and modify any system call, making their concealment essentially invisible to any software running at a lower privilege level.

The most infamous real-world rootkit deployment is the **Sony BMG CD copy protection rootkit** disclosed in 2005, where Sony's DRM software installed a hidden kernel-level rootkit on Windows machines without user consent, which was subsequently exploited by independent malware authors. In the realm of APT attacks, the **Stuxnet** worm (2010) contained rootkit components to hide its malicious files on Windows systems as well as hide modified code on Siemens PLCs — a rootkit operating at the firmware/hardware level. **LoJax** (2018), discovered by ESET, was the first confirmed UEFI rootkit used in the wild by APT28 (Fancy Bear), capable of surviving OS reinstallation.

Modern rootkit development continues to target increasingly deep layers of the computing stack — from bootloaders and UEFI firmware to hypervisors and even CPU microcode. The defensive challenge grows proportionally, as detection requires tools operating at a privilege level equal to or higher than the rootkit itself.

---

## How It Works

Rootkit operation can be broken down into three phases: **installation**, **concealment**, and **persistence**. The specific mechanisms vary dramatically by rootkit type.

### Phase 1: Installation

A rootkit cannot install itself without an initial compromise. Common delivery vectors include:

- **Exploiting a local privilege escalation vulnerability** after gaining initial access (e.g., exploiting a kernel bug via CVE-2021-4034, the Polkit vulnerability)
- **Social engineering** — tricking a user with admin rights into executing a malicious binary
- **Supply chain compromise** — embedding the rootkit in legitimate software installers
- **Physical access** — booting from removable media

Once administrative or root privileges are obtained, the rootkit installer drops its components and hooks into the system.

### Phase 2: Concealment Mechanisms by Type

#### Userland Rootkits
Replace or hook standard utilities using techniques like `LD_PRELOAD` injection on Linux:

```bash
# Attacker creates a malicious shared library
# /etc/ld.so.preload is modified to load it first
echo "/lib/libevil.so" > /etc/ld.so.preload
```

The malicious library intercepts calls to `readdir()` and `fopen()`, filtering out entries that match the attacker's file/process names before returning results to the calling program.

#### Kernel Module Rootkits (Linux)
A malicious LKM (Loadable Kernel Module) is inserted using `insmod` or `modprobe`. Once loaded, it hooks the **system call table**:

```c
// Conceptual example: hooking sys_getdents64 to hide files
asmlinkage long (*original_getdents64)(unsigned int, struct linux_dirent64 *, unsigned int);

asmlinkage long hooked_getdents64(unsigned int fd, struct linux_dirent64 *dirent, unsigned int count) {
    long ret = original_getdents64(fd, dirent, count);
    // Iterate results, remove entries starting with "rootkit_prefix"
    // Return modified count and buffer
    return ret;
}
```

The module can also hide itself from `/proc/modules` and `lsmod` by unlinking its node from the kernel's internal module list.

#### Windows Kernel Rootkits (DKOM)
**Direct Kernel Object Manipulation (DKOM)** involves modifying kernel data structures directly in memory, bypassing API hooks. A rootkit targeting Windows locates the `EPROCESS` structure for its process in kernel memory and unlinks it from the doubly-linked list of active processes (`ActiveProcessLinks`). Tools like Task Manager iterate this list, so the unlinked process becomes invisible — but it continues executing.

```
EPROCESS.ActiveProcessLinks is a LIST_ENTRY:
  [PreviousProcess] <-> [Rootkit Process] <-> [NextProcess]
After DKOM:
  [PreviousProcess] <-> [NextProcess]
  (Rootkit EPROCESS.Flink/Blink still point inward but no one traverses them)
```

#### Bootkits
A **bootkit** infects the **Master Boot Record (MBR)** or **Volume Boot Record (VBR)**. It loads before the OS kernel and can patch the kernel as it loads, making the rootkit active before any OS-level detection can begin. The **TDL4/TDSS** family was a prominent example. Detection requires examining raw disk sectors:

```bash
# Examine MBR raw bytes on Linux
dd if=/dev/sda bs=512 count=1 | xxd | head -20

# Compare against known-good MBR hash
sha256sum /dev/sda -c known_good_mbr.sha256
```

#### UEFI/Firmware Rootkits
The most persistent class. Code is written into the **SPI flash chip** containing the UEFI firmware. Survives OS reinstallation, hard drive replacement, and even some BIOS updates. **LoJax** modified the UEFI firmware image to add a UEFI module that dropped a Windows PE file during every boot cycle.

#### Hypervisor Rootkits (Virtual Machine Based Rootkits)
Theorized by Joanna Rutkowska as **"Blue Pill"** (2006). The rootkit inserts itself as a thin hypervisor *beneath* the running OS, relegating the legitimate OS to a virtual machine. Because it operates at Ring -1 (VMX root operation), it has complete visibility and control over the guest OS. Detection is theoretically possible only by timing analysis of hardware operations.

### Phase 3: Persistence

- **Kernel modules**: Added to `/etc/modules` or init scripts
- **Bootkits**: Written to disk sectors read before the OS
- **UEFI rootkits**: Embedded in flash storage, survives reinstall
- **Scheduled tasks / registry run keys**: Used by simpler userland variants

---

## Key Concepts

- **Ring 0 / Kernel Mode**: The highest CPU privilege level on x86 systems, where the OS kernel executes. Kernel rootkits operate here, giving them unrestricted access to all hardware and memory — any software running at Ring 3 (user mode) cannot detect or prevent their actions directly.

- **System Call Hooking**: The technique of intercepting calls from user-space programs to the kernel by replacing legitimate function pointers in the system call table with pointers to attacker-controlled code. This allows filtering of any OS-reported information (processes, files, network connections).

- **DKOM (Direct Kernel Object Manipulation)**: Modifying in-memory kernel data structures (like process lists, driver lists, or network socket tables) directly rather than via API hooks. DKOM bypasses hook-detection tools because no API pointers are modified — the underlying data is simply altered.

- **Bootkit**: A rootkit variant that infects the boot process (MBR, VBR, or UEFI), executing before the operating system loads. This pre-OS execution makes it capable of subverting even kernel-mode security mechanisms that load early in the boot process.

- **Rootkit Detector (Cross-View Detection)**: The primary detection strategy, which compares information from two different sources (e.g., OS API vs. raw disk/memory scan) to find discrepancies. Tools like **rkhunter**, **chkrootkit**, and **GMER** use this approach — if `ps` shows 50 processes but a raw `/proc` scan shows 52, the discrepancy reveals hidden processes.

- **Loadable Kernel Module (LKM)**: A Linux kernel feature allowing code to be dynamically loaded into the running kernel. While legitimate modules implement device drivers and filesystems, malicious LKMs are the primary delivery mechanism for Linux kernel rootkits because they execute at full kernel privilege.

- **Persistence Mechanism**: The method by which a rootkit survives system reboots. Persistence depth is a key characteristic — userland rootkits use user-space autostart mechanisms, while UEFI rootkits survive OS reinstallation because they live in firmware storage.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Rootkits appear primarily under **Domain 2.0 – Threats, Vulnerabilities, and Mitigations** and touch **Domain 4.0 – Security Operations** (detection and response).

**Common Question Patterns:**

1. **"Which type of malware is MOST difficult to detect and remove?"** — The answer is a rootkit (specifically a firmware/UEFI or kernel-mode rootkit). The exam tests understanding that rootkits subvert the detection tools themselves.

2. **"An administrator runs `ps aux` but suspects there are hidden processes. What type of malware is MOST likely responsible?"** — A rootkit, specifically because rootkits hide processes from standard OS utilities.

3. **"Which of the following BEST describes a rootkit?"** — Look for answers that combine *privileged access* AND *concealment*. Answers that only describe remote access (RAT) or only describe privilege escalation are wrong.

4. **"What is the BEST method to detect a rootkit?"** — **Booting from trusted external media** (live CD/USB) and scanning, or using an **out-of-band** trusted OS environment. This is because any detection tool running on the compromised OS may itself be subverted.

**Gotchas:**

- Don't confuse a rootkit with a **RAT (Remote Access Trojan)**. A RAT provides remote control; a rootkit provides concealment. They are often deployed *together* — the RAT is the payload, the rootkit hides it. The exam may present scenarios where both are present.
- **Bootkits** are a subtype of rootkit — if a question asks about malware surviving OS reinstallation, think bootkit/UEFI rootkit.
- The term "rootkit" itself doesn't imply remote access — a rootkit can be used purely for local privilege maintenance.
- **Secure Boot** is a defensive control specifically relevant to bootkits — expect questions pairing these concepts.

---

## Security Implications

### Vulnerabilities Exploited
Rootkits almost always depend on a prior [[privilege escalation]] vulnerability to install. Notable examples:

- **CVE-2021-4034** (PwnKit): A local privilege escalation in `pkexec` (Polkit) on virtually all Linux distributions, trivially exploitable to gain root — creating a perfect landing pad for a kernel rootkit installer.
- **CVE-2019-0543 / CVE-2021-34527** (PrintNightmare): Windows kernel vulnerabilities used in rootkit delivery chains.
- **CVE-2015-0057**: A Windows kernel vulnerability (win32k.sys) exploited by the **Equation Group** (NSA-linked) to install kernel-mode implants.

### Real-World Incidents

| Incident | Year | Type | Notable Feature |
|---|---|---|---|
| Sony BMG DRM Rootkit | 2005 | Userland/Kernel | Mass commercial deployment, enabled third-party malware |
| Stuxnet | 2010 | Kernel + PLC firmware | First known ICS/SCADA rootkit, nation-state |
| TDL4 (TDSS/Alureon) | 2011 | Bootkit (MBR) | Infected 4M+ systems, survived reinstall |
| LoJax | 2018 | UEFI firmware | First in-the-wild UEFI rootkit, APT28 |
| CosmicStrand | 2022 | UEFI firmware | Multiple firmware implants across vendors |

### Detection Challenges
The fundamental problem is the **observer effect**: any detection tool running on a compromised kernel will have its output filtered by the rootkit. Cross-view detection (comparing OS view vs. raw hardware view) is the only reliable approach without specialized hardware support. **Intel TXT** and **AMD SEV** provide hardware-backed measurement of boot integrity, while **TPM-based attestation** allows remote verification of boot state.

---

## Defensive Measures

### Prevention

1. **Enable Secure Boot** in UEFI settings and ensure the firmware is from a trusted vendor. Secure Boot uses cryptographic signatures to verify bootloader integrity, defeating most bootkit variants.

2. **Apply kernel security hardening**:
   - On Linux, enable **module signing**: `CONFIG_MODULE_SIG_FORCE=y` in kernel config prevents unsigned LKMs from loading.
   - Enable **UEFI Secure Boot** with custom keys or vendor keys.
   - On Windows, enable **Driver Signature Enforcement** and **Kernel Patch Protection (PatchGuard)**.

3. **Principle of Least Privilege**: Prevent rootkit installation by ensuring application code never runs as root/SYSTEM. Use `sudo` audit logging, restrict `su` access, and implement SELinux/AppArmor policies.

4. **Firmware updates**: Keep UEFI/BIOS firmware patched. UEFI rootkits often exploit known firmware vulnerabilities.

### Detection

```bash
# Linux: rkhunter (Rootkit Hunter) - compares hashes of system binaries
sudo apt install rkhunter
sudo rkhunter --update
sudo rkhunter --check --sk

# Linux: chkrootkit - checks for common rootkit signatures
sudo apt install chkrootkit
sudo chkrootkit

# Linux: Volatility (memory forensics) - analyze kernel memory offline
# Boot from live USB, dump memory to external drive
sudo dd if=/proc/kcore of=/external/memory.dump bs=1M

# Check for hidden kernel modules by comparing /proc/modules with lsmod
diff <(lsmod | awk '{print $1}' | sort) <(cat /proc/modules | awk '{print $1}' | sort)

# Check for DKOM-hidden processes (compare /proc entries with task_structs)
# Use tools like: unhide, pstree cross-referenced with raw /proc scan
sudo unhide proc
sudo unhide sys
```

```powershell
# Windows: GMER - kernel-level rootkit scanner (run as Administrator)
# Download from gmer.net, scan for hidden processes, hooks, DKOM

# Windows: Sysinternals Autoruns - checks all persistence mechanisms
# Compare hash of every autostart entry against VirusTotal

# Windows: Check for hidden drivers (PatchGuard violation detection)
Get-WmiObject Win32_SystemDriver | Where-Object {$_.State -eq "Running"} | Select Name, PathName
```

### Response

- **Do not trust the running OS for forensics** if a rootkit is suspected. Boot from a **trusted