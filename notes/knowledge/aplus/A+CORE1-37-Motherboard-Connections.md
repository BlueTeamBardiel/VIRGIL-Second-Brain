# Motherboard Connections

## What it is

Look at a bare motherboard on the bench. It looks like a city seen from a plane — power lines, freeways, transit hubs, neighborhoods. Every connector is a dock where some other organ plugs into the nervous system. The board itself doesn't compute anything. It's the **nervous system** that lets the brain (CPU), the workbench (RAM), the muscles (GPU), and the warehouse (storage) talk to each other through a clean, fast, standardized set of pins and traces.

Plain English: motherboard connections are the physical sockets, headers, slots, and pin blocks that everything else in the PC plugs into. CPU socket, RAM slots, PCIe slots, M.2 slots, SATA ports, power connectors, fan headers, front-panel headers, USB headers, and the rear I/O panel.

Technical: the motherboard exposes the chipset and CPU's I/O lanes through standardized connectors — LGA/PGA sockets for the CPU, DIMM slots for memory, PCIe x16/x8/x4/x1 slots for expansion, M.2 keyed slots for NVMe and Wi-Fi cards, SATA for legacy storage, 24-pin ATX and 8-pin EPS for power delivery, and 4-pin PWM headers for fans.

## Why it matters

This is the single most compatibility-sensitive purchase in a build. Wrong socket, wrong RAM generation, wrong PCIe gen on the slot you needed — the part doesn't fit, doesn't post, or fits but runs at half speed. Every A+ tech eventually gets handed a parts box and asked "can we reuse this?" The answer lives in the connector specs.

Exam relevance: **Objective 220-1201 3.5** explicitly tests motherboard form factors, connector types, expansion slots, CPU sockets, BIOS/UEFI settings, TPM, and motherboard-to-component compatibility. CompTIA loves connector identification questions and "which slot does this card go in" scenarios.

## In your build, in the enterprise

**Beat 1 — what's actually on the board.**

Form factors set the footprint: **ATX** (305×244mm, 7 slots), **microATX** (244×244mm, 4 slots), **Mini-ITX** (170×170mm, 1 slot). Bigger board = more slots, more headers, more VRM phases.

CPU sockets in 2026: Intel runs **LGA 1851** (Core Ultra). AMD runs **AM5** (Ryzen 9000) — also LGA now, no more bent pins on the chip. Server: **LGA 4677** (Xeon), **SP5** (EPYC), **sTR5** (Threadripper).

PCIe slots are keyed by lane count: **x16** (GPU), **x8**, **x4** (NVMe risers, capture cards, 10GbE NICs), **x1** (sound cards, basic NICs). Cards negotiate down to whatever the slot supports.

**M.2** slots take NVMe SSDs (M-key, PCIe x4) or Wi-Fi cards (E-key). **SATA** ports do legacy 2.5"/3.5" drives at 6 Gb/s. Power: **24-pin ATX**, **8-pin EPS** for the CPU, plus PCIe power direct to the GPU. Front-panel headers handle power button, reset, LEDs, front USB, audio. **Fan headers** are 4-pin PWM or 3-pin DC.

**Beat 2 — the gaming PC build.**

New Ryzen 7 9800X3D, 32GB DDR5-6000, RTX 5080, 2TB NVMe Gen 5, 4TB SATA SSD for Steam overflow.

**Socket check:** 9800X3D is AM5. B650 works. X670E gets better VRM and more Gen 5 lanes. *Wrong socket, wrong generation, the chip doesn't drop in. Period.*

**RAM slot check:** AM5 is DDR5 only. Slot DIMMs in **A2 and B2** for dual-channel — silkscreen tells you which. *Single-channel cuts memory bandwidth in half. Check the manual every time.*

**PCIe layout:** GPU in the top x16 slot wired Gen 5 x16. 10GbE NIC in the bottom x4. *Drop the GPU into the second x16 slot and it might be wired x4 — game performance tanks and you spend an hour blaming drivers.*

**M.2 layout:** boot drive in the top M.2 (CPU-direct lanes). Secondary in the chipset M.2. *Some boards disable a SATA port when you populate the second M.2 — read the manual or lose drives.*

**Power and fans:** 24-pin in, 8+8 EPS, three 8-pin PCIe to the GPU. AIO pump on **CPU_FAN**, radiator fans on **CPU_OPT**. *Forget the EPS connector and the board posts to a black screen — every tech has done it once.*

**Beat 3 — same questions, different build.**

Homelab/virtualization host: ATX or E-ATX, single-socket EPYC or used Xeon. Connector list grows — **multiple 8-pin EPS** for high-TDP CPUs, **eight DIMM slots** for ECC RDIMMs, **four+ PCIe x16 slots** wired full bandwidth so a GPU, an HBA, and a 25GbE NIC run simultaneously. Virtualization toggles (Intel **VT-x / VT-d**, AMD **AMD-V / IOMMU**) live in UEFI — off by default on some boards, and ESXi/Proxmox refuse to start VMs without them.

Production server: dual-socket Xeon or EPYC, redundant 8-pin EPS per socket, hot-swap backplane connectors (SAS/SATA/NVMe via SlimSAS or MCIO), out-of-band management header (iDRAC, iLO, IPMI), no front-panel audio, no RGB. Different planet.

**Beat 4 — the point.**

Same fundamental question across every build: *what's the workload, which connectors does it demand, and does this board have them in the right configuration?* Gaming wants one fast x16 and two fast M.2s. Virtualization wants lanes, lanes, lanes. Servers want redundancy and management. **Get the connector inventory into your bones — it's the question you'll ask every time someone hands you a parts list for the rest of your career.**

## Key facts

### Form factors

| Form factor | Size | PCIe slots | Typical use |
|---|---|---|---|
| **ATX** | 305 × 244 mm | up to 7 | Standard desktop, gaming, workstation |
| **microATX** | 244 × 244 mm | up to 4 | Budget, OEM, small office |
| **Mini-ITX** | 170 × 170 mm | 1 | SFF builds, homelab nodes, HTPC |
| **E-ATX** | 305 × 330 mm | up to 7+ | HEDT, workstation, dual-socket |

### CPU sockets (2026)

| Socket | Platform | Notes |
|---|---|---|
| **LGA 1851** | Intel Core Ultra (Arrow Lake) | DDR5 only, current consumer |
| **AM5** | AMD Ryzen 7000/9000 | DDR5 only, LGA (no pins on CPU) |
| **LGA 4677** | Intel Xeon Sapphire/Emerald Rapids | DDR5 ECC, server |
| **SP5** | AMD EPYC 9004/9005 | DDR5 ECC, up to 96 cores per socket |
| **sTR5** | AMD Threadripper 7000 | HEDT/workstation, up to 96 cores |

### PCIe slot bandwidth (full x16)

| Generation | Bandwidth (x16) | Common use |
|---|---|---|
| Gen 3 | ~16 GB/s | Older GPUs, basic NICs |
| Gen 4 | ~32 GB/s | Current GPUs, NVMe SSDs |
| Gen 5 | ~63 GB/s | Top-tier GPUs, Gen 5 NVMe |

### Storage and power connectors

- **M.2 (M-key)** — PCIe x4 NVMe, modern boot drive
- **M.2 (E-key)** — Wi-Fi/Bluetooth combo cards
- **SATA III** — 6 Gb/s, 2.5"/3.5" drives
- **U.2 / SlimSAS / MCIO** — server NVMe over cable
- **24-pin ATX** — main board power
- **8-pin EPS** — CPU power, sometimes dual for high-TDP
- **6/8-pin / 12VHPWR / 12V-2x6** — GPU power direct from PSU

### Headers worth knowing

| Header | Pins | Purpose |
|---|---|---|
| **CPU_FAN** | 4-pin PWM | Required — most boards won't POST without RPM signal |
| **CPU_OPT** | 4-pin PWM | AIO radiator fans |
| **SYS_FAN / CHA_FAN** | 4-pin PWM | Case fans |
| **AIO_PUMP** | 4-pin, full 12V | Pump speed (separate from fans) |
| **F_PANEL** | 9-pin block | Power button, reset, LEDs |
| **F_USB 3.2 / Type-C** | 19/20-pin | Front USB |
| **TPM** | 14/20-pin | Discrete TPM module (rare — fTPM built-in) |

### BIOS/UEFI settings that matter

- **Secure Boot** — verifies bootloader signatures, required for Windows 11
- **TPM / fTPM / PTT** — firmware TPM 2.0, required for Windows 11 and BitLocker
- **VT-x / AMD-V** — CPU virtualization, off by default on some boards
- **VT-d / IOMMU** — PCIe device passthrough for VMs
- **XMP / EXPO** — RAM overclock profile; without it DDR5-6000 runs at 4800 MT/s
- **Boot order** — UEFI vs Legacy/CSM, NVMe vs USB priority
- **BIOS password** locks UEFI access; **Boot password** prompts before OS load

### Encryption hardware

- **TPM 2.0** — stores BitLocker keys, attestation, measured boot. Discrete chip on header OR firmware (fTPM/PTT).
- **HSM** — separate PCIe card or USB device for enterprise key custody. Not on consumer boards.

### CompTIA exam traps

> **CompTIA exam trap:** *Mini-ITX has one PCIe slot, not zero.* Memorize slot counts: ATX up to 7, microATX up to 4, Mini-ITX exactly 1.

> **CompTIA exam trap:** *TPM 2.0 vs HSM.* TPM is on the motherboard (or in CPU firmware) and binds to one machine. HSM is a separate dedicated device for enterprise key management across many systems. Pick TPM for BitLocker on a single laptop, HSM for an enterprise CA.

> **CompTIA exam trap:** *CPU_FAN header is mandatory.* Many boards refuse to POST if no RPM signal is detected on CPU_FAN. If a build "won't power on" and the AIO pump is on AIO_PUMP, move a fan to CPU_FAN.

> **CompTIA exam trap:** *M.2 slots can disable SATA ports.* Lanes are shared. Populating M.2_2 may kill SATA 5/6. Always read the manual's shared-lanes table.

> **CompTIA exam trap:** *Secure Boot ≠ BIOS password ≠ Boot password.* Secure Boot validates signed bootloaders. BIOS password locks UEFI setup. Boot password prompts before OS load. Three different controls.

## Helpdesk reality

- *"It won't turn on."* → Check the **8-pin EPS** connector first. Forgotten EPS is the #1 cause of "no POST, fans don't spin" on a fresh build. Then 24-pin seating, CPU_FAN header, front-panel power switch wiring.
- *"My new GPU is slow."* → Confirm it's in the **top x16 slot**, not a chipset x4. Check GPU-Z for negotiated link width — should read x16 Gen 4 or Gen 5 under load.
- *"I can't enable BitLocker."* → TPM disabled in UEFI. Reboot, enable **fTPM** (AMD) or **PTT** (Intel), save.
- *"VMs won't start in Hyper-V/VirtualBox."* → Enable **VT-x/VT-d** or **AMD-V/IOMMU** in UEFI. Default-off on some OEM boards.
- *"RAM is running slower than the box says."* → XMP/EXPO is disabled.
- *Never promise a board upgrade is "drop-in."* Socket, RAM gen, PCIe gen, M.2 keying, power connector count — any one mismatch kills the build. Verify the QVL on the manufacturer's site before quoting parts.

## Related concepts

[[CPU Architecture]] · [[RAM Types and Configurations]] · [[PCIe Expansion Cards]] · [[Storage Devices and Interfaces]] · [[BIOS and UEFI]] · [[TPM and Secure Boot]] · [[Power Supplies]] · [[Cooling Systems]] · [[Motherboard Form Factors]] · [[Virtualization Support]]

*Source: VIRGIL knowledge base — 2026-05-10*