# Building a Forensics Capability

## What it is

In **Gran Turismo**, before you ever queue for a license test, you walk through the garage. The car is up on the lift. The tire pressure gauge is calibrated. The brake balance is set. The replay theatre is wired so you can scrub frame-by-frame through the apex and prove — to yourself, to the leaderboard, to anyone watching — that you took the corner clean and didn't cut the chicane. The tools matter. The discipline of using them matters more. Without that pre-race garage work, your fastest lap is just a number nobody will certify.

That's exactly what a forensics capability is — the garage you build *before* the incident, so that when something hits, the evidence you collect can survive scrutiny.

Technically: a **forensics capability** is the standing combination of hardware, software, trained personnel, documented procedures, and legal frameworks that an organization maintains to acquire, preserve, analyze, and present digital evidence in a manner that is **forensically sound** — meaning the original data is unaltered, the copy is verifiably identical, and the chain of custody is unbroken from acquisition through courtroom.

A SOC analyst *uses* forensic tools. A forensic analyst is responsible for **evidence defensibility**. Two different jobs. Same toolbox. Wildly different stakes.

## Why it matters

CySA+ Objective **3.2** expects you to perform IR activities including **evidence acquisition, chain of custody, validating data integrity, preservation, and legal hold**. Every one of those is meaningless without a pre-built capability.

Real stakes: an incident that ends in litigation, insurance claim, regulatory penalty, or law enforcement referral lives or dies on whether you can prove the disk image you handed over is bit-identical to the disk that was in the laptop on the day of compromise. Skip a write blocker, miss a hash, lose a custody signature, and a defense attorney makes the evidence inadmissible. The breach happened. You just can't prove it the way a court needs you to.

Career angle: forensic-capable analysts are rare and expensive. SOC L2/L3 roles that touch IR almost always require you to know what the [[Forensic Workstation]] does, why a [[Write Blocker]] is non-negotiable, and what makes a [[Chain of Custody]] form hold up.

## Key facts

### The hardware tier

| Component | Job | Why it matters |
|---|---|---|
| **Forensic workstation** | Isolated, high-spec analysis box | Air-gapped or segmented; never touches production. Heavy RAM, fast storage, multiple drive bays |
| **Write blocker** | Hardware or software intermediary that allows reads from evidence media but blocks all writes | Without it, the OS auto-mounts the drive, updates timestamps, and you've altered evidence on contact |
| **Forensic duplicator** | Dedicated imaging hardware (e.g., Tableau, Logicube class) | Bit-for-bit clone at speed, with on-device hashing |
| **Clean storage media** | Sanitized destination drives, pre-wiped and verified | Prevents cross-contamination from a previous case's residual data |
| **Faraday bag / signal isolation** | RF-blocking enclosure for mobile devices | Stops remote wipe, prevents network beaconing during transport |
| **Tamper-evident bags + labels** | Sealed evidence packaging | Physical chain of custody — if the seal is broken, somebody touched it |

### The software tier

- **Imaging**: FTK Imager, dd, dcfldd, Guymager — produce raw (.dd), E01 (EnCase), or AFF format images
- **Analysis suites**: Autopsy, EnCase, X-Ways, Magnet AXIOM
- **Memory forensics**: Volatility, Rekall — RAM is volatile; capture it *first* if the box is live
- **Hashing**: MD5 + SHA-256 at minimum. MD5 is broken cryptographically but still used as a corroborating integrity check alongside SHA-256
- **Timeline tools**: Plaso/log2timeline for super-timeline reconstruction across artifacts

### The procedural tier — order of volatility

When acquiring evidence from a live system, capture in order of **most volatile → least volatile**. Miss the order and you lose data that will never come back:

1. CPU registers, cache
2. Routing table, ARP cache, process table, kernel statistics, **RAM**
3. Temporary file systems
4. Disk
5. Remote logging / monitoring data
6. Physical configuration, network topology
7. Archival media

*Pulling the power cable on a running box destroys everything above the disk line. Sometimes that's the right call — usually it's not.*

### Chain of custody — the paperwork that wins cases

Every transfer of evidence is logged: **who, what, when, where, why**. The form tracks the item from seizure through every analyst's hands, every storage location, every courtroom, and back to disposition.

Required fields on every entry:
- Item description + unique evidence number
- Date/time of transfer
- From whom → to whom (with signatures)
- Purpose of transfer
- Storage location and conditions
- Hash values at time of acquisition (and re-verified at each major handling)

Break the chain — one missing signature, one unexplained gap — and the defense argues the evidence was tampered with. The judge often agrees.

### Validating data integrity

The acquisition workflow:

1. Attach evidence drive through **write blocker**
2. Hash the source drive (SHA-256)
3. Image the drive to clean destination media
4. Hash the resulting image
5. **The two hashes must match.** If they don't, the image is invalid — start over
6. Work from a *second* copy. The original image is the master; you never analyze it directly
7. Re-hash periodically to prove no drift during analysis

This is the forensic equivalent of the GT replay file: deterministic, reproducible, byte-identical, defensible.

### Legal hold

A **legal hold** is a formal notice — usually from counsel — that suspends normal data retention and destruction policies because litigation or investigation is reasonably anticipated. Once a hold is in place:

- Backup rotation policies stop overwriting relevant tapes
- Email auto-delete is paused for custodians named in the hold
- Endpoints flagged for preservation cannot be re-imaged, decommissioned, or wiped
- Logs that would normally roll off after 30/90 days are preserved

A legal hold predates any subpoena. Once counsel sends the notice, **destroying covered data is spoliation** — sanctionable in court, sometimes criminally.

### CompTIA exam traps

> **CompTIA exam trap:** "Pull the network cable" is **isolation/containment**, not preservation. Preservation is the imaging+hashing step. CompTIA will phrase the question around what action you take and which IR phase it lives in. Containment ≠ acquisition ≠ preservation, even though they happen close together.

> **CompTIA exam trap:** SOC analyst vs forensic analyst. The SOC analyst *triages and escalates*. The forensic analyst *preserves and testifies*. If the question asks who is responsible for evidence defensibility in court, the answer is the forensic analyst — even if the SOC L2 was the one who pulled the initial image.

> **CompTIA exam trap:** Re-imaging a compromised host during recovery is **destructive to evidence**. Always image first, then re-image. CompTIA will hand you a scenario where the ops team wants the box back in production and the IR team isn't done — the right answer is preserve before you wipe, and use **compensating controls** (network segmentation, additional monitoring) if the business pressure to restore service is real.

> **CompTIA exam trap:** Hash mismatches. If acquisition-time hash ≠ verification-time hash, the image is **not forensically sound**. CompTIA loves this as a one-line scenario question — the answer is never "proceed anyway."

### Where this lives in the IR lifecycle

| Phase | What forensics capability does |
|---|---|
| **Preparation** | Build the capability — workstations, write blockers, training, retainer with outside counsel, vendor relationships |
| **Detection & Analysis** | Acquire memory, disk, logs. Hash everything. Begin chain of custody. Determine **scope** (what's affected) and **impact** (what's the damage) |
| **Containment, Eradication, Recovery** | **Isolation** of affected hosts before eradication. Preserve images *before* re-imaging. Apply **compensating controls** when full remediation isn't immediate |
| **Post-incident** | Forensic timeline becomes the basis of the lessons-learned report and any legal proceedings |

## SOC reality

- The 3am alert fires. The L1 analyst pulls the EDR timeline, sees credential dumping behavior on a finance workstation, and escalates. The L2 makes the call: **do not log into the box, do not let IT re-image it, do not pull the cable yet.** First action is to notify IR lead and start the acquisition checklist.
- The CISO's first three questions, in order: **"What's the scope? What's the impact? Is evidence preserved?"** If you can't answer the third one yes, you don't answer the first two — you go preserve, then come back.
- Never promise containment until the image is taken, the hashes match, and chain of custody is signed. "We've isolated the host" and "we've preserved evidence" are two separate sentences. Leadership will conflate them. You will not.
- The handoff: L1 detects → L2 triages and decides preservation strategy → IR team or external DFIR retainer performs acquisition → Legal places the hold → Forensic analyst owns the image from that moment forward. Each step has a paper trail.
- Tabletop the workflow before you need it. The first time you fumble with a write blocker should not be during an active ransomware event. *I learned this the hard way during a tabletop — the write blocker firmware was out of date and the destination drive wasn't pre-wiped. Forty minutes lost. In a real incident those forty minutes are exfil minutes.*
- 80% of incidents never go to court. The 20% that do will absolutely scrutinize whether you followed the procedure on the 80% that didn't. **Treat every acquisition like it's headed to a deposition.** Because the one that does, will be.

## Related concepts

[[Chain of Custody]] · [[Write Blocker]] · [[Forensic Workstation]] · [[Order of Volatility]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[Data Integrity Validation]] · [[Hashing - MD5 SHA-256]] · [[Memory Forensics]] · [[Disk Imaging]] · [[Incident Response Lifecycle]] · [[Containment Eradication Recovery]] · [[Compensating Controls]] · [[Re-imaging]] · [[Isolation]] · [[Scope and Impact Analysis]] · [[SOC Tiers - L1 L2 L3]] · [[DFIR]] · [[Spoliation]]

*Source: VIRGIL knowledge base — 2026-05-11*