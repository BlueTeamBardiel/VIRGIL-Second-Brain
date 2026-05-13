# UEBA — User and Entity Behavior Analytics

## What it is

In **Madden**, the defensive coordinator's pre-snap read is the whole job. The free safety has watched twelve quarters of film on this offense. He knows the QB's cadence, the slot receiver's split distance on third-and-medium, the running back's hand placement when he's about to pass block versus when he's the primary read. When the offense breaks the huddle and the slot lines up two yards wider than usual on a 3rd-and-3, the safety doesn't need a coach to yell — *the formation itself is the tell*. He rotates coverage. The slot was running a deep post the whole time. Pick six.

That's exactly what UEBA does — it watches every user and machine long enough to know their snap count, then screams when somebody lines up wrong.

**User and Entity Behavior Analytics** is the SIEM-adjacent analytics layer that baselines normal behavior for every user account and every entity (servers, service accounts, IoT devices, applications) on the network, then statistically flags deviations. It uses machine learning, rule engines, and peer-group analysis to score risk — not on signatures, but on *how far* an action sits from the actor's own history and the history of similar actors. The "E" — entity — is the part Sec+ candidates miss. UEBA isn't just watching Karen in accounting. It's watching the svc_backup service account, the domain controller, the printer that suddenly wants to talk to port 445 on a workstation it has never met.

## Why it matters

Signature-based detection — AV, basic IDS, static SIEM rules — catches known bad. UEBA catches **insider threat, credential compromise, and living-off-the-land attacks** where the binary is legitimate (powershell.exe, wmic.exe, psexec) and the only anomaly is *who's running it, when, and against what*. Half the breach-disclosure stories you read end with "the attacker used valid credentials for 90 days." UEBA is the control that shortens that dwell time.

**Exam relevance — CS0-003 Objective 1.2.** UEBA is the lens through which most of the indicators in 1.2 actually get noticed at scale. Off-hours logins, [[impossible travel]], unauthorized privilege escalation, [[introduction of new accounts]], anomalous data movement, [[beaconing]] from an entity that has no business beaconing — these don't show up in a static rule. They show up as a risk score climbing on a UEBA dashboard.

Career relevance: UEBA tuning is L2 SOC work. L1 gets the alert; L2 decides whether the risk score is real or whether Karen took a legitimate vacation to Lisbon. If you can articulate what a baseline is, what z-score deviation means in this context, and why peer-group analysis matters, you're already past most candidates.

## Key facts

### What UEBA baselines

UEBA isn't one signal — it's a portfolio of behavioral dimensions, each baselined per user and per entity:

| Dimension | What "normal" looks like | What anomaly looks like |
|---|---|---|
| **Login time** | Karen logs in 0800–1730 weekdays | Karen logs in at 0314 Saturday |
| **Login geography** | Karen logs in from Dallas | Karen logs in from Dallas at 0800 and Bucharest at 0815 — [[impossible travel]] |
| **Authentication volume** | Karen authenticates ~40 times/day | 1,400 auths in an hour — credential spray or Kerberoasting |
| **Resource access** | Karen touches the AP fileshare | Karen suddenly enumerates the entire AD via LDAP |
| **Privilege use** | Karen never runs `runas` | Karen invokes admin tooling she's never touched |
| **Data movement** | Karen emails ~5MB/day | Karen uploads 4GB to a personal cloud — [[data exfiltration]] |
| **Process behavior** | Workstation runs Outlook, Chrome, Teams | Workstation spawns `powershell.exe -EncodedCommand` from `winword.exe` |
| **Network peers** | Workstation talks to file server, mail, DNS | Workstation suddenly initiates SMB to 40 other workstations — lateral movement |
| **Process resource use** | Process X uses 2% CPU steady-state | Process X pegs CPU at 98% — possible cryptominer, [[processor consumption]] |

### The math underneath (briefly, because CompTIA loves the vocab)

- **Baselining** — collect 30–90 days of activity, build a statistical profile per actor.
- **Peer-group analysis** — Karen in AP gets compared to other AP clerks, not to the DBAs. Anomaly is relative to your job.
- **Risk scoring** — each anomalous event adds points; the score decays over time if nothing else fires. Alert fires when score crosses threshold.
- **Z-score / standard deviation** — how many sigma from the mean. 3σ = roughly 1-in-370 unusual. That's the rough trigger threshold for "this deserves a look."
- **Stateful sequence analysis** — chains anomalies. One off-hours login is noise. Off-hours login + new privilege + outbound to a never-seen IP is a kill chain in progress.

### Indicators UEBA catches (mapped to CS0-003 1.2)

**User-related:**
- [[Off-hours login]] and **unusual geographic source**
- [[Impossible travel]] — two logins from locations farther apart than physics allows
- [[Introduction of new accounts]] — Karen suddenly being able to create domain users
- [[Unauthorized privileges]] — service account that gets added to Domain Admins at 0300
- [[Social engineering]] aftermath — phishing victim's account suddenly doing things the victim never does

**Host/entity-related:**
- [[Abnormal OS process behavior]] — Office app spawns a shell
- [[Unauthorized scheduled tasks]] — new task on a workstation running a base64 blob
- [[Registry changes]] in autorun keys on a host that hasn't had software installed in 6 months
- [[File system changes]] — mass file modification (ransomware encrypting), or a sudden write spike on an entity that's normally read-only
- [[Memory consumption]] / [[processor consumption]] / [[drive capacity consumption]] anomalies — a quiet entity that's suddenly loud

**Network-related:**
- [[Beaconing]] — entity making regular, low-volume callouts to a never-before-seen external IP
- [[Unexpected outbound]] traffic and [[unusual traffic spikes]]
- [[Activity on unexpected ports]] — workstation suddenly speaking on 4444 or 8443 outbound
- [[Bandwidth consumption]] spikes on an entity that historically barely talks
- [[Irregular peer-to-peer]] — workstation-to-workstation SMB that normally goes through the file server
- [[Scans and sweeps]] originating from a non-IT host
- [[Rogue devices]] — a new MAC/hostname pattern that doesn't match any baselined entity

**Application-related:**
- [[Application logs]] showing access patterns inconsistent with the user's role
- [[Unauthorized changes]] to config or content by an account that's never edited that resource
- [[Unexpected output]] from an application — a billing app suddenly emitting outbound HTTP to a paste site

### UEBA vs related controls

| Control | What it watches | Detection style |
|---|---|---|
| **[[SIEM]]** | All logs | Correlation rules — mostly signature/heuristic |
| **UEBA** | Behavior of users and entities | Statistical anomaly, peer comparison |
| **[[EDR]]** | Endpoint process trees | Behavioral + signature, host-level |
| **[[DLP]]** | Data movement | Content inspection + policy |
| **[[NDR]]** | Network flows | Behavioral anomaly on traffic |

UEBA is often a module inside a modern SIEM (Splunk UBA, Sentinel UEBA, Exabeam, Securonix) rather than a standalone product. On the exam, treat it as an analytics capability — *the layer that converts raw logs into risk scores per actor*.

### CompTIA exam traps

> **CompTIA exam trap:** UEBA is not the same as IDS. IDS looks for known-bad signatures in traffic. UEBA looks for unknown-bad based on deviation from learned normal. If the question mentions "baseline," "anomaly," "behavioral," or "insider threat" — UEBA is in play.

> **CompTIA exam trap:** The "E" matters. If the answer choices include "User Behavior Analytics" and "User and Entity Behavior Analytics," pick the one with **Entity**. CompTIA writes UEBA, not UBA. The entity coverage (service accounts, servers, IoT) is the whole reason UEBA is on the objective.

> **CompTIA exam trap:** [[Impossible travel]] is the textbook UEBA indicator and shows up constantly. Two logins, separated by less time than physics permits between the source geolocations. The answer is impossible travel, not "VPN misconfiguration" or "compromised credential" — although the *cause* is usually credential theft, the *indicator name* is impossible travel.

> **CompTIA exam trap:** UEBA generates **risk scores**, not deterministic alerts. A high score is a lead, not a verdict. Questions that say "the UEBA platform confirmed the breach" are wrong on their face — UEBA flags, analysts confirm.

### Tuning realities

- **Cold start problem** — UEBA needs 30–90 days of baseline data. Day one is mostly noise.
- **Concept drift** — Karen gets promoted, her baseline is now wrong. The model needs retraining cadence.
- **Peer-group misalignment** — if HR's job-title field is stale, peer comparison is garbage. UEBA is only as good as identity hygiene.
- **Service accounts** — the highest-risk entity class because their "normal" is the most rigid. A service account that deviates is almost always either a misconfig push or a compromise. Tune these tightest.

*I learned this the hard way: the first UEBA deployment I touched flagged the CFO every Monday at 0600 for three months. Turns out she actually does work at 0600 on Mondays. The model didn't know that until we let it learn. Don't escalate UEBA alerts in the first 60 days of deployment unless you enjoy being wrong in front of executives.*

## SOC reality

- The 3am alert: "Risk score 92 on svc_sql_backup — anomalous LDAP enumeration, off-baseline destination, new parent process." That's not a signature hit. That's UEBA stitching three weak signals into one strong one.
- L1 acknowledges, checks whether the entity is in a known maintenance window (UEBA platforms have a "context" panel — read it before escalating), and pivots to [[EDR]] for the process tree. If the parent process is `cmd.exe` spawned by a web app, that's escalation territory.
- L2 owns the tuning. Every confirmed false positive becomes a model adjustment or a peer-group correction. Every confirmed true positive becomes a kill-chain reconstruction in the [[SIEM]].
- IR lead asks: "What's the actor, what's the entity, what's the blast radius, what's the score trajectory over the last 24h?" Score trajectory matters — a score that climbs slowly over days is APT-shaped; a score that spikes in minutes is ransomware-shaped.
- Never promise leadership that UEBA "would have caught" a past breach. Hindsight is signature-perfect; the model didn't have the context. The honest answer is "UEBA *increases the probability* we catch the next one earlier."
- The handoff: L1 triages, L2 investigates and confirms, IR contains and reports. UEBA is a lead generator, not a verdict engine.

## Related concepts

[[SIEM]] · [[EDR]] · [[NDR]] · [[DLP]] · [[Impossible travel]] · [[Insider threat]] · [[Beaconing]] · [[Data exfiltration]] · [[Lateral movement]] · [[Kerberoasting]] · [[Living off the land]] · [[MITRE ATT&CK]] · [[IoC]] · [[IoA]] · [[Anomalous activity]] · [[Off-hours login]] · [[Introduction of new accounts]] · [[Unauthorized privileges]]

*Source: VIRGIL knowledge base — 2026-05-11*