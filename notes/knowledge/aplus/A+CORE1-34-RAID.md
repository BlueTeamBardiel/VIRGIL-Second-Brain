# RAID

## What it is

You bought two drives because the first one died at 2 AM the night before a deadline and you swore never again. RAID is the formalization of that instinct: combine multiple physical drives into one logical volume so that speed, capacity, or survival improves — pick your trade.

In plain English: instead of trusting one drive with all your data, you spread the data across several drives in a specific pattern. The pattern decides what you get. Some patterns make the array faster. Some make it survive a drive death. Some do both. None of them make it a backup.

**RAID** (Redundant Array of Independent Disks) is a storage virtualization layer — implemented in hardware (a dedicated controller card), firmware (motherboard BIOS RAID), or software (the OS, e.g., Windows Storage Spaces, Linux `mdadm`, ZFS) — that combines two or more physical drives into one logical unit. The pattern is called the **RAID level**.

## Why it matters

A+ objective **220-1201 3.4** explicitly names RAID 0, 1, 5, 6, and 10. CompTIA will give you a scenario — "the customer wants speed and redundancy," "the customer wants maximum capacity with one drive of fault tolerance" — and you pick the level. Memorize the patterns. Memorize the minimum drive counts. Memorize the capacity math. This is one of the easiest objectives to nail and one of the easiest to fumble if you wing it.

Career-wise: every server you touch will have an array. Every NAS in every small business runs RAID. The day a drive fails in a production array and the customer asks "are we down?" — your answer depends on knowing which level they configured. *Get the levels into your bones.*

## In your build, in the enterprise

**Beat 1 — the levels, the numbers, the rules.**

| Level | Min drives | Fault tolerance | Usable capacity | Read | Write |
|---|---|---|---|---|---|
| **RAID 0** (stripe) | 2 | None | 100% (N × smallest) | Fast | Fast |
| **RAID 1** (mirror) | 2 | 1 drive | 50% (smallest drive) | Fast | Normal |
| **RAID 5** (stripe + parity) | 3 | 1 drive | (N−1) × smallest | Fast | Slower (parity calc) |
| **RAID 6** (stripe + double parity) | 4 | 2 drives | (N−2) × smallest | Fast | Slowest |
| **RAID 10** (mirror, then stripe) | 4 | 1 per mirror pair | 50% | Fast | Fast |

Parity is the math trick: XOR the data blocks across drives, store the result on a different drive each stripe. Lose one drive, reconstruct its blocks from the survivors. RAID 6 stores two independent parity calculations, so it survives two simultaneous failures. RAID 10 doesn't use parity — it mirrors pairs and then stripes across the mirrors, so it's fast and tolerant but expensive (half your raw capacity is gone).

**Beat 2 — Feynman, in your build.**

**RAID 0:** Two NVMes striped, the OS sees one big volume, sequential reads scream because both drives feed the bus in parallel. Stick Steam there, stick scratch files there, stick the video project you can re-export. One drive dies, the array dies, everything on it is gone. *For data you can recreate. Speed at the cost of survival.*

**RAID 1:** Mirror two drives for the stuff that hurts to lose — save files, family photos, the Tarkov highlight reel, the homelab VM you spent a weekend tuning. Every write hits both drives. One drive dies, the mirror keeps serving, you swap in a new drive, it rebuilds. *Half your capacity buys you "a drive death is annoying, not a crisis."*

**RAID 5:** Three or more drives, one drive's worth of capacity goes to parity (spread across all drives, not one dedicated drive). Three 4 TB drives → 8 TB usable, one drive of redundancy. Great ratio. The catch: rebuilds are slow and stressful — the array reads every block on every surviving drive to reconstruct the dead one, and during that rebuild you have zero fault tolerance. Big modern drives make this a real problem.

**RAID 10:** Four drives, two mirrored pairs, striped across the pairs. Fast like RAID 0, survives a drive death like RAID 1, expensive like a mortgage. *What you build when the workload is heavy and downtime is unacceptable.*

**The kicker:** Then you `rm -rf` the wrong folder at 11 PM. Or ransomware encrypts the share. Or the building floods. Every array dutifully replicates the destruction across all its drives. *RAID protects against drive hardware failure. Nothing else.* Backups are a separate problem with a separate solution. You will explain this on the helpdesk approximately once a week for the rest of your career.

**Beat 3 — from your build to the enterprise.**

Same question — "how do I keep my data alive when a drive dies?" — different scale, different answers.

In your gaming rig: two NVMes in RAID 1 on the motherboard's BIOS RAID, or Windows Storage Spaces mirror. Cheap, easy, fine for a single user.

In a small-business NAS (Synology, QNAP): four to eight SATA drives in RAID 5 or RAID 6, software RAID handled by the NAS OS. The NAS sends you an email when a drive fails. You walk over, pull the bad drive, slide a new one into the same bay, walk away. The array rebuilds itself.

In a production server: a dedicated **hardware RAID controller** (PERC on Dell, SmartArray on HPE, MegaRAID on Broadcom) with its own CPU, its own cache, and a **battery-backed write cache (BBWC)** or flash-backed equivalent. The controller handles parity math at hardware speed so the host CPU doesn't break a sweat. Drives are hot-swappable — pull a failed drive out of a running server, slide a new one in, the controller starts rebuilding without a reboot. Configurations include **hot spares** (an unused drive sitting in the chassis, ready to auto-join the array the instant a member fails) and double-parity RAID 6 or RAID 10 for the workloads that can't tolerate the RAID 5 rebuild risk.

**Beat 4 — the point.**

Same fundamental question — *what does this storage need to survive, and how fast does it need to be?* — different workloads, different right answers. A gamer's scratch volume and a hospital's patient-records server are both "storage," but the constraints could not be more different. Get the question into your bones. You'll ask it every time someone says "we need more storage."

## Key facts

### The five levels CompTIA tests

- **RAID 0** — stripe, no redundancy, all capacity usable, 2+ drives. Speed only.
- **RAID 1** — mirror, survives 1 drive failure, 50% capacity, 2 drives (commonly).
- **RAID 5** — stripe with distributed parity, survives 1 drive failure, (N−1) capacity, 3+ drives.
- **RAID 6** — stripe with double distributed parity, survives 2 drive failures, (N−2) capacity, 4+ drives.
- **RAID 10** — stripe of mirrors, survives 1 failure per mirror pair, 50% capacity, 4+ drives.

### Implementation tiers

**Software RAID** — the OS does the work. Examples: Windows Storage Spaces, Linux `mdadm`, ZFS, Btrfs. Free, flexible, portable between machines (the metadata lives on the drives). CPU pays the cost. Fine for home NAS and most small workloads.

**Firmware/BIOS RAID** ("fake RAID") — the motherboard advertises a RAID controller but the actual work is done by a driver in the OS. Boot-time setup, locked to that chipset family. Avoid for anything serious.

**Hardware RAID** — a dedicated controller card with its own processor, cache, and battery/flash-backed cache. Drives connect through it (SAS or SATA backplane). The OS sees one logical drive and never knows there's an array underneath. Required for serious server workloads; charges serious money for the privilege.

### Drive interfaces in an array

- **SATA** — consumer, up to 6 Gb/s, fine for NAS and budget arrays.
- **SAS** (Serial Attached SCSI) — enterprise, up to 22.5 Gb/s, dual-port (multipath), higher MTBF drives, hot-swap standard. SAS controllers accept SATA drives; SATA controllers do not accept SAS drives.
- **NVMe over PCIe** — flash-only, used in modern all-flash arrays and high-end workstations. RAID across NVMe is a different beast (no parity-friendly write pattern at native speeds without dedicated silicon).

### Hot spare

A drive sitting in the chassis, powered and idle, configured as a standby member of the array. The instant a drive fails, the controller starts rebuilding onto the spare without human intervention. Buys you hours when the on-call tech can't get to the data center.

### CompTIA exam traps

> **CompTIA exam trap:** RAID is not a backup. A scenario will describe accidental file deletion or ransomware and ask which RAID level protects against it. The answer is none — the question is testing whether you understand that RAID handles drive hardware failure, not data loss from logical causes.

> **CompTIA exam trap:** RAID 5 minimum is 3 drives, RAID 6 minimum is 4 drives, RAID 10 minimum is 4 drives. CompTIA will give you a scenario with 3 drives and ask if RAID 10 works. It doesn't. Memorize the minimums.

> **CompTIA exam trap:** RAID 10 is "stripe of mirrors" (mirrors first, then stripe across them). RAID 0+1 is "mirror of stripes" (stripes first, then mirror them). CompTIA tests RAID 10. The two are not interchangeable — RAID 10 survives more failure scenarios than 0+1. If the exam says "1+0" or "10," it means stripe-of-mirrors.

> **CompTIA exam trap:** Capacity math. RAID 5 with four 2 TB drives = 6 TB usable (N−1). RAID 6 with four 2 TB drives = 4 TB usable (N−2). RAID 10 with four 2 TB drives = 4 TB usable (50%). They will give you the drive count and size and ask for usable capacity. Practice this.

## Helpdesk reality

- *"The drive light is red and the server is beeping."* — One drive in the array has failed. The array is degraded but running. Identify the failed drive by slot number from the controller's management tool (iDRAC, iLO, Storage Manager), order the replacement, swap it when it arrives. Don't touch any other drive in the chassis.
- *"We lost a drive in RAID 5 last week, ordered a replacement, and now another drive failed during rebuild."* — Classic RAID 5 failure mode. The rebuild stress on large drives can surface latent errors on a sibling. This is why production has moved toward RAID 6 and RAID 10. Escalate to the senior team; this is a data-recovery situation, not a swap.
- *"Can you restore the file I deleted from the share?"* — Not from RAID. From backup. Confirm the backup exists and is recent before promising anything.
- *"We're building a new file server, what RAID should we use?"* — Ask: how much capacity, how much can you afford to lose at once, what's the rebuild tolerance, what's the backup story. Then recommend. Never recommend RAID 0 for anything anyone cares about.
- Never promise a rebuild time. "It depends on drive size, array load, and controller speed — could be hours, could be days. The array is up the whole time but performance is degraded."

## Related concepts

[[Hard Drives (HDD)]] · [[Solid-State Drives (SSD)]] · [[NVMe and M.2]] · [[SATA and SAS Interfaces]] · [[Storage Form Factors]] · [[Backup Strategies]] · [[Hardware vs Software RAID]] · [[Hot Swap and Hot Spare]]

*Source: VIRGIL knowledge base — 2026-05-11*