---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 058
source: rewritten
---

# Cloud Infrastructures
**Understanding who owns security responsibility in the cloud depends entirely on your service model.**

---

## Overview
Modern organizations operate workloads across multiple cloud deployment models—whether [[Infrastructure as a Service (IaaS)]], [[Platform as a Service (PaaS)]], [[Software as a Service (SaaS)]], or on-premises systems. The critical security question isn't *what* needs protecting, but *who* protects it. For Security+ exam success, you must understand the [[Shared Responsibility Model]], which clearly delineates security ownership between cloud providers and customers across different service architectures.

---

## Key Concepts

### Shared Responsibility Model
**Analogy**: Imagine renting an apartment building. The landlord secures the building's exterior and foundation, but you lock your apartment door and windows. Neither party is fully responsible alone—it's divided based on logical ownership.

**Definition**: A framework where [[cloud service providers]] and customers split security obligations based on the service tier purchased. The higher up the stack you go (toward SaaS), the more the provider manages.

[[Responsibility Matrix]] | [[Cloud Security Governance]]

| Component | On-Premises | IaaS | PaaS | SaaS |
|-----------|-------------|------|------|------|
| Applications | Customer | Customer | Customer | Provider |
| Data | Customer | Customer | Customer | Customer* |
| Runtime | Customer | Customer | Provider | Provider |
| Operating System | Customer | Customer | Provider | Provider |
| Virtualization | Customer | Provider | Provider | Provider |
| Physical Infrastructure | Customer | Provider | Provider | Provider |
| Physical Security | Customer | Provider | Provider | Provider |

*Customer responsible for data classification and access controls, but provider manages storage/encryption infrastructure.

### Infrastructure as a Service (IaaS)
**Analogy**: Like leasing a bare plot of land—the landlord provides the dirt and boundaries, but you build and maintain everything on top.

**Definition**: Cloud provider manages physical servers, networking, virtualization, and storage infrastructure. Customer manages everything from the [[operating system]] upward: OS patching, applications, middleware, runtime environments, and all data.

[[Public Cloud Providers]] | [[Hypervisor]] | [[Virtual Machines]]

### Platform as a Service (PaaS)
**Analogy**: Like renting a fully furnished apartment with utilities included—you just move in furniture (your code) and live there (deploy apps).

**Definition**: Provider handles infrastructure *plus* [[operating systems]], [[middleware]], [[runtimes]], and development tools. Customer only manages applications and data. Ideal for developers who want to focus on code without infrastructure overhead.

[[Development Lifecycle]] | [[Application Security]]

### Software as a Service (SaaS)
**Analogy**: Like staying in a hotel—everything is provided and maintained. You just use the room; the hotel handles cleaning, repairs, utilities, and security.

**Definition**: Provider manages the entire technology stack including applications, data storage, security patches, and uptime. Customer controls only user access and data classification. Examples: Microsoft 365, Salesforce, Google Workspace.

[[Access Control]] | [[Multi-factor Authentication]]

### Customer-Managed Responsibilities
**Analogy**: Your keys work in your lock regardless of who owns the building—you're always responsible for access control.

**Definition**: Regardless of service model, customers always retain responsibility for:
- [[Data Classification]] and sensitivity labeling
- [[Identity and Access Management (IAM)]] policies
- User authentication credentials
- [[Encryption]] key management (in most cases)
- [[Audit Logging]] and compliance documentation
- Security awareness training for staff

[[Data Governance]] | [[Zero Trust Architecture]]

### Provider-Managed Responsibilities
**Analogy**: The power company generates electricity; you just pay the bill and flip switches. You don't manage their generators.

**Definition**: Cloud providers handle foundational security that varies by service level:
- **All tiers**: Physical security, facility access controls, [[DDoS]] mitigation, network segmentation
- **PaaS/SaaS**: Patch management, [[vulnerability assessment]], infrastructure hardening
- **SaaS**: Application security testing, [[incident response]], disaster recovery

[[Business Continuity]] | [[Disaster Recovery Planning]]

### Overlap and Shared Responsibilities
**Analogy**: A restaurant kitchen—the health inspector (provider) ensures sanitation standards, but the chef (customer) must follow them daily.

**Definition**: Many security functions require both parties to act:
- **Encryption**: Provider supplies encryption tools; customer must enable and manage keys
- **[[Access Control]]**: Provider builds IAM systems; customer configures policies and enforces MFA
- **[[Patch Management]]**: Provider releases patches; customer must apply them timely
- **[[Monitoring]]**: Provider collects logs; customer must analyze them and respond to alerts

[[Configuration Management]] | [[Security Monitoring]]

---

## Exam Tips

### Question Type 1: Responsibility Assignment
- *"Your organization uses SaaS for email. Who is responsible for patching the email server operating system?"* → **The cloud provider.** In SaaS, the provider owns everything below the application layer.
- *"You're using IaaS and store sensitive customer data. Who is responsible for encryption key management?"* → **Primarily you (customer),** unless your contract specifies otherwise. Keys in your account are your responsibility.
- *"A vulnerability is discovered in the hypervisor of your IaaS provider. Who must remediate it?"* → **The provider.** Hypervisor security is provider-owned across all service models.

**Trick**: Don't assume "cloud provider" handles security by default. The question tests whether you understand *which layer* requires patching. IaaS customers patch their own OS; PaaS customers don't; SaaS customers never patch anything application-related.

### Question Type 2: Shared Responsibility Scenarios
- *"Your SaaS vendor enables encryption at rest. Your data is still compromised. What failed?"* → **Your [[access control]] or [[key management]].** Provider gave you the tool; you didn't lock it down properly.
- *"You receive a compliance audit finding that systems lack [[vulnerability assessment]]. You're using PaaS. Who is responsible?"* → **The provider performs scans,** but you're responsible for remediation of your code/configuration.

**Trick**: Watch for questions that describe *shared* failures. Both parties often have roles in security incidents.

### Question Type 3: Contractual Modifications
- *"Your IaaS contract states the provider will manage your operating system patches. Is this standard?"* → **No.** This is a non-standard amendment favoring the customer. Typical IaaS: customers patch their own OS.
- *"Can a contract shift SaaS security responsibilities to the customer?"* → **Partially.** Provider always manages infrastructure, but contracts might require customers to implement extra [[Multi-factor Authentication|MFA]] or [[encryption]].

**Trick**: The exam tests whether you know default responsibility splits. Modified contracts are mentioned to test if you'll stick to the standard model or recognize exceptions.

---

## Common Mistakes

### Mistake 1: Assuming Cloud = Provider Owns All Security
**Wrong**: "We moved to the cloud, so the provider handles all security."
**Right**: Providers handle *infrastructure* security. You still own application security, data access controls, and user management.
**Impact on Exam**: You'll fail questions assigning customer responsibilities in [[IaaS]] and [[PaaS]] scenarios. Security+ emphasizes shared accountability.

### Mistake 2: Confusing IaaS and PaaS Responsibilities
**Wrong**: "PaaS provider manages the OS, so IaaS provider must also manage it."
**Right**: IaaS provider provides OS but doesn't manage patches/updates. PaaS provider fully manages the OS and runtime.
**Impact on Exam**: Questions testing OS patch responsibility are high-value; mixing these up costs easy points. Know: *IaaS = you patch* | *PaaS = they patch*

### Mistake 3: Thinking Data Responsibility Transfers to Cloud
**Wrong**: "Once data is in the cloud, the provider secures it completely."
**Right**: Provider secures storage infrastructure; you're responsible for [[data classification]], [[encryption key management]], and access policies. You own data even in SaaS.
**Impact on Exam**: Compliance and [[data sovereignty]] questions rely on this. GDPR, HIPAA, and PCI-DSS hold *you* accountable for data protection regardless of cloud use.

### Mistake 4: Overlooking Encryption Key Ownership
**Wrong**: "The cloud provider encrypts data, so they manage encryption keys."
**Right**: Provider-managed encryption is *convenient* but *optional*. In most cloud models, you're responsible for your own encryption keys—provider only manages the mechanism.
**Impact on Exam**: Key management questions distinguish between [[envelope encryption]], [[key escrow]], and customer-managed keys. Missing this nuance costs points on data protection questions.

### Mistake 5: Ignoring Audit and Compliance Gaps in Shared Model
**Wrong**: "Provider compliance certification means our data is compliant."
**Right**: Provider compliance (SOC 2, ISO 27001) covers their infrastructure. Your configuration, access controls, and use of services must also be compliant.
**Impact on Exam**: Scenario questions test whether you'll audit *your own* cloud configuration, not just trust the provider's certification. Security+ emphasizes continuous verification.

---

## Related Topics
- [[Cloud Service Models]]
- [[Identity and Access Management (IAM)]]
- [[Data Classification and Handling]]
- [[Encryption and Key Management]]
- [[Cloud Security Architecture]]
- [[Compliance Frameworks]]
- [[Incident Response in Cloud Environments]]
- [[Audit and Logging]]
- [[Third-party Risk Management]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]] | [[Cloud Computing]]*