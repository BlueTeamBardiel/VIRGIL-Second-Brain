# MITRE ATT&CK Notes

This directory contains notes on individual MITRE ATT&CK techniques, ingested automatically from [attack.mitre.org](https://attack.mitre.org).

## What Is MITRE ATT&CK?

ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge) is a globally-accessible knowledge base of adversary tactics and techniques based on real-world observations. It's the closest thing cybersecurity has to a universal language for describing how attacks work.

For CySA+ and Security+ candidates: ATT&CK appears throughout the exam. Understanding the tactic/technique hierarchy and being able to map detections to ATT&CK IDs is a core blue team skill.

## How VIRGIL Ingests ATT&CK Techniques

Any URL from `attack.mitre.org` is automatically routed to this directory:

```bash
# Ingest a technique by URL
virgil-url https://attack.mitre.org/techniques/T1059/
# → creates notes/mitre/t1059-command-and-scripting-interpreter.md

# Ingest a sub-technique
virgil-url https://attack.mitre.org/techniques/T1059/001/
# → creates notes/mitre/t1059-001-powershell.md
```

Notes named with the `t[0-9]{4}` pattern are also automatically routed here during inbox triage.

## Tactic Categories

ATT&CK organizes techniques by **tactic** — the adversary's goal:

| Tactic | ID | Description |
|--------|----|-------------|
| Reconnaissance | TA0043 | Gather info before attacking |
| Resource Development | TA0042 | Build infrastructure |
| Initial Access | TA0001 | Get a foothold |
| Execution | TA0002 | Run attacker code |
| Persistence | TA0003 | Maintain access |
| Privilege Escalation | TA0004 | Gain higher permissions |
| Defense Evasion | TA0005 | Avoid detection |
| Credential Access | TA0006 | Steal credentials |
| Discovery | TA0007 | Learn the environment |
| Lateral Movement | TA0008 | Move through the network |
| Collection | TA0009 | Gather target data |
| Command & Control | TA0011 | Communicate with implants |
| Exfiltration | TA0010 | Steal data |
| Impact | TA0040 | Disrupt/destroy/manipulate |

## Suggested Starting Points

Build your ATT&CK library by ingesting the techniques most commonly tested on blue team exams and most commonly seen in incident reports:

```bash
virgil-url https://attack.mitre.org/techniques/T1078/   # Valid Accounts
virgil-url https://attack.mitre.org/techniques/T1566/   # Phishing
virgil-url https://attack.mitre.org/techniques/T1059/   # Command & Scripting
virgil-url https://attack.mitre.org/techniques/T1190/   # Exploit Public-Facing App
virgil-url https://attack.mitre.org/techniques/T1486/   # Data Encrypted for Impact
virgil-url https://attack.mitre.org/techniques/T1110/   # Brute Force
virgil-url https://attack.mitre.org/techniques/T1133/   # External Remote Services
```

## Tags

#mitre #attack-framework #cysa-plus #threat-intel
