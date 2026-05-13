# Hashing and Data Integrity

## What it is

In **World of Warcraft**, every item in your bags has a unique server-side ID. When a GM investigates a duped legendary, they don't eyeball the icon — they pull the item GUID and compare it against the loot table entry from the boss kill. If the GUIDs match the audit trail, the item is legit. If two characters are holding items with the same GUID, or the GUID doesn't trace back to a real kill event, you've got a dupe and someone's account is about to get the ban hammer. The GUID is a fingerprint — change one bit of the item and you get a different ID, and the inventory ledger screams.

That's exactly what hashing does for digital evidence — it generates a unique fingerprint of a file or disk image, and any change to the bits produces a wildly different fingerprint.

**Technical definition:** A cryptographic hash function takes input of any size and produces a fixed-length output (the digest). For the same input, you always get the same output. For different inputs, you should get different outputs (collision resistance). You cannot reverse the digest back to the input (preimage resistance). In incident response, hashing proves [[Chain of custody|chain of custody]] integrity — that the [[Evidence acquisition|evidence]] you analyzed and presented in court is bit-for-bit identical to what you pulled off the compromised host.

## Why it matters

Without hashing, your forensic case is worthless. A defense attorney asks one question — *"How do we know this disk image wasn't modified after acquisition?"* — and if you can't produce matching hashes from acquisition time and analysis time, the evidence gets thrown out. The same applies to internal IR: if you can't prove the malware sample you analyzed is the same one that hit the endpoint, your root cause analysis is suspect.

Hashing also powers [[Indicators of compromise|IoC]] sharing. When CISA publishes a threat advisory with file hashes, your EDR doesn't need to know what the malware does — it just checks every executable hash against the blocklist. Hash matches are deterministic. No false positives from pattern matching.

**Exam relevance:** Objective CS0-003 3.2 covers evidence acquisition, [[Preservation|preservation]], and [[Validating data integrity|validating data integrity]]. CompTIA will test whether you know which hash algorithm to use, when to hash, and what a hash mismatch means for the investigation.

## Key facts

### Hash algorithms — strength and use cases

| Algorithm | Digest size | Status | Use in IR |
|---|---|---|---|
| **MD5** | 128-bit | Broken (collisions trivial since 2004) | Still used for non-adversarial integrity checks; never alone for legal evidence |
| **SHA-1** | 160-bit | Broken (SHAttered, 2017) | Legacy; deprecated for new work |
| **SHA-256** | 256-bit | Strong | Industry standard for forensic imaging |
| **SHA-512** | 512-bit | Strong | When you want extra margin; same family as SHA-256 |
| **SHA-3** | Variable | Strong | Different design family; hedge against SHA-2 break |
| **BLAKE3** | Variable | Strong, fast | Modern, increasingly used in IR tooling |

**Practical rule:** Forensic imagers (FTK Imager, dd, dcfldd, Guymager, EnCase) typically compute both MD5 and SHA-256 simultaneously. MD5 is fast and useful for quick integrity checks during acquisition. SHA-256 is what you put in the report. Recording both costs almost nothing and covers you against a defense attorney pointing out MD5's weakness.

### Collision attacks — why MD5 and SHA-1 are out

A **collision** is two different inputs producing the same hash. For MD5, attackers can craft two files with identical MD5s in seconds. SHA-1 collisions cost more compute but have been demonstrated publicly. In an adversarial forensic context, this means a sophisticated attacker could theoretically produce a "clean" file with the same hash as malware — making the malware's hash useless as proof of identity.

**For incident response, this matters less than people think.** Attackers aren't crafting collisions against your forensic hashes — they're trying to evade detection. The reason we use SHA-256 is courtroom defensibility, not because we expect the threat actor to forge a hash.

*The MD5 hash isn't useless — it's just not load-bearing alone. Pair it with SHA-256 and you're covered.*

### When hashing happens in the IR lifecycle

The CompTIA / NIST SP 800-61 lifecycle has four phases. Hashing shows up in three of them.

**Detection and Analysis:**
- Hash suspicious files on the endpoint, query VirusTotal / threat intel
- Hash mail attachments, dropped payloads, persistence artifacts
- Compare against published IoC feeds (STIX/TAXII, vendor advisories, CISA)

**Containment, Eradication, and Recovery:**
- Hash the disk image at acquisition time (before pulling the drive, ideally)
- Hash the image again after acquisition completes — the two must match
- Hash again before starting analysis (proves the working copy is the original)
- Hash the malware sample before submitting to sandbox or external analysis
- After [[Re-imaging|re-imaging]] a host, hash the golden image to confirm it's the approved baseline

**Post-incident Activity:**
- Hash every file referenced in the final report
- Maintain the hash log alongside the [[Chain of custody|chain of custody]] form
- If [[Legal hold|legal hold]] is in effect, the hashes are preserved indefinitely with the evidence

The single rule: **if the acquisition-time hash and the analysis-time hash don't match, your evidence is compromised.** You stop, document the discrepancy, and figure out what changed before you continue.

### Hashing during evidence acquisition

The workflow on a live IR engagement:

1. Document the system state (photos, screenshots, running processes, network connections)
2. Connect a [[Write blocker|write blocker]] to the source drive (hardware preferred; software acceptable)
3. Start the imaging tool — it computes the hash as it reads each block
4. Acquisition completes — tool outputs source hash and image hash
5. **Source hash must equal image hash.** If they differ, the acquisition is invalid. Common causes: failing drive sectors, write-blocker failure, interrupted read.
6. Record both hashes on the chain of custody form, signed and timestamped
7. Create a working copy from the image, hash the working copy, confirm it matches the original image hash
8. Analyze only the working copy. The original image goes into evidence storage.

*Touching the original disk without a write blocker is the unforced error that ends careers. The OS will quietly update access timestamps and your hashes won't match.*

### Hashing for IoC matching

EDR and SIEM platforms maintain hash blocklists. When a process executes, the agent hashes the binary and compares against:

- Known-bad hashes (threat intel feeds, internal IR findings)
- Known-good hashes (application allowlisting — only signed, approved binaries run)

This is deterministic detection. No heuristics, no false positives from behavior similarity — either the hash matches or it doesn't. The weakness: attackers recompile or repack the malware and the hash changes. That's why hash-based IoCs have short shelf lives, and why [[Behavioral analysis|behavioral analysis]] (process trees, command line arguments, parent-child relationships) is what catches modern threats.

### CompTIA exam traps

> **CompTIA exam trap:** Hashing does not encrypt data. The question will offer "to keep the evidence confidential" as a tempting wrong answer. Hashing provides **integrity**, not confidentiality. Confidentiality is encryption. If you need both — encrypt the evidence container, then hash the encrypted container.

> **CompTIA exam trap:** A matching hash proves the file hasn't changed since the hash was taken. It does **not** prove the file is uncompromised, authentic, or from a trusted source. The hash captures the state at hash time. If the attacker hashed their malware and gave you the hash, the hash still matches — and the file is still malware. Integrity ≠ authenticity. Authenticity requires digital signatures (asymmetric crypto on top of the hash).

> **CompTIA exam trap:** "MD5 is deprecated" is true but oversimplified. MD5 is acceptable for non-adversarial integrity checks (file transfer verification, deduplication). It is unacceptable as the sole hash for forensic evidence that may go to court. CompTIA may ask which algorithm is appropriate for a specific scenario — read carefully whether the context is adversarial or not.

> **CompTIA exam trap:** A hash mismatch during analysis doesn't always mean tampering. It can mean a bad sector developed on the storage media, a failed copy, or a tool bug. The correct first action is to **document the discrepancy and reacquire from the original if possible** — not to conclude tampering occurred.

### Validating data integrity — the broader picture

Hashing is the mechanism, but [[Validating data integrity|data integrity validation]] is the discipline. It covers:

- **Evidence integrity** — disk images, memory captures, log exports
- **Backup integrity** — proving the backup you restored from wasn't itself compromised
- **Log integrity** — SIEM logs hashed and signed at ingestion to detect tampering; ties to [[Log analysis|log analysis]] reliability
- **Configuration integrity** — file integrity monitoring (FIM) hashes critical system files (e.g., /etc/passwd, registry hives, web root) and alerts on change
- **Software supply chain integrity** — hash the installer, compare to vendor-published hash, before deploying

FIM is a [[Compensating controls|compensating control]] when you can't prevent unauthorized changes outright — you can at least detect them. The SolarWinds compromise is the textbook case for why supply chain hash validation matters: the malicious DLL was signed and would have matched a malicious-but-vendor-published hash. Defenders who blindly trusted vendor hashes had no help. Defenders running behavioral EDR caught it later.

## SOC reality

- The L1 analyst pulls a hash from a suspicious binary, drops it in VirusTotal. If it's known-bad with multiple vendor hits, escalate to L2 immediately — no further analysis needed for the triage decision. If it's unknown, that's more interesting, not less.
- The IR lead's first question when you say "I imaged the laptop" is **"Do the hashes match?"** If you fumble the answer, you've already lost credibility. Have the hash log ready before the call.
- Never tell legal "the evidence is preserved" without being able to produce the chain of custody form with hashes at every transfer point. Legal hold means every touch is documented, every hash is logged, every analyst who pulled the image computed a hash before and after their work.
- The 3am alert looks like: *"FIM: /etc/shadow modified on prod-db-01, hash changed."* Your first action isn't to panic — it's to check if there's a change ticket for it. 90% of the time, ops did a password rotation and forgot to suppress the FIM alert. The 10% you care about is the other 10%.
- Hand-off to forensic team: provide image file, image hash, acquisition log, chain of custody form, and a one-page incident summary. The forensic team will recompute the hash on receipt. If it doesn't match what you gave them, the evidence is dead on arrival and you're explaining why on the next call.

## Related concepts

[[Chain of custody]] · [[Evidence acquisition]] · [[Write blocker]] · [[Validating data integrity]] · [[Preservation]] · [[Legal hold]] · [[Indicators of compromise]] · [[Re-imaging]] · [[Compensating controls]] · [[Log analysis]] · [[Behavioral analysis]] · [[NIST SP 800-61]]

*Source: VIRGIL knowledge base — 2026-05-11*