# Binary Math

## What it is

In **Cyberpunk 2077**, every quickhack you load into your cyberdeck costs RAM, and your deck has a hard cap — say, 16 RAM. You can stack Contagion (3), Short Circuit (2), and Ping (1) and you've spent 6, leaving 10. The deck doesn't care about your intentions; it counts in fixed units, and when you hit zero you can't load another hack. That's binary math. Every IP address, every subnet mask, every routing decision is a fixed-width register of ones and zeros that either fits or doesn't.

In plain English: networking computers don't see `192.168.1.1` — they see `11000000.10101000.00000001.00000001`. The dotted-decimal is human convenience. The binary is the actual address. If you can't convert between them, you can't subnet, you can't read a mask, and you can't pass [[Subnetting]] questions on the N10-009.

Technical definition: an IPv4 address is a 32-bit binary number, written as four 8-bit octets separated by dots. Each octet ranges from `00000000` (0) to `11111111` (255). The subnet mask uses the same 32-bit format to mark which bits are network and which are host. Binary math — specifically powers of two, bitwise AND, and place-value conversion — is the arithmetic underlying every IPv4 operation.

## Why it matters

Objective **N10-009 1.7** is the IPv4 addressing objective, and roughly a third of the questions on it require you to do binary in your head or on scratch paper. Subnetting, [[CIDR]], [[VLSM]], identifying network vs. broadcast addresses, calculating host counts — none of it works without binary fluency.

On the job, you'll do this when you carve up a /24 into smaller subnets for a branch office, when you read a firewall ACL written in CIDR, when you troubleshoot why a host can't reach its gateway (wrong mask, wrong subnet), and when a junior tech swears the printer is on the same network as the workstation and you have to prove with binary that it isn't.

*If you skip binary you'll memorize a cheat sheet, pass the exam by luck, and then freeze the first time a real subnet question lands in your ticket queue.*

## Key facts

### The eight bits of an octet

Each octet is 8 bits. Each bit position has a place value, doubling left to right's inverse — the leftmost bit is worth the most:

| Bit position | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|---|
| **Place value** | 128 | 64 | 32 | 16 | 8 | 4 | 2 | 1 |

Memorize this row. It's the only table you need. To convert binary to decimal, add the place values where there's a 1.

`11000000` = 128 + 64 = **192**
`10101000` = 128 + 32 + 8 = **168**
`11111111` = 128+64+32+16+8+4+2+1 = **255**
`00000000` = **0**

To go decimal to binary, subtract from left to right. Convert 200:
- 200 ≥ 128? Yes. 200 − 128 = 72. Bit 1 = 1.
- 72 ≥ 64? Yes. 72 − 64 = 8. Bit 2 = 1.
- 8 ≥ 32? No. Bit 3 = 0.
- 8 ≥ 16? No. Bit 4 = 0.
- 8 ≥ 8? Yes. 8 − 8 = 0. Bit 5 = 1.
- Rest are 0.

200 = `11001000`. Done in under ten seconds with practice.

### Powers of two — the cheat row that isn't cheating

| 2^n | Value | What it counts |
|---|---|---|
| 2^0 | 1 | |
| 2^1 | 2 | |
| 2^2 | 4 | |
| 2^3 | 8 | |
| 2^4 | 16 | |
| 2^5 | 32 | |
| 2^6 | 64 | |
| 2^7 | 128 | |
| 2^8 | 256 | hosts in /24 (minus 2) |
| 2^16 | 65,536 | hosts in /16 (minus 2) |
| 2^24 | 16,777,216 | hosts in /8 (minus 2) |

The **minus 2** is the network address (all host bits 0) and the broadcast address (all host bits 1). CompTIA tests this constantly.

### The mask is a binary fence

A subnet mask is 32 bits where the network bits are 1 and host bits are 0. The bits must be **contiguous from the left** — `11111111.11111111.11111111.00000000` is legal (/24). `11111111.00000000.11111111.00000000` is not.

| CIDR | Mask | Network bits | Host bits | Usable hosts |
|---|---|---|---|---|
| /8 | 255.0.0.0 | 8 | 24 | 16,777,214 |
| /16 | 255.255.0.0 | 16 | 16 | 65,534 |
| /24 | 255.255.255.0 | 24 | 8 | 254 |
| /25 | 255.255.255.128 | 25 | 7 | 126 |
| /26 | 255.255.255.192 | 26 | 6 | 62 |
| /27 | 255.255.255.224 | 27 | 5 | 30 |
| /28 | 255.255.255.240 | 28 | 4 | 14 |
| /29 | 255.255.255.248 | 29 | 3 | 6 |
| /30 | 255.255.255.252 | 30 | 2 | 2 |

The octet values for masks come from the leftmost bits set: `10000000`=128, `11000000`=192, `11100000`=224, `11110000`=240, `11111000`=248, `11111100`=252, `11111110`=254, `11111111`=255. That's the only sequence a mask octet can be.

### Bitwise AND — how a host finds its network

To determine which network a host belongs to, the OS does a bitwise AND between the IP and the mask. Where both bits are 1, result is 1. Otherwise 0.

Host `192.168.1.137` with mask `/26` (255.255.255.192):

```
IP:    11000000.10101000.00000001.10001001
Mask:  11111111.11111111.11111111.11000000
AND:   11000000.10101000.00000001.10000000
       = 192.168.1.128
```

The host lives on the `192.168.1.128/26` network. Broadcast is `192.168.1.191`. Usable range: `.129–.190`. The router does this calculation for every packet it forwards.

### IPv4 classes — historical, but the exam still asks

Before [[CIDR]] (1993), IPv4 was divided into fixed classes by the leading bits of the first octet:

| Class | Leading bits | First octet range | Default mask | Purpose |
|---|---|---|---|---|
| **A** | 0 | 1–126 | /8 | Huge networks |
| **B** | 10 | 128–191 | /16 | Medium networks |
| **C** | 110 | 192–223 | /24 | Small networks |
| **D** | 1110 | 224–239 | n/a | Multicast |
| **E** | 1111 | 240–255 | n/a | Experimental/reserved |

127.x.x.x is the [[Loopback]] range — `127.0.0.1` is localhost, the address a host uses to talk to itself. It's carved out of what would've been Class A.

### Public vs. private — RFC 1918

[[RFC 1918]] reserves three ranges as **private** — non-routable on the public Internet, free to use inside any organization, translated to a public IP by [[NAT]] at the edge:

| Class | Private range | CIDR |
|---|---|---|
| A | 10.0.0.0 – 10.255.255.255 | 10.0.0.0/8 |
| B | 172.16.0.0 – 172.31.255.255 | 172.16.0.0/12 |
| C | 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 |

Everything else (with rare reserved exceptions) is public — globally routable, assigned by a regional registry, owned by an ISP or organization.

### APIPA — the IP your machine assigns itself when DHCP fails

[[APIPA]] (Automatic Private IP Addressing) is the `169.254.0.0/16` range. When a Windows or macOS host boots, asks DHCP for an address, and gets no reply, it picks a random address in 169.254.x.x and ARPs to make sure no one else has it. *If you see 169.254 on a workstation, the DHCP server is unreachable — that's the entire diagnosis.* The host can talk to others on the same broken segment but cannot reach a gateway or DNS, because APIPA has no gateway.

### CIDR and VLSM — the cure for classful waste

[[CIDR]] (Classless Inter-Domain Routing) ditches the class system. Any prefix length /1 through /32 is legal. `203.0.113.64/27` is a valid 30-host network even though 203.x is "Class C" historically.

[[VLSM]] (Variable Length Subnet Mask) means using different prefix lengths inside one organization to match actual host counts. Branch office of 50 users gets a /26 (62 hosts). Point-to-point WAN link gets a /30 (2 hosts). Server VLAN with 200 hosts gets a /24. *Pre-VLSM, you'd waste a /24 on every WAN link and run out of address space in a month.*

### CompTIA exam traps

> **CompTIA exam trap:** The first and last addresses in a subnet are NOT usable hosts. /24 has 256 addresses but 254 usable. /30 has 4 addresses but only 2 usable (which is why /30 is the standard for point-to-point WAN links — exactly two endpoints).

> **CompTIA exam trap:** 127.0.0.0/8 is loopback, NOT a Class A public range. The first octet "1–126" for Class A skips 127 deliberately. A question that lists 127.x.x.x as a Class A assignable address is wrong.

> **CompTIA exam trap:** APIPA (169.254.x.x) is not [[RFC 1918]] private space. It's a separate reservation (RFC 3927) for link-local self-assignment. CompTIA loves to list it as a private range option to bait you.

> **CompTIA exam trap:** A subnet mask's 1-bits must be contiguous from the left. `255.255.0.255` is invalid. If you see it on the exam, it's wrong.

## Helpdesk reality

- User says "the internet doesn't work." Tech runs `ipconfig`. Sees `169.254.83.12`. That's not an internet problem — that's APIPA, which means the DHCP request failed. Check the cable, the switchport, the DHCP server, in that order.
- User says "I can ping the gateway but not Google." Their IP and mask are fine, [[DNS]] is broken. Binary math is not the issue — but you had to do the binary to rule it out.
- Never promise a user "I'll get you a static IP" before checking the DHCP scope. Static IPs inside the DHCP range cause conflicts the moment the lease pool rolls around to that number.
- "The printer is on the same network as my PC." PC is `10.0.5.40/24`, printer is `10.0.6.12/24`. Different third octet, /24 mask — different networks. The user is wrong. Show them the AND if they argue.
- If you can't do binary in your head by month three on the job, you'll lose every subnet argument with the network team. Practice it like you practice headshots.

## Related concepts

[[Subnetting]] · [[CIDR]] · [[VLSM]] · [[RFC 1918]] · [[APIPA]] · [[Loopback]] · [[IPv4 Address Classes]] · [[Subnet Mask]] · [[NAT]] · [[DHCP]] · [[IPv6 Addressing]]

*Source: VIRGIL knowledge base — 2026-05-11*