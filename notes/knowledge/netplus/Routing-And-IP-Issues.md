# Routing And IP Issues

## What it is

In **BioShock**, Rapture's pneumo tube system was supposed to route messages, ammo, and cash between every level of the city. Then Ryan locked down sectors, Atlas rerouted traffic through Fontaine's smuggling tunnels, and by the time you arrive in Welcome to Rapture, half the tubes dump their payloads into flooded corridors or loop back on themselves forever. The address on the canister is fine. The routing tables behind the walls are a war zone. You watch a tube fire a package toward Arcadia and it just… never arrives. Somewhere in the pipes, a switch is sending it to Apollo Square instead, where it bounces between three more broken switches and dies.

That's exactly what routing and IP issues do — the packet is valid, the destination exists, but the path between them is broken, misconfigured, or eating itself.

Technically: this is the family of Layer 2 and Layer 3 problems where frames and packets fail to reach their destination because of switch misbehavior (loops, STP failures, wrong VLAN), router misbehavior (bad routes, missing default route, ACL drops), or host misconfiguration (wrong IP, wrong mask, wrong gateway, duplicate address). N10-009 Objective 5.3 lumps them together because in the real ticket, you don't know which layer broke until you've checked all of them.

## Why it matters

Routing and IP problems are 80% of network tickets that escalate past the helpdesk. A user can't reach a file share. Is it DNS? Gateway? VLAN? ACL? A loop chewing up the access switch? The wrong subnet mask making the host think the server is local when it isn't? You can't fix what you can't isolate, and CompTIA tests this exact isolation logic. Objective 5.3 is the domain that separates techs who guess from techs who methodically rule out L2 before L3, host config before infrastructure, and the obvious before the exotic. *Every senior network engineer I know got there by being wrong about routing problems for ten years first.*

## Key facts

### Host-side IP misconfiguration — check these first

These are the four ways a single host breaks its own connectivity. The fix is usually `ipconfig /release && ipconfig /renew` or a static-config correction.

| Misconfig | Symptom | What's happening |
|---|---|---|
| **Incorrect IP address** | Can't reach anything, or reaches the wrong host | Host is on a network it doesn't belong to, or collides with infrastructure |
| **Incorrect subnet mask** | Reaches some hosts, not others. LAN works, "remote" hosts (that are actually local) fail | Host miscalculates which destinations need the gateway vs ARP |
| **Incorrect default gateway** | LAN works perfectly, internet and remote subnets fail completely | Host has no path off-segment |
| **Duplicate IP address** | Intermittent — works, then doesn't, then works again. Windows pops the famous "IP address conflict" balloon | Two hosts answer ARP for the same IP; switch CAM table flaps between MACs |

**Subnet mask trap worth memorizing:** if a host has `/24` but the network is actually `/23`, the host thinks half its real neighbors are remote and ARPs the gateway for them. The gateway might helpfully proxy-ARP or might just drop the traffic. Inconsistent.

**Duplicate IP** is the worst of these because it's intermittent. DHCP servers do conflict detection (gratuitous ARP before lease) but static-assigned hosts don't, and a printer somebody hand-configured five years ago is the usual culprit. *I once spent four hours on a "slow VoIP" ticket that turned out to be a label printer with the same IP as the call manager's gateway.*

### Address pool exhaustion

DHCP scope runs out of leases. New hosts get APIPA addresses (169.254.x.x) and can't reach anything beyond their broadcast domain. Causes:

- Scope sized for 100 hosts, BYOD bring-your-own-device day brought 300
- Lease time set to 8 days, transient devices burn slots they won't reuse
- Rogue DHCP server handing out leases from a different scope (see [[VLANs]] and [[DHCP]])

Fix: shorten lease time, expand scope, or carve a new subnet. The 169.254 address is the diagnostic flag — if you see it, DHCP failed, period.

### Switching issues — Layer 2 problems

**Network loops** happen when two switches have redundant links and no [[Spanning Tree Protocol]] (STP) to block one. A broadcast frame enters switch A, gets flooded to switch B, gets flooded back to switch A, gets flooded to switch B again — forever, at line rate, multiplying with every flood. The switch CPU pegs, MAC tables flap as the same MAC appears on every port, and the entire broadcast domain goes dark in under a second. This is called a **broadcast storm** and it is the closest thing networking has to a heart attack.

The symptom: every host on the VLAN loses connectivity simultaneously. Link lights are solid amber/blinking like a Christmas tree. The switch CLI is unresponsive because the management plane is starving.

The fix: physically unplug one of the redundant links, then enable STP properly.

### STP — Spanning Tree Protocol

STP (802.1D) and its faster cousin RSTP (802.1w) prevent loops by electing one switch as the **root bridge** and logically disabling redundant paths until they're needed.

**Root bridge selection:** lowest **bridge ID** wins. Bridge ID = priority (default 32768) + MAC address. Lower priority wins; if tied, lower MAC wins. *The default-config switch with the oldest MAC becomes root, which is almost never the switch you want as root.* Set your core switch to priority 4096 manually. Don't let a 12-year-old access switch in a closet become the root of your network.

**Port roles:**

| Role | Function |
|---|---|
| **Root port** | The one port on a non-root switch with the lowest cost path to the root bridge. Forwards. |
| **Designated port** | The port on each segment that forwards traffic toward downstream switches. One per segment. |
| **Blocking/Alternate** | A redundant port that would create a loop. Logically disabled, but listening for BPDUs in case the primary path fails. |

**Port states (classic STP):** Disabled → Blocking → Listening → Learning → Forwarding. Takes ~30–50 seconds to converge after a topology change. RSTP collapses this to a few seconds.

> **CompTIA exam trap:** Root bridge is elected by *lowest* bridge ID, not highest. CompTIA will offer "highest priority" as a distractor. Priority is a number; lower number = higher election precedence. Also: a port in **blocking** state still receives BPDUs — it's not deaf, it's just not forwarding data frames.

### Incorrect VLAN assignment

Host plugged into a port assigned to the wrong VLAN gets a DHCP address from the wrong scope, lands in the wrong broadcast domain, and can't reach its intended resources — even though "the cable is fine and the link is up." Common with:

- Desk moves where the patch panel wasn't updated
- Voice/data port misconfig (phone in data VLAN, PC in voice VLAN)
- Trunk vs access port confusion — an access port pushed to a trunk strips VLAN tags and drops tagged traffic

Diagnostic: `show interface status` on the switch tells you the access VLAN. Compare to what the host should be on. See [[VLAN Configuration]].

### Routing issues — Layer 3 problems

**Routing table** is the router's list of known destinations and how to reach them. Built from directly-connected interfaces, static routes, and dynamic protocols ([[OSPF]], [[EIGRP]], [[BGP]], RIP). Each entry has a destination prefix, next-hop, metric, and administrative distance.

**Route selection** uses two rules in order:

1. **Longest prefix match wins.** A `/24` route beats a `/16` for any destination inside that /24. The router always picks the most specific match, regardless of source protocol.
2. **If prefixes are equal length, lowest administrative distance wins.** Static (1) beats EIGRP (90) beats OSPF (110) beats RIP (120). AD is the tiebreaker only when the prefix is identical.

**Default route** (`0.0.0.0/0`) is the route of last resort — used when nothing more specific matches. Almost every host and edge router needs one. Missing default route = "I can reach everything inside, nothing outside." It's the single most common routing misconfig on SOHO and branch routers.

> **CompTIA exam trap:** Longest prefix match is evaluated **before** administrative distance. A static `/24` and an OSPF `/16` to overlapping destinations? The /24 wins for traffic inside it, the /16 wins for everything else. CompTIA will phrase the question to make you think AD is checked first. It isn't.

### ACLs — Access Control Lists

ACLs filter traffic at the router or L3 switch by source/dest IP, port, and protocol. They are evaluated **top-down, first match wins**, with an **implicit deny all** at the bottom. Two ways to misconfigure:

- **Order wrong:** A permit statement below a deny statement that catches the same traffic never executes
- **Forgot the permit:** Implicit deny at the end blocks everything you didn't explicitly allow

Symptom: specific traffic fails (HTTPS to one server, ICMP from one subnet) while everything else works. Always check ACLs when the failure is selective rather than total. See [[Access Control Lists]].

## Troubleshooting order — CompTIA 7-step applied

1. **Identify** — what works, what doesn't, who's affected. One host or whole VLAN?
2. **Theory** — `ipconfig`, ping the gateway, ping a remote host, traceroute. Where does it stop?
3. **Test** — if ping to gateway fails, it's L1/L2/host config. If gateway works but remote fails, it's routing or ACL.
4. **Plan** — fix the smallest thing first. Wrong mask? Correct it. ACL deny? Edit it.
5. **Implement** — or escalate if it's outside your scope (core routing change = network team ticket).
6. **Verify** — ping the actual destination the user cares about, not just "the network."
7. **Document** — what was wrong, what fixed it, what you'd check first next time.

## Helpdesk reality

- User says: **"The internet is down."** Reality: their default gateway is unreachable, or their NIC pulled a 169.254 address. Check `ipconfig /all` first, every time.
- User says: **"It was working yesterday."** Reality: DHCP lease expired and renewed onto a different VLAN because somebody re-patched their cable. Check switchport VLAN assignment.
- User says: **"Only the shared drive is broken, everything else works."** Reality: ACL change, route to that subnet flapping, or subnet mask wrong so the host thinks the file server is local and ARPs into the void. Selective failure = think routing/ACL/mask, not gateway.
- Never promise: **"it'll be back up in five minutes."** STP reconvergence alone is 30–50 seconds on classic STP, and if there's a loop you haven't found yet, "five minutes" becomes the lie that ends careers.
- Escalation point: if you've verified host IP/mask/gateway are correct, the gateway pings, and traceroute dies past the first hop — it's a network team ticket. Hand it off with the traceroute output attached.

## Related concepts

[[Spanning Tree Protocol]] · [[VLANs]] · [[VLAN Configuration]] · [[DHCP]] · [[Default Gateway]] · [[Subnetting]] · [[Routing Protocols]] · [[OSPF]] · [[BGP]] · [[Access Control Lists]] · [[ARP]] · [[Broadcast Domains]] · [[APIPA]] · [[Network Troubleshooting Methodology]]

*Source: VIRGIL knowledge base — 2026-05-11*