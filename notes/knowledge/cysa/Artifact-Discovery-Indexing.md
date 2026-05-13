# Artifact Discovery & Indexing

## What it is

In **Demon's Souls**, the Adjudicator's belly is full of bones — and if you carve them out, the Sword of Searching drops. The catch: the sword doesn't deal damage worth a damn. What it does is *find things*. Hidden corpses, buried items, loot the world had swallowed. You sweep the blade and the level finally tells you what was always there.

That's exactly what artifact discovery and indexing does for a forensic image — sweeps a dead disk and forces it to surrender what the filesystem was hiding. Deleted files, slack space, registry hives, browser cache, $MFT entries marked free but not overwritten. The data is still there. The OS just stopped pointing at it.

**Technical definition:** Artifact discovery is the systematic identification of forensically relevant data on acquired media. Indexing is the process of building a searchable catalog of every byte — file content, metadata, deleted records, unallocated space — so an analyst can query the image the way you'd query a database. Tools like Autopsy, EnCase, FTK, and X-Ways do this. The index is what makes a 2 TB drive interrogable in minutes instead of weeks.

The non-negotiable axiom: **deletion ≠ removal**. Forensics assumes data persistence until physically overwritten or cryptographically destroyed. Empty Recycle Bin doesn't empty anything. `shift+delete` doesn't either. `sdelete -p 3` does. CCleaner does — *mostly*, and "mostly" is what gets people indicted.

## Why it matters

You can't investigate what you can't find. An incident with a 4 TB endpoint image and no index is an incident with no answers. Indexing turns the raw image into evidence the IR team can actually work with: keyword hits on the attacker's username, timeline of file modifications around the breach window, deleted PowerShell scripts the adversary thought they cleaned up, browser history showing the phishing click that started it all.

CompTIA tests this under **Objective 3.2 — incident response activities**, specifically the **Detection and Analysis** and **Containment, Eradication, and Recovery** phases. The exam loves to test the boundary between live triage (volatile data, EDR telemetry) and dead-box forensics (imaged disk, indexed artifacts). Know which artifacts live where, and which survive a reboot.

Career stakes: this is the skill that separates the L1 who closes the ticket as "no evidence found" from the L2 who pulls the deleted `mimikatz.exe` out of `$Recycle.Bin\$I*` and proves credential theft.

## Key facts

### What "artifact" means in IR

An **artifact** is any data object with forensic value. Not just files. Categories:

| Artifact class | Examples | Survives reboot? |
|---|---|---|
| Filesystem | $MFT, $LogFile, $UsnJrnl, INDX records | Yes |
| Registry | NTUSER.DAT, SYSTEM, SOFTWARE, SAM, AmCache, ShimCache | Yes |
| Application | Prefetch, Jump Lists, LNK files, browser history/cache, SRUM | Yes |
| Communication | Email PST/OST, Teams cache, Slack logs | Yes |
| Volatile | RAM, network connections, running processes, clipboard | No |
| Unallocated | Deleted files, slack space, carved fragments | Yes, until overwritten |

The volatile row is why **order of volatility** matters during acquisition. Capture RAM first, disk last. CompTIA tests this.

### Index-based searching — how it actually works

The forensic tool walks the entire image once and builds:

- **Full-text index** — every readable string from every file, including deleted files recovered from unallocated space
- **Metadata index** — filenames, paths, MAC times (Modified, Accessed, Created, plus `Entry Modified` on NTFS), sizes, hashes
- **Hash database** — MD5/SHA-1/SHA-256 of every file, cross-referenced against known-good (NSRL) and known-bad (threat intel) hash sets
- **Carved artifacts** — files reconstructed from headers/footers in unallocated space, no filesystem entry required

Once the index is built, a search for `"powershell -enc"` across 2 TB returns hits in seconds. Without the index, you're `grep`-ing a raw image for hours and missing anything compressed, encoded, or in slack.

### The CCleaner problem

CCleaner, BleachBit, and "secure delete" utilities are the suspect's friend and the analyst's gift. They run, they wipe the named targets, and they *leave artifacts of their own execution*:

- **Prefetch** (`C:\Windows\Prefetch\CCLEANER64.EXE-*.pf`) — proof the binary ran, when, how many times
- **AmCache / ShimCache** — execution evidence even after the binary is gone
- **Registry MUICache, UserAssist** — GUI launches logged under the user's NTUSER.DAT
- **$UsnJrnl / $LogFile** — filesystem journal recording the mass deletions
- **Volume Shadow Copies** — if VSS was enabled, the "deleted" files may still exist in a snapshot

*Anti-forensics tools advertise themselves louder than the data they erase. The presence of CCleaner running 11 minutes before acquisition is itself an IoC.*

### Indexing in the CompTIA IR lifecycle

**Preparation:** Forensic workstation built, [[Write Blocker]]s tested, [[Chain of Custody]] forms printed, indexing licenses current, NSRL hash set updated.

**Detection and Analysis:** Index the acquired image. Run keyword searches for the IoCs from threat intel — attacker usernames, C2 domains, malware filenames, encoded PowerShell fragments. Timeline analysis (Plaso/log2timeline) correlates artifacts across sources into one chronological narrative.

**Containment, Eradication, and Recovery:** The index defines [[Scope]] and [[Impact]] — which hosts touched the malicious file, which accounts authenticated to the compromised system, which data was staged for exfil. You can't scope what you haven't indexed.

**Post-incident Activity:** The indexed image is retained per [[Legal Hold]] and [[Data Retention]] policy. Often years. The index itself is part of the evidence record.

### Evidence preservation — the rules

| Rule | What it means |
|---|---|
| Work from copies | Index the working copy, never the original. Original is sealed evidence. |
| Hash everything | SHA-256 the image before and after indexing. Hashes must match. |
| Log every action | Every keyword search, every export, every bookmark — recorded in the case notes |
| Chain of custody | Every transfer of the evidence (original or copy) signed and dated |
| Write blocker on acquisition | Hardware or software — non-negotiable for the original media |

[[Validating Data Integrity]] means the image hash today equals the image hash at acquisition. If it doesn't, the evidence is dead in court.

### Re-imaging vs preservation — the IR fork

After eradication, the compromised host is either:

- **Re-imaged** — wiped to bare metal, OS reinstalled from gold image, user data restored from clean backup. Standard for production endpoints. The acquired image lives on as evidence; the live host moves on.
- **Preserved** — kept offline, untouched, under legal hold. Used when litigation is expected, regulatory investigation is open, or the asset is itself evidence (e.g., the insider threat's laptop).

The decision isn't the SOC's. It's IR lead + legal + sometimes the CISO. The SOC's job is to make sure preservation is possible — which means *don't reboot the box, don't run `cleanup` tools, don't let desktop support "fix" it before the image is captured*.

### Compensating controls during indexing

Indexing a 4 TB image takes 18–36 hours on decent hardware. The compromised user account is locked, the host is isolated on the network, and business operations need to continue. [[Compensating Controls]] bridge the gap:

- Temporary account with reduced privilege for the user
- Loaner laptop from a known-clean pool
- Restricted network segment for affected workflows until the investigation concludes
- Enhanced monitoring on adjacent systems while scope is being determined

### CompTIA exam traps

> **CompTIA exam trap:** **Deletion vs destruction.** A file "deleted" by the user is recoverable from `$Recycle.Bin`, $MFT residual entries, or carving. A file securely wiped (multi-pass overwrite, cryptographic erase) is gone. The exam will offer "the user deleted the file, so the evidence is lost" — wrong. Forensics assumes persistence.

> **CompTIA exam trap:** **Order of volatility.** RAM, network state, running processes → before disk. Disk → before archived backups. If a question gives you a live compromised host and asks what to acquire first, the answer is *not* "image the disk." It's capture volatile memory.

> **CompTIA exam trap:** **Chain of custody breaks the case, not the technique.** A perfectly indexed image with one missing signature on the custody form is inadmissible. The exam tests this — the "best" forensic process is the one that's also legally defensible.

> **CompTIA exam trap:** **Legal hold ≠ retention policy.** A legal hold suspends normal data destruction schedules. If a retention policy says "delete email after 90 days" and a legal hold is in place, the email stays. Failing to honor hold is spoliation.

## SOC reality

- At 3am the IR lead asks two things: *"Is it contained?"* and *"What's the scope?"* Scope comes from the index. If the index isn't built, you don't have an answer — you have a guess, and guesses get walked back in front of executives.
- The L1 analyst doesn't run the index. The L1 acquires the image with a write blocker, hashes it, signs the custody form, and hands it to L2/forensics. Touching the index without training is how you get pulled off the case.
- Never tell leadership "the file was deleted, so we don't know." That sentence ends careers. The correct sentence is *"the file was deleted by the user; recovery from unallocated space and shadow copies is in progress, ETA [X]."*
- The desktop support team will, every single time, try to "just re-image it" before the image is acquired. Your job is to get to the host first. A sticky note on the keyboard that says **DO NOT POWER OFF — IR HOLD** has saved more cases than any tool.
- When CCleaner, BleachBit, or `cipher /w` appears in Prefetch within the breach window, that's not exculpatory — it's [[Indicators of Compromise|consciousness of guilt]] in artifact form. Document it, hash it, hand it to legal.

## Related concepts

[[Chain of Custody]] · [[Write Blocker]] · [[Evidence Acquisition]] · [[Order of Volatility]] · [[Validating Data Integrity]] · [[Legal Hold]] · [[Forensics]] · [[Indicators of Compromise]] · [[Scope]] · [[Impact]] · [[Containment Eradication Recovery]] · [[Compensating Controls]] · [[Re-imaging]] · [[Timeline Analysis]] · [[Volume Shadow Copy]] · [[Prefetch]] · [[$MFT]] · [[Registry Forensics]]

*Source: VIRGIL knowledge base — 2026-05-11*