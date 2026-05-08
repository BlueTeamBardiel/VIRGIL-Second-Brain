# Virtualization and Cloud Computing

## What it is

In Forza, you don't actually own a McLaren or a Lamborghini — Turn 10's servers do. You pick one from the garage, drive it for a race, and the car snaps back into the shared collection when you're done. That's exactly what virtualization and cloud computing do — one expensive piece of hardware gets sliced up and handed out to whoever needs it, on demand. Virtualization is the slicing. Cloud computing is the renting.

At the core sits the **hypervisor**: software that multiplexes one physical machine's CPU, RAM, disk, and NIC across multiple guest operating systems that each think they own the place. It's the race director assigning track time, fuel, and tire allocation to every driver simultaneously, while each driver believes they have the circuit to themselves.

Two flavors:

- **Type 1 (bare-metal)** — runs directly on the hardware, no host OS underneath. The hypervisor *is* the OS, the way the Xbox firmware is the only thing standing between Forza and the silicon. VMware ESXi and Microsoft Hyper-V live here. Less overhead, more performance.
- **Type 2 (hosted)** — runs as a regular application on top of a normal OS. Like launching Forza Horizon on a Windows PC where the OS is still managing your Discord, your browser, and seventeen Chrome tabs underneath. Oracle VM VirtualBox is the classic example. Easier on a laptop, but you pay a tax for the host OS sitting in the middle.

**Containers** are the lighter cousin. Instead of virtualizing the entire machine down to fake hardware, containers share the host's OS kernel and only package the app plus its dependencies. A VM is a full car build — chassis, engine, drivetrain, paint job, the works (10+ GB). A container is a tune file (10–100 MB) that snaps onto a base car everyone already has. Docker authors the tunes; Kubernetes is the team principal that deploys them across a fleet, scales them up for race day, and respawns the ones that crash.

**Cloud computing** takes all of this — hypervisors, VMs, containers, virtual networking — and wraps it in a self-service billing portal you can hit from a browser.

## Why it matters

Before virtualization, every workload meant buying another physical box, racking it, cabling it, and watching it idle at 8% CPU. Now one server runs forty workloads and the finance team stops crying. Before cloud, scaling for a traffic spike meant ordering hardware that arrived six weeks after the spike ended. Now you click a slider.

For a network engineer specifically: the "switch" your VM connects to isn't a switch you can touch. It's a virtual switch inside a hypervisor. The "NIC" isn't a NIC — it's a vNIC. Half the troubleshooting surface lives in software now, and if you don't understand the abstractions, you can't debug them.

For security: shared infrastructure means your tenant noise lives next to someone else's tenant noise. Isolation isn't a wall, it's a configuration — and misconfigurations are how cloud breaches happen.

## Key facts

### Hypervisors and virtual hardware

- **Type 1 vs Type 2 efficiency**: Type 1 wins because there's no host OS stealing cycles. It's the difference between a dedicated PS5 and emulating a PS5 inside Windows.
- **Virtual NIC (vNIC)**: software interface that replaces a physical NIC, one per VM. Each VM thinks it has a real Ethernet card; the hypervisor is faking it.
- **Virtual switch (vSwitch)**: hypervisor-managed switching fabric that forwards frames between vNICs and out to the physical NICs. Same Layer 2 logic as a real switch, just running as code.

### Containers vs VMs

- **VM**: 10+ GB, boots a full guest OS, can mix Windows and Linux on the same host.
- **Container**: 10–100 MB, shares the host kernel — so all containers on a host run on the *same* OS kernel. No mixing Windows containers and Linux containers on the same kernel.
- **Docker**: the platform that packages and runs Linux containers.
- **Kubernetes**: the orchestrator that schedules containers across many hosts, restarts dead ones, and scales them. Docker is the soldier; Kubernetes is Helldivers' Strategem map deciding where to drop them.

### VRF (Virtual Routing and Forwarding)

VRF is virtualization for routers. One physical router pretends to be many, each with its own routing table, its own interfaces, and its own routing protocol instances. Like running multiple separate save files in Elden Ring on the same console — same hardware, completely independent worlds.

- Traffic in one VRF cannot reach another VRF unless you explicitly leak routes between them.
- **Route Distinguisher (RD)**: unique ID for the VRF in `ASN:value` format. It tags routes so overlapping IP space (two tenants both using 10.0.0.0/24) doesn't collide.
- **Route Target (RT)**: controls which routes get *exported* out of one VRF and *imported* into another. The matchmaking rule for which tenants can talk.
- **MPLS VPNs** use VRFs as overlays on top of an MPLS backbone — that's how a service provider keeps Limbo Capital's traffic separate from Styx Networking's traffic over the same physical core.

Cisco config primitives:
- `vrf definition <name>` — create the VRF
- `rd <ASN:value>` — set the Route Distinguisher
- `route-target export <value>` — tag routes leaving this VRF
- `route-target import <value>` — accept routes tagged this way
- `ip vrf forwarding <name>` — bind a physical/logical interface into the VRF

### The five NIST cloud characteristics

Treat these as the checklist that separates "real cloud" from "we put a server in a colo and called it cloud":

- **On-Demand Self-Service**: spin up resources without filing a ticket. Like adding a friend in Discord — no admin approval needed.
- **Broad Network Access**: reachable from any device, anywhere. Phone, laptop, tablet, all the same.
- **Resource Pooling**: physical compute and storage shared across multiple tenants. Same apartment building, different units.
- **Rapid Elasticity**: scales up and down automatically with demand. Black Friday traffic? More instances. 3 AM? Fewer.
- **Measured Service**: metered and billed per use. Pay-per-use, like Uber surge pricing for compute.

### Service models — who manages what

- **IaaS** (Infrastructure as a Service): provider gives you VMs, storage, and networking. *You* manage the OS and apps. Renting an empty apartment.
- **PaaS** (Platform as a Service): provider manages OS and networking; you bring code and data. Runtime, databases, dev tools come included. Renting a furnished apartment.
- **SaaS** (Software as a Service): provider manages everything except your data. You just log in. Staying in a hotel — you don't even own the toothbrush.

### Deployment models

- **Public cloud**: third-party provider owns the infrastructure (AWS, Azure, GCP).
- **Private cloud**: your organization owns and controls it.
- **Hybrid cloud**: mix of both — sensitive workloads private, burstable workloads public.
- **Community cloud**: shared between multiple organizations with common requirements.

### On-prem vs cloud tradeoffs

- **CapEx vs OpEx**: on-prem = big upfront hardware purchase. Cloud = low entry, monthly bill that grows with usage.
- **Elasticity**: cloud scales instantly; on-prem is capped by whatever you bought.
- **Compliance**: on-prem gives you full control over certifications. Cloud means you inherit the provider's certs — **SOC 2**, **HIPAA**, and others.
- **VPC** (Virtual Private Cloud): your logically isolated network slice inside a public cloud provider. Your own subnet, routing, and security boundaries inside someone else's data center.

## Related concepts

[[Hypervisors]]
[[Docker and Containers]]
[[Kubernetes]]
[[MPLS VPN]]
[[VRF-Lite]]
[[Route Distinguisher and Route Target]]
[[Virtual Private Cloud (VPC)]]
[[NIST Cloud Computing Definition]]
[[IaaS PaaS SaaS]]
[[Software-Defined Networking]]
[[Network Function Virtualization (NFV)]]
[[Shared Responsibility Model]]