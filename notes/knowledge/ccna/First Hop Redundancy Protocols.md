# First Hop Redundancy Protocols
**Tagline:** *Eliminate the single point of failure at your default gateway—ensure continuous network connectivity when routers fail.*

---

## Understanding FHRP Concepts

### The Problem: Single Point of Failure

Think of a default gateway like a bridge to the outside world. If that bridge collapses, everyone stuck on your side is isolated—even if alternative routes exist elsewhere. Traditionally, hosts configure a **single default gateway IP address**. When that physical router dies, the host has no automatic way to switch to a backup router, causing a complete network outage.

**The analogy:** Imagine a highway with one toll booth. If it breaks down, everyone stops, even though there's an identical toll booth 100 meters away. The drivers (hosts) don't know about the backup; they were told to always use booth #1.

**The solution:** [[First Hop Redundancy Protocols]] create a **virtual gateway IP address** that multiple physical routers share. Hosts point to this virtual IP (not a real router), and the routers negotiate among themselves about which one is currently "active" and forwarding traffic. When the active router fails, another seamlessly takes over—instantly, transparently, with zero host reconfiguration.

### How FHRP Works: Core Concepts

An [[FHRP]] allows multiple routers to present themselves as a single virtual router. Here's the mechanism:

1. **Virtual IP (VIP)** — A shared IP address that doesn't belong to any single physical router interface, but is claimed by whichever physical router is currently active.
2. **Virtual MAC address** — A fabricated MAC address associated with the virtual IP. Hosts in the VLAN learn this MAC (via [[ARP]]) and send frames to it, not to the real router MAC.
3. **Priority/Preemption** — Routers negotiate via hello messages; the one with highest priority becomes the **active router** or **master**. Lower-priority routers stand by.
4. **Hello/Dead timers** — Active router sends periodic "I'm alive" messages. If standby routers stop hearing hellos, they assume the active router is down and elect a new active router.
5. **Transparent Failover** — When switchover happens, the new active router immediately claims the virtual MAC and virtual IP; hosts' ARP entries don't stale, and traffic resumes.

### FHRP Neighbor Relationships

Before failover can work, routers running [[FHRP]] must discover and communicate with each other:

- **Discovery phase:** Routers on the same subnet/VLAN exchange hello packets (multicast in most protocols).
- **Election phase:** Using configured priority values (and tiebreakers), routers determine active/standby roles.
- **Steady state:** Active router sends periodic hellos; standby routers listen and verify the active router is healthy.
- **Convergence:** If active fails, a new active is elected within seconds.

### Failover Behavior

Failover timing and behavior vary by protocol:

| Aspect | Description |
|--------|-------------|
| **Detection time** | How long before standby detects active failure (typically 3× hello interval) |
| **Failover speed** | Time from detection to new active assuming traffic (sub-second to 3+ seconds) |
| **Preemption** | Whether a higher-priority standby can forcibly take over from a lower-priority active |
| **Client impact** | Temporary (< 1 sec) ARP timeout; packets queued/dropped during switchover |

---

## Comparing FHRPs

Three main [[FHRP]] protocols exist in the Cisco world, each with distinct characteristics:

### Hot Standby Router Protocol (HSRP)

**Overview:** Cisco proprietary (though loosely standardized in RFC 2281). The original FHRP, widely deployed in enterprise networks.

**Key mechanics:**
- **Active/Standby model** — One active, one or more standby routers.
- **Priority range** — 0–255 (default 100). Highest priority becomes active.
- **Preemption** — Disabled by default; if enabled, a newly configured higher-priority router seizes the active role (useful after maintenance).
- **Virtual MAC** — `0000.0C07.ACxx` where `xx` is the HSRP group number (1–255 in v1, 1–4095 in v2).
- **Hello interval** — 3 seconds (default); dead timer 10 seconds.
- **Convergence time** — ~6–10 seconds (hello sent, then 3× dead timer).

**Versions:**
- **HSRPv1** — Limited group numbers (0–255), smaller feature set.
- **HSRPv2** — Larger group numbers (0–4095), IPv6 support, better scalability.

**Strengths:**
- Well-understood, extensively deployed.
- Simple two-router (active/standby) model.
- Predictable behavior.

**Weaknesses:**
- Only one router is active; others are idle (bandwidth waste in multi-router setups).
- Slower convergence than [[RSTP]] or [[OSPF]] convergence.
- Proprietary (though RFC exists).

### Virtual Router Redundancy Protocol (VRRP)

**Overview:** Open standard ([[RFC 3768]]), similar to [[HSRP]] but not Cisco proprietary.

**Key mechanics:**
- **Master/Backup model** — Terminology differs from [[HSRP]]; one master (active), one or more backup.
- **Priority range** — 1–254 (default 100). Highest wins.
- **Virtual MAC** — `0000.5E00.01xx` where `xx` is the VRRP group ID (1–255).
- **Hello interval** — 1 second (default); dead timer 3 seconds. Faster than [[HSRP]] by default.
- **Convergence time** — ~3 seconds.
- **Preemption** — Enabled by default (differs from [[HSRP]]).
- **IPv6 support** — Built-in via [[VRRPv3]] ([[RFC 5568]]).

**Strengths:**
- Open standard; not Cisco proprietary.
- Faster hellos and failover (1-second default vs. 3-second [[HSRP]]).
- Preemption enabled by default (prevents unnecessary switchovers in stable networks).

**Weaknesses:**
- Less common in Cisco shops; may require vendor-neutral environments.
- Lower priority number = worse (opposite of [[HSRP]]; easy to misconfigure).

### Gateway Load Balancing Protocol (GLBP)

**Overview:** Cisco proprietary ([[RFC 3768]] loosely). Unique in allowing **multiple routers to forward traffic simultaneously** (active/standby + load balancing).

**Key mechanics:**
- **Active Virtual Gateway (AVG)** — One router manages the group and assigns virtual MAC addresses to other members (Active Virtual Forwarders, or AVFs).
- **Virtual IP** — Single shared IP, but **multiple virtual MACs** (one per AVF).
- **Load distribution** — Hosts in the VLAN receive different virtual MACs (via ARP replies), so traffic is distributed across multiple routers instead of concentrating on one.
- **Priority range** — 1–255 (default 100).
- **Hello interval** — 3 seconds; dead timer 10 seconds.
- **Convergence time** — ~6–10 seconds.
- **Preemption** — Configurable.

**How it works:**
1. AVG responds to ARP requests for the virtual IP, but rotates which virtual MAC it advertises.
2. Host A gets "use MAC-1" (router 1); Host B gets "use MAC-2" (router 2).
3. Traffic from A goes to router 1; traffic from B goes to router 2.
4. If AVG fails, one of the AVFs becomes the new AVG; if an AVF fails, AVG assigns its MAC to another AVF.

**Strengths:**
- **Utilizes all links** — No idle standby routers; bandwidth is fully utilized.
- **Automatic load balancing** — Clients transparently spread across multiple routers.
- **Graceful failover** — AVG failure triggers re-election; AVF failure triggers MAC reassignment.

**Weaknesses:**
- Most complex of the three; harder to troubleshoot.
- Cisco proprietary.
- Per-flow balancing (based on ARP replies) can lead to uneven distribution if ARP caches aren't refreshed frequently.
- Not suitable for all topologies (e.g., WAN link redundancy).

### FHRP Comparison Table

| Feature | HSRP | VRRP | GLBP |
|---------|------|------|------|
| **Standards** | RFC 2281; Cisco proprietary | RFC 3768 (v2), RFC 5568 (v3); open | Cisco proprietary |
| **Active model** | Active/Standby | Master/Backup | AVG/AVF (load-sharing) |
| **Priority range** | 0–255 | 1–254 | 1–255 |
| **Default hello** | 3 sec | 1 sec | 3 sec |
| **Preemption default** | Disabled | Enabled | Configurable |
| **Virtual MAC** | 0000.0C07.ACxx | 0000.5E00.01xx | 0000.07ACxx.xxxx |
| **IPv6 support** | HSRPv2 only | VRRPv3 native | Not supported |
| **Link utilization** | ~50% (active only) | ~50% (master only) | ~100% (load-balanced) |
| **Convergence** | ~10 sec | ~3 sec | ~10 sec |
| **Best for** | Cisco shops, redundant uplinks | Vendor-neutral, fast failover | Maximum uplink bandwidth use |

---

## Lab Relevance: Cisco IOS Commands

### HSRP Configuration

```ios
! Enable HSRP on an interface
interface GigabitEthernet0/0
 ip address 192.168.1.1 255.255.255.0
 standby version 2                              ! Use HSRPv2
 standby 1 ip 192.168.1.254                    ! Virtual IP for group 1
 standby 1 priority 150                        ! Priority (higher = more likely to be active)
 standby 1 preempt                             ! Preempt lower-priority active router
 standby 1 preempt delay minimum 30            ! Wait 30 sec after boot before preempting
 standby 1 timers 3 10                         ! Hello 3 sec, dead 10 sec
 standby 1 timers msec 500 1500                ! Sub-second hellos (HSRPv2 only)
 standby 1 authentication md5 key-string MyKey ! MD5 authentication (HSRPv2)
```

### VRRP Configuration

```ios
interface GigabitEthernet0/0
 ip address 192.168.1.1 255.255.255.0
 vrrp 10 ip 192.168.1.254                     ! Virtual IP for group 10
 vrrp 10 priority 200                         ! Priority (higher = master)
 vrrp 10 preempt                              ! Preempt (enabled by default in VRRP)
 vrrp 10 timers advertise 1                   ! Hello interval 1 sec
 vrrp 10 timers learn                         ! Learn timing from master
 vrrp 10 authentication md5 key-string MyKey
```

### GLBP Configuration

```ios
interface GigabitEthernet0/0
 ip address 192.168.1.1 255.255.255.0
 glbp 20 ip 192.168.1.254                     ! Virtual IP for group 20
 glbp 20 priority 110                         ! Priority for AVG election
 glbp 20 preempt                              ! Preempt lower-priority AVG
 glbp 20 load-balancing round-robin           ! Round-robin MAC assignment
                                               ! Options: round-robin, weighted, host-dependent
 glbp 20 timers 3 10

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 19 | [[CCNA]]*