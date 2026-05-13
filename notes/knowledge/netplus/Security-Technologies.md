# Network Monitoring Technologies

## What it is

In **Resident Evil**, the Spencer Mansion has a security room. Banks of CRT monitors fed by cameras you never see being installed, log books on the desk, a typewriter for saving state, and a map that fills in as you explore. Wesker sat in rooms like this for years watching everyone else stumble through the halls. He didn't need to be in the west wing to know a Hunter had broken loose — the cameras told him, the logs told him, and when something tripped a sensor, an alert told him exactly which door.

That's exactly what network monitoring is — the security room for your network, watching every door and every packet, so you find the zombie before it finds you.

Network monitoring is the collection, aggregation, and analysis of telemetry from network devices and hosts to track **performance**, **availability**, **configuration**, and **security** state in real time and against historical baselines. It is how you know your network is healthy before the help desk phone rings, and how you reconstruct what happened after it does.

## Why it matters

You cannot fix what you cannot see. A network without monitoring is the Spencer Mansion with the security room boarded up — you find out about the Hunter when it eats the intern. Monitoring is what separates the engineer who knows the WAN circuit flapped at 02:14 from the one who finds out at Monday standup.

Career-wise: NOC analyst, network engineer, SOC analyst, and SRE roles all live inside monitoring tooling. Exam-wise: **Objective 3.2** is heavily tested — SNMP versions, syslog severity, flow data vs packet capture, SIEM. CompTIA wants you to know which tool answers which question.

## Key facts

### Monitoring methods — ad hoc vs scheduled

- **Ad hoc** — you run a `ping`, a `traceroute`, a packet capture *right now* because something is broken right now. Reactive.
- **Scheduled** — automated polling on an interval. Builds **baseline metrics** over time. Catches the slow leak.

*Ad hoc finds the fire. Scheduled finds the smoke before the fire.*

### SNMP — Simple Network Management Protocol

The dominant protocol for polling devices for stats: interface counters, CPU, memory, temperature, link state. Runs on **UDP 161** (queries) and **UDP 162** (traps).

| Version | Auth | Encryption | Real-world use |
|---|---|---|---|
| **SNMPv1** | community string (plaintext) | none | legacy, do not deploy |
| **SNMPv2c** | community string (plaintext) | none | still everywhere, sadly |
| **SNMPv3** | username + password (HMAC) | AES/DES | the only secure version |

**Community strings** are the SNMPv1/v2c "password" — typically `public` (read-only) and `private` (read-write). Both are cleartext. Anyone sniffing the wire owns your management plane. *Treat v2c community strings like a Post-it labeled "router password" stuck to a monitor — because that's what they are.*

**MIB — Management Information Base** — the hierarchical catalog of what you can ask a device. Each leaf is identified by an **OID** like `1.3.6.1.2.1.2.2.1.10` (interface in-octets). Without the MIB, the OID is just numbers.

**Two interaction modes:**
- **Polling** — the NMS asks every N seconds. Predictable, constant traffic, can miss events between polls.
- **Traps** — the device pushes an alert to the NMS the moment something happens. Event-driven, lower overhead, but unreliable on UDP. **SNMP informs** are traps that require acknowledgment.

> **CompTIA exam trap:** SNMPv2c is *not* secure. The "c" stands for "community-based" and v2c keeps the v1 plaintext auth model. **Only SNMPv3 provides authentication and encryption.** If the question asks for secure SNMP, the answer is v3. Always.

> **CompTIA exam trap:** SNMP traps are on **UDP 162**, not 161. 161 is polling queries. Classic distractor.

### Flow data — NetFlow, sFlow, IPFIX

Flow data is the network equivalent of a phone bill. It doesn't tell you what was said — it tells you **who talked to whom, on what port, for how long, and how many bytes**. Each "flow" is a unique 5-tuple: source IP, dest IP, source port, dest port, protocol.

- **NetFlow** — Cisco original, standardized as IPFIX
- **sFlow** — sampled flow, used by Juniper, Arista, HP
- **IPFIX** — IETF standard, vendor-neutral

*Lightweight, scalable, and tells you 80% of what you need for capacity planning and anomaly detection.*

### Packet capture

The other 20%. When you need to see the actual bytes: **Wireshark**, **tcpdump**, **tshark**. Pcap files are forensic ground truth.

**Port mirroring** (Cisco calls it **SPAN**) copies frames from source ports to a destination port where your capture box lives. **TAP** (Test Access Point) is the hardware alternative — a physical splitter on the cable.

> **CompTIA exam trap:** Flow data ≠ packet capture. Flow is *metadata about conversations*. Packet capture is *the full content*. "Which hosts are consuming bandwidth" = flow. "What is inside a suspicious connection" = packet capture.

### Network discovery

- **Active discovery** — the NMS scans ranges (`nmap`, ICMP sweeps, SNMP walks). Noisy, can trigger IDS, sometimes crashes ancient devices.
- **Passive discovery** — listen to traffic (LLDP, CDP, ARP tables, flow data) and infer topology. Quiet, but only sees what talks.

Most enterprise NMS tools do both, plus consume **CDP/LLDP** to auto-build topology maps. *The map of the Spencer Mansion that fills in as you explore — that's network discovery.*

### What you actually monitor

| Category | Examples |
|---|---|
| **Performance** | bandwidth utilization, latency, jitter, packet loss, CPU, memory |
| **Availability** | up/down state, ICMP reachability, port status, service health checks |
| **Configuration** | running-config diffs, unauthorized changes, drift from golden image |
| **Traffic analysis** | top talkers, top apps, geographic destinations, protocol mix |
| **Security** | failed logins, ACL hits, IDS alerts, anomalous flows |

### Baselines and anomaly alerting

A **baseline** is what "normal" looks like. Monday 9am has high traffic. Saturday 3am does not. Without a baseline, you can't tell whether 400 Mbps on the WAN is a problem or a Tuesday.

**Anomaly alerting** triggers on deviation from baseline. Static thresholds ("alert if CPU > 80%") are easy but dumb. Dynamic baselining ("3 standard deviations above the rolling 7-day average for this hour") catches the actual weirdness.

*Tune your thresholds. An alert system that cries wolf every 4 minutes is an alert system everyone has muted in Slack.*

### Log aggregation and syslog

**Syslog** — standard log protocol, **UDP 514** (TCP 6514 with TLS). Severity levels 0–7:

| Level | Name | Meaning |
|---|---|---|
| 0 | Emergency | system unusable |
| 1 | Alert | act immediately |
| 2 | Critical | critical condition |
| 3 | Error | error condition |
| 4 | Warning | warning condition |
| 5 | Notice | normal but significant |
| 6 | Informational | informational |
| 7 | Debug | debug-level |

A **syslog collector** is a central host that all devices ship logs to — rsyslog, syslog-ng, Graylog.

### SIEM — Security Information and Event Management

SIEM is log aggregation with a security brain bolted on. It ingests logs, flows, alerts, and threat intel; correlates events across sources; and fires alerts when patterns match. Examples: **Splunk**, **QRadar**, **Microsoft Sentinel**, **Elastic Security**.

The value isn't storing logs — anyone can store logs. The value is **correlation**: "this failed VPN login, this lateral SMB connection, this outbound to a known-bad IP — all from the same user inside 90 seconds." No human spots that across a thousand log streams. A SIEM does.

### API integration

Modern monitoring stacks talk to everything via **REST APIs** (JSON over HTTPS). The NMS pulls from the firewall API, pushes to the ticketing API, queries the cloud provider for VM state. Webhooks push events out to PagerDuty, Slack, Teams. *If your monitoring tool can't speak API in 2026, it's a museum piece.*

### CompTIA exam traps

> **Exam trap:** Syslog is **UDP 514**. SNMP poll is **UDP 161**. SNMP trap is **UDP 162**. Memorize.

> **Exam trap:** A **SIEM** is not a log server. A syslog collector stores logs. A SIEM correlates, alerts, and supports incident response. Pick SIEM when the question mentions "correlation," "security event analysis," or "incident response."

> **Exam trap:** **Port mirroring (SPAN)** is a switch feature. A **TAP** is an inline hardware device. A TAP is fully passive and fails open; SPAN consumes switch resources and can drop frames under load.

## Helpdesk reality

- User says "the internet is slow." Check the monitoring dashboard *before* you touch their machine. If the WAN link is at 95%, it's not their machine.
- User says "I can't reach the file server." Check the server's availability monitor first. If it's pingable and SMB is open, the problem is the client.
- Never promise "we'll know the second it goes down." Monitoring polls on intervals. Traps can drop. Promise "we'll know within five minutes" and mean it.
- If a user reports an issue and the monitoring shows nothing, that doesn't mean there's no problem — it means your monitoring has a blind spot. *Trust users over dashboards when they conflict; then fix the blind spot.*
- Escalation point: if SIEM shows a security pattern (lateral movement, credential stuffing, exfiltration), it's not a help desk ticket. Page the SOC and stop touching the box — you're contaminating evidence.

## Related concepts

[[SNMP]] · [[Syslog]] · [[SIEM]] · [[NetFlow and Flow Data]] · [[Packet Capture]] · [[Port Mirroring SPAN]] · [[Network TAP]] · [[Baseline Metrics]] · [[Anomaly Detection]] · [[REST API]] · [[Network Discovery]] · [[CDP and LLDP]] · [[Performance Monitoring]] · [[Availability Monitoring]] · [[Configuration Management]]

*Source: VIRGIL knowledge base — 2026-05-11*