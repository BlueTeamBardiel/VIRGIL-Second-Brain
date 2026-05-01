---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 094
source: rewritten
---

# Monitoring Data
**Detecting unauthorized changes to critical files protects system integrity and reveals compromise.**

---

## Overview
Applications and operating systems contain core files that should remain static—executables, libraries, and system binaries—while other data constantly changes. From a security perspective, you need mechanisms to detect when those supposedly-unchanging files are modified, which often signals [[Malware]], tampering, or unauthorized access. For Security+, understanding how to monitor and verify file integrity is essential for maintaining system health and responding to potential breaches.

---

## Key Concepts

### File Integrity Monitoring (FIM)
**Analogy**: Think of FIM like having a security camera specifically trained on a museum's display cases—you know exactly what should be there, and the moment something changes, you get an alert.

**Definition**: A security control that continuously or periodically checks critical files and directories against a baseline to detect unauthorized modifications, deletions, or additions.

[[File Integrity Monitoring]] | [[Baseline Configuration]] | [[Hash Verification]] | [[Integrity Checking]]

**Why It Matters**:
- Detects [[Rootkit]] infections that modify system files
- Identifies unauthorized patches or configuration changes
- Provides forensic evidence of compromise
- Enables quick response to [[Malware]] activity

---

### System File Checker (SFC)
**Analogy**: Like a spell-checker that fixes corrupted text automatically—it scans your document, finds errors, and corrects them.

**Definition**: A Windows built-in utility (`sfc.exe`) that performs on-demand scanning of protected operating system files, verifies their integrity using cryptographic hashes, and automatically restores corrupted or modified files from a cached backup.

[[Windows System File Checker]] | [[Operating System Protection]] | [[On-Demand Scanning]]

**Key Details**:
- Runs with elevated privileges (Administrator)
- Checks critical OS files only (not user data)
- Restores files automatically if tampering detected
- Command: `sfc /scannow`

---

### Tripwire
**Analogy**: Like a booby-trap wire that alerts you the instant someone crosses a threshold—you'll know immediately if movement occurs.

**Definition**: A popular host-based [[File Integrity Monitoring]] tool for Linux/Unix systems that creates cryptographic signatures of files, monitors for changes in real-time, and alerts administrators to any modifications with detailed reports.

[[Tripwire]] | [[Linux Security Tools]] | [[Real-Time Monitoring]] | [[Cryptographic Hashing]]

**Capabilities**:
- Creates baseline database of file hashes
- Detects additions, deletions, and modifications
- Real-time alerting (vs. on-demand like SFC)
- Customizable reporting and escalation

---

### Host-Based Intrusion Prevention System (HIPS)
**Analogy**: A security guard stationed inside a building (not just at the entrance) who can stop threats and investigate suspicious activity before they spread.

**Definition**: Security software running on individual endpoints that monitors system activity, detects attack signatures, blocks known exploits, prevents unauthorized file modifications, and often incorporates [[File Integrity Monitoring]] capabilities.

[[Host-Based IPS]] | [[Network-Based IPS]] | [[Endpoint Protection]] | [[Intrusion Prevention]]

| Characteristic | HIPS | Network IPS |
|---|---|---|
| **Location** | On individual host/OS | On network perimeter |
| **Scope** | Single system activity | All network traffic |
| **File Monitoring** | Yes (native capability) | No |
| **Response Speed** | Instant (local) | Slight latency |
| **Encrypted Traffic** | Can inspect | Cannot inspect |
| **Resource Impact** | High on host | Centralized |

---

### Baseline Configuration
**Analogy**: A "before" photograph of your home before renovations—you need to know what normal looks like to identify what's changed.

**Definition**: A documented snapshot of known-good file hashes, permissions, timestamps, and system configurations that serves as the reference standard for [[File Integrity Monitoring]] comparisons.

[[Baseline]] | [[Configuration Management]] | [[Hash Values]]

**Importance for Exams**:
- Baseline must be created *before* compromise
- Stored securely (separate from monitored systems)
- Updated only through authorized change management
- Used to verify "what should be there"

---

### Cryptographic Hashing for Integrity
**Analogy**: Like a wax seal on a letter—if the seal is broken or tampered with, you immediately know the document was opened.

**Definition**: Using algorithms like [[MD5]], [[SHA-1]], or [[SHA-256]] to generate fixed-length digital fingerprints of files; any change to a file produces a completely different hash, making tampering detectable.

[[Cryptographic Hash]] | [[MD5]] | [[SHA-256]] | [[Integrity Verification]]

---

## Exam Tips

### Question Type 1: Choosing the Right Tool
- *"Which utility can you use on-demand in Windows to verify critical system files and automatically restore corrupted ones?"* → **System File Checker (SFC)**
- *"Your Linux server needs real-time alerting when configuration files change. Which tool is best?"* → **Tripwire**
- *"You need to detect attacks and file modifications on an individual workstation. What do you deploy?"* → **Host-Based IPS (HIPS)**

**Trick**: Don't confuse [[Network-Based IPS]] (perimeter) with [[Host-Based IPS]] (on the system itself). SY0-701 emphasizes host-based monitoring.

### Question Type 2: When to Use Each Technology
- *"An attacker modified system libraries after gaining root access. How would you have detected this?"* → [[File Integrity Monitoring]] or Tripwire
- *"You need continuous, real-time detection of unauthorized changes across 500 endpoints. What's the best approach?"* → HIPS with integrated [[File Integrity Monitoring]]

**Trick**: On-demand tools (SFC) require manual execution; real-time tools (Tripwire, HIPS) require running services.

### Question Type 3: Baseline and Hash Concepts
- *"Why should baselines be stored securely and separately from the monitored system?"* → To prevent attackers from modifying both the files AND the baseline simultaneously
- *"If a file's hash changes, what does this indicate?"* → File content has been modified (though not *how* or *why*)

**Trick**: [[File Integrity Monitoring]] detects *that* something changed, but doesn't always identify *what* the change was or whether it's legitimate.

---

## Common Mistakes

### Mistake 1: Confusing On-Demand vs. Real-Time Monitoring
**Wrong**: Thinking SFC and Tripwire serve the same purpose and are interchangeable.
**Right**: SFC is on-demand (manual scans) for Windows OS files; Tripwire is continuous real-time monitoring for Linux; use Tripwire when you need immediate alerts.
**Impact on Exam**: You'll see questions asking which tool provides *instant* alerting vs. which requires manual runs. Choose Tripwire or HIPS for real-time, SFC for on-demand.

### Mistake 2: Assuming File Integrity Monitoring Prevents Changes
**Wrong**: Believing FIM stops attackers from modifying files.
**Right**: FIM *detects* changes after they occur; it's a detection mechanism, not prevention (prevention requires [[Host-Based IPS]] or [[Access Controls]]).
**Impact on Exam**: Security+ distinguishes between detection and prevention. FIM is detective, HIPS can be both.

### Mistake 3: Ignoring Baseline Security
**Wrong**: Creating a baseline on a system you suspect is already compromised.
**Right**: Always establish baseline on a freshly installed, verified-clean system before any monitoring begins.
**Impact on Exam**: Questions test whether you understand that a compromised baseline makes all future comparisons useless.

### Mistake 4: Forgetting About Legitimate Changes
**Wrong**: Alerting on *every* file change without considering OS patches and updates.
**Right**: Baselines must be updated through controlled [[Change Management]] processes when legitimate changes occur.
**Impact on Exam**: Real-world scenario questions include authorized software updates; you need to distinguish legitimate changes from malicious ones.

### Mistake 5: Confusing Tools by Operating System
**Wrong**: Thinking SFC works on Linux or Tripwire is a Windows native tool.
**Right**: SFC is Windows-specific; Tripwire is Linux/Unix; HIPS is platform-agnostic but configured per OS.
**Impact on Exam**: Scenario questions specify OS; make sure you recommend the right tool for the right platform.

---

## Related Topics
- [[Host-Based Intrusion Prevention System (HIPS)]]
- [[Network-Based Intrusion Detection System (NIDS)]]
- [[Malware Detection]]
- [[Rootkit]]
- [[Change Management]]
- [[Cryptographic Hash Functions]]
- [[Baseline Configuration]]
- [[System Hardening]]
- [[Log Monitoring]]
- [[Security Information and Event Management (SIEM)]]
- [[Endpoint Detection and Response (EDR)]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*