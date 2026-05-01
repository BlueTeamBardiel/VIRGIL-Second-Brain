---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# Domain 3 - Incident Response & Management (20%)
**When bad things happen to your network, having a battle plan means the difference between a contained problem and a catastrophe.**

---

## Overview

Incident response is your organization's playbook for detecting, stopping, and recovering from security attacks. A security analyst needs to understand this domain because you'll spend your career *inside* these processes—triaging alerts, containing breaches, and helping teams rebuild. Without a structured approach, every incident becomes firefighting instead of firefighting *with a map*.

---

## Key Concepts

### [[Incident Response Program Framework]]

**Analogy**: Think of an IR program like a fire department—you need clear protocols, trained personnel, communication systems, and chain-of-command *before* the building burns. You can't figure out who calls the ladder truck when flames are already through the roof.

**Definition**: A formalized incident response program, typically based on [[NIST Special Publication 800-61]], establishes governance structures, defines incident types, assigns roles, and creates playbooks for responding to security events across your organization.

**Core Program Components**:
| Element | Purpose |
|---------|---------|
| **Purpose Statement** | Defines what the IR program protects |
| **Scope Definition** | Lists incident categories covered by the program |
| **Strategic Goals** | Alignment with business risk tolerance |
| **Authority Matrix** | Who makes what decisions when |
| **Executive Sponsorship** | Board-level backing for resources |

### [[Incident Response Team (CSIRT)]]

**Analogy**: Your CSIRT is like an emergency room surgical team—you need the trauma surgeon (cybersecurity lead), the anesthesiologist (incident commander), the nurses (SOC analysts), the blood bank (forensics), and the hospital lawyer ready to respond 24/7 without coordination delays.

**Definition**: A cross-functional team operating 24/7 that includes security practitioners, system experts, legal counsel, HR, communications, and management—each with pre-defined roles to accelerate response without decision paralysis.

**Essential Team Roles**:
- **Security Leadership**: Sets severity thresholds and escalation rules
- **Technical Personnel**: DBAs, network engineers, application developers who know their systems
- **Forensics Specialists**: Preserve evidence and conduct investigations
- **Legal/Compliance**: Guides regulatory notification and disclosure requirements
- **Communications**: Manages public statements and internal updates

### [[Incident Severity Triage]]

**Analogy**: Like a hospital emergency room triage system, you need to instantly categorize patients (incidents) so critical cases get the operating room while minor cuts get band-aids without clogging the system.

**Definition**: A standardized three-level classification that immediately triggers the appropriate response team, notification protocols, and resource allocation based on business impact.

| Severity Level | Impact Characteristics | IR Team Activation | Executive Notification |
|---|---|---|---|
| **Low** | Isolated systems, minimal data exposure, reversible | Standard queue | Department manager |
| **Moderate** | Multiple systems affected, significant operational impact | Full IR team mobilized | CISO/CTO |
| **High** | Critical infrastructure down, customer data exposed, reputational damage | 24/7 full activation + legal/executive war room | C-suite + Board |

### [[Containment Strategies]]

**Analogy**: When you detect a intruder in your house, you don't reason with them—you either lock them in one room (segmentation), push them outside (isolation), or completely remove them (removal). Same logic, different threat.

**Definition**: Tactical decisions made during active incidents to immediately stop an attacker's ability to expand their foothold or exfiltrate data while you work on permanent fixes.

**Three Containment Approaches**:
1. **[[Network Segmentation/Quarantine LAN]]**: Move compromised systems to an isolated VLAN where they can't access production resources but you can still monitor attacker activity
2. **[[Full Isolation]]**: Disconnect from corporate network completely but potentially leave internet access for forensic investigation and preventing destruction of evidence
3. **[[Complete Removal]]**: Hard disconnect from all networks—nuclear option when attacker has deep access or is actively destroying data

### [[Eradication & Recovery Process]]

**Analogy**: You've kicked the burglar out—now you change all the locks, patch the windows they used, and check every room for hidden listening devices before inviting residents back in.

**Definition**: Methodical restoration of systems to operational state after confirming the attacker has no remaining access points, requiring full system rebuild rather than hoping malware is gone.

**Critical Recovery Steps**:
1. **Vulnerability Closure**: Patch the attack vector or deploy [[compensating controls]] if patches don't exist
2. **System Reimaging**: Rebuild from clean installation media—never trust "cleaned" systems that might harbor backdoors
3. **Configuration Hardening**: Re-apply security baselines and remove unnecessary services
4. **[[Validation Testing]]**: Automated scans, vulnerability assessments, log verification, and account permission audits before returning to production

### [[Logging Architecture & Log Sources]]

**Analogy**: Imagine solving a crime—you need the security camera (NetFlow), the door logs (authentication), the store records (application logs), and witness statements (syslog messages). One source tells part of the story; all together they reveal everything.

**Definition**: Comprehensive collection of security-relevant events from network, system, and application sources that feeds investigation and threat detection capabilities.

**Critical Log Sources for Incident Investigation**:
- **[[NetFlow]]**: Network conversations (source IP, destination, port, volume)—answers "who talked to whom"
- **[[DNS Query Logs]]**: External domain lookups—reveals command-and-control communications
- **[[Authentication Logs]]**: User login attempts, privilege escalation, credential usage
- **[[Syslog Standard]]**: OS events formatted with timestamp, facility code (0-23 source types), severity level (0-7 scale), and message content
- **[[Application Logs]]**: Business logic errors, database transactions, API calls

### [[SIEM (Security Information & Event Management)]]

**Analogy**: A SIEM is like a 24/7 security operations command center that watches thousands of camera feeds simultaneously, automatically detects patterns humans would miss, and alerts when something looks suspicious—even if you're sleeping.

**Definition**: Centralized platform that collects logs from all sources, correlates events using statistical analysis and machine learning to detect patterns, and provides investigation dashboards for analysts.

**[[SIEM]] Implementation Essentials**:
- **Storage**: Use [[WORM (Write Once, Read Many)]] drives to prevent tampering of historical logs
- **Time Synchronization**: [[NTP (Network Time Protocol)]] ensures timestamps align for accurate event sequencing
- **[[Log Correlation]]**: AI identifies patterns—like "failed logins from 50 different countries in 2 minutes" that single log sources would miss
- **Analysis Approaches**:
  - **[[Anomaly/Heuristic Analysis]]**: Flags statistical outliers from baseline behavior
  - **[[Trend Analysis]]**: Detects gradual changes over weeks/months
  - **[[Behavioral Analysis (UEBA)]]**: Machine learning models user activity patterns and flags deviations

### [[SOAR (Security Orchestration, Automation & Response)]]

**Analogy**: SOAR is like teaching your security team a series of muscle-memory drills—when the alarm sounds, they execute rehearsed steps without stopping to think, completing routine responses in seconds instead of hours.

**Definition**: Platform that automates incident response workflows by executing pre-built decision trees and orchestrating tool interactions without human intervention.

**SOAR Response Types**:
- **[[Playbooks]]**: Mix of automated and human decision points—useful when judgment is needed but routine tasks can be automated
- **[[Runbooks]]**: Completely automated sequences triggered by specific events—lock account → isolate system → collect forensics → notify team

### [[Forensic Investigation Principles]]

**Analogy**: Like collecting evidence at a crime scene, contaminating a hard drive by running commands on it is like walking through wet paint at a murder scene—you've destroyed the evidence you needed.

**Definition**: Systematic process of collecting, preserving, and analyzing evidence from compromised systems following chain-of-custody protocols to maintain admissibility and prevent alteration.

**Golden Rule**: Always work with copies or images of evidence; never alter the original.

### [[Order of Volatility]]

**Analogy**: Imagine a crime scene where the murder weapon is slowly dissolving—you photograph it first, then collect it, then preserve it. In digital forensics, RAM dissolves when you turn off the computer, so you collect it *first*.

**Definition**: Priority sequence for evidence collection based on how quickly data disappears if not captured—capturing most volatile evidence first before system changes destroy it.

**Collection Priority** (Most to Least Volatile):
1. **[[Network Traffic]]**: Live connections, RAM buffers—lost on reboot
2. **[[Memory (RAM)]]**: Running processes, encryption keys—lost on power down
3. **[[System Configuration & Process Tables]]**: Current running state
4. **[[File System]]**: Temporary files, then regular files
5. **[[Audit Logs]]**: Persistent historical records
6. **[[Archived Data]]**: Backups and offline storage

### [[Hashing for Evidence Integrity]]

**Analogy**: A hash is like a fingerprint—unique to each person (or in this case, unique to each file's exact content). Change even one letter and the fingerprint completely changes, proving someone tampered with it.

**Definition**: Cryptographic algorithm that creates a fixed-length digital fingerprint of file contents—used to prove evidence hasn't been altered and establishing chain-of-custody.

**Hashing Properties**:
- **Deterministic**: Same file always produces same hash
- **Sensitivity**: Single-character change produces completely different hash
- **Uniqueness**: Different files virtually never produce identical hashes
- **Proof of Integrity**: Hash demonstrates file hasn't been modified since collection

### [[Forensic Investigation Tools]]

**Analogy**: Like a detective's toolkit—write blockers prevent you from accidentally contaminating evidence, imaging tools create perfect snapshots, and file carving tools recover deleted evidence from trash.

**Definition**: Specialized software and hardware that preserves original evidence while enabling deep analysis of compromised systems.

| Tool Type | Example | Purpose |
|-----------|---------|---------|
| **Write Blockers** | Hardware devices | Prevent analysis process from writing data to evidence drives |
| **Imaging Tools** | [[DD Utility]] ([[Linux]]), [[FTK Imager]] (Windows) | Create bit-for-bit copies of drives for safe analysis |
| **File Carving** | [[Bulk Extractor]] | Recover deleted files from unallocated disk space |
| **Memory Analysis** | **Memory dump utilities** | Extract volatile RAM contents from running systems |
| **Process Inspection** | [[Sysinternals Suite]] | Windows tools: AccessEnum, Autoruns, Process Explorer, TCPView |

### [[Live Analysis vs. Forensic Imaging]]

**Analogy**: Live analysis is like interviewing a witness while they're still awake—you get real-time answers but might miss details. Forensic imaging is like recording their statement permanently so you can replay and analyze every word later.

**Definition**: Two complementary investigation approaches—capturing volatile data from running systems (live analysis) versus creating permanent snapshots for deep analysis without risking further changes (imaging).

| Approach | Use Case | Evidence Type | Risk |
|----------|----------|---|---|
| **Live Analysis** | Active threat still present, need immediate memory/process data | Volatile data (RAM, connections) | Changes made during investigation |
| **Forensic Imaging** | Post-incident deep analysis, legal requirements | Persistent data (disk contents) | May miss volatile evidence |

### [[Sysinternals Suite for Windows Forensics]]

**Analogy**: Sysinternals tools are like X-ray machines for Windows—you can peer inside running processes to see what they're connected to and what they're doing without killing them.

**Definition**: Collection of freeware Windows utilities providing deep visibility into system processes, permissions, network connections, and startup mechanisms.

**Key Forensic Tools**:
- **[[AccessEnum]]**: Reveals file/folder permission misconfigurations
- **[[Autoruns]]**: Shows all programs launching at startup (where malware hides)
- **[[Process Explorer]]**: Hierarchical view of running processes and their parent relationships
- **[[TCPView]]**: Real-time display of active network connections and listening ports

---

## Analyst Relevance

You're sitting in the SOC on a Tuesday morning when an alert fires: "Unusual outbound connection from finance-server-04 to