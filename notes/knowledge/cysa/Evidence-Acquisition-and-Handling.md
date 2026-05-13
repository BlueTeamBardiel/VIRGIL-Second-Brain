# Evidence Acquisition and Handling

## What it is

In **Bioshock**, when you find a corpse in Rapture you don't just loot it and walk off — you pull out the camera, snap research photos of the Splicer, the ADAM trail, the audio diary it dropped, the way the body fell. Every frame goes into the research log. Skip the photo, and you lose damage bonuses against that enemy type forever. Skip the audio diary, and you never learn that Suchong was the one who designed the trigger phrase. The evidence is volatile — Splicers respawn, corpses despawn, the room reconfigures — so you capture it in the right order, label it, and store it before it's gone.

That's exactly what evidence acquisition and handling does — when an incident hits, you preserve the volatile artifacts in a defensible order before containment or recovery destroys them, and you document every hand-off so the evidence holds up later.

**Technical definition (CS0-003):** Evidence acquisition is the process of identifying, collecting, and preserving digital artifacts during incident response in a manner that maintains integrity, supports forensic analysis, and meets legal admissibility standards. Handling covers everything after acquisition — storage, transport, chain of custody, integrity validation, and disposition.

## Why it matters

Evidence is the difference between "we think the attacker did X" and "we can prove the attacker did X, at this timestamp, on this host, with this hash." Without acquisition discipline, you can't do root cause analysis, can't support litigation or law enforcement referral, can't satisfy regulators, and can't defend the IR team's actions in the post-incident review when leadership asks why you reimaged the box before you imaged it.

This is **CS0-003 Objective 3.2** territory — Given a scenario, perform incident response activities. CompTIA tests the order of volatility, chain of custody mechanics, legal hold triggers, and the tension between containment and preservation. They will write a scenario where you're tempted to reimage immediately and ask which step you missed.

In a real career, this is where junior analysts get burned. The instinct is to fix the problem fast. The discipline is to capture the scene first, then fix.

## Key facts

### Where acquisition sits in the IR lifecycle

NIST SP 800-61 / CompTIA four-phase model:

1. **Preparation** — write playbooks, pre-stage tools (FTK Imager, dd, Volatility, write blockers), train analysts on chain of custody forms
2. **Detection and Analysis** — IoCs surface, you confirm the incident, **acquisition starts here**
3. **Containment, Eradication, and Recovery** — acquisition continues *before* eradication destroys artifacts
4. **Post-incident Activity** — evidence supports root cause analysis and lessons learned

Acquisition is not a phase. It's a thread running through Detection, Containment, and Eradication. The moment you confirm an incident, the evidence clock starts.

### Order of volatility (RFC 3227)

The cardinal rule. Collect most volatile first, least volatile last:

| Tier | Artifact | Lifetime |
|------|----------|----------|
| 1 | CPU registers, cache | nanoseconds |
| 2 | RAM (memory dump), running processes, network connections | until power loss |
| 3 | Temp files, swap, page file | until reboot or overwrite |
| 4 | Disk (logical files, then full image) | until wipe |
| 5 | Remote logging, SIEM, archived data | retention policy |
| 6 | Physical configuration, network topology | static |

Pull the memory dump *before* you yank the network cable. Pull the network state *before* you power the box down. Power-down kills tiers 1–3 instantly. Get the volatile stuff or accept you'll never have it.

### Chain of custody — the paper trail

Every piece of evidence needs a chain-of-custody form that documents:

- **What** — description, serial number, hash (SHA-256 minimum, MD5 + SHA-256 is common belt-and-suspenders)
- **Who** — collector name, every subsequent custodian
- **When** — timestamp of collection and every transfer
- **Where** — location of collection, storage location, transport path
- **Why** — purpose of each transfer (analysis, court, return)
- **How** — tool used (write blocker model, imaging software + version)

Every transfer is a signature. Two people sign — releasing custodian and receiving custodian. A gap of even one transfer can get the evidence thrown out in court or challenged in arbitration.

> **CompTIA exam trap:** Chain of custody is about *continuity*, not security. CompTIA will offer "the evidence was encrypted" as a chain-of-custody answer. Wrong. Encryption is integrity/confidentiality. Chain of custody is the unbroken log of who handled what, when, and why. They are separate controls that both have to be in place.

### Validating data integrity

The hash is the evidence's fingerprint. Workflow:

1. Acquire image with a **write blocker** (hardware preferred — Tableau, WiebeTech) so the source disk cannot be modified
2. Compute hash of the source media (when feasible — sometimes you only get the image)
3. Compute hash of the acquired image
4. **Hashes match** — image is forensically sound
5. Re-hash before every analysis session and confirm it still matches the acquisition hash
6. Work on a **copy of the image**, never the original. Original goes in the safe.

If the hash changes at any point, the integrity chain is broken and the analysis is no longer defensible. SHA-256 is the modern default. MD5 is collision-broken but still appears in legacy workflows for cross-checking.

### Common evidence artifacts

| Artifact | Tool | Volatility |
|----------|------|------------|
| Memory dump | FTK Imager, WinPMem, LiME, Volatility for analysis | High |
| Disk image (bit-for-bit) | dd, dcfldd, FTK Imager, EnCase | Low |
| Network capture | Wireshark, tcpdump, Zeek | High (live) / Low (saved pcap) |
| System logs | Native (Event Viewer, journalctl), SIEM export | Medium |
| Authentication logs | DC security logs, IdP logs, SIEM | Medium |
| Malware sample | Isolated transfer to sandbox (Cuckoo, hybrid-analysis) | Low — but handle carefully |
| Cloud artifacts | CloudTrail, Unified Audit Log, API exports | Medium — vendor retention applies |

### Legal hold

The moment an incident has potential litigation, regulatory, or law enforcement implications, **legal hold** triggers. Legal hold is a directive — usually from General Counsel — that suspends all routine data destruction for relevant systems and data.

- Email retention auto-delete? Suspended.
- Log rotation purging 90-day-old SIEM data? Suspended.
- The user's laptop scheduled for reimage? Held.

Legal hold often arrives *after* the IR team has started moving. If you reimaged a host before legal hold landed and that host turns out to be material to a lawsuit, the company has a spoliation problem. **Hold the image, hold the memory dump, hold the logs — don't return them to the pool until counsel says clear.**

### Scope, impact, isolation, preservation — the containment trade-off

CompTIA loves the tension between containment and preservation. The IR lead's call:

- **Scope** — how many hosts, accounts, network segments are affected?
- **Impact** — what's the business consequence (data exfil, ransomware, BEC)?
- **Isolation** — pull the host off the network (VLAN quarantine, EDR network containment, physical disconnect)
- **Preservation** — capture volatile state *before* isolation kills it

The right order: **memory dump → network state capture → isolate → disk image**. Wrong order: isolate first, lose RAM, lose live connections, lose the C2 channel you were about to fingerprint.

*I learned this the hard way watching a junior analyst yank the cable on a beaconing host before anyone grabbed the memory dump. We lost the in-memory malware payload that never touched disk. Took three days to recover the IoC from another victim's box.*

### Re-imaging vs preservation

Re-imaging the host is recovery. Imaging the host is preservation. They are not the same word.

- **Imaging** = creating a forensic copy *before* you touch the system. Bit-for-bit. Write blocker. Hash verified.
- **Re-imaging** = wiping the system and laying down a clean gold image to return it to service.

You always image **before** you reimage. If you reimage first, you've destroyed the evidence and your root cause analysis is now guesswork.

### Compensating controls during preservation

Sometimes you can't pull a system offline — it's a production database, a clinical workstation, an ICS controller. You preserve evidence with **compensating controls**:

- Heightened monitoring (EDR in detect-and-alert mode, full pcap on the segment)
- Network microsegmentation to limit blast radius without full isolation
- Account lockdown for the compromised identity while the host stays up
- Snapshot the VM rather than imaging the live disk

The compensating control acknowledges you can't do the ideal thing, so you do the next-best thing and document why.

### CompTIA exam traps

> **CompTIA exam trap — order of operations:** The question gives you a scenario where the analyst pulls the network cable, then takes a memory dump. The answer is *the analyst destroyed volatile evidence*. Memory comes before isolation. Always.

> **CompTIA exam trap — write blocker direction:** Hardware write blockers prevent writes *to the source*. They do not prevent reads. Cheap question, often missed because the wording inverts.

> **CompTIA exam trap — legal hold scope:** Legal hold is not just about the suspect host. It covers all data *reasonably likely to be relevant*. CompTIA will offer "only the compromised endpoint" — wrong. Email of the affected users, log archives, backup tapes — all in scope.

> **CompTIA exam trap — chain of custody starts when?** Not when evidence reaches the lab. Chain of custody starts at the *moment of collection*. The first responder is the first link.

## SOC reality

- The 3am alert fires on a beaconing host. L1 acknowledges in the SIEM, opens a ticket, and **does not** click "isolate" in the EDR. Their first move is to ping the on-call IR lead and ask "do we have authority to image?" — because once you isolate, the volatile stuff is gone.
- IR lead's first three questions: **scope (how many hosts), evidence preserved (memory dump done?), legal hold status (has counsel been notified?)**. If you can't answer all three, you're not ready to brief leadership.
- Never tell the CISO "we've contained it" until the disk image is hashed, the memory dump is stored, and the chain-of-custody form has two signatures. Containment without preservation is the move that ends careers when the lawsuit lands six months later.
- Handoff chain: **L1 detects → L2 confirms and starts acquisition → IR team runs the playbook → Legal triggers hold → Forensics analyzes the image → Leadership briefed with timeline + scope + impact.** Every handoff is a chain-of-custody signature if evidence transfers with it.
- The artifact you didn't capture is the question you can't answer in the post-incident review. *Always grab more than you think you need. Storage is cheap. Re-running an incident is not.*

## Related concepts

[[Chain of Custody]] · [[Order of Volatility]] · [[Disk Imaging]] · [[Memory Forensics]] · [[Write Blockers]] · [[Legal Hold]] · [[Incident Response Lifecycle]] · [[Containment Strategies]] · [[Root Cause Analysis]] · [[Compensating Controls]] · [[Data Integrity Validation]] · [[Forensic Tools]] · [[IoC Analysis]] · [[Post-incident Activity]]

*Source: VIRGIL knowledge base — 2026-05-11*