# Infrastructure Models & Compute

## What it is

In **Call of Duty: Warzone**, the same map runs three different game modes simultaneously across the server fleet — Battle Royale on one playlist, Resurgence on another, Plunder on a third. Same Verdansk geometry, same engine, same anti-cheat, but the rules engine on top decides what spawns, what respawns, what persists. The map didn't change. The compute model on top of it did.

That's exactly what infrastructure models do — the workload doesn't care whether it runs on a bare-metal server, a VM, a container, or a Lambda function, but the security boundary, the visibility you get, and the attack surface change dramatically depending on which model you picked.

Technical definition: **infrastructure models** describe how compute, storage, and network are provisioned and isolated. The CS0-003 set covers **on-premises**, **cloud**, **hybrid**, **virtualization**, **containerization**, and **serverless** — each with a different trust boundary, a different telemetry surface, and a different way to fail.

## Why it matters

Every detection you write, every log source you onboard, every IR playbook you draft assumes a compute model. A playbook that says "isolate the host" works on a VM. It does not work on a Lambda function that fired, ran for 800ms, and died before your SIEM rule even correlated. If you don't know which model the workload lives in, you don't know what evidence exists, where to grab it, or whether "containment" is even a verb that applies.

**Exam relevance:** Objective 1.1 calls out **virtualization, containerization, serverless, on-prem, cloud, hybrid, network segmentation, zero trust, SASE, SDN, IAC** as infrastructure concepts you must distinguish. CompTIA loves to ask "which compute model best fits this scenario" and "which control applies to which model." Conflate containers with VMs on the exam and you lose the question.

## Key facts

### The deployment spectrum

| Model | What runs | Trust boundary | Who patches the OS |
|---|---|---|---|
| **On-premises** | Your hardware, your DC | Physical perimeter + your network | You |
| **Cloud (IaaS)** | VMs in someone else's DC | Hypervisor + VPC | You (guest OS) |
| **Cloud (PaaS)** | Your code on their runtime | Runtime sandbox | Provider |
| **Cloud (SaaS)** | Their app, your data | API + identity | Provider (entirely) |
| **Hybrid** | Mix of on-prem + cloud, linked | Both — and the link between them | Both |

The **shared responsibility model** is the cloud version of "who calls the wipe." IaaS: you own the guest OS, network ACLs, app, data. PaaS: you own the app and data. SaaS: you own the data and identity, that's it. Misread the line and you'll leave an S3 bucket public thinking AWS handles it.

### Virtualization

A **hypervisor** (Type 1: bare-metal like ESXi, Hyper-V; Type 2: hosted like VMware Workstation) carves one physical host into multiple **VMs** with isolated kernels, virtual NICs, and virtual disks.

- **Wins:** strong isolation, snapshot/rollback for forensics, [[live migration]], easy [[network segmentation]] via vSwitch
- **Risks:** **VM escape** (guest breaks the hypervisor — rare but catastrophic), **VM sprawl** (unmanaged VMs become shadow IT), **resource contention** side channels (Spectre/Meltdown-class)
- **SOC angle:** snapshot a compromised VM before you nuke it. The snapshot is your forensic image and your evidence.

### Containerization

A container shares the **host OS kernel** but isolates filesystem, processes, and network via namespaces and cgroups. Docker, containerd, runc at the runtime layer; Kubernetes at the orchestration layer.

- **Wins:** lightweight (MB not GB), starts in seconds, immutable images, portable across clouds
- **Risks:** **container breakout** (one kernel — break it once, own the host), **image supply chain** (pulled `nginx:latest` from an unverified registry, now you have a cryptominer), **over-permissioned service accounts** in K8s, exposed kubelet/dashboard
- **Security lives in:** image scanning (Trivy, Clair), runtime defense (Falco), admission controllers, [[network segmentation]] via service mesh, least-privilege RBAC

> **CompTIA exam trap:** Containers are **NOT** lightweight VMs. They share the kernel. If the kernel is compromised, every container on that host is compromised. VMs have separate kernels — different blast radius entirely. CompTIA will offer "lightweight VM" as a tempting wrong answer.

### Serverless

Code runs as **functions** (AWS Lambda, Azure Functions, GCP Cloud Functions). You upload the function, the provider runs it on demand, scales it, kills it. You don't see the server. You don't get to log into the server. There is no server you're allowed to think about.

- **Wins:** zero infrastructure ops, pay-per-invocation, scales to zero
- **Risks:** **event injection** (the trigger is the attack vector — malicious S3 upload triggers your function), **over-permissioned IAM roles** (the function can do anything the role allows, which is usually too much), **cold-start visibility gaps**, **dependency hell** in the deployment package, **denial-of-wallet** (attacker triggers your function a million times, you get the bill)
- **You secure:** identity (IAM role minimization), code (SCA on dependencies), data (encryption at rest/transit). Not servers — there aren't any you can reach.

> **CompTIA exam trap:** Serverless functions don't have persistent disk. There's no host to image, no /var/log to grep. Your only forensic surface is **CloudTrail, CloudWatch Logs, and the function's invocation history**. If logging wasn't on before the incident, the evidence is gone.

### On-premises vs cloud vs hybrid

**On-prem:** maximum control, maximum operational burden. You patch the firmware. You replace the failed drive. You own physical security.

**Cloud:** elastic, API-driven, opex not capex. Misconfiguration is the #1 cloud breach cause — public buckets, open security groups, hardcoded keys in git.

**Hybrid:** the interesting one. You're running on-prem AD federated to Azure AD, on-prem databases replicated to RDS, VPN/Direct Connect/ExpressRoute linking the two. The **link** is the attack path. A foothold in cloud can pivot to on-prem; a foothold on-prem can pivot to cloud via stolen tokens.

### Adjacent concepts the objective bundles in

- **[[Network segmentation]]:** divide the network so a breach in one zone doesn't pop the others. VLANs, subnets, microsegmentation (per-workload), Kubernetes NetworkPolicies. In a flat network, one compromised host = the whole game.
- **[[Zero trust]]:** "never trust, always verify." No implicit trust from network location. Every request is authenticated, authorized, encrypted. Identity is the new perimeter. Pillars: identity, device, network, application, data.
- **[[SASE]] — Secure Access Service Edge:** cloud-delivered network + security stack (SD-WAN + SWG + CASB + ZTNA + FWaaS) bundled. Branch office talks to SASE PoP, not back to HQ.
- **[[SDN]] — Software-Defined Networking:** control plane separated from data plane. Network policy is code, pushed via API. Lets you do microsegmentation at scale.
- **IAC — Infrastructure as Code:** Terraform, CloudFormation, Pulumi. Infrastructure defined in version-controlled files. Security wins: drift detection, peer review, repeatable hardening. Security loss: a bad commit deploys at scale in seconds.

### What changes for the SOC across models

| Concern | On-prem VM | Container | Serverless |
|---|---|---|---|
| Log source | Syslog, Windows Event | stdout/stderr, K8s audit log | CloudTrail, CloudWatch |
| Forensic image | Yes (disk + memory) | Ephemeral — snapshot the image | No host — only invocation logs |
| Isolation method | Network ACL / power off | Cordon node, kill pod | Disable function, revoke IAM role |
| Patching | Your job | Rebuild image | Provider's job |
| Persistence by attacker | Disk, registry, scheduled task | Image, ConfigMap, sidecar | IAM backdoor, trigger config |

### CompTIA exam traps

> **Trap — virtualization vs containerization:** VM = own kernel, hypervisor isolation, heavy. Container = shared kernel, namespace isolation, light. CompTIA will test the kernel question directly.

> **Trap — serverless responsibility:** The provider manages the runtime, OS, and hardware. You manage **code, configuration, identity, and data**. "Patching the function's OS" is not your job and not a valid answer.

> **Trap — hybrid attack path:** A scenario describes a breach in the on-prem environment that then accesses cloud resources. The answer involves **identity federation** and **token theft**, not "the firewall failed." Hybrid breaches almost always pivot via identity.

> **Trap — zero trust vs network segmentation:** Segmentation is a control (divide the network). Zero trust is an architecture (assume breach, verify every request). Zero trust *uses* segmentation; it isn't segmentation.

## SOC reality

- The Lambda function alert fires at 3:14am: "function `invoice-processor` invoked 14,000 times in 90 seconds." Your first move isn't "isolate the host" — there is no host. You disable the function trigger and revoke the IAM role. Then you pull CloudTrail to see what the role *did* with its 14,000 invocations.

- The K8s alert fires: "pod `web-frontend-7d9` spawning shell." You don't reimage the host — you **cordon the node**, kill the pod, and pull the image hash. Then you check every other cluster running the same image. *I learned this the hard way: killing the pod without checking the image meant the replacement pod, which K8s helpfully spun up from the same compromised image, was popped within 40 seconds.*

- The CISO asks three questions on every cloud incident: "What identity was used? What did it access? Is the blast radius contained to this account?" If you don't know the IAM role and the assumed-role chain, you can't answer any of them.

- Never tell leadership "the cloud provider handles that" without checking the shared responsibility matrix for the specific service. PaaS for one service ≠ PaaS for the next. Misreading the line is how organizations end up explaining a 40-million-record S3 breach.

- Escalation: L1 acknowledges and pulls the immediate logs (CloudTrail, K8s audit, hypervisor logs). L2 scopes the blast radius — which workloads share the trust boundary. IR lead decides containment (kill the function, cordon the namespace, isolate the VM). Cloud security engineer handles IAM forensics. Legal gets called when CHD or PII is in scope.

## Related concepts

[[Network segmentation]] · [[Zero trust]] · [[SASE]] · [[SDN]] · [[CASB]] · [[Cloud shared responsibility model]] · [[Identity and access management]] · [[Hypervisor]] · [[Kubernetes security]] · [[Container image scanning]] · [[IAM role minimization]] · [[CloudTrail]] · [[Infrastructure as Code]] · [[System hardening]] · [[Log ingestion]]

*Source: VIRGIL knowledge base — 2026-05-11*