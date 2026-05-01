---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# XIII. Performing Forensic Analysis and Techniques for Incident Response
**Digital detective work: capturing, preserving, and analyzing evidence from compromised systems to reconstruct what happened and prove it in court.**

---

## Overview

When a security incident occurs, you need more than just "something bad happened"—you need forensic evidence that holds up under scrutiny. Forensic analysis is how security teams methodically extract, protect, and interpret digital artifacts from devices, networks, and storage systems. A SOC analyst must understand forensic principles because incident response often determines whether an attacker gets prosecuted, whether stolen data becomes litigation evidence, or whether findings get dismissed due to procedural mistakes.

---

## Key Concepts

### [[Forensic Capability Building]]

**Analogy**: A forensic capability is like a crime scene investigation kit—you don't just show up with a magnifying glass and hope. You need sterile containers, proper documentation, trained technicians, and a chain-of-custody form. Without the infrastructure, even good evidence becomes unreliable.

**Definition**: A forensic capability encompasses the people, tools, processes, and physical infrastructure required to acquire and analyze digital evidence defensibly. This includes [[forensic workstations]] (isolated, high-capacity systems), [[write blockers]], dedicated [[forensic toolkits]], clean [[storage media]], and rigorous [[chain-of-custody]] procedures.

| Component | Purpose | Why It Matters |
|-----------|---------|----------------|
| Forensic Workstation | Isolated analysis environment | Prevents cross-contamination |
| Write Blocker | Prevents modification during imaging | Maintains evidence integrity |
| Forensic Toolkit | Specialized acquisition/analysis software | Ensures defensible results |
| Chain of Custody Log | Documents evidence handling | Proves evidence wasn't tampered with |

**Exam mindset**: A [[SOC]] analyst may *operate* forensic tools during incident response, but a dedicated forensic analyst owns the responsibility for evidence preservation and legal defensibility.

---

### [[Order of Volatility]]

**Analogy**: Imagine water on a hot skillet—some evaporates instantly (memory), while the pan itself stays put (disk). You must capture what disappears first or it's gone forever.

**Definition**: Order of volatility ranks data by how quickly it disappears when a system is powered down or altered. Capture in this sequence (highest to lowest volatility):

1. **CPU registers and cache** – Lost instantly on shutdown
2. **RAM (memory)** – Lost on power loss
3. **Active network connections** – Terminate on disconnect
4. **Running processes** – Killed on shutdown
5. **Disk storage** – Persists indefinitely
6. **Backups and archives** – Most stable

**Critical rule**: If you power off a system before capturing memory, volatile evidence containing [[fileless malware]], encryption keys, and in-memory attacks is permanently destroyed.

---

### [[Write Blocker]]

**Analogy**: A write blocker is a one-way mirror for your hard drive—data can be read through it, but nothing can be written back. It's the physical equivalent of putting a post-it note on a filing cabinet that says "LOOK ONLY."

**Definition**: A [[write blocker]] is hardware or software that enforces read-only access to storage media during forensic acquisition, preventing any modification to the source evidence.

| Type | Mechanism | Legal Strength | Best Use |
|------|-----------|----------------|----------|
| Hardware Write Blocker | Physical device between drive and computer; enforces read-only at hardware level | Very strong (preferred in court) | All legal/litigation cases |
| Software Write Blocker | OS-level driver that prevents writes | Weaker (more defensible than nothing) | Internal investigations only |

**Exam trap**: Imaging without a [[write blocker]]—even if you "promise not to modify anything"—can render evidence inadmissible in legal proceedings. Courts trust hardware enforcement, not promises.

---

### [[Disk Imaging and Acquisition]]

**Analogy**: Think of disk imaging like photocopying a document page-by-page, including blank pages on the back. You're not just copying what's visible; you're duplicating the entire paper, including margins and notes in the margins that nobody expected to find.

**Definition**: Disk imaging creates a [[bit-by-bit]] copy of storage media, capturing both allocated space (active files) and unallocated space (deleted files and slack space). This is required for forensic soundness.

#### Common Acquisition Tools

| Tool | Platform | Method | Strength | Weakness |
|------|----------|--------|----------|----------|
| `dd` | [[Linux]]/Unix | Raw bit-copy via command line | Fast, simple, universally compatible | No built-in hashing; operator error risk |
| FTK Imager | Windows | GUI-based imaging with validation | User-friendly, includes hashing/verification | Proprietary format requires FTK suite |
| EnCase Imager | Enterprise | Professional-grade with extensive logging | Enterprise-defensible, detailed metadata | Expensive, steeper learning curve |

**Why it matters**: [[Bit-by-bit]] imaging preserves deleted files, unallocated clusters, and filesystem metadata that a normal copy would skip. The exam tests whether you *understand the why*, not just the tool name.

---

### [[Hashing and Data Integrity]]

**Analogy**: A hash is like a fingerprint for data. Two identical documents produce identical fingerprints; change even one letter and the fingerprint completely changes. This proves nothing was altered.

**Definition**: A cryptographic hash is a one-way mathematical function that produces a fixed-length string (the hash) representing digital data. Identical pre-hash data always produces identical post-hash values. If hashes match before and after evidence handling, integrity is proven.

#### Hash Algorithms (Exam-Important)

| Algorithm | Status | Use Case | Collision Risk |
|-----------|--------|----------|-----------------|
| **MD5** | Deprecated but common | Legacy validation, non-critical checks | High (proven collisions) |
| **SHA-1** | Weak, legacy | Phasing out; avoid for new cases | Medium |
| **SHA-256** | Preferred standard | All new forensic work | Negligible |

**Hashing timeline**:
- Before acquisition (baseline hash of source evidence)
- After acquisition (proof image matches source)
- During analysis (optional milestone tracking)
- Before reporting (final verification)

Matching hashes = evidence integrity preserved throughout the investigation.

---

### [[Chain of Custody]]

**Analogy**: Chain of custody is a detailed logbook for evidence that answers: "Who touched it? When? Where? Why?" If that logbook has gaps, a defense lawyer will argue the evidence could have been tampered with while nobody was watching.

**Definition**: A [[chain of custody]] document tracks every person who handled evidence, the date and time of handoff, the location, and the action taken. It creates an unbroken audit trail proving evidence wasn't lost, modified, or contaminated.

**What it documents**:
- Identity of person handling evidence
- Date, time, and duration of custody
- Location and storage conditions
- Actions performed (acquisition, analysis, transfer)
- Purpose of access
- Witness signatures

**Why it's critical**: If the [[chain of custody]] is broken—even for a few minutes—defense attorneys can argue evidence was compromised and request it be excluded from trial. A single missing signature can invalidate months of investigation.

---

### [[Memory Forensics]]

**Analogy**: RAM is like a whiteboard that shows what the computer was thinking at that exact moment. Power it off and the whiteboard gets erased. You must photograph that whiteboard before erasing it.

**Definition**: [[Memory forensics]] is the acquisition and analysis of [[RAM (random-access memory)]] to recover evidence that only exists in running memory, such as [[fileless malware]], unencrypted passwords, and network connections.

#### Why Memory Matters
- **Fileless malware** – Never written to disk; only in memory
- **Encryption keys** – Decrypted keys loaded in memory
- **Active network connections** – Real-time C2 (command-and-control) channels
- **Running processes** – Injected DLLs and process hollowing attacks
- **In-memory attacks** – Shellcode, heap sprays, privilege escalation

#### Memory Capture Tools

| Tool | OS | Method | Strength |
|------|-----|--------|----------|
| **DumpIt** | Windows | Automated memory dump with minimal user interaction | Quick, reliable, minimal user error |
| **LiME** | [[Linux]] | Kernel module for memory extraction | Works on live systems; captures entire RAM |
| **fmem** | [[Linux]] | Character device interface (legacy) | Useful on older kernels |

#### Memory Analysis: [[Volatility]]

[[Volatility]] is the industry-standard framework for analyzing memory dumps. It recovers:
- Process enumeration (what was running?)
- DLL injection detection (malware hooks)
- Network artifact recovery (IP addresses, ports, URLs)
- Registry and credential analysis (cached passwords)
- Kernel rootkits (hidden processes)

**Capture priority**: Memory should be captured *before* disk imaging when possible, because any disk access can overwrite memory.

---

### [[File Carving]]

**Analogy**: File carving is like finding a letter in a shredder. You can't read the envelope (metadata), but you recognize the letter's header ("Dear Sir") and footer, so you reassemble it from the shreds.

**Definition**: [[File carving]] recovers deleted or fragmented files without relying on filesystem metadata, using file format headers/footers or content patterns to identify and extract data.

#### Carving Methods

| Method | Example | When Used |
|--------|---------|-----------|
| Header/Footer-based | JPEG (FFD8 FFE0 header) + FFD9 footer | Standard deleted file recovery |
| Content-based | Known strings or patterns within file | Partially overwritten or fragmented data |
| Structure-based | Internal record alignment | Database files, swap files |

**Used when**:
- Files are deleted (filesystem metadata destroyed)
- Filesystems are damaged or corrupted
- Malware attempts evasion via deletion
- Unallocated space analysis

---

### [[Artifact Discovery and Indexing]]

**Analogy**: Indexing is like cataloging a library by every word in every book, not just the title. Later, when you search for "insurance fraud," you find it on page 247 of a book titled "Recipes"—context you'd never get from the catalog alone.

**Definition**: Forensic suites index digital artifacts—file content, metadata, deleted files, registry entries, browser history—to enable keyword searching and discovery of evidence that wouldn't be found through manual browsing.

**Key principle**: [[Deletion ≠ Removal]]. Deleted files remain in unallocated space until overwritten. Forensic indexing discovers these "invisible" artifacts.

**Example**: A user deletes CCleaner logs to hide tracking activity. Index-based searching recovers the deleted log entry, exposing the cover-up attempt.

---

### [[Timeline Analysis]]

**Analogy**: A timeline is like reconstructing a crime scene minute-by-minute using security camera footage. Each frame (timestamp) shows what happened, and the sequence tells the story.

**Definition**: [[Timeline analysis]] correlates file creation, modification, and access times to establish the sequence of events in an investigation, particularly critical for [[insider threat]] cases.

**Timeline correlations**:
- File creation timestamps (when did malware first appear?)
- Modification timestamps (when were files altered?)
- Access timestamps (who accessed what, when?)
- Log entries (system events aligned with file changes)
- Network artifacts (when did exfiltration occur?)

**Use case**: In an insider threat investigation, you align file access logs with VPN login timestamps to prove an employee accessed company secrets from home at 2 AM—establishing intent and opportunity.

---

### [[Network Forensics]]

**Analogy**: Network forensics is like reconstructing a conversation from a recording. You hear who said what, how long they talked, and what tone they used—but you might not know their *motivations*.

**Definition**: [[Network forensics]] analyzes captured network traffic (PCAPs) and network artifacts to identify suspicious sessions, data exfiltration patterns, and command-and-control communications.

#### Common Tools

| Tool | Purpose | Data Type |
|------|---------|-----------|
| [[Wireshark]] | Interactive packet analysis | PCAP files; real-time capture |
| `tcpdump` | Command-line packet capture | PCAP files; lightweight |
| `tshark` | Non-interactive Wi