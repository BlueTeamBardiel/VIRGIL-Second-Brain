# Inhibitors to Remediation

## What it is

In **League of Legends**, you're 28 minutes in, Baron is up, and the enemy jungler is missing. Your support pings retreat. Your top laner pings to push. Your ADC is recalling. You *know* the right play — collapse mid, take Baron, end the game — but the team comp won't execute it. The Yasuo wants a 1v1. The jungler is farming raptors. The support is out of vision wards. You see the win condition. You can't get five humans to agree on it inside the cooldown window. By the time you've typed it in chat, the enemy mid has roamed and your tower is gone.

That's exactly what inhibitors to remediation are — you can see the patch, you know the fix, and you cannot get the org to execute inside the threat window.

Technically: **inhibitors to remediation** are the organizational, contractual, technical, and political constraints that prevent a known vulnerability from being patched, mitigated, or removed in a timely fashion. CySA+ tests this specifically because the gap between "vulnerability identified" and "vulnerability remediated" is where breaches live. The scanner found it on day one. The CVE is public on day three. The exploit is on GitHub by day ten. Your change board meets on the third Tuesday of the month.

## Why it matters

The CVSS 9.8 isn't dangerous because the math says so. It's dangerous because it's been sitting at CVSS 9.8 on a production asset for 94 days while three teams argue about a maintenance window. CompTIA objective **CS0-003 4.2** puts this under reporting and communication for a reason: the analyst's job isn't just to find the vuln — it's to communicate the risk in a way that breaks the inhibitor. If you can't articulate why the legacy ERP can't be patched, and what compensating control you put in instead, you can't write the report leadership signs.

Real-world stakes: most post-incident root cause analyses don't read "zero-day, undefendable." They read "vulnerability known for 6 months, remediation blocked by [legacy vendor / change freeze / SLA conflict / no test environment]." The Equifax breach was a known Struts CVE. The remediation was inhibited. The post-incident report is now a Harvard case study.

## Key facts

### The CompTIA-named inhibitors

CompTIA lists these explicitly. Memorize the categories — they show up on the exam as the wrong answer to "why didn't you patch?" and the right answer to "what should the report document?"

| Inhibitor | What it actually means | War-room example |
|---|---|---|
| **MOU** (Memorandum of Understanding) | Non-binding agreement with a partner/vendor that constrains your actions | "We agreed not to scan their connected network without 14-day notice" |
| **SLA** (Service Level Agreement) | Contractual uptime/performance promises to customers | "We owe 99.99% uptime. Patching reboots the cluster. Math says no." |
| **Organizational governance** | Change Advisory Board (CAB), change freezes, approval chains | "CAB meets Tuesday. Today is Wednesday. Holiday freeze starts Friday." |
| **Business process interruption** (BPI) | Patching breaks a workflow the business depends on | "The patch deprecates the API the finance team's macro uses for payroll" |
| **Degrading functionality** | Patched version loses features the org uses | "The new TLS config breaks the legacy thermostat fleet" |
| **Legacy systems** | EOL OS, unsupported software, no vendor patches exist | "It's Server 2008. There is no patch. There will never be a patch." |
| **Proprietary systems** | Vendor support contract voids if you modify or patch | "Touch that medical device firmware and you lose FDA clearance" |

### Stakeholder identification — who has to agree before remediation moves

This is the inhibitor most analysts underestimate. You don't patch alone. You patch through:

- **Asset owner** — the team that runs the system. They have veto over downtime windows.
- **Business owner** — the team that uses the system. They have veto over functional changes.
- **Change board / CAB** — the governance body that approves the window.
- **Vendor** — if proprietary, their blessing is required to maintain support.
- **Legal** — if the system processes regulated data, they sign off on any change to controls.
- **Security** — you. You own the risk argument, not the decision.

The exam framing: when CompTIA asks "who is responsible for accepting residual risk," the answer is **the business owner**, not security. Security recommends. Business accepts.

### Compensating controls — what you do when you can't patch

When the inhibitor wins, you don't shrug. You document, then you compensate. The CySA+ expectation is that the report shows the compensating control in writing.

- **Network segmentation** — VLAN the legacy system off, restrict reachability
- **Firewall rules / ACLs** — block the vulnerable port or protocol at the perimeter
- **Application-layer filtering** — WAF rule that blocks the specific exploit pattern
- **Enhanced monitoring** — SIEM rule tuned for exploitation of *this specific* CVE
- **Privileged access controls** — JIT access, MFA, jump host required
- **Disabling the vulnerable feature** — turn off SMBv1 even if you can't patch
- **Virtual patching** — IPS signature that drops the exploit traffic before it reaches the host

*The compensating control doesn't remove the vulnerability. It removes the exposure. The CVSS doesn't change. The exploitability does.*

### Metrics that expose the inhibitor

If you want leadership to fund the fix, you need numbers. The metrics CompTIA cares about:

| Metric | What it measures | Why it exposes inhibitors |
|---|---|---|
| **MTTD** (Mean Time to Detect) | Alert fire to analyst acknowledgment | High MTTD = tooling/staffing problem, not inhibitor |
| **MTTR** (Mean Time to Respond) | Detection to containment action | High MTTR = playbook/authority problem |
| **MTTRem** (Mean Time to Remediate) | Vulnerability identified to fully patched | **This is where inhibitors live** |
| **Alert volume** | Tickets per shift, signal-to-noise | High volume hides the real fire |
| **SLO compliance** | % of vulns patched within SLA window | Trending down = inhibitors winning |

Track MTTRem by asset class. When the legacy fleet's MTTRem is 180 days and the modern fleet's is 14, the report writes itself.

### What goes in the incident response report when inhibitors caused the breach

CompTIA objective 4.2 wants you to know the structure. When the post-incident RCA names an inhibitor:

- **Executive summary** — one paragraph, business language, no jargon. "A known vulnerability remained unpatched for 94 days due to vendor support constraints; an attacker exploited it on day 89."
- **Timeline** — who, what, when, where. Vulnerability disclosed → scanner detected → remediation blocked → exploitation → detection → containment.
- **Scope** — assets affected, data classes touched, users impacted
- **Impact** — financial, operational, reputational, regulatory
- **Root cause analysis** — the technical CVE *and* the organizational inhibitor that prevented the fix
- **Evidence** — preserved with chain of custody, references to forensic artifacts
- **Recommendations** — both the technical fix and the process fix (e.g., "amend vendor contract to allow emergency patching")
- **Lessons learned** — feeds back into preparation phase for next time

### CompTIA exam traps

> **CompTIA exam trap:** "Why wasn't this patched?" — the answer CompTIA wants is the **named inhibitor category** (MOU, SLA, legacy system, proprietary system, organizational governance, BPI), not "the team was lazy" or "no resources." Resource constraints are real, but they're not on the objective. The named categories are.

> **CompTIA exam trap:** Compensating controls are not remediation. They're risk reduction. The vulnerability still exists; the exposure is reduced. If the question asks "has the vulnerability been remediated?" and the answer is "we put a WAF rule in front of it," the technical answer is **no**. The risk has been mitigated, not eliminated.

> **CompTIA exam trap:** Who accepts residual risk? The **business owner / system owner**, not security, not the SOC, not the CISO alone. Security advises. Business decides. The CISO may sign for the organization at scale, but the documented owner of the system signs for that system.

> **CompTIA exam trap:** MTTR vs MTTRem. **MTTR** is mean time to *respond* (detect → contain). **MTTRem** is mean time to *remediate* (identified → fully patched). They are not the same. CompTIA will swap them in the answer choices.

### Regulatory and legal inhibitors — the other side of the coin

Sometimes you *can't* remediate because law or regulation forbids the action.

- **Legal hold** — evidence preservation order means you can't wipe and reimage the compromised host
- **Regulated systems** — FDA medical devices, FAA avionics, NRC nuclear systems — patching may require re-certification
- **Forensic integrity** — patching destroys evidence; if law enforcement is involved, you wait
- **Regulatory reporting timelines** — GDPR 72-hour breach notification doesn't pause for your CAB meeting

The reporting consequence: when the inhibitor is legal, the report must show that **legal counsel was consulted and approved the delay**. Without that paper trail, the regulator assumes negligence.

## SOC reality

- The vulnerability scan dashboard shows 14,000 findings. The conversation with leadership is never "patch all of them." It's "here are the 12 we can't patch, here's why, here's what we did instead." That's the inhibitor report.
- When the CISO asks "are we exposed to [headline CVE]?" the answer is not "yes" or "no." It's "we have 38 affected systems; 31 are patched; 5 are behind a WAF rule with a compensating control documented; 2 are legacy systems pending decommission in Q3."
- The L1 ticket that says "vuln scan finding, asset owner refuses to patch" doesn't get closed. It gets escalated with a documented exception, a compensating control, and a review date. **Never close a finding without a paper trail.**
- Never promise leadership "we'll patch by Friday" until you've talked to the asset owner. The number of times a confident ETA collapsed because nobody asked the team that runs the box — too many to count.
- When the breach happens on a known unpatched system, the auditor's first question is "show me the exception document." If you can't, the post-incident report names the SOC, not the inhibitor. *Document the exception or own the breach.*

## Related concepts

[[Vulnerability Management Lifecycle]] · [[CVSS Scoring]] · [[Compensating Controls]] · [[Change Management]] · [[Risk Treatment Options]] · [[Service Level Agreement]] · [[Memorandum of Understanding]] · [[Legacy Systems]] · [[Root Cause Analysis]] · [[Mean Time to Remediate]] · [[Incident Response Reporting]] · [[Executive Summary]] · [[Stakeholder Identification]] · [[Regulatory Reporting]] · [[Legal Hold]]

*Source: VIRGIL knowledge base — 2026-05-11*