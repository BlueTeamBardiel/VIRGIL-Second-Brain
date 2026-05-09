# Risk Management

## What it is

In Stardew Valley, you start spring with limited gold, a rusty watering can, and a calendar full of decisions: plant parsnips (cheap, predictable, low return) or sink everything into strawberries on day 13 (high yield, but you might run out of energy, the crows might eat them, and a lightning strike could fry the whole row). Pierre's seed shop, the Joja membership, the mine floors you're not ready for — every choice trades cost against possible catastrophe against possible payoff. That's exactly what **risk management** does — it's the structured process of deciding which threats to spend money preventing, which to insure against, which to accept, and which to walk away from entirely.

**Risk management** is the continuous identification, assessment, prioritization, and treatment of risks to organizational assets, operations, and objectives within an acceptable tolerance defined by leadership.

## Why it matters

Without a formal risk management process, security spending becomes either paranoid (gold-plating low-impact systems) or negligent (ignoring the breach waiting to happen), and auditors will gut you for both. SY0-701 Objective 5.2 explicitly tests **risk identification**, **assessment types (qualitative vs. quantitative)**, **risk analysis (SLE, ALE, ARO)**, **risk register**, **risk tolerance/appetite**, and **risk management strategies (transfer, accept, avoid, mitigate, exemption, exception)**. The classic CompTIA trap: confusing **risk appetite** (forward-looking willingness) with **risk tolerance** (acceptable variance from that appetite), and miscalculating **ALE** when the question buries SLE inside an asset value and exposure factor.

## Key facts

### The risk equation

**Risk = Threat × Vulnerability × Impact** — you need all three. A [[threat]] with no [[vulnerability]] is theater; a vulnerability with no threat actor is a research paper; either with no [[impact]] is a Tuesday.

### Risk identification and assessment types

| Type | Method | Output | Use when |
|---|---|---|---|
| **Qualitative** | Subjective ratings (High/Med/Low, 1–5) | Heat map, ranked list | Fast, broad coverage, intangibles |
| **Quantitative** | Dollar values, probabilities | ALE, ROI calculations | Justifying budget, insurance |
| **Semi-quantitative** | Numeric bands on qualitative scales | Weighted scores | Hybrid programs |

### Quantitative formulas (memorize cold)

- **SLE** ([[Single Loss Expectancy]]) = **Asset Value (AV) × Exposure Factor (EF)**
- **ALE** ([[Annualized Loss Expectancy]]) = **SLE × ARO**
- **ARO** ([[Annualized Rate of Occurrence]]) = expected incidents per year (0.5 = once every two years)
- **Control is worth it when:** cost of control < ALE_before − ALE_after

Example: $200,000 server, 25% destroyed by flood, floods every 4 years. SLE = $50,000. ARO = 0.25. ALE = $12,500/year. A $5,000/year flood control passes. A $20,000/year one doesn't.

### Risk treatment strategies

| Strategy | What you do | Stardew parallel |
|---|---|---|
| **[[Risk Mitigation]]** | Reduce likelihood/impact via controls | Build scarecrows |
| **[[Risk Transference]]** | Shift to a third party (insurance, contracts) | Crop insurance from… well, you wish |
| **[[Risk Acceptance]]** | Acknowledge and absorb the risk | Plant strawberries anyway |
| **[[Risk Avoidance]]** | Don't do the risky thing at all | Skip the mines until you have better gear |
| **[[Risk Exemption]]** | Formal, policy-backed pass from a requirement | Granted permanently |
| **[[Risk Exception]]** | Temporary deviation with compensating controls | Granted with expiration |

### Appetite vs. tolerance vs. capacity

- **[[Risk Appetite]]** — the *amount* of risk leadership is willing to pursue (expansionary, neutral, conservative)
- **[[Risk Tolerance]]** — acceptable *variance* around that appetite ("we'll accept ±10%")
- **[[Risk Capacity]]** — the maximum risk the org can absorb before it breaks

CompTIA loves swapping these in answer choices. Appetite = strategy. Tolerance = wiggle room.

### Risk register and reporting

The **[[Risk Register]]** is the canonical record. Expected fields:
- **Risk ID**, **Description**, **Owner**
- **Inherent risk** (before controls), **Residual risk** (after controls)
- **Likelihood**, **Impact**, **Risk score**
- **Treatment strategy**, **Control(s)**, **Status**, **Review date**
- **[[KRI]]** (Key Risk Indicator) thresholds

### Inherent vs. residual vs. control risk

- **[[Inherent Risk]]** — risk before any controls applied
- **[[Residual Risk]]** — risk remaining after controls applied (never zero)
- **[[Control Risk]]** — risk that the control itself fails

### Third-party and supply chain risk

Vendor risk lives here too: **[[Due Diligence]]**, **[[Due Care]]**, **[[SLA]]**, **[[MSA]]**, **[[BPA]]**, **[[NDA]]**, and right-to-audit clauses. The SolarWinds-shaped hole in your network is somebody else's risk you accepted by signing the contract.

## Related concepts

[[Business Impact Analysis]] · [[Quantitative Risk Analysis]] · [[Qualitative Risk Analysis]] · [[Risk Register]] · [[KRI]] · [[KPI]] · [[Threat Modeling]] · [[Vulnerability Management]] · [[Compensating Controls]] · [[Third-Party Risk Management]] · [[Governance Risk Compliance]] · [[MTTR]] · [[RTO]] · [[RPO]]

---
*Source: VIRGIL knowledge base — 2026-05-08*