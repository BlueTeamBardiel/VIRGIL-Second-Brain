---
domain: "governance-risk-compliance"
tags: [policy, governance, compliance, access-control, security-management, grc]
---
# Acceptable Use Policy

An **Acceptable Use Policy (AUP)** is a formal document that defines the rules, restrictions, and guidelines governing how individuals may use an organization's technology resources, networks, and data. AUPs are a foundational element of [[Information Security Policy]] frameworks and are typically required for compliance with standards such as [[NIST SP 800-53]], [[ISO 27001]], and [[PCI DSS]]. By establishing clear boundaries around permitted and prohibited behavior, the AUP serves as both a legal instrument and a behavioral control within a [[Defense-in-Depth]] security strategy.

---

## Overview

An Acceptable Use Policy exists because technology resources—computers, networks, internet access, email systems, cloud services, and data repositories—represent significant organizational assets that carry legal, financial, and reputational risk if misused. Without explicit written policy, organizations have limited recourse when employees misuse systems, and courts have historically required demonstrable notice of rules before disciplinary action or prosecution can proceed. The AUP provides that notice, creating an enforceable contract between the organization and the user.

AUPs are not merely bureaucratic formalities. They directly support the CIA Triad ([[Confidentiality, Integrity, and Availability]]) by restricting actions that could compromise sensitive data (confidentiality), introduce unauthorized changes (integrity), or degrade system performance through abuse (availability). For example, a prohibition on installing unauthorized software prevents malware introduction, while a ban on torrenting over corporate networks reduces bandwidth consumption and legal exposure from copyright infringement.

The scope of an AUP typically covers all users who interact with organizational systems—employees, contractors, vendors, and guests. It governs the use of company-owned hardware, personally-owned devices connected to corporate networks (covered under [[BYOD Policy]]), corporate email accounts, internet access provided by the organization, cloud services, and any data classified under the organization's [[Data Classification Policy]]. Some AUPs extend to social media use even from personal devices when employees identify themselves as representatives of the organization.

From a legal standpoint, the AUP often works in conjunction with employment contracts, privacy notices, and monitoring disclosures. In many jurisdictions, monitoring employee communications without notice constitutes an invasion of privacy. The AUP typically includes an explicit acknowledgment that systems may be monitored, that users have no expectation of privacy on company resources, and that violation may result in disciplinary action up to and including termination and criminal prosecution. This language has been tested and upheld in numerous employment and computer fraud cases under statutes such as the **Computer Fraud and Abuse Act (CFAA)** in the United States.

AUPs must be living documents. As technology evolves—cloud adoption, remote work, AI tools, generative AI assistants—the AUP must be revised to address new use cases and threats. A static AUP written in 2010 will fail to address whether employees may use ChatGPT to process confidential customer data, creating both a security gap and a compliance gap. Regular review cycles, typically annual, are considered a best practice.

---

## How It Works

The AUP functions as a **policy control**—a directive safeguard rather than a technical one—but it is implemented and enforced through a combination of administrative, technical, and physical controls working in concert.

### Policy Lifecycle

**1. Development Phase**
The AUP is authored by an information security team in collaboration with legal, HR, and executive leadership. Input is gathered from department heads to ensure operational activities are not inadvertently prohibited. The policy must be written in plain language accessible to all users, not just technical staff.

**2. Review and Approval Phase**
Legal counsel reviews for compliance with applicable law (GDPR, HIPAA, CCPA, employment law). Executive leadership or the board approves. Version control is applied—each published version receives a version number and effective date.

**3. Distribution and Acknowledgment Phase**
The AUP is distributed through the HR onboarding process and the organization's intranet or document management system. Critically, users must **sign** or digitally acknowledge receipt and agreement. This acknowledgment is the legal mechanism establishing notice.

```
Typical AUP Acknowledgment Record Fields:
- Employee Name
- Employee ID
- Date of Acknowledgment
- Policy Version Number
- Method of Acknowledgment (wet signature, electronic signature, LMS completion)
- Witnessed/Attested By (optional)
```

**4. Technical Enforcement Phase**
The AUP is backed by technical controls that enforce its provisions:

- **Web Content Filtering** (e.g., Cisco Umbrella, Palo Alto URL Filtering, pfSense with pfBlockerNG): Blocks access to categories prohibited by the AUP such as gambling, adult content, or peer-to-peer networks. DNS filtering at the resolver level prevents resolution of blocked domains.

```bash
# Example: pfBlockerNG DNSBL category blocking
# Navigate to: Firewall > pfBlockerNG > DNSBL > DNSBL Groups
# Add feed category: Gambling, Adult, P2P
# This enforces the AUP prohibition on those categories at the DNS layer
```

- **Email Filtering** (e.g., Microsoft Defender for Office 365, Proofpoint): Prevents exfiltration of sensitive data via email, enforcing AUP data handling provisions.

- **Data Loss Prevention (DLP)** (e.g., Microsoft Purview, Symantec DLP): Detects and blocks transmission of regulated data (SSNs, credit card numbers) in violation of AUP data protection clauses.

- **Endpoint Management** (e.g., Microsoft Intune, Jamf): Enforces AUP software installation restrictions by preventing users from installing unauthorized applications.

```powershell
# Windows AppLocker policy example - block unauthorized executables
# Enforces AUP clause: "Users may not install unauthorized software"
New-AppLockerPolicy -RuleType Publisher,Hash,Path `
  -FilePath "C:\Windows\System32\*" `
  -User "Everyone" -Action Allow
```

- **Network Access Control (NAC)**: Enforces AUP device compliance requirements. Devices that don't meet security standards (patched OS, active AV) are quarantined, enforcing the AUP clause that personal devices must be secured before connecting.

- **Monitoring and Logging** (e.g., [[SIEM]] systems like Splunk, Wazuh): All system activity is logged per the AUP's monitoring disclosure. SIEM correlation rules generate alerts when behavior deviates from policy—for example, an alert when a user accesses file shares outside business hours.

**5. Enforcement and Violation Handling Phase**
When a violation is detected—through technical controls, manager reports, or audits—the AUP defines the escalation path:

```
Violation Severity Matrix (Example):
- Minor: First warning, mandatory retraining
- Moderate: Written warning, HR file entry
- Major: Suspension, access revocation pending investigation
- Critical: Termination, law enforcement referral
```

**6. Review and Update Phase**
The policy owner schedules annual reviews. Change management documentation records modifications. Updated versions require re-acknowledgment from all users.

---

## Key Concepts

- **Authorized Use**: The specific set of activities the AUP explicitly permits—using company systems for business purposes, accessing only data required for job function, using approved software from the approved application list.

- **Prohibited Activities**: Explicitly forbidden behaviors including unauthorized access to others' accounts, downloading pirated software, using company resources for personal business ventures, harassment via company communications systems, and bypassing security controls (e.g., using VPNs to circumvent web filters).

- **Monitoring Disclosure**: A legally critical clause stating that the organization reserves the right to monitor, log, and inspect all activity on its systems, and that users have no expectation of privacy. This clause defeats Fourth Amendment and privacy law challenges to monitoring evidence used in disciplinary or legal proceedings.

- **Personal Device / BYOD Provisions**: Clauses governing the use of personally-owned devices on corporate networks or to access corporate resources, often requiring enrollment in [[Mobile Device Management (MDM)]], minimum security configurations (PIN, encryption, remote wipe consent), and prohibiting storage of sensitive corporate data on personal cloud services.

- **Data Handling Requirements**: Provisions that align with the [[Data Classification Policy]], specifying how each data classification level (Public, Internal, Confidential, Restricted) must be handled, transmitted, stored, and disposed of. Users are explicitly told they cannot email unencrypted confidential data externally.

- **Social Media Policy**: Addresses both personal and professional social media use, prohibiting disclosure of non-public company information, impersonation of the organization, and in some cases requiring disclaimers when discussing the employer online.

- **Consequences and Sanctions**: Defines the range of penalties for AUP violations, establishing proportionality while preserving the organization's discretion. Importantly, it should state that violations may be referred to law enforcement, establishing the user's awareness that conduct may have criminal implications.

- **Policy Scope and Exceptions**: Defines who is subject to the policy (all users, specific roles) and the process for requesting exceptions—for example, a security researcher may need access to malware repositories normally blocked by web filters, requiring documented exception approval.

---

## Exam Relevance

The Security+ SY0-701 exam tests AUP knowledge primarily within **Domain 5: Security Program Management and Oversight**, specifically under **5.1 (Policies, standards, and procedures)** and **5.4 (Summarize elements of effective security compliance)**.

**Common Question Patterns:**

- *"Which document establishes rules for employee use of company systems?"* → **AUP**. Distinguish from other policies: the AUP governs *user behavior*, not technical configurations.

- *"What must an AUP include to be enforceable for monitoring?"* → An explicit **monitoring disclosure** / **no expectation of privacy** clause. Without this, monitoring evidence may be inadmissible.

- *"A new employee starts tomorrow. What should they complete before accessing systems?"* → **AUP acknowledgment** (and often security awareness training). This is an onboarding control.

- *"Which policy type would prohibit an employee from using company email for personal business?"* → AUP. Remember the hierarchy: **Policy > Standard > Procedure > Guideline**.

**Gotchas:**

- Don't confuse AUP with **Privacy Policy** (which governs how the organization handles *customer* data, not employee behavior).
- Don't confuse AUP with **Security Policy** (the broad umbrella) vs. AUP (a specific *type* of policy under that umbrella).
- The AUP is an **administrative/managerial control**, not a technical control—even though technical controls enforce it.
- **Signed acknowledgment** is what makes it legally binding—an AUP that users haven't acknowledged provides weak legal protection.
- On the exam, when a scenario describes an employee violating rules about system use and asks what *should have been in place*, the answer is almost always AUP + security awareness training.

---

## Security Implications

**Insider Threat Enablement Without AUP**
Without a clear AUP, insider threats operate in a policy vacuum. The 2016 **Tesla insider threat case** (where an employee exfiltrated gigabytes of proprietary manufacturing data) succeeded in prosecution partly because Tesla's policies clearly prohibited such data exfiltration and employees had acknowledged those policies. AUP acknowledgment created the legal basis for both termination and civil litigation.

**Shadow IT and Unauthorized Applications**
Employees who install unauthorized software—a frequent AUP violation—introduce significant attack surface. The 2020 SolarWinds supply chain attack exploited trusted software installation mechanisms. If employees freely install unapproved software, they may introduce backdoored applications, adware with data harvesting capabilities, or applications with unpatched vulnerabilities.

**Data Exfiltration via Permitted Channels**
When AUPs fail to address cloud storage services like personal Google Drive or Dropbox accounts, users may inadvertently (or maliciously) sync sensitive data to personal accounts. This created significant exposure during the COVID-19 remote work transition when many organizations lacked BYOD and cloud use provisions in their AUPs.

**AUP as Legal Shield—And Its Limits**
Organizations have attempted to use AUP violations as grounds for CFAA prosecution when employees access unauthorized data. However, courts have split on this: *United States v. Nosal* (9th Circuit, 2012) held that AUP violations alone do not constitute CFAA violations—the access must exceed authorized access in a technical sense, not merely a policy sense. This means AUPs are powerful HR and civil tools but may have limitations as criminal enforcement mechanisms.

**Phishing and Social Engineering Interaction**
AUPs that prohibit users from clicking suspicious links or opening unexpected attachments represent a behavioral control against phishing. When users violate these provisions and cause a breach, the AUP creates an accountability record—but also highlights the need for technical controls (email filtering, sandboxing) since policy alone cannot stop all phishing.

---

## Defensive Measures

**1. AUP Development Best Practices**
- Engage legal, HR, IT security, and executive stakeholders in drafting.
- Write at a 6th–8th grade reading level; avoid jargon.
- Include specific prohibited activities with examples rather than vague language.
- Reference supporting policies by name (Data Classification Policy, BYOD Policy, Remote Work Policy).
- Specify review cycle (annually) and the policy owner by role, not name.

**2. Acknowledgment and Training Integration**
```
Onboarding Checklist Integration:
☐ AUP reviewed with HR (Day 1)
☐ AUP signed electronically via DocuSign / HR platform
☐ Security awareness training completed (covers AUP highlights)
☐ Acknowledgment record filed in HRIS
☐ Annual re-acknowledgment reminder scheduled
```

**3. Technical Enforcement Stack**
Align technical controls directly to AUP clauses:

| AUP Clause | Technical Control | Tool Example |
|---|---|---|
| No unauthorized software | Application whitelisting | AppLocker, Intune |
| No accessing prohibited web content | Web content filtering | Cisco Umbrella, pfBlockerNG |
| No exfiltrating sensitive data | DLP | Microsoft Purview |
| No unencrypted data transmission | Email encryption enforcement | Proofpoint, S/MIME |
| No connecting unauthorized devices | NAC / 802.1X | Cisco ISE, FreeRADIUS |

**4. Monitoring and SIEM Integration**
Deploy a [[SIEM]] (Wazuh, Splunk, Microsoft Sentinel) with use-case-specific detection rules that map to AUP violations:
- Alert on access to file shares outside business hours
- Alert on bulk file downloads (potential data exfiltration)
- Alert on USB mass storage device connections (if prohibited by AUP)
- Alert on access to prohibited URL categories that bypassed DNS filtering

**5. Violation Response Procedure**
Document a formal incident response workflow for AUP violations. Ensure HR, legal, and IT security collaborate on investigation. Preserve logs and evidence following chain-of-custody procedures in the event of legal action.

**6. Annual Review Triggers**
Beyond scheduled annual review, trigger unscheduled reviews upon:
- Adoption of new major technology (AI tools, new cloud platform)
- Regulatory change (new data privacy law)
- Significant security incident involving policy gaps
- Merger/acquisition requiring policy harmonization

---

## Lab / Hands-On

### Lab 1: Draft a Basic AUP

Create a sample AUP document for your homelab environment (treating yourself as the "employee"). This exercise builds familiarity with policy structure.

**Sections to include:**
1. Purpose and Scope
2. Authorized Uses
3. Prohibited Activities
4. Monitoring and Privacy Notice
5. Data Handling Requirements
6. Consequences for Violations
7. Acknowledgment Signature Block

Save as `AUP_v1.0_YYYYMMDD.pdf` and maintain version history in a `docs/policies/` directory.

### Lab 2: Enforce AUP Web Restrictions with pfSense + pfBlockerNG

```bash
# On pfSense firewall:
# 1. Install pfBlockerNG-devel via Package Manager
# 2. Navigate to Firewall > pfBlockerNG > DNSBL
# 3. Enable DNSBL
# 4. Add DNSBL Group:
#    - Name: AUP_Prohibited
#    - Feed URL: https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
#    - Action: Unbound (DNS Block)
# 5. Configure category feeds:
#    - Shallalist Gambling category
#    - Shallalist Adult category
# 6. Force update and verify blocking:
nslookup gambling-site.com 192.168.1.