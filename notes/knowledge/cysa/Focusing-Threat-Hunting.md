# Focusing Threat Hunting

## What it is

In **Hitman**, 47 doesn't sweep the entire Sapienza coastline looking for Silvio Caruso. He gets a mission briefing, studies the map, identifies the chokepoints — the private lab, the golf course, the ICA hands him the targets, the opportunities, and the high-value zones. He doesn't waste a single bullet checking every gardener. He focuses on the targets that matter, the rooms they'll be in, and the disguises that get him close. That's exactly what focused threat hunting does — you don't hunt everywhere, you hunt where the targets actually are.

In plain English: threat hunting is the practice of proactively searching your environment for adversary activity that automated detection missed. **Focusing** that hunt means narrowing the search space to the systems, behaviors, and assets where a real attacker would actually be operating — because hunting blind across the entire estate is how you spend three weeks chasing nothing.

Technical definition (CS0-003 1.4): threat hunting is an analyst-driven, hypothesis-based investigation of an environment to detect threats that have evaded existing controls. Focus areas are the prioritized scopes — configurations/misconfigurations, isolated networks, and business-critical assets and processes — that direct hunt effort toward maximum-impact, maximum-likelihood targets.

## Why it matters

The estate is too big. A mid-sized enterprise generates terabytes of telemetry a day. If you hunt without focus, you either burn out your team chasing the noise or you stare at dashboards and call it "hunting." Neither catches the adversary.

Focused hunting is what separates the SOC that finds the [[APT]] sitting on a domain controller from the SOC that finds it six months later when CrowdStrike's IR team shows up. CompTIA tests this directly under Objective 1.4 — they want you to know that threat hunting is **hypothesis-driven**, **focused**, and **distinct from monitoring**. Monitoring waits for alerts. Hunting goes looking.

For your career: hunt teams are the highest-paid analysts in the SOC. They're the ones leadership trusts to answer the question, *"are we compromised right now and we just don't know it?"* That question doesn't have a tool answer. It has an analyst answer.

## Key facts

### The three primary focus areas (CompTIA-tested)

CompTIA explicitly calls out three areas where focused hunting pays off. Memorize these — the exam will give you a scenario and ask which focus area applies.

| Focus area | What you're hunting for | Why it matters |
|---|---|---|
| **Configurations / misconfigurations** | Drift from baseline, weak settings, exposed services, default creds, over-permissioned accounts | Most breaches exploit a misconfiguration, not a zero-day. Drift happens silently. |
| **Isolated networks** | Lateral movement attempts, unexpected egress, anomalous east-west traffic, anything talking *out* of an air-gapped or segmented zone | Isolation is the control. If something's bridging it, you have an active intruder or a broken control. |
| **Business-critical assets and processes** | Behavioral anomalies on crown-jewel systems — domain controllers, payment processors, ICS gear, source code repos, exec mailboxes | Attackers go where the money is. So do hunters. |

### Why focus on these three specifically

**Configurations drift.** Every change ticket, every emergency patch, every "just for the demo" firewall rule that never got reverted — drift accumulates. Hunting configuration drift means diffing current state against a known-good baseline and asking *why is RDP open on this jump host*. Pair this with [[Vulnerability Management]] — misconfigs are vulnerabilities that don't have CVEs.

**Isolated networks are honey.** If a network is supposed to be isolated, any successful east-west or north-south traffic from it is, by definition, anomalous. The signal-to-noise ratio on a properly isolated segment is gorgeous — almost everything that fires is real. This is also where you deploy a [[Honeypot]] and where [[Active Defense]] earns its keep.

**Business-critical assets have known behavior.** A domain controller has a baseline — it does AD replication, it serves Kerberos, it logs to SIEM. The moment it spawns powershell.exe with `-EncodedCommand` and beacons to a never-before-seen IP, you have a hypothesis worth hunting on. Crown jewels are small in number and rich in signal.

### The hunt loop

Focused hunting is iterative, not linear:

1. **Hypothesis** — "An attacker who got initial access via phishing would attempt lateral movement to our finance file server within 72 hours."
2. **Scope** — define the focus area (the finance file server, its access logs, parent process trees on connecting endpoints, last 72 hours).
3. **Collect** — pull the relevant telemetry from [[SIEM]], [[EDR]], NetFlow, AD logs.
4. **Analyze** — look for the [[Indicators of Compromise|IoCs]] and behaviors consistent with the hypothesis.
5. **Confirm or refute** — either you found something (escalate to [[Incident Response]]) or you didn't (refine the hypothesis or move on).
6. **Document** — even a negative result is data. Tomorrow's hunt starts from today's notes.

### Hypothesis sources

Where do good hypotheses come from? Not your gut. Real sources:

- **Threat intelligence** — [[OSINT]], [[Government Bulletins]] (CISA, US-CERT), [[ISACs]], paid feeds, [[Deep/Dark Web]] monitoring, vendor reports on [[Nation-State]] or [[Organized Crime]] groups targeting your sector
- **[[MITRE ATT&CK]] coverage gaps** — pick a technique your detections don't cover, hunt for it manually
- **Recent incidents** — your own or a peer's. If a competitor got hit by a [[Supply Chain]] attack via a specific SaaS vendor, hunt your own logs for the same vendor's traffic patterns
- **Insider risk signals** — HR flags, unusual data access from [[Insider Threat]] indicators, off-hours activity
- **Internal sources** — your own help desk tickets are a goldmine. "My computer is slow" sometimes means cryptominer.

### Threat-intel attributes that drive focus

When intel comes in, weigh it before you act:

- **Timeliness** — is this current or six months stale? Stale IoCs catch nothing.
- **Relevancy** — does this threat actor target your industry, your geography, your tech stack?
- **Accuracy** — is the source trustworthy? Reputable vendor vs. anonymous Pastebin?
- **Confidence levels** — high/medium/low. Don't burn hunt cycles on low-confidence noise.

These four come straight out of the CompTIA objectives. Expect a scenario question.

### CompTIA exam traps

> **CompTIA exam trap:** Threat hunting vs. monitoring. **Monitoring is reactive** — alerts fire, analysts respond. **Hunting is proactive and hypothesis-driven** — analysts go looking before any alert fires. If the question describes someone "responding to a SIEM alert," that's monitoring/IR, not hunting.

> **CompTIA exam trap:** Threat hunting vs. incident response. Hunting *can* trigger IR, but it isn't IR. Hunting ends the moment you confirm compromise — then you hand the ball to the IR team and the four-phase lifecycle (Preparation → Detection & Analysis → Containment, Eradication & Recovery → Post-incident) takes over.

> **CompTIA exam trap:** The three focus areas. If you see "isolated network," "business-critical asset," or "configuration drift" in a hunting scenario, those are the CompTIA-blessed focus targets. Don't pick "scan the whole enterprise" — that's the wrong answer by design.

> **CompTIA exam trap:** Threat-intel attributes. **Timeliness, relevancy, accuracy, confidence levels.** CompTIA will swap one of these with a plausible distractor like "cost" or "volume." Cost is a procurement concern, not an intel-quality attribute.

## Feynman: hunting is the Hitman briefing, not the sweep

In **Hitman**, the worst run is the one where 47 starts in the lobby with no plan, no disguise, and a silenced pistol, hoping to bump into Viktor Novikov somewhere in the Paris fashion show. He'll either get caught by a bodyguard or spend an hour wandering. The good run starts with the briefing: *Novikov is in the auction room. Dahlia Margolis is upstairs. The IAGO auction begins at the top of the hour. The bodyguards rotate at these chokepoints.*

That's focused hunting.

The hunt team gets a briefing too. It's not from Diana Burnwood — it's from the threat intel team, the [[ISAC]] feed, the CISA bulletin that dropped this morning saying *APT29 is targeting healthcare VPN appliances with this specific behavior pattern*. The hunt lead reads it the way 47 reads the level map: where are the targets, what disguises (TTPs) are they using, what chokepoints (focus areas) do they have to pass through?

Then they pick the focus:
- Configuration drift on the VPN appliances themselves
- East-west traffic from those appliances into the isolated clinical network
- Anomalous authentication patterns against business-critical EHR systems

They don't sweep the whole estate. They go where Novikov will be.

*The hunt that finds nothing in a focused scope is more valuable than the hunt that finds nothing across the whole network — because you can confidently say "not here" about something specific.*

## SOC reality

- **What hunting actually looks like at 3pm Tuesday:** an analyst with two monitors, one open to Splunk/Sentinel/Elastic, the other open to a Confluence page titled "Hunt Hypothesis — APT29 VPN Compromise." Coffee. Forty-seven failed queries before one returns something interesting. Hunting is mostly tuning queries.
- **The L1 doesn't hunt — yet.** Hunting is typically L2/L3 work. L1 triages the alert queue. If you're studying CySA+, you're studying toward the role that gets *promoted into* hunting.
- **The CISO asks one question:** *"What did you hunt for, and what did you find?"* The answer is never "nothing." It's *"hypothesis X was tested against scope Y, no indicators of compromise found, here are the three detection gaps we identified during the hunt."* Negative results are still deliverables.
- **Never promise "we're clean."** The honest version is *"we hunted for this specific TTP across these specific assets and found no evidence. Absence of evidence is not evidence of absence."* Say the second sentence out loud. It saves careers.
- **The handoff:** hunt finds something → escalate to [[CSIRT]] / IR → preserve evidence, [[Chain of Custody]] starts, hunt team supports forensics but doesn't lead containment. Roles stay clean.
- **80% of hunts find nothing actionable. 20% find detection gaps, misconfigurations, or actual intrusions.** That 20% is why the program exists.

## Related concepts

[[Threat Intelligence]] · [[Indicators of Compromise]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Advanced Persistent Threat]] · [[Honeypot]] · [[Active Defense]] · [[SIEM]] · [[EDR]] · [[Vulnerability Management]] · [[Incident Response Lifecycle]] · [[CSIRT]] · [[Insider Threat]] · [[Supply Chain Attack]] · [[OSINT]] · [[ISAC]] · [[Configuration Drift]] · [[Threat Actors]]

*Source: VIRGIL knowledge base — 2026-05-11*