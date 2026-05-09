# Third-party Risk Assessment

## What it is

In Far Cry 3, before you raid Vaas's pirate camp, you climb the radio tower, scout the outpost with your camera, and tag every guard, alarm, and attack dog. You don't charge in blind — you assess what's actually in there before committing. That's exactly what third-party risk assessment does — you evaluate a vendor's security posture *before* handing them your data, network access, or supply chain trust.

**Third-party risk assessment** is the formal evaluation of vulnerabilities, threats, and control gaps introduced by external vendors, suppliers, partners, and service providers before and during a business relationship.

## Why it matters

Your security perimeter ends where your vendor's negligence begins. The Target breach (2013) came through an HVAC contractor; SolarWinds (2020) poisoned thousands of customers through one compromised software update. Skip the assessment, and you inherit every CVE, every misconfigured S3 bucket, and every disgruntled admin your vendor employs.

**Exam angle:** Objective 5.3 explicitly lists **penetration testing**, **right-to-audit clauses**, **evidence of internal audits**, **independent assessments**, **supply chain analysis**, and **vendor selection** (due diligence, conflict of interest). CompTIA's favorite trap: distinguishing **due diligence** (pre-contract investigation) from **due care** (ongoing reasonable protection), and confusing **right-to-audit** (contractual permission) with **independent assessment** (third-party verification like SOC 2).

## Key facts

### Assessment methods

| Method | What it does | When used |
|---|---|---|
| [[Penetration testing]] | Active exploitation attempt against vendor systems | Pre-contract or annually for high-risk vendors |
| [[Right-to-audit clause]] | Contractual right for *you* to audit *them* | Negotiated into MSA before signing |
| [[Internal audits]] | Vendor's own audit reports submitted as evidence | Lower assurance — they grade themselves |
| [[Independent assessments]] | Third-party attestation ([[SOC 2 Type II]], [[ISO 27001]], [[PCI DSS]] AOC) | Highest assurance, most common |
| [[Supply chain analysis]] | Trace components, sub-vendors, country of origin | Hardware, software dependencies, [[SBOM]] |

### Vendor selection controls

- **[[Due diligence]]** — investigation *before* signing: financial health, security posture, breach history, references, regulatory standing.
- **[[Conflict of interest]]** — checking whether the vendor has relationships (ownership, partnerships) that compromise their objectivity or your data.
- **[[Vendor questionnaires]]** — standardized instruments like **SIG** (Standardized Information Gathering) or **CAIQ** (Consensus Assessments Initiative Questionnaire from CSA).

### Ongoing monitoring (not one-and-done)

- **[[Vendor monitoring]]** — continuous review of vendor security events, breach disclosures, and control changes.
- **Questionnaire refresh** — typically annual.
- **[[Rules of engagement]]** — defines scope, timing, and constraints for any pen test or audit activity against the vendor.

### Contract and agreement artifacts

| Document | Purpose |
|---|---|
| [[MSA]] (Master Service Agreement) | Overarching legal terms |
| [[SLA]] (Service Level Agreement) | Performance and uptime metrics |
| [[MOA]] / [[MOU]] | Memorandum of Agreement / Understanding — looser commitments |
| [[NDA]] | Non-disclosure of shared information |
| [[BPA]] (Business Partnership Agreement) | Joint venture terms, profit/liability split |
| [[SLE]] / [[Work Order]] / [[SOW]] | Statement of Work — specific deliverables |

### The supply chain dimension

**[[Supply chain attack]]** vectors the assessment must consider:
- Compromised hardware (counterfeit chips, implanted firmware)
- Compromised software updates ([[SolarWinds]]-style)
- Sub-vendor (fourth-party) risk — your vendor's vendors
- Geopolitical risk — country of manufacture, sanctions exposure
- **[[SBOM]]** (Software Bill of Materials) — required to track open-source components and known CVEs

### Common CompTIA trap distinctions

- **Due diligence** ≠ **Due care**. Diligence = investigation. Care = ongoing protection.
- **Right-to-audit** ≠ **Independent assessment**. The first is *your* permission to audit; the second is someone neutral doing it.
- **Pen test** ≠ **Vulnerability scan**. Pen test exploits; scan only identifies.

## Related concepts

[[Vendor management]] · [[Supply chain security]] · [[SOC 2 Type II]] · [[Due diligence]] · [[Right-to-audit clause]] · [[SBOM]] · [[Penetration testing]] · [[SLA]] · [[MSA]] · [[Risk management]] · [[Vendor questionnaire]] · [[Conflict of interest]]

---
*Source: VIRGIL knowledge base — 2026-05-08*