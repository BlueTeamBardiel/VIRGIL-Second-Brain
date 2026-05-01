---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 006
source: rewritten
---

# Gap Analysis
**Systematically measuring the distance between your current security posture and your desired future state.**

---

## Overview
Gap analysis is the disciplined process of comparing where an organization's [[security posture]] currently stands against where it needs to be to meet business objectives and compliance requirements. For Security+ professionals, understanding gap analysis is critical because it forms the foundation for [[risk management]] planning, resource allocation, and strategic security improvements. This evaluation typically spans weeks or months and involves cross-functional teams gathering data about existing controls, identifying deficiencies, and creating actionable remediation roadmaps.

---

## Key Concepts

### Current State Assessment
**Analogy**: Imagine taking a detailed inventory of your home before renovations—you document every room, what's working, what's broken, and what's outdated.

**Definition**: The thorough documentation and evaluation of all existing [[security controls]], [[policies]], [[procedures]], and technological implementations currently deployed across an organization.

- Requires comprehensive auditing of [[infrastructure]]
- Involves stakeholder interviews and data collection
- Documents both technical and non-technical security measures
- Establishes the baseline from which improvements will be measured

---

### Desired State Framework
**Analogy**: Like setting a blueprint for what your renovated home should look like—it defines your end goal before you start any work.

**Definition**: The target security configuration, compliance standards, and control objectives that an organization commits to achieving based on regulatory requirements, industry standards, and business needs.

| Aspect | Description |
|--------|-------------|
| **Standards Reference** | [[NIST SP 800-171]], CIS Controls, [[ISO 27001]] |
| **Scope** | Defines which controls must be implemented |
| **Timeframe** | Establishes realistic implementation deadlines |
| **Ownership** | Identifies responsible parties for each goal |

---

### Baseline Standards
**Analogy**: Think of a baseline as the instruction manual for your industry—it tells you what "done right" looks like.

**Definition**: Pre-established, industry-specific security reference frameworks that serve as measuring sticks for evaluating organizational security maturity.

**Common Frameworks**:
- [[NIST SP 800-171 Revision 2]] — Protection of Controlled Unclassified Information (CUI) in non-federal systems
- [[CIS Controls]] — Consensus-driven defensive priorities
- [[NIST Cybersecurity Framework]] — For general security governance
- [[ISO 27001]] — International information security management standard
- Sector-specific standards (healthcare [[HIPAA]], financial [[PCI-DSS]], etc.)

---

### Gap Identification
**Analogy**: A construction inspector walks through and notes every detail that doesn't match the blueprint—the gaps ARE the work that needs doing.

**Definition**: The systematic process of documenting specific deficiencies, missing controls, non-compliant configurations, and capability shortfalls between current and desired states.

| Gap Type | Example |
|----------|---------|
| **Control Gap** | No [[multi-factor authentication]] currently deployed |
| **Policy Gap** | Missing incident response procedures |
| **Technical Gap** | Unpatched systems across infrastructure |
| **Awareness Gap** | Insufficient [[security training]] program |
| **Compliance Gap** | Non-adherence to regulatory requirements |

---

### Remediation Planning
**Analogy**: Your contractor creates a project schedule—breaking the renovation into phases, assigning resources, and estimating costs.

**Definition**: The strategic process of developing actionable plans to close identified security gaps, including resource requirements, timeline, budget, and success metrics.

Includes:
- Prioritization based on [[risk assessment]] and impact
- Resource allocation and budgeting
- Implementation phasing and dependencies
- Responsibility assignment
- Success measurement criteria

---

## Exam Tips

### Question Type 1: Gap Analysis Definition & Purpose
- *"During a security assessment, an organization determines it has no [[data classification]] policy, though industry standards require one. This missing element is identified during which process?"* → **Gap analysis** (specifically, a control gap)
- **Trick**: Don't confuse gap analysis with [[risk assessment]]—gap analysis is structural; risk assessment is probabilistic

### Question Type 2: Baseline Framework Selection
- *"A healthcare organization must protect patient data under federal regulations. Which baseline framework is most appropriate?"* → **[[HIPAA]]** combined with [[NIST SP 800-171]] or organizational-specific baselines
- **Trick**: The exam may present multiple valid frameworks—select the one MOST specific to the regulatory context described

### Question Type 3: Gap Analysis Phases
- *"What is the first step in performing a gap analysis?"* → **Establishing a baseline and current state assessment** (you can't measure gaps without knowing both endpoints)
- **Trick**: Some questions test sequencing—current state must come before gap identification, which must come before remediation planning

---

## Common Mistakes

### Mistake 1: Skipping the Baseline
**Wrong**: Starting gap analysis without selecting a reference framework, then trying to decide what "good" looks like mid-analysis
**Right**: Establish your baseline framework BEFORE assessing current state, so you have clear target criteria
**Impact on Exam**: You'll misidentify what actually constitutes a gap; questions testing process sequencing will trip you up

### Mistake 2: Confusing Gap Analysis with Risk Assessment
**Wrong**: Treating gap analysis as a [[vulnerability assessment]] that focuses only on technical flaws and their probability
**Right**: Gap analysis is a structured comparison to standards; [[risk assessment]] is determining likelihood and impact of those gaps
**Impact on Exam**: Questions about compliance frameworks will expect gap analysis language, not risk terminology

### Mistake 3: Underestimating Scope and Timeline
**Wrong**: Believing gap analysis is a quick checklist that can be completed in days
**Right**: Recognizing that comprehensive gap analysis involves stakeholders across the organization and typically requires weeks to months
**Impact on Exam**: Scenario questions testing realistic project planning will expect you to acknowledge the complexity and duration required

### Mistake 4: Focusing Only on Technical Controls
**Wrong**: Limiting gap analysis to technology, ignoring [[policies]], processes, and awareness programs
**Right**: Including administrative, technical, and physical controls plus the people and process dimensions
**Impact on Exam**: Multi-dimensional gap analysis questions will fail if you only discuss firewall and encryption gaps

---

## Related Topics
- [[Risk Assessment]]
- [[NIST SP 800-171]]
- [[Vulnerability Management]]
- [[Security Baseline]]
- [[Compliance]]
- [[Control Framework]]
- [[CIS Controls]]
- [[NIST Cybersecurity Framework]]
- [[Policy Development]]
- [[Security Governance]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*