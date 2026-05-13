# Confidence Levels in Threat Intelligence

## What it is

In **Demon's Souls**, the bloodstains on the floor of Boletarian Palace are the only intel you have about what just killed the player before you. Touch one and you see a ghostly replay — but the replay lies sometimes. The player might have died to the dragon's fire, or to a fall, or to a Blue-Eye Knight you can't see from the angle of the ghost. Some bloodstains are gold-standard — clear footage of the exact moment someone got one-shot by a specific enemy. Some are garbage — they show a player flailing in a corner and dying off-screen for no visible reason. The smart run is to read every bloodstain but trust the clear ones more than the murky ones. You don't ignore the murky ones — they still tell you "something killed someone here." You just don't bet your last Stone of Ephemeral Eyes on what.

That's exactly what confidence levels do in threat intelligence — they grade how much you trust the intel, separately from whether the intel is useful. A confidence level is a metadata tag attached to a piece of [[Threat Intelligence]] — an indicator, a TTP, an attribution claim — that tells the consumer how reliable the producer believes the data to be. It's the difference between *"we observed this hash on a confirmed C2 callback from a sandboxed sample"* (high confidence) and *"a forum post claimed APT29 might be using this domain"* (low confidence). Same intel format. Wildly different weight when you decide whether to block, hunt, or just file.

## Why it matters

Threat intel without confidence levels is just rumor. CompTIA Objective **CS0-003 1.4** explicitly calls out confidence levels alongside **timeliness**, **relevancy**, and **accuracy** as the four characteristics that determine whether intelligence is actually usable. The exam will test that you know confidence is about **trustworthiness of the source and the assessment**, not about how dangerous the threat is or how much you'd like it to be true.

In practice, confidence drives action. A high-confidence indicator from a [[Government Bulletin]] (CISA, US-CERT) gets pushed to the firewall the same hour. A low-confidence indicator from an open-source [[Blog/Forum]] post gets dropped into a hunt queue for an analyst to validate before anyone blocks anything. Block based on bad low-confidence intel and you take down your own payroll vendor on a Tuesday morning. Ignore high-confidence intel because nobody triaged it and you're explaining to the board why ransomware hit on Friday.

## Key facts

### The standard confidence scale (Admiralty / NATO style)

Most mature intel programs use a six-tier scale derived from the **Admiralty Code** (also called the **NATO System**). CompTIA references the same general structure:

| Tier | Score | Meaning |
|------|-------|---------|
| **Confirmed** | 90–100 | Independently corroborated by multiple reliable sources; observed firsthand |
| **Probable** | 70–89 | Logically consistent, supported by other intel, source is reliable |
| **Possible** | 50–69 | Plausible, partially supported, source reliability uncertain |
| **Doubtful** | 30–49 | Possible but not supported by other intel |
| **Improbable** | 2–29 | Contradicts other intel or comes from an unreliable source |
| **Discredited** | 1 | Confirmed false |

The scale separates **source reliability** (is this analyst/feed historically right?) from **information credibility** (does this specific claim hold up?). Mature shops score both axes independently then combine.

### What confidence is NOT

- **Not severity.** A confirmed CVSS 3.1 issue is still low impact. A possible CVSS 9.8 is still possible.
- **Not freshness.** That's **timeliness** — a separate quality attribute. A confirmed IoC from 2019 is still confirmed, just probably stale.
- **Not relevance.** That's **relevancy** — does it apply to your environment? Confirmed intel about Cisco ASA exploitation is irrelevant if you run Palo Alto.
- **Not accuracy.** Accuracy is whether the technical details are correct (right hash, right port). Confidence is whether you trust the producer got it right.

Four separate dials. The exam loves to confuse them.

### Confidence by source type

Different [[Collection Methods and Sources]] carry different baseline trust:

| Source | Baseline confidence | Why |
|--------|---------------------|-----|
| **Government bulletins** ([[CERT]], CISA, NCSC) | High | Vetted, attributable, accountable |
| **Paid feeds** (Mandiant, Recorded Future, CrowdStrike) | High | Analyst-curated, SLA-backed |
| **ISAC sharing** (FS-ISAC, H-ISAC) | High | Peer-verified within sector |
| **Closed source** (internal red team, IR engagements) | High to Medium | Firsthand but small sample |
| **OSINT** ([[Open Source Intelligence]] — blogs, vendor research) | Medium | Quality varies wildly by author |
| **Social media** (Twitter/X infosec community) | Medium to Low | Fast but unverified |
| **Deep/dark web** forums | Low | Adversary disinformation, broken English, brag posts |
| **[[Honeypot]]** observations (yours) | High for what you saw | But sample of one — generalize carefully |

### Confidence evolves

Intelligence is not static. A piece of intel often starts at **Possible** and climbs as corroboration arrives:

1. Analyst spots a suspicious domain in [[DNS]] logs → Possible
2. Sandbox detonation of a phish confirms the domain is a C2 → Probable
3. Two ISAC peers report the same domain in unrelated incidents → Confirmed
4. Domain is sinkholed by law enforcement and the campaign is published → Confirmed + Discredited (no longer active)

*The mistake junior analysts make: tagging intel at first sighting and never re-grading it. Stale confidence is worse than no confidence — it tells you the org isn't actually doing intel work, just collecting feeds.*

### How low-confidence intel still earns its keep

Low confidence does **not** mean delete. It means **don't act unilaterally**. The right plays for low-confidence intel:

- **Feed it to threat hunting.** Hunt hypotheses don't need confirmation — they need leads. *"Possible APT41 infrastructure on these IPs"* is a fine hunt seed.
- **Stage it in detection-only mode.** SIEM correlation rule that **alerts** but doesn't **block** on the IoC.
- **Tag it for retroactive search.** If it gets confirmed next week, you want to be able to grep last month's logs for it.
- **Cross-reference against existing telemetry.** Did anyone in your environment touch the suspicious domain? If yes, confidence in *your* exposure just jumped, even if confidence in the original attribution didn't.

*An IoC at 35% confidence is not a block. It's a question — "did we see this?" — and the answer is in your logs, free.*

### How high-confidence intel can still burn you

[[False Positives]] don't only come from bad intel. They come from good intel applied without **relevancy** filtering. A confirmed IoC for an APT campaign targeting energy-sector ICS is useless to a SaaS startup — and if you blanket-block the listed IPs, you might block your AWS region's NAT gateway because the attacker pivoted through cloud infra everyone uses.

> **CompTIA exam trap:** Confidence and accuracy are NOT the same. Confidence is *how much you trust the source/assessment*. Accuracy is *whether the technical data is correct*. A confirmed (high-confidence) IoC can still have a typo'd hash (low accuracy). CompTIA will give you a scenario and ask which intel quality is being described — read for "trust the source" (confidence) vs "data is right" (accuracy) vs "still current" (timeliness) vs "applies to us" (relevancy).

> **CompTIA exam trap:** Low confidence does **not** mean ignore. The exam will offer "discard the intelligence" as a tempting answer for low-confidence indicators. Wrong. The right answers are *validate*, *hunt*, *correlate*, *monitor in detection mode*. Only **Discredited** (confirmed false) gets discarded.

> **CompTIA exam trap:** Confidence is set by the **producer**, but the **consumer** must reassess against their own environment. Producer says Confirmed for the IoC; if you can't reproduce in your telemetry, your consumer confidence is lower. The exam tests that intel is not "fire and forget" from feed to firewall.

### The four intel quality dials together

CompTIA wants you to be able to name all four and explain how they interact:

- **Timeliness** — is it current enough to matter? IoCs decay; TTPs persist longer.
- **Relevancy** — does it apply to our stack, sector, geography?
- **Accuracy** — are the technical details correct as stated?
- **Confidence** — how much do we trust the source and the assessment?

All four must be acceptable for intel to drive automated action. Fail any one and the intel goes to a human first.

## SOC reality

- The **TIP** (Threat Intelligence Platform — MISP, Anomali, ThreatConnect) shows confidence as a numeric score or tag on every indicator. L1 analysts learn to read the score before they read the indicator. *Confidence < 60 + no internal hits = close the ticket as informational.*
- The CISO never asks "what's the confidence level?" The CISO asks **"are we exposed?"** Your job is to translate confidence into exposure language: *"High-confidence intel, but we don't run the affected product — no exposure"* or *"Medium-confidence intel, but we have three matching hits in DNS — high exposure regardless of source confidence."*
- The 3am page: a paid feed drops a Confirmed IoC for an active ransomware campaign. The right first action is **not** to block at the firewall — it's to **search your SIEM for historical hits** in the last 90 days. If you've already been touched, blocking now is closing the gate after the horse left. You need the IR call, not the firewall change.
- Never promise leadership a feed is "trusted." Promise that the **process** is trusted: confidence-graded, relevancy-filtered, correlated against telemetry before action. *Feeds are not trustworthy. Procedures are.*
- Handoff: L1 validates the confidence tag and runs the IoC against telemetry. L2 owns the hunt for low/medium confidence intel with internal hits. IR owns the response when confirmed intel has confirmed exposure. The intel team owns re-grading confidence as new corroboration arrives.

## Related concepts

[[Threat Intelligence]] · [[Open Source Intelligence]] · [[Closed Source Intelligence]] · [[STIX TAXII]] · [[Indicators of Compromise]] · [[Threat Hunting]] · [[CERT]] · [[CSIRT]] · [[ISAC]] · [[Honeypot]] · [[Government Bulletins]] · [[Tactics Techniques and Procedures]] · [[Information Sharing Organizations]] · [[Collection Methods and Sources]] · [[Intelligence Cycle]] · [[Diamond Model]] · [[MITRE ATT&CK]]

*Source: VIRGIL knowledge base — 2026-05-11*