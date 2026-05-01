---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# II. System & Network Architecture
**The blueprint of how systems talk, trust each other, and protect what matters — your map for finding where attackers hide.**

---

## Overview

System and network architecture is the foundation layer where security either works or fails. A security analyst must understand how infrastructure is built, connected, and secured because every breach flows through these pathways. You can't detect what you don't understand, and you can't respond to what you haven't mapped.

---

## Key Concepts

### Virtualization & Hypervisors

**Analogy**: Think of a hypervisor like a parking lot manager who divides one physical lot into separate, isolated parking spaces. Each car (VM) has its own painted space and can't see into the others — but they're all sitting on the same concrete.

**Definition**: [[Virtualization]] uses a [[hypervisor]] to run multiple isolated virtual machines on a single physical host. Each VM gets its own operating system, memory, and disk — logically separated but sharing hardware underneath.

**Why analysts care**: VMs create strong segmentation, enable rapid deployment, and provide snapshots for forensics. But hypervisor compromise = all VMs compromised. VM sprawl (forgotten test machines) becomes a blind spot.

**Key risks**:
- [[Hypervisor escape]] — attacker breaks out of VM into host
- [[VM sprawl]] — unpatched, unmonitored virtual machines hiding on networks
- [[Resource contention]] — noisy neighbors consuming shared CPU/memory

---

### Containerization

**Analogy**: Containers are like shipping containers stacked on a dock. They're lightweight, portable, and standardized — but they all share the same dock infrastructure (the host OS kernel). A hole in the dock affects every container.

**Definition**: [[Containers]] package application code with minimal OS dependencies, sharing the host kernel rather than embedding a full OS. They're faster and lighter than VMs but offer weaker isolation.

**Why analysts care**: Containers dominate modern deployment. Security shifts left — into [[image hygiene]] (what's in the container before it runs) and [[runtime controls]] (what it can do while running).

**Key risks**:
- [[Container breakout]] — escape from container into host kernel
- [[Image supply chain attacks]] — malicious code baked into container images
- [[Orchestration misconfiguration]] — Kubernetes defaults allow lateral movement

| Aspect | VMs | Containers |
|--------|-----|-----------|
| OS Isolation | Full OS per VM | Shared kernel |
| Resource Overhead | High | Low |
| Blast Radius if Breached | Single VM | Potentially all containers on host |
| Attack Surface | Hypervisor | Kernel, container runtime |
| Startup Time | Minutes | Seconds |

---

### Serverless Computing

**Analogy**: Serverless is like renting a appliance instead of buying one. You plug in your code (the appliance), the vendor handles power/cooling/maintenance, and you pay only when it runs. You never see or manage the "server."

**Definition**: [[Serverless]] architecture runs functions on-demand without managing underlying infrastructure. Code executes in response to events, scales automatically, and you pay per execution.

**Why analysts care**: Serverless removes visibility into the execution environment. You can't SSH into a function or patch its OS. Security lives entirely in [[function code]], [[IAM permissions]], and [[event validation]].

**Key risks**:
- [[Over-permissioned IAM roles]] — functions granted access they don't need
- [[Event injection attacks]] — untrusted event sources trigger unvalidated code
- [[Cold start exploitation]] — timing side-channels during initialization
- [[Blind logging]] — poor visibility into what functions actually did

---

### Operating System Hardening

**Analogy**: OS hardening is like locking down a house — you close unused doors, install locks, remove furniture you don't need, and grant keys only to people who absolutely need them.

**Definition**: [[Hardening]] reduces the attack surface by disabling unused services, applying principle of least privilege, patching aggressively, and removing unnecessary features.

**Why analysts care**: A hardened OS gives attackers fewer footholds. It also creates a baseline — when something unexpected is running or a port suddenly opens, that's a detection signal.

**Key hardening controls**:
- Disable unused network services ([[SMB]], [[Telnet]], [[RPC]])
- Remove unneeded user accounts and groups
- Set restrictive [[file permissions]]
- Configure [[audit logging]] comprehensively
- Apply [[DISA STIGs]] or [[CIS Benchmarks]]

---

### Windows Registry & Configuration Persistence

**Analogy**: The Windows Registry is like a massive index card system for Windows settings. Malware often hides instructions in card drawers that auto-execute at startup.

**Definition**: The [[Windows Registry]] is a hierarchical database storing OS, application, and user configurations. Keys like `HKLM\Software\Microsoft\Windows\Run` auto-execute code at startup.

**Why analysts care**: Malware persistence often lives in the Registry. Analysts hunt for unexpected keys, binary value injection, and startup folder modifications.

**High-value Registry locations**:
- `HKLM\System\CurrentControlSet\Services` — service startup
- `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` — user startup
- `HKLM\Software\Classes\*\shell\open\command` — file association hijacking

---

### File System Artifacts & Config Locations

**Analogy**: Every OS has a filing cabinet with specific drawers for specific documents. If you don't know which drawer holds admin accounts, you can't spot a fake one.

**Definition**: [[File system artifacts]] are configuration files, logs, and metadata that reveal system state and user activity. Locations differ dramatically between [[Windows]], [[Linux]], and [[macOS]].

| Artifact | Windows | Linux | Purpose |
|----------|---------|-------|---------|
| User creation logs | Event ID 4720 | `/var/log/auth.log` | Detect rogue accounts |
| Sudo usage | Event ID 4688 | `/var/log/auth.log` | Privilege escalation |
| Scheduled tasks | Task Scheduler DB | `/etc/cron.d`, systemd timers | Persistence |
| Network config | Registry, `ipconfig /all` | `/etc/network/interfaces` | Detect backdoor IPs |
| Installed software | Registry, Add/Remove Programs | `/usr/bin`, `rpm -qa` | Unauthorized tools |

**Why analysts care**: You must know where to look. Log into a compromised Linux server and check Windows Registry paths? You'll miss everything.

---

### System Processes & Hardware Architecture

**Analogy**: A process list is like a guest roster at a party. You should know who RSVP'd (legitimate processes). Anyone else is suspicious.

**Definition**: [[System processes]] are programs running in memory. Knowing baseline processes lets analysts spot anomalies — a process named `explorer.exe` running from `temp`, for example.

**Why analysts care**: Malware often disguises itself as legitimate processes or injects into trusted ones. Process baselines enable anomaly detection.

**Key concepts**:
- [[Process injection]] — malware runs inside legitimate process
- [[Process hollowing]] — legitimate process launched, code replaced
- [[Living-off-the-land]] — attackers use built-in tools (PowerShell, `cmd.exe`) to avoid detection

**Hardware architecture matters**:
- [[x86 vs ARM]] — affects malware portability
- [[CPU instruction sets]] — some exploits require specific CPU features

---

## Logging & Time Synchronization (SOC Oxygen)

### Centralized Log Ingestion

**Analogy**: Imagine detectives from 10 different precincts keeping arrest logs in different formats, using different clocks, stored in different buildings. Connecting dots becomes impossible. Centralization is the solution.

**Definition**: [[Log centralization]] aggregates logs from all systems into a single, trusted repository (typically a [[SIEM]] or [[log aggregation]] platform). Logs must be consistent, immutable, and synchronized.

**Why analysts care**: You can't correlate an attack across systems if logs aren't centralized. A lateral movement attack hits five servers — if logs are scattered, you'll never see the story.

**Centralization requirements**:
- [[Log parsing]] — normalize format across sources
- [[Retention policies]] — balance storage cost with investigation needs
- [[Log integrity]] — prevent tampering (use [[cryptographic signing]])
- [[Chain of custody]] — ensure logs survive legal challenge

---

### Network Time Protocol (NTP) & Clock Synchronization

**Analogy**: Imagine watching a crime on five security cameras, each running a different clock. One says 3:00 PM, another says 2:45 PM. You can't reconstruct the timeline. Synchronized clocks are mandatory.

**Definition**: [[Network Time Protocol (NTP)]] synchronizes system clocks across a network to a trusted authoritative source. Without sync, log correlation collapses and attack timelines become meaningless.

**Why analysts care**: A one-second clock skew can hide an attack spanning two events. NTP failures are often overlooked but catastrophic for forensics.

**Critical for**:
- [[Log correlation]] — matching events across systems
- [[Forensic analysis]] — establishing timeline
- [[Intrusion detection]] — alerts depend on accurate timestamps
- [[Compliance]] — regulatory logs require timestamp integrity

**Common issues**:
- [[NTP stratum mismatch]] — poor time source selection
- [[Clock drift]] — systems slowly lose sync if NTP fails
- [[Leap second bugs]] — systems crash during UTC leap second insertion

---

### Logging Levels & Tuning

**Analogy**: Logging verbosity is like a camera's zoom. Too zoomed out (low verbosity) and you miss details. Too zoomed in (high verbosity) and you're drowning in meaningless footage.

**Definition**: [[Logging levels]] (DEBUG, INFO, WARNING, ERROR, CRITICAL) control how much detail is recorded. Tuning is the art of capturing enough to detect attacks without overwhelming analysts.

**Why analysts care**: Over-logging creates noise that masks real incidents. Under-logging creates blind spots. Tuning is a continuous process based on what you've seen get missed.

**Tuning strategy**:
- Baseline: INFO level for production
- Escalate DEBUG for suspicious activities or investigation
- Alert on ERROR and CRITICAL automatically
- Track which events historically correlated to breaches

---

## Network Architecture & Deployment Models

### On-Premises vs. Cloud vs. Hybrid

**Analogy**: On-prem is owning a house (full control, full bills). Cloud is renting (landlord handles utilities, less control). Hybrid is owning a house with rented rooms — complexity nightmare.

**Definition**: 
- [[On-premises]]: Organization owns and operates all infrastructure
- [[Cloud]]: Third-party (AWS, Azure, GCP) owns and operates infrastructure
- [[Hybrid]]: Mix of on-prem and cloud, integrated

| Model | Control | Responsibility | Security Focus | Complexity |
|-------|---------|-----------------|-----------------|------------|
| On-Prem | Full | Full | Physical + logical | High |
| Cloud | Limited | Shared (responsibility model) | Identity + API security | Medium |
| Hybrid | Medium | Mixed | Integration points + both | Very High |

**Why analysts care**: Each model has distinct attack surfaces. Cloud attacks focus on [[IAM compromise]] and [[API misuse]]. On-prem attacks focus on [[network traversal]]. Hybrid breaches often exploit the integration seams.

**Hybrid complexity risks**:
- Inconsistent logging between environments
- Trust boundary confusion
- Attackers pivot easily across seams
- Governance fragmented

---

### Network Segmentation

**Analogy**: Segmentation is like a hospital ward system — contagious patients isolated from others, preventing one outbreak from infecting the whole building.

**Definition**: [[Network segmentation]] divides networks into smaller zones using [[VLANs]], firewalls, [[microsegmentation]], and physical separation. Each segment has its own security policy.

**Why analysts care**: Segmentation limits blast radius. If a web server is breached, segmentation prevents direct access to databases. Without it, attackers own the whole network instantly.

**Segmentation technologies**:
- [[VLANs]] — logical separation on same physical network
- [[Firewalls]] — enforce policies between segments
- [[Microsegmentation]] — ultra-granular segment (per-application)
- [[Air-gapped networks]] — physical isolation for critical systems

**Common mistakes**:
- Segmentation on paper, not enforced in practice
- Ov