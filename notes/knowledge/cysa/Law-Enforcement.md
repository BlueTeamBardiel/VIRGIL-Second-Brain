# Law Enforcement

## What it is

In **Metal Gear Solid**, when Snake gets captured on Shadow Moses, Ocelot doesn't just take him in — he takes the situation. The torture room is on Ocelot's terms now. Snake's choices narrow. He can hit the button or not, but the timeline, the location, the witnesses, the evidence — all of it belongs to the captor. Calling in law enforcement during an incident is the same handoff. The moment you pick up the phone to the FBI field office, the case has new stakeholders with their own mission, their own legal authority, and their own clock. You don't drive anymore. You ride along, and you do it on their schedule.

In plain English: **law enforcement involvement is a one-way door**. Once a federal or local agency formally takes interest, your evidence handling, your remediation timeline, and your public communications all bend to their requirements — not yours.

Technical definition: law enforcement engagement during incident response is the coordinated notification, evidence preservation, and operational cooperation between a victim organization and a government investigative body (FBI, USSS, state police, foreign equivalents) when a cyber incident meets criminal thresholds or regulatory reporting obligations. It is one specific stakeholder communication channel within the broader [[Incident Response Reporting]] and [[Communications]] workflow defined under CS0-003 Objective 4.2.

## Why it matters

CySA+ Objective 4.2 specifically lists **law enforcement** as a stakeholder category alongside [[Legal]], [[Public Relations]], [[Media]], [[Customer Communication]], and [[Regulatory Reporting]]. CompTIA tests whether you understand that these are *different audiences with different rules*, not synonyms. The exam will hand you a scenario where the SOC analyst wants to wipe and re-image a compromised host immediately, and ask what's wrong with that decision. The right answer is almost always *"you destroyed evidence the FBI needed."*

Career-wise: most analysts will never personally make the call to law enforcement — that's a CISO or General Counsel decision — but you will be the person whose forensic discipline determines whether the case is prosecutable or laughed out of the field office. Bad chain of custody, missing memory captures, re-imaged drives, overwritten logs — every one of those is a case-killer.

## Key facts

### When law enforcement gets involved

Triggers fall into a few buckets:

| Trigger | Typical Agency (US) | Notes |
|---|---|---|
| Ransomware, financial fraud, BEC | FBI (IC3, Cyber Division) | FBI is the default federal cyber agency |
| Wire fraud, payment card theft | US Secret Service | USSS owns financial system crimes |
| Critical infrastructure attack | CISA + FBI | CISA coordinates, FBI investigates |
| Nation-state activity (APT) | FBI + intel community | You will be told very little back |
| Insider threat with criminal intent | FBI or local police | Depends on dollar value and jurisdiction |
| Child safety material discovered | FBI / NCMEC | Mandatory reporting — non-negotiable |

Outside the US: NCA in the UK, RCMP in Canada, BKA in Germany, AFP in Australia. Each has its own intake portal and disclosure rules.

### What changes the moment you call

This is the part the baseline note flags and the part CompTIA loves to test. Engagement is not free.

- **Evidence handling becomes forensic-grade or it's worthless.** Write blockers, bit-for-bit images, hash verification, [[Chain of Custody]] forms on every transfer. The standard goes from "good enough for the retro" to "good enough for federal court."
- **Remediation may be delayed.** Law enforcement may ask you to leave the threat actor in place to monitor C2, identify additional victims, or coordinate a takedown. The business hates this. Legal counsel mediates.
- **System seizure is on the table.** Federal agents can take physical drives, servers, even entire racks under warrant or with consent. Plan for it — keep golden images and clean spares.
- **Public communications get coordinated.** You don't get to publish the breach blog post on your own timeline anymore. The agency may request a hold while the investigation matures.
- **Information flow becomes one-way.** You give them everything. They give you very little back, sometimes for years.

### Cooperation is a choice, not a duty (usually)

Outside of mandatory regulatory reporting ([[CIRCIA]], [[GDPR]] 72-hour notification, [[HIPAA]] breach rule, [[PCI DSS]] card brand notification), engaging law enforcement is generally **voluntary**. Organizations may:

- **Cooperate fully** — share IOCs, malware samples, logs, interview staff
- **Cooperate selectively** — share indicators but decline interviews without subpoena
- **Decline** — refer everything through outside counsel, respond only to legal process

Counsel drives this. The CISO does not unilaterally call the FBI without General Counsel and usually the CEO signed in. The reason is that everything you voluntarily disclose becomes potentially discoverable in civil litigation later — class actions, shareholder suits, B2B contract disputes. Privilege matters.

*The first time I watched a CISO want to "just call the bureau and get help" before legal was looped in, our outside counsel spent the next six months unwinding what that one phone call exposed in subsequent class-action discovery.*

### What law enforcement actually wants from you

When the engagement is on, prepare to provide:

- **Incident timeline** — [[Who, What, When, Where]], in writing, with timestamps in UTC
- **[[Scope]] and [[Impact]] assessment** — how many systems, what data, what business processes
- **Evidence package** — disk images, memory captures, log exports, malware samples, network captures
- **IOCs** — hashes, IPs, domains, C2 URLs, mutex names, scheduled task names
- **TTPs mapped to [[MITRE ATT&CK]]** — they will ask
- **Staff availability for interviews** — analysts, sysadmins, helpdesk who saw the first weirdness
- **Point of contact** — usually outside counsel, not the SOC manager directly

What they generally will NOT give you in return: attribution confidence, other victim names, timeline for their investigation, status updates. Treat it like a black hole with a customer-service window.

### CompTIA's stakeholder model

Objective 4.2 lists law enforcement alongside other communication targets. Know the differences cold:

| Stakeholder | What they need | Timing |
|---|---|---|
| **Executive** | [[Executive Summary]], business impact, dollar exposure | Hours |
| **Legal** | Privileged work product, evidence status, regulatory exposure | Immediate |
| **Law Enforcement** | Forensic evidence, IOCs, TTPs, victim cooperation | Days–weeks |
| **Regulators** | Compliance with notification rules, breach details | Statutory deadlines (e.g., GDPR 72h) |
| **Customers** | Plain-language impact, what to do, what's protected | Per contract or law |
| **Public Relations / Media** | Approved talking points, no speculation | After legal review |

These channels run in parallel and they do not say the same things. Law enforcement gets technical truth. Media gets approved language. Customers get actionable advice. Mixing them up is how careers end.

### CompTIA exam traps

> **CompTIA exam trap:** When asked "what is the first action upon discovering a confirmed breach involving criminal activity?", the obvious answer is "call the FBI." It's wrong. The correct first action is **notify Legal / General Counsel**, who decides whether and when to engage law enforcement. Calling agencies before legal is involved is an evidence-handling and privilege disaster.

> **CompTIA exam trap:** "Law enforcement requires you to report all cyber incidents." False. Outside of specific regulatory triggers (CIRCIA for covered critical infrastructure, sector-specific rules), engagement is generally voluntary. Don't confuse *regulatory reporting* with *law enforcement notification* — they are different stakeholders with different rules.

> **CompTIA exam trap:** "Re-imaging the compromised host immediately to restore service" is wrong when law enforcement is involved or likely. The correct sequence is **preserve evidence first** (forensic image, memory capture, log export, hash verification) **then** remediate. Containment and evidence preservation come before recovery. This maps to the NIST IR lifecycle phase order.

### Evidence preservation checklist

If there's any chance law enforcement will be involved — and on a real breach there usually is — these are non-negotiable before you touch the host:

1. **Memory capture first** — volatile, gone on reboot. Use a known-good tool, hash the output.
2. **Disk image with a write blocker** — bit-for-bit. SHA-256 the image and the source.
3. **Log exports with timestamps** — SIEM, AD, firewall, EDR, DNS, proxy. UTC normalized.
4. **Chain of custody form** — who collected it, when, from where, where it went.
5. **Network captures** — if the actor is still active and counsel approves monitoring.
6. **Photograph the physical environment** — server rack, monitor, anything anomalous.
7. **Do NOT log in to "look around"** — every interactive logon overwrites evidence.

The chain of custody form is the artifact that prosecutors will hold up in court. One missing transfer signature and the defense argues the evidence was tampered with. Case dismissed.

## SOC reality

- At 3am on a confirmed ransomware hit, the L1 analyst does not call the FBI. The L1 calls the on-call IR lead, who calls the CISO, who calls General Counsel. Counsel decides on agency engagement, usually after sunrise and after outside counsel is briefed.
- The first thing the IR lead asks: *"Is the evidence preserved?"* If the answer is "we re-imaged the box to restore service," the next hour is brutal. Restoring service before forensics is a career-defining mistake on a federally interesting incident.
- The CISO asks legal, not the SOC, whether to engage law enforcement. The SOC's job is to make sure that if the decision is yes, the evidence is court-ready. Assume yes until told no.
- Never promise leadership that "the FBI will help us recover the data" or "we'll get attribution." You won't, usually. Federal cyber cases take years and most victims hear nothing back. Set expectations: cooperation may help others; it rarely helps you recover.
- The handoff: SOC → IR lead → CISO → General Counsel → outside counsel → FBI field office. Everyone in that chain has a different question. The SOC's only job in the chain is *"here is the technical truth, hashed and timestamped."*

## Related concepts

[[Incident Response Reporting]] · [[Chain of Custody]] · [[Legal]] · [[Regulatory Reporting]] · [[CIRCIA]] · [[GDPR]] · [[Executive Summary]] · [[Customer Communication]] · [[Public Relations]] · [[Media]] · [[Stakeholder Identification]] · [[Scope]] · [[Impact]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Evidence]] · [[Forensic Acquisition]] · [[Who What When Where]] · [[MITRE ATT&CK]]

*Source: VIRGIL knowledge base — 2026-05-11*