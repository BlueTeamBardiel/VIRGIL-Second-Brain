# Operating Systems Overview

## What it is

You boot the machine. Fans spin, the UEFI splash flashes, then something takes over and turns a box of silicon into a thing you can talk to. That something is the operating system — the personality layered on top of the hardware. Same motherboard, same CPU, same RAM: install Windows 11 and you get one experience, install Ubuntu and you get another, install ChromeOS Flex and you get a third. The hardware doesn't change. The OS does.

In plain English: the operating system is the software that manages every other piece of software, schedules CPU time, hands out memory, talks to drivers, enforces permissions, and gives you a way to interact with the machine. It's the mind running on top of the brain.

Technical definition: an OS is a software layer that abstracts hardware resources (CPU, memory, storage, I/O) and provides services — process scheduling, memory management, filesystem access, networking, security — to applications via system calls. Workstation OSs target desktops and laptops; mobile OSs target phones and tablets; server OSs target headless infrastructure. The filesystem is the OS's warehouse-management system: how it organizes bits on the storage drive so it can find them again.

## Why it matters

Every A+ tech walks into a job knowing one OS well — usually Windows — and gets handed three more on day one. The CFO has a MacBook. The dev team runs Ubuntu in WSL. The break-room kiosk is a Chromebook. The warehouse scanners run Android. You will support all of them.

The exam (220-1202 Objective 1.1) tests whether you can name the OS, name its filesystem, know its lifecycle status, and know what crosses between systems and what doesn't. That last part — compatibility — is where real tickets live. The user who plugged a Mac-formatted external drive into a Windows machine and panicked when "nothing showed up" is a Monday-morning ticket in every shop.

Lifecycle matters because end-of-life means no more security patches. An EOL OS on a production network is a breach waiting to happen, and you'll be the one explaining to a director why their favorite ten-year-old Windows 7 machine has to go.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Five OS families matter for A+: Windows (NT kernel, NTFS native, ReFS for storage spaces), macOS (Darwin/XNU kernel, APFS native), Linux (monolithic kernel, ext4 default on most distros, XFS on Red Hat–family servers), ChromeOS (Linux kernel underneath, ext4, but the user-facing system is a hardened browser), and the mobile pair iOS/iPadOS (Darwin-derived, APFS) and Android (Linux kernel, ext4 or F2FS). Cross-platform filesystems exist because vendors had to agree on something: FAT32 (max 4GB file size, max 2TB volume, works on literally everything) and exFAT (no practical size limits, works on Windows/macOS/most Linux, designed for flash media). NTFS is read-only on macOS without third-party drivers. APFS is invisible to Windows without third-party drivers. ext4 is invisible to both.

**Beat 2 — Feynman example via gaming/personal build.**

**The Steam library drive:** You build a gaming PC, install Windows 11, format the NVMe as NTFS. Games install fine, permissions work, BitLocker is available. *NTFS is the default for a reason — it's what Windows expects.*

**The external SSD for moving big files:** You buy a 2TB portable SSD to shuttle game captures between your gaming rig and your buddy's MacBook. Format it FAT32 and the 8GB capture file refuses to copy — single-file limit is 4GB. Reformat it exFAT and both machines read and write it. *exFAT is the universal donor for flash media. FAT32 is the universal donor for everything else, with a 4GB ceiling that bites you exactly when you don't want it to.*

**The Linux homelab box:** You repurpose an old Ryzen 5 as a Proxmox host. The drives come up as ext4 by default. You plug the NTFS external in to grab some ISOs and Linux reads it through `ntfs-3g` — fine, but slower than native. You plug the APFS Time Machine drive in and Linux shrugs. *Filesystems are the OS's native language. Foreign filesystems require translation, and translation is always slower and sometimes lossy.*

**The kicker:** Reformat the wrong drive at 1am and the filesystem doesn't care that it had your wedding photos on it. *The OS gives you the power to destroy data faster than any other tool you'll ever touch.*

**Beat 3 — Bridge from gaming to enterprise.** Same question — "what filesystem do I use?" — different right answers across builds:

- **Gaming PC:** NTFS internal, exFAT external. Done.
- **Developer rig:** NTFS for Windows partition, ext4 inside WSL2, exFAT for the USB drives that get passed around the office.
- **macOS workstation (the designer's MacBook Pro):** APFS internal (it's automatic, you don't choose), exFAT for anything leaving the machine.
- **Linux server (the Red Hat box in the rack):** XFS on `/` because Red Hat ships it that way and it handles large files and parallel I/O better than ext4 at scale. ext4 on smaller volumes. ReFS or ZFS for the big storage array if the org leans Windows or BSD.
- **Windows Server with Storage Spaces:** ReFS, because it does block-level integrity checking and auto-heals from a mirrored copy when bit-rot is detected. You don't use ReFS on a boot drive — you can't boot from it. NTFS for boot, ReFS for data.

**Beat 4 — The point.** Same fundamental question, different workloads, different right answers. The home user picks a filesystem once and forgets it. The enterprise tech picks filesystems daily — boot vs data, internal vs portable, single-OS vs cross-platform, integrity-critical vs performance-critical. Get this question into your bones: *what's this drive for, who needs to read it, and how big are the files?* You'll ask it for the rest of your career.

## Key facts

### Workstation operating systems

| OS | Kernel | Default filesystem | Best at |
|---|---|---|---|
| **Windows 11 / Windows 10** | NT | NTFS | Business desktops, gaming, broad app support |
| **macOS (Sequoia / Sonoma)** | Darwin/XNU | APFS | Creative work, dev on Apple silicon, Apple ecosystem |
| **Linux (Ubuntu, Fedora, Debian, etc.)** | Linux (monolithic) | ext4 | Servers, dev, customization, low overhead |
| **Linux (Red Hat / RHEL / Rocky)** | Linux | XFS | Enterprise servers, large files, parallel I/O |
| **ChromeOS** | Linux (hardened) | ext4 | Education, kiosks, low-maintenance fleets |

### Mobile operating systems

| OS | Vendor | Filesystem | Notes |
|---|---|---|---|
| **iOS** | Apple | APFS | iPhones. Closed ecosystem, App Store only without sideloading. |
| **iPadOS** | Apple | APFS | iPad-specific fork of iOS. Multitasking, Stage Manager, external display support. |
| **Android** | Google + OEMs | ext4 or F2FS | Phones, tablets, scanners. Open source base (AOSP), OEM skins on top. |

### Filesystem quick-reference

| Filesystem | OS native | Cross-platform read/write | Max file size | Notes |
|---|---|---|---|---|
| **NTFS** | Windows | Read-only on macOS, ntfs-3g on Linux | 16 EB | Journaling, permissions, encryption, compression |
| **ReFS** | Windows Server / Pro for Workstations | Windows only | 35 PB | Integrity streams, auto-heal, **cannot boot from it** |
| **FAT32** | Universal | All major OSs | **4 GB** | Required for UEFI EFI System Partition. Tiny by modern standards. |
| **exFAT** | Windows/macOS native, Linux with package | All major OSs | 16 EB | Designed for flash media. No journaling. |
| **APFS** | macOS, iOS, iPadOS | macOS/iOS only | 8 EB | Snapshots, clones, encryption built in. Replaced HFS+ in 2017. |
| **ext4** | Linux default | Linux native, third-party drivers elsewhere | 16 TB (per file) | Stable, journaling, the boring reliable default. |
| **XFS** | Linux (Red Hat family default) | Linux only | 8 EB | High performance on large files and parallel workloads. Hard to shrink. |

### Vendor lifecycle limitations

Every OS has a support window. After end-of-life (EOL), the vendor stops shipping security patches. Running EOL OSs on production networks fails most compliance frameworks (HIPAA, PCI-DSS, SOC 2) on its face.

| OS | Lifecycle reality |
|---|---|
| **Windows 10** | EOL October 14, 2025. ESU (Extended Security Updates) available, paid, time-limited. Most orgs migrated to Windows 11. |
| **Windows 11** | Current. ~10-year support window per version, annual feature updates. |
| **macOS** | Apple supports the current version + previous two. Roughly 3 years of security updates per release. |
| **Linux (LTS distros)** | Ubuntu LTS = 5 years standard + 5 years ESM. RHEL = 10 years. Rolling distros (Arch) = supported as long as you update. |
| **ChromeOS** | Auto Update Expiration (AUE) date set per hardware model — typically 8–10 years from release. After AUE, no more updates. |
| **iOS / iPadOS** | Apple supports devices ~5–7 years. Old iPhones get critical security patches longer than feature updates. |
| **Android** | Wildly inconsistent. Google Pixel = 7 years of updates (Pixel 8+). Samsung flagships = 7 years. Budget OEM phones = often 2 years or less. |

**Update limitations** are the real-world friction. A Windows 11 machine can't install if the CPU isn't on Microsoft's supported list or lacks TPM 2.0. An old MacBook can't get the new macOS because Apple dropped its hardware ID. A budget Android phone stops getting updates two years in even though the hardware still works fine. Lifecycle isn't just "is it supported?" — it's "can this specific machine even receive the patch?"

### CompTIA exam traps

> **CompTIA exam trap:** FAT32 file size limit is **4 GB**, volume limit is **2 TB**. If the question mentions copying a single file larger than 4 GB and it fails, the answer is "reformat as exFAT or NTFS." Memorize the number.

> **CompTIA exam trap:** ReFS **cannot be used as a boot volume**. Windows boots from NTFS. ReFS is for data volumes — Storage Spaces, file servers, integrity-critical bulk storage.

> **CompTIA exam trap:** APFS is the native filesystem for **macOS, iOS, and iPadOS** — all three. It replaced HFS+ in 2017. Don't pick HFS+ on a current-exam question unless it's specifically asking about legacy.

> **CompTIA exam trap:** XFS is **Linux-only**. It's the Red Hat family default. Trick questions will offer XFS as a "cross-platform" option — it isn't.

> **CompTIA exam trap:** iPadOS is its own OS, **not just iOS on a bigger screen**. Apple forked it in 2019. Exam may test the distinction.

## Helpdesk reality

- **"My external hard drive doesn't work on my Mac, it worked fine on my PC."** It's NTFS. macOS can read it but can't write. Reformat as exFAT if it's a portable drive, or install a third-party NTFS driver if reformatting isn't an option.
- **"Why can't I copy this video file to my USB stick? It just stops."** The stick is FAT32 and the file is over 4 GB. Reformat as exFAT. Back up the stick first — formatting wipes it.
- **"My old laptop won't update to Windows 11."** Check the CPU compatibility list and TPM 2.0 status in UEFI. If the hardware isn't supported, the honest answer is "this machine is end-of-life for Microsoft's purposes." Escalate to procurement.
- **"My iPad is slow and won't update."** Check the model. If it's pre-2018 hardware, iPadOS may have dropped support. No software fix — hardware is past Apple's support window.
- **"Can we keep running this Windows 10 machine? It works fine."** Technically yes, with ESU. Practically — if it touches sensitive data or a regulated network, no. Document the risk, escalate the decision. Never promise "it's fine" on an EOL OS without a sign-off in writing.

## Related concepts

[[Windows Editions and Features]] · [[macOS Features and Tools]] · [[Linux Commands and Tools]] · [[Mobile Device Management]] · [[Filesystem Comparison NTFS exFAT APFS ext4]] · [[End-of-Life and Patch Management]] · [[Cross-platform File Sharing]]

*Source: VIRGIL knowledge base — 2026-05-10*