# Security Awareness

## What it is

In StarCraft, a Terran player can build the most expensive force in the galaxy — Battlecruisers, Ghosts, Siege Tanks — but if the SCV gathering minerals at the edge of the base wanders into a cloaked Dark Templar with no detector nearby, the whole economy collapses one worker at a time. That's exactly what security awareness addresses — humans are the worker units of every organization, and one untrained click loses the game regardless of how much you spent on the firewall.

**Security awareness** is the formal program of educating users to recognize, resist, and report threats — phishing, social engineering, anomalous behavior, password misuse, and insider risk — through training, simulated exercises, and ongoing reinforcement.

## Why it matters

Over 80% of breaches involve a human element — credential theft, phishing, or error. No technical control compensates for a user who hands over their MFA token to a "help desk" caller. CompTIA SY0-701 Objective 5.6 explicitly enumerates the components: **phishing**, **anomalous behavior recognition**, **user guidance and training**, **policy/handbooks**, **situational awareness**, **insider threat**, **password management**, **removable media and cables**, **social engineering**, **operational security**, and **hybrid/remote work environments**. The trap CompTIA loves: presenting a scenario where a technical control exists but a user behavior caused the failure, and asking what *additional* control fixes it — the answer is almost always awareness training, not another appliance.

## Key facts

### Core program components (Obj. 5.6)

| Component | What it covers |
|---|---|
| **[[Phishing]] campaigns** | Simulated phishing emails to measure click-rate and report-rate; recognition of [[spear phishing]], [[whaling]], [[smishing]], [[vishing]] |
| **Anomalous behavior recognition** | Spotting **risky**, **unexpected**, or **unintentional** user actions before they escalate |
| **User guidance and training** | Onboarding plus recurring sessions; role-based content for finance, devs, executives |
| **Policy/handbooks** | [[Acceptable Use Policy]], [[BYOD]] rules, data handling — read and acknowledged |
| **Situational awareness** | Tailgating, shoulder surfing, dumpster diving, suspicious calls |
| **[[Insider threat]]** | Recognizing disgruntled coworkers, abnormal data access, off-hours activity |
| **[[Password management]]** | Use of [[password managers]], passphrase construction, no reuse |
| **Removable media and cables** | Banning unknown USBs, [[USB drop attack]] awareness, [[O.MG cable]]-style hardware implants |
| **[[Social engineering]]** | [[Pretexting]], [[impersonation]], [[authority]], [[urgency]], [[scarcity]] tactics |
| **Operational security ([[OPSEC]])** | What not to post on LinkedIn, badge photos, travel plans |
| **Hybrid/remote work** | Home Wi-Fi hardening, [[VPN]] use, locking screens, family members on corp devices |

### Three classes of risky behavior

- **Risky** — Knowingly violating policy (sharing credentials, disabling AV).
- **Unexpected** — Deviation from baseline (3 AM logins, bulk downloads).
- **Unintentional** — Honest mistakes (misaddressed email, lost laptop).

### Program lifecycle

1. **Develop** — Identify risks, define learning objectives, build content.
2. **Execute** — Deliver training; run [[phishing simulation]] campaigns.
3. **Measure** — Track click rates, report rates, completion percentages, time-to-report.
4. **Report** — Metrics to leadership; tie to compliance frameworks ([[PCI DSS]], [[HIPAA]], [[ISO 27001]]).
5. **Iterate** — Adjust content based on what users keep failing.

### Reporting and monitoring

- **Reporting mechanisms** — A clearly marked "Report Phishing" button beats a forwarded email every time. Time-to-report is a leading indicator of program maturity.
- **Development plans** — Repeat offenders get targeted remediation, not public shaming.

### Compliance angle

Security awareness is a **[[managerial control]]** in CompTIA's taxonomy and a **[[preventive control]]** in function. Most regulatory frameworks mandate it: **PCI DSS 12.6**, **HIPAA Security Rule §164.308(a)(5)**, **NIST SP 800-53 AT family**, **ISO/IEC 27001 A.6.3**.

### Common exam traps

- "User clicked phishing link despite spam filter" → answer is **training**, not a better filter.
- Insider exfiltrating data slowly → **anomalous behavior recognition** plus [[UEBA]], not just DLP.
- Tailgating into a SCIF → **situational awareness training** plus [[mantrap]]/[[access control vestibule]].
- Found USB in parking lot → never plug in; report. Tests **removable media** awareness.

## Related concepts

[[Social engineering]] · [[Phishing]] · [[Insider threat]] · [[Acceptable Use Policy]] · [[Password management]] · [[OPSEC]] · [[UEBA]] · [[Managerial controls]] · [[Phishing simulation]] · [[Anomalous behavior]]

---
*Source: VIRGIL knowledge base — 2026-05-08*