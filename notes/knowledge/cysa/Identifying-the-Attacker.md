# Identifying the Attacker

## What it is

In **Valorant**, you're down 3-11 at half on Bind. Someone on your team is hardstuck on the Reyna who's been one-tapping your operator through smokes. *"Find out who that smurf is. Find their main account. Get them banned."* Meanwhile, the round is starting, your Sage is dead, and B site is being executed onto with no util left. The smurf isn't the problem right now. **Losing the next round is the problem right now.** Attribution is a luxury. Survival is the job.

That's exactly what identifying the attacker is in incident response — an expensive, slow, often-impossible side quest that competes with the actual mission, which is protecting the organization. Riot's anti-cheat team will eventually figure out the smurf. Your job is to win the half you're in.

In CS0-003 terms: **attacker attribution** is the process of identifying the threat actor responsible for an incident — by name, group, nation-state affiliation, or TTP cluster. It is rarely required for containment, eradication, or recovery. It is sometimes required for legal action, regulatory reporting, or strategic threat intelligence. It is **always** a management decision, not an analyst one.

## Why it matters

CompTIA tests this because junior analysts get attribution-brained. They watch too much *Mr. Robot*, they want to be the one who unmasks the APT, and they spend three hours pivoting on a Bitcoin wallet while the dwell time clock keeps running. The CySA+ exam wants you to know the priority order: **contain first, attribute later — if at all.**

Real-world stakes: a 2020 ransomware victim spent two weeks coordinating with FBI on attribution while their backup environment quietly got encrypted too. The attribution work was good. The recovery posture was a disaster.

Exam relevance: **Objective 3.2** — incident response activities, specifically the prioritization tension between law enforcement involvement and business recovery. Also touches **legal hold**, **chain of custody**, and **evidence preservation** because the moment you decide attribution matters, your forensic discipline has to hold up in court.

## Key facts

### The priority order — burn this in

| Priority | Activity | Why |
|---|---|---|
| 1 | **Containment** (isolation, network segmentation, account disable) | Stops the bleeding |
| 2 | **Eradication** (remove the foothold, kill C2, re-image) | Removes the adversary |
| 3 | **Recovery** (restore service, validate integrity) | Returns business to normal |
| 4 | **Post-incident** (lessons learned, root cause) | Prevents the next one |
| 5 | **Attribution** (who did this) | Only if it serves 1–4, or legal/regulatory drives it |

Attribution is **last by default**. It can move up if it directly informs containment scope ("this is APT29, we know their lateral movement TTPs, pull these specific logs") — but that's threat intelligence informing IR, not attribution being the goal.

### When attribution actually matters

- **Law enforcement referral** — you want subpoena power against an ISP, hosting provider, or cryptocurrency exchange. You can't subpoena anyone. The FBI / Secret Service / NCSC can.
- **Regulatory reporting** — some breach notification regimes ask "was this a nation-state actor?" because the answer changes the disclosure obligations and the safe-harbor posture.
- **Cyber insurance claims** — insurers increasingly exclude nation-state attacks under "act of war" clauses. Attribution becomes a multi-million-dollar question.
- **Strategic threat intel** — your org is in defense, energy, or finance; knowing which APT is targeting your sector shapes the next year of [[Threat Hunting]].
- **Civil litigation** — you're suing a competitor over IP theft and you need to prove the attack originated from them.

### What law enforcement gives you (and costs you)

| Gain | Cost |
|---|---|
| Subpoena power for ISPs, hosts, exchanges | Loss of control over timeline |
| Access to classified threat intel and government databases | Possible evidence seizure (your servers) |
| Cross-border coordination (FBI legal attachés, Interpol) | Public disclosure risk if charges filed |
| Potential prosecution / deterrence | Recovery delays — "don't touch that, it's evidence" |
| Insurance and PR posture ("we worked with FBI") | Conflict with [[Business Continuity Planning]] |

> **CompTIA exam trap:** The question will frame law enforcement involvement as an analyst's call. It is not. **Involving law enforcement is a management decision** — typically CISO, GC (general counsel), and CEO. The analyst's job is to preserve evidence such that *if* management calls the FBI, the chain of custody holds. If you see an answer that says "the L1 analyst contacts FBI," it's wrong every time.

### Evidence preservation when attribution might happen

The instant attribution becomes plausible, you're operating under **legal hold** — all potentially relevant data must be preserved, even if it would normally be deleted by retention policy. Touching evidence the wrong way burns it.

**Acquisition order — most volatile first (RFC 3227):**

1. CPU registers, cache
2. RAM (memory acquisition — FTK Imager, WinPmem, LiME)
3. Network state (netstat, ARP cache, routing tables, active connections)
4. Running processes
5. Disk (bit-for-bit image — `dd`, FTK, EnCase)
6. Remote logging and monitoring data
7. Physical configuration, network topology
8. Archival media

**Validating data integrity:** every acquired image gets hashed — SHA-256 minimum, MD5 + SHA-1 for legacy tool compatibility. The hash goes in the [[Chain of Custody]] form at acquisition. Every subsequent handler verifies the hash matches before doing anything. *A forensic image whose hash doesn't match the acquisition hash is not evidence — it's a story.*

**Chain of custody form must capture:**

- Who acquired it, when, where, with what tool
- Hash at acquisition
- Every transfer: from whom, to whom, when, why
- Storage conditions (locked, encrypted, access-controlled)
- Final disposition

One missing transfer entry and defense counsel turns the whole image into a Swiss cheese exhibit.

### Indicators that point toward attribution (but don't prove it)

**IoCs (Indicators of Compromise):** hashes, IPs, domains, mutex names, registry keys, user agents. Useful for clustering activity. **Not useful for attribution** — IPs get spoofed, hashes get recycled, infrastructure gets shared across actors.

**TTPs (Tactics, Techniques, Procedures):** how the actor operates — MITRE [[ATT&CK]] technique chains, dwell patterns, lateral movement preferences, tool customization. **Much better attribution signal** than IoCs. APT29 phishes differently than FIN7, who phishes differently than Lazarus.

**Tradecraft fingerprints:** custom malware compiler timestamps, language artifacts in code comments, time-of-day activity patterns matching a specific timezone, reuse of code from prior attributed campaigns.

> **CompTIA exam trap:** "An attacker's IP address was identified as originating from Country X. The incident handler concludes the attacker is a state-sponsored actor from Country X." This is **wrong reasoning**. IPs are trivially spoofed or proxied. Attribution by single-source IP is a rookie call. The right answer involves correlated TTPs, infrastructure overlap, and threat intel — never one indicator alone.

### The recovery vs. attribution conflict

Classic scenario: ransomware hits, you have clean backups, you can be operational in 18 hours. FBI shows up and says "don't re-image those servers yet, we want to image them for the investigation, give us 72 hours." Your CEO is screaming about the 72-hour outage cost. The lawyers are screaming about the breach disclosure clock.

Resolution path:

- **Image first, then re-image.** A forensic image of every affected host satisfies law enforcement *and* lets you re-image to recover. Costs storage, not time.
- **Compensating controls during the gap.** While law enforcement holds the original evidence, you run on isolated/rebuilt infrastructure with extra monitoring — additional EDR sensors, tighter egress filtering, MFA enforced on every account.
- **Parallel tracks.** Recovery team works on rebuild. IR/forensics team works on attribution evidence. They don't block each other if you have the headcount.

*The lesson the on-call lead learns once: never let "we're preserving evidence" become the reason production is down on day five. Image and move.*

### Scope and impact in the attribution decision

Before management decides whether to pursue attribution, they need the scope/impact brief:

- **Scope:** how many hosts, which business units, which data classifications
- **Impact:** financial loss estimate, regulatory exposure, reputation
- **Adversary sophistication:** opportunistic (script kiddie, commodity malware) vs targeted (APT TTPs, custom tooling)
- **Likelihood of successful attribution:** is there usable infrastructure to pivot on, or is it all Tor and bulletproof hosting?
- **Likelihood of successful prosecution:** is the actor in a country with US extradition? If not, what's the point?

A targeted APT attack on regulated data with attribution leads pointing to a domestic actor? Attribution makes sense. A commodity ransomware crew operating out of a non-cooperative jurisdiction? Attribution is theater. Spend the hours on hardening instead.

## SOC reality

- **The CISO does not ask "who did this" first.** The first three questions are always: *what's the scope, what's the impact, is it contained?* Attribution is question seven. If you lead with attribution, you've misread the room.
- **Junior analysts get attribution-brained on Twitter/X threat intel.** Someone tweets "this looks like APT-Whatever" and the analyst spends the shift chasing that theory instead of pulling the next round of EDR telemetry. Discipline is staying on the scope-and-containment job until management explicitly redirects.
- **Every IR engagement runs under legal hold from the moment you suspect attribution might matter.** This means no informal deletes, no quick "let me just restart this server," no Slack DMs about the incident. Counsel decides what's preserved and how.
- **Compensating controls cover the gap when evidence preservation blocks normal remediation.** If you can't wipe the box because FBI hasn't imaged it yet, you isolate it from the network, you stand up a replacement, you add monitoring around the quarantine VLAN. The control is temporary but documented.
- **Never promise leadership you'll identify the attacker.** Promise you'll preserve evidence such that *if* attribution is pursued, the case holds. Big difference. Attribution failure is common; failed evidence preservation is a fireable career event.

## Related concepts

[[Chain of Custody]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[Order of Volatility]] · [[Containment Eradication Recovery]] · [[Compensating Controls]] · [[Threat Actor Types]] · [[ATT&CK]] · [[Indicators of Compromise]] · [[Threat Intelligence]] · [[Business Continuity Planning]] · [[Post-incident Activities]] · [[Re-imaging]] · [[Scope and Impact]]

*Source: VIRGIL knowledge base — 2026-05-11*