# File System Analysis & Carving

## What it is

In **Half-Life**, when you're crawling through the Black Mesa wreckage after the resonance cascade, the facility is wrecked — ceilings collapsed, signage gone, the tram system trashed. But the place still tells you what happened. Scorch marks on the walls, scientist corpses where they fell, security doors blown off their hinges, a half-eaten sandwich on a desk in the break room. Gordon doesn't have a map anymore. The directory is destroyed. But the *contents* are still physically there, scattered across the floor, and you reconstruct the story from the debris.

That's exactly what file carving does — when the filesystem's index is gone, corrupted, or wiped, the actual file data is often still sitting on disk. You pull it out by recognizing what files look like in raw bytes, not by asking the directory where they live.

**File system analysis** is the broader discipline: examining a filesystem's structures (MFT on NTFS, inodes on ext4, catalog files on APFS/HFS+) to reconstruct what existed, when it existed, and what touched it. **File carving** is the subset technique: recovering file content directly from raw disk sectors by pattern-matching headers, footers, and known structures — *without* relying on filesystem metadata. Carving is what you do when the filesystem can't or won't help you.

## Why it matters

CS0-003 Objective 3.2 puts evidence acquisition, preservation, validating data integrity, and chain of custody at the center of incident response. Carving is the technique you reach for when the attacker has tried to cover their tracks — deleting payloads, wiping logs, formatting drives, dropping anti-forensics tools. The filesystem says "nothing here." The platters disagree.

Real-world stakes: ransomware operators routinely delete their staging tools after exfil. Insider threats empty the Recycle Bin and call it a day. APTs use timestomping to make their implants look like legitimate system files. If your IR capability stops at "what's the filesystem say," you miss most of what mattered. Carving is also how you recover deleted evidence under legal hold when an end-user "accidentally" purged their mailbox the day HR opened the investigation.

Exam-wise, this lands inside Domain 3.0 — detection and analysis, evidence acquisition, preservation, data integrity, and the chain of custody that keeps your findings admissible.

## Key facts

### File carving methods

Three carving approaches the exam cares about:

| Method | How it works | When it shines | Where it fails |
|---|---|---|---|
| **Header/footer** | Match known magic bytes at start and end (`FF D8 FF` for JPEG, `25 50 44 46` for PDF) | Common file types with stable signatures | Fragmented files; missing footers |
| **Content-based** | Look at internal structure — entropy, character distribution, language patterns | Text, encrypted blobs, partial files | Slow, prone to false positives |
| **Structure-based** | Use the file format's internal layout (PDF object trees, ZIP central directory) to reassemble | Complex container formats | Requires deep format parsers |

Tools: **PhotoRec**, **Foremost**, **Scalpel**, **bulk_extractor**. Autopsy and FTK Imager wrap several of these.

### File system structures you actually examine

- **NTFS** — The **MFT (Master File Table)** is the index. Every file has an MFT record with timestamps (`$STANDARD_INFORMATION` and `$FILE_NAME` — both matter, and they can disagree, which is itself an IoC). Deleted files leave their MFT entries until overwritten. `$LogFile` and `$UsnJrnl` track changes.
- **ext4** — Inodes hold metadata, directory entries point at inodes. Deletion zeros the directory entry but the inode and data blocks often persist.
- **APFS / HFS+** — Catalog file is the index. Snapshots are a forensic goldmine — they capture point-in-time state the attacker may not have known to wipe.
- **FAT32 / exFAT** — Cluster chains in the FAT. Deletion marks the first character of the filename with `0xE5`; the data clusters are unallocated but intact until reused.

The key idea across all of these: **deletion almost never means erasure.** It means "marked available for reuse." Until something reuses the space, the data is still on disk. That gap is the entire reason carving exists.

### Slack space and unallocated space

- **File slack** — The space between the end of a file and the end of the cluster it occupies. Old data from previously-deleted files often lives here.
- **Unallocated space** — Clusters not currently assigned to any file. Carving's primary hunting ground.
- **Volume slack** — Space between the end of the filesystem and the end of the partition.

A real IR finding lives in slack: an attacker's PowerShell script gets deleted, the cluster gets partially reused by a Word document, but the tail end of the original script is still readable in the new file's slack. You only find that if you carve.

### The acquisition and preservation chain

Carving without proper acquisition is evidence you can't use. The order matters:

1. **Isolation** — Pull the host off the network. Don't shut it down if memory matters (RAM dies on power-off). Network containment first.
2. **Acquisition** — Bit-for-bit image using a **write blocker** (hardware preferred). Tools: `dd`, `dcfldd`, FTK Imager, Guymager. Image format: raw (dd), E01 (EnCase), or AFF.
3. **Hash immediately** — SHA-256 (MD5 is dead for collision resistance but still common as a secondary). Hash the source, hash the image, they match or the acquisition is invalid.
4. **Work on copies** — Never carve the original. Make a working copy, hash it, hash it again when you're done. Integrity of the original is non-negotiable.
5. **Chain of custody** — Every transfer logged: who took it, when, why, where it went. One missing handoff and the defense attorney has all the leverage they need.
6. **Legal hold** — If litigation or regulatory action is foreseeable, preservation obligations kick in *before* acquisition. Routine deletion policies get suspended. Sanctions for spoliation are real and expensive.

### Data integrity validation

Hashes are the contract. If the working image's hash matches the source's hash, the data is provably unchanged. If it doesn't, the acquisition is contaminated and the analysis is suspect. Document the hash at every stage: acquisition, transfer, analysis, archival. This is the single most-tested integrity concept in Domain 3.0.

### Timestomping and what to trust

Attackers modify file timestamps to blend in. On NTFS, `$STANDARD_INFORMATION` (SI) timestamps are user-modifiable; `$FILE_NAME` (FN) timestamps are harder to forge and usually reflect actual creation/move events. **SI/FN mismatch is an IoC for timestomping.** Tools like SetMACE and Timestomp (Metasploit) target SI specifically.

### CompTIA exam traps

> **CompTIA exam trap:** "Deleted" vs "wiped" vs "overwritten." Deleted = directory entry removed, data intact, recoverable by carving. Wiped = data overwritten with patterns (zeros, random), generally unrecoverable. Overwritten = another file reused the space, partial recovery possible from slack. CompTIA will use these interchangeably in the question stem and precisely in the answer choices.

> **CompTIA exam trap:** Order of volatility. Memory before disk, disk before backups, backups before archived data. If a question asks what to acquire first on a live system, the answer is RAM — not the disk image — because powering off destroys it. Disk imaging comes after memory capture.

> **CompTIA exam trap:** Write blocker placement. The write blocker goes between the suspect drive and the analyst workstation. If the question describes imaging "directly" or "without protection," the chain of custody is already broken — that answer is wrong regardless of how thorough the rest of the process sounds.

> **CompTIA exam trap:** Hash mismatches don't mean "redo the carving." They mean the evidence is compromised and may not be admissible. Document the discrepancy, escalate, do not "fix" it by re-imaging without legal/IR lead approval.

### Carving in the IR lifecycle

Mapped to NIST SP 800-61 / CompTIA's four phases:

- **Preparation** — Write blockers staged. Imaging workstation built. Hashing tools validated. Forensic SOPs written. Legal hold templates ready.
- **Detection and analysis** — Carving runs here. Recover deleted malware, reconstruct attacker timeline, pull artifacts from slack and unallocated space. Feed IoCs back to the SIEM hunt.
- **Containment, eradication, recovery** — Carving informs scope. If you find a deleted dropper on host A, you hunt for the same hash on hosts B through Z before re-imaging. **Re-imaging** the compromised host is the standard recovery — but only after acquisition is complete, because re-imaging destroys all the evidence you didn't collect. **Compensating controls** (host isolation, application allow-listing, EDR in block mode) hold the line until full remediation.
- **Post-incident** — Carved artifacts go into the lessons-learned report and the threat intel pipeline. Root cause analysis often hinges on something carving found.

### Scope and impact assessment

Carving directly informs both. **Scope** = how many systems? Find the dropper on disk via carving, hash it, sweep the environment for that hash. **Impact** = what was taken? Carve unallocated space for exfil staging archives (`.rar`, `.7z`, `.zip` with suspicious naming), browser history fragments showing access to sensitive shares, deleted command outputs. Without carving, scope and impact are guesses based on what the attacker *didn't* delete.

## SOC reality

- The 3am page rarely says "carve the disk." It says "EDR alerted on suspicious deletion activity on FIN-WS-042." L1 acknowledges, isolates the host at the switch, opens an IR ticket. Carving is a Tier 3 / IR-team activity that starts *after* containment.
- The IR lead's first three questions are always the same: *"Is it contained? Is evidence preserved? What's the blast radius?"* If you re-imaged before acquisition, you've answered question two with "no" and your career gets shorter.
- Never tell leadership "we recovered everything the attacker deleted." You recovered what wasn't overwritten. That's a different statement and the gap matters. *I learned the hard way that "we got the dropper" doesn't mean "we got all the staging tools" — the attacker had been on the box for six weeks and most of their early footprint was long gone by the time we imaged.*
- Legal hold notifications are not optional and not the IR team's call alone. The minute the incident looks like it might involve regulator notification, litigation, or HR action, loop in legal counsel before the next acquisition step. Spoliation sanctions are real and they fall on the organization, not the attacker.
- Handoff is L1 → L2 (triage and initial scoping) → IR / forensics (acquisition and carving) → legal (chain of custody review, hold management) → executive (impact briefing). Carving artifacts are the evidence backbone of every step downstream.

## Related concepts

[[Chain of Custody]] · [[Evidence Acquisition]] · [[Order of Volatility]] · [[Write Blockers]] · [[Hashing and Data Integrity]] · [[Memory Forensics]] · [[Disk Imaging]] · [[Timestomping]] · [[MFT Analysis]] · [[Legal Hold]] · [[Re-imaging]] · [[Compensating Controls]] · [[Incident Response Lifecycle]] · [[Indicators of Compromise]] · [[Anti-Forensics]]

*Source: VIRGIL knowledge base — 2026-05-11*