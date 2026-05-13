# Switching Issues

## What it is

In **Tomb Raider** (2013), Lara crawls through the wreckage of the *Endurance* on Yamatai. The ship is a maze of collapsed corridors, blocked doorways, and rerouted paths where the obvious route is buried under debris. She has to read the environment — which doors are jammed, which ropes hold, which beams collapsed — and find a working path through. When she picks the wrong corridor, she ends up in a dead end or, worse, looping back to where she started.

That's exactly what switching issues are — the frames are Lara, the switch is the wreckage, and when the path is broken or looping, traffic either dies in a dead end, never arrives, or floods the same hallway forever until the network burns down.

Technically: **switching issues** are Layer 2 (and adjacent Layer 3) faults that break frame forwarding inside a broadcast domain. They include [[STP]] failures, network loops, port-state stuckness, [[VLAN]] misassignment, ACL drops, address pool exhaustion, and the classic IP-layer misconfigurations that look like switching problems from the user's seat — wrong gateway, wrong mask, duplicate IP, wrong [[subnet]].

## Why it matters

When a switch loop forms, you don't get "slow internet." You get a **broadcast storm** that saturates every link in the broadcast domain in under a second. CPU on the switches pegs at 100%. Phones drop. Cameras drop. The wireless controller drops. Everyone in the building calls the helpdesk at the same time. This is the failure mode that gets junior network engineers fired and senior ones promoted, depending on which side of the patch cable they were on.

Net+ Objective **5.3** explicitly lists every term in this note: route selection, STP, routing table, network loops, default routes, root bridge, port roles, address pool exhaustion, port states, incorrect gateway/VLAN/IP/mask, ACLs, and duplicate IPs. CompTIA tests these as scenario questions — "users in VLAN 20 can't reach the internet, here's the config, what's wrong?" — and the wrong answer is always the one that *sounds* right but ignores one specific detail in the prompt.

## Key facts

### Spanning Tree Protocol (STP) and loops

[[STP]] (802.1D, and faster variants RSTP 802.1w and MSTP 802.1s) exists because Ethernet has no [[TTL]] field. A frame in a loop circulates forever. STP's job: detect redundant Layer 2 paths and **block** them until needed.

**Root bridge selection** — the switch with the lowest **Bridge ID** wins. Bridge ID = priority (default 32768) + MAC address. Lower priority wins; if tied, lowest MAC wins. The root is the reference point all other switches calculate paths toward.

> **CompTIA exam trap:** the root bridge is NOT automatically the fastest or most central switch. It's whichever switch has the lowest priority. If you never set priority, the **oldest** switch (lowest MAC, manufactured first) becomes root — which is usually a 12-year-old access-layer switch in a closet, not your core. Always set root bridge priority manually on the core. *Setting priority to 4096 on the core and 8192 on the secondary is the standard move.*

**Port roles** (RSTP):
| Role | What it does |
|---|---|
| **Root port** | The port on a non-root switch with the lowest cost path to the root |
| **Designated port** | The port on a segment with the lowest cost to the root — forwards traffic |
| **Alternate port** | Backup root port — blocked, ready to take over |
| **Backup port** | Backup designated port — blocked, rare in modern topologies |

**Port states**:
| State | Forwards data? | Learns MACs? | Notes |
|---|---|---|---|
| Disabled | No | No | Admin shutdown |
| Blocking | No | No | STP says "don't forward, loop risk" |
| Listening | No | No | Transitioning, processing BPDUs |
| Learning | No | Yes | Building MAC table before forwarding |
| Forwarding | Yes | Yes | Normal operation |

Classic 802.1D takes ~30–50 seconds to go from blocking to forwarding. RSTP cuts this to a few seconds. **PortFast** skips listening/learning for access ports — use it on user ports only, never on switch-to-switch links, because PortFast + a loop = instant storm.

### Network loops

A loop forms when two switches have a redundant path and STP is disabled, broken, or bypassed. Symptoms:
- Switch CPU pegs at 100%
- All link lights blink in unison at line rate
- MAC address table thrashes — same MAC seen on different ports every millisecond
- Users report total network outage, not slowness

Root causes: someone patched two ports on the same switch into each other (the classic "loop in a wall jack"), a cheap unmanaged switch got plugged into two drops, or STP was disabled "to fix a slow port."

Defense: **BPDU Guard** on access ports (shuts down the port if a BPDU arrives — meaning someone plugged a switch into a user jack). **Root Guard** on designated ports facing downstream (prevents a rogue switch from becoming root). **Loop Guard** as a belt-and-suspenders measure.

*Never disable STP to "fix" a problem. STP is the only thing standing between you and a broadcast storm.*

### Routing table and route selection

The [[routing table]] is the switch's (or router's) map of which next-hop to send a packet toward for each destination network. Selection order:

1. **Longest prefix match** wins. A route to `10.1.1.0/24` beats `10.0.0.0/8` for a packet destined to `10.1.1.5`.
2. If prefix lengths tie, **administrative distance** (AD) decides — lower wins. Connected = 0, static = 1, EBGP = 20, OSPF = 110, RIP = 120.
3. If AD ties (same protocol), **metric** decides. OSPF uses cost, EIGRP uses composite, RIP uses hop count, BGP uses path attributes.

**Default route** (`0.0.0.0/0`) is the "if nothing else matches, send it here" entry. Always the *shortest* prefix, always loses to anything more specific. Missing default route on a Layer 3 switch = users can ping internal hosts but not the internet. *"DNS works, internal works, internet doesn't"* — check the default route.

### IP-layer misconfigs that look like switching problems

The user can't reach anything. The switch is fine. The problem is at Layer 3 on the host. Net+ tests these constantly:

| Misconfig | Symptom | How to spot it |
|---|---|---|
| **Incorrect default gateway** | Can ping locally, can't reach anything off-subnet | `route print` / `ip route` shows wrong gateway |
| **Incorrect subnet mask** | Can reach some local hosts, not others; thinks remote hosts are local and ARPs into the void | Check mask matches the rest of the subnet |
| **Incorrect IP address** | Wrong subnet entirely; nothing works | IP doesn't match the VLAN's subnet |
| **Duplicate IP** | Intermittent failures; ARP table flips between two MACs; Windows pops "IP address conflict" | `arp -a` shows the MAC flapping |
| **Incorrect VLAN assignment** | Host got an IP from the wrong DHCP scope, or no IP at all | Switch port `show interfaces switchport` shows wrong access VLAN |
| **Address pool exhaustion** | New devices can't get an IP; old devices fine | DHCP scope at 100%; expand pool or shorten lease |

> **CompTIA exam trap:** **incorrect subnet mask** is the sneaky one. A host with `192.168.1.50/16` instead of `/24` thinks the entire `192.168.0.0–192.168.255.255` range is local. It ARPs for remote hosts and never sends to the gateway. Local works, "remote-but-feels-local" fails silently. The user says "internet is slow" because half their connections time out before falling back to the gateway path.

> **CompTIA exam trap:** a **duplicate IP** doesn't always announce itself. Windows will pop a warning. Linux servers and printers often won't. Symptom is intermittent — works when one device is off, breaks when both are on. Check the ARP table on the gateway; if a MAC for one IP changes every few seconds, you've found it.

### VLAN assignment errors

A switch port is configured for an access VLAN (`switchport access vlan 20`). If it's set to the wrong VLAN, the host gets DHCP from the wrong scope — wrong subnet, wrong gateway, wrong everything. The host *thinks* it's healthy because it got an IP. It's just on the wrong network.

Trunk misconfigs are worse: native VLAN mismatch between two switches causes traffic to leak between VLANs, which is both a security issue and a debugging nightmare. **Always match native VLAN on both sides of a trunk**, and **never use VLAN 1 as native** in production.

### ACLs

Access Control Lists filter traffic by source/dest IP, port, or protocol. An ACL applied to the wrong direction (inbound vs outbound) or with an implicit-deny that's blocking legitimate traffic is a classic "the network broke after the change window" call.

> **CompTIA exam trap:** ACLs have an **implicit deny all** at the end. If your ACL is `permit tcp any any eq 443`, every other protocol — including ICMP for ping, DNS, DHCP — gets dropped. Users can browse HTTPS sites by IP and nothing else works. *"HTTPS works but ping doesn't"* = check the ACL.

ACL placement matters: standard ACLs (source-only) go close to the **destination**; extended ACLs (source + dest + port) go close to the **source** to drop traffic early.

## Helpdesk reality

- **"The whole floor is down."** Check for a loop first. If every link light on the access switch is blinking in unison, someone patched a loop. Find the rogue cable, unplug it, watch the storm subside.
- **"I can get to the file server but not the internet."** Default gateway or default route. Check `ipconfig` / `ip a`. If the gateway is blank or wrong, that's the answer. If the gateway is right, check the L3 switch's routing table for a default route.
- **"It worked yesterday."** Something changed. Pull the change log. 90% of the time it's a config push, a new ACL, or a switch port someone "cleaned up." Document the rollback before you make it.
- **"My printer keeps going offline."** Duplicate IP. Someone set a static IP inside the DHCP scope. Check ARP for flapping MACs. Either reserve the IP in DHCP or move the static outside the scope.
- **Never promise "five minutes."** Layer 2 issues can take hours to find because the symptom (whole VLAN down) is far from the cause (one cable in one closet). The honest answer is "I'll update you in 15 minutes with what I've ruled out."

Troubleshooting order, every time: **L1 (cable, link light), L2 (port state, VLAN, STP), L3 (IP, mask, gateway, route), then escalate**. Skipping layers is how you spend three hours debugging DNS when the cable was unplugged.

## Related concepts

[[STP]] · [[VLAN]] · [[Routing Table]] · [[Default Gateway]] · [[Subnet Mask]] · [[DHCP]] · [[ARP]] · [[ACLs]] · [[Broadcast Storm]] · [[Port Security]] · [[BPDU Guard]] · [[Trunk Ports]] · [[Native VLAN]] · [[Administrative Distance]] · [[CompTIA Troubleshooting Methodology]]

*Source: VIRGIL knowledge base — 2026-05-11*