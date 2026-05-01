---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 68
source: rewritten
---

# Privacy, Licensing, and Policies
**Understanding software licensing models and organizational compliance requirements is essential for managing IT infrastructure legally and securely.**

---

## Overview

Every piece of software running on your organization's computers comes with a legal agreement that defines how you're allowed to use it. Think of it like renting an apartment—you don't own the building, you own the right to live there under specific conditions. These licensing agreements protect both the software publisher and your company by establishing clear rules about usage, copying, and support. For the A+ exam, you need to understand the different licensing models and why companies choose one over another.

---

## Key Concepts

### Per-Seat Licensing

**Analogy**: Imagine a concert venue where each ticket is tied to one specific numbered seat. You can't move your ticket to another seat, and each person needs their own ticket.

**Definition**: A [[licensing]] model where one license equals one user. If your organization has 50 employees who need accounting software, you must purchase 50 per-seat licenses—one for each person, regardless of when they use it.

**Key Characteristics**:
- License tied to an individual user or device
- Predictable costs based on headcount
- Most common for traditional enterprise software

---

### Concurrent Licensing

**Analogy**: Think of a library with 10 computers available. Even if 50 people have library cards, only 10 can use a computer at the same time. When someone logs off, another person can use that machine.

**Definition**: A [[licensing]] model that limits simultaneous users rather than total users. The license count reflects how many people can actively use the software at one moment.

**Key Characteristics**:
- Based on simultaneous usage, not total users
- Cost-effective for rotating shifts or shared workstations
- Requires license management tools to track active sessions

| Scenario | Per-Seat | Concurrent |
|----------|----------|-----------|
| 30 employees, all use software daily | 30 licenses needed | 30 licenses needed |
| 30 employees, only 15 use at once | 30 licenses needed | 15 licenses needed |
| 100 shift workers, 25 per shift | 100 licenses needed | 25 licenses needed |

---

### Duration-Based (Subscription) Licensing

**Analogy**: Like a Netflix subscription—you pay monthly to access content, but when you stop paying, access ends. No permanent ownership.

**Definition**: [[Licensing]] structured as a time-bound subscription (annual, multi-year, or monthly). Access expires on a specific date, requiring renewal to continue using the software.

**Key Characteristics**:
- Continuous payment model
- Updates and support typically included
- Access terminates at expiration without renewal
- Common for cloud software and SaaS applications

---

### Personal/Home Use Licensing

**Analogy**: When you buy a single-player video game for your console, you own the right to play it on that specific console, but you can't sell copies to your friends.

**Definition**: [[Licensing]] intended for individual, non-commercial use, typically tied to one computer or device. Often includes restrictions against organizational or commercial use.

**Key Characteristics**:
- Lower cost than enterprise licenses
- Usually non-transferable between machines
- Prohibits business/commercial use
- Home versions often limited in features

---

### License Compliance and Auditing

**Analogy**: Like a restaurant health inspector checking if the kitchen meets code requirements, software audits verify you own licenses for every installation.

**Definition**: The process of tracking, documenting, and verifying that your organization owns sufficient licenses for all installed software. [[Compliance]] failures can result in significant fines and legal action.

**What Gets Audited**:
- Number of installed copies vs. licensed copies
- User assignments and transfers
- Subscription renewal dates
- Usage rights compliance

---

## Exam Tips

### Question Type 1: Licensing Model Selection
- *"Your company has 100 employees working in 4 rotating shifts. Each shift has 20 people working simultaneously on design software. Which licensing model is most cost-effective?"* → **Concurrent licensing (20 licenses needed)**
- **Trick**: Don't confuse total employees with concurrent users. The exam often tries to make you over-purchase licenses.

### Question Type 2: License Expiration and Renewal
- *"A software subscription expires on June 30th. What happens if the company doesn't renew by that date?"* → **Access terminates; software becomes non-functional or limited**
- **Trick**: Duration licenses aren't like perpetual licenses—they actually stop working, not just stop receiving updates.

### Question Type 3: Personal vs. Enterprise Use
- *"Which type of software license can a company legally use for business operations?"* → **Enterprise/per-seat/concurrent licenses ONLY**
- **Trick**: Using personal licenses in a business environment violates terms and is illegal, even if it's technically possible.

---

## Common Mistakes

### Mistake 1: Confusing User Count with Concurrent Usage

**Wrong**: "We have 80 employees, so we need 80 concurrent licenses."

**Right**: "We have 80 employees, but only 20 work the night shift simultaneously. With concurrent licensing, we need 20 licenses."

**Impact on Exam**: You'll select incorrect license quantities and misunderstand cost scenarios. The exam tests whether you understand the *practical difference* between these models.

---

### Mistake 2: Thinking Personal Licenses are Cheaper Solutions for Business

**Wrong**: "Personal licenses cost less, so we'll buy 50 personal licenses instead of 50 enterprise licenses."

**Right**: "Personal licenses explicitly prohibit commercial/organizational use. We must purchase enterprise licenses regardless of cost."

**Impact on Exam**: The exam tests legal compliance, not budget shortcuts. You'll face questions designed to see if you understand that unlicensed use violates agreements and law.

---

### Mistake 3: Assuming Expired Licenses Still Provide Access

**Wrong**: "Our subscription expired last month, but the software still runs, so we're fine."

**Right**: "Subscription licenses have hard expiration dates. Once expired, you're using unlicensed software and are in violation."

**Impact on Exam**: Questions test whether you understand the *ongoing nature* of subscription licensing and the requirement to renew before expiration.

---

### Mistake 4: Misunderstanding License Transferability

**Wrong**: "We can move our personal license from one computer to another whenever we want."

**Right**: "Personal licenses are typically non-transferable. Transferring it to different hardware violates the license agreement."

**Impact on Exam**: The exam includes scenarios about moving licenses between machines or users—you need to know which license types allow this.

---

## Related Topics
- [[Software Asset Management (SAM)]]
- [[Intellectual Property Rights]]
- [[End-User License Agreement (EULA)]]
- [[Terms of Service]]
- [[Data Privacy Regulations]]
- [[Organizational Policies]]
- [[Acceptable Use Policy (AUP)]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*