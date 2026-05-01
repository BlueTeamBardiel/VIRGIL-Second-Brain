---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 111
source: rewritten
---

# Risk Analysis
**Understanding how to measure and categorize organizational threats using structured evaluation frameworks.**

---

## Overview
Risk evaluation demands a systematic approach because every organization faces unique threat landscapes shaped by countless variables. Security+ professionals must master methods to quantify and compare these risks to guide resource allocation. This foundation enables you to recommend controls where they matter most and justify security investments to leadership.

---

## Key Concepts

### Qualitative Risk Assessment
**Analogy**: Imagine a restaurant manager walking through the kitchen and noting "the wet floor is dangerous" versus measuring exact slip probability—one uses judgment and categories, the other uses numbers. Qualitative assessment is the first approach.

**Definition**: A [[risk assessment]] methodology that evaluates [[threat|threats]] and [[vulnerability|vulnerabilities]] using descriptive categories (Low, Medium, High) rather than numerical values. It relies on expert judgment, organizational context, and comparative analysis.

**Related Elements**: 
- [[Impact Analysis|Impact]] — severity if threat occurs
- [[Likelihood|Annualized Rate of Occurrence (ARO)]] — how often the threat materializes per year
- [[Cost-Benefit Analysis|Control Costs]] — expense of implementing countermeasures
- [[Risk Matrix|Traffic Light Grid]] — visual representation tool

| Component | Purpose | Example |
|-----------|---------|---------|
| Impact | Consequence severity | Low/Medium/High business disruption |
| ARO | Frequency estimation | How many times per year this occurs |
| Control Cost | Mitigation expense | Budget needed to implement fix |
| Overall Risk | Final ranking | Composite severity for prioritization |

---

### Risk Prioritization Through Visual Grids
**Analogy**: Think of a stoplight system—red means "stop and fix immediately," yellow means "slow down and plan," green means "proceed with normal operations."

**Definition**: Using color-coded matrices to quickly communicate risk severity across multiple organizational factors, making it easy for stakeholders to identify which threats demand urgent attention.

**Common Scenarios**:

| Threat | Impact | ARO | Control Cost | Overall Risk |
|--------|--------|-----|--------------|--------------|
| [[Legacy Systems\|Outdated Windows clients]] | Medium | **High (Red)** | Medium | **HIGH** |
| [[Security Awareness\|Untrained personnel]] | Low | Medium | Low | Medium |
| [[Malware\|Systems without antivirus]] | Medium | **High (Red)** | Medium | **HIGH** |

---

## Exam Tips

### Question Type 1: Identifying Risk Components
- *"An organization discovers 200 unpatched servers. The potential downtime would cost $50,000 per hour. Patching costs $15,000. What is this primarily measuring?"* → [[Impact]] and [[Cost-Benefit Analysis|control cost comparison]]
- **Trick**: Don't confuse [[Likelihood|likelihood]] with [[Impact]]. A low-probability, high-impact event (data breach) still deserves attention.

### Question Type 2: Qualitative vs. Quantitative
- *"Management wants to quickly categorize 15 different security risks without detailed financial modeling. Which approach?"* → [[Qualitative Risk Assessment]] using a [[Risk Matrix]]
- **Trick**: Qualitative doesn't mean "less rigorous"—it's rigorous judgment, just not mathematical formulas.

### Question Type 3: Control Decision-Making
- *"The board asks why we're spending $100K to prevent a threat with low probability. How do you explain?"* → Discuss [[Impact]]: even rare threats with catastrophic consequences justify investment.
- **Trick**: [[ARO]] alone doesn't determine priority—multiply mentally: High Impact × Low Likelihood can still equal High Risk.

---

## Common Mistakes

### Mistake 1: Treating All High-Frequency Risks as Critical
**Wrong**: "We get phishing emails constantly, so it's our highest risk."
**Right**: Phishing has high [[Likelihood|ARO]] but may have low [[Impact]] if users are trained and email filtering exists. Medium Risk ≠ High Risk.
**Impact on Exam**: You'll misallocate resources in scenario questions. Test makers reward those who balance frequency AND consequence.

### Mistake 2: Ignoring Control Costs in Risk Decisions
**Wrong**: "Any risk rated High must be fully mitigated immediately."
**Right**: A High Risk with a $500K mitigation strategy might be [[Risk Acceptance|accepted]] if remediation costs exceed potential loss. This is [[Risk Management]] maturity.
**Impact on Exam**: Questions will present a High Risk but ask "what should management do?"—the answer might be accept it, not fix it.

### Mistake 3: Confusing Qualitative Assessment with Vague Judgment
**Wrong**: "We'll just pick colors randomly based on gut feeling."
**Right**: Even qualitative assessment requires documented [[Criteria]] for what constitutes Low/Medium/High in your organization. Consistency matters.
**Impact on Exam**: You'll lose points on risk assessment methodology questions if you can't explain the framework's logic.

### Mistake 4: Neglecting to Revisit Risk Ratings
**Wrong**: "We did the assessment once; it never changes."
**Right**: [[Threat Landscape|Threat landscapes]], [[Vulnerability|vulnerabilities]], and control costs evolve. Annual reassessment is standard practice.
**Impact on Exam**: Multi-part scenarios may ask "six months later, what changes?" Know that risk analysis is iterative.

---

## Related Topics
- [[Quantitative Risk Assessment]] — numerical approach using [[Single Loss Expectancy|SLE]] and [[Annualized Loss Expectancy|ALE]]
- [[Risk Management Framework]] — structured process for identifying, analyzing, and treating risk
- [[Threat Modeling]] — identifying where risks originate
- [[Cost-Benefit Analysis]] — justifying security investments
- [[Risk Acceptance]] — when organizations consciously decide not to mitigate
- [[Business Impact Analysis]] — understanding organizational consequences
- [[Security Metrics]] — measuring control effectiveness over time

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*