---
domain: "governance-risk-compliance"
tags: [privacy, compliance, data-protection, regulation, california, consumer-rights]
---
# CCPA

The **California Consumer Privacy Act (CCPA)**, enacted in 2018 and effective January 1, 2020, is a landmark **state-level data privacy law** that grants California residents significant rights over their personal information collected by businesses. It was later strengthened by the **California Privacy Rights Act (CPRA)** in 2023, which created the California Privacy Protection Agency (CPPA) as an independent enforcement body. The CCPA shares philosophical DNA with the EU's [[GDPR]] but differs significantly in scope, enforcement, and technical obligations, making it a critical framework for any organization handling data from California residents.

---

## Overview

The CCPA was born from a combination of public pressure following high-profile data breaches and growing distrust of Silicon Valley data practices. The 2018 Facebook–Cambridge Analytica scandal was a direct accelerant. California's initiative process allowed privacy advocates to push for legislation that would have been more restrictive than what ultimately became law after industry lobbying. Nevertheless, the CCPA established the most comprehensive state-level privacy framework in the United States at the time of its passage.

The law applies to for-profit businesses that do business in California and meet **at least one** of three thresholds: annual gross revenues exceeding $25 million; buying, selling, or receiving personal information of 100,000 or more California residents or households per year (raised from 50,000 by the CPRA); or deriving 50% or more of annual revenues from selling or sharing consumers' personal information. Notably, the law protects "California residents," not just California customers — meaning a business in New York that collects data from a California resident while that person is traveling must still comply.

The **CPRA amendments**, effective January 1, 2023, introduced the concept of "sensitive personal information" as a distinct category requiring heightened protection, created opt-out rights for the sharing (not just selling) of data, added a data minimization principle, established a right to correct inaccurate personal information, and created the CPPA as a dedicated enforcement agency with rulemaking authority. This moved CCPA from a primarily consumer-rights statute toward a more GDPR-like data governance framework.

Enforcement is handled both by the California Attorney General (for violations not cured within 30 days of notice) and, post-CPRA, by the CPPA. Statutory penalties are **$2,500 per unintentional violation** and **$7,500 per intentional violation**. The CCPA also provides a private right of action specifically for data breaches involving certain categories of sensitive data — consumers can sue for $100–$750 per consumer per incident or actual damages, whichever is greater, without needing to prove harm. This private right of action is one of the most consequential enforcement mechanisms, as it enables class action litigation.

Unlike GDPR, the CCPA does not require a legal basis for processing personal data (no "lawful basis" doctrine), does not mandate a Data Protection Officer, and does not require Privacy Impact Assessments for all high-risk processing — though the CPRA introduced risk assessments for certain activities. This makes CCPA compliance in some respects less prescriptive than GDPR, but the private right of action for breaches creates a litigation risk GDPR does not directly replicate.

---

## How It Works

### Scope Determination

Before implementing technical controls, organizations must determine if CCPA applies to them. The assessment involves:

```
CCPA Applicability Checklist:
1. Is the entity a for-profit business? (non-profits are generally excluded)
2. Does the entity do business in California?
3. Does the entity meet ANY ONE threshold:
   - Annual gross revenue > $25 million USD
   - Processes PI of ≥ 100,000 CA residents/households per year (post-CPRA)
   - ≥ 50% of annual revenue from selling/sharing personal information
```

### Personal Information Definition

CCPA defines **personal information (PI)** broadly — any information that "identifies, relates to, describes, is reasonably capable of being associated with, or could reasonably be linked, directly or indirectly, with a particular consumer or household." This includes:

- Identifiers: real name, alias, postal address, unique personal identifier, online identifier, IP address, email address, account name, SSN, driver's license number, passport number
- Commercial information: records of personal property, products or services purchased
- Biometric information
- Internet or electronic network activity: browsing history, search history, interaction with a website
- Geolocation data
- Professional or employment-related information
- Inferences drawn from any of the above

### Consumer Rights Workflow

```
Consumer Request → Business Verification → Response Obligations

1. RIGHT TO KNOW (Disclosure)
   - Consumer submits request via designated method
   - Business must verify identity (reasonable steps, no excessive info collection)
   - Response deadline: 45 days (extendable by 45 days with notice)
   - Must disclose: categories collected, purposes, third parties shared with,
     specific pieces of PI collected about the consumer

2. RIGHT TO DELETE
   - Consumer submits deletion request
   - Business must verify identity
   - Must delete AND instruct service providers/contractors to delete
   - Exceptions: complete transactions, security, legal obligations, 
     internal uses reasonably aligned with consumer expectations, research

3. RIGHT TO OPT-OUT OF SALE/SHARING
   - Business must provide "Do Not Sell or Share My Personal Information" link
   - Must honor opt-out within 15 business days
   - Cannot re-request opt-in for 12 months
   - Global Privacy Control (GPC) signals must be honored

4. RIGHT TO NON-DISCRIMINATION
   - Cannot deny goods/services, charge different price, or provide 
     different quality for exercising CCPA rights
   - Financial incentive programs are permitted if value-related

5. RIGHT TO CORRECT (CPRA addition)
   - Consumer can request correction of inaccurate PI
   - Same 45-day response window

6. RIGHT TO LIMIT USE OF SENSITIVE PI (CPRA addition)
   - Consumer can limit use/disclosure to what is necessary for service
```

### Technical Implementation of "Do Not Sell/Share"

The Global Privacy Control (GPC) is a browser-level signal (HTTP header or JavaScript API) that websites must honor:

```javascript
// Detecting GPC signal in JavaScript
if (navigator.globalPrivacyControl === true) {
    // Consumer has signaled opt-out of sale/sharing
    // Disable third-party advertising scripts
    // Disable cross-context behavioral advertising pixels
    disableThirdPartyTracking();
    logOptOutSignal(userId, 'GPC', new Date());
}
```

```python
# Python: Detecting GPC in HTTP request header
from flask import Flask, request

app = Flask(__name__)

@app.before_request
def check_gpc():
    gpc_header = request.headers.get('Sec-GPC')
    if gpc_header == '1':
        # Flag session for restricted data processing
        # Do not pass to advertising partners
        session['gpc_opt_out'] = True
```

### Data Inventory Requirements

CCPA compliance requires maintaining a **Record of Processing Activities (RoPA)**-equivalent data map:

```
Data Inventory Schema:
┌──────────────────────────────────────────────────────────┐
│ Category of PI    │ Source      │ Purpose    │ Recipients │
├──────────────────────────────────────────────────────────┤
│ Identifiers       │ Web forms   │ Account    │ CRM vendor │
│ Browsing history  │ Analytics   │ Marketing  │ Ad network │
│ Geolocation       │ Mobile app  │ Service    │ Internal   │
│ Biometric data    │ Auth system │ Security   │ None       │
└──────────────────────────────────────────────────────────┘

Fields to track:
- PI category
- Collection source/method
- Business purpose
- Retention period
- Third parties with access (service providers vs. third parties vs. contractors)
- Whether PI is "sold" or "shared"
- Whether PI is sensitive PI (CPRA)
```

### Service Provider vs. Third Party Distinction

```
Data flows to a "Service Provider":
  - Bound by written contract
  - Processes PI only for specified business purposes
  - Cannot sell/share PI
  - Must delete/return PI at end of relationship
  → Consumer data sold/shared to service provider does NOT 
    count as a "sale" triggering opt-out rights

Data flows to a "Third Party":
  - Not bound by service provider contract
  - May process PI for their own purposes
  → DOES constitute a "sale" or "sharing" requiring opt-out
```

---

## Key Concepts

- **Personal Information (PI)**: Any information that identifies, relates to, or could reasonably be linked with a California consumer or household; CCPA's definition is intentionally broader than most prior state breach notification laws, encompassing IP addresses, browsing history, and inferred characteristics.

- **Sensitive Personal Information (SPI)**: A CPRA-introduced subcategory including SSNs, financial account data with credentials, precise geolocation, racial/ethnic origin, religious beliefs, union membership, genetic/biometric data, health information, and sexual orientation — subject to a separate right to limit use.

- **Sale of Personal Information**: Under CCPA, "sale" means selling, renting, releasing, disclosing, disseminating, making available, transferring, or otherwise communicating PI to a third party for monetary or **other valuable consideration** — the "other valuable consideration" language is critical, as data-for-services exchanges (like sharing with ad networks in exchange for targeting capabilities) can constitute a sale.

- **Sharing**: A CPRA addition distinct from "selling" — sharing PI with a third party for **cross-context behavioral advertising**, regardless of monetary exchange. This captures much of the programmatic advertising ecosystem that tried to argue it wasn't technically "selling" data.

- **Service Provider**: A business that processes PI on behalf of a business pursuant to a written contract that prohibits the service provider from retaining, using, or disclosing PI for any purpose other than the specific business purposes outlined in the contract.

- **Data Minimization**: A CPRA principle requiring that collection, use, retention, and sharing of PI be reasonably necessary and proportionate to the purposes for which it was collected — borrowed from GDPR but now part of California law.

- **Opt-Out vs. Opt-In**: CCPA uses an opt-out model for most data practices (consumers must affirmatively request to stop sale/sharing), with a stricter opt-in requirement for selling/sharing PI of consumers under 16 years of age (and parental opt-in for under-13s).

- **Private Right of Action**: Consumers have a limited private right of action for data breaches exposing certain categories of unencrypted/unredacted PI — the categories include SSNs, financial account credentials, medical information, and login credentials. This does not extend to general CCPA violations.

---

## Security Implications

### Data Breach Private Right of Action

The most direct security implication of CCPA is the private right of action for certain data breaches. Under California Civil Code §1798.150, consumers can sue if:

1. Their unencrypted and unredacted personal information (specific categories: SSN, driver's license, account credentials, medical info, biometric data, tax ID, passport number) was subject to unauthorized access, exfiltration, theft, or disclosure
2. As a result of the business's failure to implement reasonable security procedures and practices

This creates direct legal liability for inadequate security controls. The California AG has referenced the **CIS Controls** and **NIST Cybersecurity Framework** as guidance for what constitutes "reasonable security." California's existing **CMIA** and **Confidentiality of Medical Information Act** overlap here.

### Notable Incidents and Enforcement

- **Sephora (2022)**: First major CCPA enforcement action by the California AG. Sephora was fined **$1.2 million** for failing to disclose to consumers that it sold personal information, failing to process opt-out requests via GPC, and failing to cure violations within the 30-day notice period. The key technical finding was that Sephora's website did not honor GPC signals.

- **DoorDash (2024)**: Settled for $375,000 with the California AG for sharing customer personal information with a marketing cooperative without adequate disclosure, violating the right to know and opt-out provisions.

- **Honda (2022)**: Investigated by researchers who found Honda's "Do Not Sell" implementation required consumers to re-enter personal information to submit the request, which the CPPA later clarified was an unlawful barrier.

### Attack Vectors Specific to CCPA Compliance Infrastructure

**Consumer Request Portals as Attack Surface**: Businesses must implement mechanisms for consumers to submit rights requests (access, deletion, correction). These portals become targets:
- Identity verification bypass attacks — if verification is too weak, attackers can submit fraudulent deletion requests to cover tracks post-breach, or access requests to harvest data on other individuals
- If verification is too strong (requiring excessive PI), it becomes an unlawful barrier AND collects more data than necessary
- Portal injection attacks (SQLi in request submission forms) can expose the very data consumers are asking about

**Data Mapping Tool Compromise**: The data inventories required for CCPA compliance are themselves high-value targets — they contain a complete map of where sensitive data lives across the organization.

**Opt-Out Signal Manipulation**: If GPC signal detection is implemented server-side, attackers who can manipulate request headers (e.g., through MITM on unprotected segments) could either suppress legitimate opt-out signals or inject false ones to disrupt analytics.

---

## Defensive Measures

### Technical Controls

**1. Encryption and Pseudonymization**
Encrypting data covered by the private right of action categories is a direct liability shield. If breached data is encrypted, the private right of action does not apply:

```bash
# Example: Encrypting sensitive columns in PostgreSQL using pgcrypto
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Encrypt SSN at rest
UPDATE users 
SET ssn_encrypted = pgp_sym_encrypt(ssn_plaintext, 'AES256_KEY')
WHERE ssn_plaintext IS NOT NULL;

-- Drop plaintext column after migration
ALTER TABLE users DROP COLUMN ssn_plaintext;
```

**2. Access Controls and Logging**
Implement role-based access control for systems containing PI, with comprehensive audit logging to demonstrate compliance and detect unauthorized access:

```yaml
# Example: OPA (Open Policy Agent) policy snippet for PI access control
package ccpa.data_access

default allow = false

allow {
    input.user.role == "data-governance"
    input.action == "read"
    input.resource.classification == "personal_information"
    input.user.business_purpose != ""
}

# Log all access for audit trail
audit_log {
    allow
    log_entry := {
        "user": input.user.id,
        "resource": input.resource.id,
        "purpose": input.user.business_purpose,
        "timestamp": time.now_ns()
    }
}
```

**3. Data Retention Automation**
Implement automated deletion to enforce retention limits:

```python
# Automated CCPA data retention enforcement
import datetime
from sqlalchemy import create_engine, text

engine = create_engine('postgresql://user:pass@localhost/db')

def enforce_retention_policy():
    retention_policies = {
        'web_analytics': 13,  # months
        'transaction_records': 84,  # 7 years (legal requirement override)
        'marketing_profiles': 24,
        'support_tickets': 36,
    }
    
    with engine.connect() as conn:
        for table, months in retention_policies.items():
            cutoff_date = datetime.datetime.now() - datetime.timedelta(days=months*30)
            result = conn.execute(
                text(f"DELETE FROM {table} WHERE created_at < :cutoff "
                     "AND NOT EXISTS (SELECT 1 FROM active_transactions "
                     "WHERE consumer_id = {table}.consumer_id)"),
                {"cutoff": cutoff_date}
            )
            print(f"Deleted {result.rowcount} records from {table}")
```

**4. Consent Management Platform (CMP)**
Deploy a CMP such as **OneTrust**, **TrustArc**, or **Cookiebot** to:
- Present opt-out notices at collection
- Record consent/opt-out signals with timestamps
- Propagate opt-out signals to downstream vendors via IAB TCF signals
- Generate audit logs defensible in litigation

**5