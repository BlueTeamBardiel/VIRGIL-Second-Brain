```markdown
---
domain: "threats"
tags: [malware, logic-bomb, insider-threat, attack, persistence, security-plus]
---
# Logic bomb

A **logic bomb** is malicious code embedded within a legitimate program or system that remains **dormant** until a specific **trigger condition** is met, at which point it executes a harmful payload. Unlike self-propagating threats such as [[Worm|worms]] or [[Virus|viruses]], a logic bomb is typically a *targeted* and *stationary* piece of sabotage, most often associated with [[Insider Threat|insider threats]] and disgruntled employees with privileged access to the code or infrastructure they later betray. The damage potential is disproportionate to the code's size — a six-line condition in a trusted script can destroy years of production data in seconds.

---

## Overview

A logic bomb is one of the oldest classes of malicious code, predating networked malware by decades. It exploits the most fundamental property of software — conditional execution — by hiding a destructive branch behind an `if` statement that the author hopes no reviewer will ever examine closely. The payload may delete files, corrupt databases, exfiltrate credentials, disable accounts, encrypt storage, or crash critical services. Because the code lies inert for weeks, months, or even years, logic bombs routinely evade signature-based [[Antivirus]] detection and survive routine code audits, especially in large legacy codebases.

The defining characteristic is the **trigger**, not the payload. Triggers fall into two broad families: **time-based** (a specific date, a countdown, or an elapsed interval) and **event-based** (a user being removed from a payroll file, a file reaching a certain size, a database row count crossing a threshold, or the absence of a periodic "I am still employed" heartbeat check). Time-triggered logic bombs are commonly called **time bombs**, and their cousins embedded deliberately inside operating systems or cryptographic products as backdoors are occasionally termed **logic traps**.

Logic bombs are overwhelmingly an **insider problem**. The person best positioned to plant one is a trusted developer, systems administrator, or database administrator — someone with legitimate write access to production code and the knowledge to hide the trigger in a plausible location. This is why logic bombs feature prominently in sabotage cases prosecuted under the U.S. Computer Fraud and Abuse Act (18 U.S.C. § 1030) and equivalent laws worldwide. They also appear as components of multi-stage **supply chain attacks**, where a compromised library ships a dormant payload to every downstream consumer.

Historically significant cases include **Tim Lloyd's 1996 attack on Omega Engineering**, which destroyed all manufacturing programs on the company's Novell servers after his termination at an estimated cost of $10 million; **Roger Duronio's 2002 logic bomb at UBS PaineWebber**, which wiped files on approximately 2,000 servers and earned him a 97-month sentence; **Michael Lauffenburger's 1991 attempt at General Dynamics** to delete Atlas rocket component data; and the **2013 DarkSeoul wiper** against South Korean banks and broadcasters, whose detonation was triggered by an embedded hardcoded timestamp. These cases define both the legal precedent and the mental model defenders must internalize: logic bombs are planned in advance, often well before any visible workplace conflict, and they routinely survive termination by design.

Logic bombs are explicitly enumerated in the **CompTIA Security+ SY0-701** exam objectives under malware types, and they are a canonical example in discussions of [[Code Review]], [[Separation of Duties]], and [[Version Control]] as compensating controls.

---

## How It Works

A logic bomb consists of three conceptual components: a **trigger**, a **guard** (stealth logic that keeps the code hidden from casual inspection), and a **payload**. The implementation may live in source code, a compiled binary, an interpreted script, a database trigger, a stored procedure, a scheduled task, or even firmware. The bomb's author leverages detailed insider knowledge to choose a hiding spot — an error-handling branch, a rarely audited utility script, a stored procedure they alone maintain — where the conditional will not attract scrutiny.

**Trigger Evaluation**

Trigger evaluation happens every time the host program runs or on every relevant event. The trigger is almost always computationally cheap so it does not degrade performance and draw attention. Typical trigger expressions:

```python
# Time-based trigger
import datetime
if datetime.date.today() >= datetime.date(2025, 12, 25):
    detonate()

# Event-based trigger: attacker's username no longer in HR payroll file
with open("/etc/payroll/active_employees.txt") as f:
    if "jsmith" not in f.read():
        detonate()

# Counter-based trigger: Nth invocation of the function
import os, pickle
STATE = "/var/lib/app/.counter"
n = pickle.load(open(STATE, "rb")) if os.path.exists(STATE) else 0
n += 1
pickle.dump(n, open(STATE, "wb"))
if n == 10_000:
    detonate()
```

**Database-Resident Logic Bombs**

Database-resident logic bombs are especially hard to spot because they execute inside the DBMS, leave few host-side artifacts, and blend with legitimate triggers used for auditing and referential integrity:

```sql
CREATE OR REPLACE TRIGGER audit_cleanup
AFTER INSERT ON payroll.employees
FOR EACH ROW
BEGIN
  IF (SELECT COUNT(*) FROM payroll.employees
      WHERE username = 'jsmith') = 0 THEN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE finance.general_ledger';
  END IF;
END;
```

**Guard Logic (Stealth)**

Guard logic disguises the payload from reviewers. Common techniques include:
- Encoding the trigger date as an integer comparison against raw `time()` seconds rather than a human-readable string
- Splitting the condition across multiple helper functions so no single diff reveals intent
- Hiding the payload in a rarely-executed exception handler or fallback code path
- Placing it inside a module the attacker exclusively "owns," reducing the chance of peer review
- Encrypting or encoding the payload string and decrypting it only at trigger time

A logic bomb in a build script or CI/CD pipeline can also mutate compiled artifacts between source and release, leaving the repository entirely clean to static inspection.

**Payload Execution**

Payload execution is arbitrary code, limited only by the privileges of the host process. On Unix, a typical file-destruction payload:

```bash
find / -xdev \( -name "*.dbf" -o -name "*.sql" -o -name "*.bak" \) -exec shred -u {} \;
dd if=/dev/urandom of=/dev/sda bs=1M status=none &
vssadmin delete shadows /all /quiet   # if running on a Wine/compatibility layer
```

On Windows, attackers have historically leveraged scheduled tasks, `at.exe`, WMI permanent event subscriptions, or registry Run keys to persist the trigger mechanism:

```powershell
# Planting a logic-bomb scheduled task disguised as a maintenance job
Register-ScheduledTask -TaskName "SystemHealthCheck" `
  -Trigger (New-ScheduledTaskTrigger -Daily -At 3:00AM) `
  -Action (New-ScheduledTaskAction -Execute "powershell.exe" `
           -Argument "-WindowStyle Hidden -NonInteractive -File C:\ProgramData\chk.ps1") `
  -RunLevel Highest
```

**Why Traditional Defenses Fail**

Network behavior during dormancy is absent. Unlike a [[Trojan]] or [[RAT]], a logic bomb does not need to beacon home, does not need command-and-control infrastructure, and may never open a socket at all until detonation. This is precisely what makes it invisible to [[IDS IPS|network intrusion detection systems]] during its dormant phase. Detection must therefore shift to **code**, **configuration state**, and **behavioral host telemetry** gathered by [[EDR]] agents.

---

## Key Concepts

- **Trigger condition** — The boolean predicate that decides when dormant code activates. Time, event, counter, environmental state (a file's existence, a user account's presence), or the *absence* of a condition can all serve as triggers, and multiple conditions can be combined with AND/OR logic.
- **Payload** — The destructive or malicious action carried out upon detonation. Ranges from data deletion and MBR overwrite to ransomware key release, credential exfiltration, and network service disruption.
- **Time bomb** — A logic bomb whose trigger is purely temporal — a specific calendar date, elapsed time since installation, or a countdown. All time bombs are logic bombs; not all logic bombs are time bombs. Security+ treats time bomb as a strict subset.
- **Dead-man switch variant** — A logic bomb that detonates when a recurring condition *stops* occurring — classically when the attacker's user account is removed or they stop resetting a heartbeat counter. This is the canonical insider-sabotage design: "if I am ever fired, the payload fires automatically."
- **Insider threat** — A trusted party abusing authorized access to plant or enable an attack. Logic bombs are the archetypal insider-threat malware because they exploit legitimate write access to trusted code rather than any external vulnerability.
- **Dormancy period** — The interval between planting and detonation. Long dormancy defeats signature scanning and audit sampling, but it also creates windows of opportunity for discovery via code review, personnel change audits, or accidental stumbling upon the code.
- **Supply chain logic bomb** — A logic bomb embedded in a third-party library, firmware image, or vendor update that propagates to every downstream installation. The xz-utils backdoor (CVE-2024-3094) exhibited trigger-gated activation logic at internet scale, blurring the line between logic bomb and supply-chain backdoor.
- **Separation of duties** — The administrative control of splitting code authorship, peer review, and production deployment across different individuals so no single actor can both plant and release a logic bomb unreviewed.

---

## Exam Relevance

On the **CompTIA Security+ SY0-701**, logic bombs appear in **Domain 2.4 — Given a scenario, analyze indicators of malicious activity** under the malware types enumeration. Expect the following question patterns and traps:

**Discrimination questions.** The exam will describe a scenario and ask you to identify the malware type. Logic bomb keywords to recognize:
- *"triggered by a specific date"*
- *"when the employee's account was removed"*
- *"after the developer was terminated, files were deleted"*
- *"remained dormant until…"*
- *"planted by a disgruntled employee"*

If the scenario emphasizes **propagation** to other hosts → worm/virus. If it emphasizes **disguise as legitimate software with a remote payload** → Trojan. If it emphasizes **conditional activation** tied to an internal state → logic bomb.

**Time bomb vs. logic bomb.** Security+ treats time bomb as a *subset* of logic bomb. If both appear as answer choices and the trigger is date-based, "logic bomb" is typically still correct unless the question is specifically asking you to name the subtype.

**Defensive control mapping.** The exam expects you to know that the primary preventive controls are **administrative** (separation of duties, mandatory code review, change management, immediate access revocation) rather than purely technical (antivirus, firewall). AV is largely ineffective against dormant logic bombs during the dormancy phase.

**Gotcha — persistence vs. trigger.** A scheduled task that launches malware on every boot is **persistence**, not a logic bomb. A logic bomb requires a *specific condition* beyond "the system started." Without a conditional payload trigger, it is simply a persistence mechanism.

**Gotcha — delayed ransomware.** Ransomware with a built-in delay before encrypting is still **ransomware** as the primary classification. The exam cares about the dominant purpose (encryption for extortion) over the triggering mechanism.

**Mitigation answer pattern.** When asked "what control BEST prevents logic bomb attacks by insiders?", the expected answer is typically **separation of duties** or **mandatory code review**, not antivirus or IDS.

---

## Security Implications

Logic bombs primarily threaten **integrity** and **availability**; they can simultaneously threaten **confidentiality** when the payload exfiltrates data prior to wiping or encrypting it. Because the trigger evaluates in-process, the payload runs with the full privileges of the host application — a logic bomb embedded in a privileged database scheduled job executes as the DBMS service account; one embedded in a firmware update utility runs at ring 0.

**Notable Incidents**

- **United States v. Tim Lloyd (Omega Engineering, 1996–2000)** — A six-line logic bomb in a Novell NetWare login script deleted all manufacturing CAD/CAM programs upon the first login after July 31, 1996. Estimated loss: $10 million. Lloyd sentenced to 41 months in federal prison.
- **United States v. Roger Duronio (UBS PaineWebber, 2002)** — A Unix shell logic bomb detonated on March 4, 2002 across approximately 2,000 servers, cascading through the company's trading floor infrastructure during market open. Sentence: 97 months and $3.1 million restitution.
- **Fannie Mae near-miss (Rajendrasinh Makwana, 2008)** — A scheduled logic bomb was planted hours after termination and discovered by another engineer days before its January 31, 2009 detonation; it would have destroyed data on approximately 4,000 servers. Makwana was sentenced to 41 months.
- **DarkSeoul / Jokra wiper (2013)** — Wiper malware against South Korean banks and broadcasters embedded hardcoded detonation timestamps; date-triggered mass MBR destruction took down multiple financial institutions simultaneously.
- **United States v. David Tinley (Siemens contractor, 2019)** — Contractor planted logic bombs in spreadsheet automation software to guarantee repeat service calls. Pled guilty to intentional damage under 18 U.S.C. § 1030.
- **xz-utils backdoor (CVE-2024-3094)** — Malicious code injected into a widely-used compression library by a long-term social engineering operation. The backdoor included trigger-gated activation conditions, demonstrating logic-bomb design patterns deployed at supply-chain scale.

**Detection Challenges**

Post-detonation forensic indicators include: unexpected scheduled tasks or cron jobs not matching change management records, database triggers absent from version control baselines, shell scripts containing date arithmetic against far-future Unix epoch timestamps, sudden mass file deletion or MBR overwrite events in [[EDR]] telemetry, and VCS commit history anomalies (a developer's last commit before termination introducing large unrelated changes). During dormancy, host-level behavioral anomalies are essentially absent, making **proactive code and configuration auditing** the only reliable pre-detonation detection path.

---

## Defensive Measures

Effective defense layers **administrative**, **technical**, and **procedural** controls, because no single technology stops a knowledgeable insider writing malicious logic into trusted code.

**Administrative and Process Controls**
- **Mandatory peer code review** for all changes to production systems, enforced at the VCS level via branch protection rules (GitHub, GitLab, Gerrit). No self-approved merges to `main` or `production`. This is the single highest-ROI control against logic bombs.
- **Separation of duties**: the developer who writes code must not be the one who deploys it; the DBA who authors a trigger must not be the one who audits production triggers.
- **Immediate credential and access revocation on termination**, followed by a targeted code and scheduled-task audit of everything touched by the departing employee in the prior 6–12 months. HR and IT coordination is essential; the audit should ideally begin before the employee is notified of termination.
- **Change management with audit trails**: every production deployment must reference an approved change ticket, correlate to a specific commit, and be authorized by someone other than the implementer.

**Technical Controls**
- **Signed commits** (`git commit -S`, Gitsign, Sigstore Cosign) and immutable audit logs ensure that every production line of code traces to an authenticated author.
- **File integrity monitoring** (AIDE, Tripwire, [[Wazuh]] FIM) on production binaries, crontabs, systemd unit files, scheduled tasks, and database trigger definitions. Baseline deviations alert immediately.
- **Behavioral [[EDR]]** (CrowdStrike Falcon, SentinelOne, Microsoft Defender for Endpoint, Elastic Defend) to catch detonation-phase behaviors: mass file deletion, `shred`/`sdelete` execution, `vssadmin delete shadows`, `wevtutil cl`, and similar destructive patterns — even when the triggering process is an otherwise legitimate binary