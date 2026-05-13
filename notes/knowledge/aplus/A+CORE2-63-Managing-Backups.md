# Managing Backups

## What it is

The day your NVMe dies mid-raid, you find out whether "backups" was a verb you did or a noun you owned. Most people learn the difference in the same five-second window: the drive clicks, the screen freezes, and you mentally inventory what's gone forever.

A **backup** is a copy of data stored separately from the original, with the explicit purpose of restoring it after the original is lost, corrupted, encrypted, or deleted. **Recovery** is the act of actually pulling that copy back into a working state. If you've never tested the second half, you don't have backups — you have hope.

Backups are insurance against death. Storage will fail. The only question is whether you've paid the premium.

## Why it matters

Ransomware doesn't ask permission. Drives don't warn you. Users delete the wrong folder on a Tuesday afternoon. Fires happen. Floods happen. The intern runs `DELETE` without a `WHERE` clause. Every one of those events is survivable if your backups are current, separated, and tested. Every one of them is a resume-generating event if they aren't.

CompTIA 220-1202 Objective 4.3 tests whether you can name the schemes, distinguish full from incremental from differential from synthetic full, articulate the 3-2-1 rule, and explain why backup testing is non-negotiable. The exam will give you a scenario and ask which scheme fits — read the scenario for storage cost, restore time, and retention requirements.

## In your build, in the enterprise

**Beat 1 — Technical depth.** A **full backup** copies everything every time. Slowest to run, fastest to restore — one tape, one file, one operation. An **incremental backup** copies only what changed since the last backup of any type. Fast to run, slow to restore — you need the full plus every incremental in the chain, in order. A **differential backup** copies everything that changed since the last full. Middle ground — restore needs only the full plus the most recent differential. A **synthetic full** is a full backup constructed by the backup server stitching the last real full plus all subsequent incrementals into a new full image, without touching the source machine. Best of both worlds: clients only ship incrementals, but restores behave like fulls. **In-place/overwrite** means the new backup overwrites the previous one — minimal storage, zero history. **Alternative location** means writing to a different path, drive, or site. **Onsite** is fast to restore but dies with the building. **Offsite** survives the building but takes longer to retrieve.

**Beat 2 — Feynman example via gaming/personal build.**

**The setup:** You've got a gaming rig with a 2TB NVMe for Windows and games, a 4TB HDD for personal files, and you stream on weekends. The streaming clips, the Tarkov highlight reel, the GameRanger save from 2009 you can't replace — that's the irreplaceable stuff.

**Full every Sunday:** Macrium Reflect or Veeam Agent dumps a full image of the personal-files drive to a USB external every Sunday night. Takes two hours. *One file, one restore — simple.*

**Incremental nightly:** Mon–Sat, only the changed blocks get written. Each one is 5GB instead of 800GB. *Fast, cheap, but the restore chain is seven files long if Saturday's drive dies.*

**The 3-2-1 rule:** Three copies of the data (original + two backups), on two different media types (NVMe + external HDD + cloud), with one copy offsite (Backblaze, iDrive, or a USB drive at your parents' house). House burns down, ransomware hits, drive dies — at least one copy survives. *This is the rule. Memorize it.*

**The kicker:** Six months in, the NVMe dies. You plug in the external. The newest incremental is corrupt because you never ran a test restore. Now you're rebuilding from last Sunday's full and losing a week. *Backups you haven't tested are Schrödinger's backups — both alive and dead until you open the box.*

**Beat 3 — Bridge from gaming to enterprise.** Same fundamental question: *what data can't I lose, how far back do I need to go, and how fast must I be back online?*

- **Gaming PC:** Personal files, save games, stream clips. Sunday full + nightly incremental + cloud sync. Restore in an evening is fine.
- **Developer workstation:** Source code lives in git (which is itself a distributed backup), but local config, secrets vaults, and Docker volumes don't. Daily synthetic full to NAS, weekly offsite. Restore in an hour.
- **Small business file server:** Customer records, QuickBooks, shared drives. Nightly incremental to NAS + weekly full to LTO tape rotated offsite via Iron Mountain. Restore window: 4 hours, can't lose more than 24 hours of work.
- **Enterprise production server:** Database with 24/7 transactions. Continuous replication to a warm-standby site, hourly snapshots, daily synthetic fulls, monthly fulls archived to immutable cloud storage with WORM (write-once-read-many) locks against ransomware. RPO 15 minutes, RTO 1 hour.

**Beat 4 — The point.** Same question — what to protect, how far back, how fast to recover — different answers driven by the cost of downtime and the cost of storage. The gaming rig accepts a week of pain. The production database accepts fifteen minutes. Get this question into your bones: *what's my RPO, what's my RTO, and does my backup scheme actually meet them?* You'll ask it for the rest of your career.

## Key facts

### Backup types

| Type | What it copies | Backup speed | Restore speed | Storage cost |
|---|---|---|---|---|
| **Full** | Everything | Slowest | Fastest (1 file) | Highest |
| **Incremental** | Changes since last backup of any kind | Fastest | Slowest (full + every incr) | Lowest |
| **Differential** | Changes since last full | Medium | Medium (full + 1 diff) | Medium |
| **Synthetic full** | Server-constructed full from existing full + incrementals | Zero impact on client | Fast (behaves as full) | Medium-high |

### The 3-2-1 rule

- **3** copies of the data (original + 2 backups)
- **2** different storage media types (e.g., disk + tape, or local + cloud)
- **1** copy offsite

Modern extension: **3-2-1-1-0** — add 1 immutable/offline copy, and 0 errors in the last test restore. The exam tests 3-2-1; know the extension exists.

### Rotation schemes

**In-place / overwrite:** Each backup overwrites the previous. One file on disk. *No history — if corruption happened three days ago and you didn't notice, the corruption is your backup now.* Use only for ephemeral data.

**Grandfather-Father-Son (GFS):** A retention rotation, not a backup type.
- **Son:** Daily backups (kept ~1 week)
- **Father:** Weekly fulls (kept ~1 month)
- **Grandfather:** Monthly fulls (kept ~1 year, sometimes longer)

Gives you the ability to restore to any day in the last week, any week in the last month, any month in the last year — without storing 365 daily fulls.

**Onsite vs. offsite:** Onsite is fast restore, dies with the building. Offsite survives disasters, slower to retrieve. You need both. *Onsite alone is one fire away from a career change.*

**Alternative location:** Writing the backup to a different drive, server, or geographic site. The phrase covers everything from "external USB" to "cross-region S3 replication."

### Backup testing — the part nobody does

A backup is a hypothesis. A restore test is the experiment.

| Backup tier | Test frequency |
|---|---|
| Personal / home | Every 3–6 months — restore a few files, verify they open |
| Small business | Monthly — file-level restore + quarterly full bare-metal restore |
| Enterprise production | Weekly file-level, monthly full DR drill, annual tabletop exercise |

Tests must include: **file-level restore** (can you pull one file?), **full system restore** (can you bring the whole machine back?), and **disaster recovery drill** (can you stand up the system at the alternate site?). Document the restore time — that's your real RTO, not the one in the SLA.

### CompTIA exam traps

> **CompTIA exam trap:** Incremental vs. differential — incremental is "since the last backup of any type," differential is "since the last full." The restore math is the giveaway: incrementals need the full plus *every* incremental; differentials need the full plus *only the latest* differential.

> **CompTIA exam trap:** 3-2-1 is not "3 backups." It's three *copies* (the original counts as one), two media types, one offsite. The exam will offer "3 backups on the same NAS" as a distractor — that's not 3-2-1.

> **CompTIA exam trap:** A synthetic full is constructed by the backup server, not the client. The client only sends incrementals. The exam tests this because it's the modern enterprise default and candidates from older study material miss it.

> **CompTIA exam trap:** "In-place" / "overwrite" gives you no history. If the scenario mentions ransomware, compliance, or version recovery, in-place is wrong.

### Consumer vs. enterprise

| Layer | Home / gaming rig | Enterprise |
|---|---|---|
| **Software** | File History, Time Machine, Macrium free, Backblaze | Veeam, Commvault, Rubrik, Cohesity, Azure Backup |
| **Target** | External USB drive + consumer cloud | SAN/NAS, dedicated backup appliance, S3/Azure Blob, LTO tape |
| **Rotation** | Set-and-forget weekly full + nightly incremental | GFS with tiered hot/warm/cold, monthly archives, 7-year retention for compliance |
| **Offsite** | Backblaze, iDrive, or a drive at a relative's house | Cross-region cloud replication, Iron Mountain tape pickup, DR site |
| **Testing** | "It worked last time I tried" | Documented monthly test restores, annual DR drill, audit logs |
| **Threats addressed** | Drive failure, theft, fire | All of the above + ransomware (immutable/WORM storage), insider deletion, regulatory hold, multi-region outage |

The leap from home to enterprise isn't the *concept* — it's the *rigor*. At home, "I'll test it when I need it" is acceptable risk. In production, untested backups are a finding on your next audit.

## Helpdesk reality

- **"I lost my Documents folder, can you get it back?"** — Check OneDrive/Google Drive recycle bin first (30-day retention). Then File History or shadow copies. Then the actual backup. Set expectations on time-to-restore *before* you start digging.
- **"Why does the backup take so long?"** — Probably running a full when it should be incremental, or running over Wi-Fi when it should be wired. Check the schedule and the link.
- **"We got hit with ransomware — can we restore?"** — Only if your backups are *immutable or offline*. Live-mounted NAS backups get encrypted right along with production. This is why offline/air-gapped/WORM copies exist.
- **Never promise** a restore will succeed before you've verified the backup isn't corrupt. "Let me check the backup integrity first" is the right answer.
- **Never promise** a recovery time you haven't measured. The SLA says 4 hours; your last test restore took 11. Tell the truth.

## Related concepts

[[Storage Devices]] · [[RAID]] · [[Ransomware]] · [[Disaster Recovery]] · [[Cloud Storage]] · [[Change Management]] · [[Data Destruction]] · [[OneDrive and File Sync]]

*Source: VIRGIL knowledge base — 2026-05-11*