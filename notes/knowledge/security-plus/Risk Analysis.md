# Risk Analysis

## What it is

In Dark Souls, before pushing through the fog gate to Ornstein and Smough, you weigh what you know: two bosses, your estus count, your build, the souls you'll lose if you die, and whether to summon Solaire. You don't fight blind — you assess what could kill you, how badly, and what mitigations are worth the cost. That's exactly what risk analysis does — it's the structured process of figuring out what could go wrong, how likely it is, and how much it would hurt before you commit resources.

**Risk analysis** is the systematic identification, evaluation, and prioritization of risks to organizational assets, expressed through qualitative or quantitative measures of likelihood and impact, used to drive risk treatment decisions.

## Why it matters

Without risk analysis, security spending becomes vibes-based: you buy the shiny tool the vendor pitched at the conference instead of patching the unpatched domain controller that will actually end your career. Compliance frameworks like [[PCI-DSS]], [[HIPAA]], [[SOC 2]], and [[ISO 27001]] all mandate documented risk assessments — skip it and audits fail. **Exam angle:** SY0-701 Objective 5.2 expects you to distinguish **qualitative vs. quantitative**, calculate **SLE / ARO / ALE**, and recognize **risk register** components. CompTIA's favorite trap: giving you numbers and asking which formula applies, or swapping the definitions of **inherent**, **residual**, and **control risk**.

## Key facts

### Types of risk analysis

| Type | Method | Output | Use case |
|------|--------|--------|----------|
| [[Qualitative Risk Analysis]] | Subjective ratings (Low/Med/High, 1–5) | Heat maps, risk matrix | Fast, no hard data, executive comms |
| [[Quantitative Risk Analysis]] | Monetary calculations | Dollar figures (ALE) | Insurance, capital decisions, ROI |
| **Semi-quantitative** | Hybrid — numeric scales mapped to ranges | Weighted scores | When data is partial |

### Quantitative formulas (memorize these cold)

- **[[Single Loss Expectancy]] (SLE)** = **Asset Value (AV)** × **Exposure Factor (EF)**
- **[[Annualized Rate of Occurrence]] (ARO)** = expected incidents per year (e.g., 0.25 = once every 4 years)
- **[[Annualized Loss Expectancy]] (ALE)** = **SLE** × **ARO**
- Example: Server worth $50,000, ransomware destroys 80% (EF = 0.8), expected once every 5 years (ARO = 0.2). SLE = $40,000. ALE = $8,000/year. Don't spend $20K/year defending it.

### Risk states

| State | Meaning |
|-------|---------|
| [[Inherent Risk]] | Risk before any controls are applied — the raw threat |
| [[Residual Risk]] | Risk remaining after controls are in place |
| [[Control Risk]] | Risk that the controls themselves fail or are bypassed |
| **Risk appetite** | How much risk leadership is willing to accept overall |
| **Risk tolerance** | Acceptable variance around the appetite for a specific risk |
| **Risk threshold** | The trigger point where action is required |

### Risk treatment options

- **[[Risk Acceptance]]** — acknowledge it, document it, move on (ALE < cost of control)
- **[[Risk Avoidance]]** — stop the activity entirely (no cloud, no exposure)
- **[[Risk Mitigation]]** — apply controls to reduce likelihood or impact
- **[[Risk Transference]]** — buy [[Cyber Insurance]] or outsource to a third party
- **Exemption / Exception** — formally documented deviation from policy

### Risk register components

A [[Risk Register]] is the living spreadsheet of all identified risks. Standard fields:
- Risk ID, description, category
- **Likelihood** and **Impact** scores
- Inherent risk rating → controls applied → residual rating
- **Risk owner** (named human, not "IT")
- Treatment decision and target date
- **KRI** ([[Key Risk Indicator]]) thresholds

### Risk reporting artifacts

- **Risk matrix / heat map** — likelihood × impact grid, color-coded
- **Risk register** — the authoritative inventory
- **Risk report** — executive summary tied to business objectives

### Specific risk types Sec+ tests

- **External** vs. **internal** — outside threat actor vs. insider
- **[[Legacy Systems]]** — unpatched, unsupported, irreplaceable
- **Multiparty** — risk shared across vendors and partners
- **IP theft** — loss of trade secrets, patents, source code
- **Software compliance / licensing** — audits, true-ups, BSA letters

### Common CompTIA trap

They will give you SLE and ARO and ask for ALE — or hand you ALE and ask which control is justified. If a control costs more annually than the ALE it eliminates, accepting the risk is the rational answer. The exam rewards business logic, not paranoia.

## Related concepts

[[Risk Management]] · [[Business Impact Analysis]] · [[Threat Modeling]] · [[Vulnerability Assessment]] · [[Risk Register]] · [[Cyber Insurance]] · [[Recovery Time Objective]] · [[Recovery Point Objective]] · [[Mean Time Between Failures]] · [[Third-Party Risk Management]]

---
*Source: VIRGIL knowledge base — 2026-05-08*