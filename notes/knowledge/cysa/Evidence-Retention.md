# Evidence Retention

## What it is

In **NBA 2K**, every MyCareer game writes a full save file — box score, play-by-play, broadcast replay, your VC transactions, the contract you signed, the endorsement clauses. 2K keeps that data because if you ever get flagged for VC fraud, suspicious badge progression, or a contested online ranked match, they need the receipts. The replay isn't kept forever — there's a retention window. But while it's in the vault, it's hashed, signed, and tied to your account so it can't be tampered with. The day they delete it, it's gone for good, and any dispute after that point is your word against theirs. That's exactly what **evidence retention** does — it's the deliberate decision about *how long* incident evidence lives, *where* it lives, *who can touch it*, and *when it gets destroyed*.

**Plain English:** After the incident is closed, you don't just leave the disk image and packet captures in a folder on someone's laptop. You decide — based on legal exposure, regulatory rules, and org policy — whether the evidence is locked in a vault for years or shredded next quarter. Both decisions are legitimate. Picking the wrong one ends careers.

**Technical definition:** Evidence retention is the policy-driven lifecycle management of digital forensic artifacts collected during [[Incident Response]] — covering preservation period, storage controls, integrity validation, access logging, and eventual disposition (destruction or transfer). It sits at the intersection of [[Chain of Custody]], [[Legal Hold]], records management, and regulatory compliance.

## Why it matters

Evidence retention is where incident response collides with the legal department, and where SOC analysts who skipped the boring slides get subpoenaed. CompTIA tests this under Objective **CS0-003 3.2** as part of the post-incident phase, but the operational stakes are sharper than the exam suggests: retain too little and you can't prosecute, can't claim insurance, can't defend yourself in litigation. Retain too much and you become a discovery target — opposing counsel will demand everything in your vault, and "everything" might include data you had no legal right to keep.

The career relevance is direct. Senior IR analysts and incident managers own retention decisions. Get it wrong and you're explaining to a judge why the only copy of the attacker's payload got auto-deleted at day 91, or why you still had a customer's PII in a forensic image three years after GDPR said delete it.

## Key facts

### The retention decision tree

After [[Containment Eradication and Recovery]] is complete, every evidence artifact gets one of three fates:

| Disposition | When | Who decides |
|---|---|---|
| **Retain under legal hold** | Active litigation, regulatory investigation, criminal case, or reasonable anticipation of any of the above | Legal counsel — not IR, not the CISO |
| **Retain per policy** | No active legal matter, but org retention policy requires N years (often 1, 3, 7, or "life of asset") | Records management + CISO |
| **Destroy** | Retention period expired, no legal hold attached, no compliance requirement to keep | Records management with IR sign-off |

The trap: IR doesn't get to unilaterally destroy. Once evidence exists, destruction requires policy authority *and* a documented confirmation that no [[Legal Hold]] applies.

### What "evidence" actually means in retention scope

Not just the disk image. The full evidence inventory typically includes:

- **Forensic images** — bit-for-bit copies of disks, memory captures (RAM dumps), mobile device extractions
- **Network artifacts** — full packet captures (PCAPs), [[NetFlow]] records, firewall and proxy logs
- **Endpoint telemetry** — [[EDR]] process trees, [[Sysmon]] event logs, [[Windows Event Logs]]
- **SIEM data** — correlated alerts, raw log archives, analyst notes
- **Malware samples** — extracted binaries, decoded payloads, C2 configs
- **Documentation** — chain of custody forms, IR timeline, analyst worksheets, communications
- **IoCs** — hashes, IPs, domains, registry keys (these often have *longer* retention than the raw evidence, because they feed threat intel)

### Integrity validation across the retention window

Evidence doesn't get retained by accident — it gets retained *intactly*. [[Validating Data Integrity]] runs through the entire lifecycle:

- **At acquisition** — compute SHA-256 (MD5 is dead for legal purposes, treat it as deprecated) of every image at the moment of capture. Document the hash on the chain of custody form.
- **During storage** — periodic re-hash. Quarterly is standard for high-value evidence. Hash mismatch = corruption or tampering, and you need to know *immediately*, not the day before trial.
- **At access** — every time someone pulls evidence for analysis, hash before and after. The working copy gets analyzed; the master image never gets touched.
- **At transfer** — hash on send, hash on receive, both parties sign.
- **At destruction** — hash one final time, document, then cryptographically wipe or physically destroy the media.

### Storage controls

Retained evidence lives in a controlled environment. Minimums:

- **Physical isolation** — locked safe, dedicated evidence room, or bonded third-party storage. Not a shared NAS.
- **Access logging** — every entry, every retrieval, every return. Badge logs, sign-in sheets, ticket references.
- **Encryption at rest** — AES-256 minimum. Key custody separate from media custody.
- **Environmental controls** — temperature, humidity for long-term magnetic media; offline storage for anything sensitive.
- **Redundancy with care** — backups of evidence are *also* evidence, and inherit the same chain of custody requirements. Cloud backups complicate jurisdiction.

### Retention periods you'll actually see

| Driver | Typical retention |
|---|---|
| Generic incident, no legal hook | 1 year |
| PCI DSS incident | 1 year minimum, 3 months immediately available |
| HIPAA breach | 6 years |
| SOX-relevant incident | 7 years |
| GDPR-related breach evidence | Only as long as needed for the lawful purpose — *the inverse problem* |
| Active litigation / legal hold | Indefinite until counsel releases |
| Criminal prosecution | Through trial + appeals (years) |
| Insurance claim | Through claim resolution + statute of limitations |

The HIPAA/SOX numbers are floors, not ceilings. GDPR cuts the other direction — you cannot use "we kept it for forensics" as a forever-license to retain personal data. Conflict between regulations is normal, and legal counsel resolves it.

### Legal hold mechanics

A [[Legal Hold]] (litigation hold) is a formal directive from legal counsel that suspends *all* normal retention and destruction schedules for specified evidence. Once issued:

- Auto-deletion policies pause
- The custodian acknowledges the hold in writing
- Any destruction during the hold = spoliation = sanctions, adverse inference instructions, sometimes criminal contempt
- The hold remains until counsel issues a formal release

The hold is broader than people expect. It covers email, chat logs, ticketing system notes, analyst Slack DMs about the incident. If the SOC was discussing the case in a Teams channel, that channel is now under hold.

### Compensating controls during retention

Sometimes you can't fully retain the original — the system is production-critical and had to be [[Re-imaging|re-imaged]] to restore business. Your [[Compensating Controls]] for retention then become:

- Pre-reimage forensic image preserved
- Memory capture from before wipe
- Log exports stored separately
- Documentation that the original is unavailable, why, and who authorized the reimage

CompTIA likes this scenario — production pressure forces remediation before forensics is complete, and the analyst has to defend why evidence is partial.

### CompTIA exam traps

> **CompTIA exam trap:** Retention policy is *not* the same as chain of custody. [[Chain of Custody]] documents who touched the evidence; retention policy decides how long the evidence exists. CompTIA will give you a scenario where evidence was destroyed *on schedule* and ask whether chain of custody was broken — it wasn't, but the destruction may still have violated a legal hold. Read the question for the word "litigation," "subpoena," "preservation order," or "anticipated lawsuit."

> **CompTIA exam trap:** Hash algorithm choice. MD5 collisions have been demonstrated since 2004 and MD5-based evidence has been challenged in court. SHA-1 is also deprecated. The exam-correct answer for integrity validation in 2026 is **SHA-256** or stronger. If you see MD5 as the "right" answer, it's a distractor unless the question explicitly says "legacy system."

> **CompTIA exam trap:** Destruction is not always the safe choice. New analysts default to "retain forever, just in case." Under GDPR, CCPA, and similar privacy regimes, *retaining personal data longer than necessary is itself a violation*. The right answer is "follow policy and consult legal" — not "keep it forever."

> **CompTIA exam trap:** The order. Post-incident retention decisions happen in the **Post-incident Activity** phase, not during Containment or Recovery. CompTIA may put a question about disposition decisions inside a Containment scenario to see if you recognize the phase mismatch.

### Documentation that survives the analyst

Whoever made the original acquisition will leave the company. Retention documentation must stand on its own:

- Evidence intake form with hashes, timestamps, acquiring analyst, source system
- Chain of custody log with every transfer
- Storage location and access control list
- Retention schedule with calculated destruction date
- Legal hold notices (if any) with issuing counsel and scope
- Destruction certificate when disposed

If the analyst who acquired the evidence can't be reached, the documentation alone must be sufficient to admit the evidence in court. That's the bar.

## SOC reality

- The L1 analyst doesn't make retention calls — but they're the ones who hash the image at acquisition, and that hash is what every later decision hangs on. Get the hash wrong at minute zero and nothing downstream is salvageable.
- The CISO's actual question after a closed incident: *"Is everything preserved? Is legal aware? When does the retention clock start?"* You answer with the ticket number, the hash manifest, and the calculated destruction date — or you say "I'll have that in an hour" and you actually deliver in an hour.
- Never tell leadership "we destroyed it per policy" without first confirming in writing that no legal hold applies. The IR lead who skipped that confirmation step is the IR lead who got deposed.
- The handoff: IR completes the incident → records management or legal owns the evidence custody → IR maintains read access for lessons learned and threat intel extraction. Three-way custody is normal and healthy.
- Watch for the silent killer: auto-deletion policies on SIEM log retention. Your incident evidence in the SIEM may have a 90-day TTL by default. If the investigation runs long, that data evaporates while you're still working the case. Export early, hash, store separately.

*The evidence you retain is a liability. The evidence you destroy is a liability. The only safe path is the documented one — and the documentation is the actual product of post-incident work, not an afterthought.*

## Related concepts

[[Chain of Custody]] · [[Legal Hold]] · [[Validating Data Integrity]] · [[Evidence Acquisition]] · [[Preservation]] · [[Incident Response]] · [[Post-incident Activity]] · [[Re-imaging]] · [[Compensating Controls]] · [[Forensic Imaging]] · [[Data and Log Analysis]] · [[GDPR]] · [[HIPAA]] · [[PCI DSS]]

*Source: VIRGIL knowledge base — 2026-05-11*