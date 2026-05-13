# Remediation Workflow (Lifecycle Thinking)

## What it is

In **Elden Ring**, you don't beat Malenia by reading her moveset on the wiki and walking in cold. You scout her — eat the first Waterfowl Dance, die, watch the replay in your head, respec into bleed, swap to a shield that doesn't break on contact, summon Mimic Tear, pull her into the arena's left side where the camera behaves, *test the fix on the first phase*, get to phase two, die to Scarlet Aeonia, adjust again. The fight is a loop. Find weakness, apply fix, verify under pressure, escalate, repeat. The Erdtree didn't get fixed in one swing.

That's exactly what a **remediation workflow** is — a closed loop where every discovered vulnerability is owned, fixed, tested, rescanned, and then folded back into the baseline so the next scan knows the new normal.

Technical definition: the remediation workflow is the structured lifecycle by which a vulnerability management program moves a finding from **detection → ownership → fix → validation → closure → baseline update**. It's not a checklist; it's a feedback system. CompTIA tests it as a process, not a one-shot event.

The standard six-stage loop:

1. **Assign** — finding gets an owner (system, app, infra team)
2. **Fix** — apply patch, config change, or compensating control
3. **Test** — verify in a non-prod environment doesn't break business logic
4. **Rescan** — confirm with the same scanner that detected it
5. **Close** — ticket marked resolved with evidence
6. **Update baseline** — the new "good state" becomes what future scans compare against

## Why it matters

Vulnerability scanners produce thousands of findings. Most teams treat the scan report like a to-do list and miss the point: the *report is not the program*. The program is what happens between scans. If a CVSS 9.8 sits in a Jira ticket for 90 days because nobody owns it, the scanner did its job and the organization still gets popped.

CySA+ Objective **2.1** covers scan implementation, but every CySA+ domain — 2.0 management, 2.5 reporting, 4.0 lifecycle — assumes you understand that scanning without remediation workflow is just expensive noise. The exam asks process questions: *what comes after rescan? who owns this? what's the gating step before closure?* If you don't have the lifecycle memorized, you'll guess wrong.

Operationally, this is the difference between a SOC that drives down risk quarter over quarter and one that runs the same scan, files the same tickets, and watches the same CVEs age into next year.

## Key facts

### The six stages in detail

| Stage | What happens | Who owns it | Common failure |
|---|---|---|---|
| **Assign** | Finding routed to system owner via ticket | Vuln mgmt team → asset owner | "Nobody owns this server" — [[Asset Discovery]] gap |
| **Fix** | Patch, config change, or compensating control applied | System/app/infra team | Patch breaks dependency, gets rolled back silently |
| **Test** | Validate in dev/staging that fix doesn't break business logic | App team + QA | Skipped under deadline pressure, prod breaks |
| **Rescan** | Same scanner, same auth level, confirm finding gone | Vuln mgmt team | Uncredentialed rescan can't see what credentialed scan found |
| **Close** | Ticket resolved with evidence (scan diff, screenshot) | Vuln mgmt team | Closed without rescan — finding never actually verified |
| **Update baseline** | New state becomes the reference for future scans | Vuln mgmt + GRC | Baseline drifts, exceptions accumulate, debt compounds |

### Where the workflow ties into scanning concepts

- **[[Credentialed vs Non-credentialed Scanning]]** — rescan must match the original scan's auth level. If the original finding required credentials, the rescan does too. Otherwise you're closing tickets on faith.
- **[[Agent vs Agentless Scanning]]** — agent-based rescans are continuous; agentless rescans wait for the next scheduled window. Affects how fast you can close.
- **[[Internal vs External Scanning]]** — external rescan after an internal fix tells you whether the perimeter actually changed.
- **[[Static vs Dynamic Analysis]]** — for code findings (SAST/DAST), the rescan is a rebuild + retest, not a network scan.
- **[[Asset Discovery]]** — you can't assign a finding to nobody. Asset inventory is the prerequisite for stage 1.

### Special considerations — when the loop bends

CompTIA's objective 2.1 lists "special considerations" because the textbook six-stage loop assumes a normal Windows server. Reality:

- **[[Operational Technology]] / [[ICS]] / [[SCADA]]** — you don't patch a turbine controller on a Tuesday. Fix windows are measured in months, sometimes years. Compensating controls (segmentation, monitoring) often substitute for patching entirely. The "fix" stage becomes "document risk acceptance + isolate."
- **[[Critical Infrastructure]]** — regulatory reporting (NERC CIP, CIRCIA) layers on top of the workflow. Closure isn't just "rescan clean," it's "rescan clean + audit trail preserved + regulator notified if required."
- **[[Sensitivity Levels]]** — high-sensitivity systems (PHI, cardholder data, classified) get tighter SLAs and stricter testing gates. [[PCI DSS]] requires quarterly external ASV scans and all high/critical findings remediated before passing.
- **Performance** — rescans hit production. Schedule during low-traffic windows. Aggressive [[Fuzzing]] or [[Active Scanning]] rescans can DoS fragile services.
- **[[Segmentation]]** — sometimes the fastest "fix" is network isolation, not a patch. The workflow accepts this if the compensating control reduces risk to acceptable.
- **Regulatory requirements** — [[PCI DSS]], [[ISO 27001]], [[CIS Benchmarks]] all impose remediation timeframes. PCI: critical patches within 30 days. CIS: configuration drift remediated within defined windows.

### Automation vs human judgment

The whole loop can be partially automated:

- Ticket creation from scanner → ITSM (ServiceNow, Jira)
- Patch deployment via SCCM, Ansible, Intune
- Auto-rescan on ticket transition to "resolved"
- Auto-close on clean rescan

What *cannot* be automated:

- **Risk acceptance decisions** — does this CVSS 9.8 on an air-gapped lab box actually warrant emergency change?
- **Compensating control design** — when patching breaks the app, what segmentation/monitoring stack replaces the patch?
- **Exception lifecycle** — every accepted risk needs an expiration date and a re-review. Automation files them; humans renew or revoke.
- **Business impact tradeoffs** — the change board conversation where prod stability fights security urgency.

*An auto-closed ticket is not a remediated vulnerability. An auto-closed ticket is a claim that needs evidence.*

### Update baseline — the step everyone skips

The sixth stage is the one that makes the program *learn*. Without it:

- [[Security Baseline Scanning]] keeps flagging the same "deviation" because the baseline never moved
- New scans compare against stale reference data
- Accepted exceptions multiply silently until the exception list is longer than the finding list
- Configuration drift becomes invisible because there's no current ground truth

Baseline update means: the [[CIS Benchmarks]] reference document is updated, the gold image is rebuilt, the [[Device Fingerprinting]] data in the CMDB is refreshed, and the next scan window starts from the new normal.

### CompTIA exam traps

> **CompTIA exam trap:** The exam will ask what comes *after* the fix. The wrong answer is "close the ticket." The right answer is **rescan to verify**. Closure without rescan is a process failure — you have a claim, not evidence.

> **CompTIA exam trap:** "Update baseline" is the step candidates forget. CompTIA loves the ordered-list question where five steps are obvious and the sixth is missing. If the question shows Assign → Fix → Test → Rescan → Close and asks what's missing, the answer is **update the baseline / configuration management database**.

> **CompTIA exam trap:** Rescan auth level. If the original finding was discovered via [[Credentialed Scan]] and the rescan is uncredentialed, the finding may appear "resolved" because the scanner can't see deep enough to verify. The right rescan **matches or exceeds the original scan's depth**.

> **CompTIA exam trap:** For [[ICS]]/[[SCADA]]/[[OT]] environments, the standard remediation workflow does not apply directly. The exam will offer "apply patch immediately" as a tempting wrong answer. Right answer involves **compensating controls, segmentation, scheduled maintenance windows, and vendor coordination** — not Patch Tuesday.

> **CompTIA exam trap:** Risk acceptance is not closure. An accepted risk stays in the inventory with an owner, expiration date, and review cadence. Closing the ticket as "accepted" without those three attributes is an audit finding waiting to happen.

## SOC reality

- **The 3am page is rarely from this workflow** — vuln management runs on business hours and change windows. The 3am page is IR. But the *reason* you got paged at 3am is often a finding that sat in the workflow too long. Post-incident retros trace back to a Jira ticket aged 180 days.
- **L1 analyst's job here** — own the ticket queue. Verify rescans actually ran. Chase down assignees who marked "fixed" without evidence. The unsexy work that keeps the loop closed.
- **What the CISO asks** — "What's our remediation SLA hit rate this quarter? How many critical findings aged past 30 days? Show me the exception list and the expiration dates." Not "are we secure?" — that question is unanswerable. SLA hit rate is measurable.
- **Never promise** — "we patched it" until the rescan is clean and the baseline is updated. The patch can be installed and the vulnerability can still be live (service didn't restart, registry key didn't take, container image wasn't rebuilt).
- **Escalation path** — L1 owns ticket hygiene → L2 owns dispute resolution with system owners ("you marked this fixed, scan disagrees") → vuln mgmt lead owns exception governance and SLA reporting → CISO owns risk acceptance over a defined threshold (often CVSS 7+ or any finding on regulated data systems).
- **The compensating control conversation** — half the war-room arguments in vuln management aren't about patching, they're about whether [[Segmentation]] or WAF rules or EDR detections are "good enough" to substitute for a fix the business won't approve. Document the decision, set a review date, move on. *A documented compensating control is risk management. An undocumented one is hope.*

## Related concepts

[[Vulnerability Management Lifecycle]] · [[Asset Discovery]] · [[Credentialed vs Non-credentialed Scanning]] · [[Agent vs Agentless Scanning]] · [[Internal vs External Scanning]] · [[Static vs Dynamic Analysis]] · [[Security Baseline Scanning]] · [[CIS Benchmarks]] · [[PCI DSS]] · [[ISO 27001]] · [[ICS]] · [[SCADA]] · [[Operational Technology]] · [[Segmentation]] · [[Compensating Controls]] · [[Risk Acceptance]] · [[CVSS]] · [[Patch Management]] · [[Configuration Management]] · [[Change Management]] · [[Inhibitors to Remediation]]

*Source: VIRGIL knowledge base — 2026-05-11*