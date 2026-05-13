# Unusual User and Account Behaviors

## What it is

In **Battlefield**, you've held the same flag on Operation Metro for twenty minutes. Your squad knows the rotations — sniper holds the escalator, support drops ammo at the kiosk, medic plays the choke. Then "Smith_J" — your support — suddenly stops dropping ammo, sprints alone to B flag, knife-takes three enemies in 1.2 seconds with a pistol, and immediately spawns into the enemy uplink room with admin commands you didn't know existed. That's not Smith. Smith got domain-joined by someone who shouldn't have his login. Behavior changed before the killfeed told you why.

That's exactly what **unusual user and account behaviors** are in a SOC — anomaly signals from identity and authentication telemetry that suggest a legitimate account is now being driven by someone who isn't its owner.

**Technical definition:** Behavior-based [[indicators of compromise]] derived from user account telemetry — authentication logs, privilege use, group membership changes, session metadata — that deviate from established baselines for that account, peer group, or organizational norm. Unlike file-hash or IP-based IoCs, behavior IoCs survive attacker tooling changes because the attacker still has to *act* through the account, and acting differently than the legitimate user is unavoidable.

## Why it matters

Credential theft is the dominant initial access vector in modern intrusions. Verizon DBIR has stuck the number around 80% of breaches involving the human element — phished creds, reused passwords, session token theft, OAuth abuse. Once an attacker has valid credentials, every signature-based control downstream is blind. The firewall sees an authorized login. The VPN logs a successful connect. The EDR sees a user opening their own files. The only place the attack still shows up is in **behavior** — what the account does after it logs in.

This is the heart of [[UEBA]] and the reason every modern SIEM has identity correlation built in. For CySA+ this lands in **Objective 3.2** (incident response activities) and threads into **Objective 1.3** (indicators of malicious activity) and **Objective 4.1** (incident response reporting).

L1 analysts who can tell "Bob is in Lisbon for a conference" from "Bob's account is in Lisbon while Bob is on Slack from Denver" get promoted. Analysts who close every impossible-travel alert as "user is traveling" without checking get incidents named after them.

## Key facts

### The behavior IoC categories CompTIA tests

| Category | What it looks like | Why it matters |
|---|---|---|
| **Unusual privileged account use** | Domain admin logs in at 02:47 from a workstation that's never used DA before | DA accounts should be rare, scoped, predictable. Off-baseline use is high-fidelity. |
| **Privilege escalation events** | Standard user suddenly running as SYSTEM, token impersonation, UAC bypass | Stage 2 of nearly every intrusion. [[MITRE ATT&CK]] TA0004. |
| **Group membership changes** | Account added to Domain Admins, Enterprise Admins, local Administrators | Persistence + escalation in one move. Event ID 4728/4732/4756 on Windows. |
| **Bot-like behavior** | 400 commands in 90 seconds, perfect timing intervals, no typos | Humans are sloppy. Scripts aren't. |
| **Concurrent logins** | Same account active on six hosts in three subnets at once | Pass-the-hash lateral movement or shared credentials — both bad. |
| **Impossible travel** | Login from Denver at 14:02, login from Kyiv at 14:09 | Geo-velocity violation. Token theft or VPN abuse. |
| **Off-hours activity** | Service account active during a maintenance window it's never run during | Attackers prefer quiet hours. So do their schedulers. |
| **Authentication anomalies** | Failed logon spikes (brute force), one success after many fails (spray success), Kerberos pre-auth failures (AS-REP roasting) | Pre-compromise signal. Catch it here and you don't get a compromise. |
| **Dormant account reactivation** | Account silent for 11 months, just authenticated and queried AD | Attackers love forgotten service accounts and ex-employee accounts. |
| **Token / session anomalies** | Same session token from two source IPs, MFA satisfied via unexpected method | Session hijack, AiTM phishing, OAuth consent abuse. |

### Detection sources — where the signal lives

- **Windows Security event log** — 4624 (logon), 4625 (failed logon), 4672 (special privileges assigned), 4728/4732/4756 (group add), 4688 (process creation), 4768/4769 (Kerberos)
- **Azure AD / Entra ID sign-in logs** — risk scoring, conditional access results, MFA method
- **Linux auth.log / wtmp / sudo** — SSH logons, sudo escalations, su attempts
- **VPN concentrator logs** — source geography, session duration, concurrent sessions
- **SaaS audit logs** — Microsoft 365 Unified Audit Log, Google Workspace, Okta, Salesforce
- **[[SIEM]] correlation rules** firing across all the above — single-source detection is fragile, correlation is the job

### The behavior baseline problem

Behavior IoCs require a baseline. Without one, "unusual" is meaningless. Baselines come from three layers:

1. **Per-user history** — hours, hosts, applications, data volume for *this* account.
2. **Peer group** — what other accounts in the same role do. HR analyst on the build server is unusual; DevOps engineer doing the same is Tuesday.
3. **Organizational norms** — holiday schedules, deploy windows, vendor maintenance hours.

[[UEBA]] builds these statistically. Without UEBA, the SOC builds them manually in detection rules — and the rules age badly when org structure changes.

### The legitimate-admin problem

> **CompTIA exam trap:** A scripted PowerShell session running 200 commands in 60 seconds from a domain admin account looks identical to an attacker using [[Mimikatz]] and PsExec for lateral movement. The exam answer is *correlation and context*: known change window? Approved ticket? Source on the admin jumpbox subnet? If yes, automation. If no, incident. Never close on "probably automation" without proving it.

Legitimate automation — SCCM, Ansible, Terraform, scheduled tasks, monitoring agents — behaves exactly like an attacker scripting through your network. Differentiators: **provenance** (approved orchestration host?), **identity** (designated service account, not interactive user?), **schedule** (known recurring window?), **change record** (ticket?). Any missing → suspicious until proven otherwise.

### Mapping into the CompTIA IR lifecycle

**1. Detection and Analysis**
- Pull [[indicators of compromise]] — source IP, user agent, host, timestamps, commands
- Correlate identity logs with endpoint, network, and SaaS telemetry
- **Scope** (accounts and hosts touched), **impact** (what was accessed, what was used)
- **Evidence acquisition** — volatile first (memory, network connections, sessions), then disk via [[write blocker]]
- **Data integrity** — SHA-256 every artifact at collection and again at analysis
- **[[Chain of custody]]** — every transfer logged, signed, timestamped
- **Preservation** — issue [[legal hold]] to suspend log rotation and backup deletion

**2. Containment, Eradication, Recovery**
- **Isolation** — disable the account (don't delete — you lose forensic value), revoke active sessions and refresh tokens, kill VPN, block source IPs
- **[[Compensating controls]]** — if the account can't be disabled (production service account), wrap it in segmentation, conditional access, JIT access, step-up MFA
- **Remediation** — reset credentials, rotate any secrets the account touched, audit group memberships and revert unauthorized changes
- **[[Re-imaging]]** — any host the account logged into interactively during the compromise window. Re-image, don't clean. Attackers leave persistence where you won't look.

**3. Post-incident**
- Root cause: phishing, reuse, token theft, hardcoded password in Git?
- Detection gap: why didn't the *first* anomalous login fire? Tune the rule.
- Lessons learned into the playbook and next tabletop.

> **CompTIA exam trap:** Disabling a compromised account is **containment**, not eradication. Eradication removes attacker persistence — backdoor accounts they created, scheduled tasks, malicious group memberships, OAuth grants. Recovery restores legitimate function. The exam will give you a scenario where the analyst "disables the account and closes the ticket" — wrong. Secondary persistence is still live.

### High-fidelity correlation rules worth memorizing

- **Failed logon spike + successful logon from same source** → password spray success
- **Successful logon + immediate privilege escalation + group change** → classic intrusion sequence
- **Dormant account login + AD recon (LDAP queries, BloodHound-shaped traffic)** → reactivated account being mapped
- **Successful MFA + sign-in from new country + new device** → likely AiTM session theft
- **Service account interactive logon** → service accounts should *never* log in interactively. Always investigate.

## SOC reality

- The 3am alert says "Impossible travel: jsmith@corp — Denver 22:14 MST → Frankfurt 22:38 MST." L1's first move is **not** to call jsmith. It's to check Slack/Teams presence, calendar, recent VPN logs, and user agents on both sessions. Then call him. Half the time it's a corporate VPN exit node in Frankfurt. The other half it's a real incident.
- The CISO's first three questions when privileged-account weirdness escalates: **scope** (how many accounts, how many systems), **impact** (what was accessed, was data exfiltrated), **evidence preserved** (logs locked, legal hold issued, account disabled-not-deleted). Have answers ready or they'll ask louder.
- Never tell leadership "the account is contained" when you've only disabled the user account. *If the attacker created a second account, escalated a service account, or planted a scheduled task, you have not contained anything — you've made them quieter.*
- Handoff: L1 triages and validates with the user. L2 correlates across SIEM and pulls host telemetry. IR team takes over when scope crosses two or more hosts or any privileged account is involved. Legal gets looped the moment PII or regulated data is in scope — they own the breach-notification clock.
- 70% of "unusual behavior" alerts are legitimate weirdness — new hires, expense-report deadlines, a developer running a script for the first time. The 30% that aren't will end your week if you miss them. *Triage tempo matters, but triage tempo without verification is just closing tickets faster than the attacker is opening them.*

## Related concepts

[[UEBA]] · [[indicators of compromise]] · [[MITRE ATT&CK]] · [[SIEM]] · [[chain of custody]] · [[legal hold]] · [[privilege escalation]] · [[lateral movement]] · [[Mimikatz]] · [[Kerberos attacks]] · [[impossible travel]] · [[credential stuffing]] · [[password spraying]] · [[incident response lifecycle]] · [[write blocker]] · [[compensating controls]] · [[re-imaging]] · [[service account hardening]]

*Source: VIRGIL knowledge base — 2026-05-11*