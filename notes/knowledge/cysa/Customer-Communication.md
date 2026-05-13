# Customer Communication

## What it is

In **Portal**, GLaDOS spends the entire first half of Aperture lying to you with a smile. "The cake is a real, edible cake." "Please assume the Party Escort Submission Position." She's friendly, helpful, and structured — she gives you updates on every test chamber, congratulates your progress, narrates the experience. And every word is a lie engineered to keep you compliant until the incinerator. By the time you reach the back rooms and see "THE CAKE IS A LIE" scrawled on the wall by previous test subjects, the trust is gone forever. You will never believe another sentence she says, even when she's telling the truth.

That's exactly what bad customer communication does during an incident — it doesn't matter that you eventually fixed the breach. The customer remembers the gap between "everything is fine" and the news article. They become the test subject who saw the writing on the wall, and they will never trust your status page again.

**Customer communication** during incident response is the structured, pre-planned process of notifying affected external parties — end users, B2B clients, partners — about an incident that may have impacted their data, services, or trust relationship with your organization. It is governed by contractual obligations ([[SLA]], [[MSA]]), regulatory mandates ([[GDPR]] Article 34, [[CCPA]], [[HIPAA]] Breach Notification Rule, [[PCI DSS]] 12.10.1), and the [[Communication Plan]] component of the [[Incident Response Plan]].

## Why it matters

Breaches don't kill companies. Bad post-breach communication does. Target survived 40M card numbers. Equifax got dragged for a decade — not for losing 147M records, but for the executives selling stock before the announcement, the misspelled phishing-bait notification domain, and the PIN-as-password lookup site. The breach was the wound. The communication was the infection that nearly took the limb.

For the **CS0-003 exam (Objective 4.2)**, customer communication is tested as one node inside the broader [[Incident Response Reporting]] graph: who gets told (stakeholder identification), what they're told (scope, impact, timeline), when they're told (regulatory clocks), and who controls the message ([[Public Relations]], [[Legal]], executives — not the SOC analyst). CompTIA wants you to know that customer comms is a *governed* process, not an L1 decision.

For your career: the day you handle your first real breach, you will discover that the technical containment took six hours and the customer notification draft took six days of legal review. This is normal. Plan for it now.

## Key facts

### The five rules of breach-time customer comms

1. **Communicate early — without lying.** "We are investigating reports of a potential incident" is true at hour two. "We have contained the incident" is a promise you cannot keep at hour two and will regret at hour seventy-two when the second-stage payload detonates.
2. **Pre-define the channel.** Status page, email, in-app banner, dedicated incident microsite. Decide before the incident which channel is canonical. During the incident is not the time to argue about whether Twitter counts.
3. **One spokesperson, one voice.** The CISO doesn't tweet. The L2 analyst doesn't email the customer. [[Public Relations]] and [[Legal]] write the words; an executive delivers them.
4. **Update on a cadence, not on events.** "We will provide an update every 4 hours until resolution" beats "we'll let you know when we know more." Silence is interpreted as cover-up.
5. **Never speculate on attribution.** "Nation-state actor" sounds impressive in the war room. It sounds like a lawsuit in the press release.

### What goes in the notification

The CompTIA-aligned breach notification template covers the **who-what-when-where-why** of the incident, adapted for an external audience:

| Element | What the customer needs | What to omit |
|---|---|---|
| **Who** | Which customers/data subjects are affected | Internal employee names, threat actor speculation |
| **What** | Categories of data involved (PII, payment, credentials) | Exact log entries, IoCs, [[TTPs]] |
| **When** | Date of incident, date of discovery, date of notification | Detection gaps that imply negligence (legal will edit) |
| **Where** | Which systems/services were impacted | Network topology, host names |
| **Scope** | Number of records, geographic reach | Internal asset inventory |
| **Impact** | What the customer should do (reset password, monitor credit) | Internal [[business impact analysis]] dollar figures |
| **Remediation** | What you've done and are doing | Specific control gaps that remain open |
| **Contact** | Dedicated channel for questions | The SOC analyst's direct line |

### Regulatory clocks — know these cold

| Regulation | Customer notification window | Trigger |
|---|---|---|
| **GDPR Art. 34** | "Without undue delay" to data subjects when high risk | Personal data breach with high risk to rights/freedoms |
| **GDPR Art. 33** | 72 hours to supervisory authority | Any personal data breach |
| **HIPAA Breach Notification** | 60 days to individuals | Unsecured PHI breach |
| **HIPAA (large breach)** | 60 days to HHS and media | 500+ individuals affected |
| **PCI DSS 12.10.1** | Per card brand timelines | Cardholder data compromise |
| **CCPA / CPRA** | "Most expedient time possible" | CA resident PII breach |
| **State breach laws (US)** | Varies — typically 30–90 days | Per state definition of PII |
| **CIRCIA (critical infra)** | 72 hours to CISA | Covered cyber incident |

> **CompTIA exam trap:** Don't confuse the **72-hour GDPR clock** with customer notification. The 72 hours is to the *supervisory authority* (the regulator). Data subject (customer) notification is "without undue delay" and only when the risk is high. CompTIA will offer both in answer choices.

> **CompTIA exam trap:** **CIRCIA's 72-hour reporting** is to CISA, not customers. **Ransomware payment reporting under CIRCIA is 24 hours.** Different clocks, same statute.

### Stakeholder identification — who is "the customer"?

"Customer communication" is broader than retail end users. The stakeholder map:

- **End consumers** — retail users, account holders. Want plain English, action items.
- **B2B clients** — enterprise customers with SLAs and contractual breach clauses. Want technical detail, [[RCA]], remediation commitments.
- **Partners and integrators** — third parties whose systems touch yours. Want IoCs, scope of cross-environment exposure.
- **Resellers and channel** — they get the customer's question before you do. Need talking points first.
- **Regulators** — technically not "customers" but live on the same comms timeline.
- **Internal employees** — often forgotten; they will see the press before they see the all-hands email if you let them.

The [[Communication Plan]] should list every category, the channel, the spokesperson, and the legally-cleared template — *before* the incident.

### Who actually writes it

The SOC analyst does not write customer communication. Repeat that. The SOC analyst provides:

- **Scope** — confirmed affected systems, confirmed affected record count
- **Timeline** — first event, detection, containment milestones (the [[Timeline]] artifact from your [[Incident Response Report]])
- **Impact** — what data classes were exposed, what services were degraded
- **Evidence status** — what's preserved, what's lost, [[Chain of Custody]] integrity

That feeds to: **Legal** (liability framing, regulatory triggers) → **Public Relations** (tone, audience adaptation) → **Executive** (CEO/CISO sign-off) → **Customer**. The SOC stays in the war room. The press release goes through four desks before it goes out.

> **CompTIA exam trap:** When a question asks "who should communicate with customers during an incident," the answer is never "the incident response team" or "the SOC analyst." It is **PR/Legal/Executive leadership**, coordinated through the communication plan. The IR team feeds them facts; they shape the message.

### Metrics customers will eventually ask about

If the customer is a sophisticated B2B client, expect them to demand your incident metrics in the post-mortem:

- **[[MTTD]] (Mean Time to Detect)** — how long the attacker dwelled before you noticed. Industry median is still measured in *weeks*. Anything under 24 hours is strong.
- **[[MTTR]] (Mean Time to Respond)** — detection to containment. Hours for mature programs.
- **[[MTTRem]] (Mean Time to Remediate)** — containment to full eradication and recovery. Days to weeks, honestly.
- **Alert volume** — context for whether this signal was buried in noise. Useful for explaining the detection gap without sounding like you're making excuses.

The honest version of these numbers, presented with context, builds more trust than the polished version with gaps. *I have watched a CISO win back a furious enterprise client by saying "our MTTD on this was 14 days and that's not good enough" — the apology with the number was worth more than any remediation commitment.*

### What never goes to the customer

- **Specific IoCs** unless you're issuing them as defensive intel to partners (then via [[STIX]]/[[TAXII]] or a private channel, not the press release)
- **Attribution claims** — "nation-state" or named APT groups. [[Law Enforcement]] and intel teams handle attribution.
- **Internal personnel names**
- **Detailed network architecture or [[asset inventory]] data**
- **Speculation about [[root cause]]** before [[RCA]] is complete
- **Promises about future security posture** that haven't been engineering-validated

## SOC reality

- The first customer-facing tweet during an incident is drafted by PR, reviewed by Legal, approved by the CISO, and posted by Comms. You, the analyst, will read it on your phone at 4am and want to add caveats. You will not be allowed to. This is correct.
- The CISO will ask you, every 30 minutes: *"What's the confirmed scope? What can we say publicly?"* The answer to the second question is almost always "less than you think." Give them the confirmed scope only — never the suspected scope. PR will translate confirmed scope into customer language; they cannot un-say suspected scope.
- The B2B account managers will lose their minds because their clients are screaming. Route them to the canonical comms channel and the spokesperson. Do not let them backdoor the SOC for "just a quick update" — every off-script comment is a future deposition exhibit.
- Never tell leadership "we've contained it" until you've held a clean state for at least one full detection cycle. *I have watched a "contained" call get walked back six hours later when the second C2 beacon fired from a host nobody had inventoried. The customer notification that went out in the gap is now in a legal binder.*
- The handoff: SOC → IR Lead → Legal/PR/Exec → Customer. Four desks. If you find yourself talking directly to a customer during an active incident, something has gone wrong with your communication plan.

## Related concepts

[[Incident Response Plan]] · [[Communication Plan]] · [[Stakeholder Identification]] · [[Public Relations]] · [[Legal Hold]] · [[Regulatory Reporting]] · [[GDPR]] · [[HIPAA]] · [[PCI DSS]] · [[CIRCIA]] · [[Executive Summary]] · [[Incident Response Report]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Chain of Custody]] · [[MTTD]] · [[MTTR]] · [[MTTRem]] · [[Law Enforcement Coordination]]

*Source: VIRGIL knowledge base — 2026-05-11*