# Installing Operating Systems

## What it is

You just finished the build. The CPU is seated, RAM is clicked in, NVMe is screwed down, PSU cables routed. You hit the power button and... a black screen with white text yelling about no bootable device. The body is alive. It has no mind yet.

Installing an operating system is what gives the machine its personality — the layer that decides whether this hardware behaves like a Windows gaming rig, a macOS workstation, an Ubuntu homelab host, or a Chromebook. Same silicon, different soul.

Technically, OS installation is the process of writing a bootloader, kernel, system files, and a filesystem structure onto persistent storage so the machine can boot into a functional environment. The OS choice dictates which filesystem you'll use, which applications will run, how long the vendor will support you, and how the machine will be managed in production.

## Why it matters

Every A+ tech installs operating systems. Not occasionally — constantly. New laptop arrives, employee onboards, malware infection requires a clean reload, hardware refresh cycle hits. The 220-1202 exam tests OS types, filesystem choices, vendor lifecycle limits (EOL dates matter — running Windows 10 past October 2025 means no security patches), and compatibility issues when an external drive needs to move data between a Mac and a Windows machine. Objective 220-1202 1.1 explicitly lists all of this. The reader who can't answer "which filesystem do I format this USB drive with to share between my MacBook and my desktop" is going to get embarrassed on day one of helpdesk.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Workstation OSs land in four families: Windows (10, 11, and the LTSC variants), macOS (Tahoe, Sequoia, Sonoma — Apple ships annually), Linux (Ubuntu, Fedora, Debian, RHEL, Mint — kernel + userland combinations), and ChromeOS (Google's locked-down browser-as-OS for Chromebooks). Mobile splits cleaner: iOS for iPhones, iPadOS for iPads (forked from iOS in 2019, multitasking-focused), Android for everything else (Samsung, Pixel, the Steam Deck's gaming sibling devices). Filesystems pair with OSs but aren't locked: NTFS and ReFS for Windows, APFS for modern Apple, ext4 and XFS for Linux, FAT32 and exFAT for cross-platform sneakernet. Every vendor publishes a lifecycle: Windows 10 hits EOL 2025-10-14, Windows 11 24H2 supported through 2027, macOS gets roughly three years of security updates after release, Ubuntu LTS gets five years (ten with paid Pro). Run past EOL and the patches stop. The CVEs don't.

**Beat 2 — Feynman example via gaming/personal build.**

**The fresh build:** You boot from a Windows 11 USB you made with the Media Creation Tool. Setup asks where to install. You pick the NVMe, click format, Windows lays down GPT partitions and NTFS, copies files, reboots, and you're at OOBE in twenty minutes. *NTFS is the default for one reason: Windows assumes it.*

**The second drive:** You have a 4TB spinner for Steam. Format it NTFS too, give it a drive letter, point Steam at it. Games install, life is good. *NTFS handles files larger than 4GB — your 80GB game installs land fine.*

**The USB stick for your buddy's Mac:** You want to hand him a save file. Format the stick FAT32 and the file is 6GB. FAT32 rejects it — 4GB per file ceiling. Reformat exFAT. Mac mounts it, reads it, writes back to it. *exFAT exists because FAT32 was designed when 4GB was infinite.*

**The Linux dual-boot:** You shrink the Windows partition, boot the Ubuntu installer, it carves out ext4 for root and a swap partition. GRUB installs and now you pick OS at boot. *ext4 is the Linux default the way NTFS is the Windows default — journaled, reliable, boring in the best way.*

**Beat 3 — Bridge from gaming to enterprise.** Same machine, different context. At home you install Windows from a USB stick, click through OOBE, sign into your Microsoft account, install Steam. At a 500-person company, that workflow doesn't scale. The technician images one golden machine, captures it, and pushes it via PXE boot, Microsoft Deployment Toolkit, SCCM, or Intune Autopilot to hundreds of devices simultaneously. The user never sees an installer — they unbox a laptop, sign in with their corporate account, and Autopilot pulls down the company image, joins Entra ID, applies group policy, installs the application suite, and lands them on the desktop. Filesystem choice shifts too: a homelab NAS might run ext4 or ZFS, but enterprise file servers often use ReFS for its resilience features — checksums, automatic repair from a mirrored copy, integrity streams. macOS in the enterprise is managed by Jamf, not by walking up to each iMac with an installer USB.

**Beat 4 — The point/generalization.** Same fundamental question — "how do I get a working OS onto this hardware?" — different scales, different right answers. At home: USB installer, twenty minutes, one machine. At work: deployment pipeline, golden image, zero-touch provisioning, hundreds of machines before lunch. Get this question into your bones. You'll ask it for the rest of your career.

## Key facts

### Workstation OS families

| OS | Default FS | Typical install media | Notes |
|---|---|---|---|
| Windows 11 | NTFS | USB from Media Creation Tool, ISO | Requires TPM 2.0, Secure Boot, 4GB RAM minimum |
| Windows 10 | NTFS | USB / ISO | **EOL 2025-10-14** — out of support |
| macOS | APFS | Recovery partition, Internet Recovery | Apple Silicon or Intel — different installers |
| Ubuntu / Linux | ext4 | USB from Rufus/balenaEtcher | LTS releases supported 5 years free, 10 paid |
| ChromeOS | ext4 (encrypted) | Pre-installed, recovery via Chromebook Recovery Utility | Auto Update Expiration date per device |

### Filesystem cheat sheet

| FS | Max file size | Max volume | Used by | Use case |
|---|---|---|---|---|
| **FAT32** | 4 GB | 2 TB | Legacy, USB sticks, UEFI ESP | Universal compatibility, small files only |
| **exFAT** | 16 EB (practical: huge) | 128 PB | USB drives, SD cards | Cross-platform sneakernet — Win/Mac/Linux all read/write |
| **NTFS** | 16 EB | 8 PB | Windows internal | Journaling, permissions, encryption (EFS), compression |
| **ReFS** | 35 PB | 35 PB | Windows Server, Storage Spaces | Integrity checking, auto-repair, no support as boot drive |
| **APFS** | 8 EB | 8 EB | macOS 10.13+, iOS, iPadOS | Snapshots, clones, native encryption, optimized for SSD |
| **ext4** | 16 TB | 1 EB | Linux | Mature, journaled, the boring default that just works |
| **XFS** | 8 EB | 8 EB | RHEL/CentOS default, large Linux servers | Excellent at huge files and parallel I/O |

### Vendor lifecycle — the dates that matter

- **Windows 10** — EOL 2025-10-14. ESU (Extended Security Updates) available for paying enterprises through 2028.
- **Windows 11 24H2** — mainstream support through 2027.
- **Windows Server 2019** — mainstream ended 2024, extended through 2029.
- **macOS** — Apple supports the current release plus two prior. macOS Tahoe (2025) gets security updates roughly through 2028.
- **Ubuntu LTS** (e.g., 24.04) — 5 years standard, 10 years with Ubuntu Pro.
- **RHEL** — 10 years standard, plus extended phases.
- **ChromeOS** — each Chromebook has an **AUE (Auto Update Expiration)** date, typically 8–10 years from first release. After AUE, no more updates. Period.
- **iOS / iPadOS** — Apple supports devices roughly 5–7 years; newer iPhones have stretched to 7+.
- **Android** — Google Pixels now get 7 years of OS + security updates. Samsung flagships get 7. Cheap Androids often get 2 or fewer. *Vendor matters more than the OS name.*

### Compatibility concerns

- **NTFS on Mac** — macOS reads NTFS but cannot write without third-party drivers (Paragon, Tuxera). External drives moving between Mac and Windows? Use **exFAT**.
- **APFS on Windows** — Windows can't read APFS natively at all. Tools like MacDrive exist but cost money.
- **ext4/XFS on Windows** — not native. WSL2 can mount them; standard Windows can't.
- **FAT32 file size limit** — 4GB per file. This is the most-tested trap on the exam. Any single file larger than 4GB needs exFAT or NTFS.
- **ReFS limitations** — cannot be a boot volume, no compression, no EFS. It's for data volumes and Storage Spaces, not for installing Windows onto.

### Mobile OS filesystems

iOS, iPadOS, and modern macOS all use **APFS** — Apple unified the filesystem across the ecosystem in 2017–2018. Android historically used ext4, with newer versions adding **F2FS** (Flash-Friendly File System) for the userdata partition. You'll never format an iPhone manually — Apple's recovery tooling handles it. Android devices are similar; flashing a ROM via fastboot is the closest a tech gets to "installing" mobile OS, and that's well outside A+ scope.

### CompTIA exam traps

> **CompTIA exam trap:** FAT32 vs exFAT. The 4GB-per-file limit is FAT32's defining weakness. If the question mentions a 5GB video file failing to copy to a USB drive, the answer is "reformat as exFAT (or NTFS)." Don't overthink it.

> **CompTIA exam trap:** NTFS vs ReFS. NTFS is the Windows install/boot filesystem. ReFS cannot boot Windows. If the question asks "which filesystem do you install Windows 11 on," the answer is NTFS, not ReFS — even though ReFS is "newer."

> **CompTIA exam trap:** EOL doesn't mean "stops working." It means "stops getting security patches." Windows 10 machines will boot fine on 2025-10-15. They'll also accumulate unpatched CVEs forever. Exam-correct answer: upgrade or replace.

> **CompTIA exam trap:** Chrome OS has **AUE** — a per-device expiration date, not a single OS-wide cutoff. Two Chromebooks running the same ChromeOS version can hit AUE years apart depending on hardware launch date.

## Helpdesk reality

- *"My USB drive won't hold this video file, but there's plenty of space left."* — It's FAT32 and the file is over 4GB. Back up the stick's contents, reformat exFAT, copy back, retry.
- *"My Mac won't let me save changes to this external drive."* — It's NTFS. Read-only on macOS without third-party drivers. Reformat exFAT if it'll be shared, or buy Paragon NTFS.
- *"My Chromebook stopped getting updates."* — Check the AUE date in `chrome://management` or Google's published list. If it's past AUE, the device is hardware-EOL. No update path. Quote a replacement.
- *"Can I just keep running Windows 10? It works fine."* — Technically yes, security-wise no. After 2025-10-14, every new vulnerability is permanent. For business use, document the risk and push the upgrade ticket. For grandma's machine, at least install a current browser and remove admin rights.
- *"Why does my work laptop install itself when I unbox it?"* — Autopilot. Welcome to enterprise IT, where you don't install Windows — Windows installs itself the moment you sign in.

## Related concepts

[[Workstation OS Types]] · [[Filesystems Comparison]] · [[Windows Editions and Lifecycle]] · [[macOS Features]] · [[Linux Distributions and Package Managers]] · [[Mobile Operating Systems]] · [[Imaging and Deployment]] · [[Boot Methods]] · [[Partition Schemes MBR vs GPT]]

*Source: VIRGIL knowledge base — 2026-05-11*