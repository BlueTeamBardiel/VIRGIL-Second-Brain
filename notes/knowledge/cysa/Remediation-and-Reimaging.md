# Remediation and Reimaging

## What it is

In **Forza Motorsport**, you wreck a car badly enough — frame twisted, suspension geometry off, engine block cracked — and the smart move isn't to keep duct-taping panels back on between races. You go to the garage, you rebuild from the known-good blueprint, you re-tune from a saved setup, and you roll back onto the track with a car you can actually trust at 180mph. Trying to "repair" a car with a bent chassis at race pace gets you killed in turn one. That's exactly what remediation and reimaging does — when a host gets owned, you don't scrub it clean and hope, you flatten it and rebuild from a known-good image.

**Remediation** is the full set of actions taken to remove an attacker's foothold and return the affected systems to a trusted state. **Reimaging** is the specific technique of wiping a compromised host and restoring it from a validated golden image. It sits inside the **Containment, Eradication, and Recovery** phase of the NIST SP 800-61 incident response lifecycle, and it's the moment where IR stops being investigation and starts being construction.

The core operating assumption: **a compromised system is untrustworthy until proven otherwise, and proving otherwise is harder than rebuilding.** Hidden persistence — scheduled tasks, WMI subscriptions, rootkits, firmware implants, malicious service binaries renamed to look legitimate — survives most "cleanup" attempts. Reimaging defeats persistence by destroying the substrate it lives on.

## Why it matters

Bad remediation is how a 48-hour incident becomes a 6-month dwell-time disaster. The attacker plants three persistence mechanisms, you find two, you "clean" the box, you put it back in production, and 11 days later the third mechanism beacons home and they're back in with the lights off. Every IR retro I've sat through where the org got hit twice in a quarter — same actor, same TTPs — the root cause was incomplete eradication.

Exam relevance: **CS0-003 Objective 3.2** explicitly lists *re-imaging*, *remediation*, *compensating controls*, *validating data integrity*, and *preservation* as IR activities. CompTIA will test the order, the prerequisites (root cause before restore), and the difference between containment, eradication, and recovery. They love asking what the analyst does *before* hitting the reimage button — because most candidates skip the evidence step.

## Key facts

### Rebuild vs repair — the trust question

| Approach | When to use | Risk |
|---|---|---|
| **Repair / clean** | Low-severity malware, well-understood scope, no privilege escalation, no persistence mechanisms found | Hidden persistence survives; attacker returns |
| **Reimage** | Any confirmed compromise involving admin/SYSTEM, lateral movement origin, unknown malware, APT activity | Data loss if backups aren't validated; downtime |
| **Replace hardware** | Suspected firmware/BIOS/UEFI implants, supply-chain compromise, persistent rootkit below the OS | Cost, lead time |

The default for any confirmed intrusion above commodity malware is **reimage**. "Just run the AV scan again" is not an eradication plan — it's a prayer.

### The order of operations (do not skip steps)

1. **Preserve evidence first.** Before you wipe anything, acquire what you need. Memory dump (RAM is gone the second you power off), full disk image, relevant logs pulled to a separate evidence store. **Chain of custody** documented for every artifact: who acquired, when, hash value (SHA-256), where it's stored, who touched it next.
2. **Validate data integrity.** Hash the acquired images. Record the hash. Any time evidence moves, re-hash and compare. If the hash changes, the evidence is contaminated and likely inadmissible.
3. **Apply legal hold** if litigation, regulatory action, or law enforcement involvement is even possible. Legal hold suspends normal data destruction policies — no retention-policy auto-deletes, no overwriting of backup tapes, no reimaging of the evidence-source host until counsel releases it.
4. **Identify root cause.** What CVE, what misconfiguration, what stolen credential, what phishing payload? If you reimage without knowing the entry vector, you're rebuilding the same vulnerable system the attacker already knows how to own.
5. **Isolate the host** from the network before rebuild. Air-gap or VLAN-quarantine. Containment must hold during the rebuild window.
6. **Reimage from validated golden image.** Not from a backup taken last week — that backup might contain the attacker's persistence.
7. **Patch and harden** before returning to production. New baseline must include the patch for the root-cause vulnerability.
8. **Rotate all credentials** that touched the host — local admin, service accounts, cached domain credentials, API keys, certificates, SSH keys. Assume everything that ever authenticated to that box is burned.
9. **Monitor closely** for re-compromise. Tune detections specifically for the TTPs observed.

> **CompTIA exam trap:** The wrong answer is "reimage immediately to restore service." The right answer is *preserve evidence and identify root cause first*. CompTIA tests the prerequisites, not the action. If the scenario mentions ongoing exfiltration or active C2, **isolation** comes before evidence work — you stop the bleeding, then preserve.

### Validating backups before you restore

Backups are not automatically trustworthy. The attacker may have been resident for weeks before detection — your last three backups could be poisoned. Before restoring:

- **Determine compromise window.** When was the earliest IoC? Backups from before that window are candidates; everything after is suspect.
- **Scan the backup itself** in an isolated environment with updated signatures and behavioral tooling.
- **Verify integrity hashes** against the original backup-creation hashes if you have them.
- **Test restore in a sandbox** before pushing to production.
- **Never restore the same vulnerable configuration** that got compromised. Patch and harden the image, then restore data on top.

*I learned this the hard way during a ransomware engagement where the org restored from a 14-day-old backup that already had the actor's web shell sitting in IIS. They were re-encrypted in 72 hours.*

### Compensating controls during the rebuild window

You can't always patch or reimage immediately. Maybe the vulnerable system is a 15-year-old SCADA controller. Maybe the vendor patch breaks the application. Maybe the change board won't approve the maintenance window for two weeks. **Compensating controls** are the temporary measures that reduce risk while real remediation is pending:

- **Network segmentation** — drop the vulnerable host into a restricted VLAN with explicit allow-listing
- **Application allow-listing** — only signed, approved binaries execute
- **Virtual patching** — WAF or IPS signature blocks the exploit path even though the underlying CVE remains
- **Enhanced logging and monitoring** — if you can't fix it, watch it closer
- **Account restrictions** — reduce who can authenticate to the host; remove from privileged groups
- **MFA enforcement** on every access path

Compensating controls are not remediation. They are a *time-bought* defensive posture while remediation is engineered. Document them, track them, and burn them down — every compensating control accumulates technical debt.

### Scope, impact, and what you're actually rebuilding

Before you decide what to reimage, you have to know what was touched. **Scope** is the set of affected systems, accounts, data stores, and network segments. **Impact** is what the compromise actually achieved — data exfiltrated, services degraded, credentials stolen, lateral movement reach.

Get this wrong and you reimage three hosts when you should have reimaged thirty. The **data and log analysis** that came out of the Detection and Analysis phase feeds directly into scope determination — IoCs from one host become hunt queries across the fleet. Authentication logs, EDR telemetry, [[NetFlow Analysis]] data, DNS logs — pull them together to map every system the attacker authenticated to, executed code on, or pivoted through. **Every host in scope gets reimaged.** Not "monitored extra carefully." Reimaged.

### Re-imaging mechanics in practice

- **Golden image** — a maintained, patched, hardened base build that's regularly updated. The IR team should never have to scramble for one mid-incident.
- **Configuration management** (Ansible, SCCM, Intune, Puppet) — pushes the standard config onto the freshly imaged host so it returns to production in a known state, not a hand-built snowflake.
- **Driver and application reinstall** — from trusted repositories only. Never from a local backup of the compromised host.
- **Data restoration** — user data and application data restored from validated backups, scanned before mount.
- **Reintroduction to network** — done in stages. Quarantine VLAN first, with monitoring. Production VLAN only after the host proves clean for a defined observation window.

### What about firmware and below-OS persistence?

Reimaging the OS does not touch:
- BIOS/UEFI firmware
- Baseboard management controller (BMC/iLO/iDRAC) firmware
- Hard drive controller firmware
- Network card firmware
- TPM state

If the threat actor is sophisticated enough that firmware implants are in scope — nation-state actors, supply-chain compromise — reimaging is not enough. Hardware replacement is the remediation. This is rare but real, and it's the reason high-assurance environments destroy and replace rather than reimage.

> **CompTIA exam trap:** *Sanitization vs reimaging vs destruction.* Sanitization (DoD wipe, cryptographic erase) prepares media for reuse or disposal. Reimaging restores a host to a trusted operational state. Destruction (degaussing, shredding) renders media physically unrecoverable. CompTIA will mix these — read the question for whether the goal is *return to service* (reimage), *safe disposal* (sanitize/destroy), or *evidence preservation* (image, don't touch).

## SOC reality

- **The 3am call:** "Box is owned, EDR isolated it, what's next?" Your answer is never "reimage it." Your answer is "memory dump, disk image, hash, chain of custody started — then we talk rebuild." If you skip evidence, you're explaining that decision to legal in three weeks.
- **The CISO question:** "Are we sure it's gone?" The honest answer is *"the reimaged hosts are clean by construction, but until we've validated scope across the fleet and rotated credentials, we don't claim eradication."* Never promise the incident is closed before the post-incident review.
- **The change-board friction:** Reimaging means downtime. Business owners will push back hard on rebuilding their "perfectly fine" server. The IR lead's job is to translate technical risk into business risk — *"this host has confirmed attacker code execution; restoring it without rebuild creates regulatory exposure under our breach-notification obligations."*
- **The handoff:** L1 isolates and escalates. L2 / IR team handles evidence acquisition and scope determination. Sysadmins or platform engineering execute the actual reimage under IR direction. Legal owns the legal-hold call. CISO owns the customer-and-regulator communication.
- **The follow-up:** Two weeks after reimage, hunt specifically for the original TTPs across the entire environment. The attacker who got in once knows your environment now. Assume they'll try the same path with a different payload.

## Related concepts

[[Containment Eradication and Recovery]] · [[Chain of Custody]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[Data Integrity Validation]] · [[Compensating Controls]] · [[Root Cause Analysis]] · [[Indicators of Compromise]] · [[Isolation and Segmentation]] · [[Golden Image]] · [[Configuration Management]] · [[Post-Incident Activity]] · [[NIST SP 800-61]]

*Source: VIRGIL knowledge base — 2026-05-11*