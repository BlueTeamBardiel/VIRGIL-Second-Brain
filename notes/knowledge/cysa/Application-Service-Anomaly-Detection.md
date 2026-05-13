# Application & Service Anomaly Detection

## What it is

In **Helldivers 2**, you drop onto Malevelon Creek and the mission timer starts ticking normally — patrols on the minimap, ammo count where it should be, stratagem cooldowns clean. Then something shifts. Your reinforcement budget is draining faster than your squad's deaths account for. A patrol icon appears in a sector you already cleared. The Pelican extraction beacon pings a coordinate you didn't call. Nothing has overtly broken — the HUD still works — but the *baseline* of the mission has drifted, and if you don't read the drift, a Bile Titan walks out of the fog and ends the dive. That's exactly what application and service anomaly detection does — you know what normal looks like for an app, and you hunt the deviation before the deviation becomes a breach.

Technically: anomaly detection on applications and services is the practice of baselining expected behavior — process tree, resource consumption, network destinations, log patterns, file writes — and alerting when a running app deviates. CySA+ Objective 1.2 frames it as recognizing **indicators of potentially malicious activity** across host, network, and application layers.

## Why it matters

The endpoint is where the adversary lives once they're past the perimeter. Firewalls don't see [[Living Off the Land]] binaries. The [[SIEM]] doesn't see a process unless something logs it. The thing that catches a compromised app is the analyst who knows that **svchost.exe doesn't spawn cmd.exe at 3:14am on a finance workstation, and a Java process doesn't open outbound to a Ukrainian IP on TCP/4444.**

Exam relevance: Objective 1.2 enumerates over twenty specific indicator types — host, network, application, social. CompTIA will hand you a log snippet, a process tree, or a netstat output and ask which indicator category applies. Know the categories cold.

Career relevance: this is L1/L2 SOC analyst work. Every shift, every ticket. If you can't read a process tree or spot beaconing in a NetFlow dashboard, you don't make it off the helpdesk.

## Key facts

### The three indicator domains

CompTIA splits malicious activity indicators into three buckets. Memorize the split — the exam tests categorization.

| Domain | Watch for | Primary telemetry |
|---|---|---|
| **Network-related** | Unexpected outbound, beaconing, irregular P2P, scans/sweeps, traffic spikes, activity on unexpected ports, rogue devices, bandwidth consumption | Firewall logs, NetFlow/IPFIX, [[IDS/IPS]], DNS logs |
| **Host-related** | Processor/memory/drive consumption, abnormal OS process behavior, file system changes, registry changes, unauthorized scheduled tasks, malicious processes, unauthorized privileges, new accounts | [[EDR]] telemetry, Windows Event Logs, Sysmon, auditd |
| **Application-related** | Anomalous activity, unexpected output, service interruption, application logs, introduction of new accounts, unauthorized changes, unauthorized software | Application logs, [[WAF]] logs, database audit logs |

Social engineering (obfuscated links, phishing) sits in its own bucket on the objective list but typically lands as the *initial access* vector that produces host and network indicators downstream.

### Network-related indicators

**Beaconing** — a compromised host phoning home to C2 on a regular cadence. Look for fixed intervals (every 60s, every 5min) with low-byte payloads, often to a domain registered in the last 30 days. Modern C2 jitters the interval to evade detection — Cobalt Strike defaults to 60s ± 20% jitter. The tell is the *consistency* across hours, not the exact timing.

**Unexpected outbound** — a print server initiating connections to the internet. A SQL database talking to Pastebin. Servers should have boring, predictable egress. When a server reaches outward to somewhere it has never reached before, that's worth a ticket.

**Irregular peer-to-peer** — workstations talking to each other on SMB/445 when your environment doesn't use peer file sharing. Lateral movement signature.

**Scans/sweeps** — one internal host hitting many internal IPs on common ports (22, 445, 3389, 5985). Internal recon. The attacker mapping the network from a foothold.

**Activity on unexpected ports** — your web server has no business listening on TCP/4444 or TCP/8080 outbound. Reverse shells love non-standard high ports.

**Bandwidth consumption / traffic spikes** — a user workstation uploading 40GB at 2am. That's not a backup. That's exfil.

**Rogue devices** — unmanaged MAC addresses appearing on the wire. Could be a contractor's laptop. Could be a Raspberry Pi someone plugged into a conference room jack.

### Host-related indicators

**Abnormal OS process behavior** — the canonical exam example. Parent-child relationships that shouldn't exist:

- `winword.exe → powershell.exe → cmd.exe` (macro execution)
- `svchost.exe → cmd.exe` (process injection into a service host)
- `lsass.exe` being read by anything not Microsoft-signed (credential dumping — [[Mimikatz]] pattern)
- `explorer.exe → rundll32.exe` with weird command-line args

**Processor / memory / drive consumption** — a cryptominer pegs CPU at 100% during off-hours. Ransomware encrypting a fileshare burns disk I/O and drive capacity simultaneously. Memory consumption spikes can indicate process hollowing or large in-memory payloads.

**File system changes** — mass file modification timestamps in a short window (ransomware). New executables in `C:\Users\Public\` or `/tmp/`. Files with double extensions (`invoice.pdf.exe`). System binaries with modified hashes — file integrity monitoring (FIM) catches this.

**Registry changes** — persistence lives in the registry. Watch:

- `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
- `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`
- `HKLM\System\CurrentControlSet\Services\` (new service entries)
- Image File Execution Options (debugger hijacks)

**Unauthorized scheduled tasks** — `schtasks /create` from a non-admin user, or a task with no description running a base64-encoded PowerShell payload. `at.exe` usage is almost always malicious on modern Windows.

**Introduction of new accounts** — local admin account created at 4am from a workstation. Service account suddenly added to Domain Admins. Net user / net group commands logged in 4688 events without a corresponding ticket.

**Unauthorized privileges** — privilege escalation, token manipulation, [[UAC]] bypass. SeDebugPrivilege being held by a non-admin process.

### Application-related indicators

This is where the baseline note's "non-malicious causes" matter — most app anomalies are *boring* (failed dependencies, expired certs, full disks). Your job is to clear the boring stuff fast and surface the suspicious.

**Common non-malicious causes (clear these first):**

- Auth failures (expired creds, locked accounts, Kerberos clock skew)
- Dependency issues (a microservice can't reach its database)
- Permissions problems (service account missing a directory ACL)
- Failed startups or crashes (memory leaks, unhandled exceptions)

**Suspicious app-layer signals:**

- **Unexpected output** — a web app suddenly returning database error strings to users (SQL injection probing). An API returning data fields it never returned before.
- **Service interruption** — a service crashes repeatedly. Could be a memory leak. Could be an attacker triggering a known DoS to force a failover into a vulnerable backup.
- **Unauthorized changes** — config files modified outside change window. WAR/JAR files replaced. Web root contains new `.aspx` or `.php` files (webshells — classic).
- **New accounts in the app** — an admin user created in Jira, Confluence, GitLab, the CMS, the helpdesk system. Adversaries love app-layer accounts because they bypass AD logging.
- **Unauthorized software** — a binary running on a server that's not in the asset inventory or the allowlist. [[Application Allow-Listing]] catches this if you've deployed it.
- **Application logs** — your primary detection source. A WAF log showing 500 attempted SQLi payloads from one IP in 10 minutes is not subtle. A web server log showing requests to `/wp-admin/` on a non-WordPress site is reconnaissance.

### Data exfiltration patterns

Exfil is the dragon stealing the relic. Watch for:

- Large outbound transfers, especially compressed/encrypted (`.zip`, `.rar`, `.7z`) to cloud storage (Mega, Dropbox, Google Drive)
- DNS tunneling — huge volumes of TXT record queries with base64-looking subdomains
- HTTPS POSTs to newly-registered domains
- Slow-and-low: small chunks over weeks to avoid bandwidth alerts

*The exfil you catch in real time is rare. The exfil you catch in retro from NetFlow retention is the norm. Keep your flow data for 90 days minimum.*

### Detection stack — what catches what

| Tool | Catches |
|---|---|
| **AV / [[EDR]]** | Known malware signatures, behavioral process anomalies, parent-child violations |
| **[[FIM]]** (File Integrity Monitoring) | Unauthorized changes to system binaries, configs, web roots |
| **Application allow-listing** | Unauthorized software execution (AppLocker, WDAC) |
| **[[SIEM]]** | Cross-source correlation — a 4688 + a firewall deny + a DNS query for a known-bad domain in 30s |
| **NetFlow / IPFIX** | Beaconing, bandwidth spikes, lateral movement patterns |
| **WAF** | Application-layer attacks against web apps |
| **DLP** | Sensitive data leaving the perimeter |

### CompTIA exam traps

> **CompTIA exam trap:** "Beaconing" vs "scans/sweeps." Beaconing is *outbound to one external destination at regular intervals* — the implant calling home. Scans/sweeps are *one source touching many destinations* — internal recon. CompTIA will give you a log snippet and ask which it is. Read the source/destination cardinality.

> **CompTIA exam trap:** Registry Run keys vs scheduled tasks vs services. All three are persistence mechanisms. Run keys execute at user logon. Scheduled tasks execute on a trigger (time, event, logon). Services execute at boot. Know which event ID logs which: 4698 = scheduled task created, 7045 = service installed, registry needs Sysmon Event ID 13.

> **CompTIA exam trap:** Application logs vs system logs vs security logs. Application logs are written by the *app itself* (IIS, Apache, the database). System logs are the OS event stream. Security logs are auth, privilege, and audit events. Same machine, three different log sources, three different parsers in your SIEM.

> **CompTIA exam trap:** "Unexpected output" is application-related, not host-related. A web app coughing up a stack trace to a user is an app indicator. Don't put it in the host bucket because it's on a server.

## SOC reality

- The 3am alert that matters reads: `EDR — abnormal parent-child — winword.exe spawned powershell.exe with -EncodedCommand on FIN-WKSTN-042, user jdoe.` Your first action is isolate the host via EDR (one click), then pull the encoded payload and base64-decode it before you escalate.
- The L1 closes 80% of "anomaly" alerts as benign — patch reboots, scheduled scans, a developer testing in prod, a service account whose password rotated. The other 20% is where careers are made or ended. *Never close an alert you don't understand — escalate it.*
- The IR lead's first three questions every time: **scope** (how many hosts?), **impact** (what data, what privileges?), **evidence preserved** (did you image before you re-imaged?). Have answers ready before the call.
- Never tell leadership "we've contained it" until the EDR shows the process killed, the network ACL is in place, the credentials are rotated, and 24 hours of clean telemetry have passed. *"Contained" is a present-tense claim with a future-tense liability.*
- Handoff path: L1 triages and enriches → L2 confirms and scopes → IR team takes containment and eradication → legal and execs get looped in if data left the building or regulators care. Don't skip layers unless the building is on fire.

## Related concepts

[[EDR]] · [[SIEM]] · [[Beaconing]] · [[IoC vs IoA]] · [[File Integrity Monitoring]] · [[Application Allow-Listing]] · [[Living Off the Land]] · [[Sysmon]] · [[NetFlow]] · [[MITRE ATT&CK]] · [[Data Exfiltration]] · [[Persistence Mechanisms]] · [[Process Injection]] · [[Webshells]]

*Source: VIRGIL knowledge base — 2026-05-11*