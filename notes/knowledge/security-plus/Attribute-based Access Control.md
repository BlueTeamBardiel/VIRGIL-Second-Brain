---
domain: "Identity and Access Management"
tags: [access-control, authorization, iam, zero-trust, policy-enforcement, abac]
---
# Attribute-based Access Control

**Attribute-based Access Control (ABAC)** is an authorization paradigm that grants or denies access to resources based on evaluated **policies** that combine attributes of the **subject** (user), **object** (resource), **action**, and **environment** rather than relying solely on static role assignments. Unlike [[Role-based Access Control (RBAC)]], ABAC enables fine-grained, dynamic, and context-aware decisions that can incorporate dozens of factors simultaneously. It is foundational to modern [[Zero Trust Architecture]] implementations and is codified in NIST Special Publication 800-162.

---

## Overview

ABAC emerged from the limitations of earlier access control models. [[Discretionary Access Control (DAC)]] and [[Mandatory Access Control (MAC)]] were designed for relatively static environments where resource ownership or security labels drove decisions. As enterprise environments scaled to thousands of users, hundreds of applications, and highly dynamic contexts—cloud workloads, remote access, bring-your-own-device policies—the rigidity of those models became a liability. RBAC partially addressed this by grouping permissions into roles, but role explosion (organizations accumulating hundreds of overlapping roles) and the inability to account for contextual factors like time-of-day or device health exposed its limits.

ABAC addresses these problems by treating access decisions as **policy evaluation problems**. Every relevant characteristic of the requestor, the resource being accessed, the action being attempted, and the surrounding environment is expressed as an **attribute**—a key-value pair—and a policy written in a structured language evaluates combinations of those attributes at runtime. A policy might state: "Allow access to financial records if the subject's department is 'Finance', their clearance level is 'Confidential', the request originates from a managed device, and the current time is within business hours." This cannot be expressed cleanly in RBAC without creating an enormous and unmanageable number of roles.

In practice, ABAC is deployed in enterprise identity platforms, cloud IAM systems (AWS IAM condition keys, Azure ABAC for storage, Google IAM conditions), database security layers, and API gateways. The U.S. federal government formally adopted ABAC as the preferred model for logical access control through NIST guidance, and it underpins many [[XACML]] deployments as well as modern policy-as-code frameworks like Open Policy Agent (OPA). Healthcare organizations use ABAC to enforce HIPAA-compliant access where a nurse may access patient records only for patients on their assigned ward, during their shift, from a hospital network endpoint.

ABAC is sometimes called **Policy-Based Access Control (PBAC)** in vendor literature, though PBAC is technically a broader category. The distinction is largely semantic in practice; both terms refer to externalizing authorization logic into evaluated policies rather than hard-coding it into applications. When organizations layer ABAC policies on top of an existing RBAC structure—using roles as one attribute among many—the combined model is sometimes called **ReBAC** (Relationship-Based Access Control) or simply a hybrid model.

---

## How It Works

### Architectural Components

ABAC follows a well-defined architecture standardized in NIST SP 800-162 and the XACML specification. Four core logical components interact to produce an access decision:

1. **Policy Enforcement Point (PEP):** The component that intercepts an access request and enforces the decision. This is the API gateway, the proxy server, the database driver wrapper, or the application middleware that blocks or permits the request based on instructions from the PDP.

2. **Policy Decision Point (PDP):** The authorization engine that receives a structured request, retrieves applicable policies, fetches attributes from PIPs, evaluates policy logic, and returns a Permit, Deny, NotApplicable, or Indeterminate decision.

3. **Policy Information Point (PIP):** Attribute stores and retrieval services. PIPs might be an LDAP directory for user department and job title, an MDM system for device compliance status, a CMDB for resource classification, or a threat intelligence feed for IP reputation.

4. **Policy Administration Point (PAP):** The management interface where administrators author, version, and publish policies. Tools like OPA's Rego playground, AWS IAM policy editor, or a dedicated XACML policy authoring tool serve this function.

### Request Lifecycle

```
1. User requests: GET /api/finance/reports/q3-2024

2. PEP intercepts request and constructs an authorization context:
   Subject Attributes:
     - user.id = "alice@corp.com"
     - user.department = "Finance"
     - user.clearance = "Confidential"
     - user.mfa_verified = true

   Resource Attributes:
     - resource.type = "financial_report"
     - resource.classification = "Confidential"
     - resource.owner_department = "Finance"

   Action Attributes:
     - action.verb = "read"

   Environment Attributes:
     - env.time = "14:32 UTC Tuesday"
     - env.device_managed = true
     - env.network = "corporate_vpn"
     - env.ip_risk_score = 2

3. PEP sends structured authorization request to PDP

4. PDP loads applicable policies, queries PIPs for fresh attributes

5. PDP evaluates policy logic:
   PERMIT if:
     user.department == resource.owner_department
     AND user.clearance >= resource.classification
     AND user.mfa_verified == true
     AND env.device_managed == true
     AND env.time WITHIN business_hours

6. PDP returns: PERMIT

7. PEP allows the request to proceed
```

### Policy Expression with Open Policy Agent (OPA)

OPA uses the **Rego** language for policy expression. Below is a functional ABAC policy:

```rego
package finance.access

default allow = false

allow {
    # Subject attributes
    input.user.department == "Finance"
    input.user.clearance == "Confidential"
    input.user.mfa_verified == true

    # Resource attributes
    input.resource.classification == "Confidential"

    # Action attributes
    input.action.verb == "read"

    # Environment attributes
    input.env.device_managed == true
    within_business_hours
}

within_business_hours {
    hour := time.clock(time.now_ns())[0]
    hour >= 8
    hour < 18
}
```

Test this policy with OPA's REST API on port **8181**:

```bash
# Start OPA server
opa run --server --addr :8181 finance_policy.rego

# Send an authorization request
curl -X POST http://localhost:8181/v1/data/finance/access/allow \
  -H "Content-Type: application/json" \
  -d '{
    "input": {
      "user": {
        "department": "Finance",
        "clearance": "Confidential",
        "mfa_verified": true
      },
      "resource": {
        "classification": "Confidential"
      },
      "action": {
        "verb": "read"
      },
      "env": {
        "device_managed": true
      }
    }
  }'
```

Expected response: `{"result": true}`

### XACML Policy Structure

For enterprise deployments using the XACML 3.0 standard (OASIS), policies are expressed in XML:

```xml
<Policy PolicyId="FinanceReadPolicy"
        RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:deny-overrides">
  <Target>
    <AnyOf>
      <AllOf>
        <Match MatchId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
          <AttributeValue DataType="string">read</AttributeValue>
          <AttributeDesignator
            AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id"
            Category="urn:oasis:names:tc:xacml:3.0:attribute-category:action"/>
        </Match>
      </AllOf>
    </AnyOf>
  </Target>
  <Rule RuleId="FinanceUserRule" Effect="Permit">
    <Condition>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
        <!-- Department check -->
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
          <AttributeDesignator AttributeId="department"
            Category="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject"
            DataType="string" MustBePresent="true"/>
          <AttributeValue DataType="string">Finance</AttributeValue>
        </Apply>
      </Apply>
    </Condition>
  </Rule>
</Policy>
```

### AWS IAM ABAC with Tags

AWS natively supports ABAC through resource tags and IAM condition keys:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": "arn:aws:s3:::corp-documents/*",
      "Condition": {
        "StringEquals": {
          "s3:ExistingObjectTag/Department": "${aws:PrincipalTag/Department}",
          "aws:PrincipalTag/Clearance": "Confidential",
          "aws:RequestedRegion": "us-east-1"
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

- **Subject Attributes:** Characteristics describing the entity requesting access—user identity, department, job title, security clearance, group memberships, authentication assurance level (AAL), and MFA status. These are typically sourced from directory services like [[Active Directory]] or an [[Identity Provider (IdP)]].

- **Resource Attributes:** Properties of the object being accessed—data classification label (e.g., Public, Internal, Confidential, Restricted), owning department, data type, geographic jurisdiction, sensitivity tags, and creation date. These are often stored in a CMDB or attached as metadata/tags in cloud environments.

- **Environment Attributes:** Contextual factors external to the subject and resource—current time and day, geographic location of the request, network zone (corporate LAN, VPN, public internet), device compliance state (managed vs. unmanaged, patch level), IP reputation score, and active threat alerts.

- **Policy:** A formal rule set authored at the PAP that specifies which combination of attribute values results in a Permit or Deny decision. Policies may be combined using combining algorithms such as **deny-overrides** (any Deny result wins), **permit-overrides** (any Permit wins), or **first-applicable** (first matching rule applies).

- **Policy Combining Algorithm:** The logic that resolves conflicts when multiple policies apply to the same request. The **deny-overrides** algorithm is the most secure default as it ensures that if any policy denies access, the overall decision is Deny, preventing privilege escalation through policy ambiguity.

- **Attribute Trust and Freshness:** ABAC security depends on the integrity and currency of attributes. A stale attribute—such as a cached department value for a terminated employee—can permit unauthorized access. Attribute freshness policies (max-age, real-time PIP queries) must be part of the design.

- **Negative Authorization:** ABAC natively supports explicit Deny policies, meaning access can be blocked even if a Permit policy also matches. This allows fine-grained exceptions, such as denying all access to a specific sensitive resource regardless of other permissions.

---

## Exam Relevance

**Security+ SY0-701 Domain:** 4.0 Security Operations (specifically 4.3 – Access Control Models)

### Key Exam Points

- **ABAC vs. RBAC:** Expect questions distinguishing these models. RBAC assigns permissions to *roles* and users to roles. ABAC evaluates *attributes* dynamically. The tell in a question is whether contextual factors (time, location, device state) are involved—that points to ABAC.

- **ABAC vs. MAC:** MAC uses fixed sensitivity labels and clearances set by a central authority; users cannot change them. ABAC can *incorporate* labels as attributes but is far more flexible. MAC is the model for classified government systems (Bell-LaPadula); ABAC is the modern enterprise model.

- **"Which access control model is most flexible and dynamic?"** → ABAC. This is a common stem.

- **Zero Trust connection:** Questions about Zero Trust often reference continuous verification and contextual access decisions—these describe ABAC principles. Know that Zero Trust relies on ABAC-like policy evaluation for every access request.

- **Attribute sources:** Know that attributes can come from HR systems, directory services, MDM/EDR platforms, and threat intelligence feeds. The concept of "trust but verify" attribute sources is relevant to exam questions about access control integrity.

### Common Gotchas

- Do not confuse ABAC with **PBAC**—on the exam they are treated synonymously; don't overthink vendor-specific naming.
- ABAC does **not** eliminate the need for authentication—it operates *after* authentication to make authorization decisions.
- "Context-aware access control" in exam questions is describing ABAC behavior even if the term isn't used.
- The **Policy Enforcement Point** enforces; the **Policy Decision Point** decides. Students often confuse these under exam pressure.

---

## Security Implications

### Attack Surface and Vulnerabilities

**Policy Logic Errors:** Incorrectly authored policies are the primary vulnerability class in ABAC deployments. A misconfigured combining algorithm (e.g., using permit-overrides when deny-overrides was intended) can allow a single permissive policy to override all deny policies, granting unintended access. This is analogous to a firewall rule ordering mistake but with potentially broader blast radius.

**Attribute Injection:** If an attacker can manipulate the attributes presented to the PDP—either by poisoning directory service entries, tampering with JWT claims that carry attributes, or exploiting a poorly authenticated PIP—they can cause the policy engine to evaluate against fraudulent attribute values. JWT-based attribute delivery is particularly susceptible if signature validation is weak or if attribute claims are accepted from untrusted issuers. This maps to [[OWASP API Security Top 10]] API2:2023 (Broken Authentication) and API5:2023 (Broken Function Level Authorization).

**PDP Availability Attacks:** Because every access decision flows through the PDP, it becomes a high-value denial-of-service target. If the PDP is unavailable and the PEP is configured to **fail-open** (allow access when the decision point is unreachable), attackers who can disrupt the PDP gain access to all protected resources. A notable operational pattern in misconfigured OPA deployments involves the PEP defaulting to permit on timeout.

**Stale Attribute Exploitation:** An attacker who is terminated but whose LDAP attributes haven't been updated (or whose cached attributes remain valid) can continue to access resources. Insider threat scenarios commonly involve a window between an employee's status change and attribute propagation across all PIPs.

**Relevant CVE Context:** While CVEs are rarely filed against ABAC frameworks specifically (policy logic is not patched like software vulnerabilities), CVE-2022-24348 (Argo CD path traversal allowing policy bypass) demonstrates how implementation flaws in policy enforcement infrastructure can undermine theoretically sound ABAC designs. Similarly, misconfigured AWS IAM ABAC tag conditions have been a documented vector in cloud penetration tests where attackers with tag-write permissions on their own IAM user could escalate privileges by modifying the tag values used in condition evaluations.

**Privilege Escalation via Tag Manipulation (AWS):** If IAM ABAC policies trust `aws:PrincipalTag` values and the user or role has permissions to modify their own tags (`iam:TagUser`), an attacker can self-assign tags that satisfy access conditions for sensitive resources—a form of horizontal privilege escalation unique to ABAC implementations using mutable attributes.

---

## Defensive Measures

### Policy Governance

- **Treat policies as code:** Store all ABAC policies in version-controlled repositories (Git). Require pull request reviews, automated testing with policy unit tests (OPA's `opa test` command), and signed commits before deployment. This provides auditability