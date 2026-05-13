# BIOS Settings

## What it is

You hit DEL during POST, the screen turns blue or black with a UEFI menu, and you're staring at the firmware that runs before the OS exists. This is the **first thing the machine remembers when it wakes up** — it inventories the hardware, checks that the brain (CPU), workbench (RAM), and warehouse (storage) are present and responsive, then hands control to the bootloader.

In plain English: BIOS settings are the knobs you turn before Windows or Linux ever loads. Boot order, virtualization toggles, fan curves, RAM speed profiles, Secure Boot, TPM, drive modes. The OS can't change most of these — they live a layer below it.

Technical definition: **UEFI** (Unified Extensible Firmware Interface) is the modern replacement for legacy BIOS. It runs from a chip soldered to the motherboard, initializes hardware via POST (Power-On Self-Test), and loads the bootloader from an EFI System Partition on disk. Settings persist in NVRAM, backed up by the CMOS battery (a CR2032) that also runs the RTC. Pull the battery or short the CLR_CMOS jumper and every setting reverts to default.

## Why it matters

Half the "my PC won't boot" tickets you'll work trace back to BIOS settings someone touched and didn't document. The other half trace back to BIOS settings someone *should* have touched and didn't — Secure Boot off for a Linux install, XMP not enabled so RAM runs at 2133 instead of 6000, virtualization disabled so Hyper-V refuses to start.

CompTIA loves this objective because BIOS settings sit at the intersection of hardware, security, and OS troubleshooting. Objective 220-1201 3.5 wants you to know what every major setting does, why you'd toggle it, and what breaks when you toggle it wrong. Expect questions on Secure Boot, TPM, boot order, fast boot, and CMOS battery symptoms.

## In your build, in the enterprise

**Beat 1 — what's actually in there.** Modern UEFI menus split into Easy Mode (fan curves, XMP toggle, boot priority dropdown) and Advanced Mode (every chipset register the vendor exposes). The settings that matter for A+:

- **Boot order / boot priority** — which device gets handed control first. UEFI boot entries are named (e.g., "Windows Boot Manager") rather than just "first hard drive."
- **Secure Boot** — firmware verifies the bootloader's cryptographic signature against a key database before executing it. Blocks unsigned bootkits and unsigned OS loaders.
- **TPM / fTPM / PTT** — the Trusted Platform Module, a crypto coprocessor that stores keys for BitLocker, Windows Hello, and attestation. Discrete TPM is a chip; fTPM (AMD) and PTT (Intel) are firmware implementations baked into the CPU. Windows 11 requires TPM 2.0.
- **Virtualization (VT-x / AMD-V, VT-d / AMD-Vi)** — hardware acceleration for hypervisors. Off by default on many boards. Hyper-V, WSL2, VMware, and Docker Desktop all need this.
- **XMP / EXPO / DOCP** — RAM speed profiles. Without this, your DDR5-6000 kit runs at JEDEC baseline (4800 or lower).
- **Fast Boot** — skips POST device enumeration to shave seconds off boot time. Cost: USB keyboards may not respond before OS load, so you can't enter BIOS without a workaround.
- **CSM (Compatibility Support Module)** — legacy BIOS emulation for booting MBR disks and pre-UEFI OSes. Disable it for clean UEFI + GPT installs.
- **Resizable BAR / Smart Access Memory** — lets the CPU address full GPU VRAM at once. Small FPS gains in modern titles.

**Beat 2 — the Friday night build.** You finish a new gaming rig: Ryzen 7 9800X3D, 32GB DDR5-6000, RTX 5080, NVMe boot drive. First boot.

**Boot to BIOS.** RAM shows 4800 MT/s, not 6000. *XMP/EXPO is off by default — every single time, on every single board.* Flip it on, save, reboot. Now it's 6000.

**Windows install fails with "this PC can't run Windows 11."** TPM is disabled. Enable fTPM in the Advanced menu, save, reboot. Installer accepts the machine. *Windows 11 will not install without TPM 2.0 and Secure Boot — not "should not," will not.*

**Install Hyper-V for a homelab VM.** It refuses. Virtualization is off. Reboot to BIOS, enable SVM Mode (AMD) or VT-x (Intel), enable IOMMU if you want PCIe passthrough later. *Every hypervisor question on the exam assumes you remembered this step.*

**Dual-boot Linux on a second NVMe.** GRUB won't load. Secure Boot is rejecting the unsigned shim. Either disable Secure Boot (easy, less secure) or enroll the distro's signing key via MOK (harder, keeps the security model intact). *Secure Boot isn't "Linux hostile" — it's "unsigned-code hostile." Modern Ubuntu, Fedora, openSUSE ship signed shims that work fine.*

**Beat 3 — same questions, enterprise build.** Imagine a corporate fleet rollout: 500 Dell OptiPlex workstations shipping to a regulated industry. The same six settings exist in their BIOS, but now they get pushed by policy, not by a tech sitting at each machine.

- **Boot order** — locked to internal NVMe only. USB and PXE boot disabled in production, enabled only during imaging by a temporary BIOS profile.
- **Secure Boot** — required. Audit logs trip if disabled.
- **TPM** — required, owned by the OS, BitLocker recovery keys escrowed to Active Directory or Intune.
- **Virtualization** — enabled fleet-wide whether the user needs it or not, because Credential Guard and Device Guard (Windows security features that wall off LSASS) require VBS, which requires VT-x.
- **Admin BIOS password** — set on every machine, rotated, stored in a privileged-access vault. Users cannot enter BIOS.
- **Remote management** — Intel vPro / AMT or Dell's iDRAC equivalents, so techs can change BIOS settings without physically touching the machine.

**Beat 4 — the point.** Same six toggles. Home build: you flip them yourself, once, and forget. Enterprise: they're policy-controlled, audited, password-protected, remotely managed across thousands of endpoints. The settings don't change — the *governance around them* changes. *Get this layered model into your head: same hardware, same firmware, completely different operational discipline.*

## Key facts

### Core settings cheat sheet

| Setting | What it does | When to toggle |
|---|---|---|
| Boot order | Picks which device boots first | Installing OS, booting from USB rescue |
| Secure Boot | Verifies bootloader signature | Must be ON for Win11, may need OFF for old Linux/custom kernels |
| TPM 2.0 (fTPM/PTT) | Crypto chip for BitLocker, Win11, Hello | ON for any modern Windows deployment |
| VT-x / AMD-V (SVM) | CPU virtualization | ON for Hyper-V, WSL2, VMware, Docker |
| VT-d / AMD-Vi (IOMMU) | PCIe passthrough, DMA protection | ON for GPU passthrough, ON for VBS |
| XMP / EXPO / DOCP | RAM overclock profile | ON, always, you paid for the speed |
| CSM | Legacy BIOS emulation | OFF for modern UEFI + GPT installs |
| Fast Boot | Skip POST enumeration | OFF if you ever need to enter BIOS from cold |
| Resizable BAR / SAM | Full GPU VRAM access | ON for gaming, no downside on modern hardware |
| Wake-on-LAN | Boot via magic packet | ON for remote management, OFF for security-sensitive endpoints |

### BIOS passwords

Two distinct password types, both A+ favorites:

- **Supervisor / Administrator password** — required to enter BIOS setup or change settings. Doesn't block booting.
- **User / Power-on password** — required at POST to boot the machine at all. Blocks unauthorized use, but a determined attacker pulls the CMOS battery and clears it.

> **CompTIA exam trap:** The CMOS battery clears BIOS settings *including* the user password on consumer motherboards. Enterprise laptops (ThinkPad, Latitude, EliteBook) store the password in a separate secure NVRAM that survives CMOS reset — and clearing it requires the OEM and proof of ownership. This is why stolen business laptops are bricks.

### CMOS battery symptoms

When the CR2032 dies:

- **System clock resets** to 2009 or some default epoch every cold boot
- **BIOS settings revert to defaults** — boot order, XMP, fan curves, all gone
- **Boot delays or POST errors** — "CMOS checksum error, press F1 to continue"
- **HTTPS certificate errors** in the browser because the clock is years off

Fix: power off, unplug, replace the CR2032, re-enter settings. Five-minute job. Counts as a real ticket.

### UEFI vs legacy BIOS

| | Legacy BIOS | UEFI |
|---|---|---|
| Partition scheme | MBR (2TB limit, 4 primary partitions) | GPT (effectively unlimited) |
| Boot method | Bootloader in MBR's first 512 bytes | Bootloader files on EFI System Partition |
| Interface | Text-mode, keyboard only | Graphical, mouse support |
| Secure Boot | No | Yes |
| Boot speed | Slower (full enumeration) | Faster (parallel init, Fast Boot option) |
| Network stack | No | Yes (PXE, HTTP boot built in) |

CSM bridges the gap — it lets UEFI firmware boot legacy MBR disks. Disable CSM for a pure UEFI environment.

### Firmware updates

BIOS/UEFI updates ship as flashable images. Modern boards support:

- **In-OS flashing** — vendor utility from Windows. Convenient, riskier (a crash mid-flash bricks the board).
- **BIOS-menu flashing** — Q-Flash, EZ-Flash, M-Flash, etc. Boot to BIOS, point to a USB stick with the file. Safer.
- **BIOS Flashback** — flash with no CPU or RAM installed. Plug PSU, USB stick in the labeled port, press the button. Saves you when a new CPU isn't supported by the shipped BIOS.

Never flash unless you have a reason: new CPU support, documented security fix (Spectre/Meltdown class), or a stability bug the release notes name. A working board doesn't need newer firmware.

### CompTIA exam traps

> **Exam trap:** "User can't install Windows 11" → check TPM and Secure Boot in BIOS *before* anything else. Don't go down the "is the ISO corrupt" path. CompTIA wants you to know this is a firmware-config problem.

> **Exam trap:** "System clock keeps resetting after shutdown" → CMOS battery, not a Windows time sync issue. The time-sync answer is wrong because the problem happens *before* the OS loads.

> **Exam trap:** Boot order and **boot device priority** can be set per-device or per-boot. The one-time boot menu (F12 / F11 / F9 depending on vendor) doesn't change the permanent boot order — it just selects for this boot only. CompTIA distinguishes the two.

> **Exam trap:** Disabling Secure Boot does *not* disable TPM, and vice versa. They're independent settings. A question that says "disabled Secure Boot, now BitLocker prompts for recovery key" — that's TPM measuring a config change, not Secure Boot itself.

## Helpdesk reality

- **"My computer says CMOS checksum error and won't boot until I press F1."** CMOS battery. Five-dollar part, fifteen-minute fix including documenting it. Don't promise it'll fix every weird symptom they're seeing — replace the battery, verify the clock holds across a cold boot, close the ticket.
- **"I can't boot from this USB."** Check Secure Boot (may reject unsigned media), check boot order, check whether the USB was written in UEFI mode or legacy mode. Rufus has a dropdown for this; users never picked the right one.
- **"My RAM is running slow."** XMP/EXPO is off. This is the single most common "my new build feels slow" cause. Enable it, reboot, run a stability test. If the system won't POST after enabling, the kit may not be on the QVL for that board.
- **"Hyper-V/WSL/Docker won't start."** Virtualization is disabled in BIOS. Walk them through entering BIOS, finding SVM or VT-x, enabling it, saving with F10. This is a daily ticket.
- **Never promise** that a BIOS update will fix a specific bug unless the release notes name it. "Latest firmware" is not a troubleshooting step on its own — it's a change, and changes need a reason.

## Related concepts

[[CPU Architecture]] · [[RAM Types and Speeds]] · [[Secure Boot and TPM]] · [[UEFI vs Legacy BIOS]] · [[POST and Boot Process]] · [[CMOS Battery]] · [[Motherboard Components]] · [[Virtualization]] · [[BitLocker]] · [[Boot Order Troubleshooting]]

*Source: VIRGIL knowledge base — 2026-05-11*