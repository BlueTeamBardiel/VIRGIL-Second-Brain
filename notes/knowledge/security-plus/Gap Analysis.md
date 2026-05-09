# Gap Analysis

## What it is

In Fallout, you stumble into a vault wielding a 10mm pistol and Vault 13 jumpsuit, then check your Pip-Boy against the Deathclaw-infested wasteland outside — the gear you have versus the gear you need to survive is a brutal, quantifiable delta. That's exactly what gap analysis does — it measures the difference between your current security posture and where you actually need to be.

A **gap analysis** is the formal evaluation of an organization's existing security controls against a target framework, standard, or baseline to identify deficiencies requiring remediation.

## Why it matters

Without a gap analysis, organizations spend money on controls they don't need while leaving exploitable holes wide open — the audit finds the gaps for you, usually right after the breach. It's the foundational step before adopting frameworks like [[NIST CSF]], [[ISO 27001]], or [[PCI DSS]], and it drives the [[Plan of Action and Milestones]] (POA&M) that regulators love to read.

**Exam angle:** Objective 1.2 lists Gap Analysis explicitly under fundamental security concepts. CompTIA's favorite trap is conflating it with [[risk assessment]] (gap analysis measures *control deficiencies* against a standard; risk assessment measures *threat likelihood and impact*). They're related, not interchangeable.

## Key facts

### The Process

1. **Select the benchmark** — pick a standard: [[NIST 800-53]], [[CIS Controls]], [[ISO 27001]], [[HIPAA]], [[PCI DSS v4.0]].
2. **Assess current state** — inventory existing [[technical controls]], [[administrative controls]], [[physical controls]].
3. **Identify gaps** — document every control that is missing, partial, or unverified.
4. **Prioritize** — rank by [[risk exposure]], regulatory weight, and remediation cost.
5. **Remediate** — feed findings into the [[POA&M]] or roadmap.

### Types of Gap Analysis

| Type | Compares Against | Typical Trigger |
|------|------------------|-----------------|
| **Compliance gap** | Regulatory standard ([[HIPAA]], [[GDPR]], [[PCI DSS]]) | Audit, new regulation |
| **Security gap** | Framework ([[NIST CSF]], [[ISO 27001]]) | Maturity initiative |
| **Technical gap** | Architecture baseline | Technology refresh, [[zero trust]] adoption |
| **Strategic gap** | Business security goals | Mergers, expansion |

### Common Outputs

- **Gap matrix** — control-by-control scorecard (Met / Partial / Not Met / N/A).
- **Risk register entries** — each gap becomes a tracked [[risk]].
- **POA&M** — milestones, owners, deadlines, resources required.
- **Executive summary** — the version leadership actually reads.

### Gap Analysis vs. Adjacent Concepts

| Activity | Question Answered |
|----------|-------------------|
| **Gap Analysis** | What controls are we missing against [standard X]? |
| **[[Risk Assessment]]** | What's the likelihood and impact of threats to our assets? |
| **[[Vulnerability Assessment]]** | What technical flaws exist in our systems right now? |
| **[[Penetration Test]]** | Can an attacker actually exploit those flaws? |
| **[[Audit]]** | Did we do what we said we'd do? |

### Where it fits in Sec+ thinking

Gap analysis is the bridge between [[governance]] and [[risk management]]. It precedes implementation of a [[security baseline]], informs [[zero trust architecture]] migration, and feeds directly into [[continuous monitoring]] programs. On exam day: if the question describes "comparing current state to desired state" or "measuring against a framework" — that's gap analysis, not risk assessment.

## Related concepts

[[Risk Assessment]] · [[POA&M]] · [[NIST CSF]] · [[ISO 27001]] · [[Security Baseline]] · [[Compliance]] · [[Zero Trust]] · [[Vulnerability Assessment]] · [[Audit]] · [[Governance Risk and Compliance]]

---
*Source: VIRGIL knowledge base — 2026-05-08*