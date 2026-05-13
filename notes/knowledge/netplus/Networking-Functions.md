# Networking Functions

## What it is

In **StarCraft**, a Terran base only works because every building does one job. The **Command Center** mints SCVs. **Supply Depots** raise the cap. **Barracks** train infantry. **Bunkers** absorb damage at the choke. **Missile Turrets** detect cloaked units. **Comsat** pings the fog. You don't build a Barracks expecting it to detect a Dark Templar — that's not its job. Stack the right buildings in the right positions and the base functions. Pull one out and a specific capability dies.

That's exactly what networking appliances are — a base layout of specialized devices, each with one job. Pull the firewall and you lose the wall at the choke. Pull the DNS server and nobody can find anything. Pull the switch and the LAN stops talking to itself.

**Technical definition:** Networking appliances and functions are the discrete devices, virtual instances, and software services that move, filter, store, translate, and accelerate traffic. N10-009 Objective 1.2 expects you to compare and contrast them — know what each does, where it sits in the OSI model, and what breaks when it fails.

## Why it matters

Every network ticket eventually traces back to one of these boxes. User says "internet is down" — you check the [[Router]], the [[Firewall]], the DNS resolver, the AP. Application is slow — you check the [[Load Balancer]], the [[CDN]], the [[QoS]] policy. The exam will give you a scenario ("users in the branch office can't reach the SaaS app") and expect you to name the appliance responsible. Mis-identify the function, mis-route the ticket, lose an hour.

Helpdesk knows what these boxes are. Network admins configure them. Architects decide which to deploy and where. The function vocabulary is the floor you stand on for everything above Net+.

## Key facts

### Physical vs virtual appliances

| Form factor | What it is | When you use it |
|---|---|---|
| **Physical** | Dedicated hardware, ASIC-accelerated | High throughput, deterministic latency, regulated environments |
| **Virtual** | Same software running as a VM | Cloud, lab, branch offices |
| **Cloud-native** | Function delivered as a service (AWS ELB, Cloudflare WAF) | Elastic scale, pay-per-use |

The function is the same. The packaging changes. A virtual firewall inspects packets the same way a physical one does — it's just sharing a CPU with twelve other VMs.

*Appliance ≠ function. The function is what matters on the exam. The box is just where it runs.*

### Router

**Layer 3.** Moves packets between IP networks using a routing table. Decrements [[TTL]] by one on every hop — when TTL hits zero, the packet is dropped and an ICMP Time Exceeded is returned (this is how `traceroute` works). Routers separate broadcast domains. Without a router, your LAN talks to itself but never to the internet.

### Switch

**Layer 2.** Forwards Ethernet frames based on MAC address. Builds a CAM table by learning which MAC lives on which port. Every port is its own collision domain; by default, all ports share one broadcast domain (until you carve it with [[VLAN]]s). A **multilayer switch** does Layer 3 routing in hardware — common in datacenter cores.

> **CompTIA exam trap:** Switch is L2, router is L3, multilayer switch is both. If the question says "routes between VLANs at wire speed," that's a multilayer switch. Routers route between networks; switches switch within one.

### Firewall

Filters traffic based on rules. Three generations matter:

- **Stateless / packet-filtering** — checks 5-tuple per packet. Fast, dumb.
- **Stateful** — tracks connection state. Knows return traffic for an established session is allowed without an explicit inbound rule.
- **Next-generation (NGFW)** — adds deep packet inspection, application awareness (block "Facebook" not just port 443), user identity, integrated IDS/IPS.

The firewall is the immune system at the perimeter. It is *not* an IDS. It blocks based on rules; it doesn't analyze for behavioral anomalies unless it's an NGFW with IPS modules on.

### IDS / IPS

| | **IDS** | **IPS** |
|---|---|---|
| Position | **Out-of-band** (SPAN, tap) | **In-line** |
| Action | Alerts, logs | Blocks, drops, resets |
| Failure mode | Misses the attack → you read about it Monday | False positive → blocks legit traffic → phone rings |

Detection: **signature-based** (known patterns) and **anomaly-based** (deviation from baseline). IDS is a Missile Turret that beeps when it sees a cloaked Wraith but doesn't shoot. IPS is the Turret that shoots.

### Load balancer

**Layer 4 or Layer 7.** Distributes incoming requests across a pool of backends. Methods: **round-robin**, **least connections**, **weighted**, **source IP hash** (session persistence). Provides health checks — pulls a dead backend out of rotation automatically. Often terminates TLS so backends don't have to.

*Without a load balancer, one popular service melts one server. With it, you scale horizontally and survive launch day.*

### Proxy

Sits between client and server and forwards requests on behalf of one side.

- **Forward proxy** — sits in front of clients. Content filtering, caching, anonymity. The web server thinks the proxy is the client.
- **Reverse proxy** — sits in front of servers. TLS termination, caching, load balancing, hiding backend topology. The client thinks the proxy is the server. (NGINX, HAProxy, Cloudflare.)

### CDN

Geographically distributed **edge servers** that cache static content close to users. When a game patch downloads at 200 MB/s, you're not pulling from the publisher's origin — you're pulling from a CDN node 40ms away. CDNs absorb DDoS, reduce origin load, cut latency.

*Patch night without a CDN would melt the origin. The CDN is why Steam survives a Counter-Strike update.*

### VPN

Encrypted tunnel over a public network.

- **Site-to-site** — two networks glued together with IPsec between their edge routers. Users don't know it exists.
- **Client-to-site** — single laptop tunnels into the corporate network. IPsec, SSL/TLS, or WireGuard.

A VPN is a diplomatic pouch through hostile territory. It's not zero trust — anyone with valid creds gets inside the perimeter.

### QoS

Prioritizes traffic when the link is congested. Marks packets with **DSCP** (L3) or **CoS / 802.1p** (L2). Voice and video get expedited forwarding; bulk transfers get best-effort. Without QoS, your Teams call and a file upload compete equally — and the call loses.

### TTL

A field in the IP header. Set by the source (Linux 64, Windows 128, Cisco 255), decremented by one at every L3 hop. Reaches zero → packet dropped, ICMP Time Exceeded returned. Prevents packets from looping forever on a broken routing table.

DNS also has a TTL — but that's a *cache lifetime* in seconds, telling resolvers how long to remember an answer.

> **CompTIA exam trap:** Two TTLs exist — IP header TTL (hop count, prevents loops) and DNS record TTL (cache duration in seconds). If the question mentions traceroute or routing loops, it's IP TTL. If it mentions cached records or propagation delay, it's DNS TTL.

### NAS vs SAN

| | **NAS** | **SAN** |
|---|---|---|
| Access | **File-level** (SMB, NFS) | **Block-level** (iSCSI, FC, FCoE) |
| Network | Regular IP LAN | Often dedicated storage fabric |
| Looks like to host | A network share | A locally attached disk |
| Use case | File shares, media, backups | Databases, VM datastores |

### Wireless: AP and Controller

- **Access Point (AP)** — L2 bridge between wireless clients and the wired network. An **autonomous AP** is configured individually. A **lightweight AP** receives config from a controller.
- **Wireless LAN Controller (WLC)** — centralized brain that manages dozens to thousands of lightweight APs. Pushes SSID config, channel assignments, power levels. Handles client roaming. Tunnels client traffic using CAPWAP.

*Without a controller, every AP is its own snowflake. With one, you push a config once and 400 APs update at lunch.*

### Applications running on the network

The exam also lumps in services delivered as software: **DNS**, **DHCP**, **NTP**, mail servers, web servers. Not appliances — network *functions* hosted somewhere. Can run on bare metal, a VM, or as cloud services. The function definition is what matters; the hosting is incidental.

### CompTIA exam traps

> **CompTIA exam trap:** Proxy direction. Forward = protects/serves *clients*. Reverse = protects/serves *servers*. Caching and TLS termination in front of a web farm = reverse. Content filtering for employees = forward.

> **CompTIA exam trap:** NAS is file-level (SMB/NFS), SAN is block-level (iSCSI/FC). "Appears as a local drive to the OS" = SAN. "Mounted as a network share" = NAS.

> **CompTIA exam trap:** IDS vs IPS hinges on placement. **Out-of-band = IDS** (only watches). **In-line = IPS** (can block). The question hides the answer in one phrase about where the device sits.

## Helpdesk reality

- User says **"the internet is down."** 80% of the time it's their cable, their Wi-Fi, or their DHCP lease. Check L1/L2 before you blame the [[Router]] or the [[Firewall]].
- User says **"the VPN is broken."** First check: is regular internet working? VPN issues mask DNS issues mask ISP issues. Layer the troubleshooting.
- User says **"the file share is slow."** Could be the [[NAS]], the switch uplink, [[QoS]] starving SMB, or — the boring answer — their Wi-Fi signal. Check the obvious before you blame the storage team.
- Never promise **"the load balancer will fix it."** Load balancers spread load; they don't fix broken backends. If every backend is sick, the LB just rotates them while they all fail.
- Escalation rule: if the client side is healthy (link light, DHCP lease, default gateway pings) and the issue is reproducible from multiple endpoints, it's a network-team ticket. Don't sit on it.

## Related concepts

[[OSI Model]] · [[Router]] · [[Switch]] · [[Firewall]] · [[Load Balancer]] · [[Proxy Server]] · [[CDN]] · [[VPN]] · [[QoS]] · [[IDS-IPS]] · [[NAS vs SAN]] · [[Wireless Access Point]] · [[Wireless LAN Controller]] · [[DNS]] · [[DHCP]] · [[VLAN]] · [[TTL]]

*Source: VIRGIL knowledge base — 2026-05-11*