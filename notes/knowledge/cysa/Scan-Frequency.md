# Scan Frequency

## What it is

In **Forza Horizon 5**, you don't tune every car the same way. The drift-spec Hoonigan RX-7 you race weekly on the Festival circuit gets fresh tire-pressure and camber checks before every event. Your B-class daily driver — the one you take through the Baja for fun — gets looked at when something feels off. The S2-class hypercar you only pull out for the seasonal Eliminator? You go through the whole tune sheet from scratch because the stakes are higher and you haven't touched it in weeks. Same garage, same telemetry, completely different service intervals based on *what the car does and what happens if it fails mid-race.*

That's exactly what scan frequency does — it's the cadence at which you run [[Vulnerability Scanning]] against an asset, and that cadence is driven by risk, exposure, and consequence, not by a flat "once a month" rule on a calendar.

**Technical definition (CS0-003):** Scan frequency is the scheduled interval at which vulnerability scans, asset discovery, and configuration assessments are executed against defined scopes. Frequency is set by a combination of asset criticality, threat exposure, [[Regulatory Requirements]], rate of environmental change, and operational tolerance for scan-induced load. There is no single correct cadence — there is only a *defensible* cadence.

## Why it matters

Scan frequency is where vulnerability management meets reality. Scan too rarely and you're flying blind between snapshots — a CVSS 9.8 published Tuesday goes undetected on your DMZ web server until your monthly scan on the 28th. Scan too aggressively and you knock over the legacy ERP, melt the SCADA HMI, or push the SIEM into 90% disk on a Thursday night. The CISO wants daily coverage. The change board wants no scans during business hours. The compliance officer wants quarterly proof for PCI. Your job is to make all three happy without burning the network down.

**Exam relevance:** CompTIA Objective **CS0-003 2.1** lists "scheduling" explicitly under scanning methods and concepts. CompTIA will test whether you know that frequency is driven by risk and compliance, not arbitrary — and whether you can name the specific regulatory cadences (PCI DSS quarterly external + after significant change). They love this one because it sits at the intersection of [[Asset Criticality]], [[Compliance]], and [[Change Management]].

## Key facts

### Risk-based cadence (the default model)

| Asset profile | Typical cadence | Why |
|---|---|---|
| Internet-facing, high-value (web apps, VPN concentrators, edge firewalls) | **Daily or continuous** | First targets in any external recon; CVEs weaponized within hours |
| Core infrastructure (domain controllers, file servers, internal databases) | **Weekly** | High blast radius if compromised, but lower direct exposure |
| User endpoints (workstations, laptops) | **Weekly** (agent-based) | Drift fast, install software constantly, but EDR carries most weight |
| Low-risk internal (printers, kiosks, segmented IoT) | **Monthly** | Compensating controls reduce urgency; scan noise rarely justified |
| Cloud-native / ephemeral (containers, serverless, autoscaling groups) | **Continuous / per-deploy** | Workloads live for minutes; scheduled scans miss them entirely |
| Legacy / fragile (older OT, embedded medical, line-of-business apps that crash on a [[Nmap]] SYN scan) | **Quarterly + passive monitoring** | Active scan risk > vulnerability discovery benefit |

*Asset criticality is the input. Cadence is the output. Anyone who sets cadence first and asset-maps later is doing it backward.*

### Compliance-driven cadence

Some scans aren't optional and the regulator picks the cadence for you:

- **[[PCI DSS]] 4.0** — Internal and external vulnerability scans **at least every three months** AND after any "significant change" (new system, network topology change, firewall rule modification, application upgrade). External scans must be performed by an [[ASV]] (Approved Scanning Vendor). All high-risk vulnerabilities must be resolved and re-scanned to confirm.
- **[[HIPAA]]** — No fixed cadence specified; "regular" assessment of risk is required. In practice: quarterly minimum, monthly for systems handling [[PHI]].
- **[[FedRAMP]] / [[NIST SP 800-53]]** — Monthly OS, web app, and database scans for moderate/high baselines. Authenticated scans required.
- **[[CIS Benchmarks]] alignment** — Often paired with monthly configuration drift scans.
- **[[ISO 27001]]** — Risk-based; auditors expect a documented schedule tied to your risk register.
- **[[SOX]]** — Indirect; financial reporting controls drive cadence on systems in scope.

> **CompTIA exam trap:** PCI DSS does not say "quarterly is enough." It says quarterly **and** after significant change. The exam will give you a scenario where someone deployed a new payment gateway last week and skipped the scan because "we did one in January." That's a finding. The right answer is *scan now, then resume quarterly.*

### Continuous scanning vs. scheduled scanning

**Scheduled scanning** is the cron-job model: scan window opens Saturday 2am, scanner authenticates, walks the asset list, writes results to the dashboard by Monday morning. Predictable, throttleable, easy to fit into change windows.

**Continuous scanning** is the [[Agent-Based Scanning]] / cloud-native model: every host runs a lightweight agent that reports configuration, installed software, and CVE matches in near-real-time. Scope updates automatically as assets spin up and tear down. No scan window — telemetry is always-on.

| Property | Scheduled (network-based) | Continuous (agent-based) |
|---|---|---|
| Coverage of ephemeral assets | Poor — misses anything that lived less than the interval | Excellent — agent reports on boot |
| Authentication depth | [[Credentialed Scan]] possible but fragile (creds expire) | Native — agent runs locally with system context |
| Network load | Spiky during scan windows | Low and continuous |
| Detection of off-network laptops | Zero | Full (when host phones home) |
| Operational risk to fragile assets | High — active probing | Low — no network probes |
| Cost | Lower licensing | Higher licensing, agent management overhead |

*In a modern environment you run both. The agent fleet handles continuous endpoint visibility; the network scanner sweeps the unagentable — printers, OT, network gear, third-party appliances — on a schedule.*

### Special considerations that bend the cadence

- **[[Operational Technology]] / [[ICS]] / [[SCADA]]** — Active scans can crash PLCs that have been running for fifteen years on TCP stacks that don't tolerate Nmap. Default to **passive scanning** (span port, network tap, traffic analysis) and run active scans only during planned maintenance windows. CompTIA loves this distinction.
- **Critical infrastructure** — Same rule as OT. Energy, water, manufacturing: passive first, active rarely, authenticated configuration review preferred.
- **Cloud autoscaling groups** — Scheduled scans against an IP range are useless when the IPs rotate hourly. Use [[CSPM]] tooling and agent-based scanning that registers workloads by ID, not IP.
- **Containers** — Scan the image at build time (shift-left), scan the registry on push, and scan running containers via runtime agent. The traditional "scan the host monthly" model misses the actual attack surface.
- **Maintenance windows** — Even credentialed scans against fragile DBs can lock tables. Negotiate scan windows with app owners and document them.
- **[[Segmentation]]** — Scanner placement matters. A scanner in the corporate VLAN won't see the PCI cardholder data environment because the firewall (correctly) blocks it. You need a scanner inside each segment, or you need authenticated routes through the firewall that auditors will challenge.

### Performance and operational tradeoffs

Frequency increases drive scanner load, network load, and ticket volume. Three knobs to manage it:

1. **Throttling** — Cap concurrent host scans and bandwidth per scan job. The scanner will take longer; production won't notice.
2. **Staggering** — Don't scan all 12,000 endpoints at 2am Saturday. Stagger by subnet across the week.
3. **Scope discipline** — A daily scan of 200 internet-facing assets is more useful than a daily scan of 50,000 mixed assets that finishes Thursday.

> **CompTIA exam trap:** "Continuous monitoring" on the exam usually means *continuous assessment of control effectiveness* (NIST CSF / RMF language), not literally a scan running 24/7. When the scenario says "implement continuous monitoring," the right answer is typically a combination of agent-based scanning, SIEM correlation, and automated configuration assessment — not "set the scan interval to zero seconds."

### How scan frequency interacts with the rest of vuln management

Scan frequency is one variable. The others are:

- **[[Scan Type]]** — credentialed vs. non-credentialed, active vs. passive, internal vs. external
- **[[Scope]]** — what's included, what's excluded, what's segmented away
- **[[Remediation SLA]]** — finding a vuln daily doesn't help if you patch quarterly
- **[[Asset Inventory]]** — you can only scan what you know exists; daily scans of a stale CMDB miss the shadow IT box on the DMZ

*A daily scan of an unknown asset is zero scans of that asset. Asset discovery cadence has to keep pace with scan cadence or the whole program runs on a lie.*

## SOC reality

- The dashboard you actually look at on Monday morning shows **delta** — what's new since the last scan. If the cadence is wrong, the delta is either drowning you (too frequent, too noisy) or hiding the new critical CVE on the Exchange server for 29 more days.
- When the CISO asks "are we exposed to [latest CVE]?" the right answer is **"the last authenticated scan against that asset class completed [timestamp] and we'll have fresh data by [time]"** — not "we scan monthly." Cadence is something you should be able to recite for every tier.
- The first ticket from a new scan run is almost always a server owner saying *"your scan crashed our app."* Have the change ticket, the scan window approval, and the throttle settings ready. The fight is procedural, not technical.
- Never promise leadership that increasing scan frequency reduces risk. It reduces *detection time*. Risk reduction happens when remediation SLAs shrink, not when scans run more often. CompTIA loves this distinction and so do auditors.
- The handoff: L1 triages new findings against the asset criticality tier, L2 validates and assigns to system owners, vuln management owns the cadence policy and the exception register. When PCI quarterly approaches, compliance pulls the report — they don't care what your continuous agent fleet did, they want the ASV scan PDF.

## Related concepts

[[Vulnerability Scanning]] · [[Credentialed Scan]] · [[Agent-Based Scanning]] · [[Asset Discovery]] · [[Asset Criticality]] · [[PCI DSS]] · [[Operational Technology]] · [[SCADA]] · [[Segmentation]] · [[Continuous Monitoring]] · [[Change Management]] · [[CVSS]] · [[Remediation SLA]] · [[Passive vs Active Scanning]]

*Source: VIRGIL knowledge base — 2026-05-11*