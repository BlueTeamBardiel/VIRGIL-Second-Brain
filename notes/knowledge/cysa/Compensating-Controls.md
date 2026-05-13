# Compensating Controls

## What it is

In **Valorant**, your team picks Cypher for site anchor and he gets benched mid-tournament because of a bug with his Spycam on Lotus B. You can't just remove a defender from the comp — the round still happens in 90 seconds. So you stack Killjoy turret on the same angle, run double smokes from Omen, and have Sage wall the main choke. None of those agents *are* Cypher. The Spycam intel is gone. But the site still gets held because you layered enough alternative utility that the attacker's path costs them more than the value of the plant. That's exactly what a compensating control does — it's the utility stack you run when the agent you actually wanted is locked out.

Plain English: a **compensating control** is any alternative safeguard you put in place when the primary fix can't be applied right now. The vulnerability is still there. You haven't patched it. You've made it harder to reach, louder when touched, or less valuable when popped.

Technical: a compensating control is a secondary security measure that reduces risk to an acceptable level when the original control (typically a patch, configuration change, or required control from a framework like PCI DSS) cannot be implemented due to technical, operational, or business constraints. It does not eliminate the vulnerability — it reduces likelihood of exploitation, blast radius, or both, while the root cause persists.

## Why it matters

Every vulnerability management program lives or dies on this concept. Patches take 30, 60, 90 days. Some systems will *never* be patched — the Windows Server 2012 box running the HVAC controller, the SCADA HMI from a vendor that went bankrupt in 2017, the legacy app that breaks if you touch .NET. The change board doesn't care that Tenable flagged it CVSS 9.8. They care that the production pipeline stops if you reboot.

Compensating controls are how the security team keeps shipping risk reduction in environments that won't let them patch. They're also the only way to stay compliant with **PCI DSS**, **HIPAA**, and most regulatory frameworks when a required control genuinely can't be implemented — the assessor will accept a documented compensating control if it meets the rigor bar.

Exam relevance: **CS0-003 Objective 2.5** (inhibitors to remediation, prioritization) and **2.1** (special considerations during scanning). CompTIA loves the scenario where remediation is blocked and asks what to do *next*. The answer is almost never "wait." It's "implement a compensating control and document it."

## Key facts

### When you reach for one

Compensating controls show up when one of these is true:

- **Patch unavailable** — vendor hasn't released one, or it's still in QA
- **Patch breaks the app** — known regression, business rejects the deploy
- **Legacy system** — EOL OS, unsupported firmware, can't be touched without a forklift upgrade
- **Operational technology / ICS / SCADA** — uptime requirements measured in years, patching means halting a turbine
- **Change freeze** — retail in November, finance at quarter-close, healthcare during an audit
- **Mergers & acquisitions** — you inherited the network last week and don't own the credentials yet
- **MOU/SLA constraints** — third-party-managed asset you can't unilaterally touch

These are the **inhibitors to remediation** CompTIA tests by name. Memorize them.

### What a compensating control actually looks like

| Primary control blocked | Compensating control |
|---|---|
| Patch an unauthenticated RCE in a public web app | **WAF rule** blocking the specific exploit signature; rate-limit the endpoint |
| Patch a legacy SMBv1 file server | **Network segmentation** — VLAN isolation, ACL restricting source IPs to two jump hosts |
| Disable a vulnerable service required by the app | **Host firewall** restricting listening port to localhost; **EDR** behavioral rule on the process |
| Rotate hardcoded credentials in firmware | **PAM vault** for access, **session recording**, MFA on the jump host |
| Encrypt-at-rest on a database that doesn't support TDE | **Full-disk encryption** at the volume layer; restricted physical access; tamper alerts |
| Patch an OT/ICS HMI | **Air-gap or unidirectional gateway**, **passive scanning only**, dedicated engineering workstation |
| Disable Office macros (business needs them) | **Application allowlisting** of signed macros; **EDR** ruleset for macro-spawned children |

The pattern: you can't remove the weakness, so you make exploitation **harder, slower, louder, or less valuable**.

### The four levers

Every compensating control pulls at least one of these:

1. **Reduce exposure** — segmentation, ACLs, firewall rules, removing public reachability
2. **Reduce likelihood of exploitation** — WAF, IPS signature, MFA, allowlisting
3. **Increase detection** — SIEM correlation rule, EDR behavior policy, honeytoken, additional logging
4. **Reduce impact if popped** — least privilege on the service account, network microsegmentation, DLP on the data

A strong compensating control pulls two or three. A WAF rule alone isn't great. A WAF rule **plus** SIEM alerting on bypass attempts **plus** segmentation so the host can't reach the database directly — that's a real control.

### PCI DSS — the gold standard for "what counts"

PCI DSS is the canonical framework for compensating controls because it tells you exactly what an assessor will accept. The four requirements (from PCI DSS v4.0):

1. **Meet the intent and rigor** of the original requirement
2. **Provide a similar level of defense** as the original
3. **Be "above and beyond" other PCI DSS requirements** — you can't reuse an existing control as the compensator
4. **Address the additional risk** introduced by not having the original control

That "above and beyond" clause is the trap. You can't say "we already have a firewall" — the firewall was already required. The compensating control must be *additional*.

> **CompTIA exam trap:** A compensating control is **not** the same as an **alternative control** or a **mitigating control**. CompTIA may use these loosely, but in PCI DSS specifically, "compensating control" implies a formal documentation requirement (the Compensating Control Worksheet) and assessor approval. If the scenario mentions PCI DSS or cardholder data, the answer needs documentation, not just technology.

> **CompTIA exam trap:** "Accepting the risk" is a separate risk treatment option. If the scenario says the team chose to accept the risk and move on — that's **risk acceptance**, not a compensating control. A compensating control means you *did something* to reduce risk while leaving the underlying vuln in place.

### Documentation — the part that gets people fired

A compensating control without documentation is a finding on your next audit. Every one needs:

- **Vulnerability or control gap** it's covering
- **Reason the primary control can't be applied** (the specific inhibitor)
- **Description of the compensating control** and how it reduces risk
- **Owner** — who maintains it, who reviews it
- **Review date** — compensating controls are *temporary by design*; revisit every 90 days minimum
- **Sunset condition** — what has to happen for this to go away (vendor patch released, app refactored, hardware replaced)

The sunset clause matters. *I learned this watching a "temporary" WAF rule outlive three CISOs because nobody put a review date on it — the underlying app was decommissioned in 2019 and the rule was still in production in 2024, blocking a legitimate integration that took two weeks to debug.*

### Special considerations from Objective 2.1

The objective lumps compensating controls into "special considerations" alongside operational/performance/sensitivity concerns. The exam connects them like this:

- **OT / ICS / SCADA environments** — you almost always need compensating controls because active scanning can crash a PLC. Passive scanning + segmentation + unidirectional gateways is the standard stack.
- **Critical infrastructure** — patching windows are measured in years. Compensating controls are the primary risk reduction tool.
- **Sensitivity levels** — high-sensitivity systems (cardholder data, PHI, classified) get compensating controls layered *on top of* baseline controls, not instead of them.
- **Regulatory requirements** — PCI DSS, HIPAA, NERC CIP all have explicit language for when alternatives are acceptable.

### Frameworks that name them explicitly

- **PCI DSS** — Compensating Control Worksheet (Appendix B in v4.0)
- **NIST SP 800-53** — "alternative" and "compensating" controls under the tailoring guidance
- **CIS Benchmarks** — recognize that not every recommendation is achievable; expect compensators
- **ISO 27001/27002** — the Statement of Applicability documents controls and exclusions with justifications
- **HIPAA** — "addressable" implementation specifications work similarly: implement, document an alternative, or document why neither is needed

## SOC reality

- The L1 analyst opens a vuln scan ticket on a CVSS 9.1 finding. The asset owner replies: "can't patch, breaks the EMR." The ticket goes to L2, who proposes a WAF rule plus a SIEM correlation rule on the exploit signature. That's the compensating control package — the analyst writes it up, gets sign-off, and the ticket moves to "risk-accepted-with-mitigations."
- The CISO's question is always the same: "what's the exposure, what's the cost of patching, and what are we doing in the meantime?" Compensating controls are the answer to "in the meantime." Never walk into that meeting without one.
- Never tell leadership a compensating control "fixes" the vulnerability. It doesn't. It reduces risk. The vuln is still in the scanner report next month, and you'll explain it again. *I learned this when a board member asked why a finding hadn't dropped off the report after we'd "handled it" — turns out "handled" meant something very different to them than to me.*
- The handoff: L1 detects the vuln, L2 designs the compensating control, GRC documents it and sets the review cadence, asset owner signs the acceptance, security architecture validates that the control actually works. Five hands. Don't skip any.
- The review cycle kills you if you let it. Put compensating controls in a tracked list with hard review dates. Stale compensators are how breach reports start.

## Related concepts

[[Vulnerability Management Lifecycle]] · [[Risk Treatment Options]] · [[Inhibitors to Remediation]] · [[CVSS]] · [[PCI DSS]] · [[Network Segmentation]] · [[WAF — Web Application Firewall]] · [[EDR — Endpoint Detection and Response]] · [[SCADA and ICS Security]] · [[Patch Management]] · [[Change Management]] · [[NIST SP 800-53]] · [[CIS Benchmarks]] · [[Defense in Depth]]

*Source: VIRGIL knowledge base — 2026-05-11*