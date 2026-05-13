# Networking Devices

## What it is

In **Super Mario Bros. 3**, the world map isn't one continuous level — it's a network. Each world has stages connected by paths, Toad Houses hand out items, Hammer Bros. roam the overworld blocking routes, the warp whistle skips you across the map entirely, and Bowser's castle sits behind a guarded door at the end. Every node has a job. The Toad House hands out resources. The fortress gates traffic. The whistle is an encrypted tunnel that bypasses everything between you and your destination. That's exactly what networking devices do — each one is a specialized node on the map, and the packet is Mario navigating between them.

In N10-009 terms, **networking devices** (or appliances) are the physical or virtual systems that move, filter, store, translate, secure, and serve data across a network. Each device operates at a specific OSI layer and performs a specific function. The exam wants you to know what each device does, where it sits in the stack, and when to recommend one over another.

## Why it matters

Every network ticket you'll ever touch involves at least one of these devices misbehaving. A user can't reach the file server — is it the **switch**, the **router**, the **firewall**, or DNS? A web app is slow — **load balancer** misconfigured, **CDN** cache miss, or **QoS** policy starving it? Remote workers can't connect — **VPN** concentrator down, **access point** dropping clients, or **proxy** blocking the URL?

Objective 1.2 is the foundation of the entire exam. Domains 2, 4, and 5 all assume you can name these boxes and explain their function on demand.

## Key facts

### Physical vs virtual appliances

A **physical appliance** is a dedicated hardware box — a Cisco Catalyst switch, a Palo Alto firewall. Vendor-locked, purpose-built ASICs, fast, expensive, and you have to ship it somewhere when it dies.

A **virtual appliance** is the same function delivered as a VM or container image — pfSense as a VM, a virtual F5, a cloud-native firewall in AWS. Runs on a [[hypervisor]] or in public cloud. Cheaper to scale, faster to deploy, sharing underlying hardware.

**Applications** here means software-delivered network services — a [[DNS]] server on Linux, a [[DHCP]] service on Windows Server, a [[RADIUS]] server in a container. Just a service binding to a port.

> **CompTIA exam trap:** "Appliance" usually means a dedicated single-purpose device (physical or virtual). "Application" means a service on a general-purpose server. If the question asks which is "easier to scale horizontally," the answer is virtual appliance or application — physical boxes don't scale, they get replaced.

### Layer 2: Switches

A **[[switch]]** forwards Ethernet frames inside a single broadcast domain based on MAC address. It builds a MAC address table by watching source MACs on each port. Full-duplex, dedicated bandwidth per port.

- **Unmanaged** — plug and play, no config, no VLANs. SOHO gear.
- **Managed** — supports [[VLANs]], [[STP]], port mirroring, SNMP, 802.1X. Enterprise gear.
- **Multilayer (Layer 3) switch** — routes between VLANs in hardware. Faster than a router for east-west traffic in a data center.

Switches are the **capillaries** of the network — high-volume, short-haul, getting frames to the actual hosts.

### Layer 3: Routers

A **[[router]]** forwards packets between different networks based on destination IP. Builds a routing table from directly connected interfaces, static routes, and dynamic protocols ([[OSPF]], [[EIGRP]], [[BGP]], RIP). Every interface is its own broadcast domain.

Routers are the **heart** — they pump packets between segments. When a router fails, that segment is cut off.

Routers also handle **[[NAT]]**, **[[ACLs]]**, and on SOHO units integrate DHCP, DNS forwarding, Wi-Fi, and a basic firewall into one box.

### Firewalls

A **[[firewall]]** decides what traffic crosses a boundary. Sits between trust zones — Internet/DMZ/LAN, or between VLANs.

- **Stateless** — evaluates each packet in isolation. Fast, dumb, mostly historical.
- **Stateful** — tracks connection state. The baseline modern firewall.
- **[[Next-generation firewall (NGFW)]]** — application awareness, user identity, deep packet inspection, integrated IDS/IPS, TLS inspection.
- **[[UTM]]** — firewall + IDS/IPS + AV + content filter + VPN in one appliance. Common in SMB.

The firewall is the **immune system** — decides what's foreign and stops it at the boundary.

### IDS / IPS

An **[[Intrusion Detection System (IDS)]]** watches traffic and **alerts**. Passive, out-of-band, fed by a SPAN port or network TAP.

An **[[Intrusion Prevention System (IPS)]]** **blocks** inline. Active, in the traffic path, drops malicious packets before they reach the target.

*IDS reports the burglar. IPS tackles them.* If the answer is "detected and logged," that's IDS. If it's "blocked in real time," that's IPS.

### Load balancer

A **[[load balancer]]** distributes incoming connections across a pool of backend servers. Operates at Layer 4 (TCP/UDP, port-based) or Layer 7 (HTTP/HTTPS, can route on URL, cookie, header).

Algorithms: round-robin, least connections, weighted, source IP hash. Health checks pull dead backends out automatically. Modern load balancers also terminate TLS, offloading crypto from app servers.

It's **matchmaking** — distributing players across game servers so no single instance melts.

### VPN

A **[[VPN]]** tunnels traffic encrypted across an untrusted network.

- **Site-to-site** — two firewalls/routers build a permanent encrypted tunnel between offices.
- **Client-to-site (remote access)** — laptop runs a client (AnyConnect, GlobalProtect, WireGuard) into the corporate network.
- **Protocols** — [[IPsec]] (Layer 3, the workhorse), [[SSL/TLS VPN]] (Layer 7, browser-friendly), WireGuard (modern, fast, UDP).

VPN is a **diplomatic pouch** — encrypted, trusted, routed through hostile territory.

### Proxy

A **[[proxy server]]** sits between clients and external servers, making requests on the client's behalf.

- **Forward proxy** — in front of clients going out. Content filtering, caching, user tracking, hiding internal IPs.
- **Reverse proxy** — in front of servers receiving inbound traffic. Hides backend topology, terminates TLS, caching, load balancing. NGINX, HAProxy, Cloudflare.

> **CompTIA exam trap:** Forward proxy protects the **client**. Reverse proxy protects the **server**. "Filtering employee web browsing" = forward. "Protecting web servers from direct exposure" = reverse.

### CDN

A **[[Content Delivery Network (CDN)]]** is a globally distributed network of cache servers — Cloudflare, Akamai, Fastly, CloudFront. Static content is replicated to edge nodes near users. Your request hits the nearest edge, not the origin.

CDNs cut latency, absorb DDoS, reduce origin bandwidth costs. Patch night for any modern game is a CDN doing its job.

### QoS

**[[Quality of Service (QoS)]]** prioritizes certain traffic on a congested link. Voice and video get priority (low latency, low jitter tolerance). Bulk backup gets deprioritized.

Mechanisms: **DSCP** marking (Layer 3 in the IP header), **CoS** (Layer 2 in the 802.1Q tag), traffic shaping, policing, priority queuing.

*The household rule that says voice from the Xbox beats the smart fridge's firmware update.* Without QoS, VoIP craters first.

### TTL

**[[Time to Live (TTL)]]** is a field in the IP header decremented by every router that forwards the packet. When TTL hits zero, the router drops the packet and sends back ICMP Time Exceeded. Prevents routing loops from melting the Internet.

`traceroute` works by sending packets with TTL=1, then 2, then 3, collecting ICMP responses to map the path. TTL is also reused in DNS to mean cache expiration — same word, different mechanism.

> **CompTIA exam trap:** Default TTL varies by OS — Windows 128, Linux/Mac 64, Cisco IOS 255. The exam may show a ping output and ask which OS the host is running based on the TTL subtracted from one of those defaults.

### NAS vs SAN

**[[Network Attached Storage (NAS)]]** is file-level storage — Synology, QNAP, TrueNAS. Clients access it via [[SMB]], [[NFS]], or AFP. Looks like a network drive.

**[[Storage Area Network (SAN)]]** is block-level storage — the host sees the SAN volume as a raw disk. Uses [[Fibre Channel]], [[iSCSI]], or FCoE. Expensive, fast, dedicated storage network. Used for VM datastores and databases.

> **CompTIA exam trap:** NAS = files over the network. SAN = blocks over a dedicated storage network. "Presents as a local disk to the server" = SAN. "Users map a network drive" = NAS.

### Wireless: APs and controllers

A **[[wireless access point (AP)]]** bridges Wi-Fi clients to the wired network. Layer 2 device. In SOHO, integrated into the router. In enterprise, separate ceiling-mounted units.

- **Autonomous (fat) AP** — standalone, configured individually. Doesn't scale.
- **Lightweight (thin) AP** — receives config from a central controller. Enterprise standard.

A **[[wireless LAN controller (WLC)]]** centrally manages dozens to thousands of lightweight APs. Pushes SSID config, handles roaming, coordinates channel selection and power, enforces security policy.

### CompTIA exam traps

> **Router vs Layer 3 switch:** Both route. The router has more interface types (serial, fiber WAN) and advanced features (NAT, complex ACLs, VPN termination). The L3 switch routes between VLANs at wire speed but is usually Ethernet-only. Inside a building? L3 switch. Between buildings or to the Internet? Router.

> **Hub vs switch vs router:** Hub = Layer 1, repeats every bit to every port (gone from real networks, alive on the exam). Switch = Layer 2, forwards by MAC. Router = Layer 3, forwards by IP.

## Helpdesk reality

- User says "the internet is down" — check the link light on their switch port first. 60% of "internet down" tickets are an unplugged or damaged cable. Layer 1 always.
- User can reach internal but not external — DNS, default gateway, firewall. In that order.
- "The Wi-Fi is slow in the conference room" — check the AP in the controller dashboard. Likely channel interference, client overload, or the AP fell back to a 100 Mbps uplink.
- Never promise "five minutes" on a firewall rule change. The answer is always "by end of day, pending approval."
- If you've verified IP, gateway, DNS, and the cable — escalate to the network team with your evidence, not your guess.

## Related concepts

[[OSI Model]] · [[VLANs]] · [[NAT]] · [[DHCP]] · [[DNS]] · [[Firewall Rules and ACLs]] · [[Wireless Standards]] · [[Routing Protocols]] · [[Subnetting]] · [[Network Topologies]] · [[High Availability]]

*Source: VIRGIL knowledge base — 2026-05-11*