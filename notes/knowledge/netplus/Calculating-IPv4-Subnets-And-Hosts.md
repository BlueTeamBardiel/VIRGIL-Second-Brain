# Calculating IPv4 Subnets And Hosts

## What it is

In **The Legend of Zelda: Breath of the Wild**, Hyrule is divided into regions — Necluda, Hebra, Eldin, Faron, Gerudo. Each region has its own tower that activates a chunk of map. Inside each region are smaller subdivisions: Hateno Village, Kakariko, the Dueling Peaks. You can't fast-travel into a region until you've climbed its tower, and within a region you navigate by named landmarks, not by absolute coordinates. The map is hierarchical: world → region → village → shrine.

That's exactly what subnetting does. **An IPv4 address is a coordinate. The subnet mask is the line that says "everything left of here is the region, everything right of here is the specific shrine."** Routers care about the region. Switches care about the shrine. Move the line, and you change how many regions exist and how many shrines fit in each one.

Technically: an **IPv4 address** is 32 bits, written as four dotted-decimal octets (e.g. `192.168.1.42`). A **subnet mask** (e.g. `255.255.255.0` or `/24` in CIDR) splits those 32 bits into a **network portion** (left) and a **host portion** (right). Subnetting is the act of borrowing host bits to create more, smaller networks.

## Why it matters

Subnet math is the single most-tested skill on N10-009 Objective 1.7. CompTIA will give you an address and a mask and ask: what network is this? what's the broadcast? how many hosts? what's the next subnet? You will be asked this in performance-based questions where you cannot guess.

In the field, subnetting is how you carve a /16 corporate network into floors, departments, and VLANs. Get it wrong and you either run out of addresses or you waste an entire Class B on a print server. *You will subnet by hand on the exam. No calculator. Learn the magic number method or fail the PBQs.*

## Key facts

### IPv4 address classes (legacy, still tested)

Classful addressing is dead in practice — CIDR replaced it in 1993 — but CompTIA still tests the classes because they show up in documentation, default masks, and RFC1918 boundaries.

| Class | First octet range | Default mask | CIDR | Use |
|-------|------------------|--------------|------|-----|
| **A** | 1–126 | 255.0.0.0 | /8 | Massive networks (16.7M hosts) |
| **B** | 128–191 | 255.255.0.0 | /16 | Mid-size (65K hosts) |
| **C** | 192–223 | 255.255.255.0 | /24 | Small (254 hosts) |
| **D** | 224–239 | n/a | n/a | **Multicast** |
| **E** | 240–255 | n/a | n/a | **Experimental/reserved** |

The first octet `127` is missing on purpose. That entire `/8` (127.0.0.0/8) is **loopback** — every address from 127.0.0.1 to 127.255.255.254 loops back to the local host. You ping `127.0.0.1` (localhost) to confirm the TCP/IP stack is alive on the machine itself. *If localhost doesn't ping, the problem is the OS, not the network.*

### Public vs. private (RFC1918)

**Public addresses** are globally routable on the internet, assigned by IANA through regional registries. **Private addresses** are defined by **RFC 1918** — they're free to use inside your network, but no router on the public internet will forward them. They must be **NAT**ted to a public address to reach the outside world.

| Class | RFC1918 range | CIDR | Hosts |
|-------|---------------|------|-------|
| A | 10.0.0.0 – 10.255.255.255 | 10.0.0.0/8 | 16,777,214 |
| B | 172.16.0.0 – 172.31.255.255 | 172.16.0.0/12 | 1,048,574 |
| C | 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 | 65,534 |

> **CompTIA exam trap:** the Class B private range is **172.16–172.31**, not 172.16–172.32 and not all of 172. A question asking "is 172.32.5.10 private?" — answer is **no, it's public**. Memorize 16–31.

### APIPA — Automatic Private IP Addressing

If a Windows host requests a DHCP lease and gets no answer, it self-assigns from **169.254.0.0/16** (excluding the first and last /16). This is **APIPA**, defined in RFC 3927. APIPA addresses are link-local only — they cannot route. Two APIPA hosts on the same switch can talk; nothing else works.

*If you see a 169.254.x.x address on a user's machine, DHCP failed. Check the DHCP server, the relay/helper, the VLAN, and the cable — in that order.*

### CIDR — Classless Inter-Domain Routing

**CIDR** replaced classful addressing in 1993. Instead of "this is a Class B so the mask is /16," CIDR lets the mask be any length from /0 to /32. Notation: `192.168.1.0/24` means the first 24 bits are network, the last 8 are host.

This is the **only addressing scheme that matters in modern practice.** Classes are exam trivia. CIDR is reality.

### Subnetting — the magic number method

Borrowing host bits creates smaller networks. The key skill: given an address and a CIDR prefix, find the network, broadcast, first host, last host, and host count.

**The five questions CompTIA asks:**
1. What network is this address in?
2. What is the broadcast address?
3. What is the usable host range?
4. How many hosts per subnet?
5. How many subnets total?

**The magic number method** — works in under 30 seconds with practice:

Step 1: Find the **interesting octet** — the octet where the mask transitions from 255 to something less.

Step 2: Subtract that octet's mask value from 256. That's your **magic number** (the block size).

Step 3: Count up from 0 in increments of the magic number until you pass the host's value in that octet. The previous increment is the network address.

Step 4: The next increment minus 1 (in the interesting octet) is the broadcast.

**Example:** `192.168.5.130/26`

- Mask: /26 = 255.255.255.192
- Interesting octet: the 4th (192)
- Magic number: 256 − 192 = **64**
- Increments in the 4th octet: 0, 64, 128, 192
- 130 falls between 128 and 192
- **Network: 192.168.5.128**
- **Broadcast: 192.168.5.191**
- **Usable hosts: 192.168.5.129 – 192.168.5.190** (126 hosts)
- **Host count: 2⁶ − 2 = 62** wait — let me redo: /26 leaves 6 host bits, 2⁶ = 64, minus 2 = **62 usable hosts**

Hold on. Let me recount that range: 129, 130, 131 … 190. That's 190 − 129 + 1 = 62. Math checks. *Always recount. Off-by-one is how you fail PBQs.*

**The −2 rule:** every subnet loses 2 addresses — the network address (all host bits 0) and the broadcast (all host bits 1). A /30 has 4 addresses, only 2 usable. A /31 is a special case (RFC 3021, point-to-point links, both addresses usable).

### Common CIDR cheat sheet — memorize this

| CIDR | Mask | Hosts | Block size |
|------|------|-------|-----------|
| /24 | 255.255.255.0 | 254 | 256 |
| /25 | 255.255.255.128 | 126 | 128 |
| /26 | 255.255.255.192 | 62 | 64 |
| /27 | 255.255.255.224 | 30 | 32 |
| /28 | 255.255.255.240 | 14 | 16 |
| /29 | 255.255.255.248 | 6 | 8 |
| /30 | 255.255.255.252 | 2 | 4 |
| /23 | 255.255.254.0 | 510 | 2 (in 3rd octet) |
| /22 | 255.255.252.0 | 1022 | 4 (in 3rd octet) |

*Burn this table into your skull. The exam doesn't give it to you.*

### VLSM — Variable Length Subnet Mask

**VLSM** is what makes CIDR useful in practice. Instead of carving a /24 into equal /27s, you can mix sizes: some /29s for point-to-point links, /27s for small offices, /25s for user VLANs. Allocate the biggest subnet first, then the next biggest, then the smallest — always from the largest power of 2 down.

**Example:** You have 192.168.10.0/24. You need:
- 1 subnet of 100 hosts → needs /25 (126 hosts) → **192.168.10.0/25** (0–127)
- 1 subnet of 50 hosts → needs /26 (62 hosts) → **192.168.10.128/26** (128–191)
- 1 subnet of 20 hosts → needs /27 (30 hosts) → **192.168.10.192/27** (192–223)
- 2 subnets of 2 hosts (WAN links) → needs /30 each → **192.168.10.224/30** and **192.168.10.228/30**

Without VLSM, you'd waste hundreds of addresses giving every WAN link a /24. *VLSM is why your home /24 doesn't run out, and why ISPs can hand out /29s instead of /24s.*

### CompTIA exam traps

> **Trap 1:** A /31 has zero "usable" hosts by the −2 rule, but RFC 3021 allows /31 on point-to-point links with both addresses usable. CompTIA usually wants the **−2 answer** unless the question explicitly mentions RFC 3021 or P2P.

> **Trap 2:** The network address and broadcast address are **not** assignable to hosts. If the question says "first available host," it's network+1, not network.

> **Trap 3:** `127.0.0.0/8` is loopback — the entire /8, not just 127.0.0.1. Pinging 127.0.0.2 also works on most stacks.

> **Trap 4:** APIPA is 169.254.0.0/16 but the **usable** range excludes 169.254.0.0/16's first and last /16 sub-ranges (169.254.0.x and 169.254.255.x are reserved). For the exam: 169.254.x.x = DHCP failed.

> **Trap 5:** Class D (224–239) is multicast, Class E (240–255) is reserved. Neither is for hosts. If you see 230.1.1.1 as a "host," it's wrong.

## Helpdesk reality

- User says: "I can't get to the internet." You check `ipconfig`. Address is `169.254.84.22`. **DHCP failed.** Don't troubleshoot DNS. Don't reset the browser. Fix DHCP.
- User says: "My printer disappeared." You check the printer's IP — it's `192.168.1.50`. User's laptop is on `192.168.2.0/24`. **Different subnets, no inter-VLAN routing.** Either move the laptop or fix the router.
- Never promise: "your IP will never change." DHCP leases expire. Static reservations are the only guarantee.
- Escalate when: subnet math says the design is broken (overlapping subnets, undersized host count). That's a network architect ticket, not a helpdesk fix.
- First question to ask any user with "no internet": **what's your IP address?** 169.254 = DHCP. 0.0.0.0 = no link. 10/172.16-31/192.168 = at least DHCP worked, problem is upstream.

## Related concepts

[[IPv4 Addressing Basics]] · [[IPv6 Addressing]] · [[Subnet Mask And CIDR Notation]] · [[Network Address Translation NAT]] · [[DHCP Operation And Scopes]] · [[VLANs And Inter-VLAN Routing]] · [[Default Gateway And Routing]] · [[APIPA And Link-Local Addresses]] · [[RFC1918 Private Addressing]] · [[Loopback And Localhost]]

*Source: VIRGIL knowledge base — 2026-05-11*