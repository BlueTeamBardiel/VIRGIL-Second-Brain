# Classful Subnetting

## What it is

In **Pokemon**, every Pokemon belongs to a type — Fire, Water, Grass, Electric — and the type tells you almost everything you need to know before the battle starts. A Charmander is going to have certain matchups, certain weaknesses, certain stats in a recognizable range. You don't need to read its full Pokedex entry to know what kind of creature you're dealing with. The type is a shorthand. The first piece of information sorts the rest.

That's exactly what **classful addressing** does — the first bits of an IPv4 address sort it into a class, and the class tells you the default subnet mask and how many hosts it can hold.

**Technical definition:** Classful addressing is the original IPv4 scheme defined in RFC 791 that divides the 32-bit address space into five classes (A, B, C, D, E) based on the leading bits of the first octet. Each class has a fixed default subnet mask determining the network/host split. Classful addressing was officially deprecated for routing by RFC 1519 in 1993 when **[[CIDR]]** (Classless Inter-Domain Routing) replaced it, but classful concepts still show up everywhere — in CompTIA exam questions, in legacy documentation, and in how engineers casually describe networks ("it's a slash-24" still means "Class C-sized").

## Why it matters

Classful addressing is the foundation N10-009 builds on. You cannot understand **[[VLSM]]**, **[[CIDR]]**, or **[[Subnetting]]** without first knowing what the classes were and why they failed. CompTIA Objective 1.7 explicitly tests address classes, **[[RFC 1918]]** private ranges, **[[APIPA]]**, and **[[Loopback]]** — all classful concepts.

Real-world stakes: classes are gone from routing but alive in conversation. When a senior engineer says "carve me a Class B out of 10.0.0.0/8," they don't mean a literal Class B — they mean a /16. Decode that or look lost. Every network you'll ever touch uses **[[RFC 1918]]** private space (10/8, 172.16/12, 192.168/16) — those ranges are classful by birth. The classes are a vocabulary you cannot opt out of.

## Key facts

### The five classes

The first octet of the IPv4 address determines the class. Memorize this table — CompTIA will test it directly.

| Class | First octet (decimal) | Leading bits | Default mask | CIDR | Networks | Hosts per network | Purpose |
|-------|----------------------|--------------|--------------|------|----------|-------------------|---------|
| **A** | 1–126 | `0xxxxxxx` | 255.0.0.0 | /8 | 128 | 16,777,214 | Huge orgs, ISPs |
| **B** | 128–191 | `10xxxxxx` | 255.255.0.0 | /16 | 16,384 | 65,534 | Mid-size orgs, universities |
| **C** | 192–223 | `110xxxxx` | 255.255.255.0 | /24 | 2,097,152 | 254 | Small networks |
| **D** | 224–239 | `1110xxxx` | n/a | n/a | n/a | n/a | Multicast |
| **E** | 240–255 | `1111xxxx` | n/a | n/a | n/a | n/a | Experimental/reserved |

The "minus two" on host counts is because every subnet loses the network address (all host bits 0) and the broadcast address (all host bits 1).

### Class A — the giants

Range: **1.0.0.0 – 126.255.255.255**. First bit is always 0. Default mask /8. Each Class A network holds ~16.7 million hosts. The original idea: hand these to massive entities — MIT got 18.0.0.0/8, Ford got 19.0.0.0/8, the US DoD got several. This is also why **10.0.0.0/8** is the largest **[[RFC 1918]]** private block — it's one entire Class A reserved for internal use.

Note that 127 is **excluded** from Class A — that whole /8 is reserved for **[[Loopback]]**.

### Class B — the mid-tier

Range: **128.0.0.0 – 191.255.255.255**. Leading bits `10`. Default /16. About 65,534 hosts per network. **172.16.0.0 – 172.31.255.255** (RFC 1918) lives here — note it's not a full Class B, it's 16 contiguous /16s, which is the trap CompTIA loves to set.

### Class C — the small ones

Range: **192.0.0.0 – 223.255.255.255**. Leading bits `110`. Default /24. Only 254 hosts. **192.168.0.0/16** is the RFC 1918 Class C range — 256 individual /24s that every home router on Earth carves a /24 out of (your router probably hands out 192.168.1.0/24 or 192.168.0.0/24 right now).

### Class D — multicast

Range: **224.0.0.0 – 239.255.255.255**. Leading bits `1110`. No subnet mask — these aren't network addresses, they're group addresses. One sender, many subscribed receivers. Used by routing protocols (OSPF uses 224.0.0.5/6, EIGRP uses 224.0.0.10), streaming protocols, and service discovery (mDNS uses 224.0.0.251).

### Class E — reserved, do not touch

Range: **240.0.0.0 – 255.255.255.255**. Leading bits `1111`. Reserved for "future use" since the 1980s. The future never came. Most operating systems and routers refuse to route Class E traffic. People have proposed reclaiming it to extend IPv4 — it never happens because IPv6 is the actual answer.

*Class E is the unused 25th slot in the original 151 Pokemon roster — reserved, talked about, never released.*

### Special-purpose ranges (CompTIA loves these)

| Range | CIDR | Purpose |
|-------|------|---------|
| **127.0.0.0/8** | /8 | **[[Loopback]]** — 127.0.0.1 = localhost. Packets never leave the host. |
| **169.254.0.0/16** | /16 | **[[APIPA]]** — auto-assigned when DHCP fails. |
| **10.0.0.0/8** | /8 | RFC 1918 private (Class A) |
| **172.16.0.0/12** | /12 | RFC 1918 private (16 contiguous Class B's) |
| **192.168.0.0/16** | /16 | RFC 1918 private (256 contiguous Class C's) |
| **0.0.0.0/8** | /8 | "This network" — default route is 0.0.0.0/0 |
| **255.255.255.255** | /32 | Limited broadcast — never routed |

### Public vs private

**Public** addresses are globally unique and routable on the internet. You get them from your ISP, who got them from a Regional Internet Registry (ARIN, RIPE, APNIC, etc.). **Private** addresses (RFC 1918) are unroutable on the public internet — they exist only inside organizations and translate through **[[NAT]]** to reach the outside. Every home network on Earth uses RFC 1918 space behind one public IP. That's why your laptop and your neighbor's laptop can both be 192.168.1.100 without anyone caring — the conflict is invisible to the internet.

### APIPA — the "I tried and failed" address

When a client requests an IP via **[[DHCP]]** and gets no answer, Windows (and most modern OSes) self-assign from **169.254.0.0/16**. That's APIPA. If you see a 169.254 address on a host, it means *the DHCP server is unreachable* — not that the host is misconfigured. The host is doing the right thing. Something else is broken: cable, switch port, VLAN, DHCP server itself.

*If you ever ipconfig and see 169.254-anything, stop debugging the client. The client is fine. Find the DHCP server.*

### Loopback — the conversation with yourself

**127.0.0.1** is the most famous IP address in the world. Pinging it tests whether the TCP/IP stack on the local machine is working at all — the packet never touches a wire, never hits the NIC. The entire 127.0.0.0/8 is loopback, but everyone uses .1.

### Why classful addressing died

Classful was wasteful. If you needed 300 hosts, a Class C (254) was too small and a Class B (65,534) gave you 65,234 wasted addresses. There was no in-between. By the early 1990s, IPv4 exhaustion was visible on the horizon, and the IETF responded with two fixes:

**[[VLSM]] (Variable Length Subnet Mask)** — RFC 1812. Lets you subnet a network with *different mask lengths* in different parts. Need a /30 for a point-to-point link and a /26 for a user LAN out of the same parent /24? VLSM allows it. Classful didn't.

**[[CIDR]] (Classless Inter-Domain Routing)** — RFC 1519. Throws the class boundaries out entirely. The mask is whatever you say it is, written as a slash-number (192.168.1.0/26). Routers stopped caring about the first octet's leading bits and started caring only about the prefix length. CIDR also enables **route aggregation** (summarization) — one routing table entry for 10.0.0.0/8 instead of 256 entries for every /16 inside it. This is what kept the internet's routing tables from collapsing.

### CompTIA exam traps

> **CompTIA exam trap:** 127.0.0.1 is **not** a Class A address. Class A is 1–126. 127 is reserved for loopback. If the question asks "what class is 127.0.0.1," the answer is loopback/reserved, not Class A.

> **CompTIA exam trap:** The 172.16.0.0/12 private range is **172.16.0.0 through 172.31.255.255** — not 172.16 through 172.255. The /12 mask covers 16 contiguous /16 blocks (172.16 through 172.31). Anything 172.32+ is public.

> **CompTIA exam trap:** APIPA is 169.254.0.0/16 — but Microsoft reserves 169.254.0.0/24 and 169.254.255.0/24 at the edges. The actual usable APIPA range is 169.254.1.0 through 169.254.254.255. CompTIA may ask for the full /16 or the usable range — read the question.

> **CompTIA exam trap:** Class D (224–239) is multicast. Class E (240–255) is experimental. Mixing these up is a classic distractor. Mnemonic: D comes before E, and we *Distribute* (multicast) before we *Experiment*.

> **CompTIA exam trap:** The default mask for a Class A is /8, but RFC 1918's 10.0.0.0 block is also /8 — these are the same thing because the entire Class A network 10 was reserved for private use. Don't get confused if a question says "10.0.0.0 with default mask" — it's /8.

## Helpdesk reality

- User says: "My computer says no internet." You check: `ipconfig`. If the IPv4 address starts with **169.254**, the laptop never got a DHCP lease. Don't touch the laptop — check the cable, the switch port, the VLAN assignment, and the DHCP server itself.
- User says: "I can't reach the server at 10.50.1.20 from home." You check: are they on the VPN? RFC 1918 addresses aren't routable across the public internet. No VPN = no path. Ever.
- User says: "Ping works to 127.0.0.1 but not to anything else." That tells you the TCP/IP stack is alive but something between the NIC and the rest of the network is broken. Check link light, IP config, gateway.
- Never promise: "Your IP address is fixed forever." DHCP leases expire. Static reservations get changed. If they need a stable address (printer, server), open a ticket with the network team to set a DHCP reservation — don't hand-jam a static on the client.
- Escalation: if you've confirmed the client has a valid IP, valid gateway, valid DNS, and still can't reach internal resources, it's a network team ticket. Routing, ACL, or firewall problem above your layer.

## Related concepts

[[CIDR]] · [[VLSM]] · [[Subnetting]] · [[RFC 1918]] · [[APIPA]] · [[Loopback]] · [[DHCP]] · [[NAT]] · [[IPv4 Addressing]] · [[Subnet Mask]] · [[Default Gateway]] · [[Broadcast Domain]]

*Source: VIRGIL knowledge base — 2026-05-11*