# Cloud Models

## What it is

In **Smash Bros Ultimate**, you pick your fighter, your stage, your ruleset, and your opponents — but you're not the one who built Battlefield, coded Bayonetta's frame data, or set up the matchmaking servers. Sakurai's team did. You just rent the experience. If you want full control, you set up an offline tournament on your own Switch with your own rules. If you want zero setup, you queue Quickplay and let the system handle everything. If you want something in between, you host an arena — your room, their fighters, Nintendo's netcode.

That's exactly what **cloud models** are. They're rented computing, sliced different ways depending on how much you want to control versus how much you want handed to you. The provider owns the hardware. You own some portion of what runs on it. The line between "their job" and "your job" is the entire test.

Technically: a **cloud model** is a combination of a **service model** (what layer of the stack you rent — infrastructure, platform, or software) and a **deployment model** (who can use it — public, private, hybrid, or community). Add **connectivity options** (how you reach it) and **cloud-native networking primitives** (VPC, gateways, security groups), and you have N10-009 Objective 1.3 in one frame.

## Why it matters

Every network you'll touch in 2026 has cloud somewhere in it. The on-prem-only shop is a museum exhibit. Even small businesses run [[Microsoft 365]], [[Google Workspace]], a SaaS payroll system, and a hybrid VPN back to AWS for the one legacy app nobody wants to migrate. If you can't explain the difference between IaaS and PaaS, or why the security team cares about VPC peering, you're not a network tech — you're a cable monkey.

CompTIA tests this hard on N10-009. Objective 1.3 covers service models, deployment models, connectivity, and cloud-native networking. Expect at least two scenario questions on the exam: one asking you to pick the right service model for a use case, one asking about security groups vs. network ACLs, and probably one on Direct Connect vs. VPN. Know them cold.

## Key facts

### Service models — the three layers of rent

Think of it as a Smash Bros customization slider. How much do you build, how much does Nintendo build?

| Model | You manage | Provider manages | Smash analogy | Example |
|---|---|---|---|---|
| **IaaS** | OS, runtime, apps, data, network config | Hardware, hypervisor, physical network | You rent a blank Switch. Install your own game, your own save data, your own controllers. | AWS EC2, Azure VMs, GCP Compute Engine |
| **PaaS** | Apps, data | OS, runtime, middleware, hardware | You rent Smash Ultimate already installed. You just bring your custom rulesets and replays. | AWS Elastic Beanstalk, Azure App Service, Heroku |
| **SaaS** | Data, user config | Everything else | You join Quickplay. Nintendo runs the servers, the matchmaking, the patches. You just play. | Microsoft 365, Salesforce, Gmail |

**[[Infrastructure as a Service]] (IaaS)** gives you the most control and the most responsibility. You provision virtual machines, configure the OS, patch it, secure it, network it. The provider only guarantees the hardware is alive and the hypervisor works.

**[[Platform as a Service]] (PaaS)** abstracts the OS away. You push code, the platform runs it. You don't patch the OS. You don't size the VM. You also can't tweak kernel parameters when something weird happens — that's the trade.

**[[Software as a Service]] (SaaS)** is the end-user product. You log in. You use it. You don't manage anything except your data and your account settings. When it breaks, you open a ticket with the vendor.

> **CompTIA exam trap:** SaaS vs. PaaS confusion. SaaS is the *finished app* (Gmail, Salesforce). PaaS is the *runtime where developers deploy their own app* (Heroku, App Service). If the question says "developers push code," it's PaaS. If the question says "users log in and use the application," it's SaaS.

### Deployment models — who's in the lobby

| Model | Who can use it | Smash analogy |
|---|---|---|
| **Public** | Anyone with an account and a credit card | Quickplay — open to the whole online roster |
| **Private** | One organization only | A local tournament at your house — invite only |
| **Hybrid** | Mix of public and private, connected | Local bracket finals streamed to a public lobby for spectators |
| **Community** | Several orgs with shared concerns | A regional tournament circuit — multiple crews, shared rules |

**Public cloud** (AWS, Azure, GCP) is multi-tenant — your VMs sit on the same physical hardware as some stranger's VMs, separated by the hypervisor. Cheapest, most scalable, least control.

**Private cloud** is single-tenant — either on your own datacenter hardware or a dedicated slice of a provider. More control, more expense, more responsibility.

**Hybrid cloud** is the realistic enterprise pattern: keep the database with HIPAA data in the private cloud, burst the web frontend to public cloud when traffic spikes. Connected with VPN or Direct Connect.

### Multitenancy

**[[Multitenancy]]** is the public cloud's superpower and its scariest property. One physical server, many customers' workloads, separated by software. *The hypervisor is the only thing between your data and a stranger's VM — patch it or pray.* This is why Spectre/Meltdown made cloud architects sweat in 2018 and why side-channel attacks remain a real research area.

### Scalability vs. elasticity

CompTIA tests this distinction.

- **[[Scalability]]**: the system *can* grow. You designed it to handle more load if you add resources. This is a property of the architecture.
- **[[Elasticity]]**: the system grows and shrinks *automatically* based on demand. This is a behavior — auto-scaling groups, serverless functions spinning up on request.

A monolith on a single VM is not scalable. A stateless app behind a load balancer with an auto-scaling group is both scalable and elastic. *Scalability is the road being wide enough. Elasticity is the road widening itself at rush hour.*

### Cloud-native networking primitives

This is where N10-009 gets specific. Memorize these.

**[[Virtual Private Cloud]] (VPC)** — your own logically isolated network inside the provider's datacenter. You define the CIDR block (e.g., 10.0.0.0/16), the subnets, the route tables, the gateways. AWS calls it VPC. Azure calls it VNet. GCP calls it VPC. Same concept.

**[[Internet Gateway]]** — the door from your VPC to the public internet. Without it, your VPC is an island. Attach it, add a route (`0.0.0.0/0 → IGW`), and instances with public IPs can reach the internet.

**[[NAT Gateway]]** — lets private-subnet instances reach the internet for updates without being reachable *from* the internet. Same NAT logic as your home router, but managed and horizontally scalable. Private instances send traffic to the NAT gateway, NAT gateway translates source to its own public IP, response comes back, NAT translates it back. *Your database doesn't need a public IP to download patches — that's what NAT gateway is for.*

**[[Cloud Gateway]]** — generic term for any managed edge device connecting your VPC to something else: the internet, your on-prem network, another VPC, a SaaS provider. Internet gateway and NAT gateway are specific types.

**Network Security Groups (NSGs)** — stateful firewalls attached to instances or NICs. Allow rules only (in AWS), allow + deny (in Azure). Stateful means return traffic is allowed automatically — you don't write a rule for the reply.

**Network ACLs / Security Lists** — stateless firewalls attached to subnets. Allow and deny rules, evaluated in order. Stateless means you must explicitly allow return traffic in both directions. Oracle Cloud calls them "security lists." AWS calls them "network ACLs." Same concept.

> **CompTIA exam trap:** NSG vs. ACL. Security groups are **stateful** and attach to **instances**. Network ACLs are **stateless** and attach to **subnets**. If the question mentions "must allow return traffic explicitly," it's a network ACL. If it says "applied to the VM directly," it's a security group.

### Network Functions Virtualization (NFV)

**[[NFV]]** replaces physical network appliances (firewalls, load balancers, routers, WAN optimizers) with software running on commodity hardware or in the cloud. Instead of buying a $40,000 Palo Alto box, you spin up a virtual Palo Alto in your VPC. Instead of a Cisco router, you run a virtual router VM.

NFV is what makes the cloud's networking layer possible. The "router" between your subnets isn't a physical Cisco — it's a software-defined construct running on hypervisors. *Every cloud firewall, load balancer, and VPN concentrator you'll ever configure is NFV under the hood.*

### Cloud connectivity options

How does your office reach your VPC?

| Option | How it works | When to use |
|---|---|---|
| **Internet + public endpoints** | Hit the SaaS/IaaS public IP over the open internet | SaaS apps, low-sensitivity workloads |
| **[[VPN|Site-to-site VPN]]** | IPsec tunnel from your edge router to a VPC VPN gateway | Cheap, encrypted, works anywhere with internet. Latency varies. |
| **[[Direct Connect]]** | Dedicated private circuit from your datacenter to the cloud provider's edge | Predictable latency, high bandwidth, bypasses public internet. Expensive, weeks to provision. |

AWS calls it **Direct Connect**. Azure calls it **ExpressRoute**. GCP calls it **Cloud Interconnect**. All the same idea: a private fiber circuit (often through a colocation partner like Equinix) that carries your traffic without ever touching the public internet.

> **CompTIA exam trap:** "Most secure and consistent latency to cloud" = Direct Connect, not VPN. VPN is encrypted but rides public internet — latency and jitter follow whatever the BGP weather is doing. Direct Connect is a private circuit with an SLA.

## Helpdesk reality

- User says "the cloud is slow today" — translation: their internet is slow, or DNS is slow, or the SaaS provider is having an incident. Check [[status pages]] before you touch anything. AWS, Azure, M365, Salesforce all publish them.
- User says "I can't reach our AWS server" — check whether they're on the VPN. The server is in a private subnet for a reason. If it had a public IP, every script kiddie on the internet would already be hammering port 22.
- Never promise "the cloud never goes down." AWS us-east-1 has had multi-hour outages that took half the internet with it. The cloud is someone else's computer, and someone else's computer can die.
- Never promise "moving to the cloud will be cheaper." It often isn't. It's more *flexible*, not always cheaper, especially for steady-state workloads.
- Escalation point: if it's a VPC routing or security group issue, that's the cloud team or the network team — not helpdesk. Confirm the user's client side (DNS, VPN, credentials) and hand it off with a clean ticket.

## Related concepts

[[Virtualization]] · [[VPN]] · [[Direct Connect]] · [[NAT]] · [[Firewall]] · [[Subnetting]] · [[DNS]] · [[SDN]] · [[Hypervisor]] · [[Load Balancer]] · [[High Availability]] · [[CIDR]]

*Source: VIRGIL knowledge base — 2026-05-11*