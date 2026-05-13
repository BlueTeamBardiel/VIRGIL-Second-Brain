# Logging & Time Synchronization

## What it is

In **Far Cry 3**, when you climb a radio tower and sync it, the fog lifts off a chunk of the Rook Islands map — outposts, collectibles, side missions, all the relay points snap into view in their correct positions relative to each other. Before the tower sync, you're stumbling through jungle with a compass and a guess. After the sync, every icon on the map agrees on where everything is. That's exactly what logging and time synchronization do for a SOC — without synced clocks and centralized log ingestion, you have a thousand events scattered across a thousand systems, and no way to tell which one happened first.

In plain English: **logging** is every system writing down what it did. **Time synchronization** is every system agreeing on what time it is when it writes. Without both, you cannot reconstruct an incident.

Technical definition (CS0-003 objective 1.1): log ingestion is the centralized collection, normalization, and storage of event data from hosts, network devices, applications, and cloud services into a [[SIEM]] or log aggregation platform. Time synchronization is the use of [[NTP]] (Network Time Protocol, UDP/123) — or its hardened variant [[PTP]] / chrony / w32time — to maintain consistent system clocks across the environment, typically traceable to a stratum-1 reference clock.

## Why it matters

Logs are the oxygen of the SOC. Without them, every other control is theater — your [[EDR]] can detect, your firewall can block, your [[DLP]] can flag, but if none of it lands in a queryable store with consistent timestamps, you cannot investigate, you cannot prove, and you cannot learn. The incident happened; you just can't see it.

Time sync is what turns a pile of logs into a **timeline**. Correlation across systems — "the firewall saw the outbound at 03:14:02, the proxy logged the POST at 03:14:02, the endpoint spawned powershell at 03:14:01" — only works if all three boxes agree on what 03:14 means. Clock drift of even 30 seconds across a large environment shatters causality. You'll argue with yourself about which event triggered which.

Exam relevance: CS0-003 objective 1.1 names log ingestion, logging levels, and time synchronization explicitly under network architecture. CompTIA tests this as a *foundation* — they want you to know that no detection capability matters without it.

## Key facts

### Log ingestion — the three requirements

| Requirement | What it means | Failure mode |
|---|---|---|
| **Centralized** | All logs flow to a single platform ([[SIEM]], data lake, syslog server) | Distributed logs = no correlation, easy for attacker to wipe local evidence |
| **Consistent** | Normalized schema — same field names, same formats, same timezones | Analyst spends investigation time translating fields instead of hunting |
| **Trusted** | Tamper-evident, integrity-protected, write-once where it matters | Attacker clears the Windows Security log; your only copy is gone |

The attacker's first move after gaining a foothold is often **log tampering** — clearing event logs, disabling logging services, modifying the audit policy. If logs only live on the compromised host, you've handed the attacker the eraser. Centralized ingestion (syslog forwarder, [[Sysmon]] → SIEM, Windows Event Forwarding) means the evidence is shipped off the box before they can touch it.

### Logging levels — the volume vs signal tradeoff

Most logging frameworks (syslog, Windows ETW, application loggers) use severity tiers:

| Level | Use | Typical volume |
|---|---|---|
| **DEBUG / Verbose** | Developer troubleshooting | Massive |
| **INFO** | Normal operations, successful events | High |
| **NOTICE / AUDIT** | Security-relevant events (logons, privilege use) | Moderate |
| **WARNING** | Recoverable issues | Low-moderate |
| **ERROR** | Failed operations | Low |
| **CRITICAL / ALERT / EMERGENCY** | System-impacting | Rare |

**Too low** → you have INFO and above only, and you miss the failed logon attempts that would have shown the brute force.
**Too high** → DEBUG everywhere, your SIEM ingestion bill hits seven figures, the analyst drowns, the real signal is buried.

The art is **selective verbosity**: DEBUG on the authentication subsystem during an active hunt, AUDIT on domain controllers always, INFO on the web tier with sampling. CompTIA wants you to know that more logs is not better logs — *tuning beats volume, every time.*

### Time synchronization — the protocols

| Protocol | Port | Accuracy | Use case |
|---|---|---|---|
| **[[NTP]]** | UDP/123 | ~10ms over WAN, ~1ms LAN | General enterprise — default for almost everything |
| **NTS (NTP Secure)** | UDP/123 + TCP/4460 | Same as NTP | NTP with TLS-based authentication — prevents spoofing |
| **[[PTP]] (IEEE 1588)** | UDP/319, 320 | Sub-microsecond | Financial trading, industrial control, telecom |
| **chrony** | UDP/123 | Better than ntpd on intermittent links | Modern Linux default |
| **w32time** | UDP/123 | Adequate for AD | Windows domain — DCs sync from PDC emulator |

**Stratum** is how far you are from a reference clock. Stratum 0 is the atomic clock or GPS source. Stratum 1 syncs directly from it. Stratum 2 syncs from stratum 1. Don't build deep hierarchies — every layer adds drift.

### Architecture — what good looks like

- **Internal NTP servers** (stratum 2) sync from trusted external stratum-1 sources (NIST, pool.ntp.org, GPS appliance)
- **All enterprise hosts** sync from the internal NTP servers — never directly from the internet
- **Domain controllers** anchor authentication time; the PDC emulator is the AD time authority
- **Network devices** (firewalls, switches, routers) sync to the same internal sources as hosts
- **Cloud workloads** sync to the cloud provider's time service (AWS Time Sync, Azure time, GCP) which is itself stratum-1
- **All log timestamps** stored in UTC. Always. Display in local time at the analyst console — store in UTC.

### Windows-specific logging facts

Windows logs live in the Event Viewer, backed by `.evtx` files under `C:\Windows\System32\winevt\Logs\`. Critical channels:

- **Security** — logons (4624 success, 4625 failure), privilege use, object access, account changes
- **System** — service starts/stops, driver loads
- **Application** — app-level events
- **Sysmon** (Microsoft Sysinternals) — process creation (Event ID 1), network connections (3), image loads (7), DNS queries (22). Sysmon is the SOC's force multiplier — Windows native logging without it is half-blind.
- **PowerShell** — Event ID 4103/4104 (script block logging) catches encoded commands the moment they decode.

Audit policy is configured via Group Policy or `auditpol.exe`. The [[Windows Registry]] hive `HKLM\SYSTEM\CurrentControlSet\Services\EventLog` stores log configuration.

### Linux / Unix logging facts

- **syslog / rsyslog / syslog-ng** — the classic. Listens UDP/514 (unencrypted, lossy) or TCP/6514 with TLS (preferred).
- **journald** — systemd's binary logger; query with `journalctl`
- Key files: `/var/log/auth.log` (Debian) or `/var/log/secure` (RHEL) for authentication; `/var/log/messages`; `/var/log/audit/audit.log` for auditd
- Forward with rsyslog `@@host:6514` (TCP+TLS) — never plain `@host:514` over untrusted networks

### Cloud logging facts

- **AWS** — CloudTrail (API actions), CloudWatch Logs (application/system), VPC Flow Logs (network), GuardDuty findings
- **Azure** — Activity Log, Diagnostic Settings, Microsoft Sentinel
- **GCP** — Cloud Audit Logs, VPC Flow Logs

For hybrid environments, the [[CASB]] (Cloud Access Security Broker) often acts as a logging chokepoint for SaaS — pulling API logs from Microsoft 365, Salesforce, Workday into the SIEM. Without the CASB, your SaaS activity is a black box.

### CompTIA exam traps

> **CompTIA exam trap:** NTP runs on **UDP/123**, not TCP. CompTIA will offer TCP/123 as a distractor. Also: NTP is unauthenticated by default — that's why NTS exists. Knowing NTP-the-port is easy; knowing NTP-can-be-spoofed-and-NTS-fixes-it is the deeper test.

> **CompTIA exam trap:** Log retention vs log integrity vs log availability are three different controls. Retention is *how long*. Integrity is *can it be tampered with* (hashing, WORM storage, SIEM-side immutability). Availability is *can the analyst query it*. A question about "ensuring logs aren't modified by an attacker" is asking about integrity — answer with hashing, WORM, or off-host shipping, not retention period.

> **CompTIA exam trap:** "More logging = better security" is wrong. The correct framing is *appropriate logging for the threat model*. CompTIA will offer "enable DEBUG everywhere" as a trap answer — the right answer is risk-based tuning.

> **CompTIA exam trap:** Time sync is a **detective control prerequisite**, not a detective control itself. Questions framing NTP as "detecting attacks" are wrong — NTP enables correlation, which enables detection. Subtle, but tested.

### Logging in a zero trust architecture

[[Zero Trust]] assumes the network is hostile. Every authentication, every authorization decision, every resource access is logged and evaluated. The logging volume in a mature zero trust deployment is an order of magnitude higher than perimeter-based models — every microsegment boundary, every [[SSO]] token issuance, every [[MFA]] challenge, every policy decision point (PDP) lookup produces telemetry. Without ingestion architecture that scales (cloud-native SIEM, data lake tiering, hot/warm/cold storage), zero trust drowns itself in its own logs.

## SOC reality

- The 3am alert is "NTP drift exceeds threshold on the secondary DC" — annoying, but you handle it immediately, because if the DC clock skews, Kerberos starts rejecting tickets (5-minute default skew window) and authentication breaks across the domain. Time sync failures cascade fast.
- The L1 analyst's first move on any new alert is **pivot to the SIEM**, query the source IP / user / host across all log sources for the surrounding 15-minute window. If the timestamps don't align, the L1 can't build the timeline, and the ticket escalates with no narrative — which is the worst kind of escalation.
- The IR lead asks: "Do we have logs? How far back? Are they intact? Did the attacker have time to tamper?" If the answer to any of those is shaky, the investigation is in trouble before it starts.
- Never promise leadership "we have full visibility." You have visibility into what you ingested, retained, and can query. Gaps in coverage (the legacy server nobody onboarded, the SaaS app that wasn't routed through the CASB, the developer's shadow-IT cloud account) are where the incident hides.
- The handoff line: L1 confirms the alert, validates the timeline using synced timestamps, hands to L2 with a coherent narrative. If timestamps disagree, L2 spends the first hour reconciling clocks instead of hunting. *That hour is the attacker's head start.*

## Related concepts

[[SIEM]] · [[NTP]] · [[Sysmon]] · [[EDR]] · [[Log retention]] · [[Chain of custody]] · [[SOAR]] · [[Zero Trust]] · [[CASB]] · [[Windows Registry]] · [[Syslog]] · [[Network segmentation]] · [[Incident Response Lifecycle]] · [[IoC]] · [[MFA]] · [[SSO]]

*Source: VIRGIL knowledge base — 2026-05-11*