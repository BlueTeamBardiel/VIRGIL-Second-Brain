# Cloud Characteristics

## What it is

You already use the cloud. Your Steam library lives on Valve's servers. Your phone photos sync to iCloud or Google. Your save files in *Baldur's Gate 3* roam between your desktop and Steam Deck because somewhere, a server farm is holding them for you. That's the cloud — somebody else's computer, rented by the hour, reached over the internet.

In plain English: cloud computing means consuming computing resources (storage, compute, applications) as a service over a network instead of owning the hardware yourself. You don't buy the server. You pay for what you use. When you need more, you get more. When you stop needing it, you stop paying.

Technically: cloud computing is the on-demand delivery of IT resources over the internet with pay-as-you-go pricing, characterized by NIST's five essential traits — on-demand self-service, broad network access, resource pooling, rapid elasticity, and measured service.

## Why it matters

Cloud is no longer optional knowledge. Every business you'll support either runs in the cloud, is migrating to the cloud, or is fighting a losing battle to stay out of it. Your first helpdesk ticket about "the SharePoint site is down" is a cloud ticket. Your first VPN troubleshooting call is a cloud ticket. When Microsoft 365 has a regional outage, your phone lights up.

CompTIA tests this hard on **Objective 220-1201 4.2**. They want you to distinguish the service models (IaaS/PaaS/SaaS), the deployment models (public/private/hybrid/community), and the characteristics that define cloud as a category (elasticity, metered, multitenancy, availability). Expect scenario questions: "A company wants X — which model fits?" Memorize the boundaries, not just the names.

## In your build, in the enterprise

**Beat 1 — Technical depth.** The cloud is defined by five NIST traits, but the exam-relevant breakdown is two axes: **service model** (what layer you rent) and **deployment model** (who you share it with).

Service models, bottom to top:
- **IaaS** — you rent raw VMs, storage, networking. You manage the OS, patches, apps. Examples: AWS EC2, Azure VMs, Google Compute Engine.
- **PaaS** — you rent a runtime/platform. You write code and push it; the provider handles the OS, scaling, load balancing. Examples: Azure App Service, AWS Elastic Beanstalk, Heroku.
- **SaaS** — you rent the finished application. You log in and use it. Examples: Microsoft 365, Google Workspace, Salesforce, Dropbox.

The mental shortcut: **IaaS gives you a server, PaaS gives you a sandbox, SaaS gives you a login.** More you rent, less you manage, less you control.

Deployment models:
- **Public cloud** — shared infrastructure (AWS, Azure, GCP). Multitenant. Cheap. Less control.
- **Private cloud** — infrastructure dedicated to one organization. Could be on-prem or hosted. Expensive. Maximum control.
- **Hybrid cloud** — mix of public and private, with orchestration between them. Burst to public when private fills up.
- **Community cloud** — shared between organizations with common requirements (healthcare consortium sharing HIPAA-compliant infrastructure, government agencies sharing FedRAMP).

The characteristics that make it "cloud" rather than "rented hosting": **elasticity** (scale up and down automatically with load), **metered utilization** (pay per GB, per hour, per API call), **multitenancy** (multiple customers share the same physical hardware, logically isolated), **availability** (the provider's SLA promises uptime, often 99.9%+), **shared vs dedicated resources** (public is shared at the hardware level; private dedicates hardware to you), and **file synchronization** (your data follows you between devices via the provider's sync layer).

**Beat 2 — Feynman example via your gaming life.**

**Your Steam library is SaaS.** You don't manage the servers. You don't patch anything. You log in, you click play, the game streams down. Valve handles every layer. *You rent the experience, not the machinery.*

**Your homelab Proxmox box is private IaaS.** You own the hardware. You spin up VMs on demand. You decide the OS, the network, the storage layout. Nobody else's workload touches your CPU. *Full control, full responsibility, full electricity bill.*

**Your GeForce Now or Xbox Cloud Gaming subscription is public IaaS-ish.** Somewhere in a data center, a GPU is rented to you for the duration of your session. When you log off, that same GPU serves the next gamer. Multitenancy in action. *You don't own the silicon; you rent its time.*

**Your Steam Cloud saves are file synchronization.** Beat the boss on your desktop, pick up your Steam Deck, the save is already there. Provider handles the sync layer. You don't think about where the file lives. *That seamlessness is the entire product.*

**Beat 3 — Bridge from gaming to enterprise.**

Same patterns, bigger stakes. The marketing department uses **Microsoft 365** — SaaS. They don't care where Exchange lives; they care that Outlook opens. The dev team uses **Azure App Service** — PaaS. They push code via Git; the platform handles the rest. The infrastructure team runs **EC2 instances** for the company's custom inventory database — IaaS. They're patching Linux, managing IPs, configuring security groups, just like you do in your homelab — but at 200 VMs instead of 4.

The bank down the street can't use public cloud for everything because regulators won't let customer financial data sit on shared hardware — so they run a **private cloud** for the core banking system and a **public cloud** for the marketing website. That's **hybrid**. The five hospitals in the regional health network pool resources into a HIPAA-compliant **community cloud** because none of them individually can afford the compliance overhead, but together they can split it.

When Black Friday hits, the e-commerce site scales from 10 web servers to 400 in twenty minutes — that's **elasticity**. The bill at end of month reflects exactly how many server-hours got consumed — that's **metered utilization**. The SLA promises 99.95% uptime — that's the **availability** guarantee you're paying a premium for. Five thousand other AWS customers' VMs are running on the same physical host as yours, isolated by the hypervisor — that's **multitenancy**.

**Beat 4 — The point.**

Same fundamental question as your homelab: *Do I own this, do I rent it, or do I share it?* Different scales, different right answers. A solo gamer rents Steam Cloud for 5GB of save files. A Fortune 500 rents Azure for $40M/year. The decision tree is identical: control vs cost vs operational burden. *Get this question into your bones — every cloud architecture conversation for the rest of your career starts here.*

## Key facts

### Service models — what you rent

| Model | You manage | Provider manages | Example |
|---|---|---|---|
| **IaaS** | OS, runtime, apps, data | Hardware, virtualization, network | AWS EC2, Azure VM |
| **PaaS** | Apps, data | Hardware, OS, runtime, scaling | Azure App Service, Heroku |
| **SaaS** | Data (sometimes), user config | Everything else | Microsoft 365, Salesforce |

### Deployment models — who you share with

| Model | Tenancy | Cost | Control | Use case |
|---|---|---|---|---|
| **Public** | Shared (multitenant) | Lowest | Least | General workloads, dev/test |
| **Private** | Single tenant | Highest | Most | Regulated data, custom hardware needs |
| **Hybrid** | Both | Mixed | Mixed | Burst capacity, regulated + non-regulated split |
| **Community** | Shared among similar orgs | Mid | Mid | Healthcare, gov, education consortiums |

### Defining characteristics

- **Shared vs dedicated resources** — public cloud shares hardware across customers; private cloud dedicates it. Dedicated costs more, eliminates noisy-neighbor risk.
- **Multitenancy** — multiple customers, one physical infrastructure, logically isolated by the hypervisor and network segmentation.
- **Elasticity** — automatic scaling up *and down* based on demand. Rapid elasticity is the NIST formal term. Don't confuse with scalability (which is just "can grow").
- **Metered utilization** — billing based on actual consumption. Per GB stored, per hour of VM uptime, per API call, per user seat.
- **Availability** — uptime guarantee, expressed in the SLA. 99.9% = "three nines" = ~8.7 hours downtime/year. 99.99% = "four nines" = ~52 minutes/year.
- **File synchronization** — automatic replication of files across devices/locations via the cloud provider. OneDrive, iCloud Drive, Google Drive, Dropbox.

### Ingress vs egress

- **Ingress** — data flowing *into* the cloud. Usually free.
- **Egress** — data flowing *out* of the cloud. Almost always billed, and it's how providers lock you in.

> **CompTIA exam trap:** Elasticity vs scalability. They're not synonyms. **Scalability** = the system *can* grow to handle more load (often manual). **Elasticity** = the system *automatically* scales up AND back down with demand. Elasticity is a cloud characteristic; scalability is a system property. CompTIA tests this.

> **CompTIA exam trap:** IaaS vs PaaS line. If the question mentions "managing the OS and applying patches," it's IaaS. If it mentions "deploying code without worrying about the underlying server," it's PaaS. The OS is the dividing line.

> **CompTIA exam trap:** Community cloud is not a small public cloud. It's specifically shared between organizations with *common requirements* (compliance, mission, jurisdiction). A startup using AWS is public, not community, no matter how small.

### Consumer cloud vs enterprise cloud

Your home cloud experience: one Microsoft account, OneDrive auto-syncing Documents, maybe a Plex server reaching out to plex.tv for remote streaming. You click "agree" on the SLA and move on.

**In an enterprise environment, this changes dramatically:**
- **Identity** — Entra ID (formerly Azure AD) with conditional access, MFA enforcement, device compliance. Not "log in with your email."
- **Data governance** — DLP policies, retention rules, eDiscovery holds, regulatory classifications. You can't just delete a file.
- **Cost management** — FinOps teams watching every VM, tagging resources by department, killing zombie test environments at midnight to save $300.
- **Networking** — ExpressRoute or Direct Connect (private fiber links to the provider), VPN gateways, hub-and-spoke virtual networks, transit gateways. Not "open Wi-Fi at the coffee shop."
- **Compliance** — SOC 2, HIPAA, PCI-DSS, FedRAMP audits. The provider gives you the controls; you prove you're using them.
- **Vendor lock-in awareness** — egress fees, proprietary services (AWS Lambda, Azure Cosmos DB), multi-cloud strategies to avoid being held hostage.

Your home cloud bill is $9.99/month. The enterprise's cloud bill has a comma in it. Sometimes two.

## Helpdesk reality

- **"My OneDrive isn't syncing"** — 80% of the time it's authentication: token expired, password changed, MFA prompt got dismissed. Sign out and back in before you touch the sync client. The other 20% is a file with a forbidden character or a path longer than 256 chars.
- **"SharePoint is down"** — check the Microsoft 365 admin center service health page before doing anything else. If it's a regional Microsoft outage, your job is to communicate, not to fix. Open a ticket with Microsoft and broadcast the status to users.
- **"I deleted something important from Google Drive a month ago"** — depends on the retention policy. SaaS providers have recycle bins, then version history, then nothing. Know your org's retention settings before promising recovery. Never promise data is recoverable until you've actually seen it in the restore UI.
- **"Why is our Azure bill so high this month?"** — almost always egress charges, a forgotten VM left running, or a storage account with no lifecycle policy on snapshots. Not your problem to solve at L1, but recognize the pattern so you escalate to the right team.
- **"Can I use ChatGPT for work?"** — depends entirely on your company's AI policy. The right answer is *"let me check our approved tools list"* — never "sure" and never "no" without checking. Pasting customer data into an unapproved AI is a 220-1202 privacy violation waiting to happen.

## Related concepts

[[Virtualization Basics]] · [[Hypervisors Type 1 vs Type 2]] · [[Resource Requirements for VMs]] · [[Security in the Cloud]] · [[SLAs and Uptime Guarantees]] · [[VPN and Remote Access]] · [[File Synchronization Services]] · [[Multifactor Authentication]] · [[Network Topology — WAN]]

*Source: VIRGIL knowledge base — 2026-05-10*