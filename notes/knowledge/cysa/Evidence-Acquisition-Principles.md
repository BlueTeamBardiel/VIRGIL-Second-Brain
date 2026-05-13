# Evidence Acquisition Principles

## What it is

In **Red Dead Redemption 2**, when you ride up on a fresh crime scene as Arthur, the lawmen are still working it — a body on the saloon floor, blood not yet dry, a witness three buildings over who watched it happen, hoofprints in the mud outside that the next rainstorm will erase by morning. Pinkertons show up and ask questions in a specific order: who's still here, what did they see, what's on the body, what's in the room, what's on the trail. They don't wait. They know the witness will leave town tomorrow, the rain is coming, and the trail goes cold inside a day. That's exactly what evidence acquisition does — you collect from the most volatile sources first, document every handoff, and keep the scene from being trampled before the slow evidence can be worked.

Evidence acquisition is the disciplined, ordered, defensible capture of digital artifacts from a system, network, or account during incident response — done in a way that preserves integrity, supports legal proceedings, and survives challenge in court. CompTIA frames this inside the **Detection and Analysis** phase of the IR lifecycle (NIST SP 800-61), feeding directly into **Containment, Eradication, and Recovery**.

## Why it matters

Acquisition is where most incident response actually fails. Not at detection — the [[SIEM]] fires plenty. Not at containment — analysts know how to pull a network cable. It fails the moment someone reboots a box "to see if it clears the alert," and a memory-resident implant evaporates along with every credential cached in [[LSASS]]. It fails when an L1 drag-and-drops a suspicious binary to their desktop, destroying the original timestamps. It fails when legal asks "who touched this disk between 03:14 and 09:00" and nobody can answer.

For CS0-003 (Objective 3.2), CompTIA tests acquisition as the bridge between *detecting* something is wrong and *proving* what happened. Get this wrong and the breach notification letter is the least of your problems — you've also lost the ability to attribute, prosecute, or recover insurance.

## Key facts

### Order of volatility (RFC 3227)

Collect from most volatile to least. Power loss or reboot erases anything above where you stopped.

| Order | Source | Lifetime | Captured with |
|---|---|---|---|
| 1 | CPU registers, cache | Microseconds | Specialized hardware; rarely captured |
| 2 | **RAM (memory)** | Until power loss or overwrite | WinPMem, FTK Imager, LiME |
| 3 | **Network state** (connections, ARP, routing) | Seconds to minutes | `netstat`, `ss`, `arp -a`, pcap |
| 4 | **Running processes** | Until termination | EDR snapshot, `procdump` |
| 5 | Temp files, swap, pagefile | Hours to reboot | Live acquisition before shutdown |
| 6 | **Disk storage** | Persistent | Write-blocked imaging — `dd`, FTK, EnCase |
| 7 | Remote logs, [[SIEM]] data | Retention window | Query and export |
| 8 | Backups, archives, physical media | Months to years | Standard retrieval |

*If you power off the host before memory capture, you've thrown away the half of the investigation that matters most for modern malware.*

### Live acquisition vs dead-box

**Live acquisition** — system is running. You capture RAM, network state, and process trees first, then image disk. You get volatile data, but every action you take changes system state and must be documented. The act of running your collection tool writes to memory and disk.

**Dead-box acquisition** — system is powered down (ideally by pulling the plug, not graceful shutdown — graceful shutdown writes to disk and flushes caches that may contain evidence). Disk is removed and imaged via a **write blocker**. Pristine and repeatable, but volatile data is gone forever.

In practice: live-acquire memory and triage artifacts first, then pull the plug or isolate the host on a quarantine VLAN. EDR platforms make this easier — they can snapshot process trees, network connections, and memory regions without a human touching the keyboard.

### Validating data integrity

Every image gets hashed at acquisition — **MD5 and SHA-256** is standard (MD5 for legacy tool compatibility, SHA-256 because MD5 is collision-broken). Hash is recorded on the chain-of-custody form at the moment of capture. Every copy gets re-hashed. Every analysis runs against a verified working copy.

If the hash changes, the evidence is contaminated. Full stop. *A defense attorney with a competent forensic expert will end your case on a single hash mismatch.*

Working rule: **never analyze the original image**. Hash it, write-protect it, store it, and touch it only to verify the hash on demand.

### Chain of custody

A chronological, signed record of every person who handled the evidence, when, where, and why. Every transfer is logged — analyst to evidence locker, locker to lab, lab to legal, legal to court. A missing transfer is a broken chain, and a broken chain is evidence thrown out.

Minimum fields:
- Case number and evidence tag
- Item description (make, model, serial, capacity, hash)
- Date/time of acquisition; acquired by (name, badge, signature)
- Each subsequent custodian (received/released times, purpose)
- Storage location between transfers

In a mature SOC, this is a form. In an immature SOC, it's an email thread that won't survive a subpoena.

### Scope and impact — sized at acquisition time

You can't acquire what you don't know exists. The first analyst on the scene defines **scope** (which systems, accounts, data) and estimates **impact** (CIA, regulatory exposure, dollars). Both numbers will grow — almost always. Acquisition planning assumes scope will expand and tags evidence accordingly.

Minute-zero scope questions:
- Which hosts have the [[IoC]] (hash, IP, domain, behavior)?
- Which user accounts are implicated? Service accounts? Domain admin?
- Which data stores did the implicated identities touch?
- What's the blast radius if we're wrong about scope being small?

### Preservation and legal hold

**Preservation** is the operational discipline of not destroying evidence — turn off log rotation on affected hosts, suspend re-imaging schedules, snapshot VMs instead of deleting them, freeze backup expiration.

**Legal hold** is the formal counsel-issued version: a written directive that any data potentially relevant to anticipated litigation must not be deleted, modified, or rotated out. It overrides normal retention. It applies to email, chat, tickets, logs, images — everything. Violating a legal hold is **spoliation** and triggers court sanctions, adverse-inference jury instructions, or default judgment against your org.

Once legal hold is issued, IT operations bend around it: no re-imaging of held hosts without legal sign-off, no automated cleanup of held mailboxes, no SIEM data aging out of held timeframes.

### Isolation — buying time without destroying evidence

You contain to stop the bleeding. You acquire to learn what bled. These goals fight each other if you're sloppy.

**Right way to isolate:**
- Move host to a quarantine VLAN with no egress except to forensic collectors
- Disable the user account at the IdP, don't delete it (deletion destroys audit trails)
- Block C2 at the firewall but log every attempted callback (more IoCs)
- Use EDR network containment — agent stays connected, everything else dropped

**Wrong way:**
- Power off the host (loses RAM)
- Wipe and reinstall (destroys evidence, and the threat actor still has your domain admin password)
- Delete the user account (breaks audit trails)
- Unplug from network without first capturing volatile state

### Remediation, re-imaging, and compensating controls

Acquisition is upstream of remediation. You don't re-image a box until you've pulled what you need. **Re-imaging** wipes evidence; appropriate only after acquisition is complete and IR signs off.

**Compensating controls** are temporary defenses while remediation is in flight — extra logging on the affected segment, MFA enforcement on the implicated identity, application allowlisting on similar hosts, VPN geofencing. They don't fix root cause; they reduce re-compromise risk while the slow work happens.

### Data and log analysis

Logs are evidence too, and they roll off. First action on a confirmed incident is **freeze log retention** for affected sources: extend [[SIEM]] retention, pull a forensic export, snapshot the syslog server. Grab immediately:

- Authentication logs (Windows 4624/4625/4672, Linux auth.log, IdP logs)
- Process execution (Sysmon Event ID 1, EDR telemetry)
- Network flow ([[NetFlow]]/[[IPFIX]], firewall, proxy)
- DNS query logs
- PowerShell/script-block logging (Event ID 4104)
- Cloud audit trails (CloudTrail, Azure Activity Log, GWS audit)

### CompTIA exam traps

> **CompTIA exam trap:** Order of volatility. CompTIA scrambles **CPU registers, RAM, disk, backups** and asks which goes first. Memorize: **registers → RAM → network state → processes → disk → remote logs → backups**. The trap answer is always "disk first because it has the most data" — wrong. Volatility, not volume.

> **CompTIA exam trap:** Legal hold vs preservation. Preservation is operational ("don't delete this"). Legal hold is the formal counsel-issued directive that creates legal exposure if violated. Only legal hold triggers spoliation sanctions.

> **CompTIA exam trap:** Hashing tools. Question lists `dd`, `md5sum`, `netstat`, `FTK Imager` and asks which validates integrity. Both `md5sum` and `FTK Imager` validate; `dd` images but does not hash on its own (pipe to `md5sum` or use `dcfldd`). Read carefully.

> **CompTIA exam trap:** "Pull the plug" vs graceful shutdown. For dead-box forensics on suspected ransomware or rootkit hosts, pulling the plug is preferred — graceful shutdown runs malware shutdown routines that wipe artifacts. For most other cases, isolate first, acquire memory, *then* pull power.

## SOC reality

- At 3am, the alert says "suspicious PowerShell on FIN-WKS-0412." The L1's first move is **not** to RDP in and look around — every keystroke contaminates the scene. First move is EDR isolation + memory snapshot via the EDR console, then escalate to L2.
- The IR lead's first three questions are always the same: **scope** (how many hosts?), **impact** (what data?), **evidence preserved?** If the answer to the third is "I rebooted it," the conversation ends and a new one begins with HR.
- Never tell leadership "we've contained it" until EDR confirms no new process executions, no new outbound C2, and the implicated identity has been disabled and its tokens revoked. "Contained" has legal weight — it ends up in breach notifications.
- Handoff path: L1 detects and isolates → L2 acquires volatile evidence → IR/forensics images disk and analyzes → legal issues hold → executive briefed on scope/impact → external counsel and regulators looped in if thresholds tripped.
- 80% of acquisitions never become court evidence — but you treat 100% of them like they will, because you don't know on day one which incident becomes the lawsuit.

## Related concepts

[[Chain of Custody]] · [[Order of Volatility]] · [[Incident Response Lifecycle]] · [[Containment Eradication Recovery]] · [[Legal Hold]] · [[Write Blocker]] · [[Hashing MD5 SHA256]] · [[Disk Imaging]] · [[Memory Forensics]] · [[EDR]] · [[SIEM]] · [[Sysmon]] · [[IoC]] · [[Spoliation]] · [[NIST SP 800-61]] · [[RFC 3227]]

*Source: VIRGIL knowledge base — 2026-05-11*