# Other Infrastructure Concepts

## What it is

In Grand Theft Auto V, you can switch between Michael, Franklin, and Trevor — three protagonists with different strengths, deployed for different heists. Sometimes Michael's stealth fits, sometimes Trevor's chaos is the right tool, and sometimes you call Lester to plan the whole operation from a safehouse you don't physically own. That's exactly what **Other Infrastructure Concepts** are — the architectural choices about *where* compute lives, *who* maintains it, and *how* services are stitched together.

A grouping of architecture decisions in SY0-701 covering **IaC, serverless, microservices, virtualization, containerization, high availability, and on-premises vs. cloud** — the deployment and design patterns that shape modern infrastructure security.

## Why it matters

Pick the wrong model and your attack surface mutates: a misconfigured S3 bucket leaks PII, a poisoned container image owns your cluster, a flat virtualization host lets one tenant escape into another's memory. Objective 3.1 explicitly demands you compare **centralized vs. decentralized**, **on-premises vs. cloud**, **virtualization vs. containerization**, and recognize **IaC** and **serverless** trade-offs. CompTIA's favorite trap: confusing *containerization* (shared kernel, isolated userspace) with *virtualization* (separate kernels, hypervisor-mediated) — they will absolutely give you a scenario and ask which provides stronger isolation. Spoiler: virtualization does, containers are lighter.

## Key facts

### Deployment models

| Model | Control | Cost pattern | Security responsibility |
|---|---|---|---|
| **[[On-premises]]** | Full | CapEx, slow scaling | You own everything |
| **[[Cloud]]** | Shared | OpEx, elastic | [[Shared responsibility model]] |
| **[[Hybrid cloud]]** | Mixed | Mixed | Both, with integration risk |
| **[[Centralized]]** | One control plane | Efficient | Single point of failure |
| **[[Decentralized]]** | Distributed | Resilient | Inconsistent policy enforcement |

### Virtualization vs. Containerization

- **[[Virtualization]]**: A [[hypervisor]] (Type 1 bare-metal like ESXi, Type 2 hosted like VirtualBox) runs full guest OSes. Strong isolation. Threats: **[[VM escape]]**, **[[VM sprawl]]**, **[[hypervisor]] compromise**.
- **[[Containerization]]**: Docker, Kubernetes, containerd. Shares the host kernel; isolates via namespaces and cgroups. Lightweight, fast, but a kernel bug = game over. Threats: **poisoned images**, **[[container escape]]**, secrets baked into layers.

### Serverless and microservices

- **[[Serverless]]** (AWS Lambda, Azure Functions): You hand over code; the provider handles runtime, patching, scaling. You lose visibility, gain speed. Risks: **cold-start info leaks**, **over-permissioned execution roles**, **dependency poisoning**.
- **[[Microservices]]**: Decompose monoliths into small, independently deployable services communicating via APIs. Blast radius shrinks per service; **[[API security]]** explodes in importance. Each service = each [[attack surface]].

### Infrastructure as Code (IaC)

- **[[Infrastructure as Code]]** (Terraform, CloudFormation, Ansible, Pulumi): Infrastructure defined in version-controlled text files, deployed automatically.
- Wins: repeatability, drift detection, audit trail, rapid rebuild after compromise.
- Risks: **secrets in repos**, **misconfigured templates replicated at scale**, **supply chain compromise of modules**. One bad Terraform module can vend a thousand wide-open buckets.

### High availability and resilience

- **[[High availability]]**: clustering, load balancing, **[[failover]]**, geographic redundancy.
- Measured in **nines**: 99.9% (~8.7 hrs downtime/year), 99.99% (~52 min), 99.999% (~5 min).
- Related: **[[RTO]]** (recovery time objective), **[[RPO]]** (recovery point objective).

### IoT, ICS/SCADA, embedded, RTOS

- **[[IoT]]**: cheap, rarely patched, default credentials. Mirai botnet's playground.
- **[[ICS]]/[[SCADA]]**: industrial controls — air-gapped in theory, IP-connected in practice. Stuxnet's old neighborhood.
- **[[Embedded systems]]** and **[[RTOS]]** (real-time operating systems): firmware-level constraints, limited update mechanisms, long lifecycles.

### Exam traps

- **Containers ≠ VMs.** Different isolation, different threat models.
- **Serverless still has security responsibilities** — IAM, code, dependencies are yours.
- **IaC is a control AND a risk** — depends entirely on review and secret hygiene.
- **Cloud responsibility shifts by service tier**: IaaS (you do most), PaaS (split), SaaS (provider does most, you still own data and identity).

## Related concepts

[[Shared responsibility model]] · [[Hypervisor]] · [[Container escape]] · [[Infrastructure as Code]] · [[Serverless]] · [[Microservices]] · [[High availability]] · [[SCADA]] · [[API security]] · [[Attack surface]]

---
*Source: VIRGIL knowledge base — 2026-05-08*