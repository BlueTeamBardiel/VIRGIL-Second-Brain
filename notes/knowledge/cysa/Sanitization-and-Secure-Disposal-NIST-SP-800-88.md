# Sanitization and Secure Disposal (NIST SP 800-88)

## What it is

In **Sonic the Hedgehog 2**, when you finish a Special Stage and grab the Chaos Emerald, the stage doesn't just fade out — the emerald is *gone* from that half-pipe forever. You can't replay the same stage and grab it again. The data is committed, the stage is sanitized, and the next run starts clean. Now imagine the opposite: Sonic loses his rings on a hit, they scatter, blinking, recoverable for about a second before they despawn. That blinking window is exactly what un-sanitized media looks like to a forensic recovery tool. The data is "gone" from the file system, but the rings are still on the floor, still grabbable, until something actually overwrites the sectors.

**Plain English:** Sanitization is making sure that when you throw away a disk, a phone, or a backup tape, no one can read what was on it. Secure disposal is the policy and process around that decision.

**Technical (CS0-003):** [[NIST SP 800-88]] Rev. 1 *Guidelines for Media Sanitization* defines three sanitization categories — **Clear, Purge, Destroy** — and ties the choice to data sensitivity and whether the media leaves organizational control. It's the authoritative reference CompTIA expects you to know by name for **media sanitization** under incident response, decommissioning, and [[data lifecycle management]].

## Why it matters

Decommissioning is where breaches happen quietly. A re-imaged laptop sold on eBay still has the old NTFS data in unallocated sectors. A "wiped" SSD with wear-leveling has remapped blocks the OS can't even see, let alone overwrite. A drive labeled "destroyed" that ended up on a shelf because the shred vendor was late — that's the one that turns into a HIPAA fine.

**Career relevance:** As the L2 analyst or IR lead, you sign off on disposal during [[Containment Eradication Recovery|eradication and recovery]]. You also handle [[Evidence Acquisition|evidence]] disks after a case closes — which means you choose between returning, retaining, or destroying media that may still hold sensitive incident data. Get this wrong and your post-incident report becomes Exhibit A.

**Exam relevance:** CS0-003 Objective **3.2** (incident response activities — eradication, recovery, remediation, re-imaging) and adjacent privacy/data-handling content. CompTIA will name-drop NIST 800-88 and expect you to match the right method (Clear/Purge/Destroy) to the right scenario.

## Key facts

### The three sanitization categories

NIST 800-88 replaces the older DoD 5220.22-M overwrite-pass thinking. The category you pick depends on **data sensitivity** and **whether the media leaves your control**.

| Category | What it does | Recovery resistance | When to use |
|---|---|---|---|
| **Clear** | Logical overwrite using standard read/write commands | Resists keyboard recovery (file undelete, forensic software at the logical layer) | Media stays inside the org, low-to-moderate sensitivity, will be reused |
| **Purge** | Renders recovery infeasible even with state-of-the-art lab techniques | Resists lab-level recovery (electron microscopy, head swaps, controller bypass) | Media leaves the org, moderate-to-high sensitivity, or being reused outside the original trust boundary |
| **Destroy** | Physically renders the media unusable and infeasible to recover | Total — there is no media left | Highest sensitivity, media is end-of-life, or Purge isn't possible (broken drive, unknown controller) |

The hierarchy is one-way: **Destroy > Purge > Clear**. You can always escalate. You cannot downgrade after the fact.

### Clear — the factory reset tier

- Logical overwrite via the OS or firmware (single-pass of zeros or random data is sufficient per 800-88 for modern drives)
- Factory reset on mobile devices (with encryption enabled — see below)
- `dd if=/dev/zero of=/dev/sdX` on a Linux box
- Built-in OS "secure erase" features

*Clear is fine for a laptop being re-imaged and handed to the next employee in the same building. It is not fine for a laptop going to surplus auction.*

### Purge — when the drive is leaving the building

Three Purge methods CompTIA expects you to recognize:

- **Cryptographic erase (CE)** — If the drive is self-encrypting (SED) or full-disk encrypted, you destroy the encryption key. The ciphertext is still on the platters but it's mathematically unrecoverable. Fast, scalable, the modern standard for SSDs. The catch: encryption had to be on *from day one*, with a strong algorithm, and the key destruction has to be verified.
- **Degaussing** — Magnetic field strong enough to scramble the domains on a hard drive platter or tape. Renders the drive permanently inoperable as a bonus. **Does not work on SSDs** — flash isn't magnetic. CompTIA loves this trap.
- **Block erase / ATA Secure Erase** — Drive-firmware command that erases every block including spare/remapped sectors the OS can't see. Critical for SSDs because of wear-leveling.

> **CompTIA exam trap:** Degaussing an SSD does nothing. SSDs use NAND flash, which holds charge in floating-gate transistors — a magnetic field doesn't touch them. For SSDs, you use cryptographic erase, ATA Secure Erase, or physical destruction. If the scenario says "SSD" and the answer says "degauss," it's wrong.

### Destroy — when the drive isn't coming back

- **Shredding** — Mechanical destruction into small fragments. Particle size matters; classified destruction may require fragments ≤2mm.
- **Pulverizing** — Hammer mill or similar, reduces to powder.
- **Incineration** — Licensed facility, high temperature.
- **Disintegration / melting** — Industrial-grade, used for highest classifications.

Destroy is **mandatory** when Purge isn't verifiable — broken drives, unknown firmware, legacy media (floppies, optical), or when policy/regulation demands it (classified, certain healthcare records).

### Validation — sanitization isn't done until it's verified

NIST 800-88 is loud about this: **every sanitization action must be verified, and verification must be documented.** Two layers:

- **Verification of sanitization** — Did the overwrite/erase actually complete on every addressable sector? Sample-check or full-read of the media after the operation.
- **Verification of equipment** — Is the degausser strong enough for this drive's coercivity? Is the shredder producing the required particle size? Is the cryptographic erase function actually destroying the key?

This is your [[Validating Data Integrity|data integrity validation]] for the disposal process. No verification = no sanitization. The certificate of destruction from the vendor is the [[Chain of Custody|chain-of-custody]] artifact you hand to the auditor.

### The disposal decision tree

Three questions, in order:

1. **What's the data sensitivity?** Public, internal, confidential, restricted, regulated (PHI, PCI, CUI, classified).
2. **Will the media leave organizational control?** Reuse internally, reuse externally, donate, sell, return-to-lease, destroy.
3. **Is the media still functional?** Broken drives can't be Cleared or Purged reliably — they go to Destroy.

The output is one of: Clear-and-reuse, Purge-and-release, or Destroy.

### Sanitization in the IR lifecycle

This is where CompTIA bridges 800-88 into Objective 3.2:

- **Detection & Analysis** — You acquire forensic images of compromised hosts. Those images contain malware, credentials, and sensitive data. Treat them like evidence.
- **Containment** — Isolated host's drive may need to be preserved as evidence (legal hold) before any sanitization decision.
- **Eradication** — **Re-imaging** is the most common eradication path: sanitize the affected drive (Clear minimum, Purge if leaving), then deploy a known-good gold image. For [[Rootkit|firmware-level compromise]] or [[UEFI Bootkit|UEFI bootkits]], Clear isn't enough — you need Purge or hardware replacement.
- **Recovery** — Drives used for forensic copies eventually get repurposed or destroyed. They cannot be returned to general pool without Purge minimum, because they hold incident artifacts.
- **Post-incident** — Forensic images get retained per legal/retention policy, then sanitized per 800-88 with a [[Certificate of Destruction]].

### Legal hold trumps sanitization

If the data is under **legal hold** — pending litigation, regulatory investigation, subpoena — you **do not sanitize**. Period. Sanitizing media under legal hold is spoliation of evidence, which carries fines and adverse inference rulings. Legal hold is released in writing by counsel. Until then, the drive sits in the evidence locker.

> **CompTIA exam trap:** Re-imaging is **eradication**, not sanitization. Re-imaging overwrites the OS partition with a clean image but typically leaves data partitions, firmware, and unallocated space untouched. If the threat persists in firmware or in unaddressed sectors, re-imaging alone fails. The correct sequence is: acquire evidence → sanitize (Clear/Purge per policy) → deploy gold image → validate.

### Compensating controls when you can't sanitize properly

Sometimes you can't. Drive is in a sealed appliance, vendor won't release firmware tools, lease contract requires return-as-is, drive is physically failed and can't accept commands. [[Compensating Controls]]:

- Full-disk encryption from day one (so end-of-life is just key destruction)
- Tamper-evident packaging on returned media with vendor attestation
- Physical destruction by certified vendor with witnessed destruction and video
- Encrypted-at-rest policy enforced at provisioning, audited annually

*The lesson that costs you a finding: if you didn't encrypt the drive on day one, you don't have cryptographic erase as an option on day 1,825. Plan disposal at provisioning.*

## SOC reality

- **The 3am ticket isn't about sanitization** — but the 9am call from the asset disposal vendor is. "We received drives marked 'sanitized' from your shipment but three of them mount and have user data. What do you want us to do?" That's a reportable incident and you own it.
- **L1 doesn't make the disposal call.** L1 acquires, preserves, and hands off. The disposal decision (Clear/Purge/Destroy) lives with IR lead or the data owner, often with legal in the loop if it touches regulated data.
- **The CISO will ask:** "Do we have a Certificate of Destruction for every drive from the breached cluster? Who signed it? When? Show me the chain of custody from the rack to the shredder." If you can't produce the document, it didn't happen.
- **Never promise** "the data is gone" until you have verification artifacts in hand. "Sanitization in progress" and "sanitization verified and certified" are two different statuses. Auditors and regulators only count the second one.
- **Handoff point:** SOC → IR → asset management → certified disposal vendor → legal review of disposal records. The SOC's job is to flag which assets touched the incident; the chain after that is operational, but you'll be asked to attest to scope.

## Related concepts

[[NIST SP 800-88]] · [[Chain of Custody]] · [[Evidence Acquisition]] · [[Validating Data Integrity]] · [[Containment Eradication Recovery]] · [[Legal Hold]] · [[Re-imaging]] · [[Compensating Controls]] · [[Data Lifecycle Management]] · [[Certificate of Destruction]] · [[Full-Disk Encryption]] · [[Self-Encrypting Drive]] · [[Cryptographic Erase]] · [[Forensic Acquisition]] · [[Post-Incident Activity]]

*Source: VIRGIL knowledge base — 2026-05-11*