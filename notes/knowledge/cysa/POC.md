# POC — Proof of Concept

## What it is

In **Gran Turismo**, before you take a new car into a championship, you run it on Deep Forest with the racing line on and a full fuel tank. You're not trying to win. You're trying to find out if the rear end steps out in the chicane, whether the brakes fade after lap six, and whether the tune you copied off the forum actually does what the spreadsheet said it would. You drive three laps, post a time, look at the telemetry, and decide whether to commit to the build or scrap it. That's a proof of concept — a controlled, low-stakes run of a thing to see if it survives contact with reality.

In plain English: a **POC** is a small, deliberate test of an idea, tool, technique, or playbook to prove it works before you bet the org on it.

In CS0-003 terms: a Proof of Concept is a validated demonstration that a proposed control, response procedure, detection rule, recovery process, or piece of tooling performs as expected under representative conditions. POCs live in the **Preparation** phase of the incident management lifecycle and feed directly into **Post-incident activity** — every lesson learned that proposes a change should pass through a POC before it touches production.

## Why it matters

CompTIA tests POC under Objective **3.3** (preparation and post-incident activity) because the candidate needs to understand that the IR program is not a binder — it's a living system of playbooks, tools, and procedures that have been *proven to work*. An untested playbook is a wish. An untested EDR deployment is a budget line. A backup you've never restored is Schrödinger's recovery — both alive and dead until the ransomware forces you to open the box.

Career-wise: the analyst who graduates from "ticket closer" to "IR contributor" is the one who runs POCs. POC-ing a new SIEM correlation rule against last week's logs, POC-ing a containment script in the lab, POC-ing a tabletop scenario against the on-call team — this is how the SOC matures. The CISO doesn't fund a tool they haven't seen run. The change board doesn't approve a playbook they haven't seen rehearsed.

Real stakes: orgs that skip POC end up live-testing during incidents. *I have watched a team try to use a forensic acquisition tool for the first time at 2am, on a domain controller, while the executive bridge waited for an answer. The tool needed a license server that wasn't reachable. We lost three hours.*

## Key facts

### Where POC lives in the lifecycle

| Phase | POC's role |
|---|---|
| **Preparation** | Validate tools, playbooks, runbooks, training scenarios, BC/DR procedures before they're needed |
| **Detection and Analysis** | Validate that a new detection rule fires on real signal and not on noise (test in staging first) |
| **Containment, Eradication, Recovery** | Validate isolation scripts, re-imaging procedures, recovery-from-backup steps in the lab |
| **Post-incident Activity** | Validate proposed changes from lessons learned before pushing them into the [[Incident Response Plan]] |

POC is most heavily concentrated in **Preparation** and **Post-incident**. The middle phases are too hot for experimentation — that's where you execute what you've already proven.

### Things you POC during Preparation

- **Tools** — EDR agent rollout on a pilot group, forensic imaging on a test endpoint, SIEM connector pulling from a representative log source, sandbox detonation of a known sample
- **[[Playbooks]]** — walk an analyst through the ransomware playbook on a lab machine and time every step
- **[[Tabletop exercises]]** — a discussion-based POC of the IR plan, run with stakeholders around a conference room, no real systems touched
- **[[Training]]** — does the new-hire ramp actually produce an L1 who can triage a phishing alert? Run them through ten scored scenarios and find out
- **[[Business Continuity]] / [[Disaster Recovery]]** — a DR drill is a POC of the recovery plan. Restore the database from yesterday's backup into the DR site and time how long it takes. That number is your real RTO, not the one in the policy
- **Communication trees** — does the on-call rotation actually answer the phone at 3am? POC by paging the chain on a random Tuesday

### Things you POC during Post-incident

After the incident closes, the **lessons learned** meeting produces a list of "we should have…" items. Each one is a hypothesis. POC them:

- New detection rule proposed from the IoCs → test against historical logs in a SIEM dev tier before promoting to production
- New containment procedure → run in a lab against a snapshotted VM
- New playbook step → walk through it in a tabletop with the team that will execute it
- New tooling identified as a gap → vendor POC, typically a 30–60 day evaluation against your real environment

*The lessons-learned doc that does not produce POC tasks is fan fiction.*

### Tabletop vs technical POC

CompTIA distinguishes these and the exam will test it:

| Type | What happens | Who's in the room | Output |
|---|---|---|---|
| **Tabletop exercise** | Facilitator reads a scenario; team talks through their response | IR team, legal, comms, exec sponsor | Gaps in plan, decision-authority confusion, missing contacts |
| **Functional / technical POC** | Team actually executes procedures against test systems | IR analysts, SOC, sysadmins | Validated runbook steps, real timing, tool config issues |
| **Full-scale exercise** | Red team or simulation hits live-ish environment; blue team responds end-to-end | Everyone | Closest you get to a real incident without one |

A tabletop is cheap and catches process gaps. A technical POC is expensive and catches tooling gaps. You need both.

### POC criteria — what "passed" means

A POC without success criteria is a demo. Define before you start:

- **Scope** — what system, what data, what time window
- **Hypothesis** — "this rule will detect Cobalt Strike beacon traffic with <5 false positives per day"
- **Success threshold** — measurable. Detection rate, time-to-execute, accuracy, MTTR impact
- **Failure conditions** — what would cause you to reject the proposal
- **Owner** — one name on the POC
- **Rollback plan** — if the POC blows up, how do you get back

### POC and [[Root Cause Analysis]]

RCA produces hypotheses about why the incident happened. POCs validate the *fix*. Example: RCA says "the breach succeeded because the EDR was in detect-only mode on the finance OU." Proposed fix: switch to block mode. POC: enable block mode on a pilot subset, run for two weeks, measure user-impact tickets and false-block rate. *Then* you roll org-wide. Skipping the POC is how you take down the trading floor on a Monday morning.

### CompTIA exam traps

> **CompTIA exam trap:** POC vs Pilot vs Production. A **POC** proves the concept works at all (small scope, lab or limited prod, short duration). A **Pilot** proves it works in your environment at a representative scale (broader scope, real prod, longer duration). **Production** is the full rollout. The exam will offer all three as answers and the question hinges on scope and intent.

> **CompTIA exam trap:** A tabletop exercise *is* a form of POC — specifically a POC of the incident response plan and communication procedures. If the question asks "what validates the IR plan without touching production systems?" the answer is tabletop, not "full-scale exercise" and not "live-fire test."

> **CompTIA exam trap:** Post-incident activity does **not** end with the lessons-learned meeting. It ends when the action items from that meeting are validated (POC'd) and integrated into the updated IR plan, playbooks, and training. CompTIA loves to test this: "lessons learned documented" is not the same as "incident closed."

> **CompTIA exam trap:** Forensic tooling must be POC'd against your evidence-handling policy *before* an incident. A tool that produces output inadmissible under your chain-of-custody requirements is worse than no tool — it contaminates the case. The exam phrases this as "what should be done with new forensic tools before deployment?" Answer: validate against legal/evidence requirements, then POC.

### Documentation a real POC produces

- **POC plan** — scope, hypothesis, success criteria, timeline, owner
- **Test data** — captured logs, telemetry, screenshots, command output
- **Results summary** — pass/fail against criteria, surprises, unintended impacts
- **Recommendation** — adopt as-is, adopt with changes, reject, extend POC
- **Integration plan** — if adopted, what changes to playbooks, runbooks, training, monitoring

The recommendation is the deliverable. Everything else is evidence supporting it.

## SOC reality

- The "new EDR POC" sitting in your queue for six weeks is the vendor's salesperson emailing your manager every Friday. Pick three high-value detection scenarios from your last three incidents, run those against the POC, and decide. Do not let the vendor pick the scenarios.
- When IR lead says "we need to update the ransomware playbook," the analyst who volunteers to run the tabletop POC is the one who gets noticed. The analyst who says "I'll wait for the new playbook" is the one who runs the next ransomware response with the old one.
- The CISO asks two questions about any proposed change post-incident: *"Have you tested it?"* and *"What broke when you tested it?"* If the answer to the second is "nothing," the CISO assumes you didn't really test it. Real POCs always surface something.
- Never tell leadership "the new tool is deployed" when what you mean is "the new tool is licensed." Deployment is proven by a POC report with screenshots of it catching real traffic. Licensing is an invoice.
- The DR backup you've never restored is not a backup. *I have seen a 200GB database backup restore successfully into a test environment and then fail to start because the SQL Server version mismatched by one minor revision.* That is a POC finding. That is why you POC.

## Related concepts

[[Incident Response Plan]] · [[Playbooks]] · [[Tabletop Exercise]] · [[Lessons Learned]] · [[Root Cause Analysis]] · [[Business Continuity]] · [[Disaster Recovery]] · [[Forensic Analysis]] · [[Training and Awareness]] · [[Change Management]] · [[After-Action Report]] · [[MTTR]]

*Source: VIRGIL knowledge base — 2026-05-11*