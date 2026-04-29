---
domain: "Identity and Access Management"
tags: [access-control, authorization, iam, zero-trust, policy-enforcement, abac]
---
# Attribute-Based Access Control (ABAC)

**Attribute-Based Access Control (ABAC)** is an authorization paradigm that grants or denies access to resources based on evaluated **policies** applied against **attributes** associated with subjects, resources, actions, and environmental context. Unlike [[Role-Based Access Control (RBAC)]], which relies on predefined roles, ABAC enables fine-grained, dynamic access decisions by combining multiple attribute categories into logical policy expressions. ABAC is foundational to [[Zero Trust Architecture]] and is formalized in NIST Special Publication 800-162.

---

## Overview

ABAC emerged from the limitations of traditional access control models. In large enterprises, [[Role-Based Access Control (RBAC)]] leads to "role explosion" — thousands of roles are created to handle every possible permission combination, making management unwieldy and error-prone. ABAC addresses this by replacing rigid role assignments with flexible policies that evaluate real-time attributes. The result is a system where access decisions adapt to context without requiring administrators to define every possible role permutation in advance.

The model was formally described by NIST in SP 800-162 (2014) and has since been adopted in cloud platforms, healthcare systems, financial services, and government infrastructure. Its flexibility makes it the preferred model for environments with complex, dynamic, or cross-organizational access requirements. Major implementations include Amazon Web Services IAM policies, Microsoft Azure ABAC (in storage and Entra ID), and XACML-based enterprise policy engines.

At its core, ABAC uses a **Policy Decision Point (PDP)** that receives a request context, evaluates it against a set of written policies, and returns a Permit or Deny decision. This decision is enforced by a **Policy Enforcement Point (PEP)**, which intercepts the original access request and acts on the PDP's verdict. This architecture cleanly separates the logic of "what is allowed" from the mechanism of "how it is enforced," enabling centralized policy management across distributed systems.

ABAC is closely related to **PBAC (Policy-Based Access Control)**, which is sometimes used interchangeably. It also underpins the practical implementation of [[Zero Trust Architecture]], where no implicit trust is granted and every request must be evaluated against contextual attributes including device health, user risk score, location, and time — not just identity. ABAC can complement or replace RBAC by using role as one attribute among many rather than the sole determinant of access.

---

## How It Works

ABAC access decisions are made by evaluating a **policy** against four categories of **attributes** collected at request time:

### The Four Attribute Categories

| Category | Description | Examples |
|---|---|---|
| **Subject Attributes** | Properties of the requesting user or process | `department=Finance`, `clearance=SECRET`, `job_title=Analyst` |
| **Resource Attributes** | Properties of the target object | `classification=CONFIDENTIAL`, `owner=HR`, `filetype=pdf` |
| **Action Attributes** | The operation being requested | `action=READ`, `action=DELETE`, `action=WRITE` |
| **Environmental Attributes** | Contextual/situational factors | `time=09:00-17:00`, `ip_network=10.0.0.0/8`, `device_compliant=true` |

### The ABAC Architecture (XACML Model)

The OASIS XACML (eXtensible Access Control Markup Language) standard defines the canonical ABAC architecture with four components:

1. **Policy Enforcement Point (PEP):** Intercepts the access request from the subject (user, application). Constructs an authorization request and forwards it to the PDP. Enforces the final decision.
2. **Policy Decision Point (PDP):** The policy engine. Receives the request context, retrieves applicable policies, evaluates them, and returns `Permit`, `Deny`, `NotApplicable`, or `Indeterminate`.
3. **Policy Information Point (PIP):** External attribute sources. The PDP queries the PIP to fetch attributes not present in the original request (e.g., querying LDAP for department, querying an MDM for device compliance).
4. **Policy Administration Point (PAP):** Where administrators author and store policies. Policies are written in XACML, Rego (OPA), Cedar, or other policy languages.

### Step-by-Step Access Decision Flow

```
1. User requests: GET /documents/hr-report.pdf

2. PEP intercepts the request, constructs a decision request:
   {
     subject:     { user_id: "alice", department: "HR", clearance: "INTERNAL" },
     resource:    { resource_id: "hr-report.pdf", classification: "CONFIDENTIAL", owner: "HR" },
     action:      { action_id: "READ" },
     environment: { time: "14:32", ip: "10.10.5.22", device_compliant: true }
   }

3. PEP sends decision request to PDP.

4. PDP queries PIP for missing attributes (e.g., verifies clearance level via LDAP).

5. PDP evaluates applicable policies:
   Policy-001: PERMIT if subject.department == resource.owner AND action == READ
   Policy-002: DENY  if environment.device_compliant == false
   Policy-003: DENY  if environment.time NOT IN [08:00-18:00]

6. Combining algorithm (e.g., "deny-overrides") resolves conflicts.

7. PDP returns: PERMIT

8. PEP allows the request to proceed to the resource server.
```

### XACML Policy Example

```xml
<Policy PolicyId="HR-Read-Policy"
        RuleCombiningAlgId="urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-overrides">

  <Rule RuleId="PermitHRRead" Effect="Permit">
    <Condition>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
        <!-- Subject must be in HR department -->
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
          <AttributeDesignator Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject"
                               AttributeId="department" DataType="string"/>
          <AttributeValue DataType="string">HR</AttributeValue>
        </Apply>
        <!-- Action must be READ -->
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
          <AttributeDesignator Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action"
                               AttributeId="action-id" DataType="string"/>
          <AttributeValue DataType="string">READ</AttributeValue>
        </Apply>
      </Apply>
    </Condition>
  </Rule>

  <!-- Default deny -->
  <Rule RuleId="DefaultDeny" Effect="Deny"/>
</Policy>
```

### Open Policy Agent (OPA) / Rego Example

OPA is a modern, widely deployed policy engine that implements ABAC using the **Rego** policy language:

```rego
package documents.authz

import future.keywords.if

default allow := false

# Allow read if user's department matches document owner AND device is compliant
allow if {
    input.action == "READ"
    input.subject.department == input.resource.owner
    input.environment.device_compliant == true
    time_in_business_hours
}

time_in_business_hours if {
    hour := time.clock(time.now_ns())[0]
    hour >= 8
    hour < 18
}
```

### AWS IAM as ABAC in Practice

AWS IAM implements ABAC using **condition keys** and **resource tags**. A policy granting access only when the user's department tag matches the resource tag:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": "arn:aws:s3:::company-data/*",
      "Condition": {
        "StringEquals": {
          "s3:ResourceTag/Department": "${aws:PrincipalTag/Department}",
          "aws:PrincipalTag/Compliance": "true"
        },
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
```

---

## Key Concepts

- **Subject Attributes:** Properties assigned to the entity requesting access. These may include user identity, department, job title, security clearance level, group membership, or biometric factors. Subject attributes are typically sourced from directory services like Active Directory or an IdP via SAML/OIDC tokens.

- **Resource Attributes:** Properties of the object being accessed. A file might carry attributes like `classification=PII`, `project=Apollo`, or `retention_period=7years`. These attributes are often stored as metadata, object tags (in cloud storage), or in a separate attribute store. The PDP matches these against the requesting subject's attributes to determine appropriateness of access.

- **Policy Combining Algorithms:** When multiple policies apply to a single request, a combining algorithm resolves conflicts. `deny-overrides` means any Deny result causes an overall Deny. `permit-overrides` means any Permit causes an overall Permit. `first-applicable` uses the first policy that returns a definitive result. The choice of algorithm has significant security implications.

- **Policy Decision Point (PDP):** The core logic engine of an ABAC system. It is authoritative for access decisions and must be treated as a critical security control. PDPs can be centralized (a single policy engine) or distributed (sidecar proxies in a microservices mesh). Examples include OPA (Open Policy Agent), Axiomatics Policy Server, and PlainID.

- **Policy Information Point (PIP):** The attribute authority. The PDP relies on the PIP to supply attribute values that aren't present in the initial request. A PIP might query LDAP for group membership, an MDM system for device compliance status, a threat intelligence feed for IP reputation, or a SIEM for user risk scores. PIP availability and integrity are critical to ABAC correctness.

- **XACML (eXtensible Access Control Markup Language):** The OASIS standard (v3.0) for expressing ABAC policies and the request/response protocol between PEP and PDP. While verbose, XACML provides a complete, interoperable framework. Modern alternatives include OPA's Rego, AWS Cedar, and Google Zanzibar for relationship-based variants.

- **Environmental Attributes:** Context that isn't about who the user is or what they're accessing, but about the circumstances of the request. Time of day, geographic location, network zone, device posture, and threat level are all environmental attributes. These enable time-fenced, location-locked, and risk-adaptive access policies — core requirements of Zero Trust.

---

## Exam Relevance

**SY0-701 Domain Mapping:** ABAC falls primarily under **Domain 4.0 – Security Operations** (specifically 4.6: Access Control Models) and **Domain 5.0 – Security Program Management** (governance of access control).

**Key Exam Tips:**

- The Security+ exam distinguishes ABAC from RBAC primarily on **granularity and dynamism**. RBAC uses roles as the single access determinant; ABAC uses *multiple attributes and policies*. If a question describes a policy that checks department AND time AND device compliance, that's ABAC.
- ABAC is described as **more granular and flexible** than RBAC, but also **more complex to implement and manage**.
- Know that ABAC is aligned with **Zero Trust** principles — it is explicitly referenced in NIST SP 800-207 as the preferred model for Zero Trust authorization.
- **Rule-Based Access Control** is sometimes confused with ABAC. Rule-Based uses static IF/THEN rules applied uniformly (like firewall ACLs), while ABAC evaluates dynamic attribute sets per request. The exam may present distractors using these terms.
- The term **PBAC (Policy-Based Access Control)** may appear as a synonym or near-synonym for ABAC. Treat them as equivalent for exam purposes unless the question context suggests otherwise.
- **Common gotcha:** MAC (Mandatory Access Control) uses fixed labels (Top Secret, Secret) enforced by the OS — it's not ABAC even though labels are a form of attribute. ABAC is typically implemented at the application or middleware layer.

**Sample Question Pattern:**
> *"A company wants to grant access to financial reports only to employees in the Finance department, during business hours, using a compliant corporate device. Which access control model best fits this requirement?"*
> **Answer: ABAC** — because the decision requires evaluating multiple attribute types simultaneously (department, time, device state).

---

## Security Implications

### Attack Vectors

- **Attribute Manipulation / Injection:** If attribute values are sourced from user-controlled input or poorly validated external systems, an attacker can forge attributes to escalate privileges. For example, if a JWT claim representing `department` can be modified by the client without server-side verification, an attacker could claim `department=Finance` and gain inappropriate access. This is analogous to [[JWT Attacks]] and parameter tampering.

- **Policy Misconfiguration:** Overly permissive combining algorithms (e.g., `permit-overrides` when `deny-overrides` was intended) or incomplete policy sets that return `NotApplicable` (which may default to `Permit` in some engines) can result in unintended access grants. Policy logic errors are the most common real-world ABAC failure mode.

- **PIP Poisoning / Attribute Store Compromise:** If the Policy Information Point (LDAP, database, IdP) is compromised, attackers can modify attribute values to gain unauthorized access. An attacker who can write to Active Directory attributes could, for example, elevate their own `clearance` attribute. This is a form of [[Privilege Escalation]] via attribute forgery.

- **PDP Availability Attacks:** The PDP is a centralized critical component. A [[Denial of Service (DoS)]] attack against the PDP could either block all access (if the system fails closed) or grant all access (if it fails open). Many organizations configure fail-open behavior for availability, which is a significant security risk.

- **Policy Bypass via Context Manipulation:** Attributes like IP address, time, or device compliance status can sometimes be spoofed or manipulated. VPN usage to appear on an internal network, clock manipulation, or MDM bypass techniques (jailbreaking) can fool environmental attribute checks.

### Real-World Incidents

- **Capital One Breach (2019):** The SSRF vulnerability exploited against AWS EC2 metadata allowed an attacker to retrieve IAM credentials. The resulting over-permissive IAM policies (effectively ABAC misconfigurations) granted the attacker access to S3 buckets far beyond what was necessary, demonstrating that tag-based ABAC policies must be tightly scoped and S3 bucket tagging must be enforced consistently.

- **Misconfigured OPA Instances:** Security researchers have repeatedly found publicly exposed OPA instances with default configurations that allow unauthenticated policy queries, exposing full policy logic and enabling attackers to reverse-engineer access control rules and find bypasses.

---

## Defensive Measures

### Policy Design and Management

- **Adopt a default-deny posture:** All policies should begin with an explicit `deny-all` base rule. Access is granted only by explicit `Permit` decisions. Configure combining algorithms to `deny-overrides` unless there is a specific reason not to.
- **Use a Policy Administration Point (PAP) with version control:** Store all ABAC policies in Git with mandatory peer review and CI/CD-enforced policy testing (OPA has a built-in test framework with `opa test`). Never allow manual policy edits directly in production.
- **Policy unit testing with OPA:**

```bash
# Write policy tests in Rego
# File: authz_test.rego
package documents.authz_test

import data.documents.authz

test_allow_hr_during_hours {
    authz.allow with input as {
        "action": "READ",
        "subject": {"department": "HR"},
        "resource": {"owner": "HR"},
        "environment": {"device_compliant": true}
    }
}

test_deny_wrong_department