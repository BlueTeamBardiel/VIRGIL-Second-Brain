# Designing the Cloud

## What it is

In **Apex Legends**, when you queue up for a match, you don't pick the server hardware. Respawn's matchmaker drops you into a data center somewhere — Frankfurt, Dallas, Tokyo — on a game instance that was spun up for your lobby and will be torn down the second the champion screen fades. Sixty players, twenty squads, all sharing infrastructure you'll never see. Next match, different instance. The map's the same. The legends are the same. The server underneath is disposable. That's exactly what cloud design does — it abstracts the physical hardware so the workload is the only thing you care about, and it scales the underneath to match what you're throwing at it.

In N10-009 terms, the **cloud** is on-demand delivery of compute, storage, and networking over a network (usually the internet), where resources are pooled, virtualized, and billed by consumption. You don't own the hardware. You rent a slice of someone else's, and that slice can grow, shrink, or vanish in seconds.

## Why it matters

Every modern enterprise has cloud somewhere in the stack. Your email is in Microsoft 365. Your CRM is Salesforce. Your dev team's test environment is AWS. Your backups go to Azure Blob. If you can't speak fluent cloud — service models, deployment models, connectivity options, the security primitives that wrap them — you can't troubleshoot half the tickets that hit modern helpdesks. **Objective 1.3** specifically wants you to summarize cloud concepts and connectivity options, and CompTIA tests the vocabulary hard. You don't need to build a VPC from scratch. You need to know what one is, when to recommend Direct Connect over VPN, and why a security group is not a firewall in the traditional sense.

## Key facts

### Service models — what you rent vs. what they manage

Three flavors. The differentiator is **where the responsibility line sits** between you and the provider.

| Model | You manage | Provider manages | Example |
|---|---|---|---|
| **IaaS** | OS, apps, data, runtime, middleware | Virtualization, servers, storage, networking | AWS EC2, Azure VMs |
| **PaaS** | Apps, data | Everything below the app layer | Azure App Service, Heroku, Google App Engine |
| **SaaS** | Just your data and user config | Everything | Microsoft 365, Salesforce, Gmail |

**[[IaaS]]** gives you the most control and the most homework. You patch the OS, you secure the VM, you configure the network. **[[PaaS]]** hands you a runtime — push code, the platform deals with the OS underneath. **[[SaaS]]** is the finished product. You log in, you use it, you don't think about servers.

*Rule of thumb: the more letters they take care of, the less you can break — and the less you can customize.*

### Deployment models — who else is in the building

- **[[Public cloud]]** — multitenant infrastructure owned by AWS, Azure, GCP. You share physical hardware with strangers, isolated by virtualization. Cheap, scalable, less control.
- **[[Private cloud]]** — cloud architecture (pooled, virtualized, self-service) but on hardware dedicated to one organization. Either on-prem or hosted. Expensive, more control, regulatory-friendly.
- **[[Hybrid cloud]]** — a mix. Sensitive data stays on private, burst workloads spill into public. Requires real connectivity between the two halves (more on that below).
- **Community cloud** *(not on the 1.3 list but worth knowing)* — shared by orgs with common requirements, e.g. a healthcare consortium.

### Multitenancy

**[[Multitenancy]]** is the public cloud's superpower and its scariest property. One physical host runs VMs for dozens of unrelated customers, isolated by the hypervisor. Done right, you can't see your neighbor and they can't see you. Done wrong, side-channel attacks like Spectre/Meltdown happen. *The hypervisor is the wall between you and a stranger's workload — and that wall is software.*

### Scalability vs. elasticity

CompTIA tests these as distinct concepts. They're related but not the same.

- **[[Scalability]]** — the system's capacity to grow to meet load. Can be vertical (bigger VM) or horizontal (more VMs). Planned. "We're adding capacity for Black Friday."
- **[[Elasticity]]** — automatic, real-time scaling up *and back down* in response to current demand. Reactive. "Auto-scaling group adds three instances when CPU hits 70%, kills them when it drops below 30%."

*Scalability is the gym membership. Elasticity is the muscle growing and shrinking with how much you actually lift this week.*

### Virtual private cloud (VPC)

A **[[VPC]]** is your private, logically isolated slice of a public cloud provider's network. You define the IP address range (a CIDR block like 10.0.0.0/16), carve it into subnets, attach route tables, and decide what gets to talk to what. Inside a VPC, you build the same network primitives you'd build on-prem — subnets, routing, NAT, firewalls — except every piece is a software-defined object you create with an API call.

### Cloud gateways — how traffic enters and leaves

- **[[Internet gateway]]** — the on-ramp to the public internet for resources in a VPC. Attach one to your VPC, point a route to it, and instances with public IPs can reach out and be reached.
- **[[NAT gateway]]** — managed network address translation. Lets private-subnet instances initiate outbound connections (patches, API calls) without being publicly reachable. Same NAT concept as your home router, just elastic and managed by the provider.
- **Cloud gateway** (umbrella term) — any managed entry/exit point: internet gateway, NAT gateway, VPN gateway, transit gateway. CompTIA uses the general term; know it means "the box at the edge of your VPC that routes traffic somewhere."

### Network security groups vs. network security lists

CompTIA distinguishes these. Both are virtual firewalls in cloud environments, but they apply at different scopes.

| | **Security group** | **Security list / NACL** |
|---|---|---|
| Scope | Per instance / NIC | Per subnet |
| State | Stateful (return traffic auto-allowed) | Stateless (must allow both directions explicitly) |
| Rule types | Allow only | Allow and deny |
| Evaluation | All rules evaluated | Rules evaluated in order |

A **[[network security group]]** wraps individual workloads. A **network security list** (AWS calls this a Network ACL) wraps a whole subnet. Defense in depth uses both — list at the subnet boundary as a coarse filter, group at the instance as the fine filter.

### Network functions virtualization (NFV)

**[[NFV]]** is the practice of running network appliances — routers, firewalls, load balancers, WAN optimizers — as software on commodity hardware (usually VMs or containers) instead of as dedicated physical boxes. The cloud is built on NFV. When you spin up a VPC, the "router" and "firewall" are NFV instances managed by the provider. *The box on the rack is dead. The function lives in software now.*

### Cloud connectivity options

How does your on-prem network actually reach the cloud? Three answers on the exam.

**1. Internet (with or without VPN)**
The cheap path. Traffic crosses the public internet. If you wrap it in a **[[site-to-site VPN]]** (IPsec tunnel between your edge router/firewall and a cloud VPN gateway), it's encrypted and authenticated. Latency is whatever the internet gives you that day. Bandwidth tops out at your internet circuit and the VPN gateway's throughput cap.

**2. Direct Connect / ExpressRoute / Cloud Interconnect**
AWS calls it **[[Direct Connect]]**, Azure calls it ExpressRoute, GCP calls it Cloud Interconnect. Same idea: a private, dedicated physical circuit from your data center or colo facility to the cloud provider's network, bypassing the public internet entirely. Predictable latency, dedicated bandwidth (1 Gbps, 10 Gbps, 100 Gbps), better security posture. Costs real money — both the circuit and the port fees — and takes weeks to provision.

**3. SD-WAN / cloud on-ramps**
Increasingly common. Your SD-WAN fabric has direct peering into cloud regions, giving you VPN-like flexibility with closer-to-Direct-Connect performance.

*Rule of thumb: VPN for dev/test and low-volume production. Direct Connect when latency or compliance demands it.*

### CompTIA exam traps

> **CompTIA exam trap:** **Scalability vs. elasticity.** They sound interchangeable. They aren't. Scalability = the *capacity* to grow (and you usually trigger it deliberately). Elasticity = *automatic* growth and shrinkage in response to live demand. If the question says "automatically" or "in real time," the answer is elasticity.

> **CompTIA exam trap:** **Security group vs. NACL/security list.** Security groups are stateful and instance-scoped. NACLs/security lists are stateless and subnet-scoped. If the question mentions return traffic being implicitly allowed, that's stateful → security group. If it mentions explicit deny rules or subnet-level filtering, that's a NACL/list.

> **CompTIA exam trap:** **IaaS vs. PaaS responsibility.** If the customer patches the OS, it's IaaS. If the provider patches the OS and the customer just deploys code, it's PaaS. Patching the OS is the dividing line CompTIA loves.

> **CompTIA exam trap:** **Internet gateway vs. NAT gateway.** Internet gateway = bidirectional public reachability for instances with public IPs. NAT gateway = outbound-only translation for private instances. They are not interchangeable, and a VPC often has both.

> **CompTIA exam trap:** **VPN over internet vs. Direct Connect.** Both connect on-prem to cloud. VPN is encrypted-over-public-internet; Direct Connect is a dedicated private circuit (not encrypted by default — you can layer IPsec on top if you need it). If the question emphasizes predictable latency, dedicated bandwidth, or bypassing the internet, the answer is Direct Connect.

## Helpdesk reality

- User says: *"The cloud is down."* What they mean: one SaaS app — usually Microsoft 365 or Salesforce — is throwing an error for them specifically. Check the provider status page first. Then check whether the user can hit anything else cloud-hosted. Nine times out of ten the cloud is fine; their session token expired or their VPN dropped.
- User says: *"I can't get to our AWS server."* Don't assume AWS is down. Check (1) is the user on the corporate VPN that fronts the Direct Connect / VPN tunnel to AWS, (2) does their account have the right IAM/security-group access, (3) is the instance even running. Stopped EC2 instances generate this ticket constantly.
- Never promise: *"Cloud means it's always up."* Cloud means *somebody else's hardware*. Regional outages happen. AZ failures happen. Your SLA is the only thing standing between you and a bad afternoon.
- Escalation: if you've confirmed the user's client, network path, and credentials are fine and the resource itself is unreachable, it's a cloud/network team ticket. Hand off with the VPC ID, instance ID, source IP, and timestamps. They can't troubleshoot vibes.
- The hybrid-cloud gotcha: when on-prem and cloud both have 10.0.0.0/16 subnets, routing breaks in fun ways. *Overlapping CIDR ranges are the single most common reason a brand-new VPN tunnel "comes up" but no traffic flows.*

## Related concepts

[[IaaS]] · [[PaaS]] · [[SaaS]] · [[VPC]] · [[Public cloud]] · [[Private cloud]] · [[Hybrid cloud]] · [[Multitenancy]] · [[Scalability]] · [[Elasticity]] · [[NFV]] · [[Internet gateway]] · [[NAT gateway]] · [[Network security group]] · [[Direct Connect]] · [[Site-to-site VPN]] · [[SD-WAN]] · [[Subnetting]] · [[CIDR]]

*Source: VIRGIL knowledge base — 2026-05-11*