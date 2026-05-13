# Application Behavior Analysis

## What it is

In **Grand Theft Auto V**, the cops don't show up because you exist. They show up because you did something a citizen doesn't do — fired a weapon in Vinewood, jacked a car in front of a witness, ran a red light into a pedestrian. The wanted-level stars are a behavior heuristic. Pre-crime you're invisible. Post-crime the dispatcher knows your last-known location, your vehicle, and your trajectory, and the response scales with the severity. That's exactly what application behavior analysis does — watch what the app *does*, not what it *is*, and flag the moment its behavior crosses a line the baseline says it shouldn't.

In CS0-003 terms: **application behavior analysis** is the detection discipline of comparing an application's runtime activity — processes spawned, files touched, network connections opened, registry keys written, memory allocated, accounts created — against a known-good baseline, and surfacing deviations as **indicators of potentially malicious activity (IoCs)**. It's heuristic and behavioral, not signature-based. The signature engine asks "is this a known bad binary?" Behavior analysis asks "is this binary doing something a known-good binary wouldn't?"

The reason this matters: most modern threats are **living off the land**. The attacker isn't dropping `evil.exe`. They're running `powershell.exe`, `wmic.exe`, `certutil.exe`, `rundll32.exe` — all signed, all trusted, all in your allowlist. The only thing that gives them away is *what those binaries are doing*. Powershell.exe is fine. Powershell.exe spawning at 03:14 with `-EncodedCommand` from an Office macro, beaconing to a domain registered six hours ago — that's a wanted level five and Merryweather is on the way.

## Why it matters

Signature-based detection caught the 2010 threat landscape. The 2026 landscape is fileless malware, supply-chain trojans, legitimate-binary abuse, and zero-days that have no signature by definition. If your detection stack is signature-only, you are catching the script kiddies and missing everything an APT does after initial access.

CySA+ tests this hard under **Objective 1.2 — Given a scenario, analyze indicators of potentially malicious activity.** Expect scenario questions: a host shows X CPU, Y memory, Z outbound — what's the most likely IoC? You will not get the answer from a signature. You get it from knowing what *normal* looks like on that host and naming the deviation.

Career relevance: this is what L1/L2 SOC analysts do all day. The SIEM fires. You open the alert. You look at the process tree, the parent-child chain, the outbound destination, the file writes, the user context. You decide in under five minutes: tuned-out noise, suspicious-needs-L2, or escalate-now. That decision is application behavior analysis.

## Key facts

### The baseline is the whole game

You cannot detect anomaly without a baseline. Period. Behavior analysis with no baseline is just somebody yelling about CPU usage.

A baseline answers: what processes normally run on this host class? What ports does this app normally open? What's the average outbound volume per day? Which user accounts log in to this server? What time? From where? How much disk does this DB write per hour?

Baselines are built from at least 2–4 weeks of clean telemetry — longer for low-frequency events like quarter-end batch jobs. They get reviewed every time the environment changes. *A baseline that wasn't updated after the last app migration is a baseline that screams about every legitimate change and trains the SOC to ignore it.*

### Indicator categories CompTIA tests

CompTIA buckets IoCs into three families. Memorize the buckets; the exam will give you a symptom and ask which bucket.

| Category | What you're watching | Example IoCs |
|---|---|---|
| **Network-related** | Traffic patterns, ports, destinations, volumes | [[Beaconing]], unexpected outbound, [[Data exfiltration]], irregular peer-to-peer, scans/sweeps, activity on unexpected ports, unusual traffic spikes, rogue devices, bandwidth consumption |
| **Host-related** | Endpoint resource usage, OS-level activity | Processor consumption, memory consumption, drive capacity consumption, [[Unauthorized changes]], registry changes, file system changes, unauthorized scheduled tasks, abnormal OS process behavior, malicious processes |
| **Application-related** | App-layer behavior and output | Anomalous activity, [[Unexpected output]], unauthorized software, service interruption, application log anomalies, introduction of new accounts, unauthorized privileges, obfuscated links, social engineering attacks |

### Network-related indicators

**Beaconing** — a process phoning home on a regular interval. Implants check in every 60s, 5min, 1hr — sometimes with jitter to evade naive detection. Look for low-volume, high-regularity outbound to the same destination. NetFlow + IPFIX is how you find it; SIEM correlation rules tuned for periodicity flag it.

**Unexpected outbound** — your DB server should never initiate connections to the internet. Your print server should never talk to a cloud storage API. East-west traffic that doesn't match the app's architecture diagram is the loudest IoC you get.

**Data exfiltration** — large outbound transfer, often staged. Watch for DNS tunneling (massive TXT record traffic), HTTPS POST volumes that don't match the app's read/write pattern, cloud uploads from servers that shouldn't have cloud accounts.

**Irregular peer-to-peer** — workstations talking to each other on SMB, RDP, WMI. Normal workstation traffic is north-south to servers, not east-west to peers. East-west between endpoints is **lateral movement** unless you can prove otherwise.

**Activity on unexpected ports** — a web server with outbound 4444 (default Metasploit), 8080 to unknown, or any outbound to TOR exit nodes. Match port to expected service.

**Rogue devices** — a MAC address showing up on a port that's never had one, a DHCP lease to a hostname that doesn't match your naming convention, a wireless client that didn't go through onboarding. NAC catches this if it's deployed; otherwise the DHCP logs are your only friend.

### Host-related indicators

**Processor / memory / drive consumption** — sustained spikes outside baseline. Cryptominers love CPU; ransomware loves disk I/O (encrypting everything); memory-resident implants will sit at unusually high RAM for the binary they claim to be.

**Registry changes** — Run, RunOnce, services, scheduled-task registrations, AppInit_DLLs. Persistence lives in the registry. Sysmon Event ID 13 (registry value set) is the firehose you tune.

**File system changes** — new binaries in `C:\Windows\Temp`, `%AppData%`, `%ProgramData%`. Modifications to system DLLs. New files in startup folders. Sysmon Event ID 11 (file create) catches this.

**Unauthorized scheduled tasks** — the second-favorite persistence mechanism after registry Run keys. `schtasks.exe /create` invoked by a process that has no business creating tasks is a near-certain IoC.

**Abnormal OS process behavior** — the canonical one: `winword.exe` spawning `powershell.exe` spawning `cmd.exe` spawning `rundll32.exe`. That parent-child chain has no legitimate reason to exist. EDR lives for this.

**Malicious processes** — process names misspelled to look legit (`scvhost.exe` not `svchost.exe`), running from the wrong path (`svchost.exe` from `%TEMP%` instead of `System32`), running under the wrong user (`lsass.exe` under a domain user not SYSTEM).

### Application-related indicators

**Unauthorized software** — new binaries that didn't come through your software deployment system. Anything not on the approved list, especially RMM tools (AnyDesk, ScreenConnect, TeamViewer) installed silently — those are the 2024–2026 ransomware operator's favorite ingress-and-persistence kit.

**Service interruption** — services stopping that should be running. Especially: AV, EDR, Windows Defender, event logging, backup agents. Attackers disable defenses before they execute payload. *If your EDR agent stops reporting and nobody's pushing an update, treat it as compromised until proven otherwise.*

**Introduction of new accounts** — local admin accounts created outside the IAM pipeline. Domain accounts created outside the JML (joiner-mover-leaver) process. Service accounts with interactive logon enabled. Event ID 4720 (account created), 4732 (added to local group), 4728 (added to global group).

**Unauthorized privileges** — existing accounts suddenly in Domain Admins, Enterprise Admins, or the local Administrators group. Privilege escalation events outside the change window.

**Unexpected output** — the app returns data it shouldn't. SQL error messages leaking schema. Stack traces in a production response. Web pages rendering content from other tenants. Often the first sign of injection or auth bypass.

**Obfuscated links** — URLs with hex encoding, punycode lookalikes, URL shorteners hiding the destination, base64-encoded redirects. Phishing's signature move.

**Application log anomalies** — gaps in the log (attacker cleared logs — Event ID 1102 on Windows is a *huge* tell), bursts of failed auths, log entries from impossible times or locations, log levels suddenly switching to ERROR en masse.

### CompTIA exam traps

> **CompTIA exam trap — IoC vs IoA.** Indicator of Compromise is forensic, post-event: "this file hash was on the box." Indicator of Attack is behavioral, in-progress: "this process chain is happening now." Behavior analysis produces both, but CompTIA will ask which type a given symptom is. Process tree currently spawning = IoA. File hash in YARA hit = IoC.

> **CompTIA exam trap — beaconing vs unusual traffic spike.** Beaconing is low-volume, high-regularity, periodic. Unusual traffic spike is high-volume, often one-shot or short-burst (exfil, DDoS participation). Same network bucket, different signatures, different answers.

> **CompTIA exam trap — baseline is required.** If the question stem says "the analyst notices high CPU" with no baseline mentioned, the *correct* answer is often "establish a baseline" or "compare to baseline," not "isolate the host." CompTIA loves to test that you don't react without a reference point.

> **CompTIA exam trap — abnormal process behavior wording.** Watch for "Office application spawning a scripting engine" — that's the canonical malicious parent-child chain (macro-borne malware). Default to suspicious unless the question explicitly justifies it.

## SOC reality

- The 3am alert reads: `EDR: ALERT — winword.exe → powershell.exe → cmd.exe — host WKS-FIN-0421 — user jdoe — outbound to 185.x.x.x:443`. Your first action is not to call IR. It's to pull the process tree, check the user's recent email for an attachment, and confirm whether `jdoe` is logged in or whether this fired off a scheduled task. Five-minute triage before you escalate.
- The CISO walks in at 8am and asks three questions: **scope** (how many hosts?), **impact** (what did it touch?), and **evidence** (do we have the artifacts preserved?). If you can't answer scope inside 30 minutes, your detection stack is undertuned or your asset inventory is broken — usually both.
- Never tell leadership "we've contained it" until you've confirmed no live C2, no persistence, no lateral spread. The temptation to declare victory after killing one process is the most expensive instinct in this job.
- 80% of behavior-analysis alerts are tuned-out noise: a developer running an unsigned binary, an admin using `psexec` legitimately, a backup job spiking disk. The 20% that matter look identical to the 80% on the first glance — that's the whole challenge. Tune aggressively, but document every suppression so the next analyst knows why the rule is quiet.
- Handoff: L1 confirms the chain and user context, L2 pulls memory and validates persistence, IR team scopes blast radius and runs containment, legal gets pulled in when data classification crosses regulatory lines. Know your escalation tree before the alert fires.

## Related concepts

[[Beaconing]] · [[Data exfiltration]] · [[Indicators of Compromise]] · [[Indicators of Attack]] · [[SIEM]] · [[EDR]] · [[Sysmon]] · [[MITRE ATT&CK]] · [[Living off the Land]] · [[Lateral Movement]] · [[Persistence Mechanisms]] · [[Process Tree Analysis]] · [[NetFlow Analysis]] · [[Baseline Configuration]] · [[Threat Hunting]]

*Source: VIRGIL knowledge base — 2026-05-11*