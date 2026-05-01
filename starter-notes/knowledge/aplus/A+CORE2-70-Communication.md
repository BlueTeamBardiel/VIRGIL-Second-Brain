---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 70
source: rewritten
---

# Communication
**The hidden superpower that separates entry-level techs from IT leaders.**

---

## Overview

Most IT professionals obsess over mastering [[Operating Systems]], [[Network Architecture]], and [[Security Protocols]], yet they stumble when talking to actual humans about their problems. The truth? Your ability to bridge the gap between tech-speak and business language is what gets you promoted, keeps customers happy, and honestly—what makes you hireable. Communication isn't soft skills fluff; it's a core technical competency on the A+ exam and in real-world IT.

---

## Key Concepts

### Audience Awareness & Language Adaptation

**Analogy**: Imagine you're a doctor who can only speak in Latin. You know medicine perfectly, but if your patient doesn't understand "dyspepsia," they can't follow your treatment plan. Same with IT—your technical knowledge means nothing if your audience can't decode it.

**Definition**: [[Audience Awareness]] is the practice of adjusting your communication style, vocabulary, and depth of explanation based on who you're talking to. With fellow technicians, you can use [[Acronyms]] and technical jargon freely. With end-users, management, and customers, you must translate technical concepts into business-friendly language.

**Key Distinction**:

| Audience | Approach | Example |
|----------|----------|---------|
| **IT Peers** | Use acronyms, technical depth, assume knowledge | "The RAID-5 array experienced controller failure; I'm rebuilding via hot-swap." |
| **End Users** | Plain English, avoid jargon, explain impact | "Your storage is temporarily slower because one of the backup drives failed. We're replacing it now." |
| **Management/C-Suite** | Business impact focus, ROI, risk assessment | "This outage cost us $5,000/hour and affects 30% of staff productivity. Replacement takes 4 hours." |

### The Translator Role

**Analogy**: Think of yourself as a bridge between two countries speaking different languages. One side speaks in [[RAM]], [[Latency]], and [[Packet Loss]]. The other side speaks in "profit," "efficiency," and "revenue." Your job is the interpretation.

**Definition**: As an IT professional, your fundamental responsibility is to convert technical realities into business-understandable statements that decision-makers can act on. This means:
- Removing all unnecessary [[Jargon]]
- Explaining the *why* behind the technical *what*
- Connecting technical problems to business consequences
- Presenting solutions in terms of outcomes, not features

### Avoiding Acronyms in Customer Communication

**Analogy**: Imagine someone describing your car problem using only manufacturer part codes. You hired them because you don't speak that language—now they're making it worse.

**Definition**: [[Acronyms]] (like [[DNS]], [[DHCP]], [[API]], [[VPN]]) are efficient shortcuts among technicians but create barriers with non-technical stakeholders. Effective communication means replacing them with plain-language equivalents or brief explanations.

| Acronym | Never Say This To Customers | Say This Instead |
|---------|-----|---|
| [[DNS]] | "The DNS server is down" | "The system that translates website names to addresses isn't working" |
| [[DHCP]] | "DHCP lease expired" | "Your device lost its network address assignment" |
| [[RAM]] | "You're maxing out your RAM" | "Your computer is running out of temporary working memory" |
| [[VPN]] | "Connect via VPN" | "Use this secure tunnel to access company resources safely from home" |

### Information Presentation & Decision Support

**Analogy**: A CEO doesn't need a blueprint of a building—they need to know if it's safe, on budget, and ready for tenants. Give them what matters to *their* job.

**Definition**: When presenting technical information to non-technical decision-makers, structure your communication around three pillars:
1. **What happened** (the problem in plain terms)
2. **What it costs** (business impact: downtime, lost productivity, security risk)
3. **What we're doing** (solution timeline and expected outcome)

---

## Exam Tips

### Question Type 1: Customer/User Communication Scenarios
- *"A user calls saying 'My computer is laggy.' Which response is MOST appropriate?"*
  - **Wrong**: "Your [[L3 Cache]] is saturated and you're experiencing memory paging from your [[HDD]]."
  - **Right**: "It sounds like your computer is working harder than it should. Let me check what programs are running in the background and see if we can speed things up."

- *"A manager asks why a [[Windows Update]] installation failed. What do you explain?"* → Focus on business impact ("This affects system security and file sharing") not technical minutiae ("The [[Registry]] rollback failed because...").

- **Trick**: The exam loves testing whether you recognize *when* to use technical language vs. plain language. Watch for answer choices that use unnecessary acronyms when talking to end-users.

### Question Type 2: Professional Documentation & Reports
- *"What should you include in a ticket summary for a customer-facing issue?"* → Clear problem description, customer-friendly language, estimated resolution time—NOT deep technical logs.

- **Trick**: Some answers will include accurate technical info but in the wrong *tone* for the audience. Always ask yourself: "Would a non-tech person understand this?"

---

## Common Mistakes

### Mistake 1: Assuming Your Audience Knows Tech Acronyms
**Wrong**: "Your [[GPU]] isn't rendering properly due to outdated drivers. Flash your [[BIOS]] and reinstall from [[UEFI]]."
**Right**: "Your graphics card software needs an update. I'm going to restart your computer and install the latest version."
**Impact on Exam**: CompTIA specifically tests your ability to communicate across audience levels. A high score requires demonstrating you *know* when NOT to use jargon, not just knowing the jargon itself.

### Mistake 2: Overwhelming Users with Technical Depth
**Wrong**: Launching into a 10-minute explanation of [[TCP/IP]] [[packet structure]] when someone asks why email is slow.
**Right**: "Your email is taking longer because there's congestion on our network right now. We're monitoring it and should have it back to normal within an hour."
**Impact on Exam**: Efficiency and clarity matter. The correct answer prioritizes what the user *needs* to know, not everything you *could* tell them.

### Mistake 3: Forgetting Business Context in Documentation
**Wrong**: Ticket notes: "[[DHCP]] pool exhaustion detected on [[VLAN]] 7. Implemented [[subnet]] expansion and restarted [[DHCP server]]."
**Right**: Ticket notes: "Users on the 3rd floor couldn't connect to the network because we ran out of available addresses. Expanded capacity and restored service."
**Impact on Exam**: Management reviews these tickets. Show you understand how technical problems affect the business, not just how to fix them.

### Mistake 4: Using Slang or Overly Casual Language with Executives
**Wrong**: "Yo, your servers are totally toast. We gotta nuke the storage array."
**Right**: "We've encountered a critical storage failure. Our team is working to recover data and restore service within the next 4 hours."
**Impact on Exam**: Professionalism is part of communication competency. Maintain respect and credibility with all audience levels.

---

## Related Topics
- [[Active Listening]]
- [[Soft Skills in IT]]
- [[Customer Service]]
- [[Troubleshooting Methodology]] (documenting findings clearly)
- [[IT Professionalism]]
- [[Network Concepts]] ([[DNS]], [[DHCP]], [[VPN]])
- [[System Architecture]] ([[RAM]], [[GPU]], [[BIOS]], [[UEFI]])

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*