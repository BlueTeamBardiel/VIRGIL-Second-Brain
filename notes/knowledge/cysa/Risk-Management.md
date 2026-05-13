# Risk Management

## What it is

In **StarCraft**, you're playing Terran against a Zerg opponent who's already scouted your natural expansion. You can see the overlord drifting at the edge of your vision. You have four choices: cancel the expansion entirely (no second base, no risk of it dying), wall it off with bunkers and a turret (still exposed but harder to crack), buy a mercenary contract — sorry, hire some allied protoss to defend it — or just keep mining and pray the muta flock goes somewhere else. Four moves, four risk treatments. The one you pick depends on minerals, time, and how much you trust your scout count.

That's exactly what **risk management** does — you identify a threat to an asset, then pick one of four treatments based on cost, impact, and how much risk leadership will swallow.

Technical definition: Risk management is the formal process of identifying risks to organizational assets, analyzing likelihood and impact, selecting a treatment (avoid, mitigate, transfer, accept), implementing controls, and continuously reassessing. In CySA+ vulnerability management context, it's how you decide which CVE gets patched Tuesday, which gets a compensating control, which gets an exception, and which gets the CFO's signature on a "we're living with this" memo.

## Why it matters

Every vulnerability scan dumps hundreds of findings. You cannot patch them all this sprint. Risk management is the framework that decides what actually moves — and just as importantly, what the business signs off on leaving alone. Get this wrong and you either burn the team patching CVSS 4.0 findings on isolated dev boxes while a CVSS 9.8 on the external auth server rots for 90 days, or you patch aggressively and break production during business hours.

**Exam relevance:** CS0-003 Objective 2.5 — vulnerability response, handling, and management. CompTIA tests the four treatments by name, the three control categories (managerial/operational/technical), the six control functions (preventative/detective/corrective/responsive/compensating/etc.), and the inhibitors to remediation. They love edge cases on "avoidance vs mitigation" — see traps below.

## Key facts

### The four risk treatments

| Treatment | What it means | StarCraft example | SOC example |
|---|---|---|---|
| **Avoid** | Stop doing the risky activity entirely | Cancel the expansion | Decommission the legacy SMBv1 file server |
| **Mitigate** | Reduce likelihood or impact while continuing the activity | Wall off the expansion with bunkers | Patch the CVE; add a WAF rule; segment the VLAN |
| **Transfer** | Shift the financial or operational risk to a third party | Pay allied protoss to defend it | Cyber insurance; outsource the PCI cardholder environment |
| **Accept** | Acknowledge the risk and continue without additional controls | Keep mining and pray | Sign-off memo: "CVSS 6.1 on internal-only host, accepted by CISO" |

The single most common exam stumble: **adding a control is mitigation, not avoidance.** Avoidance means the activity stops. Firewall rules, patches, WAFs, segmentation — all mitigation. If the business is still doing the thing, you didn't avoid anything.

### Control categories (the "who owns it" axis)

- **Managerial** — policies, procedures, risk assessments, SLAs, governance. The paperwork layer.
- **Operational** — humans executing process. Awareness training, IR procedures, change management, log review.
- **Technical** — the tooling. Firewalls, EDR, MFA, encryption, IDS.

### Control functions (the "what does it do" axis)

- **Preventative** — stops the event before it happens. MFA, patching, input validation, network segmentation.
- **Detective** — sees the event when it occurs. SIEM, IDS, log monitoring, file integrity monitoring.
- **Corrective** — fixes things after the event. Re-imaging a box, restoring from backup, patching post-incident.
- **Responsive** — orchestrated reaction. IR playbooks, SOAR automation, containment runbooks.
- **Compensating** — a substitute control when the primary control can't be implemented. PCI DSS lives on these.

> **CompTIA exam trap:** A **compensating control** is not "any control you happened to add." It's specifically a substitute when the required/primary control is infeasible — legacy system, business process interruption, cost. The compensating control must provide *equivalent* protection. Example: legacy industrial controller can't run MFA, so you wrap it in a jump-host with strict ACLs, full session recording, and MFA on the jump host itself. That's compensating. A WAF in front of an unpatched web app while you wait for the patch window — also compensating.

### Exceptions

When you can't apply the required control and a compensating one is in place (or accepted), you document an **exception**. Exceptions have:

- An owner (a named human, not a team)
- An expiry date (six months is typical — never "indefinite")
- A documented compensating control or accepted-risk statement
- A review cadence
- Executive sign-off proportional to the risk level

Exceptions that never expire are how organizations end up running Windows Server 2008 in production in 2026.

### Prioritization — "bang for the buck"

CompTIA's prioritization model is criticality-to-effort ratio, not pure severity. A medium-criticality fix that takes 6 hours beats a medium-criticality fix that takes a day, every time. A CVSS 9.8 that takes 12 weeks to remediate is real work, but it's not a *quick win* — it's a program. Don't confuse the two when leadership asks for both.

Factors that drive real prioritization (not just CVSS):

- **Exposure** — internet-facing > internal-only > air-gapped
- **Exploitability** — public PoC, in-the-wild exploitation (check CISA KEV), weaponized
- **Asset criticality** — domain controller > marketing intranet
- **Compensating controls already in place** — WAF, segmentation, MFA can knock effective risk down hard
- **Data sensitivity** — PII, PHI, PCI, IP

CVSS is the starting point, not the answer. A CVSS 10 on a host with no network reachability and no users is a P3. A CVSS 6.5 on the public auth gateway is a P1.

### Attack surface reduction & management lifecycle

Attack surface management (ASM) is the continuous lifecycle:

1. **Discovery** — passive (DNS, certificate transparency, OSINT) and active (port scans, edge discovery of unknown internet-facing assets)
2. **Inventory** — every asset tied to an owner
3. **Classification** — criticality, data sensitivity, exposure
4. **Risk scoring** — combine CVE data with exposure context
5. **Remediation tracking** — patch, mitigate, accept, or exception
6. **Continuous monitoring** — re-scan, validate

**Edge discovery** is the part where you find the assets nobody told you about — the marketing team's WordPress site, the dev S3 bucket, the forgotten Azure VM. You cannot defend what you don't know exists.

### Secure SDLC — risk management shifted left

CompTIA's secure software development lifecycle puts risk controls at every phase:

- **Planning** — threat modeling (STRIDE, attack trees)
- **Design** — security requirements, architecture review
- **Implementation** — secure coding: [[input validation]], [[output encoding]], [[parameterized queries]], proper [[session management]], strong [[authentication]], [[data protection]] at rest and in transit
- **Testing** — SAST, DAST, IAST, [[security controls testing]], [[penetration testing]], [[bug bounty]] programs, [[adversary emulation]]
- **Deployment** — change control, [[maintenance windows]], rollback plans
- **Maintenance** — patching, configuration management, continuous monitoring

Threat modeling early is risk management in its cheapest form. Finding a SQL injection design flaw in a whiteboard session costs nothing. Finding it in a pentest costs a sprint. Finding it post-breach costs the company.

### Inhibitors to remediation

CompTIA tests these by name. When you cannot patch, it's usually one of:

- **MOU / SLA** — contractual constraint, can't touch the system without vendor approval
- **Organizational governance** — change board hasn't approved
- **Business process interruption (BPI)** — patching means downtime during business hours
- **Legacy systems** — no patch exists, vendor is gone
- **Proprietary systems** — vendor won't share enough to assess
- **Degrading functionality** — the patch breaks the application

Each of these pushes you toward compensating controls + exception, not avoidance.

> **CompTIA exam trap:** The most common risk of running vulnerability scans is **services crashing** — not "attackers learning about the vulns." Scanners are noisy. They send malformed packets, brute-force authentication, and probe fragile services. Old SCADA and printers especially love to fall over. Schedule scans inside maintenance windows on production-critical assets, and use credentialed authenticated scans over unauthenticated when possible — they're more accurate and less destructive.

> **CompTIA exam trap:** **Risk transference does not eliminate risk.** Cyber insurance pays for some of the cleanup, but the breach still happened, customers still left, the regulator still fines you, and the residual risk still owns you. Same with outsourcing — you can transfer execution, but legal accountability for the data usually stays with you.

### Risk register essentials

Every tracked risk has: ID, description, owner, likelihood, impact, inherent risk score, treatment selected, controls in place, residual risk score, review date. If your scan output isn't feeding a register that leadership can read, you have a scanner, not a program.

## SOC reality

- The 3am alert isn't where risk management lives. Risk management lives in the 10am Thursday vuln-review meeting where the platform team explains why they cannot patch the Oracle box and asks for an exception. Your job is to make sure the compensating control is real and the exception has an expiry date that isn't "Q4 someday."
- L1 analyst's first move on a new critical CVE in the morning briefing: check CISA KEV, check internal asset inventory for affected versions, check whether the asset is internet-facing, check whether compensating controls (WAF, segmentation, MFA) reduce effective risk. *Then* escalate to L2 with context, not just a CVE number.
- The CISO will ask three questions: "Are we exposed? What's compensating? When's it patched?" Have all three answers before you walk in.
- Never tell leadership "we've accepted the risk" without a signed memo. Verbal acceptance evaporates the moment the breach hits the news.
- The handoff: L1 triages and scores, L2 validates exploitability and asset criticality, vuln management owns the register, asset owners own the remediation, the CISO owns the exceptions. If any one of those is missing, the program leaks.

## Related concepts

[[CVSS]] · [[Vulnerability Scanning]] · [[CISA KEV]] · [[Threat Modeling]] · [[Compensating Controls]] · [[Change Management]] · [[Patch Management]] · [[Secure SDLC]] · [[Penetration Testing]] · [[Bug Bounty]] · [[Attack Surface Management]] · [[Risk Register]]

*Source: VIRGIL knowledge base — 2026-05-11*