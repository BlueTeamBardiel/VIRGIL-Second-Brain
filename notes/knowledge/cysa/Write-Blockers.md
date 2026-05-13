# Write Blockers

## What it is

In **Cyberpunk 2077**, when V jacks into a Militech datashard or a corpo netrunner's deck, the breach protocol shows you the daemons you can run — but the moment V's cyberdeck *writes* anything back, the ICE knows. Every quickhack leaves a trace. The clean runs — the ones where Johnny doesn't have to bail you out — are the ones where you read the shard's contents through the personal link without uploading anything of your own. Pull the data, leave no fingerprint, walk out before NetWatch logs your signature.

That's exactly what a write blocker does — it lets you read a suspect drive without ever writing back to it.

A **write blocker** is a hardware or software device that sits between a forensic workstation and a piece of source evidence (hard drive, SSD, USB, phone) and intercepts every write command the OS tries to send. Reads pass through. Writes get dropped or denied. The original media stays bit-for-bit identical to the moment you seized it, which is the entire game when that media has to hold up in court.

Per CS0-003 objective 3.2, write blockers are a foundational tool for **evidence acquisition**, **preservation**, **validating data integrity**, and **chain of custody** — the entire forensic spine of the IR lifecycle.

## Why it matters

A defense attorney does not need to prove the suspect is innocent. They need to prove your evidence is contaminated. If you plugged the drive into a Windows box without a write blocker, Windows wrote a `System Volume Information` folder, updated `$MFT` timestamps, possibly ran an indexer pass, and maybe triggered shadow copy creation — all before you even opened a file. The drive's hash is now different from the moment of seizure. Your timeline has phantom events. Cross-examination eats you alive.

For the CySA+ exam, write blockers show up in any question involving forensic imaging, evidence handling, or chain of custody. CompTIA wants you to know that the *order of operations* during acquisition is: power down or live-image carefully → connect through write blocker → image the drive → hash before and after → store the original under legal hold → work only on the image. Miss the write blocker step and the rest is theater.

For the SOC analyst career path, this is where IR work touches the legal world. You will not personally do most acquisitions — your DFIR team or an outside firm will — but you will be the person who decides *when* to call them, and if you mishandle the endpoint between the alert and their arrival, you've already burned the evidence.

## Key facts

### How they work

A write blocker is a hardware shim or kernel-level driver that filters the SCSI/ATA/NVMe command set. The OS sees a normal storage device. Underneath, the blocker maintains a whitelist of read commands (READ, IDENTIFY, INQUIRY) and either silently drops or returns success on write commands (WRITE, ERASE, TRIM, FORMAT) without passing them through.

The good ones also block **side-channel writes** the OS does without asking you — automount indexing, journal recovery, SMART log updates, pagefile creation on the mounted volume. That's why a real hardware write blocker beats "I unchecked automount in Linux."

### Hardware vs software write blockers

| Aspect | Hardware | Software |
|---|---|---|
| Enforcement | Physical — circuit-level | Kernel driver / OS policy |
| Defensibility in court | Strong, well-established | Weaker, depends on OS state |
| Cost | $300–$3,000+ (Tableau, WiebeTech, CRU) | Free to cheap |
| Speed | Often faster (purpose-built ASIC) | Limited by host bus |
| Interfaces | SATA, SAS, IDE, USB, NVMe, FireWire | Whatever the host supports |
| Failure mode | Fails closed (no writes) | Can fail open on driver bugs |
| NIST CFTT tested | Yes, the major vendors | Some, not all |

**Hardware is the default for any acquisition that might see a courtroom.** Software write blockers (like `blockdev --setro` in Linux, or Windows USBSTOR registry tweaks) are acceptable for triage, training, or internal-only investigations where the bar is "don't accidentally scribble on the drive" rather than "withstand a Daubert challenge."

### Where they fit in the IR lifecycle

This maps to **CompTIA's incident response phases** (NIST SP 800-61):

1. **Preparation** — write blockers live in the IR go-bag alongside Faraday bags, sterile target drives, evidence labels, and the chain-of-custody form. If the go-bag doesn't have one, you're not ready.
2. **Detection and Analysis** — once an endpoint is flagged via [[IoC]] (indicator of compromise) hits in the [[SIEM]] or [[EDR]], scope and impact are assessed. If the host is going to be acquired rather than just re-imaged, the write blocker comes out.
3. **Containment, Eradication, and Recovery** — the host is isolated (network quarantine via EDR, switchport disable, or physical pull). For acquisition: power down cleanly or pull the plug depending on whether memory matters more than disk consistency. Connect through the write blocker. Image. Hash.
4. **Post-incident Activity** — the working image is analyzed. The original media stays in evidence storage under legal hold. The chain-of-custody log gets every transfer.

### Validating data integrity — the hash dance

The write blocker only matters if you *prove* it worked. The process:

1. Connect source to write blocker. Compute hash of source media → `SHA-256(source) = abc123...`
2. Image the source to a sterile target → `dd if=/dev/sdb of=/mnt/evidence/case42.dd` or use `dcfldd`, `ewfacquire`, FTK Imager, X-Ways.
3. Compute hash of the image → `SHA-256(image) = abc123...`
4. Re-hash the source after imaging → still `abc123...`

If all three match, you have a defensible copy and you've proved the write blocker held. **MD5 and SHA-1 still appear in tooling but are cryptographically broken — use SHA-256 minimum. Many shops dual-hash (MD5 + SHA-256) for cross-tool compatibility.**

### Chain of custody — what the form actually captures

Every transfer of the original media gets a row:

- Item description and serial number
- Date/time of transfer
- From whom, to whom (signatures)
- Purpose of transfer
- Storage location and seal number after transfer

Lose one row and the defense gets to argue someone tampered with the drive during the gap. *I once watched a perfectly good intrusion case get gutted in deposition because the evidence locker logbook had a 14-hour window with no signature — the drive sat on a desk overnight and nobody could prove it wasn't touched.*

### Legal hold and preservation

When the org receives notice of litigation, regulatory action, or anticipates either, **legal hold** kicks in — all potentially relevant data must be preserved, including normally-rotated logs, backups, and endpoints scheduled for re-imaging. Write blockers are the mechanism that lets you preserve while still analyzing copies. **You cannot re-image a host under legal hold without first acquiring it.** This is where the IR team and legal counsel must talk before remediation moves forward.

### Special cases

- **Live systems / RAM acquisition** — you cannot write-block volatile memory. Memory acquisition (with `winpmem`, `LiME`, FTK Imager) inherently writes a kernel driver to the running system. Document the change, accept it, prioritize per the [[order of volatility]].
- **Encrypted drives (BitLocker, FileVault, LUKS)** — image the encrypted blob through the write blocker first, then decrypt the image, never the original. Recovery keys go in the evidence package.
- **SSDs and TRIM** — even with a write blocker on the host side, SSD garbage collection runs autonomously inside the drive. Hash *immediately* and document. This is a known forensic limitation, not a write blocker failure.
- **Mobile devices** — phones rarely image cleanly through a generic write blocker. Use Cellebrite, GrayKey, or vendor-specific forensic gear that handles the protocols.
- **Cloud / virtualized evidence** — write blockers don't exist in AWS. Equivalent control is API-driven snapshot + immutable storage (S3 Object Lock, Azure immutable blobs). Hash and document the snapshot ID.

### CompTIA exam traps

> **CompTIA exam trap:** "Imaging the drive with `dd` on a Linux box" is *not* sufficient on its own. The answer they want includes the write blocker — even Linux will update access timestamps if the source is mounted. The exam tests whether you know the *order*: write blocker first, image second, hash third.

> **CompTIA exam trap:** Software write blockers are not the same as "read-only mount." A read-only mount prevents *filesystem-layer* writes; the kernel can still issue device-layer writes (SMART updates, journal replay). Hardware write blockers stop both. If the question pits hardware vs software, hardware wins for legal defensibility.

> **CompTIA exam trap:** Hashing happens *before and after* imaging. If a question only mentions hashing the image and not the source, that's the wrong answer. Both must match, and the source hash must be unchanged post-acquisition.

> **CompTIA exam trap:** Re-imaging is *remediation*, not preservation. If a host is under legal hold, you acquire first, then remediate. Compensating controls (network isolation, EDR quarantine) keep the host contained while acquisition happens — they do not replace it.

## SOC reality

- The L1 analyst who clicked "isolate host" in CrowdStrike at 2am does not own a write blocker. Their job is to *not touch the box further* and escalate to IR/DFIR. The worst thing an eager L1 can do is RDP into the host "just to check" — every login writes event logs, updates `NTUSER.DAT` timestamps, and contaminates the timeline.
- The CISO will ask three questions when an acquisition is in play: **scope** (how many endpoints), **impact** (data exfil confirmed?), **evidence preserved** (chain of custody started?). If you cannot answer the third with "yes, write blocker in use, hashes captured," you do not say "we've got it under control."
- The IR lead's call: live-image with memory capture, or pull power and image cold? Memory wins if the malware is fileless or the encryption keys are in RAM. Cold wins if disk consistency matters more and the threat actor might be watching the EDR console.
- Never promise legal or HR "we have all the evidence" until the hashes match and the chain-of-custody form is signed. *I have watched a perfectly executed acquisition get questioned six months later because the analyst who did it left the company and nobody else could testify to the process. Document like you'll be deposed, because you might be.*
- Handoff path: L1 detects → L2 scopes → IR team decides acquisition vs re-image → DFIR (internal or contracted) does the imaging with write blocker → legal owns the chain of custody from there. Know your lane.

## Related concepts

[[Chain of Custody]] · [[Order of Volatility]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[Data Integrity Validation]] · [[Hashing (MD5, SHA-256)]] · [[Disk Imaging]] · [[Memory Forensics]] · [[Incident Response Lifecycle]] · [[NIST SP 800-61]] · [[Compensating Controls]] · [[Re-imaging]] · [[Forensic Tools (FTK, EnCase, Autopsy)]] · [[Isolation and Containment]]

*Source: VIRGIL knowledge base — 2026-05-11*