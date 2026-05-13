# Forensics

## What it is

In **Halo: Combat Evolved**, Cortana spends the entire game pulling data off Forerunner terminals — the Pillar of Autumn's crash site, the Library, the Control Room. Every console she touches, she copies first and reads second. When she finds the truth about the ring — that it's a weapon, not a weapon platform — she has the artifacts to prove it: terminal logs, Forerunner schematics, audit records left behind by builders who died a hundred thousand years ago. Master Chief doesn't get to argue with her conclusion. The evidence is intact, hashed, and chain-of-custody clean from console to AI core.

That's digital forensics. You don't get to argue with what the disk says — if you preserved it correctly. If you didn't, you don't have evidence; you have a story.

**Plain English:** Forensics is the discipline of acquiring, preserving, analyzing, and presenting digital evidence in a way that holds up — to leadership, to legal, to a courtroom, to an insurance adjudicator. The technical work is finding what happened. The procedural work is proving you didn't tamper with it.

**Technical (CS0-003):** Forensics is the structured collection and analysis of digital artifacts — disk images, memory dumps, log files, network captures, filesystem metadata — performed during the **Detection and Analysis** and **Post-incident Activity** phases of the NIST SP 800-61 incident response lifecycle. It enforces evidence integrity through hashing, write blockers, and documented chain of custody so the artifacts support [[Root Cause Analysis]], legal proceedings, regulatory reporting, and lessons-learned outputs.

## Why it matters

Forensics is where IR work either survives contact with reality or collapses. You can contain a breach beautifully and still lose the lawsuit, the insurance claim, or the regulator's confidence because someone mounted the suspect drive read-write and changed the last-accessed timestamps on 40,000 files. Containment without preservation is just cleanup.

For CySA+, forensics shows up across Objective 3.2 (incident response activities) and 3.3 (post-incident). CompTIA tests acquisition order, hash validation, chain of custody, legal hold triggers, and the difference between [[Re-imaging]] and forensic imaging — they sound similar and mean opposite things.

Career-wise: SOC analysts who can do clean acquisition and basic timeline reconstruction get pulled into IR. Analysts who can't stay on the tier-1 queue.

## Key facts

### The acquisition pipeline

| Step | What you do | Why it matters |
|------|-------------|----------------|
| **Isolation** | Pull the host off the network — VLAN quarantine, EDR containment, or unplug | Stops compromise and stops the attacker from wiping evidence |
| **Order of volatility** | Capture volatile data first: CPU registers/cache → RAM → network state → disk → archives | Volatile data is gone the moment you pull power |
| **Write blocker** | Hardware or software device between suspect drive and acquisition workstation | Prevents the OS from writing metadata to the evidence drive on mount |
| **Imaging** | Bit-for-bit copy using `dd`, FTK Imager, EnCase, or `dc3dd` | Working copy gets analyzed; original goes in the safe |
| **Hash** | SHA-256 (or SHA-3) of source and image | Mathematical proof the copy is identical |
| **Chain of custody** | Sign and date every transfer, storage location, and access | Proves no one tampered between acquisition and courtroom |

### Order of volatility (memorize this)

Highest volatility first:

1. **CPU registers, cache** — gone in microseconds
2. **RAM** — gone at power-off
3. **Network state** — routing tables, ARP cache, open connections, running processes
4. **Temporary filesystems** — `/tmp`, paging files, swap
5. **Disk** — persistent, but writes happen constantly
6. **Remote logging and monitoring data**
7. **Physical configuration, network topology**
8. **Archival media** — backups, tapes

### Validating data integrity — hashing

A forensic hash is a mathematical fingerprint. SHA-256 produces a 256-bit value; flip one bit anywhere on the drive and the hash changes completely.

1. Hash the source drive **before** imaging
2. Image the drive through the write blocker
3. Hash the image
4. Compare. If they match — bit-identical. If they don't — your image is corrupt or your write blocker failed.

A matching hash proves three things in one operation: **nothing was altered, nothing was deleted, nothing was added.**

MD5 and SHA-1 are considered broken for collision resistance, but for forensic integrity verification (you control both ends, no adversarial collision pressure) they remain acceptable. SHA-256 is the modern default.

### `dd` — the imaging command

```
dd if=/dev/sdb of=/mnt/evidence/case42.img bs=4M conv=noerror,sync status=progress
```

- `if=` input file (source — the suspect drive)
- `of=` output file (destination — the image)
- `bs=` block size — **adjust this first when imaging is slow.** 4M or 16M is reasonable.
- `conv=noerror,sync` — keep going on read errors, pad bad sectors with zeros (preserves offsets)
- `count=` limits how many blocks to copy — **never touch this for full forensic images**, you'll get a partial image

`dc3dd` and `dcfldd` are forensic forks that hash on the fly and log everything.

### Where deleted files leave evidence (Windows)

| Artifact | What it stores |
|----------|----------------|
| **Master File Table (MFT)** | Every file NTFS has ever tracked, including deleted entries until overwritten |
| **INDX files** | NTFS directory index records — retain entries for deleted files |
| **Windows Registry** | RecentDocs, shellbags, USB device history, UserAssist |
| **Prefetch** (`C:\Windows\Prefetch`) | Last 8 execution times of executables, evidence the program ran |
| **ShimCache / AmCache** | Application execution history, even if deleted |
| **Volume Shadow Copies** | Point-in-time snapshots — gold mine for "what did this file look like yesterday" |
| **Pagefile / Hiberfil** | RAM contents flushed to disk — can contain decrypted secrets |
| **$LogFile, $UsnJrnl** | NTFS journaling — every metadata change, timestamped |

**Event logs do NOT reliably record file existence at a specific path.** They record system, security, and application events. Logon success, service starts, audit policy changes — yes. "This file used to be at C:\Users\bob\loot.zip" — no.

### Chain of custody

Every transfer, every access, every storage change, signed and dated. The form lives with the evidence. Break the chain — even once, even briefly — and opposing counsel will exclude the evidence.

The form captures case ID, evidence number, description and serial, who collected it / when / where, every transfer (from-whom, to-whom, date, time, purpose, signatures), and the storage location and access log. If you handed the drive to a colleague to grab coffee, that's a transfer. Document it.

### Legal hold

A **legal hold** (litigation hold) is a formal directive from legal counsel that ordinary data retention and deletion policies are **suspended** for specific systems, mailboxes, or users because litigation or investigation is reasonably anticipated. Once issued: auto-delete pauses, re-imaging and disposal stop, backups are preserved beyond normal retention, and custodians are notified in writing.

Spoliation — destroying evidence under legal hold — gets the organization sanctioned and gets careers ended. When legal hold lands in your inbox, confirm receipt and freeze the affected assets immediately.

### Where forensics fits in the IR lifecycle

Forensics sits inside **Detection and Analysis** but its outputs feed every later phase:

- **Containment:** [[Isolation]] of the affected host via network segmentation or EDR containment — done in a way that preserves volatile state where possible
- **Eradication:** Forensics tells you *what* to eradicate and *where else to look* (lateral movement, persistence mechanisms)
- **Recovery:** [[Re-imaging]] from known-good baselines, restoring clean backups, applying [[Compensating Controls]] if a full patch isn't yet available
- **Scope and impact:** Forensic timeline reconstruction answers "how many hosts, what data, over what window" — the questions leadership asks first

**Re-imaging vs forensic imaging — opposite operations.** Re-imaging *overwrites* the compromised host with a clean OS build. Forensic imaging *preserves* the compromised host bit-for-bit. Forensic image **first**, then re-image production.

Forensics also produces high-fidelity [[Indicators of Compromise]] — file hashes, registry keys, scheduled task names, C2 domains, mutex names, persistence locations — which feed back into SIEM correlation, EDR custom detections, and threat intel sharing.

### CompTIA exam traps

> **CompTIA exam trap — re-imaging is not remediation evidence.** Re-imaging removes the compromise; it does not prove what happened. If you re-image before forensic acquisition, you've destroyed evidence. Forensic image first, re-image second. Always.

> **CompTIA exam trap — event logs vs filesystem artifacts.** Event logs do not record arbitrary file paths over time. To prove a specific file existed, look at MFT, INDX, registry shellbags, prefetch, or USN journal. Event logs prove *events happened*, not *files existed*.

> **CompTIA exam trap — hash matching proves more than non-alteration.** A matching forensic hash simultaneously proves: nothing altered + nothing deleted + nothing added. If a question lists all three with "all of the above," the answer is all of the above.

> **CompTIA exam trap — `dd` performance.** When `dd` is slow, adjust **block size (`bs=`)** first. Never adjust `count=` to "speed it up" — that produces a truncated image.

> **CompTIA exam trap — order of volatility starts with CPU, not RAM.** Registers and cache are more volatile than RAM. CompTIA will list four options where RAM is first to bait you.

## SOC reality

- At 3am the IR lead asks three things: **scope, impact, evidence preserved?** If you can't answer the third, the first two don't matter — you've lost the case before it started.
- The L1 first action on a confirmed compromise is **do not log into the host interactively.** Every login writes timestamps, updates registry keys, and rolls event logs. EDR isolation through the console is fine; RDP to "take a look" is forensic vandalism.
- Volatile data acquisition gets skipped by tired analysts because the host is "already isolated" — and then six weeks later legal asks what was in RAM and the answer is *we power-cycled it.* Capture memory before you pull the plug.
- Never tell leadership "we have the evidence" until hashes match and the chain of custody form is signed. *An image without a verified hash is a story, not evidence.*
- Handoff: L1 isolates and preserves, L2 acquires and hashes, IR/forensics team analyzes, legal owns chain of custody and hold decisions. When legal hold drops, every related ticket gets a flag and nothing about those assets gets deleted, re-imaged, or disposed of without legal sign-off.

## Related concepts

[[Chain of Custody]] · [[Order of Volatility]] · [[Write Blocker]] · [[Hashing]] · [[Legal Hold]] · [[Re-imaging]] · [[Isolation]] · [[Compensating Controls]] · [[Indicators of Compromise]] · [[Root Cause Analysis]] · [[NIST SP 800-61]] · [[Memory Forensics]] · [[Disk Forensics]] · [[Timeline Analysis]] · [[MFT]] · [[Volume Shadow Copy]] · [[Spoliation]]

*Source: VIRGIL knowledge base — 2026-05-11*