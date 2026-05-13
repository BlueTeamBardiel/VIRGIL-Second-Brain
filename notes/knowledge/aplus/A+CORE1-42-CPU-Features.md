# CPU Features

## What it is

The CPU is the brain. Everything else in the box exists to feed it data, cool it, or display what it computed. But "brain" alone undersells it — modern CPUs are brains with built-in security guards, translators, and traffic cops. The features baked into silicon decide what your machine can actually *do*, not just how fast it counts.

CPU features are the architectural capabilities of a processor beyond raw clock speed and core count: instruction set (x86/x64 vs ARM), virtualization extensions (Intel VT-x, AMD-V), hardware-level encryption acceleration (AES-NI), socket compatibility, multi-socket capability, and core/thread configuration (P-cores, E-cores, SMT). These features determine whether a CPU can run a hypervisor, encrypt a disk without melting, boot a 64-bit OS, or sit next to another CPU on the same board.

In plain terms: two CPUs with identical core counts can have wildly different capabilities. One runs VMs natively; the other can't. One offloads BitLocker to dedicated silicon; the other taxes the cores. The features list is where that lives.

## Why it matters

Pick the wrong CPU and the build is dead before it boots. The socket has to match the motherboard. The architecture has to match the OS. If the user wants to run Hyper-V, VirtualBox, WSL2, or Docker Desktop, virtualization extensions have to be present *and enabled in BIOS*. If TPM 2.0 is required (Windows 11, BitLocker), the CPU's firmware-based TPM has to support it.

CompTIA Objective 220-1201 3.5 covers CPU architecture, socket types, x86/x64 vs ARM, multisocket, core configurations, and virtualization support. The exam tests whether you can match a CPU to a workload, identify why a VM won't start, and recognize when a socket mismatch is the silent killer of an upgrade.

In the field, this is the single most common upgrade-gone-wrong: tech orders a CPU that "fits" the motherboard physically, ignores the chipset compatibility list, and bricks the deployment.

## In your build, in the enterprise

**Beat 1 — Technical depth.**

Modern x86-64 CPUs from Intel and AMD share the same instruction set baseline (the descendant of x86 from the 1980s, extended to 64-bit by AMD in 2003 — hence "AMD64" or "x64"). On top of that baseline, vendors layer extensions: SSE, AVX, AVX-512 for parallel math; AES-NI for encryption acceleration; VT-x/VT-d (Intel) and AMD-V/AMD-Vi (AMD) for virtualization; TXT/SEV for secure enclaves. ARM is a different instruction set entirely — RISC (Reduced Instruction Set Computing) vs x86's CISC. ARM dominates phones, Apple Silicon Macs, and an increasing share of cloud servers (AWS Graviton). An x86 binary will not run natively on ARM; emulation layers (Rosetta 2, Windows-on-ARM Prism) bridge the gap with a performance tax.

Sockets are physical and electrical. Intel's current LGA 1851 (Core Ultra) and AMD's AM5 (Ryzen 9000) are not interchangeable. Multi-socket boards exist for Xeon and EPYC — two, four, sometimes eight CPUs sharing memory across an interconnect (Intel UPI, AMD Infinity Fabric). Consumer chips do not multi-socket. Ever.

Core configurations split two ways. Hybrid (Intel Core Ultra) mixes Performance cores and Efficient cores on one die — the OS scheduler decides which gets the workload. Homogeneous (AMD Ryzen, server Xeon/EPYC) gives you identical cores across the chip, sometimes stacked with 3D V-Cache for gaming wins.

**Beat 2 — Feynman example via gaming/personal build.**

You're building a homelab on a gaming chassis. Goal: play Tarkov at 1440p, run three Linux VMs for CCNA practice, encrypt the boot drive with BitLocker.

**The socket question:** Ryzen 7 9800X3D, AM5 socket, B850 board. Check the motherboard QVL (Qualified Vendor List) before clicking buy. *The chip fits the socket physically — that doesn't mean the BIOS recognizes it.* A board shipped before the CPU launched needs a BIOS flash first, sometimes via a USB BIOS Flashback button with no CPU installed.

**The virtualization question:** AMD-V is on the silicon. It's also disabled in BIOS by default on half the boards I've touched. Boot, F2, find SVM Mode (AMD) or VT-x (Intel), enable it, save, reboot. *VirtualBox throwing "VT-x is not available" is not a software bug — it's a BIOS setting you forgot.*

**The encryption question:** BitLocker wants TPM 2.0. The 9800X3D has fTPM (firmware TPM) built in. Enable it in BIOS under Security or AMD CPU Configuration. Windows 11 install sees it, BitLocker arms itself, the boot drive is encrypted with hardware-backed keys. *No discrete TPM module needed. The CPU is the TPM.*

**The kicker:** Months later you decide to add a second GPU for local AI inference. The 9800X3D has 24 PCIe 5.0 lanes from the CPU. Two GPUs at x16 each? Not happening on consumer silicon. *Consumer CPUs are lane-starved by design. That's the line where workstation chips start earning their price.*

**Beat 3 — Bridge from gaming to enterprise.**

Same question — "does this CPU fit my workload?" — different right answers across four builds:

- **Gaming PC:** Ryzen 7 9800X3D or Core Ultra 7 265K. Eight P-cores plenty, 3D V-Cache or hybrid scheduling for FPS. Single socket. fTPM for Windows 11.
- **Developer rig running 6 VMs:** Ryzen 9 9950X or Core Ultra 9 285K. 16+ cores, virtualization extensions confirmed, 64–128 GB RAM, IOMMU enabled for PCIe passthrough.
- **Security analyst workstation:** Threadripper 7970X or Xeon W. 32+ cores for parallel sandbox detonation, ECC memory, AES-NI for full-disk encryption at speed, sometimes Intel TXT for measured boot.
- **Production hypervisor host:** Dual-socket EPYC 9004 or Xeon Scalable Gen 5. 64+ cores per socket, 128+ across the box, NUMA-aware OS, hardware HSM in a PCIe slot, Secure Encrypted Virtualization (SEV) so VM memory is encrypted from the host.

**Beat 4 — The point.**

Same fundamental question — what features does this workload need from the silicon? — different right answers depending on whether you're chasing frames, juggling VMs, analyzing malware, or hosting a hundred tenants. Get this question into your bones. You will ask it for the rest of your career, every time someone hands you a budget and a workload.

## Key facts

### CPU architecture: x86/x64 vs ARM

| Architecture | Type | Used in | Key trait |
|---|---|---|---|
| **x86** (32-bit) | CISC | Legacy PCs, embedded | Caps RAM at 4 GB, mostly extinct |
| **x64 / AMD64** | CISC | Modern Intel & AMD desktops/servers | 64-bit registers, addresses up to 256 TB RAM |
| **ARM** | RISC | Phones, Apple Silicon, Snapdragon laptops, AWS Graviton | Lower power, simpler instructions, not binary-compatible with x86 |

> **CompTIA exam trap:** x64 was invented by AMD, not Intel. Intel licensed it back from AMD. The architecture is correctly called AMD64 in technical docs even when running on an Intel chip. CompTIA may also call it "Intel 64" or "EM64T" — same thing.

### Consumer CPU tiers (2026)

| Tier | Intel (Core Ultra) | AMD (Ryzen 9000) | Workload fit |
|---|---|---|---|
| Entry | Core Ultra 3 | Ryzen 3 | Office, web, light work |
| Mainstream | Core Ultra 5 | Ryzen 5 | Gaming sweet spot, business workstation |
| Enthusiast | Core Ultra 7 | Ryzen 7 (9800X3D = best gaming CPU) | Content creation, light VMs, dev work |
| Flagship | Core Ultra 9 | Ryzen 9 | Workstation loads, heavy VMs, streaming + gaming |

### Workstation/server tier

| Class | Examples | Sockets | Cores | Memory |
|---|---|---|---|---|
| HEDT/Workstation | Threadripper 7000, Xeon W | Single, sTR5/LGA 4677 | 24–96 | ECC, 8-channel |
| Server | EPYC 9004/9005, Xeon Scalable Gen 5/6 | 1S, 2S, 4S, 8S | 32–192 per socket | ECC RDIMM, 12-channel |

### Socket types — current generation

| Socket | Vendor | CPU family | Pins/lands |
|---|---|---|---|
| **LGA 1851** | Intel | Core Ultra (Series 2) | 1851 lands on board |
| **LGA 1700** | Intel | 12th–14th gen Core (legacy) | 1700 lands |
| **AM5** | AMD | Ryzen 7000/9000 | 1718 lands (LGA, switched from PGA) |
| **AM4** | AMD | Ryzen 1000–5000 (legacy) | PGA, pins on chip |
| **sTR5 / SP6** | AMD | Threadripper 7000 / EPYC 8004 | LGA, 4844 / 4844 lands |
| **LGA 4677** | Intel | Xeon Scalable Gen 4/5 | 4677 lands |

> **CompTIA exam trap:** LGA = Land Grid Array, pins on the *board*, contacts on the chip. PGA = Pin Grid Array, pins on the *chip*, holes in the socket. Bend a PGA pin and you bend the CPU. Bend an LGA pin and you've damaged a $400 motherboard. AMD switched from PGA (AM4) to LGA (AM5) — know that the platform changed.

### Virtualization extensions

| Feature | Intel name | AMD name | What it does |
|---|---|---|---|
| Hardware virtualization | VT-x | AMD-V (SVM) | Lets a hypervisor run guest OSes at near-native speed |
| I/O virtualization | VT-d | AMD-Vi (IOMMU) | PCIe passthrough — assign a GPU directly to a VM |
| Nested virtualization | EPT + VT-x | RVI + AMD-V | Run a hypervisor inside a VM (lab work, WSL2 on a VM) |
| Memory encryption | TME / MKTME | SEV / SEV-SNP | Encrypts VM memory so the host can't read guest RAM |

**Always disabled in BIOS by default on consumer boards.** Enable before installing the hypervisor.

### Encryption and security features

- **AES-NI** — hardware AES instructions. BitLocker, FileVault, dm-crypt all use it. Without AES-NI, full-disk encryption hammers the CPU.
- **fTPM (AMD) / PTT (Intel)** — firmware TPM 2.0 built into the CPU. Satisfies Windows 11 requirement, no discrete chip needed.
- **Intel TXT / AMD SVM** — measured boot, attests the boot chain hasn't been tampered with.
- **HSM (Hardware Security Module)** — separate dedicated device, not a CPU feature. PCIe card or external appliance. Stores keys for high-assurance workloads (banking, certificate authorities). When CompTIA says HSM, they mean the dedicated device, not fTPM.

### Multisocket and core configurations

- **Single socket** — every consumer CPU. One CPU, one socket, done.
- **Multisocket (2S, 4S, 8S)** — server only. CPUs share memory over an interconnect. NUMA-aware OS scheduling matters; cross-socket memory access is slower than local.
- **Hybrid cores (Intel)** — P-cores (performance, hyperthreaded) + E-cores (efficient, single-threaded). Thread Director routes workloads.
- **Homogeneous cores (AMD)** — all cores identical. Some Ryzen X3D parts add 3D V-Cache to one CCD for gaming.
- **SMT / Hyper-Threading** — one physical core presents as two logical threads. Roughly 20–30% throughput gain on parallel workloads.

> **CompTIA exam trap:** "Cores" and "threads" are not the same. A 16-core / 32-thread CPU has 16 physical cores with SMT enabled. Disable SMT and you have 16 cores, 16 threads. Some security-sensitive workloads disable SMT to mitigate side-channel attacks (Spectre, Foreshadow).

## Helpdesk reality

- **"My VMs won't start, it says VT-x is missing."** — BIOS setting. Reboot, F2/Del, enable VT-x or SVM, save, reboot. 90% of "broken Hyper-V" tickets.
- **"Can I upgrade my CPU?"** — Check the socket, then the motherboard QVL, then the BIOS version. Three checks, in that order. Skipping any one of them ends in a returned chip.
- **"Windows 11 install says my PC isn't supported."** — Usually fTPM/PTT disabled in BIOS, or Secure Boot off. Enable both. Don't promise it'll fix it until you've confirmed the CPU is on the supported list.
- **"My encryption is killing performance."** — On a CPU without AES-NI (very old hardware), yes. On anything from the last decade, no — something else is the bottleneck. Check disk I/O, not the CPU.
- **Never** promise a CPU upgrade on a prebuilt OEM machine without checking the BIOS will accept it. Dell, HP, and Lenovo lock their BIOSes to a CPU whitelist. The chip will fit and the system will refuse to POST.

## Related concepts

[[Motherboard Form Factors]] · [[BIOS UEFI]] · [[TPM and Secure Boot]] · [[Cooling and Thermal Paste]] · [[RAM Types and ECC]] · [[Virtualization Basics]] · [[PCIe Lanes and Expansion Cards]] · [[CPU Sockets]] · [[Power Connectors and PSU]] · [[Windows 11 System Requirements]]

*Source: VIRGIL knowledge base — 2026-05-10*