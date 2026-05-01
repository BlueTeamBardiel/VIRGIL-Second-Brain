---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 03
source: rewritten
---

# Installing Operating Systems
**The bootstrap paradox: you need an OS to install an OS, so here's how we break that chicken-and-egg cycle.**

---

## Overview

Getting an [[operating system]] onto a bare machine creates a logical catch-22—you need software to load software. A+ techs solve this by leveraging [[bootable media]] and network protocols to jump-start the installation process. Understanding installation methods is critical because you'll encounter scenarios where USB won't work, network deployment saves hours, and knowing the right boot option determines success or failure in real-world deployments.

---

## Key Concepts

### Bootable Installation Media

**Analogy**: Think of a bootable USB drive like a seed packet. You can't grow a tree with just dirt—you need the seed first. The seed contains everything needed to sprout the tree, then the tree grows roots into the soil. The bootable media contains the minimal OS kernel needed to launch the full installer.

**Definition**: [[Bootable media]] is removable storage (USB drive, DVD, external SSD) prepared with a minimal operating system and installation files that can launch without an existing OS present.

**Creating Bootable USB**:
```
Common tools: Rufus, Balena Etcher, Windows Media Creation Tool
Process: Select ISO file → Select USB drive → Write/Flash → Eject safely
```

| Media Type | Speed | Reliability | Use Case |
|---|---|---|---|
| [[USB 3.0]] Flash Drive | Fast | Very High | Modern systems, field techs |
| [[DVD]]/CD | Slow | Medium | Legacy systems, offline environments |
| External [[SSD]] | Very Fast | Very High | Large deployments, imaging |

---

### PXE Boot (Preboot Execution Environment)

**Analogy**: Imagine calling a pizza place to order—you don't need to own the kitchen (storage), you just need a phone line (network) and they deliver everything you need. PXE works the same way: your computer uses the network cable instead of a USB port to grab the installer from a central server.

**Definition**: [[PXE]] is a network-based boot protocol allowing computers to load and execute an [[operating system]] installer directly from a server across the local network, bypassing physical media entirely.

**How It Works**:
1. Computer [[BIOS]]/[[UEFI]] configured to support PXE boot
2. System broadcasts [[DHCP]] request at startup
3. [[PXE server]] responds with installer location
4. OS installation files stream over network to client
5. Installation proceeds as if media were locally attached

**Requirements**:
- [[BIOS]]/[[UEFI]] with PXE capability enabled
- [[Network adapter]] with PXE ROM
- [[DHCP]] server configured for PXE clients
- PXE boot server on local network
- Adequate network bandwidth

---

### Boot Order and BIOS Configuration

**Analogy**: Your computer is like a restaurant manager checking different supply sources in priority order—first check the USB dock, then the network, then the internal storage. Whichever has what you need first gets used.

**Definition**: [[Boot order]] (or [[boot sequence]]) is the hierarchical list in [[BIOS]]/[[UEFI]] that determines which storage devices the system checks first for bootable code.

**Accessing Boot Menu**:
```
Common key sequences during startup:
- F12, F2, DEL, ESC (varies by manufacturer)
- Look for "Press X to enter Boot Menu" on splash screen
- Modern [[UEFI]] systems: Settings → Advanced Startup → UEFI Firmware
```

**Typical Boot Order** (customizable):
1. [[USB]] devices
2. Network ([[PXE]])
3. Internal [[HDD]]/[[SSD]]
4. [[CD]]/[[DVD]] drive
5. Onboard network adapter

---

### Storage Device Preparation

**Analogy**: Before you can plant a garden, you need to till the soil and remove rocks. Similarly, the target drive needs to be wiped and partitioned before OS files can be installed.

**Definition**: [[Disk partitioning]] and [[formatting]] prepare a storage device by erasing existing data, creating partition tables, and establishing file systems ready to receive OS files.

**Disk Preparation Methods**:

| Method | When to Use | Destructive? |
|---|---|---|
| [[Quick Format]] | Non-critical data, speed needed | Yes (data recoverable) |
| [[Full Format]] | Secure wipe, enterprise standards | Yes (secure) |
| [[DBAN]] (Darik's Boot and Nuke) | DoD-grade data destruction | Yes (highly secure) |
| [[Diskpart]] utility | Windows enterprise deployment | Yes (CLI-based) |

**Windows Diskpart Example**:
```
diskpart
list disk
select disk X
clean
create partition primary
format fs=NTFS quick
assign letter=C
```

---

### Unattended Installation

**Analogy**: Instead of manually cooking each ingredient in a recipe one-by-one, you give the kitchen all ingredients in the right order and let automation handle the timing. Unattended installation feeds the OS installer all its answers automatically.

**Definition**: [[Unattended installation]] uses automated answer files ([[answer file]], [[XML]] configuration, or scripts) to supply all required OS setup parameters without user interaction, enabling mass deployment.

**Common Answer File Formats**:
- **Windows**: [[Autounattend.xml]] (placed on installation media root)
- **Linux**: [[Kickstart]] files (Red Hat/CentOS), [[Preseed]] (Debian/Ubuntu)
- **macOS**: [[Configuration profiles]], deployment scripts

---

## Exam Tips

### Question Type 1: Installation Media Selection
- *"A tech needs to deploy Windows 11 to 50 computers in a warehouse without visiting each one. Which method is most efficient?"* → **PXE boot** (network-based, doesn't require physical USB swapping)
- *"An offline facility with no network has 20 systems needing OS installation. What's the best approach?"* → **Bootable USB drives** (removable media doesn't require network infrastructure)
- **Trick**: Don't assume faster = better. Some scenarios eliminate options (no network = no PXE; no USB ports = must use network or optical media)

### Question Type 2: BIOS/UEFI Configuration
- *"A system won't boot from the USB drive with installation media. The drive is bootable. What's most likely the issue?"* → **Boot order in BIOS needs adjustment** (USB not prioritized) or **USB legacy support disabled** in UEFI
- **Trick**: UEFI systems may need [[Secure Boot]] disabled or specific [[UEFI boot mode]] settings; don't assume traditional BIOS procedures apply

### Question Type 3: Pre-Installation Requirements
- *"Before installing an OS on a used laptop, what should be verified?"* → [[BIOS]]/[[UEFI]] compatibility, sufficient [[hard drive space]], compatible [[network adapter]], [[processor]] and [[RAM]] meet minimum specs
- **Trick**: Check for conflicting [[drivers]], required firmware updates, or BIOS revisions that affect OS installation

---

## Common Mistakes

### Mistake 1: Forgetting to Adjust Boot Order
**Wrong**: Inserting bootable USB and expecting automatic boot to installation media
**Right**: Enter BIOS/UEFI setup and manually set USB as first boot device before inserting media
**Impact on Exam**: This appears constantly—questions test whether you know this is a separate step from creating bootable media

### Mistake 2: Confusing PXE Requirements
**Wrong**: Thinking PXE works with just a BIOS that "supports networking"
**Right**: PXE requires [[DHCP]], an active [[PXE server]], network connectivity, AND BIOS/UEFI PXE ROM capability—all must be present
**Impact on Exam**: Scenario questions often include a "missing piece" (no DHCP server, PXE disabled in BIOS)—you must identify which prerequisite fails

### Mistake 3: Assuming All Media Types Are Interchangeable
**Wrong**: Treating USB 2.0, USB 3.0, and optical media as equally fast for deployment
**Right**: [[USB 3.0]] deployment is 10x faster; optical media is slow but works on legacy systems; network booting is fastest for multiple systems but slowest for single machines
**Impact on Exam**: Efficiency questions hinge on matching media to scenario (50 systems = network deployment; legacy system = optical media)

### Mistake 4: Skipping Disk Preparation Steps
**Wrong**: Installing new OS over existing partition without formatting
**Right**: Wipe/format target drive first to remove old partition tables and boot sectors; this prevents boot conflicts
**Impact on Exam**: Questions about "system won't boot after fresh install" often stem from incomplete disk wiping

### Mistake 5: Misunderstanding UEFI vs. Legacy Boot Modes
**Wrong**: Using legacy BIOS installer image on UEFI-only system
**Right**: Match installer mode (UEFI or legacy) to system firmware; modern systems require UEFI installers and [[GPT]] partitions
**Impact on Exam**: Boot failure scenarios often test whether you know UEFI/legacy mode compatibility

---

## Related Topics
- [[BIOS]] and [[UEFI]]
- [[Bootable Media Creation]]
- [[Network Boot Protocols]]
- [[Disk Partitioning Schemes]] ([[MBR]] vs. [[GPT]])
- [[File Systems]] ([[NTFS]], [[FAT32]], ext4)
- [[System Requirements and Compatibility]]
- [[Post-Installation Configuration]]
- [[Operating System Deployment Tools]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*