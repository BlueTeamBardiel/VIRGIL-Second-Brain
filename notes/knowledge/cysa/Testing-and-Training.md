# Testing and Training

## What it is

In **World of Warcraft**, before a guild pulls Mythic Jailer for the first time, they don't just walk in. They watch kill videos, parse logs from other guilds on Warcraft Logs, run the encounter on Heroic until mechanics are muscle memory, then spend a hundred wipes on Mythic learning the soft enrage. Every pull is recorded. Every wipe gets a callout in Discord: who stood in the swirly, who missed the interrupt, who let the add reach the boss. The raid lead pulls the logs and the healer who keeps dying gets benched until they fix their positioning. That's exactly what testing and training does — you simulate the attack under controlled conditions, log everything, and turn each wipe into a permanent skill upgrade before the real boss shows up.

In CS0-003 terms: **testing and training are the controlled-rehearsal activities that validate security controls, measure responder competence, and harden the organization against real incidents.** It covers penetration testing, red/blue/purple team exercises, tabletop exercises, and the continuous-training pipeline that keeps the SOC sharp. Per Objective 1.1, it lives under the umbrella of building and maintaining a defensible architecture — you don't know your architecture works until you've attacked it on purpose.

## Why it matters

Controls that have never been tested are theatre. You can deploy [[EDR]], [[SIEM]] correlation rules, [[network segmentation]], [[MFA]], [[PAM]] vaults, and a perfectly documented [[incident response]] playbook — and have all of it fail at 3am because nobody validated the alert pipeline, nobody ran a containment drill, and the on-call analyst has never actually clicked the "isolate host" button in production.

For the exam: CompTIA expects you to know the difference between pentest types, the four-team color taxonomy, the structure of a tabletop, and the role of training in maintaining a [[zero trust]] posture. CySA+ Objective 1.1 frames testing as part of architecture because untested architecture is theoretical architecture.

For the career: every blue-teamer eventually sits across the table from a pentester who just popped a critical asset using credentials that should have been rotated. The conversation is uncomfortable. The lessons stick.

## Key facts

### Penetration testing

A pentest is an authorized, scoped, simulated attack to find exploitable weaknesses before an adversary does. It is **not** a vulnerability scan — a scan finds known CVEs; a pentest chains them into a kill chain that produces business impact.

| Phase | What happens | Analyst-side equivalent |
|---|---|---|
| **Planning / scoping** | ROE, in-scope targets, exclusions, authorization letter, test windows | Read the ROE, set SIEM to expect noise from tester IPs |
| **Recon / discovery** | Passive [[OSINT]], active scanning ([[Nmap]]), service enumeration | Watch for [[port scans]], validate detection fires |
| **Attack / exploitation** | Exploitation, [[privilege escalation]], [[lateral movement]], persistence | Confirm [[EDR]] catches the payload, [[SIEM]] correlates the chain |
| **Reporting** | Findings, severity ([[CVSS]]), PoC, remediation guidance | Triage findings, build remediation tickets, re-test |

**Pentest knowledge models:**

- **Black box** — tester gets nothing. Simulates external attacker. Slowest, most realistic.
- **White box** — tester gets source code, architecture, credentials. Fastest, deepest coverage.
- **Gray box** — partial info, like a compromised user account. Simulates insider or phished employee. Best realism-to-cost ratio.

**Engagement types:**

- **External** — from the public internet against [[DMZ]] and edge services
- **Internal** — assumes breach; tester dropped on the LAN with a user account
- **Web application** — [[OWASP Top 10]] focus: [[XSS]], [[SQL injection]], [[SSRF]], broken access control
- **Wireless** — rogue APs, [[WPA2]]/[[WPA3]] attacks, evil twin
- **Physical** — tailgating, lock-picking, badge cloning, dropped USBs
- **Social engineering** — phishing simulations, vishing, pretexting

### Team color taxonomy

| Team | Role | What they do |
|---|---|---|
| **Red** | Offense | Simulate the adversary. Goal: get to crown-jewel data. |
| **Blue** | Defense | The SOC. Detect, contain, eradicate. |
| **Purple** | Collaboration | Red + blue working together in real time. Red shows the attack, blue tunes the detection. |
| **White** | Referee | Sets ROE, observes, scores, prevents real damage. Often GRC or external consultant. |
| **Gold** | Strategic | Crisis-management leadership. CISO, legal, comms. |

**Purple teaming is the highest-yield format for blue teams.** A red team report dropped on your desk three weeks after the engagement is a postmortem. Purple is a live tuning session — red runs Mimikatz, blue checks if [[Defender]] / [[CrowdStrike]] catches it, if not, the rule gets written before the meeting ends.

### Tabletop exercises (TTX)

Discussion-based exercise. No keyboards, no live attacks. The facilitator reads a scenario ("ransomware note on the file server at 2am, all of finance is locked out") and the IR team walks through what they would do: who's called, what tools fire, what the comms plan is, when legal gets looped, when leadership escalates to the board.

**Why they matter:** the cheapest way to find out your playbook says "contact the on-call DBA" and the on-call DBA left the company eight months ago. Tabletops surface stale runbooks, broken escalation trees, and authority gaps.

**Cadence:** annually minimum, quarterly for mature programs. Required by [[PCI DSS]], [[HIPAA]], and most cyber-insurance underwriters.

### Live-fire and simulation exercises

- **Functional exercises** — test specific components (DR failover, alert pipeline, isolation script). Live system, narrow scope.
- **Full-scale exercises** — multi-team, multi-system, end-to-end. Expensive. Closest to real.
- **Breach and attack simulation (BAS)** — automated platforms (AttackIQ, SafeBreach, Cymulate) that continuously fire MITRE [[ATT&CK]] techniques to measure detection coverage. Continuous purple teaming.
- **Capture the flag (CTF)** — competitive skill-building. Good for hiring, retention, and keeping analysts sharp.

### Training pipeline

| Audience | What they need | How often |
|---|---|---|
| **General workforce** | [[Security awareness]], phishing recognition, password hygiene, reporting | Annual minimum, monthly micro-training better |
| **Privileged users** | Secure coding, [[PAM]] discipline, change management, [[OWASP]] | Quarterly + role-specific |
| **SOC analysts** | Tool proficiency, [[ATT&CK]], IR playbooks, threat intel, forensics | Continuous; certs, labs, CTFs |
| **Executives / board** | Risk literacy, breach disclosure obligations, tabletop participation | Annual + during incidents |

**Phishing simulations** are the highest-ROI awareness training. Send a fake phish, measure click rate, clickers get a 60-second training module. Benchmarks: 25–30% click rate untrained, sub-5% in mature programs.

### CompTIA exam traps

> **CompTIA exam trap:** **Pentest is not a vulnerability scan.** A scan enumerates known weaknesses ([[CVE]]-tagged). A pentest *exploits* them, chains them, and demonstrates impact. CompTIA will give you a scenario where someone runs Nessus and calls it a pentest — wrong. Pentest requires exploitation and proof.

> **CompTIA exam trap:** **Purple is a mode of operation, not a permanent team in most orgs.** If the question describes "red and blue working together in real time to improve detection," the answer is purple, even if the org has no dedicated purple roster.

> **CompTIA exam trap:** **Black/white/gray box refers to tester knowledge of the environment**, not type of testing. Black = no knowledge. White = full. Gray = partial. Don't confuse with "black hat / white hat" (hacker intent).

> **CompTIA exam trap:** **ROE and authorization letter are mandatory before any pentest activity.** Without written authorization, the test is a federal crime under the [[CFAA]]. The first step of a pentest is *always* planning and authorization, never reconnaissance.

> **CompTIA exam trap:** **Tabletops are discussion-based, not technical.** "Team walked through a scenario in a conference room and identified gaps" = tabletop. If they actually executed isolation scripts, that's a functional or full-scale exercise.

### How testing maps to architecture (Objective 1.1)

- **[[Zero trust]]** — pentest tries to move laterally after initial access. If they can't, your segmentation works.
- **[[PAM]]** — red team tries to escalate to domain admin. If they can't pull cleartext creds from a workstation, your tiering works.
- **[[MFA]] / [[SSO]] / [[Federation]]** — phishing simulation measures whether MFA fatigue or push bombing gets through.
- **[[Network segmentation]] / [[SDN]] / [[SASE]]** — internal pentest tests whether a foothold in user VLAN reaches database VLAN.
- **[[Logging]] and [[SIEM]]** — purple team validates that every ATT&CK technique fires a detection or generates an artifact.
- **[[Encryption]] / [[PKI]] / [[TLS]]** — testing validates cert pinning, weak cipher rejection, and that [[SSL]] inspection isn't introducing weaker crypto downstream.

*The architecture is the hypothesis. The pentest is the experiment. The findings are the data. If you skip the experiment, you're running on faith.*

## SOC reality

- **The pentest pre-brief is a calendar invite you do not skip.** Tester IPs, time windows, in-scope assets — you put them in the SIEM as a watch-list with a "PENTEST" tag so you can triage real attacks during the engagement. The worst outcome is calling the FBI on your own pentester at 4am.
- **Purple team sessions are where detection engineering actually happens.** Red runs `Invoke-Mimikatz`, you watch [[EDR]] either fire or stay silent. If it stays silent, you write the rule, push to staging, validate, push to prod — all before lunch. *Detection content written during a purple session is worth ten written from a blog post.*
- **The CISO will ask after every test: "what's our remediation timeline?"** Have the answer ready. Critical: 7 days. High: 30. Medium: 90. Track them in the same workflow as scan findings. If a pentest finding sits open for six months, the next pentest will find it again.
- **Never promise the auditor that "we passed."** Pentests aren't pass/fail. They're "what we found and what we fixed." Mature programs report findings *and* remediation velocity. *A clean pentest report usually means the scope was too narrow.*
- **The handoff: tester → SOC for re-test validation → vuln management for tracking → GRC for compliance reporting → executive for risk acceptance on anything not remediated.** Every step gets a ticket. Every ticket gets a date.

## Related concepts

[[Red team]] · [[Blue team]] · [[Purple team]] · [[Vulnerability scanning]] · [[Vulnerability management]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Incident response]] · [[Tabletop exercise]] · [[Security awareness training]] · [[CVSS]] · [[OWASP Top 10]] · [[Zero trust]] · [[PAM]] · [[SIEM]] · [[EDR]] · [[Phishing simulation]] · [[Breach and attack simulation]] · [[Rules of engagement]]

*Source: VIRGIL knowledge base — 2026-05-11*