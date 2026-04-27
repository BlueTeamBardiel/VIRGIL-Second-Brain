# MITRE ATT&CK Enterprise Tactics Overview

The MITRE ATT&CK Enterprise framework defines 14 core tactics representing the "why" of adversary actions—their tactical goals during cyberattacks. Each tactic describes a phase of an attack lifecycle, from initial reconnaissance through impact.

## Tactics by Phase

### Preparation
- **TA0043 – [[Reconnaissance]]**: Gathering information to plan future operations
- **TA0042 – [[Resource Development]]**: Establishing resources to support operations

### Execution & Persistence
- **TA0001 – [[Initial Access]]**: Getting into the network
- **TA0002 – [[Execution]]**: Running malicious code
- **TA0003 – [[Persistence]]**: Maintaining foothold in the environment

### Escalation & Evasion
- **TA0004 – [[Privilege Escalation]]**: Gaining higher-level permissions
- **TA0005 – [[Defense Evasion]]**: Avoiding detection *(planned for deprecation in ATT&CK v19)*

### Information Gathering
- **TA0006 – [[Credential Access]]**: Stealing account names and passwords
- **TA0007 – [[Discovery]]**: Understanding the environment
- **TA0009 – [[Collection]]**: Gathering data relevant to objectives

### Movement & Exfiltration
- **TA0008 – [[Lateral Movement]]**: Moving through the environment
- **TA0011 – [[Command and Control]]**: Communicating with compromised systems
- **TA0010 – [[Exfiltration]]**: Stealing data

### Destruction
- **TA0040 – [[Impact]]**: Manipulating, interrupting, or destroying systems and data

## Framework Structure

Tactics support the broader [[MITRE ATT&CK]] matrices, which also include techniques, sub-techniques, and defensive countermeasures (mitigations, detections, asset hardening).

## Tags
#mitre #att-ck #tactics #adversary-goals #cybersecurity #threat-framework

---
_Ingested: [[2026-04-15]] 22:04 | Source: https://attack.mitre.org/tactics/enterprise/_
