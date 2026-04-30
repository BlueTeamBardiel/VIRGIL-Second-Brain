# Blue Team Operations — Defending in Practice
> The red team finds the hole. The blue team has to be right every single time.

---

## Teams and Roles

### Red vs Blue vs Purple

| Team | Role | Focus | Mindset |
|---|---|---|---|
| **Red Team** | Offensive — simulate attackers | Find vulnerabilities before attackers do | "How do I get in?" |
| **Blue Team** | Defensive — detect and respond | Monitor, detect, contain, recover | "How do I catch them?" |
| **Purple Team** | Collaborative — red attacks while blue tunes | Improve detection coverage together | "How do we get better together?" |

**Purple teaming is underrated:** Red team finds a technique. Blue team says "that triggered nothing." They work together to write detection for it. Repeat. Coverage improves faster than with separate teams.

**Pentest vs Red Team:**
- **Pentest:** "Find all the vulnerabilities in this scope" — point-in-time assessment, deliverable is a report
- **Red Team:** "Simulate APT TTP X against us and see if we detect it" — ongoing, tests people/process/technology

---

## SOC Structure

### Tier System

**L1 — Alert Triage**
- Monitor SIEM/EDR dashboards
- Triage incoming alerts: true positive or false positive?
- Follow runbooks for common alert types
- Escalate to L2 if suspicious
- Skills needed: SIEM basics (Splunk/Elastic), alert prioritization, basic Windows/Linux, network fundamentals

**L2 — Investigation**
- Take escalated L1 cases
- Full incident investigation: scope, timeline, root cause
- Threat hunting queries
- Write incident reports
- Skills needed: Everything L1 + malware analysis, log correlation, scripting

**L3 — Threat Hunting / IR / Engineering**
- Proactive threat hunting (not waiting for alerts)
- Incident response for major breaches
- Detection engineering: write new detection rules
- Tooling improvements, red/purple team collaboration
- Skills needed: Everything L2 + advanced forensics, reverse engineering, detection engineering

---

## Alert Fatigue — The SOC Killer

**The problem:** The average SOC receives thousands of alerts per day. Most are false positives. Analysts tune out. Critical alerts get missed.

**Why it happens:**
- Overly broad detection rules (too many things trigger them)
- No baseline of "normal" — can't tell signal from noise
- No prioritization — all alerts treated equally
- No automation for obvious false positives

**How to fight it:**
1. **Tune aggressively:** Any rule with >95% false positive rate needs to be refined or killed
2. **Build baselines:** What does normal authentication traffic look like? Alert on deviation.
3. **Enrich automatically:** Auto-resolve known-good processes, internal IPs, approved tools
4. **Prioritize with context:** Asset criticality + threat intel → alert score
5. **Automate L1 triage:** SOAR playbooks for common alert types

**The metric that matters:** Mean time to detect *true* positives, not volume of alerts handled.

---

## Threat Hunting

Threat hunting is proactive search for threats that evaded detection. Not waiting for alerts — going looking.

### Hypothesis-Driven Hunting
Start with a hypothesis about attacker behavior:
> "APT28 uses scheduled tasks for persistence. Do we have any scheduled tasks created by non-standard accounts in the last 30 days?"

```splunk
index=windows EventCode=4698
| where NOT user IN ("SYSTEM","LOCAL SERVICE","NETWORK SERVICE")
| stats count by user, host, TaskName
| sort -count
```

### IOC-Driven Hunting
Start with known bad indicators from threat intel:
> "This CVE was published last week. Have any of our systems made HTTP requests to these newly published C2 domains?"

```splunk
index=proxy 
| lookup threat_intel_domains domain AS url_domain OUTPUT threat_category
| where isnotnull(threat_category)
```

### Anomaly-Based Hunting
Find statistical outliers without a specific hypothesis:
> "Which hosts are making DNS queries to the most unique domains? (DGA malware generates hundreds of random domains)"

```splunk
index=dns
| stats dc(query) AS unique_domains by src_ip
| sort -unique_domains
| head 20
```

### Hunting Hypothesis Library
Build these up over time. See [[MITRE ATT&CK]] for technique-specific hypotheses:
- T1059 scripting engines: PowerShell/cmd.exe spawned by Office applications
- T1053 scheduled tasks: tasks created from temp directories
- T1055 process injection: parent/child process anomalies
- T1078 valid accounts: logins at unusual hours, from new locations
- T1105 ingress tool transfer: curl/wget/certutil/bitsadmin downloading files

---

## Detection Engineering

Writing good detection rules is a skill. Bad rules = alert fatigue. Good rules = actionable signal.

### Sigma Rules
Vendor-neutral detection rule format. Write once, convert to any SIEM.

```yaml
title: Mimikatz sekurlsa Command
description: Detects Mimikatz sekurlsa module commands
status: stable
references:
  - https://attack.mitre.org/techniques/T1003/
logsource:
  category: process_creation
  product: windows
detection:
  selection:
    CommandLine|contains:
      - 'sekurlsa::logonpasswords'
      - 'sekurlsa::wdigest'
      - 'lsadump::sam'
      - 'kerberos::golden'
  condition: selection
falsepositives:
  - Legitimate Mimikatz use in authorized penetration tests
level: critical
tags:
  - attack.credential_access
  - attack.t1003
```

Convert with `sigma convert --target splunk rule.yml`

### YARA Rules (File-Based Detection)
Pattern matching against file content. Used in AV, EDR, memory forensics.

```yara
rule Mimikatz_Strings {
    meta:
        description = "Detect Mimikatz strings"
        author = "VIRGIL"
    strings:
        $s1 = "sekurlsa::logonpasswords" ascii
        $s2 = "lsadump::dcsync" ascii
        $s3 = "privilege::debug" ascii
    condition:
        2 of them
}
```

### Detection Rule Quality Checklist
- [ ] Does it have a false positive rate? Test on known-good logs.
- [ ] Does it have context enrichment? (What asset, what user, what risk level?)
- [ ] Does it have a runbook? Analyst shouldn't have to figure out what to do.
- [ ] Is it tuned for your environment? Generic rules generate noise.
- [ ] Is it tied to a specific ATT&CK technique? Improves triage context.

---

## Key Metrics

| Metric | Definition | Target |
|---|---|---|
| **MTTD** (Mean Time to Detect) | Time from attack start to detection | < 24 hours for critical |
| **MTTR** (Mean Time to Respond) | Time from detection to containment | < 4 hours for critical |
| **False Positive Rate** | % of alerts that are not real threats | < 10% per rule (target) |
| **Detection Coverage** | % of ATT&CK techniques with at least one detection | Track over time, improve |
| **Dwell Time** | How long attacker was in before detection | Industry avg: 197 days. Target: < 1 day. |

---

## SIEM, EDR, SOAR

### SIEM (Security Information and Event Management)
Centralizes logs, correlates events, generates alerts.
- **[[Splunk]]:** Most widely deployed enterprise SIEM. SPL is the query language.
- **Elastic/Kibana:** Open source alternative. ECS (Elastic Common Schema) for normalization.
- **[[Wazuh]]:** OSS SIEM + XDR. [YOUR-LAB] uses Wazuh 4.14.1 on [[[YOUR-HOST]]].
- **Microsoft Sentinel:** Cloud-native SIEM for Azure environments.

### EDR (Endpoint Detection and Response)
Agent on every endpoint. Deep visibility + active response.
- **CrowdStrike Falcon:** Industry leader. Cloud-based, behavioral detection.
- **SentinelOne:** Strong autonomous response (can kill processes, isolate hosts without analyst)
- **Microsoft Defender for Endpoint:** Solid, included with M365 E5
- **Wazuh:** OSS EDR capabilities (FIM, syscall monitoring, rootkit detection)

### SOAR (Security Orchestration, Automation, Response)
Automate repetitive analyst tasks. Connect tools. Run playbooks automatically.
- Block an IP across 10 firewalls simultaneously? SOAR.
- Automatically isolate a host when EDR fires ransomware alert? SOAR.
- Enrich every alert with threat intel lookup and asset data? SOAR.
- **Shuffle:** OSS SOAR. Good for homelabs.
- **Splunk SOAR (Phantom):** Enterprise-grade.
- **Palo Alto XSOAR:** Enterprise-grade.

---

## Career Path

```
Help Desk / Desktop Support
        ↓
SOC L1 (alert triage, SIEM basics)
        ↓
SOC L2 (investigation, threat hunting)
        ↓
SOC L3 / Threat Hunter / IR Analyst
        ↓
Detection Engineer / Threat Intel Analyst / Red Team
        ↓
Security Architect / CISO
```

### Certifications by Tier
| Cert | Tier | What It Proves |
|---|---|---|
| CompTIA Security+ | L1 ready | Foundational concepts, enough to get hired |
| **CompTIA CySA+** | L1→L2 | Threat analysis, SIEM, vulnerability management |
| GIAC GCIH | L2→L3 | Incident handling, proven skill |
| GIAC GCFA | L3 | Computer forensics, artifacts mastery |
| GIAC GREM | L3 advanced | Malware reverse engineering |
| OSCP | Red → Purple | Offensive skills for better defensive understanding |

**your current position:** Transitioning from help desk to SOC L1/L2. [[CySA+]] is exactly the right cert.

### The Help Desk Advantage
Help desk people know what normal looks like. They know the weird ticket patterns, the problem users, the janky systems that break every quarter. That institutional knowledge is gold in a SOC — you know what to investigate and what to dismiss.

---

## Tags
`#blue-team` `#soc` `#detection-engineering` `#threat-hunting` `#siem` `#career`

[[Splunk]] [[Incident Response]] [[DFIR]] [[CySA+]] [[TryHackMe]] [[Wazuh]] [[MITRE ATT&CK]]
