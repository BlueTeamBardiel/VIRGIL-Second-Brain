# Storage Devices

## What it is

Storage is the warehouse. RAM is the workbench — what's in your hands right now, gone the second power dies. Storage is the shelves in the back room: slower to reach, but the data survives a power cut, a reboot, a thunderstorm, a forgotten payment to the electric company.

In plain English: storage is where your operating system, programs, games, and files live when the machine is off. When you boot, the CPU pulls what it needs from the warehouse into the workbench so it can actually work on it.

Technically, storage devices are non-volatile media — magnetic platters, NAND flash cells, or optical pits — connected to the system over an interface (SATA, SAS, NVMe over PCIe, USB) and presented to the OS as block devices. The exam (220-1201 Objective 3.4) wants you fluent in the form factors, the interfaces, the RAID levels, and the tradeoffs.

## Why it matters

Storage is the single biggest performance variable a normal user actually feels. A ten-year-old laptop with a fresh SSD boots faster than a brand-new laptop someone cheaped out on with a 5400 RPM drive. Every helpdesk tech learns this in their first month: "my computer is slow" is, eight times out of ten, a dying or saturated hard drive.

It's also where data dies. CPUs rarely fail. RAM rarely fails. Storage fails constantly — and when it goes, it takes the user's tax returns, the family photos, and the only copy of the quarterly report with it. CompTIA tests storage heavily because storage is where techs spend their time: cloning drives, migrating users to SSDs, configuring RAID, recovering data, explaining to people why "the cloud" was not, in fact, automatically backing them up.

Objective 3.4 specifically wants you comparing — HDD vs SSD, SATA vs NVMe, RAID 1 vs RAID 5, M.2 vs 2.5-inch. The exam loves "which is fastest," "which survives a drive failure," "which form factor fits in this slot."

## In your build, in the enterprise

**Beat 1 — the technical layer.**

Two media types matter: spinning rust (HDD) and flash (SSD). HDDs store bits as magnetic polarity on platters spun at 5400, 7200, 10000, or 15000 RPM, read by an actuator arm. Mechanical, slow, cheap per terabyte, eventually fails because moving parts always do. SSDs store bits in NAND flash cells — no moving parts, dramatically faster random I/O, more expensive per terabyte, finite write endurance measured in TBW (terabytes written).

Form factors you must know cold: **3.5-inch** (desktop HDDs, big capacity), **2.5-inch** (laptop HDDs and SATA SSDs), **M.2** (gumstick form factor for SSDs, plugs flat into the motherboard), **mSATA** (older laptop SSD format, mostly dead but still on the exam).

Interfaces: **SATA** tops out at 6 Gbps (~550 MB/s real-world) — the bottleneck for any modern SSD. **SAS** (Serial Attached SCSI) is the enterprise cousin of SATA, runs at 12 or 22.5 Gbps, supports dual-port redundancy, designed for 24/7 server duty. **NVMe over PCIe** is the speed king — a Gen 4 NVMe drive hits 7,000 MB/s, Gen 5 hits 14,000. M.2 slots can be SATA-keyed or NVMe-keyed; plug a SATA M.2 into an NVMe-only slot and it does nothing. Read the manual.

**Beat 2 — Feynman, your gaming rig at 11pm.**

You're building a gaming PC. Budget says one drive. What do you buy?

**The wrong answer:** a 2TB 7200 RPM HDD because it's $50 and has the most space. Your boot times are 90 seconds. Cyberpunk takes four minutes to load a save. You hate your computer. *The cheapest drive is the most expensive mistake in a build.*

**The right answer:** a 1TB NVMe Gen 4 SSD in the M.2 slot. Boot in 12 seconds. Games load in 8. The system feels alive. *NVMe is the single biggest "feel" upgrade in modern PCs — bigger than CPU, bigger than RAM.*

**The upgrade path:** six months later you add a 4TB SATA SSD as your library drive. Steam installs there, the NVMe holds the OS and the three games you actually play this week. *Tier your storage: fast small drive for active stuff, big cheap drive for the rest.*

**The kicker:** a year in, the SSD's SMART data starts showing reallocated sectors. You shrug — you have backups. You do have backups, right? *Every drive in your house is one bad day from being a paperweight. Plan accordingly.*

**Beat 3 — the bridge to the enterprise.**

Same question, different builds, different right answers.

- **Gaming PC:** one NVMe Gen 4 (1–2TB) for OS and active games, one SATA SSD (2–4TB) for the library. No HDDs. Backup to an external drive once a month.
- **Developer workstation:** two NVMe drives — one for OS, one for code repos and VM disk images. The second drive isolates I/O so a `npm install` doesn't choke your IDE.
- **Cybersecurity analyst rig:** NVMe for OS, dedicated NVMe for VM lab (malware sandboxes hammer storage), large SATA SSD for evidence and pcap captures. Encryption everywhere — BitLocker or LUKS.
- **Enterprise file server:** eight to twenty-four 2.5-inch SAS SSDs or 3.5-inch SAS HDDs in a hardware RAID 6 or RAID 10, hot spares ready, dual-port SAS for path redundancy, NVMe tier for hot data. UPS-backed, replicated to a second site.

The home gamer's "one drive" mindset becomes the enterprise's "tiered, redundant, replicated, monitored." A drive failure on your gaming rig means a Saturday of reinstalling. A drive failure in production means nothing — RAID rebuilds while the business keeps running.

**Beat 4 — the point.**

Same fundamental question — *where does the data live and how fast does it need to come back?* — different workloads, different right answers. A gaming PC optimizes for load times. A database server optimizes for IOPS. A backup target optimizes for capacity per dollar. A SAN optimizes for shared access and uptime. Get this question into your bones — you'll ask it for the rest of your career.

## Key facts

### Drive types and speeds

| Type | Interface | Real-world speed | $/TB (2026) | Best for |
|---|---|---|---|---|
| 5400 RPM HDD | SATA | ~100 MB/s | cheapest | bulk archive, NAS bays |
| 7200 RPM HDD | SATA | ~180 MB/s | very cheap | desktop secondary |
| 10K/15K RPM HDD | SAS | ~250 MB/s | mid | legacy enterprise (dying) |
| SATA SSD | SATA 6 Gbps | ~550 MB/s | mid | mass SSD storage, laptop upgrades |
| NVMe Gen 3 | PCIe 3.0 x4 | ~3,500 MB/s | mid | budget builds, older boards |
| NVMe Gen 4 | PCIe 4.0 x4 | ~7,000 MB/s | sweet spot | mainstream gaming/workstation |
| NVMe Gen 5 | PCIe 5.0 x4 | ~14,000 MB/s | premium | high-end workstation, enterprise |
| Enterprise SAS SSD | SAS 22.5 Gbps | ~2,200 MB/s | expensive | 24/7 servers, dual-port redundancy |

### Form factors at a glance

- **3.5-inch** — desktop HDDs, NAS drives. SATA power + SATA data. Up to 24TB+ in 2026.
- **2.5-inch** — laptop HDDs, SATA SSDs, enterprise SAS drives. Same connector family.
- **M.2** — gumstick. Sizes named by dimensions: **2280** (22mm × 80mm) is standard, also 2230, 2242, 2260, 22110. Can be SATA or NVMe — check the keying (B-key vs M-key vs B+M).
- **mSATA** — older mini-PCIe-shaped SSD format, predates M.2, still appears on the exam and in legacy laptops.
- **U.2 / U.3** — 2.5-inch NVMe for enterprise, hot-swappable, common in servers.
- **EDSFF (E1.S, E3.S)** — newer enterprise ruler-shaped NVMe, increasingly common in 2026 datacenters.

### RAID levels

| RAID | Min drives | Survives | Capacity | Use case |
|---|---|---|---|---|
| **0** | 2 | nothing — one drive dies, all data dies | 100% | scratch space, video editing cache |
| **1** | 2 | 1 drive failure | 50% | OS mirror, small critical volumes |
| **5** | 3 | 1 drive failure | (n−1)/n | general file servers (falling out of favor) |
| **6** | 4 | 2 drive failures | (n−2)/n | modern bulk storage, large arrays |
| **10** | 4 | 1 per mirror pair | 50% | databases, anything write-heavy |

RAID 5 is dying because rebuild times on multi-terabyte drives are so long that a second drive often fails mid-rebuild. RAID 6 and RAID 10 are the modern defaults.

> **CompTIA exam trap:** RAID is not a backup. RAID protects against drive *hardware* failure. Ransomware, accidental deletion, fire, and `rm -rf` all replicate cleanly across every drive in the array. The exam tests this distinction directly — "your RAID 5 array protects you from..." The answer is *one drive failing*, not *data loss in general*.

### Removable and optical

- **USB flash drives** — NAND flash in a USB stick. USB 3.0/3.1/3.2 speeds vary wildly; cheap drives are slower than they advertise.
- **Memory cards** — SD, microSD, CompactFlash, CFexpress. Speed classes (Class 10, U3, V30, V60, V90) matter for video recording.
- **External drives** — 2.5-inch or 3.5-inch in an enclosure, USB or Thunderbolt. The "set it and forget it" backup target.
- **Optical drives** — CD (700MB), DVD (4.7GB single / 8.5GB dual layer), Blu-ray (25GB / 50GB dual / 100GB triple). Connect via SATA. Mostly dead in consumer builds, still appear in legacy enterprise for compliance archival and in ruggedized field kits.

### CompTIA exam traps

> **Trap — M.2 form factor ≠ NVMe interface.** M.2 is the physical slot. The drive in it might speak SATA or NVMe. The exam will give you a scenario where someone bought an "M.2 SSD" expecting NVMe speeds and got SATA speeds. Read the keying.

> **Trap — SAS vs SATA connectors.** SAS drives can plug into a SAS backplane that also accepts SATA. SATA drives go in SAS bays. SAS drives do *not* go in SATA-only ports. One-way compatibility.

> **Trap — spindle speed is HDD only.** SSDs have no spindles. If a question mentions "5400 RPM" or "7200 RPM," it's a hard drive question.

## Helpdesk reality

- **"My computer is so slow."** Eight out of ten times: dying HDD or a nearly-full SSD. Run SMART. Check free space. The fix is usually a drive clone to a fresh SSD, not a reformat.
- **"I plugged in my external drive and it's not showing up."** Disk Management → check if Windows sees it but didn't assign a letter. Half the tickets resolve in 30 seconds.
- **"I deleted a file, can you get it back?"** On an HDD with shadow copies or a backup, maybe. On a TRIM-enabled SSD, the data is likely gone within minutes. Set the expectation honestly — never promise recovery you can't deliver.
- **"Is RAID 1 a backup?"** No. Say it slowly. Then say it again. Then send them the link to the company-approved cloud backup.
- **"The drive is making a clicking sound."** Power it off *now*. Every minute it spins, more data dies. This is escalation territory — data recovery shops, not the helpdesk.

## Related concepts

[[Motherboards]] · [[RAID]] · [[SATA and NVMe Interfaces]] · [[M.2 Form Factor]] · [[Backups and Recovery]] · [[SMART Monitoring]] · [[Storage Troubleshooting]] · [[File Systems]] · [[Optical Media]] · [[USB Standards]]

*Source: VIRGIL knowledge base — 2026-05-10*