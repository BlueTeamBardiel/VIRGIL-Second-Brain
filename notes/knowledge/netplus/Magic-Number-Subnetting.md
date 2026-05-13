# Magic Number Subnetting

## What it is

In **Sonic the Hedgehog 2**, the Special Stage half-pipe forces you to grab rings in chunks — every checkpoint demands a specific count, and if you're short by even one ring you fail and get spat back out. You don't have time to count rings one at a time. You learn to read the pattern, see the cluster, and grab the *block* in a single motion. That's exactly what magic number subnetting does — instead of counting hosts one IP at a time, you grab whole subnet blocks in a single jump down the address space.

Magic number subnetting is a mental shortcut for solving [[Subnetting|subnet]] questions in seconds. You take the **octet where the mask isn't /8, /16, or /24**, calculate one number (the "magic number" = 256 minus the mask value in that octet), and use it to enumerate every subnet, network ID, broadcast, and host range without converting anything to binary. It is the single most testable, most time-saving skill on the N10-009 exam for Objective 1.7.

## Why it matters

The exam gives you 90 minutes for up to 90 questions. Spending three minutes converting `/26` to binary on every subnet question will sink you. Working pros don't do binary math at the keyboard either — they use the magic number trick or a subnet calculator. Knowing it cold means you finish the subnet question in 20 seconds and bank time for the scenario questions.

Career relevance: every time you stand up a new VLAN, carve a `/24` into four `/26`s for separate Wi-Fi SSIDs, or troubleshoot why a host is pinging itself but not the gateway, you're doing subnet math in your head. The senior network engineer doesn't pull out a calculator. They look at `192.168.10.130/26` and say "that's in the .128 subnet, broadcast is .191, gateway's probably .129." Magic number is how they got there.

Exam relevance: **Objective 1.7** explicitly tests [[CIDR]], [[VLSM]], [[IPv4 address classes]], private vs. public, [[APIPA]], and [[Loopback]]. You will see "which subnet does this host belong to" questions. You will see "how many usable hosts" questions. You will see "what's the broadcast address" questions. All of them yield to the same trick.

## Key facts

### The magic number, in one move

The **magic number = 256 − (the mask value in the interesting octet)**.

The "interesting octet" is the one where the mask is neither 0 nor 255. For `/26`, the mask is `255.255.255.192`. The interesting octet is the 4th. Magic number = 256 − 192 = **64**.

That 64 is your jump size. Subnets land at 0, 64, 128, 192 in the 4th octet. Done. No binary.

| CIDR | Mask | Interesting octet | Magic number | Subnets in that octet |
|------|------|-------------------|--------------|-----------------------|
| /25 | 255.255.255.128 | 4th | 128 | 0, 128 |
| /26 | 255.255.255.192 | 4th | 64 | 0, 64, 128, 192 |
| /27 | 255.255.255.224 | 4th | 32 | 0, 32, 64, 96, 128, 160, 192, 224 |
| /28 | 255.255.255.240 | 4th | 16 | 0, 16, 32, …, 240 |
| /29 | 255.255.255.248 | 4th | 8 | 0, 8, 16, …, 248 |
| /30 | 255.255.255.252 | 4th | 4 | 0, 4, 8, …, 252 |
| /22 | 255.255.252.0 | 3rd | 4 | 0, 4, 8, …, 252 (in 3rd octet) |
| /21 | 255.255.248.0 | 3rd | 8 | 0, 8, 16, …, 248 (in 3rd octet) |

*If you memorize one table on this page, memorize this one.*

### Solving a question in 20 seconds

**Question:** Host `192.168.10.130/26`. What's the network ID, broadcast, and usable host range?

1. Mask `/26` → magic number 64.
2. Subnets in the 4th octet: 0, 64, 128, 192.
3. `.130` falls between 128 and 192 → network ID is **192.168.10.128**.
4. Broadcast is one less than the next subnet → **192.168.10.191**.
5. Usable hosts: network+1 to broadcast−1 → **.129 through .190**.
6. Host count: 2^(32−26) − 2 = 64 − 2 = **62 usable hosts**.

Six steps. No binary. *Once it clicks, you'll never go back.*

### Host count, fast

Hosts = 2^(host bits) − 2. The −2 is the network ID and the broadcast — neither is assignable.

| CIDR | Host bits | Usable hosts |
|------|-----------|--------------|
| /24 | 8 | 254 |
| /25 | 7 | 126 |
| /26 | 6 | 62 |
| /27 | 5 | 30 |
| /28 | 4 | 14 |
| /29 | 3 | 6 |
| /30 | 2 | 2 (point-to-point links) |
| /31 | 1 | 2 (RFC 3021, P2P only) |
| /32 | 0 | 1 (host route / loopback) |

### IPv4 address classes (legacy, still tested)

Classes are obsolete in practice — [[CIDR|Classless Inter-Domain Routing]] replaced them in 1993 — but CompTIA still tests them.

| Class | First octet | Default mask | Use |
|-------|-------------|--------------|-----|
| A | 1–126 | /8 (255.0.0.0) | Huge networks |
| B | 128–191 | /16 (255.255.0.0) | Medium networks |
| C | 192–223 | /24 (255.255.255.0) | Small networks |
| D | 224–239 | none | Multicast |
| E | 240–255 | none | Experimental/reserved |

127.x.x.x is **not Class A** — it's reserved for [[Loopback]]. 127.0.0.1 is localhost. Pinging it tests the local TCP/IP stack — if loopback fails, the NIC driver or stack is broken before you even leave the machine.

### Private ranges — RFC 1918

Memorize these. They show up on every exam attempt.

| Class | RFC 1918 range | CIDR |
|-------|----------------|------|
| A | 10.0.0.0 – 10.255.255.255 | 10.0.0.0/8 |
| B | 172.16.0.0 – 172.31.255.255 | 172.16.0.0/12 |
| C | 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 |

Private addresses are not routable on the public internet. [[NAT]] translates them to a public address at the edge. *If you see 172.32.x.x on a question, that is public, not private — the Class B private range stops at 172.31.*

### APIPA — the 169.254 tell

**Automatic Private IP Addressing** kicks in when a host requests a [[DHCP]] address and gets no reply. The host self-assigns from **169.254.0.0/16**. APIPA addresses can talk to other APIPA hosts on the same segment but cannot route anywhere — no gateway gets assigned.

*If a user calls and ipconfig shows 169.254.something, the DHCP server is unreachable. That's the entire diagnosis. Check cable, VLAN, DHCP relay, then the DHCP server itself.*

### VLSM — different-sized blocks from one parent

**Variable Length Subnet Mask** means you carve a parent block into subnets of *different* sizes. Take `192.168.1.0/24` and split it:

- `192.168.1.0/25` — 126 hosts (the user LAN)
- `192.168.1.128/26` — 62 hosts (the printer/IoT VLAN)
- `192.168.1.192/27` — 30 hosts (management)
- `192.168.1.224/30` — 2 hosts (router P2P link)
- `192.168.1.228/30` — 2 hosts (another P2P link)
- …

VLSM is how you avoid wasting addresses. Without it, every subnet has to be the same size and a P2P link burns 254 addresses to use 2.

The trick to VLSM: **always allocate the biggest block first**. If you start with the /30s, you'll fragment the space and the /25 won't fit anywhere clean.

### CIDR notation — what the slash actually means

`/X` = the first X bits of the address are network, the remaining 32−X bits are host. CIDR killed classful routing because it lets you summarize routes (`10.0.0.0/8` covers everything starting with 10) and split blocks at any boundary, not just /8, /16, /24.

### CompTIA exam traps

> **CompTIA exam trap:** The /31 mask. Classically /31 has 0 usable hosts (2 addresses, both consumed by network ID and broadcast). RFC 3021 carves out an exception for **point-to-point links** where both addresses are usable. CompTIA may test either the classical answer or the RFC 3021 answer — read the question. If it says "point-to-point WAN link," expect 2 usable.

> **CompTIA exam trap:** 127.0.0.1 is **loopback**, not Class A, even though 127 is in the 1–126/127 numeric range. The 127.0.0.0/8 block is fully reserved. Pinging 127.0.0.1 tests the local stack, not the NIC and not the cable. If 127.0.0.1 fails, reinstall the stack.

> **CompTIA exam trap:** 169.254.x.x is **APIPA**, meaning DHCP failed. It is not a valid manually-assigned range and it does not route. If a question asks "the host has 169.254.1.50 — what's the problem," the answer is always "no DHCP."

> **CompTIA exam trap:** The 172.16.0.0/12 private range. People remember 10.x and 192.168.x but get 172 wrong. It's **172.16 through 172.31**, not 172.16 through 172.32 and not all of 172.x. 172.15 is public. 172.32 is public.

> **CompTIA exam trap:** Subnet broadcast vs. directed broadcast vs. limited broadcast. Limited broadcast is 255.255.255.255 (never routed). Subnet broadcast is the last address in a subnet (e.g., 192.168.10.191 in a /26). The exam will mix these — read carefully.

## Helpdesk reality

- **"My internet is down."** → Run `ipconfig`. If you see `169.254.x.x`, DHCP failed — check the cable, the switchport, the VLAN assignment, the DHCP relay (`ip helper-address`), and the DHCP server scope in that order. The user's machine is fine; the path to the DHCP server isn't.
- **"I can't reach the server but my coworker can."** → Check the subnet mask on both machines. If yours is `/24` and theirs is `/23`, you're on different logical networks even on the same physical wire. Mask mismatch is the silent killer.
- **"Ping to 127.0.0.1 works but I can't browse."** → Loopback proves the TCP/IP stack is alive. Now ping the gateway. Now ping a public IP. Now ping a public hostname. Each step isolates one layer. Never skip steps.
- **Never promise** the user that "a quick reboot will fix it." Reboots paper over DHCP lease issues but don't fix mask misconfigurations, VLAN mismatches, or routing problems. The ticket comes back in 20 minutes.
- **Escalation point:** if the client side is clean (correct IP, correct mask, correct gateway, can ping gateway) and the destination is unreachable, it's a routing or firewall problem upstream. Network team ticket.

## Related concepts

[[Subnetting]] · [[CIDR]] · [[VLSM]] · [[IPv4 Addressing]] · [[Private IP Ranges (RFC 1918)]] · [[APIPA]] · [[Loopback]] · [[DHCP]] · [[NAT]] · [[Default Gateway]] · [[Subnet Mask]] · [[Broadcast Domain]]

*Source: VIRGIL knowledge base — 2026-05-11*