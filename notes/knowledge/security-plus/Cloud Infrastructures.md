# Cloud Infrastructures

## What it is

In Gran Turismo, you don't own the cars. You unlock access to a Ferrari F40, a Nissan Skyline GT-R, and a Mazda 787B from Polyphony's massive garage — you tune them, race them, and when you're done you go pick a different one. You never bought the engine, never paid for the warehouse, never changed the oil. That's exactly what **cloud infrastructure** does — you rent computing resources from a provider's pool instead of buying and maintaining the physical hardware yourself.

**Cloud infrastructure** is the on-demand delivery of computing resources — servers, storage, networking, and platforms — over the internet from a provider that owns and maintains the underlying physical hardware, billed by consumption.

## Why it matters

Misconfigured cloud is now the dominant cause of mass data breaches — exposed S3 buckets, public databases, leaked API keys, IAM roles handed to anyone wearing a hat. The [[Shared Responsibility Model]] is where candidates fail: CompTIA loves to ask who patches the guest OS in IaaS versus PaaS, and the answer changes every time. Objective 3.1 specifically expects you to know **cloud deployment models**, **service models**, **responsibility matrix**, **hybrid considerations**, and **third-party vendors**. The classic exam trap: assuming the cloud provider secures your data — they secure the *facility*; you secure the *configuration*.

## Key facts

### Service Models — what you rent vs. what you manage

| Model | You get | You manage | Provider manages | Example |
|---|---|---|---|---|
| **[[IaaS]]** (Infrastructure as a Service) | Virtual machines, storage, networking | OS, runtime, apps, data | Hypervisor, hardware, facility | AWS EC2, Azure VMs |
| **[[PaaS]]** (Platform as a Service) | Pre-built runtime + DB | Apps, data | OS, runtime, infra | Azure App Service, Heroku |
| **[[SaaS]]** (Software as a Service) | Finished application | User access, data input | Everything else | Microsoft 365, Salesforce |
| **[[FaaS]]** / Serverless | Function execution | Code only | All infrastructure | AWS Lambda, Azure Functions |

Mnemonic: the more "aaS" you buy, the less you maintain — and the less you control.

### Deployment Models

- **[[Public Cloud]]** — Multi-tenant. AWS, Azure, GCP. Cheap, scalable, shared underlying hardware. Concern: [[VM Escape]], noisy neighbors, data residency.
- **[[Private Cloud]]** — Single-tenant. On-prem or hosted. Maximum control, maximum cost.
- **[[Hybrid Cloud]]** — Public + private connected. Sensitive workloads stay private, burst capacity goes public. Watch the [[VPN]] / [[ExpressRoute]] / [[Direct Connect]] link.
- **[[Community Cloud]]** — Shared by orgs with common requirements (gov agencies, healthcare consortiums).
- **[[Multi-Cloud]]** — Multiple providers simultaneously. Avoids vendor lock-in, multiplies attack surface.

### Shared Responsibility Model — the exam's favorite ambush

| Layer | IaaS | PaaS | SaaS |
|---|---|---|---|
| Data & access | **Customer** | **Customer** | **Customer** |
| Application | **Customer** | **Customer** | Provider |
| OS / Runtime | **Customer** | Provider | Provider |
| Hypervisor / Network | Provider | Provider | Provider |
| Physical | Provider | Provider | Provider |

The customer **always** owns identity, access, and data classification. Always.

### Cloud-specific concerns from Objective 3.1

- **[[Third-party Vendors]]** — Supply chain risk, [[SLA]] enforcement, [[SOC 2]] reports.
- **[[Cloud-native Controls]]** — [[Security Groups]], [[NACLs]], [[CSPM]] (Cloud Security Posture Management), [[CASB]] (Cloud Access Security Broker).
- **[[Resource Policies]]** — IAM roles, bucket policies, key policies. Misconfiguration = breach.
- **[[Availability Zones]] / [[Regions]]** — Geographic redundancy and data sovereignty.
- **[[Cloud Workload Protection Platform]] (CWPP)** — Runtime protection for VMs, containers, serverless.

### Common attacks on cloud infrastructure

- **Misconfigured storage** — Public S3 buckets, open Azure blobs.
- **Credential leakage** — API keys committed to GitHub. Hello, cryptominer.
- **[[Account Hijacking]]** — Phished console credentials, no [[MFA]].
- **[[VM Escape]]** — Breaking out of guest into hypervisor (rare, devastating).
- **[[Side-channel Attacks]]** — Spectre/Meltdown class, exploiting shared CPU.
- **Resource exhaustion / cryptojacking** — Stolen credentials spinning up GPU instances on your card.

### Defenses

- Enforce [[MFA]] on all console + root accounts.
- [[Least Privilege]] IAM, no wildcard policies.
- [[Encryption]] at rest (KMS-managed keys) and in transit (TLS 1.3).
- [[CSPM]] for continuous misconfiguration scanning.
- [[CloudTrail]] / [[Azure Monitor]] logging into a [[SIEM]].
- Tag everything. Untagged resources are how shadow IT becomes a breach.

## Related concepts

[[Shared Responsibility Model]] · [[Virtualization]] · [[Containerization]] · [[Serverless]] · [[CASB]] · [[CSPM]] · [[Zero Trust]] · [[SASE]] · [[Edge Computing]] · [[Microservices]]

---
*Source: VIRGIL knowledge base — 2026-05-08*