# Recovery

## What it is

In **Dark Souls**, when you finally drop Ornstein and Smough, the fight isn't actually over. You walk forward, kindle the bonfire, then spend the next ten minutes doing the unglamorous work: repairing your weapon at the blacksmith, refilling Estus, restocking arrows, banking souls so the next death doesn't wipe your run, and — critically — walking the path back to make sure the shortcut elevator still works and no respawned hollows are camping the route. The boss is dead. The zone is *not* yours yet. You're rebuilding the loop so you can keep playing without losing what you just earned.

That's exactly what Recovery does — it's the slow, deliberate work of putting the environment back into a trustworthy production state after the threat has been removed.

Technically: **Recovery** is the fourth beat inside the CompTIA / NIST SP 800-61 Containment, Eradication, and Recovery phase. After containment isolated the bleed and eradication removed the adversary's presence (malware, accounts, persistence, implants), recovery restores affected systems to normal operations, validates they're clean, hardens them against repeat, and monitors closely for resurgence. It is **not** "we re-imaged the box, ticket closed." It is the bridge between an incident being technically over and the business being able to trust the asset again.

## Why it matters

Recovery is where most IR programs quietly fail. The breach gets contained, the malware gets scrubbed, leadership wants the win declared, and someone rushes a server back online with the same misconfiguration that let the attacker in. Two weeks later, same actor, same vector, same room — except now the SOC has lost credibility with the business.

CompTIA tests this hard under **Objective 3.2 — incident response activities**, and the trap is almost always sequencing: recovery comes *after* eradication, validation comes *before* you tell the business it's safe, and lessons-learned (the post-incident phase) comes *after* recovery, not in parallel with it.

In the field, recovery is the phase where the CISO finally asks the question you've been dreading: *"Are we good?"* The honest answer is never yes immediately. The honest answer is *"We're monitoring. Here's what we restored, here's what we validated, here's what we're watching for the next 30 days."*

## Key facts

### Recovery objectives

Three goals, in order of priority:

1. **Restore normal operations** — bring affected systems and services back into the production environment safely.
2. **Validate** — confirm the restored systems are clean, hardened, and behaving as expected. Security controls active, integrity intact, logging flowing.
3. **Reduce likelihood of recurrence** — apply [[Compensating controls]] and lessons from the incident before the attacker (or their twin) comes back.

If you skip step two, step one and step three are theater.

### Re-imaging vs. cleanup

| Approach | When to use | Risk |
|---|---|---|
| **Re-imaging** (wipe and rebuild from gold image) | Confirmed malware, rootkit, persistence mechanism, or unknown depth of compromise | Slow, disruptive — but the only way to be sure |
| **Cleanup in place** | Surface-level compromise, single artifact removed, behavior fully understood | Fast — but you're trusting that you found everything |
| **Restore from backup** | Ransomware, destructive incident, integrity unknown | Backup must predate compromise *and* be validated clean |

The default for any non-trivial endpoint compromise is **re-imaging**. *I learned this the hard way watching a "cleaned" workstation beacon out to the same C2 four days later — the actor had dropped a scheduled task we missed because the EDR was tuned to alert on process execution, not persistence enumeration.*

### Validating data integrity

Before a system is declared recovered, the responder verifies:

- **Account audit** — only authorized accounts exist. No leftover attacker-created users, no enabled service accounts that should be dormant, no local admins added during the intrusion.
- **Permissions follow least privilege** — group memberships restored, no escalation residue (e.g., a workstation user still in Domain Admins).
- **Configuration baseline** — no unauthorized changes to registry, scheduled tasks, startup items, firewall rules, GPOs, or trust relationships.
- **Logging restored** — endpoint agents (EDR, Sysmon) are reporting, log forwarding to SIEM is healthy, retention is configured.
- **Vulnerability scan** — credentialed scan against the restored asset to confirm patches applied and the original entry vector is closed.
- **File integrity** — checksums/hashes of critical binaries match the known-good baseline. This is where [[File integrity monitoring]] earns its keep.

### Chain of custody and legal hold during recovery

Recovery does **not** mean you destroy evidence. If the incident may involve regulatory reporting, litigation, insurance claims, or law enforcement, a **legal hold** is in effect — meaning the original compromised disks, memory captures, and logs must be preserved untouched even as you bring replacement systems online.

The pattern:

- Original system → forensic image acquired during detection/analysis → preserved under chain of custody → **do not wipe**
- Replacement system → built fresh from gold image → restored to production
- Hash both images. Document everything. The [[Chain of custody]] log lives or dies on signatures and timestamps.

> **CompTIA exam trap:** Re-imaging the affected host before forensic acquisition is wrong, even if the business is screaming for the system back. The correct sequence is **acquire evidence → preserve under chain of custody → then** re-image or rebuild. CompTIA will offer "re-image immediately to restore service" as a tempting answer. It's wrong when legal hold or evidence preservation applies.

### Compensating controls

When the root cause can't be fully remediated immediately — legacy application that can't be patched, ICS device the vendor won't certify on a new OS, business process that depends on a deprecated protocol — you deploy **compensating controls**: alternate measures that reduce risk to an acceptable level until the real fix lands.

Examples:

- Legacy app needs SMBv1 → segment it onto an isolated VLAN with strict ACLs, monitor every connection
- Server can't be patched this cycle → virtual patching at the WAF, IPS signature deployed, enhanced logging
- User group must keep local admin → enforce LAPS, session recording, [[Privileged access management]]
- Vulnerable service must stay exposed → rate-limit, geo-block, deploy a reverse proxy with WAF

Compensating controls are recovery's bridge. They are not the fix. *Document every one of them with an expiration date or they become permanent technical debt.*

### Monitoring after restoration

The single highest-value action in recovery is **enhanced monitoring** of the restored asset for 30–90 days. The original threat actor knows the environment now. If your eradication missed anything, this is when it shows up.

Tune SIEM rules to:

- Alert on any connection from the restored host to known [[Indicators of compromise]] from the incident
- Alert on the specific behavioral patterns (parent-child process anomalies, off-hours auth, beacon-like network timing) observed during the intrusion
- Lower the threshold for this asset specifically — false positives are acceptable here, missed resurgence is not

### Scope and impact reassessment

Recovery often surfaces facts that change the scope of the incident. While restoring System A you discover lateral movement artifacts pointing to System B that nobody scoped. **Recovery is not a one-way door** — if new evidence emerges, the IR team loops back to detection/analysis and re-scopes. Containment may need to expand. Eradication may need a second pass.

This is why the phases are written as a cycle, not a line.

### Data and log analysis during recovery

The recovery phase is when you finally read all the logs you didn't have time to read at 3am. Patterns emerge: the actor's working hours, their tooling, their dwell time, the accounts they touched but didn't use. This data feeds two things — the post-incident lessons learned report, and tuning for the SIEM/EDR going forward. *Every incident should leave the environment harder to compromise than it was before. If it doesn't, the recovery phase was incomplete.*

### CompTIA exam traps

> **CompTIA exam trap:** Recovery and post-incident activity are **separate phases**. Recovery is restoring operations and validating. Post-incident is lessons learned, root cause analysis, and process improvement. CompTIA will blur the line — keep them distinct.

> **CompTIA exam trap:** "Restore from backup" is not automatically the right answer for ransomware. The backup must be **validated clean** (predates the compromise, integrity verified, scanned for dormant payloads). A backup taken three days into the dwell period restores the malware along with the data.

> **CompTIA exam trap:** Compensating controls are not "the fix." They reduce risk until the real remediation is possible. An exam question describing a long-term compensating control without a remediation plan is describing **risk acceptance**, not mitigation.

## SOC reality

- The 3am alert is long over. Recovery is the 9am meeting where the asset owner asks when their server is back, and you have to say *"after we validate, not before."* That conversation is the job.
- L1 hands off to L2 / IR engineer for the actual rebuild. L1's recovery-phase task is usually **monitoring the restored asset** with tuned alerts and escalating anything that looks like resurgence.
- The CISO asks three questions: **scope** (what was touched), **impact** (what was lost or exposed), **evidence preserved** (can we defend this in court / to the regulator / to the insurer). Have the answers written down before the meeting, not during it.
- Never tell leadership "we've fully recovered" — say "we've restored service and we're in enhanced monitoring through [date]." The first phrasing ends your career when the actor comes back. The second phrasing is honest.
- The handoff out of recovery is into **post-incident activity** — the retro, the lessons learned, the report. If your organization skips that meeting, the next incident is already pre-written.

## Related concepts

[[Containment]] · [[Eradication]] · [[Incident response lifecycle]] · [[Chain of custody]] · [[Legal hold]] · [[Evidence acquisition]] · [[Compensating controls]] · [[File integrity monitoring]] · [[Indicators of compromise]] · [[Post-incident activity]] · [[Lessons learned]] · [[Root cause analysis]] · [[Vulnerability scanning]] · [[Privileged access management]] · [[Business continuity]]

*Source: VIRGIL knowledge base — 2026-05-11*