---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 103
source: rewritten
---

# Digital Forensics
**The systematic process of capturing, preserving, and analyzing evidence from security incidents for investigation and legal use.**

---

## Overview
When security breaches occur, professionals must methodically gather electronic evidence to reconstruct what happened and establish accountability. Digital forensics combines technical investigation with legal standards to ensure that evidence collected today remains admissible in court proceedings that may occur years later. Understanding these practices is essential for Security+ professionals who may be responsible for evidence preservation and incident documentation.

---

## Key Concepts

### Evidence Collection and Preservation
**Analogy**: Think of it like a crime scene investigator photographing, cataloging, and securing physical evidence in a chain-of-custody log—except you're doing this with digital data instead of fingerprints and weapons.

**Definition**: The process of identifying, acquiring, and maintaining digital data in a way that protects its integrity and legal validity. [[RFC 3227]] establishes industry guidelines for this practice.

**Key Principle**: Maintain strict documentation of every step taken, who accessed the evidence, and when.

---

### Legal Hold
**Analogy**: Like a court order freezing a bank account so funds can't be moved before trial, a legal hold prevents data deletion or modification before litigation.

**Definition**: A formal directive, typically issued by legal counsel, requiring the preservation of specific data within an organization. The designated [[data custodian]] becomes responsible for maintaining that data exactly as it exists.

| Aspect | Details |
|--------|---------|
| **Initiator** | Legal department or external counsel |
| **Recipient** | Data custodian (person with access to systems) |
| **Scope** | Specifies which data types must be preserved |
| **Duration** | Until legal proceeding concludes |
| **Violation Risk** | Spoliation of evidence (legal consequences) |

---

### Acquisition
**Analogy**: Similar to how a photographer must document a crime scene with multiple angles and timestamps, digital acquisition requires capturing complete system states without altering original data.

**Definition**: The collection phase where forensic professionals create forensically sound copies of storage media and system memory. This must be done using [[write-blocking]] tools to prevent accidental modification.

---

### Analysis
**Analogy**: Like reconstructing a shredded document by carefully fitting pieces together, forensic analysis examines collected data for evidence of malicious activity, unauthorized access, or policy violations.

**Definition**: The systematic examination of acquired data to identify artifacts, timelines, and evidence relevant to the security incident or investigation.

---

### Chain of Custody
**Analogy**: Like a relay race where every runner logs their name and time, chain of custody documents every person who handled evidence and when.

**Definition**: The documented record showing who possessed evidence at each stage, when transfers occurred, and what was done with the data. Breaking this chain can render evidence inadmissible in court.

| Component | Requirement |
|-----------|-------------|
| **Documentation** | Record every access and modification |
| **Integrity Verification** | Use [[hashing]] (MD5, SHA-1, SHA-256) to prove data unchanged |
| **Witness** | Have neutral parties observe acquisitions when possible |
| **Timestamps** | Log precise times for all actions |

---

### Data Custodian
**Analogy**: Like a museum curator responsible for protecting priceless artifacts, a data custodian bears responsibility for safeguarding evidence according to legal requirements.

**Definition**: An individual or role designated to maintain control and security of specified data during a legal hold period.

---

## Exam Tips

### Question Type 1: Legal Hold Procedures
- *"Your organization receives a legal hold notice. Which action should the data custodian prioritize?"* → Immediately cease any routine data deletion processes and document current data states; notify IT management and legal.
- **Trick**: Exam may ask about "continuing normal operations"—never do this during a legal hold. All relevant data preservation becomes primary.

### Question Type 2: Chain of Custody Violations
- *"An investigator photographs evidence but fails to document who was present. What is the impact?"* → Evidence integrity is compromised and likely inadmissible in proceedings.
- **Trick**: Questions often present "minor oversights"—even small documentation gaps can invalidate evidence.

### Question Type 3: Forensic Standards
- *"Which RFC provides guidelines for evidence collection?"* → RFC 3227
- **Trick**: Don't confuse with other security RFCs; 3227 is specifically about evidence archiving.

### Question Type 4: Write-Blocking
- *"Why must forensic professionals use write-blocking devices during acquisition?"* → To prevent any accidental or intentional modification to original storage media, maintaining evidence integrity.
- **Trick**: Exam may suggest using "backup software" instead—backups don't prevent writes to original media.

---

## Common Mistakes

### Mistake 1: Confusing Data Preservation with Normal Backups
**Wrong**: "A legal hold is just asking IT to do daily backups like always."
**Right**: A legal hold requires cessation of normal retention policies and explicit preservation of specific datasets exactly as they exist. Backups may not satisfy legal requirements.
**Impact on Exam**: Questions test whether you understand that legal holds change normal operations. You might see "continue standard backup procedures" as a wrong answer.

### Mistake 2: Assuming Only IT Needs to Understand Chain of Custody
**Wrong**: "Chain of custody is only the forensics team's responsibility."
**Right**: Everyone handling evidence—from initial discovery through analysis to court presentation—must document their involvement. Every handoff matters.
**Impact on Exam**: Expect questions about entire organizational responsibility, not just investigators.

### Mistake 3: Treating All Data the Same Under Legal Hold
**Wrong**: "Just preserve everything when a legal hold arrives."
**Right**: Legal holds specify particular data types, timeframes, and scopes. Over-preservation wastes resources; under-preservation violates the hold.
**Impact on Exam**: Look for answer choices that discuss "targeted" versus "blanket" preservation approaches.

### Mistake 4: Overlooking Metadata and System Artifacts
**Wrong**: "Forensics only cares about user files, not system logs or swap files."
**Right**: Complete forensic acquisition includes everything: file metadata, deleted data in free space, system memory, application caches, logs, and temporary files. These often provide crucial timeline evidence.
**Impact on Exam**: Questions may ask what should be acquired during a forensic investigation—expect comprehensive answers.

### Mistake 5: Assuming Old Cases Don't Matter for Current Practice
**Wrong**: "Data collection standards have changed since that 2010 incident."
**Right**: Evidence collected today may be used in proceedings 5-10 years from now under standards that may change. Current best practices (RFC 3227) ensure future admissibility.
**Impact on Exam**: Expect questions emphasizing why current forensic rigor matters for future-proofing evidence.

---

## Related Topics
- [[Incident Response]] (framework that includes forensics)
- [[Data Preservation]]
- [[Write-Blocking Devices]]
- [[Hashing and Integrity Verification]]
- [[RFC 3227]]
- [[Legal and Compliance Requirements]]
- [[Incident Documentation]]
- [[Evidence Handling]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*