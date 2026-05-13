# Evidence Acquisition and Preservation

## What it is

In **League of Legends**, after a tournament match where someone calls cheating, Riot doesn't take the loser's word for it. They pull the match replay — the full deterministic record of every input, every cooldown, every fog-of-war reveal — from Riot's servers, not the player's machine. The replay is hash-verified against server state. Chain of custody is enforced because the replay lives in Riot's infrastructure, not in a Discord screenshot someone cropped. If the file's timestamp doesn't match server logs, the evidence is junk. That's exactly what evidence acquisition and preservation does — capture the artifact in a verifiable state, prove it hasn't been touched, and keep a paper trail of every hand it passed through.

**Technical definition:** Evidence acquisition is the forensically sound collection of digital artifacts (disk, memory, network, logs, VM snapshots) from a compromised or relevant system. Preservation is the disciplined handling of those artifacts — storage, integrity validation, chain of custody — such that the evidence is admissible in legal, regulatory, or internal disciplinary proceedings and survives adversarial scrutiny.

This sits inside **Detection and Analysis** of the [[Incident Response Lifecycle]] (NIST SP 800-61), but the moment you touch a compromised host, the rules of evidence apply. Acquisition done wrong cannot be redone — you only get one shot at memory, and a sloppy disk image is contamination, not evidence.

## Why it matters

Acquisition and preservation are the boring parts of IR that decide whether the loud parts mattered. You can do brilliant malware analysis, identify the threat actor down to the keyboard layout, and write a beautiful root-cause report — and if your chain of custody has a six-hour gap, opposing counsel walks the whole thing back at deposition. Insurance won't pay. Regulators won't accept your timeline.

For CySA+ this is **Objective 3.2** — given a scenario, perform incident response activities. CompTIA expects you to know the acquisition order, the hash workflow, the legal hold trigger, and the difference between isolation that preserves evidence and containment that destroys it.

In the field: every incident that touches PII, PHI, payment data, or a regulated industry will eventually have a lawyer in the room. Your evidence is either court-ready or it isn't.

## Key facts

### Acquisition order — volatility first

RFC 3227 gives the canonical sequence, and CompTIA tests it: capture the most volatile data first because it dies the fastest.

| Order | Artifact | Method | Why |
|---|---|---|---|
| 1 | CPU registers, cache | Live memory tools | Gone the instant power changes |
| 2 | RAM | FTK Imager, WinPmem, LiME, Magnet RAM Capture | Process trees, injected code, encryption keys, network connections |
| 3 | Network state | `netstat`, `ss`, packet capture, NetFlow | Active C2 channels, established sessions |
| 4 | Running processes / temp files | KAPE, CyLR | Lost on reboot |
| 5 | Disk image | `dd`, FTK Imager, EnCase, write-blocker + duplicator | Persistent — but huge |
| 6 | Remote logging / SIEM data | SIEM export, syslog archives | Already off-host |
| 7 | Physical config, topology | Photos, network diagrams | Static |

**File copies** lose timestamps (MAC times), slack space, deleted-file remnants, and alternate data streams. Triage only.

**Disk images** are bit-for-bit copies. Use a hardware **write blocker** on the source — it permits reads but blocks writes, so the OS can't update access times and contaminate the image. Common formats: raw `dd`, E01 (EnCase), AFF4.

**Memory captures** are the highest-value modern artifact. Fileless malware, [[Process Injection]], in-memory C2 beacons — none of it lives on disk. If you reboot before capturing RAM, you've destroyed evidence. *I have watched a junior analyst "isolate" a host by pulling the power cable. He thought he was helping. He wasn't.*

**VM snapshots** capture memory + disk + CPU state atomically. For any VM compromise, snapshot first, analyze second. Hypervisor-level acquisition is also stealthy — the guest OS doesn't know you copied it.

### Isolation vs. containment

**Isolation** preserves the host for forensic analysis. **Containment** stops the bleeding. Not the same.

- **Network isolation** (VLAN move, firewall rule, EDR network containment) keeps the host alive, RAM intact, attacker visible. Evidence-friendly.
- **Power-off containment** preserves disk but destroys memory. Sometimes necessary (ransomware actively encrypting), almost never preferred.
- **Re-imaging** wipes the evidence entirely. Never re-image until acquisition is complete and validated.

EDR-driven network isolation is the modern default — CrowdStrike, SentinelOne, Defender for Endpoint all support "contain host" with one click. Host stays running, SOC keeps full visibility, acquisition proceeds cleanly.

### Chain of custody

The documented, unbroken record of who held the evidence, when, where, why, and what they did to it. Every transfer logged. Every access logged. Gaps in the chain are how cases die.

A chain of custody form tracks:

- **Case ID** and incident reference
- **Evidence ID** (unique per artifact — disk image, RAM capture, log export each get their own)
- **Description** (make, model, serial, hostname, hash)
- **Acquisition** — who, when, where, what tool, what hash
- **Every transfer** — from whom, to whom, date, time, purpose, signature
- **Storage** — evidence locker, access list, environmental controls
- **Destruction** — when, how, witnessed by whom

> **CompTIA exam trap:** Chain of custody is not the same as data integrity validation. Chain of custody is the *paper trail*. Hashing is the *cryptographic proof*. CompTIA will offer both as answers and the right one is whichever the question is actually asking about. "Prove the file wasn't modified" → hash. "Prove no unauthorized person accessed the evidence" → chain of custody.

### Validating data integrity — the hash workflow

Every artifact gets hashed at acquisition and re-hashed at every analysis step. Hashes match, evidence is unchanged. They don't, the artifact may be inadmissible.

1. Hash the source (when possible — sometimes you only get one read).
2. Acquire the image.
3. Hash the image.
4. Verify source hash == image hash.
5. Store hashes in chain-of-custody documentation, separately from the evidence.
6. Re-hash the working copy before each analysis pass. Never analyze the original — always work from a verified duplicate.

**Algorithms:** SHA-256 is the modern standard. MD5 and SHA-1 are still seen in legacy tooling (FTK Imager defaults to both) but are cryptographically broken. Best practice is dual-hash (SHA-256 + MD5) so older tools can still verify.

> **CompTIA exam trap:** MD5 collisions exist, but MD5 is still acceptable for evidence integrity in many jurisdictions because the threat model is *accidental modification*, not *adversarial second-preimage attacks*. The nuanced answer is "yes for integrity verification, no as the sole modern standard." Pick SHA-256 if it's an option.

### Legal hold

A formal directive — issued by legal counsel — that suspends normal data retention and destruction policies for any data potentially relevant to anticipated or active litigation, regulatory action, or investigation.

When legal hold fires:

- Email auto-deletion pauses for named custodians
- Backup rotation pauses (the tape about to be overwritten gets pulled)
- Endpoint re-imaging pauses for affected hosts
- Cloud workspace retention extends
- Departing employees' accounts are preserved, not decommissioned

Triggers: subpoena, regulatory inquiry, breach disclosure that may lead to litigation, EEOC complaint, internal investigation that may go external. Failure to honor legal hold is **spoliation of evidence** — sanctions range from adverse inference instructions to default judgment. Companies have lost cases purely because IT auto-deleted mailboxes after legal hold was issued.

*Legal hold is the one process where IT gets a non-negotiable order from outside the change board. Treat it that way.*

### Scope, impact, and what to acquire

You can't image every endpoint. Scope and impact drive priorities:

- **Scope:** which hosts, accounts, data stores, network segments are confirmed or suspected compromised? Acquire all of them, plus one hop out (the jump box the attacker pivoted through, even if it looks clean).
- **Impact:** what data was accessible? PII, PHI, source code, executive mailboxes? High-impact gets full forensic acquisition. Low-impact gets triage collection (KAPE-style targeted artifact pull).

Pull SIEM exports, EDR telemetry, firewall logs, DNS logs, proxy logs, auth logs **into an evidence repository before analysts touch them in production**. Production logs roll. The 90-day DNS log you needed becomes the 89-day-ago log you don't have. Export, hash, preserve, then analyze.

### Compensating controls during recovery

While evidence is being acquired, the business still has to run. **Compensating controls** reduce risk while the original control is rebuilt:

- Compromised VPN account → disable account, force MFA re-enrollment for the user's department
- Compromised web server → WAF in blocking mode, IP allowlist
- Compromised admin workstation → all privileged access moves to a clean PAW for 30 days

They don't replace remediation. They buy time until [[Remediation]] and re-imaging complete.

## SOC reality

- The 3am alert is "EDR detected credential dumping on FINANCE-the primary DC." Your first action is **not** to log into the box. It's to invoke EDR network containment, page the IR on-call, and start the acquisition checklist.
- The IR lead asks three questions in order: **scope** (how many hosts?), **impact** (what data was accessible?), **evidence preserved** (RAM captured? disk imaged? hashes documented?). If you can't answer the third, you stop everything and answer it.
- Never tell leadership "we've contained it" until acquisition is complete, the host is isolated, and you've verified no lateral movement in the last 24h of logs. "Contained" is a legal word now — it shows up in breach notifications.
- Handoff: L1 detects and triages → L2 validates and scopes → IR team owns acquisition and preservation → legal owns chain of custody and hold notifications → executive owns external comms. Cross those wires and somebody talks to a regulator who shouldn't have.
- 80% of "incidents" turn out to be tuned-out noise. The 20% that are real — your evidence handling is the only thing standing between the company and a six-figure legal bill on top of the breach.

## Related concepts

[[Incident Response Lifecycle]] · [[Chain of Custody]] · [[Indicators of Compromise (IoC)]] · [[Containment Eradication and Recovery]] · [[Forensic Imaging]] · [[Memory Forensics]] · [[SIEM]] · [[EDR-XDR]] · [[Legal Hold]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Data Retention Policy]]

*Source: VIRGIL knowledge base — 2026-05-11*