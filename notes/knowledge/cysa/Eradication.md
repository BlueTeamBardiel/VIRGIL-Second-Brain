# Eradication

## What it is

In **Destiny**, when a Hive infestation takes root on a moon, you don't just shoot the Wizard and leave. You hunt the Shrieker hidden in the wall, you smash the Hive crystals seeding the corruption, you clear the Thrall closet that keeps respawning adds, and you go find the Ascendant realm portal the Wizard came through in the first place. Leave one rune burning and the whole nest grows back by next reset. That's eradication — and the Guardian who skips a step is the same Guardian who comes back next week to find the Lost Sector somehow worse than before.

In plain English, eradication is the step in incident response where you remove everything the attacker left behind — malware, backdoors, scheduled tasks, rogue accounts, persistence keys, modified binaries, dropped tooling, the lot — and you fix the hole they came in through. Containment stops the bleeding. Eradication kills the infection.

Technically: eradication is the phase of the NIST SP 800-61 incident response lifecycle (Preparation → Detection & Analysis → **Containment, Eradication, and Recovery** → Post-incident Activity) where the responder removes all attacker artifacts and addresses the vulnerabilities or misconfigurations that enabled the intrusion. It happens *after* containment has limited the spread, and *before* recovery restores normal operations.

## Why it matters

Skip eradication and you reinfect. Every IR veteran has watched a team re-image one box, declare victory, and miss the scheduled task on a domain controller that pulled the implant back down 48 hours later. The board sees "incident closed." The attacker sees "free re-entry."

For the [[CySA+]] exam (Objective CS0-003 3.2 — incident response activities), eradication shows up as the phase where you perform **remediation**, **re-imaging**, **compensating controls** when full remediation isn't possible yet, and **root cause analysis** to make sure the same hole doesn't get punched twice. CompTIA tests the *order* of the phases hard, and tests the distinction between eradication (kill the artifacts) and recovery (restore the systems).

Operationally, eradication is where the SOC hands off to engineering and where engineering hands off to architecture. Three teams, one decision: are we sure it's gone?

## Key facts

### What eradication actually removes

The goal is total artifact removal. Anything the attacker touched, dropped, or scheduled:

| Artifact class | Examples |
|---|---|
| **Malware** | Implants, RATs, ransomware payloads, stagers, loaders |
| **Persistence** | Registry Run keys, scheduled tasks, services, WMI subscriptions, cron jobs, systemd units, launch daemons |
| **Backdoors** | Web shells, SSH keys, reverse-tunneled accounts, rogue admin accounts |
| **Credential artifacts** | Cached hashes, Kerberos tickets, golden/silver tickets, API keys the attacker minted |
| **Tooling left on disk** | Mimikatz, Cobalt Strike beacons, PsExec, network scanners, exfil utilities |
| **Config modifications** | Firewall rule changes, GPO edits, AD permission changes, modified binaries |
| **Network artifacts** | Reverse tunnels, modified routes, rogue VPN configs |

If you can't enumerate it, you can't eradicate it. This is why [[Data and log analysis]] from the Detection & Analysis phase feeds directly into eradication — the IoCs you found earlier are the kill list now.

### Re-imaging vs. surgical cleanup

The cleanest eradication is **re-imaging from known-good baseline**. Wipe the disk, reinstall the OS from gold image, restore data from a backup that predates the compromise, rotate every credential that touched the host. Done.

Surgical cleanup — finding and deleting individual artifacts on a running system — is faster but riskier. You don't know what you don't know. Modern attackers chain persistence: kill one mechanism and another wakes up. The rule of thumb:

- **Re-image when:** the host is in scope of a confirmed intrusion, had SYSTEM/root-level compromise, ran credential-theft tooling, or is critical enough that "probably clean" isn't good enough.
- **Surgical cleanup when:** the artifact is well-understood, the persistence is fully mapped, re-imaging cost is genuinely prohibitive (rare), and you can monitor closely post-cleanup.

When in doubt, re-image. The hours you save on surgical cleanup get repaid with interest the first time you find the implant came back.

### Root cause analysis (RCA)

Eradication isn't done when the artifacts are gone. It's done when you know **how they got there** and you've fixed that.

RCA answers:
- What was the initial access vector? Phishing? Exposed RDP? Unpatched [[CVE]]?
- What control failed or was missing? No MFA? No EDR? No egress filtering?
- Which other systems share that same weakness?
- What detection gap let it sit undetected?

> **CompTIA exam trap:** Root cause is *not* attribution. Identifying that the initial vector was a phishing email with a malicious macro is RCA. Identifying that APT29 sent that email is attribution. CompTIA will write a question where the "right" answer sounds like attribution but is actually RCA, or vice versa. RCA = the *why* of the control failure. Attribution = the *who* of the threat actor. Different jobs, different deliverables.

RCA feeds Post-incident Activity (lessons learned, control improvements) but it lives *inside* eradication because you can't claim the threat is eradicated if you haven't closed the hole. Kill the Wizard, sure — but if you don't seal the portal, the next Wizard walks through on Tuesday.

### Compensating controls

Sometimes you can't fix the root cause immediately. The vulnerable system runs a 2009 industrial controller. The patch breaks production. The vendor is out of business. The fix requires a 6-week change window.

**Compensating controls** are temporary mitigations that reduce risk while the real fix gets scheduled:

- Additional firewall rules isolating the box
- Increased logging and SIEM alerting on that asset
- Restricted access (network segmentation, jump-host-only, MFA on the way in)
- Application allowlisting
- Manual approval workflows for sensitive operations

Two rules: (1) compensating controls are **temporary** — write the ticket, set the date, track to closure. (2) They must be **revisited** — the change-board reality is that "temporary" becomes "forever" if nobody owns the cleanup. *I have personally watched a "temporary" firewall rule survive three CISOs.*

### Validating eradication

You don't get to declare eradication complete on vibes. You validate:

1. **Re-scan with updated IoCs.** The IoCs from this incident go into the [[SIEM]] and [[EDR]] as detection rules. Run them against the whole environment, not just the known-affected hosts.
2. **Hunt for the persistence techniques used.** If the attacker used scheduled tasks, sweep all scheduled tasks across the fleet for anomalies.
3. **Verify credential rotation.** Every credential that existed on a compromised host is burned. Service accounts, local admin, cached domain creds, API keys, certs.
4. **Confirm patches/config changes are applied** to all vulnerable systems, not just the one that got popped.
5. **Validate data integrity.** Hash compare critical files against known-good. Confirm backups weren't tampered with before restoration.

### Eradication and the evidence chain

Eradication is destructive. The moment you wipe a disk, the forensic evidence on it is gone. Before you eradicate:

- **Evidence acquisition** is complete (disk image, memory dump, network captures)
- **Chain of custody** is documented for every artifact pulled
- **Legal hold** is honored — if litigation or regulatory action is possible, preservation overrides cleanup speed
- **Preservation** of artifacts continues even after eradication (you may need them in 18 months for the lawsuit)

> **CompTIA exam trap:** Eradication and evidence preservation can conflict. CompTIA will ask the order — preserve first, eradicate second. Never wipe a host before the forensic image is taken and verified (hash matched, write blocker used during acquisition). The pressure to "clean up and move on" is real, but a defensible incident report needs the evidence.

### Where eradication sits in the lifecycle

```
Preparation
    ↓
Detection & Analysis  ← IoCs discovered, scope determined
    ↓
Containment ← stop the bleed (isolation, network segmentation)
    ↓
ERADICATION ← remove artifacts, fix root cause, compensating controls
    ↓
Recovery ← restore from clean baseline, return to production, monitor
    ↓
Post-incident Activity ← lessons learned, control improvements
```

Containment is temporary (isolate the host). Eradication is permanent (clean the host and the cause). Recovery is restoration (bring it back online, validate it's healthy). CompTIA loves swapping these in a question stem.

### CompTIA exam traps

> **CompTIA exam trap:** "Containment, Eradication, and Recovery" is *one phase* in NIST SP 800-61, but the three sub-activities have a strict order: contain first, eradicate second, recover third. Questions that present scenarios mid-incident will test whether you recover before eradicating (wrong — you'll restore a compromised baseline) or eradicate before containing (wrong — the threat keeps spreading while you clean).

> **CompTIA exam trap:** Compensating controls are not the fix. They're the bridge to the fix. If a question asks "what is the remediation?" and the options include both the compensating control and the permanent patch, the permanent patch is the remediation. The compensating control is risk reduction during the gap.

## SOC reality

- **The 3am moment:** EDR alert fires for credential dumping on a domain controller. L1 escalates immediately. IR pulls the memory image *before* anyone reboots — reboot kills volatile evidence. Containment isolates the DC from the network. Eradication doesn't start until forensics says "image acquired, hash verified."
- **What the CISO asks:** "Are we sure it's gone?" The honest answer is "we've removed every artifact we know about and re-imaged the affected hosts, rotated credentials, and added detection rules for the techniques used. We are monitoring for resurgence." Never say "we've eradicated it" without qualifying the confidence level. *The incident I remember worst is the one where we said "contained" and meant "we hope."*
- **The handoff:** SOC L2 confirms IoCs and scope. IR team owns eradication decision-making (re-image vs. cleanup). Engineering executes the re-image. IAM rotates credentials. Architecture owns the root cause fix. Legal owns the legal hold determination. Five lanes, one incident commander.
- **Never promise leadership** that eradication is "complete" until you've run a sweep for the IoCs across the entire environment and waited through at least one beacon interval to confirm no callbacks. Attackers love delayed-action persistence.
- **The trap of speed:** Business will pressure you to recover fast. Recovery before eradication is how you restore the implant from your own backups. *Slow is smooth, smooth is fast.*

## Related concepts

[[Incident Response Lifecycle]] · [[Containment]] · [[Recovery]] · [[Root Cause Analysis]] · [[Compensating Controls]] · [[Re-imaging]] · [[Chain of Custody]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[Preservation]] · [[Data Integrity]] · [[Isolation]] · [[Remediation]] · [[Post-incident Activity]] · [[IoC]] · [[Persistence Mechanisms]] · [[SIEM]] · [[EDR]]

*Source: VIRGIL knowledge base — 2026-05-11*