# Disk Imaging and Acquisition Tools

## What it is

In **Metroid**, when Samus enters a new area on Zebes, she doesn't just glance at the room and move on — the map system records every tile she's walked, every door she's opened, every item slot she's passed even if she couldn't reach it yet. Later, when she needs to backtrack with the Morph Ball or Ice Beam, the map still has the unreachable rooms ghosted in. Nothing she saw is lost. The world is preserved exactly as she encountered it, so future Samus can return with new tools and find what past Samus couldn't.

That's exactly what disk imaging does — capture the entire storage medium, including the parts you can't currently "see," so analysts with better tools later can still recover what's there.

Technically: **disk imaging (forensic acquisition)** is the process of creating a **bit-for-bit copy** of a storage device — every sector, allocated or not, deleted or not, slack or not — into a forensically sound image file. The image is then hashed, write-protected, and analyzed in a lab. The original device goes into evidence storage and is never touched again unless a court orders it.

This is **Domain 3.2 — evidence acquisition** territory. CompTIA expects you to know why bit-level matters, how integrity is validated, and how chain of custody survives the trip from the rack to the courtroom.

## Why it matters

A logical copy — `cp -r /home/user /evidence/` — misses everything that matters. Deleted files, browser cache fragments, malware staging directories that got cleaned up at boot, the unallocated regions where the attacker dropped a payload and then `rm`'d it. Logical copy gives you the rooms Samus can currently walk into. Bit-level imaging gives you the whole map, including the rooms behind doors you don't have keys for yet.

Get this wrong and you lose three things at once: **the evidence** (overwritten or not captured), **the case** (chain of custody broken, judge throws it out), and **the job** (the post-incident review names you). CySA+ Objective 3.2 tests evidence acquisition explicitly because it's the IR phase where junior analysts cause the most permanent damage.

## Key facts

### Bit-by-bit vs logical copy

| Type | What it captures | Forensically sound? |
|---|---|---|
| **Bit-by-bit (physical image)** | Every sector — allocated, unallocated, slack space, HPA/DCO regions, deleted file remnants | Yes |
| **Logical copy** | Only files visible to the filesystem | No |
| **Sparse image** | Selected portions of the disk | Sometimes — depends on scope and legal posture |

**Bit-by-bit is the default for forensic work.** It captures:

- **Allocated space** — current live files
- **Unallocated space** — where deleted files used to live, often still recoverable
- **Slack space** — leftover bytes between end-of-file and end-of-cluster, where attacker data hides
- **File system metadata** — MFT entries on NTFS, inodes on ext4, journals, timestamps

### The acquisition toolkit

**`dd` (Linux/Unix)** — the original. Raw, bit-level, will happily destroy your evidence drive if you flip `if=` and `of=`. No hashing built in. Pair with `sha256sum` or use the safer fork **`dcfldd`** (DoD Computer Forensics Lab `dd`) or **`dc3dd`**, which add hashing, progress bars, and split-image support natively.

```
dc3dd if=/dev/sdb hash=sha256 log=acq.log of=evidence.dd
```

**FTK Imager** — free, GUI-driven, runs from a USB so you don't install anything on the suspect host. Creates E01 (EnCase format, compressed + hashed) or raw `dd` images. Previews the image before full acquisition. The standard tool for Windows-based field acquisition.

**EnCase / Guidance Software** — enterprise platform. Acquisition, analysis, reporting, court-ready exports. Expensive. Common in law enforcement and large IR firms.

**Magnet AXIOM, X-Ways Forensics, Cellebrite** — the rest of the commercial field. CySA+ doesn't quiz you on these specifically, but recognize the names.

**Memory acquisition (separate problem)** — disk imaging captures storage; volatile memory needs **WinPMEM, LiME, FTK Imager's memory option, or Magnet RAM Capture**. RAM dies when the box powers off. Capture it first if the host is still running and you have authority.

### Order of volatility (NIST/RFC 3227)

Capture from most volatile to least. If you image the disk first, you lose RAM. If you pull the plug to image the disk, you lose RAM, network state, and running processes.

1. CPU registers, cache
2. Routing tables, ARP cache, process tables, RAM
3. Temporary files
4. **Disk (this note)**
5. Remote logs
6. Physical configuration, network topology
7. Archival media

### Write blockers — non-negotiable

A **write blocker** is a hardware or software device that sits between the suspect drive and the acquisition workstation, allowing reads but physically blocking writes. Hardware write blockers (Tableau, WiebeTech) are the gold standard. Software blockers exist but defense attorneys love attacking them in court.

*If you imaged a drive without a write blocker, you didn't acquire evidence. You contaminated it.*

### Validating data integrity

The image is worthless if you can't prove it matches the original. Standard practice:

1. Hash the **source** drive before acquisition (SHA-256 or SHA-1; MD5 is acceptable legacy but increasingly questioned)
2. Acquire the image
3. Hash the **image**
4. Compare. If they match, the image is a faithful copy.
5. Re-hash the image periodically during analysis to prove no drift

| Hash | Status |
|---|---|
| MD5 | Legacy, collision-broken, still used in tools |
| SHA-1 | Deprecated for cryptographic use, still common in forensics |
| SHA-256 | Current standard |

Forensic tools typically record **both MD5 and SHA-256** to cover legacy and modern verification.

### Chain of custody

Every transfer of evidence — from suspect machine to acquisition workstation to evidence locker to lab analyst to court — gets logged on a chain of custody form. Who, what, when, where, why, hash value. One missing transfer and the defense argues the evidence was tampered with.

> **CompTIA exam trap:** Chain of custody is about *every* transfer, not just the first one. If the IR lead hands the drive to the lab tech without a form, the chain is broken even if everything else was perfect. The exam will give you a scenario where one handoff is missing and ask why the evidence is inadmissible.

### Legal hold

A **legal hold** (litigation hold) is a formal notice that suspends normal data destruction policies because litigation is anticipated. Once issued, the org cannot let log rotation, retention policies, or routine re-imaging destroy potentially relevant data. Legal hold is *organizational*, not technical — but it's what forces you to image the box instead of wiping and re-deploying it.

### Re-imaging (recovery phase)

Different "imaging." After eradication, you don't clean an infected host — you **re-image** it from a known-good golden image. The forensic image of the *compromised* state is preserved for analysis; the *production* host gets blown away and rebuilt. Two separate images, two separate purposes:

- **Forensic image** — frozen snapshot of the crime scene, preserved
- **Golden image / re-image** — clean baseline pushed back to the endpoint to restore service

### Compensating controls during acquisition

You often can't image a production database server at 2pm on a Tuesday. Acquisition can take hours. Compensating controls during the gap:

- **Network isolation** — VLAN quarantine, firewall block, switch port disable — contain without powering off
- **Enhanced logging** — turn up verbosity on adjacent systems while the suspect host waits for the imaging window
- **EDR containment mode** — most EDRs (CrowdStrike, SentinelOne, Defender) have a "network contain" toggle that isolates the endpoint from everything except the EDR console

### CompTIA exam traps

> **Exam trap:** Pulling the power on a running suspect host destroys RAM, network state, and any encryption keys held in memory. If the disk is full-disk encrypted (BitLocker, LUKS) and you yank the plug, you may have a fully encrypted brick. **Live acquisition first when possible**, then orderly shutdown — *unless* the malware is actively destroying evidence, in which case pulling the plug is the lesser evil.

> **Exam trap:** "Imaging" appears in two completely different IR phases. **Forensic imaging** is in Detection and Analysis (evidence acquisition). **Re-imaging** is in Containment/Eradication/Recovery (rebuilding the host). Read the question carefully — CompTIA will use the same word for both and bank on you confusing them.

> **Exam trap:** Hashing is for **integrity**, not confidentiality. A matching hash proves the image equals the source. It does not protect the contents from disclosure. Encryption of the image-at-rest is a separate control.

## SOC reality

- The 3am page says "ransomware note on FILE-SRV-04." Your first instinct is to log in and look around. **Don't.** Every shell you spawn writes to the prefetch, updates `lastlogin`, mutates RAM. The L1 playbook is: isolate at the switch, page the IR lead, do not touch the host until acquisition authority is confirmed.

- The CISO's first three questions are always **scope, impact, evidence preserved**. The third one means: "Do we have a forensic image, or did someone reboot the box?" The answer "we rebooted it to see if that fixed it" ends careers.

- Imaging a 2TB enterprise SSD over USB 3 takes 4–8 hours. The business will scream about downtime. Your answer is the EDR network-contain toggle plus a written statement that re-imaging without acquisition forfeits root cause analysis and any legal recourse. Get legal to sign before you skip the image.

- L1 acknowledges and isolates. L2 calls the IR lead and stages the write blocker and acquisition workstation. IR lead authorizes acquisition, signs the chain of custody form, and runs the image. Legal gets looped in the moment "litigation" or "law enforcement" enters the conversation.

- Never tell leadership "we have the evidence" until the image hashes match and the chain of custody form has every signature. *"We're acquiring now, expected completion 0600, image will be hashed and verified before analysis begins"* is the right sentence. Promises about evidence integrity made too early are the ones that come back at the deposition.

## Related concepts

[[Chain of Custody]] · [[Order of Volatility]] · [[Write Blockers]] · [[Hashing and Data Integrity]] · [[Memory Acquisition]] · [[Legal Hold]] · [[Incident Response Lifecycle]] · [[Containment Strategies]] · [[Re-imaging and Recovery]] · [[EDR Network Containment]] · [[Slack Space and Unallocated Space]] · [[Full Disk Encryption]] · [[Evidence Preservation]] · [[NIST SP 800-86]]

*Source: VIRGIL knowledge base — 2026-05-11*