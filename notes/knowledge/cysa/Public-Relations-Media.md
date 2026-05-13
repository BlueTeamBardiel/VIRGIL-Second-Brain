# Public Relations & Media

## What it is

In **Resident Evil**, the opening cinematic of the original 1996 release shows the Raccoon City news report on cannibalistic murders in the Arklay Mountains. Umbrella Corporation's PR machine spent months ahead of that broadcast spinning the disappearances as bear attacks, hiker accidents, anything but a viral outbreak from their underground lab. By the time Chris and Jill's S.T.A.R.S. Bravo team went in, the public narrative was already locked — and when Umbrella's containment failed in Raccoon City two months later, the company's reputation didn't survive the gap between what they'd said and what was crawling out of the sewers. That's exactly what bad incident PR does — the gap between your messaging and your reality is where your brand dies.

**Plain English:** Public Relations & Media is the practice of controlling the external narrative about a security incident — who speaks, what they say, when they say it, and how it lines up with what's actually true.

**Technical (CS0-003):** Public relations during incident response is the coordinated communication function that manages information flow between the affected organization and external audiences — press, social media, industry analysts, the general public — to preserve trust, meet regulatory disclosure obligations, and prevent narrative drift that could amplify harm. It runs in parallel to [[Customer Communication]], [[Regulatory Reporting]], and [[Law Enforcement]] coordination but answers to different audiences with different tolerances for technical detail.

## Why it matters

The breach itself rarely kills the company. The press release does. Equifax in 2017, Target in 2013, SolarWinds in 2020 — in every case, the *handling* drove the long-term damage more than the intrusion. Stock price, customer churn, regulatory scrutiny, class actions: all anchored to how the first 72 hours of public messaging landed.

For the CySA+ exam, this falls under **Objective 4.2 — incident response reporting and communication**. CompTIA tests whether you understand that PR is part of the IR playbook, not a separate function bolted on after the fact. The exam expects you to recognize the spokesperson model, pre-approved messaging, and the tension between speed and accuracy in modern media cycles.

For the analyst — you will never be the one talking to reporters. But you will be the one drafting the technical facts that get sanitized up the chain into the public statement. If your timeline is wrong, the CEO's apology is wrong. If your scope is wrong, the lawsuit is bigger.

## Key facts

### The single-spokesperson rule

One voice. Always. Every breach playbook names a **designated incident spokesperson** — typically the CISO, General Counsel, or a dedicated Crisis Communications lead. Everyone else — engineers, analysts, middle management, the helpful sales rep — is forbidden from commenting to media, posting on LinkedIn, or replying to journalist DMs.

| Role | Speaks to media? |
|------|------------------|
| Designated spokesperson (CISO / Legal / Comms lead) | Yes — only authorized voice |
| Executive team (CEO, CFO) | Only with pre-approved script, coordinated with spokesperson |
| SOC analysts, IR team | **Never** — refer all inquiries to spokesperson |
| Sales, support, marketing | **Never** — refer all inquiries to spokesperson |
| Board members | Only through coordinated investor relations channel |

The reason is simple: contradictory statements from two company sources is the lead paragraph of every breach article. Reporters *hunt* for the second voice because that's where the real story lives.

### Pre-approved messaging — the holding statement

The first public statement during an incident is almost never the full truth, because the full truth isn't known yet. It's a **holding statement** — pre-drafted before the incident, customized with current facts, approved by Legal and Comms in under an hour.

A holding statement covers:
- **Acknowledgment** — yes, we are aware of an issue
- **Action** — we are investigating with internal and external experts
- **Audience care** — we take the security of our customers seriously (lawyered phrasing)
- **Next update commitment** — we will provide an update by [time]

What it does NOT contain:
- Speculation on cause, scope, or threat actor
- Specific numbers (records affected, dollar impact)
- Promises about what was or wasn't stolen
- Technical detail that could aid the attacker still in your network

*The first statement exists to buy time, not to inform. Anyone who treats it as the final word is going to embarrass themselves in the second statement.*

### The speed problem — why NIST 800-61 is dated

NIST SP 800-61 (Computer Security Incident Handling Guide) was last meaningfully revised before TikTok existed. Its communication guidance assumes a press-conference rhythm: 24-hour news cycles, journalists who call for comment before publishing, time to convene a war room.

Modern reality:
- Breach rumors hit Reddit and X within hours of the first dark-web post
- Security researchers tweet IoCs and victim attribution before the victim knows they're breached
- Customers screenshot weird account activity and post it before your SOC opens the ticket
- A single Mastodon post from a credible researcher can move the story faster than your General Counsel can finish reading the holding statement

What this means operationally: the **monitoring side of PR** is now part of detection. Your comms team should be watching X, Reddit, breach forums, and Telegram channels for early signal that *you're the victim*. More than one organization has learned about its own breach from a journalist's email.

### Coordinating with adjacent functions

PR does not operate in isolation. It sits at the intersection of:

- **[[Legal]]** — every public statement is reviewed for liability exposure, regulatory compliance, and litigation hold implications. Legal usually has *veto*, not just input.
- **[[Regulatory Reporting]]** — GDPR (72-hour notification to supervisory authority), CIRCIA (covered entities, US), SEC (material cyber incidents within 4 business days for public companies under the 2023 rule), state breach laws (all 50 US states + DC). PR statements must not contradict regulatory filings.
- **[[Law Enforcement]]** — FBI, Secret Service, or national CSIRT engagement. LE often *requests* delay of public disclosure to preserve investigation. PR must coordinate the gag period with the legal disclosure clock.
- **[[Customer Communication]]** — direct customer notifications (email, in-app) usually go out *before* media statements, so customers don't learn about their own breach from the news.

### The disclosure timing tradeoff

| Disclose early | Disclose late |
|----------------|---------------|
| Builds trust, narrative control | More accurate facts, fewer corrections |
| Meets regulatory deadlines safely | Risk of regulator fines, leak from researcher |
| Activates customer protective action | Risk of customers blindsided by news |
| Risk of inaccurate detail | Risk of looking like a cover-up |

There's no right answer. Every incident is a judgment call between these columns. The CISO who tells you there's a clean formula is selling something.

### CompTIA exam traps

> **CompTIA exam trap:** The exam will offer "the SOC analyst should brief the journalist on technical details to ensure accuracy" as a plausible-looking answer. It's wrong. The analyst NEVER speaks to media. The correct answer is always "refer to the designated spokesperson" or "follow the established communications plan."

> **CompTIA exam trap:** Confusing **Public Relations** with **Customer Communication** with **Regulatory Reporting**. They're three distinct audiences. PR = media and general public. Customer comms = direct notification to affected individuals/orgs. Regulatory = mandatory filings to government bodies. A single incident generates all three workstreams in parallel, each with different content, timing, and legal weight.

> **CompTIA exam trap:** "When should the organization disclose the incident publicly?" The exam answer is almost never "immediately" or "after full remediation." It's "according to the established incident response plan and applicable regulatory requirements." CompTIA tests *process adherence*, not gut calls.

### The five Ws as PR scaffolding

Every public statement is built on **Who, What, When, Where, Why** — the same scaffolding as the internal IR report, sanitized:

- **Who** — the organization acknowledging (not the attacker; attribution is dangerous early)
- **What** — high-level nature of the incident ("unauthorized access to a portion of our systems")
- **When** — discovery date, not always intrusion date (those usually differ — see [[Mean Time to Detect]])
- **Where** — affected systems or services at the business-unit level, never network-level detail
- **Why** — almost always omitted from early statements. Root cause analysis comes later.

### Metrics that surface in PR statements

Public statements increasingly reference operational metrics to signal maturity:

- **[[Mean Time to Detect]] (MTTD)** — how fast you noticed. Industry average is in the *months*, so single-digit days looks good.
- **[[Mean Time to Respond]] (MTTR)** — how fast containment started after detection
- **[[Mean Time to Remediate]] (MTTRem)** — how long full eradication and recovery took
- **[[Alert Volume]]** — rarely public, but referenced in post-incident reports to leadership

Be careful — disclosing weak metrics in a press statement is a self-inflicted wound. Disclose only what the regulator requires or what helps the narrative.

## SOC reality

- At 3am when the breach goes public on Reddit before your IR call has finished, the CISO's first question is not "how did they get in" — it's "who else knows, and what are they saying." Your job in that moment is to feed the comms lead a clean five-line factual summary, nothing more.
- Every analyst on the IR bridge will get a LinkedIn message from a journalist within 48 hours of a major incident. The correct response is no response. Forward to comms. Do not be helpful. Do not be flattered.
- When the executive summary draft circulates, read it for technical accuracy *only*. Do not edit tone, do not soften scope, do not negotiate language. That's Legal and Comms' job. Your job is to make sure no factual claim in the public document contradicts the forensic timeline.
- Never tell leadership "we've contained it" before you actually have. That phrase ends up in the press release. If it's wrong, the second press release is the one that tanks the stock.
- The handoff: SOC analyst → IR lead → CISO → Legal → Comms → designated spokesperson → media. Six handoffs, each one a chance for facts to drift. The analyst's job is to make their handoff bulletproof, because everything downstream depends on it.

## Related concepts

[[Customer Communication]] · [[Regulatory Reporting]] · [[Law Enforcement]] · [[Legal]] · [[Stakeholder Identification]] · [[Executive Summary]] · [[Incident Response Reporting]] · [[Root Cause Analysis]] · [[Lessons Learned]] · [[Mean Time to Detect]] · [[Mean Time to Respond]] · [[Mean Time to Remediate]] · [[Incident Declaration]] · [[Scope]] · [[Impact]] · [[Timeline]] · [[Evidence]] · [[Recommendations]]

*Source: VIRGIL knowledge base — 2026-05-11*