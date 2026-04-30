---
domain: "1.0 - General Security Concepts"
section: "1.2"
tags: [security-plus, sy0-701, domain-1, aaa-framework, authentication, authorization, accounting]
---

# 1.2 - Authentication, Authorization, and Accounting

## Summary

The [[AAA Framework]] (Authentication, Authorization, and Accounting) is the foundational security model that controls who can access systems, what they can do, and how those actions are tracked. This section covers the three distinct phases of user and device access control, along with practical implementation strategies like [[Certificate Authentication]] and authorization models. Understanding AAA is critical for the Security+ exam because it directly supports the [[CIA Triad]] and forms the basis of all access control policies in modern security infrastructures.

---

## Key Concepts

### AAA Framework Components

- **Identification**: The claim of identity (typically a username or device identifier)
  - What you *claim* to be—not yet verified
  - First step in the AAA process
  - Example: typing "[YOUR-USERNAME]@cocytus.local" at login

- **Authentication**: Proof of identity using one or more factors
  - Validates that you are actually who you claim to be
  - Methods: passwords, [[MFA]], [[PKI]]/certificates, biometrics, hardware tokens
  - Establishes trust in the identity before granting access

- **Authorization**: Access rights determined by authenticated identity
  - Answers the question: "What resources can this user/device access?"
  - Based on roles, organizational membership, attributes, or policies
  - Separate concept from authentication—you can authenticate without having authorization

- **Accounting**: Logging and tracking of resource usage
  - Captures: login times, logout times, data transferred, actions performed
  - Enables audit trails and compliance reporting
  - Critical for [[Incident Response]] and forensic investigation

### Authenticating Systems (Device Authentication)

- **The Challenge**: Systems and devices cannot type passwords interactively
  - Automated systems require non-interactive authentication mechanisms
  - Manual password storage on devices introduces security risks

- **Certificate-Based Authentication**:
  - Organization maintains a trusted [[Certificate Authority]] (CA)
  - CA creates and digitally signs certificates for authorized devices
  - Digital signature proves certificate validity and device authorization
  - Certificates serve as an authentication factor included on the device
  - Example: [[TLS]] certificates for server authentication, client certificates for device access

### Authorization Models

- **Direct (No Model)**: User → Resource mapping
  - Simplistic but doesn't scale
  - Difficult to audit and maintain
  - Impossible to understand authorization relationships at scale

- **Model-Based Approach**: User → (Role/Attribute/Organization) → Resource
  - Introduces abstraction layer between identity and access
  - Scales to thousands of users and resources
  - Makes administration streamlined and auditable
  - Creates clear relationship mapping: why does a user have access?

- **Common Authorization Models**:
  - **Role-Based Access Control (RBAC)**: Access based on assigned roles (e.g., "Database Admin")
  - **Attribute-Based Access Control (ABAC)**: Access based on attributes (user department, resource classification, time of day, etc.)
  - **Organization-Based**: Access determined by organizational structure (department, team, location)

---

## How It Works (Feynman Analogy)

**The Concert Venue Analogy:**

Imagine you're attending a concert venue with three distinct security checkpoints:

1. **Identification** (at the gate): "Who are you?" You show your driver's license with your name. You're claiming to be "John Smith."

2. **Authentication** (ticket verification): The gate attendant calls the ticket company to verify that John Smith actually purchased a ticket. You've now *proven* you're really John Smith. They hand you a wristband (your "certificate of authentication").

3. **Authorization** (access control): Your wristband color determines where you can go:
   - **Red wristband** = Main floor access
   - **Blue wristband** = VIP lounge access
   - **Green wristband** = Backstage access

4. **Accounting** (the log): Security logs when you entered (3:45 PM), how long you stayed, what areas you visited, and when you left (11:30 PM).

**In Technical Reality:**

- **User identification** = username at login prompt
- **Authentication** = password verification + [[MFA]] factors (you prove identity)
- **Authorization** = [[Active Directory]] groups determine access to file shares, applications, and VPNs
- **Accounting** = [[Wazuh]] and [[SIEM]] systems log all login attempts, resource access, and data transfers for audit trails

---

## Exam Tips

- **Distinguish "Authentication" from "Authorization"**: The exam loves asking questions that blur these lines. Authentication = "Are you who you say?" Authorization = "What can you access?" A user can be authenticated but have zero authorization.

- **Certificate authentication for devices**: When the question asks "How do we authenticate a system that can't enter a password?", the answer is almost always **digital certificates signed by a trusted CA**. This is tested frequently.

- **Authorization models scale**: Understand why direct user-to-resource mapping fails at scale. The exam tests whether you know that authorization models (RBAC, ABAC) are necessary for large deployments.

- **AAA is sequential**: The exam may ask scenario questions implying that you must authenticate *before* you can authorize. You cannot grant access to someone you haven't verified.

- **Accounting ≠ Authorization**: Don't confuse accounting (tracking resource use) with authorization (granting access). Accounting happens *after* both authentication and authorization are complete.

---

## Common Mistakes

- **Confusing Authentication with Authorization**: Students often use these terms interchangeably. Remember: Authentication = *Who you are*. Authorization = *What you can do*.

- **Assuming passwords work for device authentication**: A common wrong answer on exams. Many candidates forget that [[Certificate Authentication]] (not passwords) is the standard for authenticating systems, IoT devices, and servers that operate without human interaction.

- **Overlooking authorization models in scalability questions**: When the exam asks "How do we manage access for 10,000 users and 5,000 resources?", the wrong answer is "direct user-to-resource mapping." The right answer is "authorization model (like RBAC or ABAC)." Direct mapping is only viable for very small deployments.

---

## Real-World Application

In your [[[YOUR-LAB]]] homelab, the AAA framework operates across multiple layers:

- **Authentication**: [[Active Directory]] validates user credentials; [[TLS]] certificates authenticate the [YOUR-LAB] server nodes to the Tailscale mesh VPN.
- **Authorization**: AD groups determine who can manage [[Wazuh]] dashboards, access storage volumes, or SSH into hypervisors.
- **Accounting**: [[Wazuh]] and syslog systems track all authentication attempts, privilege escalations, and sensitive data access—critical for compliance audits and post-incident investigation.

For production sysadmin work, understanding AAA prevents the #1 access control disaster: granting excessive permissions because there's no authorization model in place.

---

## Deep Dive: Certificate Authentication in [YOUR-LAB]

Certificate-based authentication is particularly relevant to homelab operators. Instead of storing passwords on devices:

1. [YOUR-LAB]'s Certificate Authority generates a unique certificate for each hypervisor node
2. The certificate is digitally signed with the CA's private key (proof of trust)
3. When a node joins the [[Tailscale]] mesh or authenticates to a centralized service, it presents the certificate
4. Other systems verify the certificate's signature against the CA's public key (no password required)
5. This enables automated, scalable authentication across dozens of devices without a single shared secret

This is how [[Kubernetes]] clusters, container registries, and service meshes authenticate without passwords.

---

## [[Wiki Links]]

- [[AAA Framework]] – Authentication, Authorization, Accounting
- [[Authentication]] – Proving identity
- [[Authorization]] – Granting access rights
- [[Accounting]] – Logging and tracking resource use
- [[Certificate Authentication]] – Using digital certificates as authentication factors
- [[Certificate Authority]] – Trusted entity that signs certificates
- [[PKI]] (Public Key Infrastructure) – Foundation for certificate-based authentication
- [[TLS]] (Transport Layer Security) – Uses certificates for server/client authentication
- [[Active Directory]] – Windows identity and access management system
- [[RBAC]] (Role-Based Access Control) – Authorization model using roles
- [[ABAC]] (Attribute-Based Access Control) – Authorization model using attributes
- [[MFA]] (Multi-Factor Authentication) – Using multiple authentication factors
- [[Digital Signatures]] – Cryptographic proof of certificate validity
- [[CIA Triad]] – Confidentiality, Integrity, Availability (authentication supports all three)
- [[Zero Trust]] – Security model requiring continuous authentication and authorization
- [[SIEM]] – Security Information and Event Management (accounting/logging)
- [[Wazuh]] – your security monitoring and logging platform
- [[Tailscale]] – Mesh VPN used in [YOUR-LAB] with certificate authentication
- [[[YOUR-LAB]]] – your homelab infrastructure
- [[Incident Response]] – Uses accounting logs for investigation
- [[Forensics]] – Relies on accounting audit trails
- [[Audit Trail]] – Records generated by accounting systems
- [[Access Control]] – Broader concept encompassing authentication and authorization
- [[Privilege Escalation]] – Attempting to exceed authorization level
- [[Compliance]] – Regulations requiring proper AAA implementation
- [[NIST]] – Standards for authentication and access control

---

## Tags

`domain-1` `security-plus` `sy0-701` `aaa-framework` `authentication` `authorization` `accounting` `certificate-authentication` `access-control` `device-authentication` `authorization-models` `rbac` `abac`

---

## Study Review Checklist

- [ ] Explain the difference between authentication and authorization in your own words
- [ ] Describe how device authentication (certificates) differs from user authentication (passwords)
- [ ] Explain why direct user-to-resource mapping doesn't scale
- [ ] List 3 examples of authorization models and when to use each
- [ ] Trace through a real login scenario: identification → authentication → authorization → accounting
- [ ] Describe how certificate signing by a CA creates trust
- [ ] Explain how accounting supports [[Incident Response]] investigations

---
_Ingested: 2026-04-15 23:23 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
