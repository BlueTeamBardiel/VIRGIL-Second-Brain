# IDS — Intrusion Detection System

## What it is

In **Counter-Strike**, the bomb plant on A-site triggers a distinct audio cue — that low ticking beep every CT in the server can hear. You didn't see the planter. You didn't catch them on the way in. But the moment that beep starts, every defender on the team knows: *someone got through, the payload is live, and the clock is running.* You can't defuse from spawn. You have to rotate, contact the threat, and decide whether to retake or save for next round.

That's exactly what an IDS does — it tells you something hostile is already inside, without doing anything to stop it.

An **Intrusion Detection System (IDS)** is a passive monitoring control that inspects network traffic, host activity, or both, and generates alerts when it sees patterns matching known attacks or anomalous behavior. Key word: **passive**. An IDS detects and alerts. It does not block. The defender (you, the analyst) has to act on the alert. Its active cousin is the [[IPS]] — Intrusion Prevention System — which sits inline and drops traffic.

## Why it matters

Every enterprise network runs some flavor of IDS or IPS, and on the CySA+ exam (Objective 1.1) you need to know where it sits, what it sees, how it makes decisions, and where its blind spots are. In the SOC, IDS alerts are a primary feed into the [[SIEM]] and a primary driver of the L1 triage queue. Mis-tune the IDS and you either drown the team in false positives or miss the actual breach.

The IDS-vs-IPS distinction is also a classic interview question and a frequent exam trap. Get the placement, the detection method, and the limitations right and you've covered most of what CompTIA wants from this objective.

## Key facts

### IDS vs IPS — the placement question

| Property | IDS | IPS |
|---|---|---|
| Posture | Passive — observes | Active — intercepts |
| Placement | Out-of-band (SPAN port, network TAP) | Inline (traffic flows through it) |
| Action on detection | Alert only | Alert + block/drop/reset |
| Failure mode | Fail open — traffic keeps flowing if it dies | Fail open or fail closed — depends on config |
| Latency impact | None | Adds inline latency |
| Risk of bad rule | Noise in the SIEM | Outage in production |

An IDS sits **out-of-band**, fed by a switch SPAN/mirror port or a hardware [[Network TAP]]. It sees a copy of the traffic. An IPS sits **inline** and traffic physically flows through it — which means a bad signature can drop production. That's why a lot of mature shops run IPS in "IDS mode" (detect-only) during tuning, then flip individual signatures to block once they've proven clean.

### IDS types by what they monitor

- **NIDS — Network Intrusion Detection System.** Watches network traffic. Sensors placed at chokepoints — perimeter, DMZ boundary, between [[Network segmentation|segmented]] zones, in front of the crown-jewel VLAN. Sees packets and flows. Blind to encrypted payloads unless paired with [[SSL]]/TLS decryption or operating on metadata.
- **HIDS — Host Intrusion Detection System.** Agent on the endpoint. Watches process trees, file integrity, [[Windows Registry]] changes, authentication events, [[System processes]]. Sees what NIDS can't — what happens *after* the encrypted payload lands. Modern [[EDR]] is HIDS on steroids.
- **WIDS — Wireless IDS.** Watches the RF spectrum for rogue APs, deauth floods, evil twins.
- **Hybrid.** Most real deployments. NIDS at the perimeter, HIDS/EDR on every endpoint, all firing into the same [[SIEM]].

### Detection methods

- **Signature-based.** Pattern-matches traffic or behavior against a database of known-bad. Snort rules, Suricata rules, YARA for files. Fast, low false-positive rate, *zero* coverage of anything novel. Same model as VAC — known cheat signatures get caught, the new private cheat walks past.
- **Anomaly-based.** Builds a baseline of "normal" and alerts on deviation. Catches novel attacks in theory. Generates noise in practice — every new printer, every legit admin script, every quarter-end report run looks anomalous until you train it. Tuning is forever.
- **Behavior-based / heuristic.** Looks at sequences and patterns rather than fixed signatures. PowerShell launching from a Word macro making outbound HTTPS to a freshly-registered domain at 3am — no single piece is a signature, the *combination* is the alert. This is where modern [[EDR]] and [[UEBA]] live.
- **Stateful protocol analysis.** Knows what each protocol is *supposed* to look like and flags deviations. Useful for catching protocol abuse like [[DNS tunneling]] or HTTP smuggling.

### Where the sensors go

The IDS is only as good as its visibility. Placement matters more than the engine:

- **Perimeter** — between the internet edge and the [[DMZ]]. Catches inbound scans, exploit attempts, C2 callbacks.
- **DMZ-to-internal boundary** — anything pivoting from a public-facing server into the trust zone. This is where APT lateral movement first becomes visible.
- **Between segmented zones** — the whole point of [[Network segmentation]] is that east-west traffic between zones is inspectable. PCI [[CHD]] zone, OT/[[ICS]] zone, dev vs prod — IDS on the boundary.
- **In front of critical assets** — DCs, [[PAM]] vaults, code-signing servers, [[PKI]] roots. Crown jewels get their own sensor.
- **Cloud** — [[VPC]] flow logs, AWS Traffic Mirroring, Azure NSG flow logs feed cloud-native IDS like GuardDuty. The principle is the same; the plumbing is different.

In a [[Zero trust]] or [[SASE]] architecture, the IDS function gets distributed — every PEP (policy enforcement point) does inspection, and inspection telemetry flows into a central decision plane. The sensor isn't one box at the edge anymore; it's the whole fabric.

### What feeds the IDS, and what the IDS feeds

The IDS doesn't live alone. It's one organ in the immune system:

- **Inputs:** raw packets (SPAN/TAP), [[NetFlow]]/IPFIX metadata, host logs (HIDS), threat intel feeds ([[STIX/TAXII]]), [[SDN]] inspection mirrors.
- **Outputs:** alerts into [[SIEM]] for correlation, IoCs into [[SOAR]] for automated triage, blocks into firewalls/[[NAC]] if you've wired up automation.
- **Adjacent controls:** [[DLP]] for [[PII]]/[[CHD]] egress detection, [[CASB]] for SaaS-layer visibility, [[NDR]] for ML-driven flow analysis. None of these replace the IDS; they extend its eyeballs into traffic it can't natively see.

### Encrypted traffic — the blind spot

The honest truth: most modern traffic is TLS-encrypted, and a NIDS that can't decrypt sees only metadata — IPs, ports, SNI, certificate fingerprints, JA3/JA4 hashes, packet sizes and timing. That's not nothing. JA3 fingerprinting of malware C2, beaconing detection by inter-packet timing, and SNI mismatch all work without decryption. But signature-matching on payloads requires either TLS interception (a proxy with [[PKI]]-issued certs the endpoints trust) or moving detection to the host with [[EDR]].

This is why HIDS/EDR matter more every year. The packet on the wire is opaque. The decrypted buffer in memory on the endpoint is not.

### CompTIA exam traps

> **CompTIA exam trap:** IDS is **passive**, IPS is **active**. The exam will describe a system that "detected and dropped" malicious traffic and ask what it is. If it dropped, it's an IPS. If it only alerted, it's an IDS. Don't get cute.

> **CompTIA exam trap:** **Signature-based** catches known threats with low false positives. **Anomaly-based** catches unknown threats with high false positives. CompTIA loves to swap these. Signature ≠ zero-day coverage. Anomaly ≠ low noise.

> **CompTIA exam trap:** A NIDS placed **inside** the firewall sees less internet noise but catches what got through — and that's what matters. A NIDS placed **outside** the firewall sees everything the firewall already blocked. CompTIA will ask which placement gives you better signal. The answer is usually inside.

> **CompTIA exam trap:** **HIDS** sees what happens on the host — file changes, registry edits, process trees. **NIDS** sees what happens on the wire. If the question mentions [[Windows Registry]] modification or file integrity monitoring, it's HIDS, not NIDS.

> **CompTIA exam trap:** [[Time synchronization]] (NTP) matters for IDS because correlated alerts across multiple sensors are worthless if the timestamps drift. CompTIA may bury this in a scenario about why incident timeline reconstruction failed.

## SOC reality

- At 3am the IDS alert looks like a single line in the SIEM queue: `ET MALWARE Cobalt Strike Beacon HTTP Request` with a source IP, dest IP, and a rule ID. L1's first action is to pivot — pull the host name from DHCP/[[DNS]] logs, check the [[EDR]] timeline on that endpoint, look for sibling alerts within ±5 minutes. Single alert, no corroboration, low confidence — it might be a sig fire on benign traffic. Three correlated alerts from NIDS + HIDS + DNS — now you're escalating.
- The CISO does not ask "did the IDS fire?" The CISO asks "what's the scope, what's contained, and what's the evidence?" The IDS alert is the bomb-plant beep. The answer to the CISO is the retake plan.
- Never promise the IDS caught everything. *I learned this the hard way watching a six-month dwell time investigation: the attacker used a TLS-encrypted C2 channel with a domain front, and the NIDS saw exactly nothing for 180 days. HIDS would have caught the initial PowerShell. We didn't have it deployed on that segment.*
- Tuning is the job. A fresh-out-of-the-box Snort/Suricata deployment will generate tens of thousands of alerts per day, 99% of them noise. The work is suppressing the noise without suppressing the signal — and writing that delta into runbooks so the next analyst doesn't re-tune from scratch.
- Handoff: L1 triages and closes the noise, L2 investigates the survivors, IR team owns anything that becomes a confirmed incident. The IDS never owns the decision — the analyst does.

## Related concepts

[[IPS]] · [[SIEM]] · [[EDR]] · [[NDR]] · [[Network TAP]] · [[Network segmentation]] · [[DMZ]] · [[Zero trust]] · [[SASE]] · [[CASB]] · [[DLP]] · [[Firewall]] · [[NetFlow]] · [[STIX/TAXII]] · [[SOAR]] · [[UEBA]] · [[SSL]] · [[PKI]] · [[Time synchronization]] · [[Windows Registry]] · [[System processes]] · [[DNS tunneling]] · [[Snort rules]]

*Source: VIRGIL knowledge base — 2026-05-11*