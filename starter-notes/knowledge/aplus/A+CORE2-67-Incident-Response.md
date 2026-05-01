---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 67
source: rewritten
---

# Incident Response
**Preserving evidence and coordinating action when security breaches occur.**

---

## Overview

When a [[security incident]] happens, you're dealing with a crime scene—except your evidence might be invisible. The A+ exam expects you to understand how to protect, document, and report that evidence so it holds up under scrutiny. This is foundational because A+ technicians are often first responders, and contaminating evidence can destroy an investigation.

---

## Key Concepts

### Chain of Custody

**Analogy**: Think of a chain of custody like a signed delivery receipt. Every time someone handles a package, they initial it. If the package arrives damaged, you know exactly who touched it and when.

**Definition**: A documented trail showing every person who has contacted, accessed, or possessed [[evidence]] during an [[incident response]]. It prevents tampering claims and proves [[integrity]].

**Why it matters**: 
- Legal defensibility in court proceedings
- Proves evidence wasn't modified or contaminated
- Identifies who accessed what and when

| Aspect | Physical Evidence | Digital Evidence |
|--------|------------------|-----------------|
| Storage | Sealed, labeled bags | Hash verification |
| Access Log | Manual sign-in sheet | Digital signatures |
| Tracking | Written documentation | Audit logs & timestamps |

### First Response Procedures

**Analogy**: You're a firefighter arriving at a burning building. Your first job isn't to put out the fire—it's to assess what's actually burning and call for backup.

**Definition**: The initial steps taken when [[incident response|responding to a breach]], including [[identification]], [[assessment]], and [[escalation]].

**Steps**:
1. **Identify** the issue using [[logs]], witness statements, and [[monitoring]] data
2. **Assess** severity and scope
3. **Escalate** to proper [[incident response]] channels

### Evidence Integrity

**Analogy**: A photograph's fingerprint. Just like every photo file has metadata, digital evidence needs a [[hash]] that proves "this file hasn't changed since I first collected it."

**Definition**: Verifying that evidence hasn't been altered, deleted, or tampered with using cryptographic [[hashing]] and [[digital signatures]].

```
# Hash verification example
$ md5sum suspicious_file.exe
a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6  suspicious_file.exe

# Compare later to ensure no changes
$ md5sum suspicious_file.exe
a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6  suspicious_file.exe
# Match = integrity verified ✓
```

### Incident Reporting & Escalation

**Analogy**: Your IT department has an emergency contact tree, like a fire evacuation plan. You don't improvise who to call—you follow the list.

**Definition**: Notifying designated [[stakeholders]], management, and potentially [[law enforcement]] through established [[incident response]] procedures.

**Key contacts typically include**:
- [[IT Security]] team lead
- Management/executives
- [[Legal]] department (if breach involves data)
- Local [[law enforcement]] (if criminal activity suspected)

---

## Exam Tips

### Question Type 1: Chain of Custody Scenarios
- *"Which documentation method best preserves the integrity of a hard drive seized as evidence?"* → Using a sealed evidence bag with signed chain of custody form and [[cryptographic hash]] values recorded at collection time.
- **Trick**: Don't confuse "documenting who touched it" with "preventing access." Chain of custody is about *recording* access, not *restricting* it.

### Question Type 2: First Responder Identification
- *"You discover unusual network traffic. What's your first action?"* → Check [[logs]] and monitoring tools to identify the scope, THEN report through proper channels.
- **Trick**: Students pick "isolate the system immediately" when the question actually wants you to identify the problem first.

### Question Type 3: Evidence Protection Methods
- *"What prevents tampering with digital files during incident response?"* → [[Hash verification]] (MD5, SHA-256) proves the file hasn't changed.
- **Trick**: Physical sealing alone doesn't work for digital evidence—you need [[cryptographic integrity checks]].

---

## Common Mistakes

### Mistake 1: Assuming Chain of Custody Is Only for Physical Evidence
**Wrong**: "Chain of custody only matters when you have a hard drive in a bag."
**Right**: Digital evidence also requires [[chain of custody]]—documented access logs, [[digital signatures]], and [[hash]] verification at every step.
**Impact on Exam**: You'll miss questions about securing cloud data or log files if you think chain of custody is physical-only.

### Mistake 2: Identifying the Incident But Not Escalating
**Wrong**: You find suspicious activity in logs but only report it to your team lead, not to the pre-established incident response contact list.
**Right**: Identify the issue, THEN immediately escalate through official channels (which may include management, legal, law enforcement).
**Impact on Exam**: Questions often test whether you know escalation procedure is a *required step*, not optional.

### Mistake 3: Modifying Evidence While "Investigating"
**Wrong**: Opening a suspected malware file to see what it does, copying it to your desktop to analyze, or clearing logs to "clean things up."
**Right**: Preserve the evidence exactly as found. If analysis is needed, use a forensic copy with documented [[hash]] values.
**Impact on Exam**: A+ emphasizes that first responders should *preserve*, not alter. This is tested heavily.

### Mistake 4: Forgetting [[Law Enforcement]] Escalation
**Wrong**: Assuming all incidents stay internal—just report to IT leadership.
**Right**: Some breaches (data theft, ransomware with ransom demands) legally require [[law enforcement]] notification.
**Impact on Exam**: Watch for questions that include criminal activity—they're testing if you know escalation goes beyond your IT department.

---

## Related Topics
- [[Security Incident]]
- [[Forensics]]
- [[Logging and Monitoring]]
- [[Digital Signatures]]
- [[Cryptographic Hashing]]
- [[Law Enforcement Collaboration]]
- [[Incident Response Team]]
- [[Evidence Handling]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*