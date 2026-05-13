# Threat Hunting Process

## What it is

In **Escape from Tarkov**, you don't queue into Customs hoping to find loot. You queue in with a hypothesis: *the rogues at Water Treatment got pushed off thirty minutes ago, the extract through ZB-013 will be hot, and the squad that killed them is probably rotating to Dorms to reset.* You're not waiting for a gunshot to react to. You're moving toward where you think the threat already is, with a route picked, a kit chosen for that fight, and a fallback if the read is wrong. That's exactly what threat hunting is — proactive, hypothesis-driven adversary pursuit inside your own network, assuming the attacker is already there and your alerts haven't caught them yet.

Threat hunting is the structured process of forming a hypothesis about adversary activity, collecting and analyzing data to prove or disprove it, and turning the result into a new detection or a closed gap. It is not alert triage. It is not vulnerability scanning. It assumes the SIEM missed something and goes looking for the miss.

## Why it matters

Detection tooling is signature-and-heuristic bound. [[EDR]] catches known bad. [[SIEM]] catches what its rules say to catch. Anything new, slow, or living-off-the-land slips through — that's why dwell time for sophisticated intrusions still sits at weeks-to-months in industry reports. Threat hunting is the discipline that closes that gap. Every successful hunt produces one of two outcomes: a confirmed incident that goes to [[Incident Response]], or a tuned detection that makes the next intrusion of that type loud. There is no wasted hunt — the disproven hypothesis still hardens the environment.

For CySA+ this lands squarely in **Objective 1.4** — threat intelligence and threat hunting concepts. CompTIA tests the process steps, the distinction from reactive monitoring, and the integration with [[Threat Intelligence]] feeds.

## Key facts

### The hunting loop — six beats

CompTIA's framing tracks the standard industry loop. Memorize the order; CompTIA will scramble it.

| Phase | What happens | Tarkov parallel |
|---|---|---|
| **1. Establish hypothesis** | State a falsifiable claim about adversary activity. "Attacker is using WMI for lateral movement in the finance subnet." | "Squad rotating from Water Treatment to Dorms." |
| **2. Profile threats and TTPs** | Pick the actor groups plausible for your sector and pull their [[Tactics Techniques and Procedures]] from [[MITRE ATT&CK]]. | Knowing rogues drop Labs keys and PMCs rotate for them. |
| **3. Apply hunting tactics** | Query the data — [[SIEM]], [[EDR]] telemetry, NetFlow, DNS logs — against the hypothesis. | Running the route, scoping the angles. |
| **4. Reduce attack surface** | What you find that's not malicious but is still risky — open shares, stale admin accounts, misconfigurations — gets closed. | Locking the doors behind you so the next raid is quieter. |
| **5. Group critical assets / identify attack vectors** | Bucket the crown jewels into protection zones. Map the paths an attacker would take to reach them. | Knowing which extracts and stashes actually matter. |
| **6. Integrate intelligence, improve detection** | Feed findings back into [[SIEM]] rules, [[EDR]] policies, threat intel platform. Every hunt produces a detection or a closed gap. | Post-raid: update the map, share the intel with the squad. |

### Hypothesis types — three flavors CompTIA cares about

- **Intelligence-driven** — a [[Threat Intelligence]] feed reports a [[Threat Actor]] group is hitting your sector with a specific TTP. You hunt for that TTP in your environment. ("APT29 is using OAuth token theft against logistics firms — are we seeing anomalous OAuth grants?")
- **Situational-awareness-driven** — you know your environment changed. New M&A acquisition, new SaaS rollout, new VPN appliance. You hunt the new surface. ("We just merged Acme Corp's AD — is there anything weird in the trust relationship?")
- **Analytics-driven** — anomaly in a baseline. PowerShell execution count jumped 4x last Tuesday on workstations that don't normally run it. Hunt the deviation.

### Collection — where the data comes from

Hunting is only as good as the telemetry feeding it. CompTIA wants you to know the source taxonomy:

**Internal sources**
- [[EDR]] process trees, parent-child relationships, command-line arguments
- [[SIEM]] correlated logs from endpoints, servers, network, identity
- DNS query logs, NetFlow / IPFIX, proxy logs
- Identity and authentication logs (Kerberos, OAuth, federation)
- Configuration baselines — what *should* be running

**External sources**
- **[[Open Source Intelligence|Open source (OSINT)]]** — blogs, forums, social media, public reports, vendor research
- **Closed source / paid feeds** — commercial intel platforms with curated [[IoC|indicators]]
- **Government bulletins** — CISA alerts, FBI flashes, sector-specific advisories
- **Information sharing organizations** — [[ISAC]]s (FS-ISAC for finance, H-ISAC for health), CERT and [[CSIRT]] feeds
- **Deep/dark web monitoring** — credential dumps, ransomware leak sites, forum chatter about your org
- **Supply chain intel** — what's hitting your vendors will hit you next

### Intelligence quality — the four dimensions

When you fold intel into a hunt, judge it on:

- **Timeliness** — intel about an attack from 2019 is archaeology, not defense
- **Relevancy** — APT activity against semiconductor fabs is noise if you're a credit union
- **Accuracy** — false positives in a feed will burn analyst hours
- **Confidence level** — is the source saying "confirmed," "likely," or "we saw one packet"?

### Threat actors — who you're hunting

| Actor | Motivation | Sophistication | Typical TTPs |
|---|---|---|---|
| **[[Nation-state]] / [[APT]]** | Espionage, geopolitics | Highest | Custom malware, zero-days, long dwell, living-off-the-land |
| **[[Organized Crime]]** | Money | High | Ransomware, BEC, credential theft, initial access brokers |
| **[[Hacktivist]]** | Ideology | Mid | DDoS, defacement, doxing, leak sites |
| **[[Insider Threat]] — intentional** | Revenge, profit, espionage | Variable | Data staging, abnormal access patterns, USB exfil |
| **[[Insider Threat]] — unintentional** | Negligence | N/A | Misconfigurations, phishing victims, shadow IT |
| **[[Script Kiddie]]** | Clout | Low | Public tools, mass scanning, opportunistic |

Profile step 2 of the hunting loop is about asking: *which of these is actually plausible against us this quarter?* You don't hunt nation-state TTPs at a small dental practice. You hunt commodity ransomware affiliates.

### Active defense — where hunting touches deception

Hunting overlaps with **active defense** when you deploy [[Honeypot]]s, honey tokens, and honey credentials. The hypothesis becomes: *if anyone touches this, by definition it's adversary or insider misuse.* No legitimate user has a reason to authenticate with `svc_backup_admin_DECOY`. The trip flips the hunt from "looking" to "confirmed."

Related concept: **isolated networks** — when you hunt across air-gapped or segmented zones (OT, [[ICS]], lab networks), the telemetry collection is different and the assumption that "no internet" means "no threat" is exactly the assumption [[Supply Chain]] compromises exploit.

### CompTIA exam traps

> **CompTIA exam trap:** Threat hunting is NOT the same as [[Incident Response]] and NOT the same as alert triage. Hunting is *proactive and hypothesis-driven* — you start with a theory, not an alert. If the question describes an analyst responding to a SIEM alert, that's monitoring or IR. If the analyst is querying data with no alert in hand, that's hunting.

> **CompTIA exam trap:** Threat hunting is NOT [[Vulnerability Management]]. Vuln management asks "where am I weak?" Hunting asks "where is the adversary right now?" CompTIA will offer a vuln-scan answer to a hunting question — wrong.

> **CompTIA exam trap:** **CERT vs CSIRT.** Computer Emergency Response Team (CERT) is often a national or sector body that publishes bulletins (US-CERT, now CISA). Computer Security Incident Response Team (CSIRT) is typically the internal org team that handles incidents. CompTIA tests the distinction; they are not interchangeable.

> **CompTIA exam trap:** Intelligence dimensions — **timeliness, relevancy, accuracy, confidence**. CompTIA will list five options and one will be a distractor like "cost" or "volume." Pick the four above.

### Focus areas — what to actually hunt

Don't hunt everything. Pick the protected zones:

- **Business-critical assets** — domain controllers, payment systems, source code repos, executive mailboxes
- **Identity infrastructure** — AD, Entra ID, federation servers, PAM vaults
- **Internet-facing applications** — anything in the DMZ, anything SaaS-integrated, anything CVE-prone
- **Supply chain integrations** — vendor VPN tunnels, third-party API access, software update channels
- **Recent changes** — new deployments, new acquisitions, new vendor onboarding

*The hardest lesson from a real hunt: the senior engineer's "temporary" RDP rule from 2021 is still there, and someone is using it right now.*

## SOC reality

- **The hunt ticket doesn't start with an alert.** It starts with an analyst saying "I want to look for X this week" and a hunt lead approving the hypothesis, scope, and data sources. If you can't write the hypothesis as a falsifiable sentence, the hunt isn't ready.
- **Most hunts find nothing — and that's a successful hunt.** You disproved the hypothesis, you documented the queries, the next analyst doesn't have to re-run them. The hunts that *do* find something get converted into [[SIEM]] correlation rules within 48 hours or the lesson is wasted.
- **The CISO's question after every hunt is the same: "what did we change?"** New detection rule, closed firewall hole, decommissioned account, tuned [[EDR]] policy. If the answer is "nothing," the hunt program is theater.
- **Hunting is L2/L3 work.** L1 lives in the alert queue. L2 hunters need the data fluency to write KQL/SPL/EQL queries, read process trees, and recognize benign anomalies vs. malicious anomalies. Confusing the two is how false-positive fatigue starts.
- **Never promise leadership the environment is clean after a hunt.** A clean hunt means *that hypothesis* did not pan out. The next hypothesis might. Dwell time is measured in weeks for a reason.

## Related concepts

[[Threat Intelligence]] · [[MITRE ATT&CK]] · [[Tactics Techniques and Procedures]] · [[IoC]] · [[Indicators of Attack]] · [[SIEM]] · [[EDR]] · [[Incident Response]] · [[Honeypot]] · [[APT]] · [[Threat Actor]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[OSINT]] · [[ISAC]] · [[CSIRT]] · [[Vulnerability Management]] · [[Supply Chain]] · [[Insider Threat]]

*Source: VIRGIL knowledge base — 2026-05-11*