# IPS — Intrusion Prevention System

## What it is

In **World of Warcraft**, a paladin tank running **Hand of Protection** doesn't just notice the rogue ambush — it shuts the damage off mid-swing. Compare that to a healer screaming "incoming!" while the warlock eats a backstab. One detects. The other prevents. That's the IDS-vs-IPS difference, and CompTIA will ask it three different ways.

An **Intrusion Prevention System (IPS)** sits **inline** on the network path. Every packet has to pass through it to reach its destination. When it matches a signature, anomaly, or behavior rule for malicious traffic, it doesn't just log — it **drops, resets, or quarantines** the connection before the payload lands. An IDS is passive (tap or SPAN port, sees a copy, alerts after the fact). An IPS is active (inline, sees the original, makes a real-time block decision).

The trade: an IDS that misclassifies costs you a noisy alert. An IPS that misclassifies costs you a dropped legitimate connection — and the user calling the helpdesk asking why payroll won't load.

## Why it matters

CompTIA CS0-003 Objective 1.1 puts IPS in the [[Network architecture]] bucket alongside firewalls, [[Network segmentation]], and inspection points. The exam wants you to know **where** an IPS sits, **what** it inspects, and **how** it differs from peers in the security stack ([[IDS]], [[NGFW]], [[WAF]]). Real-world stakes: a tuned IPS stops commodity exploits at the perimeter so your [[SOC]] analysts aren't drowning in noise from automated scanners. A badly tuned IPS becomes its own outage — false positives blocking the CEO's video call gets the device flipped to detect-only by Monday.

The deeper career relevance: SOC L1s spend their first six months learning **which IPS alerts mean something** and which are background radiation. That tuning judgment is the job.

## Key facts

### IPS vs IDS — the inline distinction

| Property | IDS | IPS |
|---|---|---|
| Placement | Out-of-band (SPAN/TAP) | Inline |
| Traffic seen | Copy | Original |
| Action | Alert only | Alert + block/drop/reset |
| Failure mode | Misses an attack | Drops good traffic |
| Latency impact | Zero | Non-zero (every packet inspected) |
| Tuning pressure | Reduce false negatives | Reduce false positives |

The mental model: **IDS is the security camera. IPS is the security guard.** A camera that misses something is bad. A guard who tackles the wrong person is a lawsuit.

### Detection methods

- **Signature-based** — known bad patterns (hashes, byte sequences, regex on packet payload). Fast, accurate on known threats, useless against zero-days. Same idea as antivirus signatures.
- **Anomaly-based** — baseline normal traffic, alert on deviation. Catches novel attacks. Generates false positives every time marketing launches a new campaign and traffic patterns shift.
- **Behavior-based / heuristic** — pattern of activity (e.g., a host suddenly beaconing every 60 seconds to a never-before-seen domain). Closer to how [[EDR]] thinks about endpoints.
- **Reputation-based** — block known-bad IPs, domains, URLs from [[Threat intelligence]] feeds. Cheap, effective, must be kept current.

Modern IPS appliances (Palo Alto, Cisco Firepower, Fortinet, Snort/Suricata-based open source) blend all four.

### Placement in network architecture

```
Internet → [Edge firewall] → [IPS] → [DMZ] → [Internal firewall] → [LAN]
                                ↑
                           inspects N-S traffic
```

- **North-south IPS** — perimeter, inspects internet ↔ internal. Classic placement.
- **East-west IPS** — between internal segments ([[Zero trust]] influence). Catches [[Lateral movement]] after an initial breach. Increasingly common in [[Network segmentation]] designs.
- **Host-based IPS (HIPS)** — agent on the endpoint inspecting local traffic. Often bundled into [[EDR]] now.
- **Wireless IPS (WIPS)** — detects rogue APs, evil twins, deauth attacks on the WLAN.

In [[Software-defined networking]] (SDN) and [[SASE]] architectures, IPS becomes a **service chain** function — traffic gets steered through a virtual IPS instance in the cloud rather than a physical box in a data closet. Same logic, different deployment model.

### Response actions

When an IPS triggers, it can:

1. **Drop** the packet silently
2. **Reset** the TCP connection (send RST to both endpoints)
3. **Quarantine** the source IP (add a temporary block rule)
4. **Shun** — push a rule to upstream firewalls to block the source for a duration
5. **Alert only** (detect-only mode — effectively running as an IDS)

Detect-only mode is where most IPS deployments start. You watch it for two to four weeks, tune out the false positives, then flip rules to **block** one category at a time. Never flip the whole device to block on day one. That's how you take down production.

### Encrypted traffic — the inspection problem

If 90%+ of your traffic is [[TLS]]/[[SSL]] encrypted (it is), an IPS without decryption sees only metadata: source, destination, SNI, certificate, byte counts, timing. Useful, but not payload-level.

Options:

- **SSL/TLS inspection (a.k.a. break-and-inspect)** — IPS holds a trusted internal CA, terminates TLS on its side, inspects plaintext, re-encrypts to destination. Requires endpoints to trust the internal CA via [[PKI]] distribution (usually pushed by GPO).
- **Bypass lists** — never decrypt healthcare, banking, or HR portals (legal/privacy reasons). [[Sensitive data protection]] and [[PII]] handling means you don't get to see everything.
- **Encrypted traffic analysis (ETA)** — ML on metadata patterns. Doesn't need decryption. Detects beaconing, C2, data exfil patterns without breaking encryption.

The CompTIA framing: TLS inspection is a **privacy + performance + trust** trade. You're MITM-ing your own users. Document it in policy or auditors will eat you.

### Tuning — the actual job

A factory-default IPS will alert on tens of thousands of events per day. Most are noise:

- Internal vuln scanners (your own [[Vulnerability scanning]] tools)
- Legitimate apps with sloppy traffic patterns
- Misconfigured devices doing weird-but-benign things
- Outdated signatures matching modern legitimate traffic

The tuning loop:

1. Pull last 7 days of alerts from [[SIEM]] (the IPS ships logs there via syslog)
2. Group by signature ID, source, destination
3. Top 20 noisy signatures → review → suppress, refine, or kill
4. Repeat weekly

Good IPS deployments alert on **hundreds, not thousands** per day after tuning. The signal-to-noise ratio is the deliverable.

### Logging and time sync

IPS logs go to [[SIEM]] via syslog (UDP 514 / TCP 6514 for syslog-TLS). For correlation to work, the IPS clock must match every other log source — [[NTP]] (UDP 123) sync against authoritative internal stratum-1 sources. **Time synchronization** is on Obj 1.1 for a reason: if your IPS says 14:03:22 and your firewall says 14:02:51 and your endpoint says 14:04:01, reconstructing a kill-chain timeline in IR becomes a guessing game.

Logging levels matter too — most IPS appliances run **informational** for tuning, drop to **warning/critical** for production noise control. Logging everything to SIEM at debug level will burn your license fees and bury real signals.

### CompTIA exam traps

> **CompTIA exam trap:** IDS vs IPS placement. The question describes a device on a **SPAN port** or **network tap** receiving a **copy** of traffic. That's an IDS, no matter what the vendor marketing says. An IPS must be **inline**. If it can't drop the original packet, it's not preventing anything.

> **CompTIA exam trap:** IPS vs NGFW vs WAF. A [[NGFW]] does L3–L7 filtering with IPS *features* built in. A [[WAF]] inspects HTTP/HTTPS application-layer traffic specifically (SQLi, XSS, [[OWASP Top 10]]). An IPS is generally network-layer signature/anomaly inspection. CompTIA will give you a scenario about blocking **SQL injection at the web tier** — that's a WAF, not an IPS, even though IPS *can* have some web signatures.

> **CompTIA exam trap:** "The IPS blocked the attack." Be skeptical. An IPS alert that fired in **detect-only mode did not block anything** — it logged. Read the question carefully for the device's operating mode. The trap is conflating "alert" with "prevention."

> **CompTIA exam trap:** HIPS vs NIPS. Host-based IPS runs on the endpoint and sees local traffic + process behavior. Network-based IPS sits on the wire. CompTIA likes scenario questions where the right answer is HIPS because the traffic in question never crosses a network segment with an inline NIPS (e.g., loopback or same-VLAN host-to-host).

### IPS in modern architectures

- **[[Cloud]] / [[Hybrid]]** — cloud-native IPS as a service (AWS Network Firewall, Azure Firewall Premium IDPS, GCP Cloud IDS). Same logic, autoscaling, paid by the GB inspected.
- **[[Zero trust]]** — east-west IPS becomes mandatory because the perimeter assumption is dead. Every microsegment gets inspected.
- **[[Containerization]] / [[Serverless]]** — traffic between pods or function invocations may never hit a traditional IPS. Service mesh sidecars (Istio, Linkerd) handle L7 policy enforcement instead.
- **[[SASE]] / [[CASB]]** — IPS function gets folded into the SASE edge for remote users. The user's traffic hits a cloud PoP that runs IPS, [[DLP]], [[CASB]], and [[SWG]] in one pass.

## SOC reality

- **The 3am alert:** "IPS: Suricata ET TROJAN — Cobalt Strike beacon pattern from 10.42.18.7 to 185.x.x.x." Your first move is to confirm it actually **blocked** — check the action field. If it says `alert`, the host is still talking to the C2. If it says `drop`, the connection died but the implant is still on the box and will try again. Both are incidents. The drop just buys you time.
- **The CISO question:** "Did the IPS stop it?" The honest answer is almost always *"It stopped this attempt. The host is still compromised until [[EDR]] confirms eradication."* IPS is a network control. It doesn't clean endpoints.
- **The L1 first action:** Acknowledge the ticket, pivot to [[SIEM]] to correlate with endpoint, firewall, and DNS logs. Build the timeline. Don't trust a single IPS event in isolation — they fire on patterns, and patterns lie sometimes.
- **What never to promise:** "The IPS will catch it." Signature-based detection has zero coverage on a zero-day. Anomaly engines miss slow-and-low. *An IPS is a speed bump, not a wall — the attacker who tuned their tradecraft against your exact IPS vendor sails right through.*
- **The handoff:** L1 triages → L2 validates and pivots to host investigation → IR team owns containment if a host is confirmed compromised. The IPS event is the starting gun, not the finish line.

## Related concepts

[[IDS]] · [[NGFW]] · [[WAF]] · [[SIEM]] · [[EDR]] · [[Network segmentation]] · [[Zero trust]] · [[SASE]] · [[CASB]] · [[Threat intelligence]] · [[Lateral movement]] · [[TLS inspection]] · [[PKI]] · [[NTP]] · [[Vulnerability scanning]] · [[OWASP Top 10]] · [[DLP]]

*Source: VIRGIL knowledge base — 2026-05-11*