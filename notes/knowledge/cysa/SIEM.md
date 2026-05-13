# SIEM — Security Information and Event Management

## What it is

In **Far Cry 3**, every outpost on Rook Island has a tower. Climb it, sync it, and the fog lifts — suddenly you see patrol routes, alarm boxes, sniper nests, the alligator pit, the guy with the flamethrower nobody warned you about. The tower doesn't fight for you. It just *correlates everything in line of sight* and tells you where the danger lives. Without the towers you're knife-fighting in the dark. With them, you're picking targets before they know you're on the island.

That's a SIEM. A **Security Information and Event Management** platform ingests logs from every system on your network — firewalls, endpoints, domain controllers, web proxies, cloud APIs, application logs — normalizes them into a common schema, correlates events across sources, and fires alerts when patterns match a rule. It is the analyst's tower. It does not stop the attack. It tells you the attack is happening and gives you the evidence trail to prove it after.

Technical definition: SIEM is a centralized log aggregation, normalization, correlation, and alerting platform that combines **SIM** (long-term log storage and reporting for compliance) with **SEM** (real-time event monitoring and correlation for detection). Modern SIEMs — Splunk, Sentinel, QRadar, Elastic, Chronicle — add UEBA, SOAR integrations, and threat intel feeds.

## Why it matters

The SIEM is the SOC's primary workspace. CS0-003 Objective 1.1 lists log ingestion and infrastructure concepts under security operations because **you cannot detect what you cannot see, and you cannot investigate what you did not log.** Every domain on this exam — threat hunting, incident response, vulnerability management, reporting — assumes you have a working SIEM and know how to query it.

Career reality: L1 SOC analysts spend 80% of their shift inside the SIEM. Tuning, querying, pivoting on indicators, writing detection rules. If you cannot read a correlation rule and explain why it fired, you are not employable as a SOC analyst. CompTIA tests this conceptually; your future shift lead will test it the first week.

## Key facts

### Architecture and data flow

| Stage | What happens | Tooling |
|---|---|---|
| **Collection** | Logs shipped from sources to the SIEM via agent or syslog | Splunk Universal Forwarder, Winlogbeat, NXLog, syslog-ng |
| **Normalization / parsing** | Raw log lines mapped to common fields (src_ip, user, action, timestamp) | Built-in parsers, custom regex, CIM/ECS schemas |
| **Enrichment** | Add context: GeoIP, threat intel reputation, asset criticality, user role | TI feeds (STIX/TAXII), asset DB lookups |
| **Correlation** | Rules match patterns across multiple events/sources | Sigma rules, KQL, SPL, EQL |
| **Alerting** | Match fires a ticket, email, SOAR playbook | ServiceNow, PagerDuty, XSOAR |
| **Storage / retention** | Hot tier (queryable), warm, cold (compliance archive) | S3, Azure Blob, on-prem indexers |

### Log sources that matter (CySA+ scope)

- **Network architecture sources** — firewalls (allow/deny), routers, switches, IDS/IPS, NetFlow/IPFIX, DNS query logs, web proxy, [[Software-defined networking]] controllers
- **Endpoint sources** — Windows Event Logs (Security, System, Application, Sysmon), Linux auditd/syslog, [[EDR]] telemetry, [[Windows Registry]] modification events
- **Identity sources** — domain controller auth events (4624/4625/4768/4769), [[Identity and access management|IAM]] platforms, [[Single sign-on|SSO]] (Okta, Azure AD), [[Multifactor authentication|MFA]] challenges, [[Privileged access management|PAM]] vaults (CyberArk, BeyondTrust)
- **Cloud sources** — AWS CloudTrail, GCP Audit Logs, Azure Activity Logs, [[CASB|Cloud Access Security Broker]] events, [[SASE|Secure Access Secure Edge]] gateway logs
- **Application sources** — web server access logs, database audit logs, [[DLP|Data Loss Prevention]] hits, custom app logs
- **Security tooling** — vulnerability scanners, sandbox detonations, email security gateway

### Logging levels — what you actually keep

Most platforms use a severity hierarchy descended from syslog:

| Level | Meaning | SIEM treatment |
|---|---|---|
| **DEBUG / TRACE** | Developer noise | Usually dropped at the collector — too expensive to store |
| **INFO** | Routine operations | Kept for context, rarely alerted on |
| **NOTICE** | Worth knowing | Indexed, searchable |
| **WARN** | Something off | Correlation candidate |
| **ERROR** | Failure | Alerts possible |
| **CRITICAL / ALERT / EMERGENCY** | Service down or active compromise | Immediate alert |

The tuning question is always *what level do we ingest from this source*. Take everything DEBUG from every endpoint and your license bill destroys the security budget. Take only ERROR and above and you miss the **failed logons** (level: WARN or INFO depending on platform) that signal a password spray.

### Time synchronization — the unsexy requirement that breaks investigations

Every log source must be synced to the same authoritative time, typically via **NTP** against a stratum-2 internal source or an external pool. Why this matters: a correlation rule like *"failed logon followed by successful logon from same source IP within 5 minutes"* is useless if the firewall is 90 seconds ahead of the domain controller. Forensic timeline reconstruction lives and dies on clock skew under 1 second. **UTC everywhere.** Local time zones in log timestamps are how a 3am incident turns into a 6am argument about whether the alert fired before or after the exfil started.

> **CompTIA exam trap:** Time synchronization is a *security operations* requirement, not just an IT hygiene one. If asked why NTP matters in a SOC context, the answer is **accurate event correlation and forensic admissibility**, not "so the clocks match."

### Correlation rules vs simple alerts

A **simple alert** = one log event matches one condition. *"Any logon to the CFO laptop outside business hours."*

A **correlation rule** = multiple events across sources within a time window. *"100+ failed logons followed by one success from the same source IP within 10 minutes, against accounts in the Finance OU, where the source is not in the corporate ASN."*

The first is noisy. The second catches password spray with low false-positive rate. CySA+ wants you to know correlation is what makes SIEM more than a log search tool.

### Deployment models

| Model | Where it lives | Trade-off |
|---|---|---|
| **On-premises** | Your hardware, your datacenter | Full control, full cost, you patch it |
| **Cloud-native** | Sentinel, Chronicle, Sumo Logic | Elastic scale, vendor handles infra, data leaves your perimeter |
| **Hybrid** | Collectors on-prem, indexers in cloud | Common pattern — most enterprises live here |
| **Managed (MSSP)** | Someone else's SOC reads your alerts | Cheaper headcount, slower context, weaker tribal knowledge |

### What the SIEM cannot do

It cannot block an attack. It cannot patch a vulnerability. It cannot stop a privileged user from running `Remove-Item -Recurse C:\` if that user has rights to do it. The SIEM tells you it happened. Containment lives in [[EDR]], firewalls, [[IAM]], and the human at the console. *A SIEM alert is not a contained host. It is a starting pistol.*

### CompTIA exam traps

> **Exam trap — SIM vs SEM vs SIEM:** SIM = Security Information Management (storage, reporting, compliance). SEM = Security Event Management (real-time correlation, alerting). SIEM = both. If the question asks which platform provides *long-term log retention for PCI audit*, the answer leans SIM/SIEM, not SEM alone.

> **Exam trap — SIEM vs SOAR vs XDR:** SIEM ingests and correlates. **SOAR** (Security Orchestration, Automation, and Response) takes SIEM alerts and runs automated playbooks against them. **XDR** is vendor-integrated detection across endpoint+network+cloud, often replacing parts of a SIEM. CompTIA loves to mix these. If it says *"automatically executes a playbook to isolate the host,"* that's SOAR, not SIEM.

> **Exam trap — log retention drivers:** PCI DSS requires **one year minimum**, with **90 days immediately available**. HIPAA, SOX, and GDPR have their own. The exam will give you a scenario with a regulated dataset (CHD, PII, PHI) and ask the minimum retention. Know PCI's number cold.

### Tuning — the war that never ends

A new SIEM rule starts at maybe 50:1 false positives. Your job is to drag that toward 5:1 without killing true positives. The four levers:

- **Allowlist known-good** — vulnerability scanners, patch servers, jump hosts. Suppress, don't delete.
- **Threshold tuning** — raise the count, widen the window, require a second condition.
- **Asset enrichment** — same alert on a kiosk PC is noise; on a domain controller it's a P1.
- **Kill the rule** — if 6 months in it has never caught a real incident, it's a tax on the analyst queue. Retire it.

*The rule that fires 200 times a shift is the rule the analyst learns to ignore. That is how the real one gets missed.*

## SOC reality

- The 3am alert looks like a Slack ping or a ServiceNow ticket: `[HIGH] Impossible travel - user jdoe - login from Lagos 2 min after login from Dallas`. You open the SIEM, pivot on the user, check VPN logs, check whether the Dallas session is still active, check the [[CASB]] for any cloud app access from Lagos. Decision tree, not panic.
- L1's first action: acknowledge the alert (claim it in the queue so two analysts don't both work it), pull the raw logs, decide *true positive, false positive, benign true positive*, document the verdict. Escalate to L2 if it's TP and scope is unclear.
- The CISO does not ask "did the SIEM fire?" The CISO asks **"what did we see, when did we see it, what did we do about it, and what didn't we see?"** That last one is the killer. Coverage gaps in log ingestion are the question that ends careers.
- Never promise leadership "the SIEM would have caught it." A SIEM only catches what a rule was written to detect against logs that were ingested with correct parsing. Three failure modes, stacked.
- Handoff path: SIEM alert → L1 triage → L2 investigation → IR team if scoped as incident → legal/comms if data involved → executive brief. The SIEM is the source of truth for the entire chain.

## Related concepts

[[Log ingestion]] · [[EDR]] · [[XDR]] · [[SOAR]] · [[UEBA]] · [[Threat intelligence]] · [[Sigma rules]] · [[MITRE ATT&CK]] · [[NetFlow]] · [[Sysmon]] · [[Windows Event Logs]] · [[Time synchronization]] · [[CASB]] · [[SASE]] · [[DLP]] · [[PAM]] · [[IAM]] · [[Incident response lifecycle]] · [[Chain of custody]] · [[Log retention]]

*Source: VIRGIL knowledge base — 2026-05-11*