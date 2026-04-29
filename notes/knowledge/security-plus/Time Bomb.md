---
domain: "malware"
tags: [malware, logic-bomb, time-based-attack, persistence, insider-threat]
---
# Time Bomb

A **time bomb** is a subclass of [[Logic Bomb]] — malicious code embedded within software that activates automatically when a specific **date or time condition** is met. Unlike traditional malware that executes immediately upon infection, time bombs remain completely dormant and often undetected until their **trigger timestamp** is reached, at which point they execute their payload. Time bombs are frequently deployed by [[Insider Threat]] actors or embedded within [[Trojan Horse]] programs and [[Ransomware]] frameworks.

---

## Overview

Time bombs represent one of the oldest and most conceptually straightforward forms of malicious software, yet they remain operationally dangerous precisely because of their patience. The core idea is deferred execution: an attacker plants code that causes no immediate harm, evades behavioral detection during dormancy, and detonates on a schedule of the attacker's choosing. The first well-documented academic treatment of logic bombs — of which time bombs are a derivative — appeared in the 1970s alongside early discussions of computer security, though real-world criminal use became documented in the 1980s and 1990s.

The motivation for using a time bomb rather than an immediately executing payload is multifaceted. First, delayed execution creates temporal distance between the act of planting the bomb and its detonation, making attribution significantly harder. A disgruntled employee who plants a time bomb and then leaves the organization may be far removed from suspicion by the time the payload fires. Second, time bombs can be synchronized for maximum impact — an attacker may choose a date when IT staff are understaffed (holidays, weekends) or when a critical financial event is occurring (quarter-end reporting, a product launch) to maximize damage and minimize rapid response capability.

Time bombs appear in several distinct threat actor categories. Insider threats — particularly employees facing termination or disciplinary action — represent the most historically documented source. The famous 1992 case of Donald Burleson, a programmer who planted a logic/time bomb in his employer's payroll system after being fired, resulted in the deletion of 168,000 commission records and is widely cited as one of the first prosecuted computer sabotage cases in the United States. Nation-state actors and advanced persistent threat (APT) groups also utilize time bombs to synchronize destructive phases of campaigns, as seen in components of the [[Shamoon]] malware that waited until a specific date before overwriting the Master Boot Record on Saudi Aramco workstations in 2012, destroying over 35,000 systems.

A critical operational characteristic of time bombs is that the dormancy period is both their strength and their weakness. During dormancy, the malicious code must reside somewhere in the system — in a binary, a script, a scheduled task, a cron job, or even within legitimate software that has been trojanized. This static presence provides a forensic footprint that defenders can, in principle, detect through code auditing, integrity checking, and behavioral analysis, though doing so before detonation requires proactive threat hunting rather than reactive incident response.

Modern time bombs are often more sophisticated than simple `if datetime.now() == target_date` constructs. They may use encrypted payload retrieval triggered at a certain time, anti-analysis techniques that check for sandbox environments before executing, or multi-condition triggers that combine time with other environmental checks (user logged in, network available, specific process running). This intersection of time-based and condition-based logic blurs the boundary between pure time bombs and the broader [[Logic Bomb]] category.

---

## How It Works

### Conceptual Trigger Mechanism

At their core, time bombs poll or react to system time. The malicious code contains a conditional check against the system clock, a calendar date, or both, and executes a payload when the condition evaluates to true.

```python
# Simplified Python conceptual example — for educational understanding only
import datetime
import os

TARGET_DATE = datetime.date(2025, 1, 1)

def check_trigger():
    today = datetime.date.today()
    if today >= TARGET_DATE:
        detonate()

def detonate():
    # Payload: in a real time bomb this could be data deletion,
    # ransomware encryption, exfiltration, etc.
    os.system("rm -rf /critical/data/")  # Destructive example

check_trigger()
```

### Delivery Vectors

Time bombs are delivered through multiple mechanisms:

1. **Trojanized software**: Legitimate-looking software with an embedded malicious routine hidden within its codebase. The installer or application binary executes normally until the trigger date.
2. **Insider implantation**: A privileged user (developer, sysadmin) directly embeds the code into production systems, build pipelines, or backup scripts.
3. **Supply chain compromise**: A dependency or library used by a software project contains the time bomb — when the software is built and deployed, the bomb travels with it.
4. **Macro-embedded documents**: Office documents containing [[VBA Macro]] code that checks the date on open.

### Scheduling Mechanisms Used

Time bombs leverage legitimate OS scheduling infrastructure as persistence mechanisms:

**Windows — Scheduled Tasks:**
```powershell
# Attacker creates a task that runs on a specific date
schtasks /create /tn "SystemMaintenance" /tr "C:\Windows\Temp\payload.bat" /sc once /sd 01/01/2026 /st 02:00 /ru SYSTEM
```

**Linux — Cron Jobs:**
```bash
# Entry in crontab designed to trigger on a specific date
0 2 1 1 * /usr/local/bin/.sysupdate > /dev/null 2>&1
# Fires at 02:00 on January 1st every year
# Attacker may remove after first execution or embed kill-switch
```

**Linux — at command (one-time execution):**
```bash
echo "/usr/local/bin/payload.sh" | at 02:00 01/01/2026
```

**Windows Registry Run Key with Date Check:**
```bat
@echo off
:: Embedded in a batch file called from a Run key
for /f "tokens=2 delims==" %%a in ('wmic os get LocalDateTime /value') do set dt=%%a
set YYYY=%dt:~0,4%
set MM=%dt:~4,2%
set DD=%dt:~6,2%
if "%YYYY%%MM%%DD%"=="20260101" (
    start /b payload.exe
)
```

### Multi-Stage Time Bomb Pattern

Advanced time bombs operate in phases:

```
Phase 1: DELIVERY
  └─ Malicious code embedded in legitimate software/script
  └─ Persists silently — no network traffic, no observable behavior

Phase 2: DORMANCY
  └─ Periodic time-check loop (may run at login, via cron, via task)
  └─ Anti-analysis: checks for sandbox/VM indicators, aborts if detected
  └─ Optionally: polls C2 server for "go" signal combined with time check

Phase 3: TRIGGER EVALUATION
  └─ system_time >= TARGET_DATE  →  TRUE
  └─ May include secondary checks: user_logged_in, network_available

Phase 4: DETONATION
  └─ Payload executes: data destruction, encryption, exfiltration, backdoor activation
  └─ May attempt to delete itself and logs to hinder forensics
```

### C/C++ Low-Level Implementation Pattern

```c
#include <time.h>
#include <stdio.h>

void detonate() {
    // Payload execution would be here
    system("cipher /w:C:\\"); // Windows data overwrite (educational example)
}

int main() {
    time_t now = time(NULL);
    struct tm *t = localtime(&now);

    // Trigger: January 1, 2026
    if ((t->tm_year + 1900) == 2026 &&
        (t->tm_mon + 1) == 1 &&
        t->tm_mday == 1) {
        detonate();
    }
    // Otherwise: execute normally, appear benign
    return 0;
}
```

### Anti-Forensic Techniques

- **Obfuscated trigger date**: The target date is XOR-encoded or base64-encoded within the binary, making static analysis harder.
- **Log wiping**: Payload includes deletion of Windows Event Logs (`wevtutil cl System`) or Linux syslog rotation/deletion.
- **Self-deletion**: Script deletes itself post-execution.
- **Time tampering awareness**: Some bombs include checks to verify the system time hasn't been artificially advanced (defender countermeasure bypassed by comparing against a remote NTP source).

---

## Key Concepts

- **Trigger Condition**: The specific date, time, or timestamp that activates the time bomb. Can be an exact moment (`2026-01-01 02:00:00`) or a threshold (`any date after 2026-01-01`). Distinguishes time bombs from other [[Logic Bomb]] variants which use non-temporal conditions.

- **Dormancy Period**: The interval between implantation and detonation during which the malicious code is present but inactive. Extended dormancy is intentional — it separates the attacker from the event in time and defeats simple behavioral detection tools that look for immediately malicious actions.

- **Payload**: The malicious action executed upon trigger. Common time bomb payloads include mass file deletion, [[Ransomware]] encryption initiation, data exfiltration, [[Denial of Service]] against internal resources, or activation of a previously planted [[Backdoor]].

- **Dead Man's Switch Variant**: A reversed time bomb that fires if a specific action is *not* taken by a deadline — for example, code that destroys data unless an operator enters a key every 30 days. Used by both attackers (as coercion tools) and occasionally in legitimate contexts (canary tokens, timed access revocation).

- **Persistence Mechanism**: The method by which the time bomb survives reboots and normal system operations until its trigger date. Common mechanisms include [[Windows Scheduled Tasks]], [[Cron Jobs]], registry Run/RunOnce keys, service installations, and bootkit-level hooks for the most sophisticated variants.

- **Supply Chain Time Bomb**: A specific variant where the time bomb is embedded within a third-party software component, library, or package that is incorporated into a target organization's software build — the attack exploits the [[Software Supply Chain]] rather than direct access to target systems.

- **Coordinated Multi-Node Detonation**: Advanced attacks deploy time bombs across many systems simultaneously with synchronized trigger dates, ensuring that when the payload fires, the breadth of damage exceeds any single team's ability to respond quickly — as observed in the Shamoon attack.

---

## Exam Relevance

**Security+ SY0-701 Domain Mapping**: Time bombs appear under **Domain 2.0 — Threats, Vulnerabilities, and Mitigations**, specifically in the context of malware types and [[Indicators of Compromise]] (IoCs).

**Key exam facts to memorize:**
- Time bombs are a *subtype* of **logic bombs** — the differentiating factor is that the trigger condition is **time-based** (date/time) rather than a general logical condition.
- The exam frequently tests the **distinction between logic bomb, time bomb, and Trojan** — remember that a time bomb is about *when*, a logic bomb is about *if*, and a Trojan is about *disguise*. A real-world time bomb is often delivered as a Trojan (the delivery mechanism is separate from the trigger type).
- **Insider threat** is the most commonly tested deployment scenario for time bombs on the Security+ exam.
- Time bombs are classified under **non-replicating malware** — they do not self-propagate like [[Worm]] or [[Virus]] malware.

**Common question patterns:**
- *"A disgruntled employee plants code that deletes the database on their last day of employment. What type of malware is this?"* → **Logic bomb** (or time bomb if a specific date was set). The exam may accept either — read carefully for whether a specific date is mentioned.
- *"Which malware type remains dormant until a specific date?"* → **Time bomb**.
- *"Which control best prevents insider logic/time bomb attacks?"* → **Separation of duties**, **code review**, and **least privilege**.

**Gotchas:**
- Do not confuse time bombs with **ransomware countdown timers** — those are social engineering pressure tactics, not the trigger mechanism itself.
- The exam may use "logic bomb" as the umbrella term and expect you to recognize time bombs as a subset — both answers may be technically defensible.
- Time bombs are **not** classified as [[Rootkit]] unless they specifically manipulate kernel-level functions for hiding.

---

## Security Implications

### Attack Surface

Time bombs exploit **trust** — trust in software, trust in employees, trust in code review processes. The attack surface includes:
- **Internal development environments**: Build servers, CI/CD pipelines, source control systems where privileged developers can inject code.
- **Third-party software**: Any external dependency can theoretically harbor a supply-chain time bomb.
- **Backup systems**: Dormant malicious code in backups may survive remediation and reactivate when backups are restored.

### Real-World Incidents

**Donald Burleson (1992)**: Considered the first criminally prosecuted time/logic bomb case in the US. After being fired from USPA & IRA Co. in Fort Worth, Texas, Burleson activated pre-planted code that deleted 168,000 commission records. He was convicted under the Texas computer crime statute.

**Siemens Logic Bomb (2006)**: Timothy Lloyd, a network administrator for Omega Engineering (a Siemens contractor), planted a logic/time bomb that deleted all manufacturing software 20 days after his termination, causing $10 million in damages. This case established important legal precedent for computer fraud prosecution of insider threat actors.

**Shamoon/DistTrack (2012)**: The malware contained a time-triggered wiper component (`wiper.exe`) set to activate on a specific date. It overwrote the [[Master Boot Record]] and files on infected systems. Attributed to Iranian threat actors. Destroyed approximately 35,000 Saudi Aramco workstations. CVE reference: the malware family is tracked without a single CVE due to its nature as a custom APT tool rather than a vulnerability exploit.

**Shamoon 2 (2016–2017)**: A resurgence of similar time-triggered wiper functionality, again targeting Saudi Arabian organizations, demonstrating that time-bomb-based destructive attacks remain a relevant nation-state tactic.

### Detection Challenges

- **Static analysis evasion**: The malicious routine may be small, obfuscated, and embedded within thousands of lines of legitimate code.
- **Behavioral analysis blindspot**: Since no malicious behavior occurs during dormancy, sandbox detonation testing that runs samples for minutes or hours will not trigger a bomb set for months in the future (though sandboxes can manipulate system clocks).
- **Signature evasion**: Without network activity or file system changes during dormancy, traditional [[Antivirus]] and [[Intrusion Detection System]] tools have minimal to detect.

---

## Defensive Measures

### Code Review and Software Assurance

- **Mandatory peer code review**: All code committed to production repositories should require at least one independent reviewer. Pay particular attention to date/time API calls, scheduled task creation, and conditional execution blocks.
- **Static Application Security Testing (SAST)**: Tools like **Semgrep**, **SonarQube**, and **Checkmarx** can be configured with custom rules to flag suspicious date-comparison patterns combined with system execution calls.
- **Software Composition Analysis (SCA)**: Tools like **Snyk**, **OWASP Dependency-Check**, and **Black Duck** audit third-party dependencies for known malicious or tampered components.

### Integrity Monitoring

- **File Integrity Monitoring (FIM)**: Deploy tools such as **Tripwire**, **OSSEC**, or **Wazuh** to detect unauthorized modifications to scripts, binaries, cron tabs, and scheduled task configurations.
- **Scheduled task auditing**:
```powershell
# Enumerate all scheduled tasks and their actions — review for anomalies
Get-ScheduledTask | Select-Object TaskName, TaskPath, State |
  Where-Object {$_.State -ne "Disabled"} | Format-List

# Export full task XML for review
Export-ScheduledTask -TaskName "SuspiciousTask" | Out-File C:\Audit\task_review.xml
```
- **Linux cron monitoring**:
```bash
# List all system and user cron entries
for user in $(cut -d: -f1 /etc/passwd); do
    crontab -l -u $user 2>/dev/null | sed "s/^/$user: /"
done
# Also check