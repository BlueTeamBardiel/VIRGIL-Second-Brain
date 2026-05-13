# The BIOS

## What it is

You press the power button. Fans spin. Nothing on screen yet. For the next two or three seconds, before Windows even exists as a concept, a tiny program living in a chip on your motherboard is checking that the CPU is alive, the RAM is real, the GPU answers when called, and the boot drive is reachable. Only after that handoff does the operating system get to wake up.

That tiny program is the **BIOS** — Basic Input/Output System. Or on every machine built in the last decade, its modern replacement: **UEFI** (Unified Extensible Firmware Interface). It's the first thing the machine remembers when it wakes up. It runs before the soul (the kernel) loads, sets up the body (initializes hardware), then hands off control and gets out of the way.

Technically: firmware stored on a non-volatile flash chip on the motherboard, executed by the CPU at power-on. It performs the **POST** (Power-On Self-Test), enumerates hardware, applies your saved configuration, and locates a bootable device to chain-load the OS bootloader.

UEFI is the modern standard. It supports drives larger than 2 TB (via GPT instead of MBR), boots faster, runs Secure Boot, has a mouse-driven GUI, and isn't shackled to 1980s 16-bit real mode. People still call it "the BIOS" out of habit. Don't fight it.

## Why it matters

The BIOS/UEFI is where you fix problems the OS can't see. RAM not detected? BIOS. CPU running at base clock instead of boost? BIOS. New NVMe invisible to Windows installer? BIOS. Secure Boot blocking your Linux dual-boot? BIOS. TPM not showing up so Windows 11 won't install? BIOS. Fans screaming at idle? BIOS.

It's also the first attack surface. A rootkit that lives in firmware survives every OS reinstall, every disk wipe, every "nuke it from orbit." That's why Secure Boot, BIOS passwords, and TPM-backed measured boot exist — and why CompTIA tests them on 220-1201 Objective 3.5.

For the exam: know the difference between BIOS and UEFI, know what Secure Boot does, know what TPM is for, know the boot order menu, know how to update firmware, and know the password types. For the job: the BIOS is the first place a senior tech tells you to check when the machine isn't behaving and the OS hasn't loaded yet.

## In your build, in the enterprise

**Beat 1 — Technical depth.** The BIOS chip is non-volatile flash, typically SPI, soldered or socketed on the motherboard. A small coin cell battery (CR2032) keeps the **CMOS** chip alive — that's where your settings and the real-time clock live. Pop the battery or short the clear-CMOS jumper and your settings reset to defaults. The firmware itself stays on the flash chip; only your tweaks reset.

UEFI replaces the old 16-bit BIOS interrupt model with a modular pre-boot environment. It supports **GPT** partition tables (drives over 2 TB, more than 4 primary partitions), **Secure Boot** (only signed bootloaders allowed to run), and a real driver model so it can talk to NVMe, USB 3, and modern GPUs before the OS loads. **POST** still happens — beep codes, diagnostic LEDs, Q-codes on enthusiast boards. Learn your motherboard's diagnostic indicators. They'll save you an hour at 1 AM.

Key UEFI/BIOS settings you'll touch: boot order, Secure Boot toggle, **TPM** enable, **virtualization** support (Intel VT-x / AMD-V, plus VT-d / AMD-Vi for IOMMU passthrough), **XMP/EXPO** memory profiles, fan curves, CPU power limits, SATA mode (AHCI vs RAID), and the supervisor/user passwords.

**Beat 2 — The 2 AM Tarkov scenario.**

**The crash:** Fresh Ryzen 7 9800X3D build. Windows installed. You boot Tarkov for the first time. Twelve frames per second. Task Manager says CPU is running at 3.6 GHz — its base clock. *Boost is dead.*

**The RAM tell:** You check RAM speed. DDR5-4800. You bought DDR5-6000 CL30. *XMP/EXPO is off by default. The motherboard runs every stick at JEDEC base spec until you tell it otherwise.*

**The fix:** Reboot, mash Delete, into UEFI. Enable EXPO Profile 1. Save. Reboot. RAM now at 6000 MT/s. While you're in there, you also enable Secure Boot (Windows 11 wanted it), turn on fTPM (already on, good), and set the CPU fan curve so it doesn't scream during cutscenes. *Three settings, ten minutes, problem solved.*

**The kicker:** Six months later you're troubleshooting a friend's "slow" build over Discord. First question: "Did you enable EXPO?" Silence. *Every default UEFI profile is conservative. Every enthusiast build needs a fifteen-minute UEFI tour before it performs as advertised.*

**Beat 3 — Same machine, enterprise context.** Now imagine that same Ryzen box is a developer workstation at a Fortune 500. IT images it from a golden image over PXE. The UEFI is configured by policy: Secure Boot **mandatory**, TPM **enabled and owned by BitLocker**, supervisor password set so end users can't change boot order, USB boot **disabled**, network boot enabled only for the imaging VLAN, virtualization enabled for Hyper-V/WSL2. The user never sees the UEFI screen. They're not supposed to.

On a server in the same company's datacenter, the equivalent is **iDRAC** (Dell), **iLO** (HPE), or **BMC/IPMI** generally — out-of-band management that lets you reach the firmware over the network, mount an ISO remotely, and reboot a machine in another building at 3 AM. Same firmware concepts. Different access model. Same fundamental question: *who is allowed to change the pre-OS configuration?*

**Beat 4 — The point.** The question is always the same: **what runs before the OS, and who controls it?** On your gaming rig, you control it. On a corporate workstation, IT controls it. On a server, the BMC controls it remotely. Different scales, different stakeholders, same firmware layer doing the same job. Get this question into your bones — when something boots wrong, you'll know exactly which layer failed.

## Key facts

### BIOS vs UEFI

| Feature | Legacy BIOS | UEFI |
|---|---|---|
| CPU mode at boot | 16-bit real mode | 32/64-bit protected mode |
| Partition scheme | MBR (max 2 TB, 4 primary) | GPT (effectively unlimited) |
| Boot speed | Slow | Fast (parallel init) |
| Secure Boot | No | Yes |
| Interface | Text, keyboard only | GUI, mouse support |
| Network stack | No | Yes (PXE built in) |
| Drive support | INT 13h, ~2 TB ceiling | Native large-drive support |

Most "BIOS" settings menus today are actually UEFI. The name stuck.

### Boot options

- **Boot order / boot priority** — which device the firmware tries first. Common entries: NVMe/SSD, USB, network (PXE), optical.
- **UEFI vs Legacy/CSM** — Compatibility Support Module emulates old BIOS for legacy OSes. Disable CSM for clean UEFI boot. Required for Secure Boot.
- **Boot override / one-time boot menu** — usually F12 or F11 at POST. Boots a USB once without changing the saved order.
- **PXE boot** — boot from network. How enterprises image fleets.

### Security settings

| Setting | What it does |
|---|---|
| **Supervisor / BIOS password** | Required to enter UEFI setup. Locks configuration. |
| **User / boot password** | Required to boot the machine at all. |
| **Secure Boot** | Firmware verifies bootloader signatures against a key database. Blocks unsigned bootkits. |
| **TPM (Trusted Platform Module)** | Crypto chip for key storage. Backs BitLocker, Windows Hello, measured boot. Discrete chip or **fTPM** (firmware TPM in CPU). |
| **HSM (Hardware Security Module)** | Enterprise-grade key management appliance. Not on consumer boards — datacenter gear for CA roots, payment processing, etc. |
| **Drive encryption** | BitLocker (Windows) and similar tools rely on TPM to seal keys to the boot state. |

### Virtualization support

Has to be enabled in UEFI before any hypervisor will work properly:

- **Intel VT-x / AMD-V** — basic CPU virtualization. Required for Hyper-V, VMware, VirtualBox, WSL2, Docker Desktop, Android emulators.
- **Intel VT-d / AMD-Vi (IOMMU)** — device passthrough. Required for GPU passthrough to a VM, SR-IOV.
- **SVM Mode** — AMD's name for VT-x in some BIOS menus.

If your VM software complains that virtualization is disabled, the user didn't go into UEFI. Common helpdesk ticket.

### Performance & monitoring

- **XMP (Intel) / EXPO (AMD)** — one-click memory overclocking profile. Without it, your DDR5-6000 runs at DDR5-4800.
- **Fan curves / fan considerations** — map fan RPM to temperature. CPU fan, case fans, AIO pump headers. Set aggressive curves for builds with high TDP CPUs; quiet curves for office machines.
- **Temperature monitoring** — CPU, motherboard, sometimes VRM temps. Visible in UEFI and via OS tools (HWiNFO, BIOS-equivalent vendor utilities).
- **Power limits / PBO / TDP** — set CPU power ceiling. Lower for thermal headroom, higher for sustained boost.

### Firmware updates

- **Why update:** new CPU support (huge for AM4/AM5 boards adding new Ryzen gens), microcode security patches (Spectre, Meltdown, Downfall), bug fixes.
- **How:** vendor utility from inside the OS, **flash from USB** at the UEFI screen, or **BIOS Flashback** (some boards flash without a CPU installed — life-saver for new gen CPUs on old-stock boards).
- **The risk:** a failed flash bricks the board unless it has dual-BIOS or flashback recovery. Don't flash during a thunderstorm. Don't flash on a laptop running on battery.

*Update the BIOS only when you have a reason. "Latest is greatest" is how you brick a working machine.*

### CompTIA exam traps

> **CompTIA exam trap: BIOS password vs boot password.** A **BIOS password** (supervisor password) protects access to the firmware setup utility. A **boot password** (user/power-on password) is required to boot the system at all. CompTIA will give you a scenario and ask which to set. Read the question — "prevent unauthorized config changes" = BIOS password; "prevent unauthorized power-on" = boot password.

> **CompTIA exam trap: TPM vs HSM.** TPM is on the motherboard, protects one machine, backs BitLocker and measured boot. HSM is a dedicated appliance (or PCIe card in big enterprises) for managing crypto keys at scale — CA roots, code signing, payment systems. If the question is about a single PC, it's TPM. If it's about an enterprise key management appliance, it's HSM.

> **CompTIA exam trap: Secure Boot blocks Linux.** Not always. Mainstream distros (Ubuntu, Fedora, RHEL) ship signed shims that work with Secure Boot. Niche distros and custom kernels don't. The exam answer for "Linux won't boot after enabling Secure Boot" is usually disable Secure Boot OR enroll the distro's keys.

> **CompTIA exam trap: clearing the CMOS.** Resets settings, **not** the firmware itself. Done by pulling the CR2032 battery for ~30 seconds OR shorting the CLR_CMOS jumper. Will NOT recover a bricked firmware flash. Will reset a forgotten BIOS password on most consumer boards (not on business-class machines with a separate security chip).

## Helpdesk reality

- **"My new RAM isn't running at the speed on the box."** XMP/EXPO is off. Walk them into UEFI, enable the profile, save and reboot. Most common "my build is slow" ticket on the planet.
- **"Windows 11 install says my PC isn't supported."** TPM 2.0 disabled or Secure Boot off. Both live in UEFI. Enable fTPM (Ryzen) or PTT (Intel), enable Secure Boot, retry install.
- **"My VM software says virtualization isn't enabled."** They didn't enable VT-x/AMD-V in UEFI. Walk them in, toggle it, save, reboot. Hyper-V/WSL2/Docker Desktop won't run without it.
- **"I forgot the BIOS password."** On consumer boards: pull the CMOS battery or short the jumper. On business laptops (Dell, Lenovo, HP) with security chips: vendor service call, often requires proof of ownership. Never promise a quick fix on locked business hardware.
- **"My PC won't boot after a BIOS update."** Hope the board has dual-BIOS or BIOS Flashback. If not, this is an RMA or a board-level repair. Document why you don't flash firmware without a reason.

## Related concepts

[[Motherboard Form Factors]] · [[CPU Architecture]] · [[TPM and Hardware Security]] · [[Secure Boot and Measured Boot]] · [[POST and Diagnostic Indicators]] · [[BitLocker and Drive Encryption]] · [[Virtualization Basics]] · [[PXE Boot and Imaging]]

*Source: VIRGIL knowledge base — 2026-05-10*