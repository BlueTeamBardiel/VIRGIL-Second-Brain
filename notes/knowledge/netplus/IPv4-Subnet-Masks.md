# IPv4 Subnet Masks

## What it is

In **Tears of the Kingdom**, when you open the map you see Hyrule sliced into regions: Hyrule Field, Hebra, Faron, Gerudo, the Depths beneath, the Sky Islands above. Each region has a name, a boundary, and a shrine count. Link can fast-travel within and between regions because the map *knows* where one region ends and the next begins. The boundary isn't a fence — it's an overlay. The terrain is continuous; the regions are how you carve it up so you can find anything.

That's exactly what a subnet mask does — it tells a device which part of an IPv4 address is the "region" (network) and which part is the specific shrine (host).

Technically: an **IPv4 subnet mask** is a 32-bit value that pairs with an IPv4 address to separate the **network portion** from the **host portion**. Bits set to `1` mark network; bits set to `0` mark host. `255.255.255.0` is eight zero-bits of host space — 256 addresses, 254 usable. The mask is what makes `192.168.1.50` mean "host 50 on network 192.168.1.0" instead of just being four numbers in a trench coat.

## Why it matters

Subnetting is the single most tested topic on Network+ (Objective 1.7) and the single most useful skill in the first five years of an IT career. Every router decision, every firewall rule, every "why can't this VM talk to that VM" ticket comes back to: *what subnet is each side on, and is there a route between them?*

Get this wrong on the job and you build broadcast domains the size of a stadium — ARP storms, slow DHCP, and a help desk drowning in "the network is slow" tickets. Get it wrong on the exam and you'll miss 8–12 questions that were free points.

## Key facts

### The mask, in three notations

A subnet mask can be written three ways. All mean the same thing.

| Dotted decimal | Binary (last octet shown) | CIDR |
|---|---|---|
| 255.0.0.0 | 11111111.00000000.00000000.00000000 | /8 |
| 255.255.0.0 | 11111111.11111111.00000000.00000000 | /16 |
| 255.255.255.0 | 11111111.11111111.11111111.00000000 | /24 |
| 255.255.255.128 | …10000000 | /25 |
| 255.255.255.192 | …11000000 | /26 |
| 255.255.255.224 | …11100000 | /27 |
| 255.255.255.240 | …11110000 | /28 |
| 255.255.255.248 | …11111000 | /29 |
| 255.255.255.252 | …11111100 | /30 |

The CIDR number is just the count of `1` bits. `/24` = 24 network bits, 8 host bits, 256 total addresses, 254 usable hosts.

*Memorize the last-octet values: 128, 192, 224, 240, 248, 252. You will see them on the exam and on every router on Earth.*

### Hosts per subnet — the off-by-two trap

Host count = `2^(host bits) - 2`. The minus-two is the network address (all host bits `0`) and the broadcast address (all host bits `1`). Neither can be assigned to a device.

| CIDR | Total addresses | Usable hosts |
|---|---|---|
| /24 | 256 | 254 |
| /25 | 128 | 126 |
| /26 | 64 | 62 |
| /27 | 32 | 30 |
| /28 | 16 | 14 |
| /29 | 8 | 6 |
| /30 | 4 | 2 |

`/30` is the standard for point-to-point router links — two usable hosts, one for each end, no waste.

### IPv4 address classes (legacy, but tested)

Before [[CIDR]] existed (1993), addresses came in fixed-size classes. CompTIA still tests this because the class boundaries still appear in default masks and private-range definitions.

| Class | First octet | Default mask | Use |
|---|---|---|---|
| A | 1–126 | /8 (255.0.0.0) | Massive networks |
| B | 128–191 | /16 (255.255.0.0) | Mid-size networks |
| C | 192–223 | /24 (255.255.255.0) | Small networks |
| D | 224–239 | n/a | Multicast |
| E | 240–255 | n/a | Experimental/reserved |

`127.0.0.0/8` is carved out of Class A space for **loopback** — `127.0.0.1` is `localhost`, the address that means "this machine, talking to itself." Pinging it tests whether the TCP/IP stack is alive at all.

Class D is multicast — one-to-many delivery. Class E is reserved and you'll likely never see it in production.

### Public vs. private — RFC1918

**RFC1918** carves out three private ranges that are non-routable on the public internet. Every home router, every corporate LAN, every Kubernetes pod network uses these:

| Range | CIDR | Class | Size |
|---|---|---|---|
| 10.0.0.0 – 10.255.255.255 | 10.0.0.0/8 | A | 16.7 million addresses |
| 172.16.0.0 – 172.31.255.255 | 172.16.0.0/12 | B | ~1 million addresses |
| 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 | C | 65,536 addresses |

Private addresses get translated to a public address by [[NAT]] at the network edge. Without NAT, your laptop on `192.168.1.50` couldn't talk to Google — the internet doesn't route 192.168 anything.

> **CompTIA exam trap:** the 172 range is **172.16.0.0 to 172.31.255.255**, not 172.0–172.255 and not 172.16–172.16. It's a /12, which spans 16 Class B networks. Memorize 16–31.

### APIPA — the "I gave up" address

**APIPA** (Automatic Private IP Addressing) lives at `169.254.0.0/16`. When a device is set to DHCP but can't reach a [[DHCP]] server, it self-assigns an address from this range. It means: *I tried to get an IP, nobody answered, here's my consolation prize.*

An APIPA address is a diagnostic finding, not a working configuration. The device can talk to other APIPA hosts on the same link, but it has no gateway, no DNS, and no path off the LAN.

*If you `ipconfig` and see 169.254-anything, the DHCP server is unreachable. Check the cable, the switch port, the VLAN, then the DHCP server itself — in that order.*

### CIDR — what killed the classes

**Classless Inter-Domain Routing** decoupled the mask from the first octet. Instead of "this is a Class B so the mask is /16," CIDR lets you mask anywhere — `/19`, `/22`, `/27`. It also enables **route summarization**: a single advertisement for `10.0.0.0/8` can represent every subnet inside it, shrinking routing tables by orders of magnitude.

Without CIDR, the IPv4 internet would have run out of routable space in the late 1990s. With CIDR, it limped on for another 30 years.

### VLSM — different subnet sizes in one network

**Variable Length Subnet Masking** means using different mask lengths within the same parent network. The point: stop wasting addresses.

A `/24` site with four subnets — Sales (50 hosts), Engineering (25 hosts), Servers (10 hosts), Router-link (2 hosts) — would burn four full `/24`s with classful addressing. With VLSM you carve a single `/24` into:

| Subnet | Size needed | CIDR | Range |
|---|---|---|---|
| Sales | 50 | /26 (62 hosts) | .0–.63 |
| Engineering | 25 | /27 (30 hosts) | .64–.95 |
| Servers | 10 | /28 (14 hosts) | .96–.111 |
| Router link | 2 | /30 (2 hosts) | .112–.115 |

Same 256 addresses, four subnets, no overlap. **Always allocate the largest subnet first**, then work down — that's the rule that prevents the headache of having to renumber when you realize Sales doesn't fit.

### The magic number method (subnetting in your head)

For an exam question like "what subnet is 192.168.5.137 in if the mask is /27?":

1. /27 means the boundary is in the 4th octet. The mask is 255.255.255.**224**.
2. Magic number = `256 - 224 = 32`. Subnets increment by 32 in the 4th octet.
3. Subnets: .0, .32, .64, .96, **.128**, .160, .192, .224.
4. 137 falls between 128 and 160, so the network is `192.168.5.128/27`.
5. Broadcast is `.159`. Usable hosts: `.129` to `.158`.

*Drill this until it's reflex. You will do it a dozen times on the exam and a thousand times in your career.*

### CompTIA exam traps

> **CompTIA exam trap:** `127.0.0.1` is loopback, not APIPA. APIPA is `169.254.x.x`. Both indicate "something's wrong with the network" but mean different things — loopback being unreachable means the TCP/IP stack itself is broken; APIPA means DHCP is unreachable.

> **CompTIA exam trap:** the network address and broadcast address are **not assignable to hosts**. A `/24` has 256 addresses, **254 usable**. A `/30` has 4 addresses, **2 usable**. The exception is `/31` (RFC 3021) which is used on point-to-point links and has 2 usable addresses with no broadcast — but classic Network+ math expects the minus-two rule unless the question explicitly invokes /31.

> **CompTIA exam trap:** the default mask for a Class B is **/16**, not /24. The default mask for a Class A is **/8**. CompTIA will give you `10.5.5.5` with no mask and expect you to know it's a Class A address with a default /8 — even though in real life nobody runs 10/8 as a single flat subnet.

## Helpdesk reality

- **User says:** "I have no internet." **You check:** `ipconfig`. If you see `169.254.x.x`, it's APIPA — DHCP didn't answer. If you see `127.0.0.1` as the primary, something is deeply wrong with the stack. If you see `0.0.0.0`, the interface is down — check the cable and the link light.
- **User says:** "I can ping the router but not Google." **You check:** DNS first (`nslookup google.com`), then default gateway, then the WAN side of the router. The subnet is fine; the problem is upstream.
- **User says:** "I plugged into the new jack and nothing works." **You check:** whether the jack is on the right VLAN and whether DHCP is scoped for that subnet. A jack that lands on a subnet with no DHCP scope hands out APIPA.
- **Never promise** that "expanding the subnet" is fast. Resubnetting a live network means renumbering DHCP scopes, firewall rules, static routes, and every device with a hard-coded IP. It's a change-window job, not a same-day fix.
- **Escalation point:** if you've confirmed the client has a valid IP, correct mask, reachable gateway, and working DNS, and it still can't reach a destination — that's a routing or firewall ticket for the network team. Subnet math is your job; transit policy is theirs.

## Related concepts

[[IPv4 Addressing]] · [[CIDR Notation]] · [[VLSM]] · [[DHCP]] · [[APIPA]] · [[NAT]] · [[RFC1918 Private Addressing]] · [[Loopback Address]] · [[IPv6 Addressing]] · [[Default Gateway]] · [[Broadcast Domain]] · [[VLANs]] · [[Routing Tables]]

*Source: VIRGIL knowledge base — 2026-05-11*