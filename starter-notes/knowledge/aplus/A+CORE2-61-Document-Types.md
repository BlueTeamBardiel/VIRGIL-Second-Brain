---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 61
source: rewritten
---

# Document Types
**Critical paperwork that transforms chaos into organized response.**

---

## Overview

IT environments generate mountains of documentation that serve as the backbone of organizational knowledge and crisis response. Understanding the major document types—especially [[Incident Reports]] and [[Standard Operating Procedures]]—is essential for the A+ exam because you'll be expected to know when to create them, what they contain, and how they function within a broader [[Incident Response Plan]]. These aren't just busywork; they're your organization's institutional memory and playbook.

---

## Key Concepts

### Incident Reports

**Analogy**: Think of an incident report like a crime scene investigation report. The detective doesn't just say "something happened." They document what was there *before* the crime, *during* the crime, and what actions were taken *after* discovering it. Same structure, applied to IT systems.

**Definition**: A formal [[Documentation|document]] created following a [[Security Incident]] or system disruption that chronologically details the events leading up to the problem, the incident itself, and the organization's response actions.

**What It Contains**:
- Timeline of events preceding the issue
- Description of what actually occurred
- Impact assessment
- Actions taken to remediate
- Lessons learned

This creates an ongoing [[Database]] of incidents that allows your organization to spot patterns and prevent future occurrences.

### Standard Operating Procedures (SOPs)

**Analogy**: Imagine a cookbook for your IT kitchen. Every restaurant has recipes written down so that whether Chef Alice or Chef Bob is working, the lasagna comes out the same way every time. SOPs are your recipes for IT tasks.

**Definition**: Comprehensive, standardized [[Documentation|written guidelines]] that outline the exact steps, contacts, and processes an organization must follow for any recurring situation—from routine maintenance to emergency response.

**Common SOP Scenarios**:
- [[Downtime]] response and communication chains
- [[Facilities]] emergencies (power loss, HVAC failure)
- Data backup procedures
- User access provisioning
- Security breach escalation

| Element | Purpose |
|---------|---------|
| Step-by-step procedures | Ensures consistency |
| Contact lists | Clarifies who to notify and when |
| Decision trees | Guides judgment calls |
| Escalation paths | Routes problems to right authority |

### Incident Response Plan

**Analogy**: If SOPs are recipes, an [[Incident Response Plan]] is the entire restaurant's operational manual—it tells you which recipes to use, who's in charge of each station, and how communication flows when the health inspector shows up.

**Definition**: An overarching [[Policy|organizational policy]] that outlines the formal process and structure for responding to any [[Security Incident|security or operational incident]], including roles, responsibilities, and decision-making authority.

**Why It Matters**: Without a plan, every incident becomes chaos. With one, your team knows exactly what to do before the crisis even starts.

---

## Exam Tips

### Question Type 1: Document Selection
- *"A server goes down unexpectedly. Which document should the tech team consult first?"* → **Standard Operating Procedures** (specifically the downtime SOP)
- *"After the outage is resolved, what should be created?"* → **Incident Report** (to document what happened and how it was fixed)
- **Trick**: Don't confuse "what do we do?" (SOP) with "what did we do?" (Incident Report). The exam loves this distinction.

### Question Type 2: Incident Response Framework
- *"Your organization has established formal procedures for handling security breaches. This is an example of..."* → **Incident Response Plan**
- **Trick**: SOPs are *specific* (downtime, backups, etc.). Incident Response Plans are *overarching* (the framework that decides *which* SOPs to activate).

---

## Common Mistakes

### Mistake 1: Confusing SOPs with Incident Reports
**Wrong**: "An SOP is just a detailed description of what happened during an incident."
**Right**: SOPs are *prescriptive* (telling you what to do *before* something happens). Incident Reports are *descriptive* (telling you what you did *after* something happened).
**Impact on Exam**: You'll see scenario questions where you need to distinguish whether the question is asking about planning (SOP) or post-mortems (Incident Report).

### Mistake 2: Thinking Documentation is Optional
**Wrong**: "We'll just handle incidents as they come and skip the paperwork."
**Right**: Formal documentation creates institutional knowledge, prevents repeated mistakes, demonstrates compliance, and provides evidence for [[Root Cause Analysis]].
**Impact on Exam**: A+ test scenarios assume mature, documented processes. The "right" answer almost always involves proper documentation.

### Mistake 3: Forgetting the Full Incident Report Timeline
**Wrong**: Only documenting the incident itself, leaving out context.
**Right**: Including three sections—*before* (what led to it), *during* (the incident), *after* (response and resolution).
**Impact on Exam**: Questions about incident reports often test whether you understand the full scope of what needs to be documented, not just the problem itself.

---

## Related Topics
- [[Incident Response Plan]]
- [[Security Incident|Security Incidents]]
- [[Root Cause Analysis]]
- [[Documentation]]
- [[Standard Operating Procedures]]
- [[Change Management]]
- [[Compliance]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*