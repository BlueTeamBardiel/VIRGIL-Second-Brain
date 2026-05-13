# Network Communication

## What it is

In **Watch Dogs**, Aiden Pearce stands on a Chicago street corner and the ctOS feed lights up around him — every pedestrian's name, income, and medical condition; every traffic camera he can hop into; every phone call he can tap. The city is instrumented. Every node reports back. Aiden doesn't see the city — he sees its telemetry.

That's exactly what network monitoring does. You don't watch the network. You watch what the network reports about itself.

Technically: **network monitoring** is the collection, aggregation, and analysis of telemetry from network devices and hosts to verify availability, measure performance, detect anomalies, and produce evidence for troubleshooting and audit. The N10-009 exam treats it as a toolbox: **SNMP** for device polling, **syslog** for event streams, **flow data** for traffic accounting, **packet capture** for forensic depth, **SIEM** for correlation, and **APIs** for everything modern. You pick the tool by the question being asked.

## Why it matters

A network you can't see is a network you can't fix. When the helpdesk queue lights up with "internet is slow," you don't guess — you check the dashboard. Was there a CPU spike on the core switch at 09:42? Did the WAN link saturate? Did a port flap? Did anyone authenticate to the firewall from Bucharest at 3am? The answers live in telemetry you collected before the incident started.

Objective **3.2** is a heavy hitter on N10-009. Expect questions on **SNMP versions and security**, **trap vs poll**, **flow data vs packet capture**, **syslog severity levels**, **SIEM correlation**, and the difference between **performance**, **availability**, and **configuration monitoring**. CompTIA also leans hard on **baseline metrics** — you can't detect anomalies without a normal.

## Key facts

### Monitoring methods

| Method | What it means | When you use it |
|---|---|---|
| **Ad hoc** | One-off check, manual | Troubleshooting a live ticket — `ping`, `traceroute`, `show interface` |
| **Scheduled** | Polling on a fixed interval | Continuous health checks, dashboards, trend graphs |
| **Event-driven** | Device pushes when something happens | SNMP traps, syslog messages — alerts you didn't ask for |

The exam distinction: **ad hoc** is reactive, **scheduled** is proactive baseline collection, **event-driven** is the device interrupting you because something broke.

### Network discovery

How the monitoring system learns what devices exist. Two flavors:

- **Active discovery** — the scanner pings, sweeps subnets, queries SNMP, fingerprints. Fast but noisy and visible.
- **Passive discovery** — listens to traffic (CDP, LLDP, ARP, DHCP) and infers topology without sending probes. Slower, quieter, doesn't trip IDS.

[[LLDP]] and Cisco's [[CDP]] are the link-layer protocols neighbors use to announce themselves. A monitoring platform that speaks LLDP can draw your topology map without you typing in a single IP.

### SNMP — the workhorse

**Simple Network Management Protocol** runs on **UDP 161** for queries and **UDP 162** for traps. It's how monitoring platforms talk to switches, routers, firewalls, UPS units, printers — basically anything with a management plane.

**Three operations matter:**

- **GET** — manager polls agent: "what's the value of this OID?"
- **SET** — manager writes a value to the agent (rare, dangerous, often disabled)
- **TRAP** — agent pushes unsolicited alert to manager: "interface gi0/1 just went down"

**Polling vs traps:** polling is scheduled GETs every 1–5 minutes. Traps are real-time event pushes. You use both — polling for trend data, traps for "wake me up at 3am" events.

#### MIB and OIDs

The **Management Information Base (MIB)** is the schema. It defines every variable an agent can report — interface counters, CPU load, temperature, uptime. Each variable has an **OID (Object Identifier)** — a dotted numeric string like `1.3.6.1.2.1.2.2.1.10.1` (that's `ifInOctets` for interface 1, bytes received).

Vendors ship their own MIBs (Cisco-specific, Juniper-specific) on top of the standard ones. Your monitoring platform loads the MIB to translate OIDs into human-readable names.

#### SNMP versions — exam gold

| Version | Auth | Encryption | Use in 2026 |
|---|---|---|---|
| **SNMPv1** | Community string (plaintext) | None | Legacy only — avoid |
| **SNMPv2c** | Community string (plaintext) | None | Still widely deployed; insecure but functional |
| **SNMPv3** | Username + password (HMAC) | Optional AES/DES | The only version you should deploy new |

**Community strings** in v1/v2c are passwords sent in cleartext. Two conventions: `public` for read-only, `private` for read-write. If you've ever inherited a network where `public` and `private` are still the live community strings, you've inherited a network anyone with `snmpwalk` can map in thirty seconds.

**SNMPv3** introduces three security levels:
- **noAuthNoPriv** — username only, no auth, no encryption (pointless)
- **authNoPriv** — authenticated but not encrypted (MD5/SHA)
- **authPriv** — authenticated AND encrypted (the one you want)

> **CompTIA exam trap:** SNMPv2c is NOT secure just because it's newer than v1. v2c added bulk operations and better error handling, but the community string is still cleartext on the wire. Only **v3 with authPriv** is considered secure. If the question asks "most secure SNMP option," the answer is always SNMPv3, never v2c.

### Performance, availability, configuration monitoring

Three flavors of "is it healthy?":

- **Performance monitoring** — how well is it working? Bandwidth utilization, latency, jitter, CPU, memory, interface errors. Trend graphs live here.
- **Availability monitoring** — is it up? ICMP ping, TCP port checks, HTTP probes. Pure binary up/down with uptime percentages.
- **Configuration monitoring** — did the config change? Tracks running-config diffs, alerts when someone modifies an ACL or a routing statement. Critical for change control and post-incident forensics.

A platform that does all three is what most vendors call NMS (Network Management System).

### Baseline metrics and anomaly alerting

A **baseline** is normal. You can't detect abnormal without it. Collect for two to four weeks minimum during typical business cycles — weekday, weekend, month-end batch jobs, the Monday morning login storm.

Once you have a baseline, **anomaly alerts** fire when current values deviate beyond a threshold. Two threshold styles:

- **Static** — alert if CPU > 80% for 5 minutes
- **Dynamic** — alert if current value is more than 3 standard deviations from the same-time-of-week historical average

*The first time someone hands you a brand-new monitoring deployment with no baseline, every alert is noise. Tune for two weeks before you trust any of it.*

### Flow data vs packet capture

This is the most common exam confusion in 3.2. Both look at traffic. They are not the same thing.

| | **Flow data** | **Packet capture** |
|---|---|---|
| What it sees | Metadata: src/dst IP, ports, protocol, byte count, duration | Full packet contents — headers AND payload |
| Volume | Small — summaries per conversation | Massive — every byte on the wire |
| Use case | Traffic accounting, top talkers, capacity planning | Deep forensics, protocol debugging, security investigation |
| Examples | **NetFlow** (Cisco), **sFlow**, **IPFIX** | **Wireshark**, **tcpdump**, full PCAP files |

[[NetFlow]] tells you that 10.1.5.7 sent 4 GB to 8.8.4.4 over TCP/443 yesterday afternoon. Packet capture tells you exactly what was in those packets. Flow scales to backbone links; capture doesn't.

### Port mirroring

You can't capture packets a switch doesn't show you. Switches forward frames only to their destination port — that's the point. To capture, you configure **port mirroring** (Cisco calls it **SPAN** — Switched Port Analyzer): the switch duplicates traffic from a source port (or VLAN) to a destination port where your capture device sits.

**RSPAN** spans across switches in the same L2 domain. **ERSPAN** tunnels mirrored traffic over L3 (GRE) to a remote analyzer.

> **CompTIA exam trap:** You cannot capture traffic on a switched network by just plugging a laptop into any port. The switch will only show you broadcast, multicast, and traffic destined for your MAC. You need port mirroring/SPAN, a network TAP, or a hub (which doesn't exist anymore in production). This is a frequent N10-009 question.

### Syslog and log aggregation

**Syslog** runs on **UDP 514** (or TCP 6514 for syslog over TLS). Devices send event messages to a central **syslog collector**. Severity levels you must know:

| Level | Name | Meaning |
|---|---|---|
| 0 | Emergency | System unusable |
| 1 | Alert | Immediate action required |
| 2 | Critical | Critical condition |
| 3 | Error | Error condition |
| 4 | Warning | Warning |
| 5 | Notice | Normal but significant |
| 6 | Informational | Informational |
| 7 | Debug | Debug-level |

Mnemonic: **E**very **A**wesome **C**isco **E**ngineer **W**ill **N**eed **I**ce-cream **D**aily. Lower number = more severe.

**Log aggregation** collects logs from dozens or thousands of sources into one searchable index. You can't grep a hundred switches by hand at 2am — you grep the aggregator.

### SIEM

**Security Information and Event Management** sits on top of log aggregation and adds **correlation** — rules and analytics that turn raw events into incidents. Splunk, QRadar, Sentinel, Elastic Security. The SIEM watches for patterns: 50 failed logins followed by a success is a brute-force success. A new admin account created at 4am is suspicious. A workstation suddenly talking to a server it's never contacted before is lateral movement.

*A SIEM is only as good as the rules tuned into it. Out of the box, it's an expensive log search. Tuned, it's how you find the breach before the breach finds you.*

### API integration

Modern monitoring is API-first. **REST APIs** over HTTPS let your monitoring stack pull telemetry, push config, integrate with ticketing, and feed dashboards. **Webhooks** push events to Slack, Teams, PagerDuty. The exam doesn't go deep here — know that API integration is how monitoring tools talk to each other and to ITSM platforms, replacing legacy point-to-point integrations.

## Helpdesk reality

- User says: "The internet is slow." You check the bandwidth graph for their site on the WAN edge. If utilization is at 95%, it's capacity. If it's at 20%, it's not the WAN — look at DNS, the wireless, or the user's laptop.
- User says: "It worked yesterday." Configuration monitoring tells you what changed overnight. If nothing changed in config, look at logs for what changed in state — a flapping link, a failover, a certificate expiry.
- Never promise "we're already alerted on that." Half the time, the alert was suppressed, the SNMP community was wrong, or the device fell off monitoring six months ago and nobody noticed.
- If you don't have a baseline, you don't actually know if anything is wrong. You're guessing with confidence.
- Escalation point: if performance graphs show the problem is upstream of your edge router, it's an ISP ticket. Get the circuit ID and the last 60 minutes of flow data ready before you call.

## Related concepts

[[SNMP]] · [[NetFlow]] · [[Syslog]] · [[SIEM]] · [[Port Mirroring]] · [[Packet Capture]] · [[Wireshark]] · [[Baseline]] · [[LLDP]] · [[CDP]] · [[REST API]] · [[Network Discovery]] · [[MIB]] · [[OSI Model]] · [[Change Management]]

*Source: VIRGIL knowledge base — 2026-05-11*