# Virtualization and Cloud Computing
**Why this matters:** Virtualization and cloud services define modern enterprise infrastructure—you need to understand how VMs, containers, and VRF partition physical resources, and how cloud deployment models affect network architecture decisions.

---

## 17.1 Virtual Machines and Containers

### Simple Analogy First
Think of virtualization like a single apartment building (physical server) housing multiple independent apartments (VMs). Each apartment has its own kitchen, bedroom, and bathroom—but they all share the same foundation, electrical system, and plumbing. A building manager (hypervisor) divides and allocates shared resources fairly.

**Adding the Detail:**
Virtualization creates logically separate computing environments on shared physical hardware. This extends the concept you already know from [[VLAN|VLANs]] (logical networks on shared switches) and [[VPN|VPNs]] (secure virtual networks over public infrastructure) into the compute domain.

---

### 17.1.1 Virtual Machines (VMs)

**Problem they solve:** Traditional 1:1 hardware-to-OS mapping wastes resources. A single physical server might use only 15% of its CPU and RAM, yet you've paid for 100% of the hardware—plus space, cooling, and electricity.

**The Solution:** A [[hypervisor]] (also called **Virtual Machine Monitor/VMM**) sits between hardware and multiple operating systems, multiplexing physical resources (CPU, RAM, storage, network) among guest OSs.

#### Hypervisor Types

| Aspect | Type 1 (Bare-Metal) | Type 2 (Hosted) |
|--------|-------------------|-----------------|
| **Installation** | Directly on hardware | Runs as app on host OS |
| **Resource Efficiency** | High—direct hardware access | Low—must traverse host OS |
| **Common Examples** | [[VMware ESXi]], [[Microsoft Hyper-V]] | Oracle VM VirtualBox, VMware Workstation |
| **Use Case** | Data centers, cloud, production | Development, testing, personal use |
| **Host OS Required?** | No | Yes |
| **Other Names** | Native hypervisor, bare-metal | Hosted hypervisor |

**Why this distinction matters for the CCNA:**
- Type 1 hypervisors dominate cloud and enterprise deployments—this is what you'll encounter in real networking jobs
- Type 2 is easier to understand (install it on your laptop)—but less relevant for network-focused certifications

#### Networking Virtual Machines

Each VM operates as an independent network host despite running on shared physical hardware. Key concepts:

- **Virtual NIC (vNIC):** Software interface that replaces the physical NIC for each VM
- **Virtual Switch:** Hypervisor-managed switching fabric that forwards frames between vNICs and the physical NIC(s)

```
┌─────────────────────────────────────────┐
│         Physical Server                 │
├─────────────────────────────────────────┤
│  ┌──────────┐  ┌──────────┐            │
│  │   VM 1   │  │   VM 2   │            │
│  │ vNIC eth0│  │ vNIC eth0│            │
│  └─────┬────┘  └─────┬────┘            │
│        │             │                  │
│    ┌───┴─────────────┴───┐             │
│    │   Virtual Switch    │             │
│    └─────────┬───────────┘             │
│              │                          │
│        ┌─────▼──────┐                  │
│        │ Physical   │                  │
│        │ NIC (eth0) │                  │
│        └─────┬──────┘                  │
└──────────────┼──────────────────────────┘
               │
        ┌──────▼──────┐
        │   Network   │
        └─────────────┘
```

---

### 17.1.2 Containers

**Simple Analogy:** If VMs are full apartments (complete OS + apps), containers are like shared office spaces in the same building—they share the same underlying OS kernel but keep applications isolated in separate namespaces.

**Key Advantage over VMs:** Much lighter weight. A container might be 10-100 MB; a VM might be 10+ GB. You can run hundreds of containers on one server versus dozens of VMs.

**Trade-off:** Containers require all applications to run on the same OS (e.g., Linux kernel). VMs can mix Windows, Linux, etc. on the same hardware.

#### Container Technologies

- **[[Docker]]:** Most common containerization platform; uses Linux containers ([[LXC]]) under the hood
- **Container Orchestration:** [[Kubernetes]] automatically manages deployment, scaling, and networking of containers at scale

**Networking Containers:**
- Containers communicate via virtual networks similar to VMs
- Orchestration platforms handle IP assignment, load balancing, and service discovery
- Port mapping allows container ports to be exposed to external networks

---

## 17.2 Virtual Routing and Forwarding (VRF)

### Simple Analogy
Imagine a single router as a large post office with multiple delivery stations. Each station (VRF instance) operates independently—mail addressed to Station A never gets delivered to Station B, even though they share the same building. Each has its own routing table, even on the same physical router.

**Why it matters:** A single physical router can now isolate traffic for different customers, departments, or network segments—essential for [[MPLS]] networks and service providers.

### VRF Fundamentals

**Definition:** [[VRF|Virtual Routing and Forwarding]] partitions a single physical router into multiple virtual routers, each with independent:
- Routing tables
- Network interfaces
- Routing protocols

Each VRF is a separate routing domain. Traffic in VRF A never crosses into VRF B unless explicitly configured.

#### VRF Use Cases

| Scenario | Benefit |
|----------|---------|
| Service Provider with multiple customers | Customer A and Customer B never see each other's traffic, even over shared infrastructure |
| Multi-tenancy in enterprise | Department Finance isolated from Department Engineering |
| [[MPLS VPN|MPLS/VPN]] networks | Overlay VRFs on top of MPLS backbone for scalability |
| Testing/staging environments | Parallel networks on one router for different projects |

#### VRF Configuration (IOS Syntax)

```
Router(config)# vrf definition CUSTOMER-A
Router(config-vrf)# rd 65000:100
Router(config-vrf)# route-target export 65000:100
Router(config-vrf)# route-target import 65000:100

Router(config)# interface GigabitEthernet0/0/1
Router(config-if)# ip vrf forwarding CUSTOMER-A
Router(config-if)# ip address 10.1.1.1 255.255.255.0

! View VRF configuration
Router# show vrf
Router# show vrf detail CUSTOMER-A
Router# show ip route vrf CUSTOMER-A
```

**Key Terms:**
- **RD (Route Distinguisher):** Unique identifier for the VRF (format: `ASN:value`)
- **Route Target:** Controls which routes are exported/imported between VRFs

---

## 17.3 Cloud Computing

### Simple Analogy
Cloud computing is like renting apartments (compute resources) on-demand from a landlord (cloud provider) instead of owning a building outright. You pay only for what you use, resources scale up/down automatically, and the landlord handles maintenance.

### Cloud Characteristics (NIST Definition)

| Characteristic | Meaning | Network Impact |
|---|---|---|
| **On-Demand Self-Service** | Users provision resources without IT intervention | Must support rapid IP/VLAN allocation |
| **Broad Network Access** | Access from any device, anywhere | Requires robust WAN/internet connectivity |
| **Resource Pooling** | Shared compute/storage across multiple tenants | Must enforce strict isolation (VRFs, SDN) |
| **Rapid Elasticity** | Auto-scale up/down based on demand | Network must dynamically adapt (load balancers) |
| **Measured Service** | Pay-per-use billing | Must track bandwidth/traffic per tenant |

---

### Cloud Service Models

#### IaaS (Infrastructure as a Service)
- **What you get:** Virtual machines, storage, networking
- **You manage:** OS, applications, data
- **Provider manages:** Hardware, hypervisor, physical network
- **Examples:** AWS EC2, Microsoft Azure VMs, Google Compute Engine
- **Network relevance:** You design VPCs ([[VPC|Virtual Private Cloud]]), security groups, load balancers

#### PaaS (Platform as a Service)
- **What you get:** Runtime environment, databases, development tools
- **You manage:** Your applications and data only
- **Provider manages:** OS, networking, security patches
- **Examples:** Heroku, AWS Lambda, Google App Engine
- **Network relevance:** Less network configuration—provider handles it

#### SaaS (Software as a Service)
- **What you get:** Ready-to-use applications accessed via browser/API
- **You manage:** Only your data
- **Provider manages:** Everything else
- **Examples:** Salesforce, Microsoft 365, Slack, Zoom
- **Network relevance:** Minimal—just need reliable internet connectivity

#### Comparison Table

| Model | VM Required? | Manage OS? | Manage Network? | Ease of Use | Cost |
|-------|---|---|---|---|---|
| **IaaS** | Yes | Yes | Yes | Hardest | Pay-per-VM |
| **PaaS** | No | No | Partial | Medium | Pay-per-app |
| **SaaS** | No | No | No | Easiest | Pay-per-user |

---

### Cloud Deployment Models

| Model | Infrastructure | Control | Use Cases | Security |
|-------|---|---|---|---|
| **Public Cloud** | Third-party provider (AWS, Azure, GCP) | Provider controls | Startups, non-sensitive apps | Lowest control |
| **Private Cloud** | Your own data center, cloud-like tools ([[OpenStack]], [[Proxmox]]) | You control | Large enterprises, compliance-heavy | Highest control |
| **Hybrid Cloud** | Mix of public + private | Split control | Burst traffic, gradual migration | Balanced |
| **Community Cloud** | Shared by multiple organizations (e.g., healthcare consortiums) | Shared | Industry-specific workloads | Moderate |

**Network Implications:**
- **Public Cloud:** Rely on [[WAF|Web Application Firewalls]], [[DDoS]] protection, encryption
- **Private Cloud:** Manage your own [[firewall|firewalls]], [[IDS/IPS]]
- **Hybrid Cloud:** VPN ([[site-to-site VPN]]) or [[AWS Direct Connect|Direct Connect]] bridges on-premises to cloud

---

### On-Premises vs. Cloud (Exam Topic 1.2.f)

| Aspect | On-Premises | Cloud |
|--------|---|---|
| **CapEx** | High upfront | Low—pay monthly |
| **Scalability** | Limited by hardware purchases | Instant elasticity |
| **Maintenance Burden** | Your team 24/7 | Provider handles it |
| **Compliance Control** | Full control | Dependent on provider's certifications ([[SOC 2]], [[HIPAA]], etc.) |
| **Network Design** | Direct control of every switch/router | Limited—use provider's abstractions (VPC, subnets) |
| **Latency** | Predictable (local) | Depends on region/distance |

---

## Lab Relevance

### Cisco IOS Commands (VRF Focus)

#### Create and configure VRF
```
Router(config)# vrf definition MY-VRF
Router(config-vrf)# rd 65000:1
Router(config-vrf)# route-target export 65000:1
Router(config-vrf)# route-target import 65000:1
```

#### Assign interface to VRF
```
Router(config)# interface GigabitEthernet 0/0/0
Router(config-if)# ip vrf forwarding MY-VRF
Router(config-if)# ip address 10.0.0.1 255.255.255.0
Router(config-if)# no shutdown
```

#### View VRF

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 17 | [[CCNA]]*