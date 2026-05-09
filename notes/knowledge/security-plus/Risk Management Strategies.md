# Risk Management Strategies

## What it is

In Tears of the Kingdom, when you face a Gloom Hands, you have four real options: fight them with everything you've got (Mineru's construct + a fused Silver Lynel horn), run away entirely, slap on Gloom-resistant armor and tank the chip damage, or hand the problem to Tulin's wind gust to scatter them. That's exactly what risk management strategies do — they are the four levers an organization pulls when a threat looms over an asset.

A **risk management strategy** is the formal decision an organization makes about how to handle an identified risk: **mitigate**, **transfer**, **accept**, or **avoid** (with **exemption** and **exception** as governance variants).

## Why it matters

Pick the wrong strategy and you either burn money defending things that don't matter, or you "accept" a risk that ends up on the front page of Krebs. CompTIA SY0-701 Objective 5.2 explicitly enumerates these strategies, and the exam loves to disguise them in business scenarios — a vendor contract with a liability clause is **transfer**, not mitigate; choosing not to launch a product line is **avoid**, not accept. The classic trap: confusing **risk acceptance** (a documented business decision) with **risk exemption** (a formal carve-out from a policy) — they are not synonyms.

## Key facts

### The Core Four Strategies

| Strategy | What you do | TotK parallel | Example |
|---|---|---|---|
| **Mitigate** | Reduce likelihood or impact via [[controls]] | Wear Gloom-resistant armor + eat Sundelions | Deploy [[EDR]], [[MFA]], patching |
| **Transfer** | Shift financial impact to a third party | Hand the fight to Mineru's construct | [[Cyber insurance]], outsourcing, contractual indemnity |
| **Accept** | Acknowledge risk, take no further action | Walk into the Depths knowing you'll take Gloom damage | Documented [[risk acceptance]] with sign-off |
| **Avoid** | Eliminate the risk by not doing the activity | Don't enter the Gloom-infested cave at all | Cancel the project, decommission the system |

### Risk Acceptance — Two Flavors

- **[[Ad hoc acceptance]]** — informal, situational, often undocumented (dangerous on audit day).
- **[[Ongoing acceptance]]** — formally documented, periodically reviewed, signed by a [[risk owner]].

Acceptance requires an **[[risk appetite]]** and **[[risk tolerance]]** threshold defined by leadership. If the residual risk sits below tolerance, acceptance is rational. Above it, acceptance is negligence with paperwork.

### Risk Transference — The Fine Print

- **[[Cyber insurance]]** transfers *financial* loss, not *reputational* loss. Your customers don't care that Lloyd's paid out.
- **Contractual transfer** via [[SLA]], [[MSA]], and indemnification clauses — the [[shared responsibility model]] in cloud is transference codified.
- You **cannot transfer regulatory liability**. [[GDPR]] fines stay with the data controller no matter how many MSPs you hire.

### Risk Avoidance vs. Risk Mitigation

- **Avoidance** removes the asset, activity, or exposure entirely. No system, no risk.
- **Mitigation** keeps the asset and reduces the risk via [[preventive controls]], [[detective controls]], [[corrective controls]], or [[compensating controls]].
- A control that reduces risk to zero doesn't exist. There is always **[[residual risk]]**.

### Exemption vs. Exception (CompTIA Loves This)

| Term | Meaning |
|---|---|
| **[[Risk exception]]** | Temporary deviation from a policy or control standard, formally approved, with an expiration date and remediation plan |
| **[[Risk exemption]]** | A permanent or codified carve-out — the policy explicitly does not apply to this system/group/scenario |

Both require documentation, approval, and review. An undocumented exception is just a vulnerability with optimism attached.

### The Risk Management Lifecycle Context

These strategies plug into the broader process: [[risk identification]] → [[risk assessment]] ([[qualitative risk analysis|qualitative]] / [[quantitative risk analysis|quantitative]]) → **risk response (this topic)** → [[risk monitoring]] → [[risk reporting]]. Outputs land in the [[risk register]] with owner, strategy, control, residual risk, and review date.

### Quantitative Inputs That Drive Strategy Choice

- **[[SLE]]** (Single Loss Expectancy) = Asset Value × Exposure Factor
- **[[ARO]]** (Annualized Rate of Occurrence)
- **[[ALE]]** (Annualized Loss Expectancy) = SLE × ARO
- If a control costs more than the ALE it reduces, you're paying to feel safe. That's mitigation theater — often the right answer is **accept**.

## Related concepts

[[Risk register]] · [[Risk appetite]] · [[Risk tolerance]] · [[Residual risk]] · [[Inherent risk]] · [[Qualitative risk analysis]] · [[Quantitative risk analysis]] · [[Control categories]] · [[Shared responsibility model]] · [[Cyber insurance]] · [[Business Impact Analysis]] · [[Risk owner]]

---
*Source: VIRGIL knowledge base — 2026-05-08*