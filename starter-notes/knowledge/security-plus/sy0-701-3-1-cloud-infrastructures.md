---
domain: "3.0 - Security Architecture"
section: "3.1"
tags: [security-plus, sy0-701, domain-3, cloud-security, shared-responsibility]
---

# 3.1 - Cloud Infrastructures

Cloud security is fundamentally different from on-premises security because responsibility for protecting systems and data is **shared** between the cloud provider and the customer—and the division of that responsibility varies by service model and provider. Understanding the [[Cloud Responsibility Matrix]] is critical for the Security+ exam because exam questions frequently test your ability to identify *who* is responsible for securing specific components in [[IaaS]], [[PaaS]], and [[SaaS]] environments. This topic also covers the additional complexity introduced by [[Hybrid Cloud]] deployments, where organizations operate across multiple cloud providers or mix public and private clouds, creating authentication, firewall, and monitoring challenges.

---

## Key Concepts

### Cloud Service Models & Responsibility

- **[[IaaS]] (Infrastructure as a Service)**
  - Customer responsible for: Operating system, middleware, application, data, identity/access management
  - Provider responsible for: Physical infrastructure, hypervisor, network, storage hardware
  - Example: [[AWS]] EC2, Azure VMs, Google Compute Engine

- **[[PaaS]] (Platform as a Service)**
  - Customer responsible for: Application, data, identity/access management
  - Provider responsible for: OS, middleware, runtime, infrastructure, networking
  - Example: [[AWS]] Elastic Beanstalk, Azure App Services

- **[[SaaS]] (Software as a Service)**
  - Customer responsible for: Data, user access controls, account management
  - Provider responsible for: Everything else (application, infrastructure, platform, OS, updates, patches)
  - Example: Microsoft 365, Salesforce, Google Workspace

### Cloud Responsibility Matrix

- **Well-documented responsibility allocation** is essential for security posture
  - Should be explicitly stated in Service Level Agreements (SLAs) and contracts
  - Creates clear accountability and prevents security gaps
  - Different providers have different matrices—no universal standard

- **Responsibility can shift based on:**
  - Service model chosen (IaaS vs. PaaS vs. SaaS)
  - Contractual agreements with the provider
  - Additional security services purchased (managed security, compliance modules, etc.)
  - Configuration choices made by the customer

- **Critical principle:** The customer is **always** responsible for their data and how they configure/use the service, even in SaaS models

### Hybrid Cloud Complexity

- **Definition:** Organization operates across multiple cloud environments (two or more public clouds, private cloud + public cloud, on-premises + cloud)
  - Increases security surface area exponentially
  - Requires consistent policies across heterogeneous environments

- **Authentication across platforms**
  - Federated identity management ([[SAML]], [[OAuth]]) becomes mandatory
  - Single sign-on (SSO) must bridge different cloud providers
  - Directory services ([[Active Directory]], [[LDAP]]) must synchronize across clouds

- **Firewall and network protection mismatches**
  - Each cloud provider has different [[Firewall]] implementations and terminology
  - Security groups in [[AWS]] ≠ Network Security Groups in Azure
  - Hybrid deployments may have gaps where traffic crosses provider boundaries
  - VPN or [[Zero Trust]] access controls become critical

- **Data leakage risks**
  - Data traveling between public clouds crosses the public Internet
  - Requires strong encryption in transit ([[TLS]], [[IPSec]])
  - Multiple data sovereignty and compliance considerations

### Security Monitoring Challenges in Hybrid

- **Log diversity and fragmentation**
  - Each cloud provider generates logs in different formats and structures
  - On-premises systems have different logging standards than cloud services
  - Centralized log collection and analysis becomes complex
  - [[SIEM]] solutions (like [[Wazuh]]) must aggregate and correlate logs from heterogeneous sources

- **Visibility gaps**
  - Cloud provider logs may not expose network-layer details
  - On-premises monitoring tools may not have visibility into cloud traffic
  - Requires cloud-native monitoring tools in addition to traditional tools

---

## How It Works (Feynman Analogy)

**Simple Analogy: Apartment Building vs. Your Apartment**

Imagine you rent an apartment in a large building (the cloud). The building owner (cloud provider) is responsible for maintaining the structure, roof, foundation, lobby, and hallways. *You* are responsible for what happens inside your apartment: your locks, your furniture, your safety, your guests.

- In a **SaaS building**, the landlord even furnishes and maintains your apartment; you just decide who gets to visit and what you store inside.
- In a **PaaS building**, the landlord provides the walls and utilities; you furnish and maintain your space.
- In an **IaaS building**, the landlord provides the walls and structure; you build everything else (utilities, furniture, paint, security system).

Now imagine your apartment is in a **hybrid setup**: part of it is in Building A (AWS), part in Building B (Azure), and you still own a house next door (on-premises). Now you have to coordinate:
- Different lock systems and security protocols
- Different fire alarm systems
- Coordinating which utilities work across buildings
- Making sure your mailman (data) can reach all three places reliably

**Technical Reality:**

The [[Cloud Responsibility Matrix]] codifies this division. You must know: for the service you're using, what does the provider guarantee, and what must *you* secure? In hybrid clouds, this gets exponentially harder because you're managing multiple responsibility matrices simultaneously, and data traversing between them is vulnerable.

---

## Exam Tips

- **Know the responsibility matrix cold for each service model.** The exam frequently presents a scenario like: "You're using AWS EC2 (IaaS). Your database is compromised. Who is responsible for patching the OS?" Answer: **You are**—IaaS means you manage the OS.

- **Watch for [[SaaS]] trick questions.** Candidates often think the provider handles everything in SaaS, but **you are always responsible for your data and user access controls.** Example: "Your Microsoft 365 tenant was compromised. Is this Microsoft's fault?" Answer: Depends—if you had weak password policies or no [[MFA]], that's your responsibility.

- **Hybrid cloud questions test your understanding of aggregation and visibility.** When asked about monitoring a hybrid environment, the correct answer almost always involves centralized [[SIEM]], standardized log formats, or cloud-native monitoring tools alongside traditional monitoring.

- **Responsibility matrix questions often include contractual language.** The key distinction: **What does the provider *contractually guarantee* to do vs. what you must configure yourself?** Review the SLA and responsibility matrix in the question.

- **Data in transit in hybrid clouds = encryption requirement.** If data crosses public Internet between cloud providers, expect the answer to involve [[TLS]], [[IPSec]], or [[VPN]] tunnels. This is a high-yield topic.

---

## Common Mistakes

- **Assuming the cloud provider secures everything.** Even in SaaS, the customer controls data and user access. Weak passwords or oversharing in Salesforce is the customer's fault, not the provider's.

- **Confusing responsibility shifts between service models.** A candidate might correctly identify IaaS responsibilities but then apply the same level to a PaaS service. Test yourself: IaaS = more your responsibility; SaaS = less your responsibility.

- **Overlooking hybrid complexity in monitoring.** Candidates often assume their existing SIEM or firewall will handle hybrid clouds seamlessly. In reality, you need to explicitly handle log aggregation, format translation, and cross-cloud correlation—these don't happen automatically.

---

## Real-World Application

In Morpheus's [[[YOUR-LAB]]] fleet homelab, if you were to extend beyond on-premises into a hybrid model (e.g., running some workloads on [[AWS]] while maintaining local Proxmox clusters), you'd immediately face these challenges:

- Your local [[Active Directory]] domain wouldn't automatically trust cloud workloads; you'd need [[SAML]] or [[OAuth]] federation
- Your local [[Wazuh]] agent deployment works differently in cloud environments; cloud providers provide their own logging
- Your [[Tailscale]] mesh network would bridge on-premises and cloud, but firewall rules differ between your local iptables setup and cloud security groups
- Data replication between on-premises storage and cloud storage must be encrypted in transit and comply with responsibility matrices from both sides

For a real sysadmin deploying hybrid, this means: **document responsibilities explicitly, centralize logging immediately, and test failover/connectivity across cloud boundaries before production traffic depends on it.**

---

## [[Wiki Links]]

- [[CIA Triad]]
- [[Cloud Responsibility Matrix]]
- [[IaaS]] (Infrastructure as a Service)
- [[PaaS]] (Platform as a Service)
- [[SaaS]] (Software as a Service)
- [[Hybrid Cloud]]
- [[AWS]] (Amazon Web Services)
- [[Azure]] (Microsoft Azure)
- [[Google Cloud Platform]]
- [[SAML]] (Security Assertion Markup Language)
- [[OAuth]]
- [[Zero Trust]]
- [[Active Directory]]
- [[LDAP]] (Lightweight Directory Access Protocol)
- [[Firewall]]
- [[VPN]] (Virtual Private Network)
- [[IPSec]]
- [[TLS]] (Transport Layer Security)
- [[SIEM]] (Security Information and Event Management)
- [[Wazuh]]
- [[Tailscale]]
- [[MFA]] (Multi-Factor Authentication)
- [[SLA]] (Service Level Agreement)
- [[Encryption]]
- [[Incident Response]]
- [[NIST]] (National Institute of Standards and Technology)
- [[Proxmox]]
- [[Security Monitoring]]
- [[Data Leakage]]
- [[Compliance]]

---

## Tags

`domain-3` `security-plus` `sy0-701` `cloud-security` `shared-responsibility` `hybrid-cloud` `responsibility-matrix` `cloud-service-models` `siem-hybrid` `data-in-transit`

---
_Ingested: 2026-04-15 23:51 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
