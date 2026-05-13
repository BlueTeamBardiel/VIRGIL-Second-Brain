# Logs And Monitoring

## What it is

In **Fallout**, you walk into a ransacked Vault and the first thing you do is hit the terminals. Overseer's log. Security log. Maintenance log. Some entries are routine ("water chip replaced, 2077-10-12"), some are screaming ("the door won't hold, they're inside"). The story of what killed everyone is already written down — you just have to read it in order. The Pip-Boy radio chirps when something nearby changes. Your S.P.E.C.I.A.L. stats give you a baseline of what "normal you" looks like, so when you're irradiated or crippled, the numbers tell you before the symptoms do.

That's exactly what logs and monitoring do on a network. Every device — routers, switches, firewalls, servers — keeps terminals full of entries. Monitoring tools read them in order, alert on the screaming ones, and compare current behavior against a baseline of "normal." When the network is dying, the story is already written. You just have to be listening.

Technically: **network monitoring** is the continuous collection, aggregation, and analysis of device telemetry (logs, metrics, flows, packets) to maintain availability, performance, security, and configuration integrity. N10-009 Objective 3.2 covers the methods, protocols, and tools used to do it.

## Why it matters

You cannot fix what you cannot see. A router can be dropping 4% of packets for three weeks and nobody notices until the CEO's Zoom call stutters. A switch can be 98% CPU at 3am every night because of a broadcast storm in VLAN 40 and the day-shift never knows. Logs and monitoring are how you find problems **before** the helpdesk queue tells you, and how you prove what happened **after** an incident.

For Net+ this is one of the most heavily tested operational domains. CompTIA expects you to know SNMP versions cold, the difference between polling and traps, what flow data shows that packet capture doesn't, and why a SIEM is not just a fancy log file. *Show up to the exam fuzzy on SNMPv2c vs SNMPv3 and you will lose points.*

## Key facts

### Monitoring methods

Three modes of collection, and CompTIA wants all three named:

| Method | What it is | Example |
|---|---|---|
| **Scheduled** | Polled at fixed intervals | SNMP GET every 60 seconds for interface counters |
| **Ad hoc** | Run on demand by an engineer | `show interface` on a switch during a complaint |
| **Trap / event-driven** | Device pushes an alert when something happens | SNMP trap when an interface goes down |

Scheduled gives you trends. Ad hoc gives you answers to a specific question. Traps give you speed — the device tells you the second it breaks instead of waiting for the next poll cycle.

### SNMP — Simple Network Management Protocol

The workhorse of network monitoring. [[SNMP]] runs on **UDP 161** (queries) and **UDP 162** (traps). The monitoring server is the **NMS** (Network Management Station). Every monitored device runs an **SNMP agent**.

**MIB (Management Information Base)** — the tree of every value the agent can report. Each value has an **OID** (Object Identifier) like `1.3.6.1.2.1.2.2.1.10.1` (interface 1 input octets). The MIB is the device's terminal directory; the OID is the file path. You don't memorize OIDs — you load the vendor's MIB file into your NMS and it translates.

**SNMP operations:**
- **GET** — NMS asks agent for a value
- **GETNEXT / GETBULK** — walk the MIB tree
- **SET** — NMS writes a value (change config remotely — usually disabled)
- **TRAP** — agent pushes an unsolicited alert to the NMS
- **INFORM** — like a trap but acknowledged (reliable)

**SNMP versions — memorize this table:**

| Version | Auth | Encryption | Notes |
|---|---|---|---|
| **v1** | Community string (plaintext) | None | Legacy, avoid |
| **v2c** | Community string (plaintext) | None | Most common in the wild, adds GETBULK and INFORM |
| **v3** | Username + password (MD5/SHA) | Optional (DES/AES) | The only secure version |

**Community strings** are the v1/v2c "password" — typically `public` (read-only) and `private` (read-write). They travel **in cleartext**. Anyone sniffing the wire reads them. This is why v3 exists.

> **CompTIA exam trap:** If the question mentions **authentication and encryption** for SNMP, the answer is **v3**. If it mentions **community strings**, it's v1 or v2c. If it mentions **GETBULK**, it's v2c or v3 (not v1). Don't confuse "community string" with "credentials" — they are not the same thing and v3 is the only one with real auth.

### Network discovery

How the NMS finds what's on the network in the first place. Two flavors:

- **Active** — the NMS sweeps subnets with ICMP, SNMP, and port probes. Fast, noisy, sometimes triggers IPS.
- **Passive** — the NMS listens to LLDP/CDP advertisements, ARP tables, DHCP leases, NetFlow records. Slower, invisible.

Most NMS tools do both. Discovery builds the topology map and the device inventory the rest of monitoring depends on.

### Flow data vs packet capture

Two completely different tools, constantly confused.

| | **Flow data** (NetFlow, sFlow, IPFIX) | **Packet capture** (pcap, Wireshark) |
|---|---|---|
| What it shows | Metadata: src, dst, port, protocol, bytes, duration | Full payload of every packet |
| Volume | Small — summaries | Massive — every byte |
| Use case | "Who's talking to whom and how much" | "What did they actually say" |
| Retention | Weeks to months | Hours to days |
| Where collected | Router/switch exports to a collector | SPAN/mirror port to a sniffer |

[[NetFlow]] (Cisco) and [[sFlow]] tell you traffic volume by conversation. Packet capture tells you the contents. Flow finds the elephant; pcap dissects it.

**Port mirroring** (SPAN on Cisco) is how you feed a packet capture tool. The switch is configured to copy traffic from one or more ports (or a whole VLAN) to a designated **monitor port** where a sniffer or IDS sits. Without port mirroring, a switch only forwards frames to their destination MAC, and your sniffer sees nothing but its own traffic.

> **CompTIA exam trap:** "You need to analyze the contents of suspicious traffic" → **packet capture** with **port mirroring**. "You need to identify which host is consuming the most bandwidth" → **flow data**. Don't pick pcap for volume questions and don't pick NetFlow for payload questions.

### Performance, availability, configuration monitoring

CompTIA names these as three distinct disciplines:

- **Performance monitoring** — throughput, latency, jitter, CPU, memory, interface errors. Are things *fast enough*?
- **Availability monitoring** — is the device up? Ping, TCP port check, HTTP health probe. Are things *there at all*?
- **Configuration monitoring** — has the running config changed? Diff against last known good. Detects unauthorized changes and config drift.

A device can be **available** (pings fine) but **performing badly** (60% packet loss). A device can be **performing fine** today but its config silently changed last night — that's where configuration monitoring catches the time bomb.

### Baselines and anomaly alerting

A **baseline** is the recorded "normal" — WAN link averages 200 Mbps weekdays 9–5, 40 Mbps overnight, CPU sits at 15%. You build it over weeks of clean operation. Then you alert on deviation: *WAN link at 800 Mbps at 2am on a Tuesday* is anomalous even if it's technically within the link's capacity.

**Anomaly alerting** = the monitoring system flags deviation from baseline. Static thresholds ("alert if CPU > 90%") catch obvious failures. Baseline-driven alerts catch the weird stuff — exfiltration, compromised hosts, runaway processes.

*Without a baseline, every alert is just a number. With a baseline, every alert is a story.*

### Log aggregation and syslog

Every device generates logs locally. That's useless when you have 400 devices. **Log aggregation** centralizes them.

[[Syslog]] runs on **UDP 514** (or TCP 514 / TLS 6514 for reliable/encrypted variants). The **syslog collector** is the central server that receives messages from every device. Syslog messages carry a **severity** (0=emergency, 7=debug) and a **facility** (which subsystem).

Memorize the severity scale — CompTIA tests it:

| Level | Name | Meaning |
|---|---|---|
| 0 | Emergency | System unusable |
| 1 | Alert | Action required immediately |
| 2 | Critical | Critical condition |
| 3 | Error | Error condition |
| 4 | Warning | Warning condition |
| 5 | Notice | Normal but significant |
| 6 | Informational | Informational |
| 7 | Debug | Debug-level |

### SIEM — Security Information and Event Management

A [[SIEM]] is log aggregation **plus correlation, alerting, retention, and search**. Splunk, QRadar, Sentinel, Graylog. Logs flow in from firewalls, AD, endpoints, servers, switches. The SIEM normalizes them into a common schema and runs **correlation rules**: "100 failed logins from one IP followed by one success = brute force, alert."

A syslog collector is a filing cabinet. A SIEM is a detective reading every file as it lands and shouting when the pattern matches a crime. SIEM is also where **compliance retention** lives — PCI, HIPAA, SOX all require log retention measured in years.

> **CompTIA exam trap:** Syslog collector = receives and stores logs. SIEM = receives, stores, **correlates, and alerts**. If the question mentions "correlation across multiple sources" or "security event detection," it's SIEM, not plain syslog.

### API integration

Modern monitoring lives on **APIs**. REST APIs let your NMS pull data from cloud platforms (AWS CloudWatch, Azure Monitor), push tickets into ServiceNow, query firewall rules, or feed dashboards. Anything SNMP can't reach — SaaS apps, cloud-native services, containers — gets monitored through API integration. *If a vendor doesn't have an API in 2026, walk away.*

## Helpdesk reality

- User: "The internet is slow." Helpdesk: pull up the monitoring dashboard, check WAN link utilization, check ISP latency probe, check the user's switchport for errors. Three checks in 30 seconds beats an hour of guessing.
- Don't promise "we'll find what's wrong" — promise "we'll look at the logs and call back." Logs sometimes show nothing. Be honest.
- The first question after any outage is "what changed?" Configuration monitoring answers that without anyone having to remember.
- If the SIEM is alerting and you don't understand the alert, escalate to security. Don't acknowledge alerts you can't read — that's how breaches go undetected for 200 days.
- When a vendor asks for logs, send the syslog export with timestamps in UTC. Mixed timezones in a ticket waste everyone's day.

## Related concepts

[[SNMP]] · [[Syslog]] · [[SIEM]] · [[NetFlow]] · [[sFlow]] · [[Packet capture]] · [[Port mirroring]] · [[Wireshark]] · [[Network baselines]] · [[ICMP]] · [[LLDP]] · [[CDP]] · [[Configuration management]] · [[OSI model]] · [[Troubleshooting methodology]]

*Source: VIRGIL knowledge base — 2026-05-11*