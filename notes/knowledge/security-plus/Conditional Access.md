---
domain: "Identity and Access Management"
tags: [conditional-access, zero-trust, authentication, authorization, identity, mfa]
---
# Conditional Access

**Conditional Access** is a [[Zero Trust]] security model that evaluates a set of signals — such as user identity, device health, location, and application sensitivity — before granting or denying access to resources. It acts as a **policy engine** that sits between a user's authentication attempt and the resource they want to reach, enforcing [[Least Privilege]] dynamically based on real-time context. First popularized by Microsoft Azure AD (now Entra ID), Conditional Access is now a foundational component of modern [[Identity and Access Management]] platforms and enterprise security architecture.

---

## Overview

Traditional access control models operated on a binary perimeter model: once inside the network, users were generally trusted. Conditional Access emerged as a response to the dissolution of the corporate perimeter driven by cloud adoption, remote work, and the proliferation of personal devices. Rather than asking only "who are you?", Conditional Access asks "who are you, where are you, what device are you on, and what are you trying to do?" before rendering a decision.

The architecture of Conditional Access relies on **policy evaluation at the identity plane** rather than the network plane. When a user attempts to access an application or resource, an identity provider (IdP) such as Microsoft Entra ID, Okta, or Ping Identity intercepts the authentication request and evaluates it against a library of administrator-defined policies. These policies combine **conditions** (the "if") with **access controls** (the "then"). A condition might be "user is outside the corporate IP range," and the corresponding control might be "require [[Multi-Factor Authentication]]" or "block access entirely."

Conditional Access is closely tied to the broader [[Zero Trust Architecture]] philosophy. Zero Trust mandates that no user, device, or network segment should be implicitly trusted. Conditional Access is the technical implementation layer that enforces this philosophy at every login attempt. This is distinct from traditional [[Role-Based Access Control]] (RBAC) because RBAC assigns static permissions based on job function, while Conditional Access applies dynamic policy enforcement based on runtime context.

Real-world deployments of Conditional Access typically protect high-value assets like corporate email (Exchange Online), cloud storage (SharePoint, OneDrive), SaaS applications (Salesforce, ServiceNow), and administrative portals. Modern platforms integrate with [[Endpoint Detection and Response]] (EDR) tools, [[Mobile Device Management]] (MDM) platforms like Microsoft Intune, and threat intelligence feeds to enrich the signal set used in policy evaluation. For example, a policy might check that a device has a current antivirus signature and no active threat alerts before permitting access, even from a known user with valid credentials.

The regulatory and compliance landscape has also driven Conditional Access adoption. Frameworks such as [[NIST SP 800-207]] (Zero Trust Architecture), SOC 2, ISO 27001, and HIPAA implicitly or explicitly require context-aware access controls. Conditional Access policies serve as a documented, auditable mechanism for demonstrating compliance with access control requirements, making them valuable not only as security controls but as compliance artifacts.

---

## How It Works

Conditional Access functions as a **policy enforcement point (PEP)** that intercepts the authentication and authorization flow, typically integrated with a SAML 2.0 or OpenID Connect (OIDC) identity provider. The process follows a distinct signal-collect → policy-evaluate → action pattern.

### Signal Collection Phase

When a user initiates a sign-in, the IdP collects a broad array of signals before evaluating policy:

- **User/Group identity**: Who is authenticating? Are they a member of privileged groups (e.g., Global Admins)?
- **Device state**: Is the device Entra ID-joined, compliant per Intune MDM policy, or unmanaged?
- **Location**: Does the source IP match a named location (corporate egress IPs) or a known Tor exit node?
- **Application**: What resource is being accessed — low-sensitivity (Teams) vs. high-sensitivity (Azure Portal)?
- **Sign-in risk**: Is the [[Identity Protection]] engine flagging anomalous behavior (impossible travel, leaked credentials)?
- **User risk**: Has the account been flagged as compromised based on leaked credentials from threat intelligence databases?

### Policy Evaluation Phase

Policies are evaluated as **if-then statements**:

```
IF:
  User is in group "All Users"
  AND accessing application "Azure Management Portal"
  AND device is NOT marked "Compliant" in Intune
THEN:
  Block Access
```

```
IF:
  User is in group "Remote Workers"
  AND sign-in location is NOT in named location "Corporate HQ"
  AND sign-in risk = Medium OR High
THEN:
  Require MFA
  Require password change
```

Policies are evaluated in the cloud identity plane; there is no on-premises firewall rule equivalent. The decision is embedded in the token issuance process — if access is blocked, no OAuth/OIDC token is issued.

### Grant Controls (Actions)

When conditions are met, the following grant controls can be applied:

| Control | Description |
|---|---|
| Block access | Hard deny; no token issued |
| Require MFA | Step-up authentication required |
| Require compliant device | Device must pass MDM compliance check |
| Require Hybrid Azure AD join | Device must be domain-joined and registered |
| Require approved client app | Only approved apps (e.g., Outlook, not web browser) |
| Require app protection policy | Intune MAM policy must be applied |
| Require password change | Force credential reset |

### Session Controls

Beyond grant controls, Conditional Access can also apply **session controls** that modify the experience post-authentication:

```
IF:
  User is accessing SharePoint
  AND device is unmanaged (personal device)
THEN:
  Allow access BUT:
    - Disable file download
    - Disable printing
    - Enable sign-in frequency (re-auth every 1 hour)
    - Apply Microsoft Defender for Cloud Apps monitoring
```

Session controls use **Continuous Access Evaluation (CAE)**, a protocol where the resource provider (e.g., Exchange Online) can revoke tokens mid-session if conditions change — for example, if a user's account is disabled or their IP suddenly changes to a flagged range. CAE uses a near-real-time push model over HTTPS rather than waiting for token expiry (default 1 hour).

### Protocol and Infrastructure Details

- **Transport**: HTTPS (TCP 443) for all token requests
- **Token format**: JWT (JSON Web Token) with claims evaluated at the resource provider
- **Key protocols**: OAuth 2.0, OpenID Connect (OIDC), SAML 2.0
- **Named locations**: Defined using IPv4/IPv6 CIDR ranges or GPS-based country-level filtering
- **Risk signals**: Integrated from Microsoft Entra Identity Protection, Microsoft Defender, and third-party SIEM/SOAR feeds
- **Evaluation latency**: Typically under 200ms for policy evaluation in Entra ID

### Microsoft Entra ID – Policy Configuration (PowerShell Example)

```powershell
# Install Microsoft Graph PowerShell module
Install-Module Microsoft.Graph -Scope CurrentUser

# Connect with required permissions
Connect-MgGraph -Scopes "Policy.ReadWrite.ConditionalAccess"

# Create a basic Conditional Access policy requiring MFA for Azure Portal
$conditions = @{
    users = @{
        includeGroups = @("All Users Group GUID")
    }
    applications = @{
        includeApplications = @("797f4846-ba00-4fd7-ba43-dac1f8f63013") # Azure Management
    }
    locations = @{
        includeLocations = @("All")
        excludeLocations = @("AllTrusted")
    }
}

$grantControls = @{
    operator = "OR"
    builtInControls = @("mfa")
}

New-MgIdentityConditionalAccessPolicy `
    -DisplayName "Require MFA for Azure Portal - External" `
    -State "enabled" `
    -Conditions $conditions `
    -GrantControls $grantControls
```

---

## Key Concepts

- **Signal**: Any piece of context data fed into the Conditional Access policy engine, including user identity, device compliance state, IP address, sign-in risk score, and application sensitivity. The richness of signals determines the precision of policy enforcement.

- **Named Location**: A defined set of IP address ranges or geographic regions that represent trusted (e.g., corporate office) or untrusted (e.g., sanctioned countries) locations. Named locations are used as conditions in policies to differentiate behavior for on-site vs. remote access.

- **Compliant Device**: A device that has been enrolled in an MDM platform (e.g., Microsoft Intune) and satisfies all compliance policies — such as requiring disk encryption, OS patch level, and screen lock timeout. Requiring a compliant device is one of the strongest Conditional Access controls because it ties identity to a specific trusted hardware posture.

- **Sign-in Risk vs. User Risk**: Sign-in risk assesses the probability that a specific authentication attempt is unauthorized (e.g., impossible travel, anonymous IP). User risk assesses the probability that a user account itself is compromised (e.g., credential breach detected in threat intelligence feeds). Both are computed by [[Identity Protection]] and can be used as Conditional Access conditions.

- **Continuous Access Evaluation (CAE)**: A mechanism that allows resource providers to subscribe to critical user events (account disabled, password changed, session revoked) and immediately invalidate access tokens without waiting for standard token expiration. This closes the window where a valid token could be used after account compromise.

- **Break-Glass Account**: An emergency access account deliberately excluded from all Conditional Access policies, including MFA requirements, to ensure administrative access is available even if the IdP or MFA provider is unavailable. These accounts must be tightly controlled, audited, and their usage triggers high-priority alerts.

- **Report-Only Mode**: A non-enforcement policy state in which Conditional Access logs what *would have* happened if the policy were active, without actually blocking or requiring anything. This is critical for impact assessment before enabling new policies in production.

---

## Exam Relevance

**SY0-701 Mapping**: Conditional Access appears most directly under **Domain 4.0 – Security Operations** and **Domain 5.0 – Security Program Management**, particularly in the context of identity management, Zero Trust implementations, and access control enforcement.

**Key SY0-701 Themes to Know**:

- Conditional Access is the practical implementation of **Zero Trust** — the exam frequently asks you to identify the Zero Trust principle being applied when access is granted based on device health + identity + location.
- Understand that Conditional Access is an **authentication + authorization** control, not a network control. It doesn't replace firewalls or NAC; it complements them at the identity layer.
- The exam may present scenarios where MFA alone is insufficient and ask what additional control provides stronger assurance — the answer often involves **device compliance** (Conditional Access) rather than just password or MFA.
- Know the difference between **authentication** (proving identity) and **authorization** (granting access). Conditional Access lives at the intersection — it can interrupt the flow between them.
- **Gotcha**: Conditional Access policies apply to cloud identity flows. They do NOT natively protect on-premises Kerberos authentication unless you have Entra ID hybrid join + Entra ID Application Proxy in place.
- **Gotcha**: Legacy authentication protocols (SMTP AUTH, IMAP, POP3) bypass Conditional Access because they don't support modern authentication token flows. Blocking legacy authentication is a separate, critical hardening step.
- Exam questions may use the term "adaptive authentication" — this is essentially Conditional Access described in vendor-agnostic terms.
- Understand **least privilege in context**: a Conditional Access policy that allows read-only access from unmanaged devices but full access from compliant devices is an example of context-aware least privilege.

---

## Security Implications

### Attack Vectors Against Conditional Access

**Legacy Authentication Bypass**: The most common and impactful weakness. Protocols like IMAP, POP3, SMTP AUTH, and Basic Authentication do not support modern authentication flows and therefore entirely bypass Conditional Access policies. Attackers with compromised credentials can use tools like `ruler` or custom scripts to authenticate via legacy protocols even when MFA is enforced for modern auth flows. Microsoft's own data indicated that over 99% of password spray attacks used legacy authentication protocols at their peak.

**Token Theft and Session Hijacking**: Conditional Access grants tokens (JWTs) upon successful evaluation. If an attacker steals a valid access token — via adversary-in-the-middle (AiTM) phishing using tools like **Evilginx2** or **Modlishka** — they can replay that token to the resource provider without triggering Conditional Access re-evaluation. This is because the token already contains the Conditional Access satisfaction claims. The **Midnight Blizzard** (APT29) attack on Microsoft in 2023 involved exactly this technique — using AiTM phishing to steal OAuth tokens and bypass MFA/Conditional Access entirely.

**Policy Misconfiguration**: Overly permissive policies, forgotten exclusions (e.g., service accounts excluded from MFA policies), and break-glass accounts with weak monitoring are common real-world failures. A policy that says "require MFA for all users" but excludes a legacy service account used by an attacker provides no protection for that vector.

**Compliant Device Compromise**: If an attacker compromises an endpoint that is marked as Intune-compliant, they effectively inherit all trust that device carries. Conditional Access's device compliance check relies on the integrity of the MDM system — if that system is compromised or device certificates are stolen, the control fails.

**Conditional Access Gap in Federated Environments**: In environments using third-party IdPs (ADFS, Ping, Okta) federated with Entra ID, Conditional Access policies may only apply after the federated token is exchanged. Authentication occurring entirely within the third-party IdP may not be subject to Entra Conditional Access at all, creating blind spots.

**Relevant Incidents**:
- **Lapsus$ Group (2022)**: Repeatedly bypassed MFA using SIM swapping and social engineering of MFA fatigue (MFA bombing), demonstrating that Conditional Access policies requiring MFA are only as strong as the MFA method used. SMS-based MFA is insufficient for high-value targets.
- **Storm-0558 (2023)**: Exploited a forged Microsoft account consumer signing key to forge authentication tokens, demonstrating that even Conditional Access controls can be bypassed if the underlying token infrastructure is compromised — a supply chain-level attack on identity.

---

## Defensive Measures

### Block Legacy Authentication Immediately
Create a dedicated Conditional Access policy targeting all users and all cloud apps that blocks any authentication using legacy authentication client apps:

```
Conditions → Client apps → Select: Exchange ActiveSync clients + Other clients
Grant → Block access
```

This single control eliminates the largest single bypass vector for Conditional Access.

### Use Phishing-Resistant MFA
Replace SMS and voice-based MFA with **FIDO2 security keys** (YubiKey, Windows Hello for Business, Passkeys) which are immune to AiTM token theft. Configure Conditional Access Authentication Strengths to require phishing-resistant MFA for administrator roles and sensitive applications.

### Enable Microsoft Entra Identity Protection
Activate risk-based Conditional Access policies:
- **User risk ≥ High → Require password change**
- **Sign-in risk ≥ Medium → Require MFA**
- **Sign-in risk = High → Block access**

These policies ensure that even if a user's credentials are compromised, anomalous login behavior triggers additional friction or blocking.

### Require Compliant Devices for Sensitive Resources
For administrative portals, financial applications, and any resource containing sensitive data, require device compliance through Intune MDM. Define compliance policies that mandate:
- BitLocker/FileVault encryption enabled
- OS patches within 30 days of release
- Antivirus signature currency
- Screen lock timeout ≤ 15 minutes
- No jailbreak/root detected (mobile)

### Monitor and Alert on Break-Glass Usage
Break-glass accounts must be excluded from Conditional Access MFA requirements by design. Compensate with:
```
Azure Monitor Alert Rule:
  Signal: Sign-in logs
  Condition: UPN equals "breakglass@domain.com"
  Action: Immediate PagerDuty/email/SMS alert to Security team
```

### Use Report-Only Mode Before Enabling Policies
Never enable a new Conditional Access policy directly in "enabled" state in production. Always deploy in `reportOnly` first for 7–14 days, review the Conditional Access insights workbook in Azure Monitor, identify unintended impacts, then promote to enabled.

### Regularly Audit Policy Exclusions
Policy exclus