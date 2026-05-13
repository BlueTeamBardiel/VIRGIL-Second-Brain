# Managing Change Control

## What it is

In **Call of Duty: Modern Warfare**, the "Clean House" mission drops you into a townhouse stack-up — Price calls the breach, every operator has a pre-assigned door, a pre-assigned corner, a pre-assigned target. Then somebody hears a baby cry through a wall and the whole plan inverts mid-stack. Price doesn't shoot first and document later. He still calls it — "hold fire" — over comms, every operator hears it, every operator acknowledges. The deviation gets called, logged, and absorbed into the op. That's exactly what emergency change control does — when the building is on fire you can skip the change advisory board, but somebody still has to call it on comms and write it down after.

**Plain English:** Change control is the process that says nobody touches production without a ticket, a reviewer, a rollback plan, and an approval. **Emergency change control** is the carve-out for when waiting for the weekly CAB meeting means the breach gets worse. You're allowed to act fast. You are not allowed to act invisibly.

**Technical (CS0-003 framing):** Change control is the governance layer that gates modifications to systems, configurations, and code. During an incident, IR teams routinely push **compensating controls**, isolate hosts, re-image endpoints, or block IPs at the perimeter — every one of those is a change. The standard process (request → review → approve → schedule → implement → verify → close) gets compressed into an **emergency change** workflow: act now, document concurrently, retroactively review at the next CAB. Failure to integrate emergency changes back into standard change management is how organizations end up with undocumented firewall rules nobody can explain three years later.

## Why it matters

**Career relevance:** Every IR engagement you ever run will require changes — firewall rules, AD password resets, EDR isolation actions, DNS sinkholing, account disablement. If you push them without a paper trail, the audit team eats you alive, the legal team can't defend the response, and the next analyst who comes through can't tell your emergency block from a misconfiguration.

**Real-world stakes:** Emergency changes that never get retrofitted into standard change management are the #1 source of configuration drift. Drift is how you fail your next PCI audit. Drift is how the "temporary" firewall exception from the 2023 incident is still there in 2026, now being used by an attacker who found it.

**Exam relevance:** CS0-003 Objective 3.2 lists this explicitly under incident response activities — CompTIA wants you to know that containment, eradication, and recovery actions are *changes* that ride on a change management process, and that emergency procedures exist specifically so IR doesn't get blocked by Tuesday-afternoon CAB meetings.

## Key facts

### The standard change control flow

| Phase | What happens | Who owns it |
|---|---|---|
| Request | Ticket filed (RFC — request for change) | Engineer / IR analyst |
| Review | Technical review, risk scoring, rollback plan | Change manager + peer reviewer |
| Approve | CAB (Change Advisory Board) signs off | CAB / change manager |
| Schedule | Maintenance window assigned | Change manager |
| Implement | Change executed | Engineer |
| Verify | Post-change validation, monitoring | Engineer + ops |
| Close | Ticket closed, documentation final | Change manager |

This is the calm-day path. Nothing in here matches the tempo of an active intrusion.

### Emergency change control — the IR-friendly path

Emergency changes are a recognized, sanctioned bypass. They exist because the standard path takes days and a ransomware operator takes hours. The rules:

- **Pre-authorized scope.** The IR team has a standing authorization to take certain actions during a declared incident — isolate endpoints, block IPs, disable accounts, kill processes. This is written into the IR plan during [[Preparation]] (the first phase of the NIST lifecycle). If it isn't, you're negotiating authority during the fire.
- **Document concurrently.** You don't wait until after. The analyst running the keyboard updates the ticket as actions are taken. Timestamps, host names, command run, output observed.
- **Single approver, not a committee.** Emergency changes get approved by the IR commander, on-call director, or designated change authority — not the full CAB. One throat to choke.
- **Retroactive CAB review.** Every emergency change goes to the next CAB meeting for review. The CAB doesn't *approve* it — it already happened — but it does *ratify*, *integrate*, and decide if the change becomes permanent or gets backed out.
- **Rollback plan still required.** "We'll figure it out later" is not a rollback plan. Even in an emergency, you need to know how to undo the firewall block when the threat is gone.

### Changes IR pushes during the lifecycle

Mapping common IR actions to the change control they trigger:

| IR action | Lifecycle phase | Change type |
|---|---|---|
| Network segment a compromised VLAN | Containment | Emergency |
| EDR isolation of a host | Containment | Pre-authorized (no ticket needed if in IR plan) |
| Block C2 IP at perimeter firewall | Containment | Emergency |
| Disable compromised AD account | Containment | Emergency |
| Apply compensating control (WAF rule, ACL) | Containment | Emergency |
| Re-image endpoint | Eradication | Standard (planned during recovery) |
| Force password reset, domain-wide | Eradication | Emergency |
| Restore from backup | Recovery | Standard |
| Patch the exploited CVE | Recovery | Standard |
| Update SIEM detection rules | Post-incident | Standard |

Containment work is almost always emergency. Recovery work is almost always standard — by the time you're rebuilding, the fire is out and you have time to do it right.

### Compensating controls — the emergency-change special case

A **compensating control** is a temporary mitigation when the proper fix isn't available yet. The patch isn't out, the vendor hasn't responded, the legacy system can't be touched without breaking the business. So you wrap it: WAF rule, network ACL, host-based firewall, additional logging. CompTIA loves this term.

Every compensating control is an emergency change. Every compensating control needs an expiration date or a review date. *The compensating control that becomes permanent without a CAB decision is the technical debt that eats your next audit.*

### Evidence preservation under change pressure

Here's where change control collides with [[Chain of Custody]] and [[Evidence Acquisition]]: the change you push during containment can destroy evidence. Killing a process clears memory. Re-imaging an endpoint nukes the disk. Disabling an account changes AD timestamps.

The order matters: **acquire first, change second.** Memory capture before you kill the process. Disk image before you re-image. Logs exported before you rotate them. The IR plan and the change procedure both need to reference this — if the procedure says "isolate immediately," the analyst needs to know that isolation in EDR usually preserves the live system for triage, while *power off* destroys volatile evidence.

[[Legal Hold]] adds another wrinkle. If counsel has put a hold on systems related to the incident, even routine changes (log rotation, patching, re-imaging) can violate the hold. Change control during an active legal hold needs legal review baked into the emergency path.

### Validating data integrity post-change

After any IR change, validate:

- **Hash the evidence** — MD5/SHA-256 of acquired images, before and after transport
- **Confirm the change took** — the firewall rule actually loaded, the account is actually disabled
- **Confirm no collateral damage** — the block didn't take out a production segment
- **Monitor for adversary response** — attackers notice when you block their C2. They pivot. The next 24 hours after containment is when you find the second foothold.

### CompTIA exam traps

> **CompTIA exam trap:** Emergency changes don't skip documentation — they skip the *waiting period* for approval. The trap answer says "emergency changes don't require CAB review." Wrong. They require *retroactive* CAB review. Documentation is never optional.

> **CompTIA exam trap:** A compensating control is not a fix. It's a wrapper. The exam will offer "patched the vulnerability" as the correct answer when the scenario describes a WAF rule blocking the exploit. The WAF rule is a compensating control; the vulnerability is still there. Right answer is usually "applied a compensating control while remediation is scheduled."

> **CompTIA exam trap:** Re-imaging is part of [[Eradication]], not Containment. CompTIA will put re-imaging in the containment phase as a distractor. Containment stops the bleeding; eradication removes the adversary; recovery restores service. Re-image lives in eradication.

> **CompTIA exam trap:** Pre-authorized actions in the IR plan are not the same as standing change approval. The exam loves the phrase "standing authorization." It means specific, named actions the IR team can take without a ticket — *not* a blank check.

## SOC reality

- **The 3am call:** L1 sees a confirmed ransomware payload detonating on a file server. They have pre-authorized EDR isolation. They click isolate, open the IR ticket, and *then* page the IR lead. The change is documented in the ticket before the IR lead picks up the phone. If L1 isolates without ticketing, the post-incident review goes badly.
- **What the IR commander asks first:** "What have you changed?" Not "what happened" — that comes second. The commander needs the running list of every block, every isolation, every account disable, so the next decision doesn't fight the last one.
- **What you never tell the CISO:** "We made some firewall changes, I'll document them tomorrow." If it isn't ticketed by end of shift, it didn't happen — and when the auditor asks in six months why TCP/4444 is blocked outbound from the DMZ, nobody will remember.
- **The CAB conversation after the incident:** Every emergency change goes on the agenda. Each one gets a decision: keep, modify, or back out. The "keep" decisions become permanent baseline. The "back out" decisions get scheduled. The "modify" decisions get a follow-up ticket. Nothing stays in limbo.
- **Handoff point:** L1 isolates and documents → L2 confirms scope and applies broader compensating controls → IR lead authorizes eradication changes (password resets, re-imaging) → change manager schedules recovery work as standard changes → CAB ratifies the emergency changes at the next meeting → post-incident review feeds lessons learned back into the IR plan and standing pre-authorizations.

## Related concepts

[[Incident Response Lifecycle]] · [[Containment Eradication Recovery]] · [[Compensating Controls]] · [[Chain of Custody]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[Preservation]] · [[Re-imaging]] · [[Validating Data Integrity]] · [[Isolation]] · [[Scope and Impact]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Configuration Management]] · [[Change Advisory Board]]

*Source: VIRGIL knowledge base — 2026-05-11*