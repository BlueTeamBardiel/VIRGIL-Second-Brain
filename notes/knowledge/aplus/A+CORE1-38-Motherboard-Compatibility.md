# Motherboard Compatibility

## What it is

You found a deal on a used CPU. Cheap. You drop it into your existing board and nothing posts. Not dead — just incompatible. The socket fits, but the chipset doesn't recognize the silicon, or the BIOS is two versions too old, or the VRM can't deliver enough current. The board is the nervous system of the build, and like any nervous system, it only speaks to organs it was designed to speak to.

In plain English: a motherboard isn't a universal docking station. It's a tightly-spec'd platform that supports a specific socket family, a specific RAM standard, a specific PCIe generation, a fixed number of power phases, and a chassis size that constrains what fits around it. Compatibility is the matrix you check *before* you buy parts, not after.

Technically, motherboard compatibility means verifying that every component you intend to install — CPU, RAM, GPU, storage, cooler, PSU, case — is supported by this board's socket, chipset, firmware version, form factor, connector layout, and power delivery design. Miss one and the build doesn't boot.

## Why it matters

Compatibility mistakes are the single most common reason a first-time builder's PC won't post. They're also the most common reason a corporate refresh project gets delayed — a tech orders 200 NVMe drives and finds out the procurement-spec workstations only have one M.2 slot wired for PCIe 3.0 x2.

CompTIA tests this directly under **Objective 220-1201 3.5** — install and configure motherboards, CPUs, and add-on cards. They want you to know form factors, socket types, connector types, BIOS/UEFI settings, virtualization and encryption features (TPM, Secure Boot), and which expansion cards plug into which slots. The exam loves to ask "tech installs new CPU, system won't post — what's the most likely cause?" The answer is almost always BIOS version or socket mismatch.

In the field, this is the homework that prevents a return trip. Verify before you order.

## In your build, in the enterprise

**Beat 1 — what you're actually checking.** Compatibility breaks down into seven matrices:

1. **Socket** — LGA1851 (Intel Core Ultra), AM5 (Ryzen 9000), LGA4677 (Xeon), SP5 (EPYC). The CPU's pin/land pattern must match the socket exactly. AM4 chips do not fit AM5. Intel changes sockets roughly every two generations.
2. **Chipset** — the southbridge silicon (Intel Z890/B860/H810, AMD X870/B850/A820) determines PCIe lane count, USB versions, SATA ports, and overclocking support. A Ryzen 9 9950X works in a B850 board, but you lose PCIe 5.0 lanes and overclock headroom.
3. **BIOS/UEFI version** — newer CPUs often need a firmware update *before* the board will recognize them. AMD AM5 boards shipping in 2024 frequently need a flash before they post a 2025 Ryzen.
4. **RAM** — DDR5 boards take DDR5 only. Speed is rated by the board's QVL (Qualified Vendor List); pushing past it requires XMP/EXPO and may not stabilize.
5. **Form factor** — ATX, microATX, Mini-ITX, E-ATX. Must fit the case and align with the case's standoffs.
6. **Power connectors** — modern boards take a 24-pin ATX plus one or two 8-pin EPS for the CPU. High-end boards want both 8-pins populated.
7. **Expansion and storage** — PCIe slot count and generation, M.2 slot count and lane wiring, SATA port count, front-panel headers (USB-C, USB 3.2, fan headers, RGB).

**Beat 2 — the gaming build that almost didn't post.** You're building a Ryzen 7 9800X3D rig in late 2025. Picked a B850 board on sale, 32GB DDR5-6000, RTX 5070 Ti, single 2TB NVMe. Box arrives, you assemble, hit power. Fans spin. No post. No display. Debug LED stuck on CPU.

**The diagnosis:** Board was manufactured before the 9800X3D launched. Its shipping BIOS doesn't recognize the chip. *The hardware is fine. The firmware is blind to it.*

**The fix:** Most modern AM5 boards have **BIOS Flashback** — a USB port and a button on the rear I/O that flashes firmware with no CPU installed. Download the latest BIOS to a FAT32 USB stick, plug PSU in, hit the button, wait five minutes. Then try posting again. *This feature exists specifically because AMD ships new CPUs onto old sockets.*

**The second gotcha:** You enable EXPO in BIOS to get your DDR5-6000 running at rated speed. System reboots into a loop. Dropped back to JEDEC default 4800. *RAM compatibility isn't just "DDR5 fits the slot" — it's "this kit on this board with this CPU's memory controller at this speed."* Check the QVL. Always.

**The kicker:** Six months later you want to add a second NVMe. Slot 2 exists, but populating it disables two SATA ports per the manual's shared-lane footnote. *Every modern board shares PCIe lanes between M.2 and SATA. Read the block diagram before you buy storage.*

**Beat 3 — bridge from gaming to enterprise.** Same fundamental question — "will this CPU work in this board?" — at scale.

In a corporate refresh, the IT team specs Dell OptiPlex workstations with Core Ultra 5 chips. Each board is a proprietary microATX with a locked BIOS, a TPM 2.0 chip soldered on, Secure Boot enforced, and exactly one M.2 slot. The board's QVL is whatever Dell certified. There is no BIOS Flashback button — firmware updates come through Dell's management tooling.

In a server build — a 2U rackmount with dual EPYC 9554s — compatibility is enforced by the vendor's HCL (Hardware Compatibility List). Multisocket boards require matched CPUs (same model, same stepping). RAM must be RDIMM or LRDIMM ECC, not the unbuffered desktop kit. PSUs are redundant 1+1 hot-swap units with a specific connector standard. The OS itself (VMware ESXi, Windows Server, Proxmox) has its own HCL, and if your NIC isn't on it, you don't get drivers.

**Beat 4 — the point.** Same question, four contexts, different right answers. *The gaming builder checks the manufacturer's CPU support page and BIOS version. The corporate tech checks the OEM's certified configuration. The server admin checks the vendor HCL and the hypervisor HCL.* The discipline is identical. Verify compatibility before you buy. Get this into your bones — it's the difference between a build that posts and a Tuesday afternoon spent on the phone with vendor support.

## Key facts

### Form factors

| Form factor | Size | Use case |
|---|---|---|
| **E-ATX** | 305 × 330mm | HEDT, dual-socket workstations, enthusiast |
| **ATX** | 305 × 244mm | Standard desktop, gaming, full features |
| **microATX** | 244 × 244mm | Office PCs, budget builds, fewer slots |
| **Mini-ITX** | 170 × 170mm | SFF builds, HTPCs, one PCIe slot |

Form factor determines case fit, slot count, and standoff alignment. A microATX board fits an ATX case (extra standoffs unused). An ATX board does not fit a microATX case.

### Socket types (current as of 2026)

| Socket | Platform | RAM |
|---|---|---|
| **LGA1851** | Intel Core Ultra (Arrow Lake, Meteor Lake desktop) | DDR5 |
| **AM5** | AMD Ryzen 7000/8000/9000 | DDR5 |
| **LGA4677** | Intel Xeon Sapphire/Emerald Rapids | DDR5 ECC |
| **SP5** | AMD EPYC 9004/9005 | DDR5 ECC |
| **AM4** (legacy) | AMD Ryzen 1000–5000 | DDR4 |
| **LGA1700** (legacy) | Intel 12th–14th gen | DDR4/DDR5 |

### CPU architecture

- **x86/x64** — Intel and AMD desktop/server. CISC instruction set. Backward compatible to 1978.
- **ARM** — Apple Silicon, Qualcomm Snapdragon X, AWS Graviton. RISC instruction set. Lower power, growing in laptops and servers.
- **Core configurations** — physical cores, hyperthreading/SMT (logical threads = 2× cores), P-cores vs E-cores on modern Intel.
- **Multisocket** — server boards with 2, 4, or 8 sockets. Requires matched CPUs and NUMA-aware operating systems.

### Connector types

| Connector | Purpose |
|---|---|
| **24-pin ATX** | Main board power |
| **8-pin (4+4) EPS** | CPU power; high-end boards take two |
| **PCIe x16 / x8 / x4 / x1** | Expansion: GPU, capture card, NIC, sound card |
| **M.2** | NVMe SSDs (PCIe) or SATA SSDs depending on slot wiring |
| **SATA** | 2.5"/3.5" drives, optical |
| **eSATA** | External SATA, hot-swappable, mostly legacy |
| **Fan headers (4-pin PWM)** | CPU, case, AIO pump |
| **Front-panel headers** | Power button, reset, USB, audio |
| **RGB headers** | 12V 4-pin or 5V 3-pin ARGB |

### BIOS/UEFI features tested on the exam

- **Secure Boot** — only signed bootloaders run. Required for Windows 11.
- **TPM 2.0** — hardware crypto chip storing BitLocker keys, attestation hashes. Required for Windows 11. Often a discrete chip or fTPM in firmware.
- **HSM** — Hardware Security Module. Enterprise-grade key storage; servers, not desktops.
- **Boot order** — which device the firmware tries first.
- **BIOS password** — locks firmware settings.
- **Boot password** — required before OS loads.
- **Virtualization support** — Intel VT-x / VT-d, AMD-V / AMD-Vi (IOMMU). Must be enabled in BIOS for Hyper-V, VMware, Proxmox, WSL2.
- **XMP/EXPO** — RAM overclocking profile.
- **Fan curves and temperature monitoring** — set thermal thresholds, configure fan response.

### CompTIA exam traps

> **Exam trap:** "Tech installs new CPU. System won't post. What's the most likely cause?" — answer is **BIOS update needed**, not "CPU is dead" or "socket damaged." CompTIA loves this scenario because it's the #1 real-world cause.

> **Exam trap:** TPM vs HSM — TPM is on the motherboard for endpoint encryption (BitLocker). HSM is a separate appliance/card for enterprise key management at scale. They are not interchangeable.

> **Exam trap:** Windows 11 requires **TPM 2.0 + Secure Boot + UEFI** (not legacy/CSM). All three. Missing any one fails the install check.

> **Exam trap:** Virtualization support must be **enabled in BIOS** — it ships disabled on many OEM boxes. If a user can't run Hyper-V or WSL2, check VT-x/AMD-V before reinstalling anything.

## Helpdesk reality

- **"I bought a new CPU and my computer won't turn on."** First question: did you check the board's CPU support list and BIOS version? Nine times out of ten the board needs a flash. Walk them through BIOS Flashback if the board supports it; otherwise they need a temporary compatible CPU to do an in-OS update.
- **"My RAM is rated for 6000 MHz but Task Manager shows 4800."** XMP/EXPO isn't enabled in BIOS. Out of the box, DDR5 runs at JEDEC default. One toggle, one reboot, fixed.
- **"Windows 11 install says my PC isn't compatible."** Three checks: TPM 2.0 enabled, Secure Boot enabled, UEFI mode (not legacy/CSM). All three live in BIOS. Never promise the upgrade will work until you've verified all three.
- **"I added a second NVMe and now my SATA drive disappeared."** Shared lanes. Read the manual's block diagram. Either move the drive to a different SATA port or accept the trade.
- **Never promise a build will work without checking the QVL and CPU support list first.** "Should be fine" is how return trips happen.

## Related concepts

[[CPU Architecture]] · [[BIOS UEFI Configuration]] · [[RAM Types and Compatibility]] · [[PCIe and Expansion Cards]] · [[Form Factors and Cases]] · [[TPM and Secure Boot]] · [[Virtualization Support]] · [[Power Supply Sizing]]

*Source: VIRGIL knowledge base — 2026-05-10*