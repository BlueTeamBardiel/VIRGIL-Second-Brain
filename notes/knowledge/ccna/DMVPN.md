# DMVPN

## What it is

In Sekiro, the **Grappling Hook** lets you fire a line at any branch, banner, or stake the moment a green icon appears — no rope pre-strung, no scaffolding built. Wolf reaches the target dynamically, on demand, and lets go when done. That's exactly what **DMVPN** does — it builds VPN tunnels between sites on the fly instead of configuring every connection by hand in advance.

**DMVPN** is a Cisco overlay technology combining [[mGRE]], [[NHRP]], and optional [[IPsec]] to create scalable site-to-site VPNs where spokes can dynamically establish tunnels to a hub and, in later phases, directly to each other.

## Why it matters

A full-mesh VPN with traditional [[GRE]] tunnels requires **N(N-1)/2** point-to-point tunnels — 50 sites means 1,225 tunnels, each manually configured on both ends. Adding site 51 means touching every existing router. DMVPN reduces this to one mGRE interface per spoke and a single hub config that never changes when spokes are added. **Exam angle**: know the three phases, know NHRP's role as the "phone book," and know that mGRE is what makes one tunnel interface terminate many peers.

## Key facts

### Core components

- **[[mGRE]] (multipoint GRE)** — one tunnel interface that terminates multiple GRE peers. Protocol number **47**. No fixed `tunnel destination`.
- **[[NHRP]] (Next Hop Resolution Protocol)** — RFC 2332. The "phone book" that maps **tunnel IPs → physical (NBMA) IPs**. Spokes register with the **NHS (Next Hop Server)**, which is the hub.
- **[[IPsec]] profile** — optional but standard. Encrypts the GRE payload using **transport mode** (saves 20 bytes vs tunnel mode since GRE already provides the outer header).
- **Routing protocol** — [[EIGRP]], [[OSPF]], or [[BGP]] runs over the overlay so spokes learn each other's networks.

### The three phases

| Phase | Topology | Spoke-to-spoke traffic | Key behavior |
|-------|----------|------------------------|--------------|
| **Phase 1** | Hub-and-spoke only | Hairpins through hub | Spokes use **p2p GRE**; hub uses mGRE |
| **Phase 2** | Dynamic spoke-to-spoke | Direct after NHRP resolution | Spokes use mGRE; each spoke is its own next-hop in routing updates (no `next-hop-self` on hub) |
| **Phase 3** | Dynamic spoke-to-spoke, scalable | Direct via NHRP redirects | Hub sends **NHRP redirect**; spoke installs **NHRP shortcut** route. Summarization works. |

### Hub configuration (skeleton)

```
interface Tunnel0
 ip address 10.0.0.1 255.255.255.0
 no ip redirects
 ip nhrp authentication CISCO
 ip nhrp map multicast dynamic
 ip nhrp network-id 1
 ip nhrp redirect              ! Phase 3
 tunnel source GigabitEthernet0/0
 tunnel mode gre multipoint
 tunnel key 1
 tunnel protection ipsec profile DMVPN-PROFILE
```

### Spoke configuration (Phase 3)

```
interface Tunnel0
 ip address 10.0.0.2 255.255.255.0
 ip nhrp authentication CISCO
 ip nhrp map 10.0.0.1 198.51.100.1
 ip nhrp map multicast 198.51.100.1
 ip nhrp network-id 1
 ip nhrp nhs 10.0.0.1
 ip nhrp shortcut              ! Phase 3
 tunnel source GigabitEthernet0/0
 tunnel mode gre multipoint
 tunnel key 1
 tunnel protection ipsec profile DMVPN-PROFILE
```

### Verification commands

```
show dmvpn
show dmvpn detail
show ip nhrp
show ip nhrp brief
show crypto ipsec sa
```

### Gotchas

- **MTU**: GRE adds 24 bytes, IPsec adds more. Set `ip mtu 1400` and `ip tcp adjust-mss 1360` on the tunnel.
- **Split horizon**: disable on the hub for [[EIGRP]] (`no ip split-horizon eigrp <asn>`) in Phase 1/2 or spokes won't learn each other's routes.
- **next-hop-self**: in Phase 2, the hub must **not** rewrite the next hop, or spokes will always send through the hub.
- **NHRP holdtime**: default **7200 seconds** (2 hours) for registrations.

## Related concepts

[[mGRE]] · [[NHRP]] · [[GRE]] · [[IPsec]] · [[Site-to-Site VPN]] · [[EIGRP]] · [[OSPF over DMVPN]] · [[FlexVPN]]

---
*Source: VIRGIL knowledge base — 2026-05-07*