---
domain: "Identity and Access Management"
tags: [identity, zero-trust, authentication, access-control, risk-based-security, iam]
---
# Adaptive Identity

**Adaptive identity** is a security framework in which access decisions are made **dynamically at the time of authentication or authorization**, using contextual signals such as device posture, location, behavior, and risk scoring rather than relying solely on static credentials. It is a foundational component of [[Zero Trust Architecture]] and closely related to [[Risk-Based Authentication]], enabling organizations to continuously evaluate *who* is requesting access, *from where*, *with what device*, and *under what circumstances* before granting or denying access to resources.

---

## Overview

Traditional identity systems operate on a binary model: a user provides the correct username and password, and access is granted. This model is fundamentally inadequate in modern threat environments where credentials are routinely compromised through [[Phishing]], [[Credential Stuffing]], and data breaches. Adaptive identity emerged as a response to this inadequacy, shifting the paradigm from *"prove who you are once"* to *"continuously prove that this access makes sense in context."*

The core premise of adaptive identity is that **trust should never be implicit and always be earned dynamically**. Every authentication event carries a risk score derived from multiple signals: the geographic location of the login attempt, the reputation of the source IP address, the health and compliance posture of the device, the time of day relative to the user's normal patterns, and the sensitivity of the resource being accessed. If these signals align with expected behavior, access is granted seamlessly, perhaps without additional friction. If anomalies are detected — a login from an unfamiliar country, a new device, or a sudden burst of access requests — the system escalates the authentication challenge or denies access entirely.

Adaptive identity systems typically integrate with a broader **Identity Provider (IdP)** such as Microsoft Entra ID (formerly Azure AD), Okta, or Ping Identity, and leverage [[Security Information and Event Management (SIEM)]] platforms to feed behavioral analytics. The risk engine continuously ingests telemetry from endpoint agents, network logs, and cloud activity, building a baseline of "normal" behavior for each user and entity. This behavioral baseline is what allows the system to detect anomalies without generating unacceptable numbers of false positives.

In regulatory and compliance contexts, adaptive identity supports frameworks like NIST SP 800-207 (Zero Trust Architecture), NIST SP 800-63 (Digital Identity Guidelines), and PCI DSS 4.0, which now explicitly requires risk-based authentication for certain cardholder data access scenarios. The European Banking Authority (EBA) similarly mandates Strong Customer Authentication (SCA) under PSD2, and adaptive identity mechanisms are the primary technical means of satisfying SCA requirements with minimal user friction through the concept of transaction risk analysis (TRA).

The business case for adaptive identity is compelling beyond compliance: organizations using adaptive authentication report significant reductions in account takeover incidents while simultaneously reducing friction for legitimate users. A user logging in from their registered corporate laptop on the corporate network at 9 AM may pass through silently with no MFA prompt, while the same credentials appearing from a Tor exit node at 3 AM trigger an immediate block and security alert.

---

## How It Works

Adaptive identity functions through a pipeline of signal collection, risk scoring, policy evaluation, and enforcement action. The following describes the technical flow in detail.

### 1. Authentication Request Initiation

When a user attempts to authenticate to a protected resource, the request is intercepted by the identity provider or an authentication proxy. In a modern deployment this typically uses:

- **OpenID Connect (OIDC)** over HTTPS (TCP/443) for web and application authentication
- **SAML 2.0** for enterprise SSO federation
- **OAuth 2.0** for API and delegated authorization flows

The initial request captures contextual metadata automatically: source IP address, User-Agent string, timestamp, and any device tokens previously registered.

### 2. Signal Collection

Before the risk engine renders a decision, it gathers signals from multiple sources:

**Device Signals:**
- Device compliance status from [[Mobile Device Management (MDM)]] platforms (Microsoft Intune, Jamf)
- Certificate presence (device certificates issued by an internal PKI)
- Endpoint Detection and Response (EDR) agent health
- OS version and patch level

**Network Signals:**
- IP reputation (checked against threat intelligence feeds)
- Geolocation of the source IP
- AS (Autonomous System) ownership — is this a known VPN, datacenter, or residential ISP?
- Velocity checks — has this IP or user authenticated from a distant location within an impossibly short time frame? (Impossible Travel)

**User Behavioral Signals:**
- Time-of-day relative to historical access patterns
- Resources typically accessed vs. resources now being requested
- Volume and rate of requests (access velocity)
- Privileged action patterns

**Identity Signals:**
- Whether the account appears in a breach credential database (e.g., HIBP integration)
- Recent password changes
- MFA device registration status

### 3. Risk Scoring

The collected signals are fed into a risk scoring engine — either a rule-based system or a machine learning model (or both). The output is a **risk score** typically expressed as Low / Medium / High or as a numeric value (0–100).

Example logic for a Conditional Access policy in Microsoft Entra ID:

```json
{
  "conditions": {
    "signInRiskLevels": ["high", "medium"],
    "locations": {
      "includeLocations": ["All"],
      "excludeLocations": ["AllTrusted"]
    },
    "deviceFilter": {
      "mode": "exclude",
      "rule": "device.isCompliant -eq True"
    }
  },
  "grantControls": {
    "operator": "OR",
    "builtInControls": ["mfa", "compliantDevice"]
  }
}
```

### 4. Policy Evaluation

The risk score is evaluated against pre-defined Conditional Access policies. These policies define thresholds and response actions:

| Risk Level | Response Action |
|------------|----------------|
| Low | Permit (no additional challenge) |
| Medium | Require MFA step-up |
| High | Require MFA + compliant device |
| Critical / Impossible Travel | Block + alert SOC |

### 5. Enforcement Actions

Based on the policy match, the enforcement engine returns one of these outcomes:

- **Allow** — Grant token/session with standard assurance level
- **Step-Up Authentication** — Challenge with [[Multi-Factor Authentication (MFA)]] (TOTP, push notification, FIDO2 hardware key)
- **Reauthentication Required** — Force fresh credential entry even if a valid session exists
- **Block** — Deny access entirely and log the event
- **Session Restriction** — Allow access but limit capabilities (read-only, no data export)

### 6. Continuous Evaluation

Modern adaptive identity systems do not stop evaluating at login. **Continuous Access Evaluation (CAE)**, implemented in standards like the IETF's Shared Signals Framework and supported by Microsoft Entra ID, means that a session token can be revoked mid-session if risk signals change — for example, if the user's IP address suddenly changes during an active session.

```bash
# Example: Querying Microsoft Graph API for risky sign-ins
# Requires AzureAD.IdentityRiskyUser permission

GET https://graph.microsoft.com/v1.0/identityProtection/riskyUsers \
  -H "Authorization: Bearer <access_token>" \
  -H "Content-Type: application/json"
```

---

## Key Concepts

- **Risk Score**: A numeric or categorical value computed from contextual signals at authentication time that represents the probability of malicious activity; used as the primary input for policy decisions.
- **Impossible Travel**: A detection heuristic that flags authentication events where two logins occur from geographically distant locations within a time window that makes physical travel impossible (e.g., New York at 10:00 AM and London at 10:15 AM).
- **Step-Up Authentication**: The process of requiring additional authentication factors mid-session or at login when a risk threshold is crossed, escalating assurance level without full reauthentication where possible.
- **Continuous Access Evaluation (CAE)**: A protocol-level mechanism that allows identity providers to push near-real-time revocation signals to relying parties, invalidating access tokens before their scheduled expiration when risk conditions change.
- **Behavioral Baseline**: A statistical model of a user's or entity's normal access patterns (time, location, resources, volume) against which current activity is compared to detect anomalies.
- **Trust Score / Identity Assurance Level (IAL)**: A measure of confidence in the claimed identity, incorporating both the strength of the initial credential verification and the ongoing contextual signals supporting the current session.
- **Conditional Access Policy**: A rule set that maps combinations of user, device, location, and application conditions to enforcement actions; the primary administrative interface for adaptive identity in enterprise IdP platforms.
- **Token Binding**: A technique that cryptographically ties an OAuth/OIDC token to a specific TLS session, preventing token theft and replay by adversaries who intercept bearer tokens.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Adaptive Identity falls under **Domain 1: General Security Concepts** and **Domain 4: Identity and Access Management**. It is explicitly called out in the SY0-701 exam objectives as a Zero Trust concept.

**Key exam tips:**

- The exam will test your understanding that adaptive identity is **dynamic and context-aware**, contrasting it with static [[Role-Based Access Control (RBAC)]] or simple password authentication.
- Know that adaptive identity is a **control within Zero Trust Architecture** — understand the Zero Trust principle of "never trust, always verify" and how adaptive identity operationalizes it.
- **Common question pattern:** A scenario describes a user logging in from an unusual location and the system requiring additional MFA — this is adaptive identity / risk-based authentication in action.
- Distinguish between **adaptive identity** (which evaluates real-time context) and standard [[Multi-Factor Authentication (MFA)]] (which applies uniformly regardless of context). Adaptive identity *uses* MFA as one possible enforcement action but is not synonymous with it.
- **Gotcha:** Adaptive identity does NOT mean passwords are eliminated. It means the *response* to authentication events is adjusted based on risk. Candidates sometimes conflate this with passwordless authentication.
- The exam may present distractor answers involving [[Attribute-Based Access Control (ABAC)]] — know that ABAC is a related but distinct concept focused on attributes of the subject/object/environment, whereas adaptive identity specifically emphasizes **real-time risk scoring and dynamic policy enforcement**.
- Questions involving **Conditional Access** in Microsoft environments or **Okta Adaptive MFA** are practical implementations of this concept.
- Remember: adaptive identity supports **least privilege** by ensuring elevated assurance is required before granting access to sensitive resources, tying it to [[Principle of Least Privilege]].

---

## Security Implications

### Attack Vectors Against Adaptive Identity Systems

**1. Adversary-in-the-Middle (AiTM) Phishing**
Modern phishing kits (EvilGinx2, Modlishka) act as reverse proxies, intercepting the authentication flow and stealing session cookies *after* MFA has been satisfied. Because the legitimate token is stolen, the adaptive identity system never sees an anomalous login — the attacker replays a valid session. This was the technique used in the 2022 LAPSUS$ attacks against Microsoft and Okta.

- **CVE relevance:** While not a single CVE, the LAPSUS$ intrusions demonstrated that even MFA-enforced adaptive identity can be bypassed when session tokens are the target rather than credentials.

**2. MFA Fatigue / Push Bombing**
If the adaptive system's escalation action is an approval push notification, attackers who already possess valid credentials can flood the user with approval requests until one is accidentally accepted. This technique was used in the 2022 Uber breach (Lapsus$ affiliate).

**3. Trusted Location Exploitation**
If an attacker can route traffic through a trusted IP range (e.g., by compromising a VPN endpoint, a cloud egress IP, or an internal system), the adaptive system may assign a lower risk score and skip step-up authentication.

**4. Device Enrollment Attacks**
An attacker who achieves initial access can register a new device with the IdP, obtaining a compliant device certificate, which then satisfies device-based Conditional Access policies. Microsoft's 2023 guidance specifically calls out this vector as a post-compromise escalation technique.

**5. Risk Score Manipulation**
In systems using IP reputation and geolocation, attackers using residential proxy networks (Luminati/Bright Data, residential botnets) can appear to originate from the victim's geographic area, suppressing anomaly signals.

### Detection Opportunities

- Monitor for impossible travel events in IdP sign-in logs
- Alert on new device registrations, particularly for privileged accounts
- Correlate MFA push sends with user-reported fatigue or unusual hours
- Track Conditional Access policy modifications (attackers may weaken policies post-compromise)

---

## Defensive Measures

**1. Implement Phishing-Resistant MFA**
Deploy [[FIDO2]] hardware security keys (YubiKey, Google Titan) or certificate-based authentication as the step-up factor. These are bound to the origin domain and cannot be proxied by AiTM toolkits. CISA's 2023 guidance explicitly recommends this as the primary countermeasure against AiTM phishing.

**2. Enable Continuous Access Evaluation (CAE)**
In Microsoft Entra ID, enable CAE for supported applications. This ensures that sessions are revoked within seconds of policy changes rather than waiting for token expiration (typically 1 hour).

```
Azure Portal → Entra ID → Security → Continuous Access Evaluation → Enable
```

**3. Enforce Compliant Device Requirements**
Require devices to be Intune-enrolled and compliant (up-to-date OS, EDR agent running, disk encryption enabled) as a condition for accessing sensitive applications. This raises the bar for attacker-registered devices.

**4. Restrict Trusted Locations**
Audit and minimize trusted named locations in Conditional Access policies. Do not blanket-trust all corporate IP ranges — a compromised internal system should not automatically receive elevated trust.

**5. User and Entity Behavior Analytics (UEBA)**
Deploy [[UEBA]] tools (Microsoft Sentinel, Splunk UBA, Exabeam) to build behavioral baselines and detect lateral movement even when credentials are valid.

**6. Privileged Identity Management (PIM)**
Require just-in-time elevation for privileged roles with adaptive controls — high-privilege actions should always trigger step-up authentication regardless of session risk score.

**7. Token Binding and Sender-Constrained Tokens**
Where supported, implement OAuth Demonstrating Proof of Possession (DPoP) or mutual TLS (mTLS) for API tokens, binding them to a specific client key pair so stolen bearer tokens cannot be replayed.

```
# Example DPoP header in an API request
Authorization: DPoP <access_token>
DPoP: <signed-JWT-proof>
```

**8. Monitor and Alert on Policy Changes**
Adaptive identity is only as strong as its policies. Use Azure Monitor / AWS CloudTrail / SIEM to alert on any modifications to Conditional Access policies, MFA configurations, or trusted network definitions.

---

## Lab / Hands-On

### Lab 1: Implement Conditional Access with Risk-Based Policies (Microsoft Entra ID Free Trial)

```bash
# Prerequisites: Microsoft Entra ID P2 trial (required for Identity Protection risk policies)
# Sign up at https://entra.microsoft.com

# Step 1: Enable Identity Protection
# Portal: Entra ID → Security → Identity Protection → User Risk Policy

# Step 2: Create a Named Location (trusted office IP)
# Portal: Entra ID → Security → Conditional Access → Named Locations → + IP Ranges

# Step 3: Create a Conditional Access Policy
# Conditions: Sign-in risk = Medium or High
# Grant: Require MFA
# Session: Sign-in frequency = Every time (for high risk)
```

### Lab 2: Simulate Risky Sign-In and Observe Response

```powershell
# Install Microsoft Graph PowerShell
Install-Module Microsoft.Graph -Scope CurrentUser

# Connect with Identity Protection permissions
Connect-MgGraph -Scopes "IdentityRiskEvent.Read.All","IdentityRiskyUser.Read.All"

# List current risky users
Get-MgRiskyUser | Select-Object UserPrincipalName, RiskLevel, RiskState, RiskLastUpdatedDateTime

# List recent risk detections
Get-MgIdentityProtectionRiskDetection | Select-Object Activity, DetectedDateTime, RiskLevel, RiskEventType | Format-Table
```