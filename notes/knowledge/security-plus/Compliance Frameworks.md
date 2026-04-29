---
domain: "Governance, Risk, and Compliance"
tags: [compliance, governance, risk-management, frameworks, auditing, security-controls]
---
# Compliance Frameworks

**Compliance frameworks** are structured sets of guidelines, standards, and best practices that organizations follow to meet legal, regulatory, and industry requirements for protecting data and managing risk. They provide a **systematic approach** to implementing [[Security Controls]], ensuring accountability, and demonstrating due diligence to regulators, auditors, and customers. Frameworks like [[NIST CSF]], [[PCI DSS]], [[HIPAA]], and [[ISO 27001]] form the backbone of enterprise [[Risk Management]] programs worldwide.

---

## Overview

Compliance frameworks exist because the consequences of data breaches, privacy violations, and operational failures are severe — financially, legally, and reputationally. Governments and industry bodies developed these frameworks to create consistent, measurable standards that organizations must meet. Without frameworks, each organization would independently define "secure enough," leading to wildly inconsistent protection of sensitive data like medical records, financial transactions, and critical infrastructure.

A compliance framework typically consists of three core layers: **policies** (high-level organizational intent), **standards** (specific mandatory requirements), and **procedures** (step-by-step operational instructions). Frameworks like NIST SP 800-53 contain hundreds of individual controls organized into control families such as Access Control (AC), Incident Response (IR), and System and Communications Protection (SC). Organizations select and implement controls based on their risk profile, data types handled, and applicable regulations.

Frameworks are often **mandatory or voluntary** depending on context. PCI DSS is contractually mandatory for any entity processing credit card payments — failure can result in fines of $5,000–$100,000 per month and loss of the ability to process card payments. HIPAA is US federal law; violations carry civil penalties up to $1.9 million per violation category per year. NIST CSF, by contrast, is voluntary for most organizations (though mandatory for US federal agencies under FISMA) but widely adopted as an industry best practice.

The compliance ecosystem also distinguishes between **compliance** and **security** — a critical nuance that security professionals must internalize. An organization can be fully compliant with PCI DSS and still be breached. Compliance is a point-in-time snapshot of control implementation; security is an ongoing operational posture. The 2013 Target breach occurred despite the company being PCI DSS compliant at its last audit. This is why mature programs treat compliance as a *floor*, not a ceiling, and layer additional security controls beyond minimum requirements.

Frameworks are maintained and updated by standards bodies: NIST (US government), ISO (international), PCI Security Standards Council (payment industry), and various national regulatory agencies. Organizations must track framework version updates — for example, PCI DSS moved from version 3.2.1 to 4.0 in 2022, introducing significant changes around authentication requirements and customized approaches to control implementation.

---

## How It Works

### Framework Implementation Lifecycle

Implementing a compliance framework follows a repeatable lifecycle regardless of which specific framework is chosen:

```
1. Scoping        → Define what systems, data, and processes are in scope
2. Gap Analysis   → Compare current state against framework requirements
3. Remediation    → Implement missing controls, fix deficiencies
4. Documentation  → Create policies, procedures, evidence artifacts
5. Assessment     → Internal audit or third-party audit/assessment
6. Certification  → Receive compliance attestation (if applicable)
7. Continuous Monitoring → Ongoing control validation, annual re-assessment
```

### Major Frameworks Breakdown

#### NIST Cybersecurity Framework (CSF) 2.0
The NIST CSF organizes security activities into six core **Functions**:

| Function | Abbreviation | Description |
|---|---|---|
| Govern | GV | Establish cybersecurity strategy, policies, roles |
| Identify | ID | Asset management, risk assessment |
| Protect | PR | Access control, awareness training, data security |
| Detect | DE | Anomaly detection, continuous monitoring |
| Respond | RS | Response planning, communications, mitigation |
| Recover | RC | Recovery planning, improvements |

Each function breaks into **Categories** and **Subcategories**. For example:
- `PR.AC-1`: Identities and credentials are managed for authorized devices, users, and processes
- `DE.CM-1`: Networks are monitored to detect potential cybersecurity events

#### NIST SP 800-53 Rev 5 Control Families
Used by US federal agencies and contractors. Controls are organized into 20 families:

```
AC  - Access Control          IR  - Incident Response
AT  - Awareness and Training  MA  - Maintenance
AU  - Audit and Accountability MP  - Media Protection
CA  - Assessment/Authorization PE  - Physical/Environmental
CM  - Configuration Mgmt      PL  - Planning
CP  - Contingency Planning     PM  - Program Management
IA  - Identification/Auth      PS  - Personnel Security
...
```

#### PCI DSS 4.0 — 12 Requirements

```
Req 1:  Install and maintain network security controls
Req 2:  Apply secure configurations to all system components
Req 3:  Protect stored account data
Req 4:  Protect cardholder data in transit (TLS 1.2+ minimum)
Req 5:  Protect all systems against malware
Req 6:  Develop/maintain secure systems and software
Req 7:  Restrict access to cardholder data by business need
Req 8:  Identify users and authenticate access (MFA required)
Req 9:  Restrict physical access to cardholder data
Req 10: Log and monitor all access to system components
Req 11: Test security of systems and networks regularly
Req 12: Support information security with org policies
```

#### ISO/IEC 27001:2022 — Annex A Controls
ISO 27001 uses a Plan-Do-Check-Act (PDCA) model for the **Information Security Management System (ISMS)**. Annex A contains 93 controls organized into 4 themes:
- **Organizational** (37 controls) — policies, roles, threat intelligence
- **People** (8 controls) — screening, training, remote work
- **Physical** (14 controls) — physical security, media handling
- **Technological** (34 controls) — endpoint, access, encryption, monitoring

#### HIPAA Technical Safeguards (45 CFR §164.312)
```
§164.312(a)(1) - Access Control
  - Unique user identification (Required)
  - Emergency access procedure (Required)
  - Automatic logoff (Addressable)
  - Encryption/decryption (Addressable)

§164.312(b) - Audit Controls (Required)
§164.312(c)(1) - Integrity Controls
§164.312(d) - Person Authentication (Required)
§164.312(e)(1) - Transmission Security
  - Encryption: TLS 1.2+ for ePHI in transit (Addressable)
```

### Control Assessment Methods

```bash
# Example: Using OpenSCAP to assess RHEL against STIG/NIST 800-53
# Install OpenSCAP
sudo dnf install scap-security-guide openscap-scanner

# List available profiles
oscap info /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml | grep "Profile"

# Run assessment against NIST 800-53 profile
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cui \
  --results scan-results.xml \
  --report scan-report.html \
  /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml

# Generate remediation script from results
oscap xccdf generate fix \
  --result-id xccdf_org.open-scap.sce.result_1 \
  --output remediation.sh \
  scan-results.xml
```

---

## Key Concepts

- **Control**: A safeguard or countermeasure designed to satisfy a security requirement. Controls are classified as **administrative** (policies, training), **technical** (firewalls, encryption), or **physical** (locks, cameras). NIST SP 800-53 provides the most comprehensive control catalog for US federal systems.

- **Gap Analysis**: A formal comparison between an organization's current security posture and the requirements of a target compliance framework. The output is a prioritized remediation roadmap. Tools like Nessus Compliance Checks, Qualys Policy Compliance, and manual spreadsheet-based assessments are commonly used.

- **Attestation of Compliance (AoC)**: A formal document signed by a Qualified Security Assessor (QSA) or the organization's officer confirming that a PCI DSS assessment was completed and the entity is compliant. Distinct from a Report on Compliance (ROC), which is the full detailed assessment document.

- **Compensating Controls**: Alternative security measures that provide equivalent protection when an organization cannot meet a specific control requirement as written. PCI DSS explicitly allows compensating controls under strict conditions — they must exceed other requirements, address the risk of the original requirement, and be proportionate.

- **Scope Reduction (Segmentation)**: The practice of isolating systems that handle sensitive data (cardholder data environment, ePHI systems) from the broader network to reduce the number of systems subject to compliance requirements. Proper network segmentation using [[VLANs]], [[Firewalls]], and [[DMZ]] architectures can dramatically reduce PCI DSS scope.

- **Continuous Compliance Monitoring**: Automated, ongoing verification that controls remain in place between formal audits. Tools like AWS Config, Azure Policy, and SIEM platforms continuously check configurations against compliance baselines and alert on drift.

- **Right of Audit**: A contractual clause in third-party agreements (vendors, cloud providers, contractors) that grants the organization the right to assess the third party's security controls. Critical for supply chain risk management under frameworks like NIST SP 800-161.

---

## Exam Relevance

### SY0-701 Domain Mapping
Compliance frameworks appear heavily in **Domain 5.0: Governance, Risk, and Compliance (14%)** of the Security+ SY0-701 exam.

### Key Framework Associations — Know These Cold

| Framework | Applies To | Governing Body |
|---|---|---|
| PCI DSS | Payment card data | PCI Security Standards Council |
| HIPAA | Healthcare/medical data (US) | US Dept. of Health & Human Services |
| GDPR | EU personal data | European Union |
| SOX | Public company financial records | SEC / US Congress |
| FISMA | US federal agencies | NIST / OMB |
| GLBA | Financial institutions (US) | FTC / banking regulators |
| CMMC | DoD contractors | US Dept. of Defense |
| ISO 27001 | Any organization (international) | ISO / IEC |
| NIST CSF | Critical infrastructure (voluntary) | NIST |

### Common Question Patterns

1. **"Which framework applies to..."** — Match the data type or industry to the correct framework. PHI = HIPAA. Credit cards = PCI DSS. EU personal data = GDPR. Federal agency = FISMA/FedRAMP.

2. **"What is the difference between a policy, standard, and procedure?"** — Policy = high-level intent (what). Standard = specific mandatory requirement (how much/what level). Procedure = step-by-step instructions (how exactly).

3. **"Compliance vs. Security"** — The exam loves scenarios where a company is compliant but still breached. The correct answer acknowledges that compliance is a minimum baseline, not complete security.

4. **"What type of control is X?"** — Know the three types: Administrative/Managerial, Technical/Logical, Physical/Operational. Also know control *functions*: Preventive, Detective, Corrective, Deterrent, Compensating, Directive.

### Gotchas

- **GDPR applies extraterritorially** — US companies processing EU citizens' data must comply even if they have no EU presence.
- **HIPAA Business Associate Agreements (BAAs)** — Cloud providers, IT vendors, and billing companies that handle ePHI are **Business Associates** and must sign BAAs. AWS, Azure, and GCP all offer HIPAA-eligible services with BAAs.
- **SOC 2 is not a regulation** — It's a voluntary auditing standard by the AICPA based on Trust Services Criteria. Often confused with a regulatory framework on the exam.
- **CMMC 2.0** — The Cybersecurity Maturity Model Certification has three levels. Level 1 (Foundational) = 17 practices. Level 2 (Advanced) = 110 practices aligned to NIST SP 800-171. Level 3 = NIST SP 800-172.

---

## Security Implications

### Compliance Theater and False Security
The most significant risk of compliance frameworks is organizations treating them as a checkbox exercise rather than genuine risk reduction. The 2013 **Target data breach** — resulting in 40 million credit card records stolen — occurred while Target was PCI DSS compliant. The attackers compromised an HVAC vendor with network access, exploited poor network segmentation, and exfiltrated data through the point-of-sale network. PCI DSS Requirement 1 (network segmentation) was technically met, but the implementation was insufficient.

### Audit Scope Manipulation
Attackers and even dishonest insiders sometimes attempt to keep systems out of audit scope to avoid scrutiny of vulnerable configurations. If a system is declared "out of scope" for PCI DSS, it won't be assessed for compliance controls, potentially leaving it as a pivot point into the cardholder data environment.

### Third-Party and Supply Chain Risks
Compliance frameworks create a false sense of security regarding vendors. The **2020 SolarWinds attack** (CVE-2020-10148) compromised organizations that were fully compliant with FISMA and NIST controls because the attack entered through a trusted software update mechanism — a vector many compliance checklists did not adequately address. NIST SP 800-161 (Supply Chain Risk Management) has since gained prominence.

### Framework Version Lag
Compliance frameworks update infrequently (ISO 27001 updates roughly every decade; PCI DSS major versions every 3-5 years). This creates a temporal gap between current threat landscape and mandated controls. TLS 1.0/1.1 deprecation, for example, was addressed in PCI DSS 3.1 (2015) but many organizations remained non-compliant well into 2018.

### Credential Theft During Assessments
Compliance assessments often require auditors to be granted privileged access to systems. This access, if not properly controlled with temporary credentials and session monitoring, represents an insider threat vector. Audit credentials have been targeted by attackers who compromise assessor firms.

---

## Defensive Measures

### Implement a Governance, Risk, and Compliance (GRC) Platform
Tools like **ServiceNow GRC**, **RSA Archer**, **LogicGate**, and the open-source **Eramba** automate control tracking, evidence collection, and audit workflows. For smaller organizations, structured spreadsheets (NIST provides downloadable SP 800-53 control templates) are a viable starting point.

### Continuous Control Monitoring
```bash
# AWS Config rule for S3 bucket encryption compliance (PCI DSS Req 3)
aws configservice put-config-rule --config-rule '{
  "ConfigRuleName": "s3-bucket-server-side-encryption-enabled",
  "Source": {
    "Owner": "AWS",
    "SourceIdentifier": "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }
}'

# Check compliance status
aws configservice describe-compliance-by-config-rule \
  --config-rule-names s3-bucket-server-side-encryption-enabled
```

### Network Segmentation for Scope Reduction
```
# Example Firewall Rule: Isolate PCI CDE from corporate network
# Only allow necessary traffic from corporate to CDE
iptables -A FORWARD -s 192.168.1.0/24 -d 10.0.1.0/24 -p tcp \
  --dport 443 -j ACCEPT
iptables -A FORWARD -s 192.168.1.0/24 -d 10.0.1.0/24 -j DROP
iptables -A FORWARD -s 10.0.1.0/24 -d 192.168.1.0/24 -j DROP
```

### Policy Hierarchy Documentation
Maintain a documented policy hierarchy:
1. **Information Security Policy** (