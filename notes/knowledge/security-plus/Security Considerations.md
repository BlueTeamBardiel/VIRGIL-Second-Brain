# Security Considerations

## What it is

In Among Us, before you even start a match, the host configures the lobby: how many impostors, vent access, kill cooldown, vision range, task bar updates. Pick the wrong settings and the game is unwinnable for crew before anyone presses Start. That's exactly what **security considerations** are — the up-front decisions about how a system, change, or asset is governed *before* it goes live, because retrofitting security after deployment is how you lose the round.

Security considerations are the governance, regulatory, legal, industry, geographical, and business-impact factors that shape security control selection, risk treatment, and change management decisions across the lifecycle of a system or process.

## Why it matters

If you skip considerations, you ship a [[change]] that breaks production, violates [[GDPR]], or exposes [[PHI]] in a jurisdiction that fines per record. The exam angle lives in **Domain 5.1** (governance structures, policies, standards, procedures, external considerations) and bleeds into **5.2** (risk management) and **5.4** (change management). CompTIA's favorite trap: confusing **regulatory** (legally enforced by government — [[HIPAA]], [[GDPR]]) with **industry** (enforced by a sector body — [[PCI DSS]]) with **internal** (enforced by your own policy). They are not interchangeable on the exam.

## Key facts

### External considerations (the ones that come from outside)

| Type | Source | Example | Penalty for ignoring |
|---|---|---|---|
| **Regulatory** | Government law | [[HIPAA]], [[SOX]], [[GLBA]] | Fines, prison |
| **Legal** | Contract, court order | NDAs, e-discovery | Lawsuits, breach of contract |
| **Industry** | Sector body | [[PCI DSS]], [[NERC CIP]] | Loss of ability to operate |
| **Geographical** | Where data lives/moves | [[GDPR]] (EU), [[data sovereignty]], cross-border transfer rules | Fines, data localization mandates |

### Internal considerations

- **Business impact** — will this break revenue, reputation, or operations? See [[business impact analysis]].
- **Stakeholder** — who has skin in the game ([[data owner]], [[data custodian]], legal, HR, end users)?
- **Internal policies** — [[acceptable use policy]], [[password policy]], [[change management]] policy.
- **Existing controls** — don't re-buy what you already have; do verify it still works.

### Change management considerations (5.1 explicitly tests these)

| Consideration | What it covers |
|---|---|
| **Approval process** | [[CAB]] (Change Advisory Board) sign-off |
| **Ownership** | Who is accountable when it breaks |
| **Stakeholders** | Who must be informed |
| **Impact analysis** | Blast radius if the change fails |
| **Test results** | Sandbox/UAT proof it works |
| **Backout plan** | How to undo it at 3 a.m. |
| **Maintenance window** | When downtime is tolerable |
| **Standard operating procedure** | Repeatable steps |

### Technical implications of changes

- **Allow/deny lists** — modifying [[firewall]] or [[application allow list]] rules.
- **Restricted activities** — what's off-limits during the change window.
- **Downtime** — planned outage acceptable to the business.
- **Service restart** — does the change require it?
- **Application restart** — narrower than service restart.
- **Legacy applications** — the ones nobody wants to touch but everyone depends on.
- **Dependencies** — Service A breaks, so do Services B, C, and the help desk phone.

### Documentation considerations

- Update **diagrams**, **policies**, **procedures**, and the [[CMDB]] (Configuration Management Database) after every change. An undocumented change is a future incident pretending to be a feature.
- **Version control** — for code, configs, and policy documents. Git for infra, document control for governance.

### Governance hierarchy (memorize the order)

1. **Policy** — high-level intent ("we will protect customer data").
2. **Standard** — measurable requirement ("AES-256 minimum").
3. **Procedure** — step-by-step ("how to rotate the key").
4. **Guideline** — recommended, not mandatory.

CompTIA loves asking which document type corresponds to which artifact. Policy = what & why. Standard = what specifically. Procedure = how. Guideline = suggestion.

## Related concepts

[[Change management]] · [[Risk management]] · [[Governance]] · [[Compliance]] · [[Business impact analysis]] · [[Data sovereignty]] · [[Acceptable use policy]] · [[CAB]] · [[CMDB]] · [[Regulatory frameworks]]

---
*Source: VIRGIL knowledge base — 2026-05-08*