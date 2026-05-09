# Digital Forensics

## What it is

In Skyrim, after a dragon torches a village, you find scorched bones, a half-burned journal, claw marks on the cobblestones, and a witness who swears it was Alduin. You don't just kill the next dragon — you reconstruct what happened, in order, without disturbing the scene, because the Greybeards will want a coherent story. That's exactly what **digital forensics** does — it reconstructs a security incident from preserved evidence so the story holds up under scrutiny.

**Digital forensics** is the structured process of identifying, preserving, collecting, analyzing, and reporting on digital evidence in a manner that maintains its integrity and admissibility for legal, regulatory, or internal proceedings.

## Why it matters

If you mishandle evidence, the attacker walks, the insurance claim dies, and the regulator fines you anyway. Forensics is the bridge between "we got hacked" and "we can prove who, how, and what they touched" — without it, incident response is just guessing with extra steps. SY0-701 Objective 4.8 explicitly requires you to know **legal hold**, **chain of custody**, **acquisition**, **reporting**, **preservation**, and **e-discovery**, and CompTIA's favorite trap is mixing up the *order of volatility* (CPU registers first, archived data last) and confusing **chain of custody** (documenting who touched the evidence) with **legal hold** (the obligation to preserve it).

## Key facts

### The forensic process

| Phase | What happens |
|---|---|
| **Identification** | Determine what's relevant — systems, logs, users, timeframes |
| **[[Preservation]]** | Stop the bleeding without destroying evidence; isolate, don't power off blindly |
| **[[Collection]] / [[Acquisition]]** | Capture bit-for-bit copies; never analyze the original |
| **[[Analysis]]** | Reconstruct the timeline, identify [[Indicators of Compromise]] |
| **[[Reporting]]** | Document findings in a form a court or auditor can use |

### Order of volatility (memorize this)

From most volatile (grab first) to least:

1. **CPU registers, cache**
2. **RAM** ([[Memory dump]] / [[volatile memory]])
3. **Network state** — routing tables, ARP cache, active connections
4. **Running processes**
5. **Temporary files, swap/pagefile**
6. **Disk** (HDD/SSD)
7. **Remote logging and monitoring data**
8. **Physical configuration, network topology**
9. **Archival media** (backups, tapes)

CompTIA loves asking what you collect *first*. Answer: whatever dies fastest when the plug is pulled.

### Chain of custody

- Documents **who** collected, **what** was collected, **when**, **where**, **why**, and **how** — plus every transfer of possession.
- A break in chain of custody = evidence inadmissible. The attacker says "thank you" and goes home.
- Typically a paper or digital form attached to each evidence item with hash values ([[MD5]] / [[SHA-256]]) recorded at collection.

### Acquisition methods

| Method | Use case |
|---|---|
| **[[Disk imaging]]** (bit-for-bit) | Tools: `dd`, FTK Imager, EnCase. Produces a forensic image with a hash. |
| **[[Memory acquisition]]** | Tools: Volatility, WinPmem, LiME. Captures running processes, encryption keys, injected malware. |
| **[[Live acquisition]]** | System is running; necessary for volatile data and full-disk-encrypted systems |
| **[[Static acquisition]]** | System is off; cleaner but loses volatile evidence |
| **[[Write blocker]]** | Hardware/software device that prevents any writes to the source media during imaging |

### Hashing and integrity

- Hash the evidence **before** and **after** acquisition. Matching hashes = bit-perfect copy.
- **[[SHA-256]]** preferred; **[[MD5]]** still widely used in forensic tools for legacy reasons.
- Any hash mismatch and the evidence is questionable.

### Legal hold and e-discovery

- **[[Legal hold]]**: A formal notice requiring an organization to **preserve** all potentially relevant data (emails, documents, logs) when litigation is anticipated. Auto-deletion policies must be suspended.
- **[[E-discovery]]** (electronic discovery): The process of identifying, collecting, and producing electronically stored information (ESI) in response to a legal request.
- Failure to honor legal hold = **spoliation of evidence** = sanctions, adverse inference, fines.

### Reporting

- Must be **reproducible** — another examiner following your steps gets the same result.
- Includes tools used (with versions), hashes, timeline, methodology, and findings.
- Distinguish **facts** ("hash X was found at offset Y") from **opinion** ("this suggests lateral movement").

### Common artifacts examined

- **Windows**: Registry hives, Event Logs (.evtx), Prefetch, Shimcache, MFT, USN journal, `$Recycle.Bin`
- **Linux**: `/var/log/`, bash history, `/tmp`, cron jobs, systemd journals
- **Network**: PCAP captures, NetFlow, firewall logs, DNS query logs
- **Cloud**: API logs (CloudTrail, Azure Activity Log), provider must cooperate — you don't own the disk

### Cloud forensics complications

- You can't image a hypervisor you don't own.
- **Right-to-audit clauses** in contracts determine what you can demand.
- **Jurisdiction** matters — data in Ireland is governed by Irish/EU law, not yours.
- Provider's [[shared responsibility model]] dictates what evidence they'll hand over.

## Related concepts

[[Incident Response]] · [[Chain of Custody]] · [[Legal Hold]] · [[E-discovery]] · [[Order of Volatility]] · [[Disk Imaging]] · [[Write Blocker]] · [[SHA-256]] · [[Memory Forensics]] · [[Indicators of Compromise]] · [[Spoliation]] · [[Right-to-Audit]]

---
*Source: VIRGIL knowledge base — 2026-05-08*