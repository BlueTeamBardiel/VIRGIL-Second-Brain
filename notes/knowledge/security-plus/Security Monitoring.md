# Security Monitoring

## What it is

In World of Warcraft, your raid lead has DBM (Deadly Boss Mods) screaming when Patchwerk's Hateful Strike is incoming, Recount tracking who's slacking on DPS, and the combat log auditing every spell cast so the warlock can't blame the healer when he stands in fire. That's exactly what security monitoring does — it watches everything happening on your systems and yells when something that shouldn't be happening starts happening.

**Security monitoring** is the continuous collection, aggregation, and analysis of activity data from systems, applications, infrastructure, and users to detect, investigate, and respond to security events.

## Why it matters

Without monitoring, attackers dwell inside networks for an average of weeks before discovery — long enough to exfiltrate everything worth taking and pivot through your environment uncontested. SY0-701 Objective 4.4 explicitly demands you "explain security alerting and monitoring concepts and tools," covering monitoring computing resources, activities (log aggregation, alerting, scanning, reporting, archiving, alert response/remediation, validation, quarantine, alert tuning), and tools (SCAP, benchmarks, agents/agentless, SIEM, antivirus, DLP, SNMP traps, NetFlow, vulnerability scanners).

CompTIA's favorite trap: confusing **alert tuning** (reducing false positives) with **alert response** (actually doing something about a real alert), and confusing **agent-based** (software installed on endpoint, deeper visibility, maintenance overhead) with **agentless** (no install, lighter, but limited depth).

## Key facts

### What gets monitored

| Target | What you watch |
|---|---|
| **Systems** | OS logs, process execution, file integrity, patch state |
| **Applications** | Auth attempts, transaction errors, API calls |
| **Infrastructure** | Routers, switches, firewalls, hypervisors, cloud control planes |

### Monitoring activities (memorize this list — exam gold)

- **[[Log aggregation]]** — pulling logs from many sources into one searchable place. Without it, you're alt-tabbing through 400 servers.
- **[[Alerting]]** — automated notification when a rule or threshold trips.
- **[[Scanning]]** — proactive checks (vulnerability, configuration, malware).
- **[[Reporting]]** — periodic summaries for compliance and management.
- **[[Archiving]]** — long-term log retention for forensics and regulatory mandates (often 1–7 years).
- **[[Alert response and remediation]]** — quarantine, block, isolate, patch.
- **[[Alert validation]]** — is this a true positive or noise?
- **[[Quarantine]]** — isolating the infected host so it stops biting other hosts.
- **[[Alert tuning]]** — adjusting rules to cut false positives without missing real threats.

### Tools (Objective 4.4 explicit list)

| Tool | Purpose |
|---|---|
| **[[SIEM]]** (Security Information and Event Management) | Central log aggregation, correlation, alerting, dashboards. Splunk, QRadar, Sentinel. |
| **[[SCAP]]** (Security Content Automation Protocol) | NIST standard for expressing security configuration in machine-readable form. |
| **[[Benchmarks]]** | CIS Benchmarks, DISA STIGs — known-good configuration baselines. |
| **[[Agents]]** | Software on the endpoint reporting back. Deep visibility. |
| **[[Agentless]]** | Remote scanning, no install. Less depth, less hassle. |
| **[[Antivirus]]** | Signature- and heuristic-based malware detection. |
| **[[DLP]]** (Data Loss Prevention) | Detects/blocks sensitive data leaving the network. |
| **[[SNMP traps]]** | Devices push alerts to a manager when thresholds break. UDP **162**. |
| **[[NetFlow]]** | Traffic flow records (who talked to whom, how much, how long) — not packet contents. |
| **[[Vulnerability scanners]]** | Nessus, Qualys, OpenVAS — find missing patches and misconfigs. |

### Agent vs. agentless

| | Agent-based | Agentless |
|---|---|---|
| Install footprint | Yes | No |
| Visibility depth | High (process, memory, file) | Lower (network-observable only) |
| Maintenance | Update agents constantly | Minimal |
| Offline coverage | Yes (caches, syncs later) | No |

### Alert tuning lifecycle

1. Deploy rule → 2. Drown in alerts → 3. Identify false positives → 4. Refine thresholds, exclusions, correlation logic → 5. Re-baseline → 6. Repeat forever.

A SIEM with untuned rules is just an expensive noise machine. A SIEM with over-tuned rules is an expensive way to miss the breach.

### Common log sources

- **[[Syslog]]** — UDP/TCP **514**, TLS **6514**
- **[[Windows Event Log]]** — Security, System, Application, Setup
- **[[Firewall logs]]**, **[[IDS/IPS logs]]**, **[[Proxy logs]]**, **[[DNS logs]]**, **[[Authentication logs]]**

### What breaks without it

- Breach dwell time measured in months
- Compliance failure: PCI DSS Req. 10, HIPAA, SOX all mandate monitoring and log review
- No forensic timeline when you need to answer "when did they get in?"
- Insider threats walk out the door with the data

## Related concepts

[[SIEM]] · [[Log aggregation]] · [[NetFlow]] · [[SCAP]] · [[Vulnerability scanning]] · [[Incident response]] · [[SOAR]] · [[EDR]] · [[Continuous monitoring]] · [[Alert tuning]]

---
*Source: VIRGIL knowledge base — 2026-05-08*