# Seven Second Subnetting

## What it is

In **Fortnite**, the storm closes on a timer. You glance at the map, you see the safe zone, and you have to know — instantly — whether your current position is inside it, on the edge, or already taking damage. No calculator. No second-guessing. You read the circle, you read your dot, you move. The whole decision takes about two seconds because you've done it ten thousand times.

That's exactly what seven-second subnetting is — a drilled, repeatable method to look at an IP address and a CIDR mask and instantly know the network, the broadcast, the host range, and how many addresses you've got. No long division. No binary on scratch paper. Pattern recognition.

Technically: **subnetting** is the practice of dividing an IPv4 address space into smaller logical networks by extending the network portion of the mask into what would otherwise be host bits. **CIDR** (Classless Inter-Domain Routing) is the notation `/n` that replaces the legacy class system, where `n` is the number of network bits. **VLSM** (Variable Length Subnet Masking) is the practice of using different mask lengths for different subnets in the same network — right-sizing each segment instead of wasting addresses.

This is N10-009 Objective 1.7 territory, and CompTIA will absolutely give you a scenario where you must subnet under pressure.

## Why it matters

Every network engineer subnets. Every help desk tech who gets promoted subnets. Every cloud architect designing a VPC subnets. If you can't look at `192.168.4.130/26` and tell me the network ID, the broadcast, and the usable host range in under ten seconds, you will lose time on the exam and you will be slow on the job.

CompTIA tests this with multiple-choice questions where every option looks plausible unless you actually did the math. The questions are not hard. They are timed. Seven-second subnetting is how you get out of those questions in seven seconds and bank that time for the questions that actually require thought.

Real-world: when a [[VLAN]] needs splitting because broadcast traffic is melting a segment, when an [[AWS VPC]] needs four subnets across two availability zones, when a [[DHCP]] scope is exhausted and you need to carve out a second one — this is the skill.

## Key facts

### The address landscape

Before you can subnet, you have to know what space you're in.

| Range | Type | Use |
|---|---|---|
| `0.0.0.0/8` | Reserved | "This network" |
| `10.0.0.0/8` | **RFC 1918 private** | Class A private |
| `127.0.0.0/8` | **Loopback** | `127.0.0.1` = localhost |
| `169.254.0.0/16` | **APIPA** | DHCP failed, host self-assigned |
| `172.16.0.0/12` | **RFC 1918 private** | Class B private |
| `192.168.0.0/16` | **RFC 1918 private** | Class C private |
| `224.0.0.0/4` | **Class D** | Multicast |
| `240.0.0.0/4` | **Class E** | Experimental, do not use |
| `255.255.255.255` | Reserved | Limited broadcast |

[[Public IP]] addresses are anything routable on the internet — anything not in the reserved ranges above. [[Private IP]] addresses (RFC 1918) are not routable on the public internet and require [[NAT]] to talk to anything outside.

### Legacy classes (know them, don't use them)

| Class | First octet | Default mask | CIDR | Use |
|---|---|---|---|---|
| A | 1–126 | 255.0.0.0 | /8 | Huge networks |
| B | 128–191 | 255.255.0.0 | /16 | Mid networks |
| C | 192–223 | 255.255.255.0 | /24 | Small networks |
| D | 224–239 | — | — | Multicast |
| E | 240–255 | — | — | Experimental |

Notice 127 is missing from Class A — that's loopback. CompTIA loves this.

The classful system died in 1993 when CIDR replaced it. We still teach the classes because the exam asks, and because "Class C network" is shorthand for "/24-ish small network" in the field.

### The seven-second method

Memorize this table. Burn it into your skull. This is the only thing you need.

| CIDR | Mask | Block size | Hosts |
|---|---|---|---|
| /24 | 255.255.255.0 | 256 | 254 |
| /25 | 255.255.255.128 | 128 | 126 |
| /26 | 255.255.255.192 | 64 | 62 |
| /27 | 255.255.255.224 | 32 | 30 |
| /28 | 255.255.255.240 | 16 | 14 |
| /29 | 255.255.255.248 | 8 | 6 |
| /30 | 255.255.255.252 | 4 | 2 |

**The pattern:** the mask values are always `128, 192, 224, 240, 248, 252, 254, 255`. The block sizes are always powers of two: `128, 64, 32, 16, 8, 4, 2`. Hosts = block size minus 2 (network ID and broadcast).

### The procedure

Given `192.168.4.130/26`:

1. **Find the interesting octet.** /26 falls in the fourth octet (24 + 2). The mask is `255.255.255.192`.
2. **Find the block size.** /26 → block size 64.
3. **Find the network ID.** Count by 64 in the fourth octet: 0, 64, 128, 192. The address 130 falls in the 128 block. Network ID = `192.168.4.128`.
4. **Find the broadcast.** Next block starts at 192, so broadcast = `192.168.4.191`.
5. **Find the host range.** `192.168.4.129` through `192.168.4.190`. 62 usable hosts.

Done. Seven seconds once you've drilled it fifty times.

### VLSM — right-sizing the storm circle

[[VLSM]] is what happens when you stop wasting addresses. Classful design gives every subnet the same mask. VLSM gives each subnet a mask sized to its actual host count.

Scenario: you've got `10.50.0.0/22` (1022 hosts) and three departments:
- Engineering: 200 hosts
- Sales: 50 hosts
- Point-to-point WAN link: 2 hosts

Sized:
- Engineering → /24 (254 hosts) → `10.50.0.0/24`
- Sales → /26 (62 hosts) → `10.50.1.0/26`
- WAN → /30 (2 hosts) → `10.50.1.64/30`

Three subnets, three different masks, almost no wasted space. **Always allocate the biggest subnet first** — VLSM is greedy from the top.

*The hard-earned lesson: never subnet without VLSM in production. Wasted address space becomes an architectural debt that haunts you for a decade.*

### CompTIA exam traps

> **CompTIA exam trap — APIPA means DHCP failed.** If you see `169.254.x.x` on a client, the DHCP server is unreachable or down. The client self-assigned. The fix is upstream — at the DHCP server, the relay, or the cable. The client is doing exactly what it should.

> **CompTIA exam trap — loopback is 127.0.0.0/8, not just 127.0.0.1.** Every address from 127.0.0.1 to 127.255.255.254 is loopback. CompTIA will offer `127.5.5.5` as a "public" answer. It isn't. It's loopback.

> **CompTIA exam trap — /31 and /32 exist.** /31 is two hosts with no network ID or broadcast (RFC 3021, used for point-to-point links). /32 is a single host route (used for loopbacks on routers). They're rare on the exam but they exist.

> **CompTIA exam trap — Class A goes 1–126, not 1–127.** 127 is loopback. The "default" Class A is 1.0.0.0 through 126.255.255.255. If the question gives you `127.0.0.1` and asks the class, the answer is loopback, not Class A.

> **CompTIA exam trap — 172.16.0.0/12, not /16.** The Class B private range is 172.16.0.0 through 172.31.255.255 — sixteen contiguous /16s, which is a /12. Students consistently say "172.16.0.0/16" and get it wrong.

### Public vs. private — the [[NAT]] boundary

Inside your house, your devices have private IPs (`192.168.1.50`, `192.168.1.51`). Your router has one public IP from your ISP. [[NAT]] translates outbound traffic so the internet sees one address. Inbound unsolicited traffic gets dropped because the router has no translation entry for it.

This is why your friend can't connect to your hosted Fortnite Creative server without [[port forwarding]] — the router has no idea which internal device to send the inbound packet to.

### CIDR aggregation — the other direction

[[CIDR]] doesn't just chop networks smaller; it also lets you summarize. Eight contiguous /24s can be advertised as one /21. ISPs and BGP routers do this constantly to keep routing tables manageable. **Supernetting** is the term for moving the mask leftward to combine networks. You won't be asked to do hard supernetting math on N10-009, but you should recognize the term and the concept.

## Helpdesk reality

- User says: "Internet is broken." You check their IP. If it starts with `169.254`, DHCP is down or the cable is bad. Don't reboot the router yet — check link lights first.
- User says: "I can't reach the file server." You check their subnet mask. Half the time someone manually configured `255.255.255.0` on a `/23` network and now half the addresses look "remote" to their machine.
- Never promise: "Re-imaging will fix the IP issue." If DHCP is broken, every machine you re-image will land with 169.254. Fix the infrastructure, not the symptom.
- Escalation: if APIPA persists across multiple clients on the same VLAN, it's a DHCP scope, a relay agent, or a switchport configuration issue. Hand it to the network team with the evidence — which subnet, which clients, what time it started.
- Quick win: `ping 127.0.0.1` proves the TCP/IP stack is alive on the local machine. If that fails, the OS is sick, not the network.

## Related concepts

[[IPv4 addressing]] · [[IPv6 addressing]] · [[NAT]] · [[DHCP]] · [[APIPA]] · [[RFC 1918]] · [[CIDR]] · [[VLSM]] · [[Subnet mask]] · [[VLAN]] · [[Loopback]] · [[Default gateway]] · [[Routing fundamentals]] · [[Public IP]] · [[Private IP]]

*Source: VIRGIL knowledge base — 2026-05-11*