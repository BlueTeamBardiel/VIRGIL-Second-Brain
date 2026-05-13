# Internet Connection Types

## What it is

Your house has one pipe to the internet. That pipe is one of six or seven physical things: a fiber strand, a coax cable, a phone line, a cellular antenna, a satellite dish, or a fixed-wireless radio on the roof. Each one has a different ceiling, a different floor, and a different failure mode. The router doesn't care — it just speaks Ethernet to whatever modem is on the other side. You care, because the pipe is what's between your raid group and a 200ms ping spike.

**Plain English:** an internet connection type is the last-mile technology — the physical medium and signaling that carries IP traffic from your house to your ISP's edge. Network types (LAN, WAN, PAN, MAN, WLAN, SAN) are the *scope* of the network: how big it is and what it's for.

**Technical:** the connection type defines Layer 1 (medium) and Layer 2 (framing/encoding) between the customer premises and the ISP head-end. The network type categorizes the topology by physical scope and purpose — a building, a city, a continent, or a storage fabric.

## Why it matters

Every helpdesk ticket about "internet is slow" eventually traces back to one of two things: the LAN inside the house, or the WAN link leaving it. You have to know which is which by the symptom, before you ever touch the modem. CompTIA tests this directly in **Objective 220-1201 2.7** — they want you to identify the connection type from a description (latency, medium, typical speeds) and distinguish LAN/WAN/MAN/PAN/WLAN/SAN by scope and purpose.

In your career, this knowledge follows you out of the helpdesk and into network admin, sysadmin, and security work. A SAN failure looks nothing like a WAN failure. A WLAN problem and a LAN problem live on the same cable but have completely different root causes. Get the vocabulary right and the troubleshooting gets easier.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Six connection types matter for the exam:

- **Fiber** — light through glass. 1 Gbps symmetric is the floor now; 2–10 Gbps is common. Sub-10ms latency. Immune to EMI. The gold standard.
- **Cable (DOCSIS)** — coax, shared with the neighborhood. DOCSIS 3.1 hits 1+ Gbps down but uploads are asymmetric (often 35–50 Mbps). Latency 15–40ms. Speeds dip when the neighborhood comes home from work.
- **DSL** — twisted-pair copper, the same wires as the old landline. ADSL2+ tops out around 24 Mbps down. VDSL2 can push 100 Mbps if you're close to the DSLAM. Distance-sensitive — every foot from the central office costs you bandwidth.
- **Cellular** — 4G LTE gives you 10–50 Mbps real-world; 5G mid-band runs 100–500 Mbps; 5G mmWave can break a gigabit but only with line of sight. Latency 20–50ms. Subject to congestion and tower load.
- **Satellite** — geostationary (HughesNet, Viasat) sits 35,000 km up — 600ms+ latency, brutal for gaming. LEO constellations (Starlink) sit at ~550 km — 25–50ms latency, 100–300 Mbps. The LEO change is why satellite is on the exam now.
- **Wireless internet service (WISP / fixed wireless)** — point-to-point radio from a tower to a dish on your house. Rural/exurban play. 25–100 Mbps typical, line of sight required.

**Beat 2 — Feynman example via gaming build.** You just finished a $2,500 gaming PC. 4070 Super, Ryzen 7 9800X3D, 32GB DDR5. You boot up *Marvel Rivals* and your shots aren't registering.

**The fiber friend:** 18ms ping, 940 Mbps down, 940 up. Game feels instant. Stream to Discord while playing, no hitch. *The pipe is bigger than anything you can do with it.*

**The cable friend:** 28ms ping most of the time. Saturday at 8 PM, ping spikes to 90ms because the whole neighborhood is streaming Netflix. Upload is 35 Mbps so OBS at 6 Mbps to Twitch is fine, but two streams kill it. *Asymmetric bandwidth is the cable tax.*

**The DSL friend:** 45ms ping, 18 Mbps down, 1.5 Mbps up. Game playable, voice chat fine, but a Steam update during the match drops everyone in the lobby to 200ms. *No headroom — every background task is felt.*

**The Starlink cousin in Montana:** 38ms ping, 180 Mbps down. Plays fine, until a snowstorm drops the dish for ten minutes. *LEO satellite finally made gaming over satellite a real thing — but weather is still weather.*

**The geostationary holdout:** 650ms latency. Can't play anything competitive. Period. *Don't game over GEO sat.*

**Beat 3 — Bridge from gaming to enterprise.** Same question — *what's the pipe?* — different stakes.

At home, you pick the connection that fits your gameplay and budget. At a small business, the IT admin is choosing between a 1 Gbps fiber line for $400/month and a cheaper cable line, and the question is "can the office of 25 survive a four-hour cable outage?" The answer is usually no, so they buy fiber as primary and a 5G cellular failover modem as backup — when the fiber cut happens (and it will, because somebody's always digging), the firewall fails over to LTE and the office keeps working at degraded speed.

At a regional headquarters, the WAN link is dual-fiber from two different carriers entering the building from two different sides — diverse paths, BGP failover, an SLA with teeth. Plus a 5G backup. Plus sometimes a Starlink dish for emergencies.

**Beat 4 — The point.** Same fundamental question — what's the pipe, what's the backup, what happens when it fails — different workloads, different right answers. Home user wants gaming latency. Office wants uptime. Enterprise wants uptime *with contractual penalties when the carrier misses it.* Get this question into your bones — you'll ask it for the rest of your career.

## Key facts

### Connection types — the comparison table

| Type | Medium | Typical speed | Latency | Where it lives |
|---|---|---|---|---|
| **Fiber** | Glass strand | 1–10 Gbps symmetric | 5–10ms | Cities, suburbs, modern buildouts |
| **Cable** | Coax (DOCSIS) | 100–1000 Mbps down / 35–50 up | 15–40ms | Suburbs, anywhere with cable TV |
| **DSL** | Twisted pair (phone line) | 10–100 Mbps | 20–60ms | Anywhere phone service exists; distance-limited |
| **Cellular** | RF (LTE/5G) | 10–500 Mbps | 20–50ms | Anywhere with tower coverage |
| **Satellite (GEO)** | RF to 35,000 km orbit | 25–100 Mbps | 600ms+ | Truly remote; legacy |
| **Satellite (LEO)** | RF to ~550 km orbit | 100–300 Mbps | 25–50ms | Rural, mobile, maritime |
| **WISP / fixed wireless** | RF point-to-point | 25–100 Mbps | 20–40ms | Rural, line of sight to tower |

### Network types — by scope

- **PAN (Personal Area Network)** — Bluetooth headphones, AirDrop, your phone tethering to your watch. ~10m range.
- **LAN (Local Area Network)** — your house, an office floor. Wired Ethernet, switches, one broadcast domain. Building-scale.
- **WLAN (Wireless LAN)** — same scope as LAN, but Wi-Fi. The 802.11 standards. Often runs alongside the wired LAN — same network, different access medium.
- **MAN (Metropolitan Area Network)** — a city. Municipal fiber rings, university campus networks spanning multiple buildings, a hospital system across town.
- **WAN (Wide Area Network)** — connects LANs across geography. The internet is the largest WAN. A company linking its New York office to its Tokyo office over MPLS or SD-WAN is running a private WAN.
- **SAN (Storage Area Network)** — high-speed dedicated network for block-level storage. Fibre Channel or iSCSI, separate fabric from the production LAN. Servers see SAN volumes as if they were local disks. *This is not internet — it's an internal storage fabric.*
- **Wireless Internet Service** — generic term for ISPs delivering internet via wireless (cellular, WISP, satellite). Distinct from WLAN — WLAN is your *local* wireless; wireless internet is your *uplink* wireless.

### CompTIA exam traps

> **CompTIA exam trap:** *WLAN vs Wireless Internet Service.* WLAN is your home Wi-Fi — local network, 802.11. Wireless internet service is your ISP delivery method — cellular, satellite, fixed wireless. The exam will hand you a scenario and want you to pick the right term. WLAN = inside your building. Wireless internet = how your building reaches the ISP.

> **CompTIA exam trap:** *SAN is not WAN.* SAN = Storage Area Network, internal, block-level storage fabric, often Fibre Channel. WAN = Wide Area Network, geographic, IP routing. Different acronyms, completely different jobs. Easy point if you don't panic.

> **CompTIA exam trap:** *Cable speeds are asymmetric, fiber is symmetric.* If a question says "1 Gbps down, 35 Mbps up," that's cable. If it says "1 Gbps down, 1 Gbps up," that's fiber. CompTIA loves this distinction.

> **CompTIA exam trap:** *Satellite latency depends on orbit.* GEO = 600ms+ (terrible for gaming/VoIP). LEO = 25–50ms (acceptable). If a question mentions Starlink-style service or "low earth orbit," expect normal-feeling latency. If it says "geostationary," expect the lag.

### Consumer vs. enterprise

**At home:** one ISP, one modem, one connection type. If the cable goes out, you tether your phone and grumble. The router is the demarcation point — what's in front of it is the ISP's problem.

**In the enterprise:** *this changes.* A real office has dual WAN links from two different carriers, often two different connection types (fiber primary + cellular backup, or two fiber providers entering on opposite sides of the building). The firewall handles failover. There's an SLA — a contract specifying uptime, latency, and packet loss thresholds, with credits owed when the carrier misses them. SD-WAN appliances aggregate multiple links and route traffic intelligently across them. The SAN runs on its own fabric, often dual-switched for redundancy. Large enterprises run private WANs (MPLS, SD-WAN overlays) between sites, treating the public internet as a fallback rather than the primary path.

The home user thinks "internet is one wire." The enterprise treats every link as a contract, every link as fallible, and every site as needing a backup path.

## Helpdesk reality

- *"My internet is slow."* — First question: wired or wireless? If wireless, you might be debugging WLAN (their Wi-Fi), not WAN (their ISP). Different problem entirely.
- *"Is the internet down?"* — Have them check if other devices work. One device down = LAN/device problem. All devices down = WAN/ISP problem. This single question saves twenty minutes.
- *"Why is my upload so slow?"* — If they're on cable, that's the connection type. Not broken. Asymmetric is the deal. Explain it once, document it in the ticket.
- *"Starlink keeps dropping during storms."* — LEO satellite is line-of-sight RF. Heavy precipitation attenuates the signal. There's no fix beyond moving the dish or accepting it. Don't promise a fix you can't deliver.
- *"We need internet at the new branch office."* — Not your call alone. Someone in IT leadership picks the connection type based on what's available at the address, the budget, and the SLA needs. Your job is to know the trade-offs well enough to contribute to the conversation.

## Related concepts

[[Networking Hardware]] · [[TCP and UDP Ports]] · [[Wireless Networking Standards]] · [[SOHO Network Configuration]] · [[Network Troubleshooting]] · [[Cable Types and Connectors]] · [[OSI Model]]

*Source: VIRGIL knowledge base — 2026-05-10*