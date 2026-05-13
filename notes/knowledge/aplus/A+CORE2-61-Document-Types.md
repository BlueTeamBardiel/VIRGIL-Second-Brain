# Document Types

## What it is

You install Windows on a fresh NVMe and it asks you to format the drive. NTFS or ReFS? You plug a USB stick into your friend's Mac and it can't write to it — FAT32 only reads. You try to copy a 6 GB game install file to that same stick and it refuses. Different filesystems, different rules, different limits. The filesystem is how the OS organizes bits on a disk — the warehouse's filing system. The OS is the personality on top of it.

This objective bundles four things CompTIA wants in your head at once: which OSes exist (workstation and mobile), which filesystems each one prefers, when each OS dies (end-of-life and update limits), and what breaks when you move files between them. The exam will hit you with "which filesystem supports files over 4 GB on a USB drive readable by both Windows and macOS?" and expects you to answer exFAT without thinking.

Technical definition: a **filesystem** is the data structure that maps filenames and metadata to physical blocks on a storage device. The **OS** is the software layer that loads at boot and manages hardware, processes, and user interaction. **Lifecycle limitations** are vendor-defined dates after which an OS no longer receives security updates — the immune system stops getting patched while the threats keep evolving.

## Why it matters

Every helpdesk ticket about "I can't open this file" or "my external drive won't work on the new laptop" traces back to one of these: wrong filesystem, wrong OS version, or OS past end-of-life. Enterprises run mixed fleets — Windows desktops, macOS for design, Linux servers in the rack, iPads for executives, Androids on the warehouse floor. You will move data between all of them.

EOL is the one that gets companies breached. Windows 10 hit end-of-life October 14, 2025. Every machine still running it in 2026 is a compliance violation and a ransomware on-ramp. You will be the person telling a department head their five-year-old laptop has to be replaced because Microsoft stopped issuing patches.

Exam relevance: Objective **220-1202 1.1**. Expect questions on filesystem compatibility across OSes, EOL implications, and which filesystem belongs to which platform.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Workstation OSes: **Windows** (NTFS native, ReFS for Storage Spaces and Server), **macOS** (APFS since 2017, replacing HFS+), **Linux** (ext4 default on most distros, XFS on Red Hat and enterprise workloads), **Chrome OS** (ext4 underneath, users never touch it). Mobile: **iOS and iPadOS** (APFS), **Android** (ext4 historically, F2FS on newer devices — A+ tests ext4). Cross-platform removable media: **FAT32** (universal read/write, 4 GB max file size, 2 TB max volume), **exFAT** (universal, no practical size limits, the modern answer for USB sticks over 32 GB).

**Beat 2 — Feynman example via your build.** You build a gaming rig and a homelab in the same year. Every storage decision is a filesystem decision.

**The boot drive:** Windows 11 on a 2 TB NVMe. **NTFS** — journaling, permissions, file compression, BitLocker. *NTFS is the filesystem Windows actually trusts itself on.*

**The Steam library drive:** Second NVMe, also NTFS. ReFS would drop features NTFS has (no compression, no EFS) and games don't care. *ReFS is for data integrity at scale, not your Steam library.*

**The homelab NAS:** TrueNAS box, ZFS pool for the bulk array. For a single Linux VM disk, **ext4** (default, stable, journaling) or **XFS** for RHEL or huge files like video editing scratch. *ext4 is the safe default; XFS scales harder.*

**The "share with everyone" USB stick:** 128 GB drive that has to work on your Windows rig, your roommate's MacBook, and the Steam Deck. **exFAT**. FAT32 would choke on any single file over 4 GB. *exFAT is the only filesystem every consumer OS reads and writes without drama.*

**The phone:** iPhone runs APFS, Android runs ext4. You don't choose. The vendor chose.

**Beat 3 — Bridge from gaming to enterprise.** Same question — "what filesystem and what OS?" — different answers up the stack:

- **Gaming PC:** Windows 11 + NTFS. Done.
- **Developer workstation:** macOS + APFS, or Linux + ext4. Dev tooling expects POSIX permissions and case-sensitive filesystems.
- **File server:** Windows Server + ReFS on data volumes (corruption healing matters when 200 users hit it), NTFS on the boot drive.
- **Database server:** Linux + XFS. Handles massive files and parallel I/O better than ext4 at scale.
- **Engineering laptops in a Windows shop:** Windows 11 + NTFS, but the shared external drive for vendor CAD exchange is exFAT.

**Beat 4 — The point.** Same fundamental question — "what filesystem for what workload, on what OS, talking to whom?" — different right answers every time. The home build trains your instincts. The enterprise tests them at scale where wrong answers cost money. Get this question into your bones — you'll ask it for the rest of your career.

## Key facts

### Workstation operating systems

| OS | Default filesystem | Notes |
|---|---|---|
| Windows 10 / 11 | NTFS | ReFS available for Storage Spaces and Server roles |
| macOS (10.13+) | APFS | Replaced HFS+ in 2017; optimized for SSDs |
| Linux (Ubuntu, Debian, Fedora) | ext4 | Universal default since 2008 |
| Linux (RHEL, Rocky, CentOS Stream) | XFS | Default since RHEL 7, scales to huge files |
| Chrome OS | ext4 | Users see Google Drive-centric UI |

### Filesystem cheat sheet

| Filesystem | Owner | Max file size | Max volume | Cross-platform? |
|---|---|---|---|---|
| **NTFS** | Microsoft | 16 EB | 8 PB | Windows native; macOS read-only; Linux via ntfs-3g |
| **ReFS** | Microsoft | 35 PB | 35 PB | Windows Server / Pro for Workstations only |
| **FAT32** | Microsoft (legacy) | **4 GB** | 2 TB | Universal |
| **exFAT** | Microsoft | 16 EB | 128 PB | Universal — Windows, macOS, Linux, Android |
| **APFS** | Apple | 8 EB | 8 EB | macOS / iOS / iPadOS only |
| **ext4** | Linux community | 16 TB | 1 EB | Linux native |
| **XFS** | SGI / Red Hat | 8 EB | 8 EB | Linux only; not bootable on most distros |

### Mobile operating systems

- **iOS** — iPhone. APFS. Closed ecosystem, Apple controls hardware and software.
- **iPadOS** — fork of iOS since 2019, desktop-class multitasking and external display support. APFS.
- **Android** — Google's open-source OS, vendor-customized (Samsung One UI, Pixel stock). A+ tests ext4.

### Vendor lifecycle — when OSes die

| OS | End-of-life status (2026) |
|---|---|
| Windows 10 | **EOL October 14, 2025.** ESU available for paid enterprise extension through 2028. |
| Windows 11 | Supported. 24H2 and 25H2 current. ~24 months of updates per version. |
| Windows Server 2019 | Mainstream ended; extended through January 2029. |
| macOS | Current + two previous versions (~3 years of patches). |
| Ubuntu LTS | 5 years standard, 10 years with Ubuntu Pro. |
| RHEL | 10 years standard, extendable. |
| Chrome OS | Auto Update Expiration (AUE) per device — typically 8–10 years from release. |
| iOS / iPadOS | ~5–6 years of major version updates per device. |
| Android | Pixel 8+ and Samsung flagships: 7 years. Budget Android: often 2–3 years. |

### CompTIA exam traps

> **CompTIA exam trap:** **FAT32 vs exFAT for large files.** FAT32 cannot store a single file larger than 4 GB. Period. exFAT has no practical limit. If the question mentions a 4K video, game installer, VM disk image, or anything over 4 GB on a cross-platform USB drive — the answer is **exFAT**.

> **CompTIA exam trap:** **NTFS on a Mac.** macOS reads NTFS natively but **cannot write** to it without third-party drivers. If a user says "my external hard drive is read-only on my Mac" — it's NTFS. Reformat to exFAT or install a driver.

> **CompTIA exam trap:** **ReFS is not a replacement for NTFS on workstations.** ReFS lacks compression, EFS encryption, and isn't bootable. It exists for data integrity at scale — Storage Spaces, Server, Pro for Workstations. Boot volume is always NTFS.

> **CompTIA exam trap:** **EOL means no security updates — not "stops working."** Windows 10 machines still boot after October 2025. They just don't get patched. The threat is unpatched vulnerabilities being exploited.

> **CompTIA exam trap:** **XFS is Linux-only and not cross-platform.** If a question asks about moving files between OSes, XFS is never the right answer.

### Update limitations

- **Windows 11 hardware floor:** TPM 2.0 plus a supported CPU (8th-gen Intel / Ryzen 2000+ minimum). Older Windows 10 hardware can't upgrade without unsupported workarounds.
- **macOS hardware cutoffs:** Each major release drops older Macs. A 2017 MacBook Pro might be stuck two macOS versions behind current.
- **Chrome OS AUE:** After the date, device works but receives no updates. Enterprise fleet refresh planning starts here.
- **iOS / iPadOS:** ~5 years of major version upgrades, then security-only patches, then nothing.
- **Android:** OEM controls update delivery. Budget phones often ship one version behind and get one update, ever.

### Compatibility concerns

- **Windows → Mac:** NTFS external is read-only on macOS. Reformat exFAT or buy a driver.
- **Mac → Windows:** APFS is invisible on Windows. Use exFAT for shared drives.
- **Linux → Windows:** ext4 and XFS are invisible to Windows. Use exFAT or SMB.
- **Cross-platform USB:** exFAT for drives over 32 GB. FAT32 only if every file is under 4 GB and you need old-device compatibility (car stereos, older cameras).
- **Android → Windows:** Phone presents as MTP, not raw filesystem. Protocol abstracts it.
- **iPhone → Windows:** Apple Devices app. No direct filesystem access. APFS stays hidden.

## Helpdesk reality

- **"My USB drive doesn't work on the Mac."** It's NTFS. Reformat to exFAT, or install Paragon NTFS for Mac. Warn them reformatting wipes the drive.
- **"I can't copy this file to my flash drive — it says not enough space, but there's 50 GB free."** Drive is FAT32, file is over 4 GB. Reformat to exFAT.
- **"My laptop says Windows 10 isn't supported anymore. Is it broken?"** No, it still works. It just stops getting security updates. Get them on the replacement plan. This conversation will happen weekly in 2026.
- **"My iPhone won't show up as a drive on my PC."** It doesn't work that way. iOS doesn't expose its filesystem. Use iCloud, AirDrop, or the Apple Devices app.
- **"Can I install Windows on this old MacBook?"** Maybe via Boot Camp on Intel Macs. Apple Silicon Macs — no, not natively. Set expectations.

## Related concepts

[[Windows Editions]] · [[macOS]] · [[Linux Distributions]] · [[Mobile OS Features]] · [[Disk Management]] · [[File Permissions]] · [[Storage Devices]] · [[Backup Strategies]]

*Source: VIRGIL knowledge base — 2026-05-11*