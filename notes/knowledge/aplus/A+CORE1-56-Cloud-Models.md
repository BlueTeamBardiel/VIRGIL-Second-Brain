# Cloud Models

## What it is

You already use the cloud. Your Steam library lives on Valve's servers, your save files sync through Steam Cloud, your Discord chat history exists on machines you'll never touch. You don't own any of it — you rent access. When the servers go down, you sit there refreshing.

That's the cloud. Someone else's computer, rented by the hour, accessed over the network, abstracted enough that you don't care which physical box is doing the work.

In technical terms: **cloud computing** is on-demand delivery of compute, storage, and services over a network — pooled across many tenants, metered by usage, scaled elastically. NIST defined it with five essential characteristics: on-demand self-service, broad network access, resource pooling, rapid elasticity, and measured service. CompTIA tests those characteristics directly.

The body metaphor still works: if your gaming PC is a body you own, the cloud is a body you lease — same organs (CPU, RAM, storage, network), but the brain belongs to AWS, Azure, or Google, and you're paying rent on the parts you use.

## Why it matters

Every IT job touches the cloud now. Helpdesk resets Microsoft 365 passwords. Sysadmins manage hybrid Active Directory syncing to Entra ID. Security analysts hunt threats across AWS CloudTrail logs. Even on-prem-only shops use cloud backup targets, cloud-managed Wi-Fi, or cloud-hosted ticketing.

CompTIA 220-1201 Objective 4.2 expects you to distinguish the **deployment models** (private, public, hybrid, community) from the **service models** (IaaS, PaaS, SaaS) from the **characteristics** (elasticity, multitenancy, metered utilization, shared vs dedicated, file sync, availability). They love testing these distinctions because they're easy to mix up and easy to write multiple-choice traps around.

If you can't fluently answer "is Microsoft 365 IaaS, PaaS, or SaaS?" in a job interview, you'll be screened out before the technical round.

## In your build, in the enterprise

### Beat 1 — the technical breakdown

**Service models** stack from least managed to most managed:

- **IaaS (Infrastructure as a Service)** — you rent virtual hardware. CPU, RAM, storage, network. You install the OS, patch it, configure everything above. AWS EC2, Azure VMs, Google Compute Engine. You're a sysadmin with a credit card instead of a server room.
- **PaaS (Platform as a Service)** — you rent a runtime. The provider manages the OS, the database engine, the web server. You upload code. Azure App Service, AWS Elastic Beanstalk, Heroku. Developers love it; sysadmins lose visibility.
- **SaaS (Software as a Service)** — you rent the finished application. Microsoft 365, Salesforce, Gmail, Dropbox. You log in. That's the whole job.

**Deployment models** describe who shares the underlying iron:

- **Public cloud** — anyone with a credit card. AWS, Azure, GCP. Multitenant — your VM lives on a host running other customers' VMs too. Shared resources, isolated logically.
- **Private cloud** — infrastructure dedicated to one organization. Could be on-prem (VMware vSphere in your own data center) or hosted by a provider on dedicated hardware. Expensive, but the resources are yours.
- **Hybrid cloud** — both, stitched together. On-prem Active Directory syncs to Azure AD. Production runs in your data center, burst capacity spills to AWS.
- **Community cloud** — shared infrastructure for organizations with common requirements. Government agencies sharing a FedRAMP environment, hospitals sharing a HIPAA-compliant platform. Rare in the wild, common on the exam.

The cross-cutting **characteristics** — elasticity (scale up and down on demand), multitenancy (many customers on shared infrastructure), metered utilization (pay for what you use), shared vs dedicated resources, file synchronization (OneDrive, iCloud, Dropbox keeping files consistent across devices), high availability (redundancy across data centers) — apply across all the models.

### Beat 2 — Feynman via your homelab

You've got a gaming PC and you want to run a Minecraft server for your friends.

**Option 1 — IaaS:** Rent an AWS EC2 instance. Pick Ubuntu, SSH in, install Java, install the Minecraft server jar, configure the firewall, manage backups, patch the OS monthly. You own everything from the OS up. *Maximum control, maximum babysitting.*

**Option 2 — PaaS:** Use a service that hosts Java game servers. You upload your world file and config, they handle the OS and Java runtime. You don't SSH anywhere. *You traded control for "I don't want to be a sysadmin tonight."*

**Option 3 — SaaS:** Realms. Mojang runs the whole thing. You click a button, invite friends, play. No OS, no jar files, no backups to manage. *You traded everything for "it just works." You also can't install mods.*

**Option 4 — your homelab:** Run it on the Proxmox box in your closet. Private cloud of one. Free after hardware cost, total control, your problem when the SSD dies at 2am. *Cheapest long-term, most expensive in time.*

Same workload — Minecraft server — four different right answers depending on what you value: control, convenience, cost, or learning.

### Beat 3 — bridge to the enterprise

Same question scales up. A company needs to host a customer-facing web app:

- **Gaming-PC equivalent (IaaS on AWS)** — DevOps team spins up EC2 instances, manages the OS, patches, deploys code via CI/CD. Maximum flexibility, maximum staffing cost.
- **Developer-rig equivalent (PaaS on Azure App Service)** — developers push code, Azure handles the OS, scaling, load balancing. Faster to ship, harder to debug when the abstraction leaks.
- **Cybersecurity-analyst equivalent (SaaS — buy, don't build)** — buy Salesforce or HubSpot, configure it, integrate it. No app to maintain.
- **Server-room equivalent (private cloud)** — regulated industry, sensitive data, on-prem VMware cluster with dedicated hardware. Audit-friendly, slow to scale.

### Beat 4 — the point

Same fundamental question — *who runs the layer below my code?* — different workloads, different right answers. A startup chasing time-to-market picks SaaS or PaaS. A defense contractor with classified data picks private. A SaaS company with unpredictable traffic picks IaaS with autoscaling. Get this question into your bones — you'll ask it every time someone says "let's move this to the cloud."

## Key facts

### Service models — the responsibility line

| Model | Provider manages | You manage | Example |
|---|---|---|---|
| **IaaS** | Hardware, virtualization, network | OS, runtime, app, data | AWS EC2, Azure VMs |
| **PaaS** | Everything up through runtime | App code, data | Azure App Service, Heroku |
| **SaaS** | Everything | Your user accounts and data inside the app | Microsoft 365, Salesforce |

The shorthand: **IaaS = rent the box. PaaS = rent the platform. SaaS = rent the app.**

### Deployment models

| Model | Who shares the hardware | Best for |
|---|---|---|
| **Public** | Multiple unrelated tenants | Most workloads, cost efficiency, scale |
| **Private** | One organization only | Regulated data, predictable load, control |
| **Hybrid** | Mix — some on-prem, some public | Burst capacity, gradual migration, regulatory hybrid |
| **Community** | Organizations with shared requirements | Government, healthcare consortiums |

### The five NIST characteristics (CompTIA loves these)

- **On-demand self-service** — you provision through a portal or API, no human in the loop
- **Broad network access** — accessible over standard networks from any device
- **Resource pooling (multitenancy)** — provider's resources serve many customers, dynamically assigned
- **Rapid elasticity** — scale up during Black Friday, scale down at 3am, automatically
- **Measured service (metered utilization)** — pay for what you use, billed by the hour/GB/request

### Other characteristics CompTIA tests

- **Shared vs dedicated resources** — multitenant VM on shared host vs dedicated host with no neighbors. Dedicated costs more, satisfies compliance.
- **High availability** — multiple availability zones, automatic failover, replicated storage. SLAs of 99.9%, 99.99%, 99.999%.
- **File synchronization** — OneDrive, iCloud, Dropbox, Google Drive keep the same file consistent across devices. The client watches a folder, uploads changes, pulls remote changes down. Conflict resolution when two devices edit offline.

### CompTIA exam traps

> **CompTIA exam trap:** Microsoft 365 is **SaaS**, not PaaS. Azure App Service is PaaS. Azure Virtual Machines is IaaS. All three live on Microsoft Azure infrastructure — same company, different service models. Read the question carefully.

> **CompTIA exam trap:** **Multitenancy ≠ public cloud.** Private cloud can also be multitenant — multiple departments of one company sharing infrastructure. Multitenancy describes resource sharing; public/private describes who owns the hardware.

> **CompTIA exam trap:** **Elasticity ≠ scalability.** Scalability is "can it grow?" Elasticity is "can it grow AND shrink automatically based on demand?" Cloud's superpower is shrinking — you stop paying when load drops. On-prem servers can be scalable but rarely elastic.

> **CompTIA exam trap:** **Community cloud** is the one everyone forgets. If the question describes "several healthcare organizations sharing HIPAA-compliant infrastructure," that's community, not hybrid.

### Home vs enterprise

At home, you touch SaaS daily — Gmail, Spotify, Netflix, Steam Cloud, iCloud Photos. You probably touch IaaS only if you're running a game server or a VPS for a side project. Your "private cloud" is the Proxmox box or NAS in your closet.

**In an enterprise environment, this changes:**

- **Identity** — your personal Microsoft account becomes a tenant in Entra ID with thousands of users, conditional access policies, MFA enforcement, and SSO into hundreds of SaaS apps.
- **Cost management** — you don't notice $5/month on a personal VPS. Enterprises hire FinOps teams to audit cloud spend; an unattended IaaS instance can rack up thousands in a weekend.
- **Hybrid is the default** — most real companies aren't fully cloud or fully on-prem. Identity syncs from on-prem AD to Entra ID, file shares replicate to SharePoint, backups land in Azure Blob or S3.
- **Compliance gates everything** — public cloud is fine for marketing data, off-limits for certain regulated workloads. The deployment model decision is a legal decision before it's a technical one.
- **Shared responsibility** — the cloud provider secures *the cloud* (the hardware, the hypervisor). You secure *what's in the cloud* (your data, your IAM config, your firewall rules). Misconfigured S3 buckets cause breaches weekly, and it's never AWS's fault.

## Helpdesk reality

- **"My OneDrive isn't syncing."** Check the sync client status icon, check the account is signed in, check the file isn't locked open in another app, check storage quota. File sync conflicts are 90% of cloud helpdesk tickets.
- **"I can't get to [SaaS app]."** First question: is it down for them, or for everyone? Check the provider's status page before you spend an hour troubleshooting their browser.
- **"Why is our Azure bill so high this month?"** Not your ticket — escalate to the cloud team. But know the cause: orphaned resources, autoscaling gone wrong, egress charges, someone left a GPU VM running.
- **"Can we just move everything to the cloud?"** Never promise. The honest answer is "some workloads, yes; others, no — depends on data, latency, compliance, and cost." That's a project, not a ticket.
- **Never paste customer data into an unapproved AI tool** to "help draft a ticket update." Use company-approved AI (Microsoft Copilot, ServiceNow Now Assist) only, and only for non-sensitive content. CompTIA 220-1202 tests this directly.

## Related concepts

[[Virtualization]] · [[Hypervisors]] · [[Containers]] · [[VPN]] · [[Microsoft 365]] · [[Active Directory and Entra ID]] · [[Backup Strategies]] · [[Shared Responsibility Model]]

*Source: VIRGIL knowledge base — 2026-05-10*