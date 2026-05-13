# Chain of Custody

## What it is

In **The Witcher 3**, Geralt walks into a room where a noble has been murdered. He pulls out his medallion, switches to Witcher Senses, and the world goes grey-blue. Bloodstains glow red. A wine goblet pulses. Footprints lead to a window. He examines each clue — *bloody handprint, left-handed, fresh*; *crossbow bolt, dwarven make, fired from the courtyard* — and the game logs every finding in his journal with a timestamp. Later, when he accuses the killer in front of the Baron, the journal is what makes the accusation stick. If Geralt had picked up the goblet, put it down, wandered off, come back, and picked it up again without the medallion's log, the Baron would laugh him out of the keep.

That journal is chain of custody. Every piece of evidence collected during an incident — a memory dump, a disk image, a router config, a USB drive pulled from a desk — gets a documented record of **who touched it, when, where it was stored, and what was done to it**. Every transfer is signed. Every gap is a defense lawyer's Christmas present.

Technically: chain of custody is the chronological, signed documentation trail proving that digital or physical evidence was preserved in an unaltered state from the moment of collection through analysis, storage, and presentation. CompTIA frames it as a core component of **evidence acquisition and preservation** under Objective 3.2.

## Why it matters

Incidents end up in three places: the post-incident review, the regulator's inbox, or a courtroom. The first one is forgiving. The other two are not.

If your org gets breached and you want to sue the threat actor, prosecute an insider, claim cyber insurance, or defend against a regulator's fine — the evidence has to survive a hostile lawyer asking *"how do we know this disk image wasn't tampered with between 2am Tuesday and the day you handed it to the FBI?"* If you can't answer with a signed log, the evidence gets thrown out and your case dies.

On the exam, CompTIA tests this hard because candidates conflate "we have the evidence" with "the evidence is admissible." Those are different things. A perfect forensic image with a broken custody log is worthless in court.

Career-wise: chain of custody is one of the cleanest dividing lines between a help-desk-grade responder and an actual IR analyst. Junior folks grab the laptop. Seniors document the grab.

## Key facts

### What chain of custody documents

Every entry in the log answers four questions:

| Field | What it captures |
|---|---|
| **Who** | Full name, role, organization of every person who handled the evidence |
| **What** | Description of the item — make, model, serial number, hash value for digital evidence |
| **When** | Date and time of every transfer, examination, or storage event (timezone explicit) |
| **Where** | Physical location — evidence locker, lab bench, courier transit, sealed bag #X |
| **Why** | Purpose of the transfer or action (acquisition, analysis, transport to lab) |
| **How** | Method used — write blocker model, imaging tool (dd, FTK Imager, Guymager), hash algorithm |

Every transfer is a signature. Both parties sign — the one releasing custody and the one accepting it. No exceptions. A handoff without two signatures is a broken chain.

### The custody form

A physical or digital form follows the evidence everywhere. Common name: **Evidence Custody Document** or **CoC Form**. It typically includes:

- Case number and incident ID
- Item number (each piece of evidence gets a unique ID)
- Description and identifying marks
- Cryptographic hash (MD5, SHA-1, SHA-256) for digital evidence — captured at acquisition and re-verified at every analysis
- Tamper-evident seal numbers (for physical media in sealed bags)
- Signature rows for every transfer

### Validating data integrity

For digital evidence, the chain isn't just about who carried the disk — it's about proving the bits didn't change. That's hashing.

- **At acquisition**: image the disk through a [[write blocker]], compute a SHA-256 hash of the image, write it down in the custody log.
- **Before analysis**: re-hash the working copy. Hash matches → integrity preserved. Hash differs → the evidence is contaminated, the chain is broken, you start over from the original (which is why you always work from copies, never the original).
- **At presentation**: hash one more time. The number on the courtroom display matches the number on the custody form from acquisition night.

MD5 and SHA-1 still appear in legacy tools, but SHA-256 is the modern default. Collision attacks on MD5 are practical — a defense lawyer who knows what they're doing can argue the hash is meaningless. Use SHA-256.

### Where chain of custody fits in the IR lifecycle

CompTIA's four-phase lifecycle (NIST SP 800-61):

1. **Preparation** — custody forms pre-printed, evidence bags stocked, write blockers tested, the lab's locker has a working lock.
2. **Detection and Analysis** — the moment you decide an alert is a real incident, custody starts. The first analyst to touch the affected endpoint signs the first row.
3. **Containment, Eradication, and Recovery** — [[isolation]] of the host preserves evidence; [[re-imaging]] destroys it. Image **before** you re-image. [[Compensating controls]] (network ACLs, EDR quarantine) hold the line while acquisition runs.
4. **Post-incident Activity** — evidence sits in the locker for years. Custody log keeps growing every time someone pulls it for review.

### Legal hold

When litigation is anticipated — internal investigation, regulator inquiry, lawsuit — **legal hold** kicks in. Legal counsel issues a formal notice that suspends normal data retention and deletion. Backups don't roll off. Mailboxes don't auto-purge. Logs don't get rotated out.

Legal hold is upstream of chain of custody. Hold says *"preserve this data."* Chain of custody says *"and here's the documented proof we did."* You need both. A hold without custody documentation is half a defense.

### Preservation order

Evidence is collected most-volatile-first. RFC 3227 order:

1. CPU registers, cache
2. RAM (live memory capture)
3. Network state (ARP cache, routing table, open connections)
4. Running processes
5. Temporary file systems
6. Disk
7. Remote logging and monitoring data
8. Physical configuration, network topology
9. Archival media

Each acquisition gets its own custody entry. The memory dump is one item. The disk image is another. They share a case number but have separate item IDs.

### CompTIA exam traps

> **CompTIA exam trap:** *"The disk was imaged with FTK Imager and stored on a shared analyst drive."* — Wrong answer, even if every other step was correct. Evidence on a shared drive has no custody. Anyone with access could modify it. Evidence lives in a controlled location (evidence locker, encrypted forensic share with access logging) with documented retrievals.

> **CompTIA exam trap:** *"Hashes were taken at acquisition and again at court."* — Sounds complete. It's not. Hashes must be re-verified at **every** examination, not just the endpoints. A six-month gap with no integrity check is a six-month gap a lawyer will walk through.

> **CompTIA exam trap:** Chain of custody vs. legal hold. They are not synonyms. Legal hold preserves the data from deletion. Chain of custody documents the handling of evidence already collected. CompTIA will write a question where the right answer is "legal hold" and the trap is "chain of custody," or vice versa.

> **CompTIA exam trap:** Re-imaging the host before acquisition. CompTIA loves this scenario — a junior analyst, eager to restore service, re-images the compromised endpoint. [[Scope]] is now unknowable, [[impact]] is now unknowable, and the [[indicators of compromise]] are gone. Always acquire before you remediate.

### Common ways the chain breaks

- **Unwitnessed handoff** — one signature instead of two. The accepting party didn't sign. Chain broken at that row.
- **Gap in time** — evidence was "in the lab" from Friday to Monday with no entries. Defense argues anyone could have walked in.
- **Hash mismatch** — working copy doesn't match acquisition hash. Either the copy was corrupted or the original was modified. Either way, integrity is gone.
- **Original used for analysis** — you analyze copies, never originals. An analyst who runs tools against the original disk has just modified the evidence.
- **Storage without access logging** — locker has a key but no sign-in sheet. Who entered, when, why? No answer = no chain.
- **Personal device involvement** — an analyst takes the USB drive home "to work on it." Chain dies the second it crosses the office door without documentation.

## SOC reality

- The L1 analyst who finds the actual incident is usually the person who starts custody — and often the one who breaks it. *"I just plugged it into my workstation to take a quick look"* is the most expensive sentence in IR. Train the L1s to stop, document, and call a senior before they touch anything.
- The CISO's first three questions during an active incident: **scope, impact, evidence preserved?** The third one is where careers are made or ended. Saying *"we have full forensic captures with hash verification"* buys you the room. Saying *"we re-imaged it"* loses it.
- At 3am, the dashboard does not show chain of custody. It shows alerts. The custody work happens off-screen — pre-printed forms in the IR runbook binder, the locked cabinet next to the SOC, the encrypted evidence share with MFA-gated access. If your IR program doesn't have those staged before an incident, you don't have an IR program.
- Never promise leadership *"the evidence will hold up in court."* That's legal counsel's call, not yours. Promise: *"acquisition followed documented procedure, hashes verified, custody log intact."* That's the truth you can defend.
- Handoff to law enforcement or external IR firms is its own custody event. Two signatures, sealed transport, hash re-verification on arrival. The FBI does not accept evidence on a USB stick handed to an agent in a parking lot. *Document the handoff like a wedding ceremony.*

## Related concepts

[[Evidence acquisition]] · [[Write blocker]] · [[Forensic imaging]] · [[Legal hold]] · [[Data integrity]] · [[Hashing (MD5, SHA-256)]] · [[Order of volatility]] · [[Isolation]] · [[Re-imaging]] · [[Compensating controls]] · [[Scope and impact]] · [[Incident response lifecycle]] · [[Post-incident activity]] · [[NIST SP 800-61]] · [[Indicators of compromise]]

*Source: VIRGIL knowledge base — 2026-05-11*