# Network Types

## What it is

Networks are how machines talk. The scale of "talk" is what defines the type. Two laptops sharing a printer in your living room is one kind of conversation. A bank in Frankfurt querying a database in Dallas is another. Same fundamental act — packets moving across a medium — radically different distance, latency, ownership, and cost.

In plain English: a **network type** is a label for the *scope* of a network (how big an area it covers, who owns it, what it carries), and an **internet connection type** is the *physical medium and service* you use to reach the public internet (fiber, cable, cellular, satellite, DSL).

Technically: network types are classified by geographic scope and purpose — PAN, LAN, WLAN, MAN, WAN, SAN. Internet connection types are classified by the last-mile transport — fiber-optic, coaxial cable, twisted-pair DSL, licensed cellular spectrum, or radio link to a satellite constellation. The two concepts overlap (a WAN often uses fiber; cellular creates a WAN) but the exam tests them as separate vocabulary.

The body metaphor: if the CPU is the brain and RAM is the workbench, the network stack is the **voice and ears**. Network types describe how far the voice carries — whisper distance, room distance, building distance, city distance, planet distance.

## Why it matters

Objective 220-1201 2.7 puts this on the exam directly, and CompTIA loves to test the boundary cases — *is a Bluetooth headset a PAN or a LAN? Is a fiber connection between two offices in the same city a MAN or a WAN?* Get the definitions clean and these questions are free points.

Career relevance: every helpdesk ticket that touches "the internet is slow" or "I can't reach the file server" hinges on knowing which network you're actually on, who owns it, and where the failure boundary is. Tier 1 techs who confuse LAN problems with WAN problems waste hours and escalate tickets that should have been closed in ten minutes. The vocabulary isn't academic — it's how you describe a problem to the person above you on the escalation ladder without sounding green.

## In your build, in the enterprise

**Beat 1 — technical depth.** Network types stack by scope. **PAN** is one person's bubble — Bluetooth, typically 10 meters, sometimes USB cable between two devices. **LAN** is a single building or floor, wired Ethernet, owned by you. **WLAN** is the same scope as a LAN but the medium is Wi-Fi (802.11). **MAN** spans a city — a university campus across town, a municipal fiber ring, a hospital network linking three buildings downtown. **WAN** is anything beyond that — branch offices in different cities, the public internet itself, MPLS circuits between data centers. **SAN** is the oddball — it's a dedicated high-speed network just for **block-level storage traffic**, usually Fibre Channel or iSCSI, isolated from the regular LAN so a backup job doesn't tank Outlook for everyone.

Internet connection types are a separate axis. **Fiber** is glass, light pulses, gigabit-and-up symmetric, lowest latency. **Cable** is coax, asymmetric (fast down, slow up), shared with the neighborhood. **DSL** is twisted-pair phone line, distance-sensitive, dying. **Cellular** is 4G LTE / 5G over licensed spectrum — the SIM card in your phone, also the failover modem in a branch office router. **Satellite** is radio link to a bird in orbit — geostationary (Viasat, HughesNet) means high latency (~600ms), LEO constellations (Starlink) drop that to ~30ms. **Wireless internet service** (WISP) is a fixed antenna on your roof pointed at a tower somewhere — common in rural areas where fiber and cable never came.

**Beat 2 — your homelab.**

**The PAN:** Your gaming headset pairs to your PC over Bluetooth. Your phone tethers via USB when the Wi-Fi drops. *That's a PAN — your personal bubble of devices, no infrastructure required.*

**The LAN and WLAN:** Your gaming rig is wired Cat6 to the router for low-latency ranked matches. Your laptop, phone, Switch, and smart bulbs are on Wi-Fi. Same network, two media. *Wired side is the LAN, wireless side is the WLAN — together they're your home network.*

**The WAN:** Your fiber ONT terminates in a closet, hands off Ethernet to your router, and from there everything outside your house is WAN. Steam downloads, Discord voice, the patch server in Dublin — all WAN traffic. *The router is the boundary. Inside is yours, outside is somebody else's problem.*

**The SAN you don't have:** Your NVMe drive is local. Your Plex library on a NAS is *file-level* (SMB/NFS) over the LAN — that's a NAS, not a SAN. *Home users don't run SANs. The distinction matters because the exam will try to trick you.*

**Beat 3 — bridge to enterprise.** Same scopes, different scale and ownership.

The PAN doesn't change much — Bluetooth keyboards and earbuds at desks. The LAN balloons: instead of one 8-port switch, you have stacked 48-port managed switches per floor, uplinked to core switches in the MDF, with VLANs separating finance from guest Wi-Fi. The WLAN runs on dozens of ceiling-mounted access points coordinated by a controller, not one consumer router in the living room.

The MAN is where home users have no equivalent. A hospital with three buildings across downtown runs dark fiber between them — that's a MAN, owned by the hospital (or leased from the city), carrying internal traffic that never touches the public internet.

The WAN at the enterprise is two things: the public internet (with redundant ISPs — primary fiber, backup cellular failover) and **private WAN circuits** (MPLS, SD-WAN overlays, site-to-site VPNs) connecting branch offices to HQ. A branch in Phoenix talking to the data center in Atlanta isn't going over the public internet if the company is serious — it's over a private WAN with QoS guarantees.

The SAN is the big enterprise-only beast. Your VMware cluster has 40 hosts. They all need to see the same storage to support live migration. That storage lives on an array (NetApp, Pure, Dell PowerStore) connected by **Fibre Channel** over dedicated FC switches, or **iSCSI** over a dedicated 10/25/100GbE network. The SAN never carries user traffic — it's a separate fabric. Mixing SAN traffic with LAN traffic is how you get backup jobs that take 14 hours and angry calls from finance at month-end close.

**Beat 4 — the point.** Same fundamental question across every build: *what's the scope of this conversation, and who owns the wire?* At home, the answer is "small, and me." At the enterprise, the answer fractures into six different network types because the scopes and ownership boundaries fracture. Get the scope question into your bones — every troubleshooting call starts with it, whether you realize it or not.

## Key facts

### Network types by scope

| Type | Scope | Typical use | Medium |
|---|---|---|---|
| **PAN** | ~10m, one person | Bluetooth headset, phone tether, smartwatch | Bluetooth, USB, NFC |
| **LAN** | Building/floor | Office wired network, home Ethernet | Cat5e/6/6a, fiber uplinks |
| **WLAN** | Building/floor | Office Wi-Fi, home Wi-Fi | 802.11 (2.4/5/6 GHz) |
| **MAN** | City / metro area | Campus network, municipal fiber, hospital system | Fiber, microwave |
| **WAN** | Multi-city, country, global | Branch-to-HQ, public internet, MPLS | Fiber, cellular, satellite |
| **SAN** | Datacenter | Block storage for VM clusters, databases | Fibre Channel, iSCSI |

### Internet connection types

| Type | Speed (typical 2026) | Latency | Notes |
|---|---|---|---|
| **Fiber** | 1–10 Gbps symmetric | ~5–15ms | Best option where available; future-proof |
| **Cable** | 300Mbps–2Gbps down / 20–100Mbps up | ~15–30ms | Shared coax, asymmetric, congestion at peak |
| **DSL** | 10–100 Mbps | ~25–50ms | Twisted pair, distance-limited, being retired |
| **Cellular (5G)** | 100Mbps–1Gbps | ~20–40ms | Mobile + fixed wireless + branch failover |
| **Satellite (LEO)** | 100–300 Mbps | ~30–50ms | Starlink-class; usable for real-time work |
| **Satellite (GEO)** | 25–100 Mbps | ~600ms | Viasat/HughesNet; unusable for VoIP/gaming |
| **WISP** | 25–100 Mbps | ~20–60ms | Roof antenna to tower; rural last-resort |

### SAN vs NAS — the trap CompTIA loves

- **NAS** (Network Attached Storage): file-level access (SMB, NFS), runs over the regular LAN, looks like a shared folder. Synology, QNAP, Windows file server.
- **SAN** (Storage Area Network): block-level access (Fibre Channel, iSCSI), runs on its own dedicated fabric, looks like a raw disk to the server. Enterprise-only.

A NAS is a *server* on a LAN. A SAN is a *network type* dedicated to storage.

### CompTIA exam traps

> **CompTIA exam trap:** WLAN vs Wi-Fi. WLAN is the **network type** (a wireless LAN). Wi-Fi is the **technology** that implements it (the 802.11 standards). On the exam, the answer for "what type of network is this?" is WLAN, not Wi-Fi.

> **CompTIA exam trap:** MAN vs WAN. If the question describes a network spanning *one city* or *one campus*, it's a MAN. If it spans multiple cities or it's the public internet, it's a WAN. CompTIA writes campus-fiber questions specifically to test this distinction.

> **CompTIA exam trap:** SAN vs NAS. SAN = block-level, dedicated fabric, datacenter. NAS = file-level, runs over the LAN, can be a $300 box in a closet. If the question mentions "shared folders" or "SMB," it's a NAS. If it mentions "Fibre Channel," "iSCSI," or "block storage," it's a SAN.

> **CompTIA exam trap:** Bluetooth is a PAN, not a LAN. Even if your headset and phone are "networked," the scope is personal — that's the defining characteristic.

> **CompTIA exam trap:** Satellite latency. Geostationary satellite has ~600ms latency because the signal has to travel ~36,000 km up and back. LEO (Starlink) is ~550 km up, hence ~30ms. If a question asks why VoIP doesn't work on satellite, the answer is latency from orbital distance.

## Helpdesk reality

- *"The internet is down."* — First question: is it the LAN or the WAN? Can other users in the building reach internal resources (file server, intranet)? If yes, it's a WAN/ISP issue, escalate to network team. If no, it's a LAN issue and you're chasing a switch, AP, or DHCP problem. This triage takes 30 seconds and saves 30 minutes.
- *"My Bluetooth keyboard stopped working."* — That's a PAN, not a LAN. The Wi-Fi outage they're also complaining about is unrelated. Treat them as two tickets.
- *"Why is the VPN slow from the hotel?"* — Hotel Wi-Fi is a WLAN you don't control, riding a WAN you don't control, terminating into your corporate WAN. Three networks, three potential failure points. Don't promise speeds.
- *"Can we just use the office Wi-Fi for the backup server?"* — No. Backups belong on the LAN (or a SAN if you're at scale). Pushing terabytes over Wi-Fi destroys the WLAN for everyone else and the backup will fail anyway.
- *"Starlink at the remote site — will VoIP work?"* — LEO satellite, yes, mostly. GEO satellite, no, the latency kills call quality. Confirm which constellation before quoting the customer.

## Related concepts

[[TCP-IP Protocols]] · [[IP Addressing]] · [[Wireless Standards 802.11]] · [[SOHO Routers]] · [[Network Cables and Connectors]] · [[Internet Appliances]] · [[VLANs]] · [[VPN]]

*Source: VIRGIL knowledge base — 2026-05-10*