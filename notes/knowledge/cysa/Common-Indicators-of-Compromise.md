# Common Indicators of Compromise

## What it is

In **Cyberpunk 2077**, when V jacks into a hostile network, the scanner overlay paints the room in red highlights — a Militech turret pinging on a frequency it shouldn't, a netrunner crouched behind a wall whose breach protocol just lit up your RAM, a camera that swivels to track you when no NPC is in the room. None of those things are the attack itself. They're the *tells* that an attack is in progress or already happened. That's exactly what indicators of compromise are — the artifacts left behind on hosts, networks, and logs that tell you something hostile is touching your environment.

In plain English: an IoC is a forensic breadcrumb. A weird process. A connection to an IP in a country you don't do business with. A file that shouldn't exist. A login at 3am from an account that goes home at 5pm.

Technical definition for CS0-003: an **Indicator of Compromise (IoC)** is observable evidence — host-based, network-based, or log-based — that an asset has been or is being attacked. IoCs are **forensic and retrospective** ("what happened"), distinct from **Indicators of Attack (IoA)**, which are behavioral and active ("what's happening right now"). IoCs feed [[Detection and Analysis]] inside the [[NIST 800-61 Incident Response Lifecycle]] and drive every downstream decision: [[Scope]], [[Impact]], [[Containment]], [[Eradication]], [[Recovery]].

## Why it matters

If you can't recognize an IoC, you can't open a ticket. If you can't open a ticket, the dwell time clock keeps running, and the average breach dwell time is still measured in weeks. The CySA+ exam tests this on **Objective 3.2** because the entire incident response process is gated on detection — and detection is gated on knowing what a compromised host *looks* like in the logs.

In the SOC, the L1 analyst lives in IoC land. Every fired SIEM rule is a candidate IoC. Most are noise. The 5% that aren't are how the org finds out it's been breached — usually before legal, almost always before the executives.

## Key facts

### Network-based IoCs

These are the ones that hit your IDS, NetFlow collector, and DNS logs first.

| IoC | What it looks like | Why it matters |
|---|---|---|
| **Unusual outbound traffic** | Connection to a country/ASN you don't do business with | Most attacks exfiltrate *out*, not in. Outbound is the tell. |
| **Beaconing** | Periodic connections every N seconds with low jitter | Classic C2 callback. Cobalt Strike, Sliver, custom implants. |
| **DNS anomalies** | Queries to DGA domains, long subdomains, TXT record abuse | DNS tunneling / DNS C2. Often missed because port 53 is "always allowed." |
| **Traffic on unexpected ports** | RDP on 4444, SSH on 8080 | Attackers rebind services to evade port-based filtering. |
| **East-west traffic spikes** | Workstation talking to workstation | [[Lateral movement]]. Workstations should talk to servers, not each other. |
| **Protocol/port mismatch** | HTTPS on 22, SSH on 443 | Tunneling through allowed egress paths. |
| **Volume anomalies** | 40GB outbound from an HR laptop at 2am | Bulk exfil. The volume itself is the IoC. |
| **Probes and scans** | Sequential TCP SYN to 22, 23, 80, 443, 3389 | Either an external recon or an internal pivot. Segment your network so you can tell which. |

> **CompTIA exam trap:** Probes and scans from an **internal** source are far worse than from external. External scans hit your perimeter every day. An internal host scanning the /24 means an attacker already has a foothold and is mapping for lateral movement. Don't downgrade internal recon to "noise."

### Host-based IoCs

These come from EDR, endpoint logs (Sysmon, Windows Security), and file integrity monitoring.

- **Unauthorized processes** — `powershell.exe -EncodedCommand`, `rundll32.exe` spawning network connections, `cmd.exe` parented to `winword.exe` (macro execution chain)
- **New or modified services** — persistence via service creation (Event ID 7045)
- **Scheduled tasks** — `schtasks.exe /create` running at logon or every 10 minutes
- **Registry run keys** — `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` entries you didn't put there
- **Unusual file hashes** — known-bad SHA256 matching threat intel feeds
- **File system anomalies** — files in `C:\Windows\Temp\`, `%APPDATA%`, or `C:\ProgramData\` with random names
- **Unexpected privilege escalations** — a standard user account suddenly in the local Administrators group
- **Account anomalies** — disabled accounts logging in, service accounts with interactive logons, impossible-travel logins
- **Memory artifacts** — process hollowing, reflective DLL injection, unsigned modules in signed processes
- **Disk usage spikes** — staging directories filling up before exfil
- **Antivirus disabled** — Defender real-time protection off, EDR agent stopped or uninstalled

### Log-based and application IoCs

- **Authentication failures followed by success** — brute force or password spray that worked
- **Logons outside business hours** — especially for accounts that have never done so
- **Service account interactive logons** — service accounts should run services, not open desktops
- **Audit log clearing** — Windows Event ID 1102. *If they clear the log, the clearing is the log.*
- **Web server anomalies** — unexpected `POST` to admin endpoints, web shells (`cmd.aspx`, `shell.jsp`), spikes in 500-class errors
- **Database query anomalies** — `SELECT *` over entire tables, queries from unexpected service accounts
- **Email security** — sudden mailbox forwarding rules, OAuth grant to unknown apps, bulk message rules

### IoC vs IoA

| | **IoC** | **IoA** |
|---|---|---|
| Time orientation | Retrospective | Real-time / proactive |
| Question answered | What happened? | What's happening? |
| Example | A known-bad SHA256 in the file system | A process spawning suspicious children right now |
| Mapped to | Forensics, threat intel | Behavioral detection, EDR/XDR |

> **CompTIA exam trap:** IoC and IoA are not interchangeable. If the question describes a **known artifact match** (hash, IP, domain, filename), it's an IoC. If it describes **behavior in progress** (process tree, sequence of actions), it's an IoA. CompTIA will give you a stem that sounds like both and you have to pick the orientation.

### IoCs inside the NIST 800-61 lifecycle

IoCs don't live alone — they're the connective tissue of incident response. The CS0-003 exam wants you to know where each appears.

**Preparation** — build the IoC catalog. Subscribe to threat intel feeds. Tune SIEM rules. Run tabletops where the injected IoC is realistic.

**Detection and Analysis** — IoCs fire. Triage. Confirm scope (how many hosts?), impact (what data, what systems, what dollars?), and validity (is this real or a false positive?). Begin **data and log analysis** — pull SIEM correlation, NetFlow, endpoint timelines.

**Containment, Eradication, and Recovery** — based on confirmed IoCs:
- **Isolation** — network-quarantine the host via EDR, switch port shutdown, or NAC. Don't power off — you lose volatile memory.
- **Evidence acquisition** — capture RAM first (volatile), then disk image, then logs. Use a [[Write blocker]] for disk imaging.
- **Chain of custody** — every transfer of evidence logged with who/what/when/where. Missing one entry breaks admissibility.
- **Preservation** — store images in a tamper-evident location. Hash everything (SHA-256) at acquisition and verify before analysis. This is **validating data integrity**.
- **Legal hold** — once IR confirms a likely incident with legal exposure, normal data retention is suspended. Don't delete anything that might be relevant.
- **Eradication** — kill processes, remove persistence, rotate credentials touched by the attacker
- **Remediation** — patch the vulnerability that was exploited, fix the misconfiguration
- **Re-imaging** — for confirmed compromise of a workstation or server, wipe and rebuild from gold image. *You cannot clean a rootkit you can't see.*
- **Compensating controls** — if the root vulnerability can't be patched immediately (legacy app, vendor support window), put a temporary control in place: WAF rule, segmentation, additional logging, MFA enforcement.

**Post-incident Activity** — IoCs from the incident become detections going forward. Yara rules. Sigma rules. SIEM correlation logic. The attack you survived is the vaccine for the next one.

> **CompTIA exam trap:** **Re-imaging** is the safe answer when an endpoint is confirmed compromised with malware persistence. "Run AV scan and put it back into production" is the wrong answer. CompTIA tests this because in the real world, business pressure pushes against re-imaging — but the exam wants the textbook clean answer.

### The scope vs impact distinction

CompTIA separates these and so should you.

- **Scope** = how wide. Number of hosts, accounts, network segments, data stores touched. Answers "how much of the environment?"
- **Impact** = how bad. Data classification touched (PII, PHI, PCI, IP), business systems affected, regulatory exposure, dollars. Answers "what does this cost?"

You report both up. The CISO asks scope first ("how bad is it?"), then impact ("what does that mean for us?"). Get both wrong at your peril.

## SOC reality

- At 3am, the IoC that wakes you is rarely the exotic one. It's a beacon to an unfamiliar IP, an EDR alert for `mshta.exe` spawning `powershell.exe`, or a "user disabled MFA" event from your IdP. Boring on paper. Existential when it's real.
- L1's first move: don't touch the host. **Acknowledge the alert, pivot to SIEM, build the timeline.** Pulling the network cable before you have the timeline destroys volatile evidence and tips the attacker that you saw them.
- The CISO asks three questions, in this order: **scope, impact, evidence preserved?** If you can't answer all three within an hour of escalation, the IR program isn't mature yet.
- Never tell leadership "we've contained it" until you've validated lateral movement paths and rotated touched credentials. A contained host on a network where the attacker still has domain admin is not contained.
- The handoff path: L1 triages and enriches → L2 confirms and scopes → IR team owns containment and forensics → legal owns notification and hold → executive owns external comms. Skip a step and someone gets paged at 4am to clean it up.
- 80% of IoC alerts are tunable noise. The 20% that matter look exactly like the 80% until you pull the timeline. *Triage discipline is the entire job.*

## Related concepts

[[Indicators of Attack (IoA)]] · [[NIST 800-61 Incident Response Lifecycle]] · [[Chain of custody]] · [[Evidence acquisition]] · [[Validating data integrity]] · [[Legal hold]] · [[Re-imaging]] · [[Compensating controls]] · [[SIEM]] · [[EDR/XDR]] · [[Threat intelligence]] · [[STIX/TAXII]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Lateral movement]] · [[Beaconing and C2]] · [[DNS tunneling]] · [[Sysmon]] · [[Write blocker]] · [[Scope and impact]]

*Source: VIRGIL knowledge base — 2026-05-11*