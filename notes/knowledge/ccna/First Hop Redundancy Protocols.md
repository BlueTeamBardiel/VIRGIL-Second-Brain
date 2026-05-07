# First Hop Redundancy Protocols

## What it is

In Apex Legends, when your squad's jumpmaster gets knocked, someone else instantly takes over — the squad keeps moving, the role just transfers. FHRP does the same thing for your default gateway. Your laptop knows about exactly one gateway IP (say, 10.0.0.1), but behind that single IP is a tag-team of physical routers ready to swap in the moment one drops.

The trick: FHRP fabricates a **virtual IP address** and a **virtual MAC address** that float between routers. Hosts ARP for the gateway, get the virtual MAC, and have no idea which physical box is actually answering. One router is "active" (or "master") and forwards the traffic. The others are watching, listening for hello messages, and waiting to take over if the heartbeat stops.

The three flavors you'll meet:
- **HSRP** — Cisco's proprietary one (Active/Standby)
- **VRRP** — the open standard (Master/Backup)
- **GLBP** — Cisco's load-balancing one (multiple forwarders at once)

## Why it matters

Without FHRP, your default gateway is a single point of failure. If the router dies, every device on that subnet is stranded — like a Helldivers 2 squad whose only Pelican pilot just disconnected. You could manually reconfigure every host with a new gateway, but at that point the outage already happened.

FHRP makes failover automatic and (mostly) invisible. The catch is "mostly" — convergence isn't instant. During the swap, ARP caches may go stale, packets get queued or dropped, and depending on the protocol you're looking at anywhere from sub-second to 10+ seconds of pain. Choosing between HSRP, VRRP, and GLBP is really choosing between vendor lock-in, failover speed, and whether you want one router doing all the work or several sharing the load.

## Key facts

**Universal mechanics**
- Virtual gateway IP is shared across multiple physical routers; hosts only ever see the virtual IP.
- Virtual MAC is synthesized — not the burned-in MAC of any physical router.
- Active/master router sends periodic **hello messages**; standbys assume it's dead after missing them.
- Failure detection typically takes ~3× the hello interval (the dead timer).
- During switchover, ARP entries may go stale and packets may be queued or dropped.

### HSRP (Hot Standby Router Protocol)
Like a CS2 IGL with a designated backup caller — only the IGL talks, the backup just listens until needed.
- **Cisco proprietary**, loosely documented in RFC 2281.
- **Active/Standby** model — exactly one active router forwards traffic.
- Priority range **0–255**, default **100**. Higher wins.
- Virtual MAC format: **0000.0C07.AC**xx (xx = group number).
- HSRPv1 groups: **1–255**. HSRPv2 groups: **1–4095**.
- Default hello: **3 seconds**. Default dead/hold: **10 seconds**.
- Convergence: roughly **6–10 seconds** (sub-second possible if you crank timers — but only HSRPv2 supports sub-second hellos).
- **Preemption is OFF by default** — a higher-priority router coming back online won't steal the active role unless you explicitly turn it on.
- Preempt delay lets you configure a minimum wait after boot before preempting (so a router that just rebooted doesn't yank the role before its routing table converges).
- MD5 authentication supported in HSRPv2.

### VRRP (Virtual Router Redundancy Protocol)
The vendor-neutral one — works on Cisco, Juniper, Arista, your homelab's pfSense box, whatever.
- **Open standard** — RFC 3768 (VRRPv2). VRRPv3 in RFC 5798/5568 adds IPv6 support.
- **Master/Backup** model — one master forwards.
- Priority range **1–254**, default **100**.
- Virtual MAC format: **0000.5E00.01**xx (xx = group/VRID).
- Default hello: **1 second**. Default dead: **3 seconds** — much more aggressive than HSRP out of the box.
- Convergence: roughly **3 seconds**.
- **Preemption is ON by default** — opposite of HSRP. Highest priority always wins.
- Backup routers can **learn timing parameters from the master** instead of being statically configured.
- MD5 authentication supported.

### GLBP (Gateway Load Balancing Protocol)
HSRP and VRRP only let one router work at a time — the others sit on the bench. GLBP is more like an Overwatch team comp where multiple DPS can frag simultaneously. All routers forward traffic at once.
- **Cisco proprietary**.
- Uses an **Active Virtual Gateway (AVG)** — the one router that runs the show: assigns virtual MACs, answers ARPs.
- Uses **Active Virtual Forwarders (AVFs)** — multiple routers each owning a different virtual MAC, all actively forwarding.
- Multiple virtual MACs per group enables real load balancing — the AVG hands out different MACs to different hosts.
- Virtual MAC format: **0000.07AC.**xxxx (with the forwarder number embedded).
- Priority range **1–255**, default **100**.
- Default hello: **3 seconds**. Default dead: **10 seconds**.
- **Load balancing modes:**
  - **Round-robin** — cycle through AVFs evenly per ARP request.
  - **Weighted** — distribute based on configured weight (heavier router, more traffic).
  - **Host-dependent** — same host always gets the same MAC (deterministic, based on ARP replies — good for sticky sessions).
- AVG failure → re-election of a new AVG.
- AVF failure → AVG reassigns that virtual MAC to another forwarder.
- MD5 authentication supported.

### Quick comparison
| | HSRP | VRRP | GLBP |
|---|---|---|---|
| Standard | Cisco | Open (RFC) | Cisco |
| Model | Active/Standby | Master/Backup | AVG + multiple AVFs |
| Hello / Dead | 3s / 10s | 1s / 3s | 3s / 10s |
| Preemption default | Off | On | — |
| Load balancing | No | No | Yes |

## Related concepts
[[Default Gateway]]
[[ARP and Gratuitous ARP]]
[[Spanning Tree Protocol]]
[[Layer 3 Switching]]
[[VLANs and SVIs]]
[[Routing Convergence]]
[[High Availability Design]]
[[MD5 Authentication]]