# Introduction to IP

## What it is

In **FIFA Ultimate Team**, every player card has a unique ID. Messi isn't just "Messi" — he's a specific card with a specific rating, a specific position, a specific chemistry style. When you build a squad, the game has to address each card individually: this CAM goes here, that CDM goes there. Two cards can't occupy the same slot, and the squad-builder has to know exactly which one you're slotting where. Now scale that up. Imagine FIFA had to track every card in every squad in every Ultimate Team account on the planet — and route messages between them. Each card needs a globally unique address, and the system needs rules about which addresses are public (visible to EA's servers) and which are private (only meaningful inside your own club).

That's exactly what **IP addressing** does — give every device on a network a unique address so traffic knows where to go.

**Technical definition:** Internet Protocol (IP) is the Layer 3 protocol that assigns logical addresses to network-attached devices and routes packets between them. IPv4 addresses are 32 bits, written as four dotted decimal octets (e.g., `192.168.1.50`). Every host on a network — local or global — needs an IP to send or receive traffic.

## Why it matters

IP addressing is the single most-tested concept on N10-009 Objective 1.7. CompTIA will throw subnet math, RFC1918 ranges, APIPA, and CIDR notation at you in every form they can. In the field, every ticket you ever work — from "internet is down" to "my printer disappeared" — starts with `ipconfig` or `ip a` and a question: *does this device have a valid address, and is it the right one?* If a tech doesn't know the difference between `192.168.1.5` and `169.254.x.x` at a glance, they can't troubleshoot. Period.

## Key facts

### IPv4 anatomy

A 32-bit address split into 4 octets of 8 bits each. Each octet ranges 0–255. Total possible addresses: ~4.3 billion. We ran out years ago — which is why [[NAT]], [[IPv6]], and [[CIDR]] exist.

Every IPv4 address has two parts:
- **Network portion** — identifies which network the host belongs to
- **Host portion** — identifies the specific device on that network

The [[subnet mask]] tells you where the split is. `255.255.255.0` means the first 3 octets are network, the last is host.

### IPv4 address classes (the classful system)

Before CIDR, IPv4 was divided into rigid classes based on the first octet:

| Class | First octet range | Default mask | Networks | Hosts/network | Purpose |
|-------|-------------------|--------------|----------|---------------|---------|
| **A** | 1–126 | /8 (255.0.0.0) | 126 | ~16.7M | Massive orgs (HP, MIT, DoD) |
| **B** | 128–191 | /16 (255.255.0.0) | ~16K | ~65K | Large enterprises, universities |
| **C** | 192–223 | /24 (255.255.255.0) | ~2M | 254 | Small networks, most SOHO |
| **D** | 224–239 | n/a | n/a | n/a | **Multicast** (one-to-many) |
| **E** | 240–255 | n/a | n/a | n/a | **Experimental/reserved** |

Note that **127.x.x.x is missing from Class A** — it's reserved for loopback. And Class D/E aren't assigned to hosts; they have special jobs.

*Classful addressing is dead in practice — everyone uses CIDR now — but CompTIA still tests the class boundaries because they appear in defaults, RFCs, and legacy gear.*

### RFC1918 — private address space

RFC1918 carved out three blocks for **private use** — addresses that are never routed on the public internet. These are the addresses inside your home, your office, your data center LAN.

| Class | RFC1918 range | CIDR | Hosts |
|-------|---------------|------|-------|
| A | 10.0.0.0 – 10.255.255.255 | 10.0.0.0/8 | ~16.7M |
| B | 172.16.0.0 – 172.31.255.255 | 172.16.0.0/12 | ~1M |
| C | 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 | ~65K |

That `172.16–172.31` range is the one people forget. CompTIA loves it.

**Public** = anything not RFC1918, not loopback, not APIPA, not multicast/experimental. Public addresses are globally routable and assigned by your ISP (or IANA upstream). Your router uses [[NAT]] to translate private LAN traffic to its one public IP.

### Loopback / localhost

`127.0.0.1` — the entire `127.0.0.0/8` block, technically. This is the **loopback** address. Traffic sent here never leaves the device. It bounces off the network stack and comes right back.

```
ping 127.0.0.1
```

If that fails, the TCP/IP stack on the machine is broken. Reinstall. If it succeeds but nothing else works, the stack is fine — your problem is elsewhere (cable, DHCP, gateway, DNS). Loopback is your **first sanity check**.

`localhost` is the hostname that resolves to `127.0.0.1` via the hosts file. Same thing, friendlier name.

### APIPA — when DHCP fails

If a device is set to DHCP but can't reach a DHCP server, Windows (and most OSes) auto-assigns from **169.254.0.0/16**. This is **APIPA** (Automatic Private IP Addressing).

| Symptom | What it means |
|---------|---------------|
| `169.254.x.x` on `ipconfig` | DHCP failed. The device gave up and self-assigned. |
| No internet | Correct — APIPA isn't routable. No gateway, no DNS. |
| Other APIPA devices on same segment can talk | Yes — link-local communication works among APIPA hosts |

**Causes:** DHCP server down, scope exhausted, broken cable to the DHCP path, VLAN misconfiguration, rogue DHCP failing to respond, firewall blocking DHCP (UDP 67/68).

*When you see 169.254 on a user's machine, you don't need to ask what's wrong — you already know. DHCP didn't answer. Now find out why.*

### Subnetting — slicing networks into smaller networks

A `/24` gives you 256 addresses (254 usable — subtract network and broadcast). What if you need eight separate networks of 30 hosts each? You **subnet** — borrow bits from the host portion to create more network segments.

| CIDR | Mask | Usable hosts | Subnets from /24 |
|------|------|--------------|-------------------|
| /24 | 255.255.255.0 | 254 | 1 |
| /25 | 255.255.255.128 | 126 | 2 |
| /26 | 255.255.255.192 | 62 | 4 |
| /27 | 255.255.255.224 | 30 | 8 |
| /28 | 255.255.255.240 | 14 | 16 |
| /29 | 255.255.255.248 | 6 | 32 |
| /30 | 255.255.255.252 | 2 | 64 (point-to-point links) |

**Formula:** Usable hosts = 2^(host bits) − 2. The minus two is the network address and the broadcast. CompTIA will absolutely test this off-by-two.

### VLSM — Variable Length Subnet Mask

Classful subnetting forced every subnet to be the same size. **VLSM** lets you mix mask lengths within a single network — so a point-to-point WAN link gets a `/30` (2 usable hosts) while a user LAN gets a `/24` (254 usable hosts). No wasted addresses.

VLSM is how you efficiently allocate scarce IPv4 space. Without it, that `/30` WAN link would consume an entire `/24`, burning 252 addresses on a link that needs two.

### CIDR — Classless Inter-Domain Routing

CIDR killed the classful system in 1993. Instead of "this is Class B, so it's /16," you write the prefix length explicitly: `192.168.5.0/24`, `10.50.0.0/13`, `172.16.4.0/22`. The slash is the number of network bits.

CIDR also enables **route summarization** — combining multiple contiguous subnets into a single advertised route. `10.0.0.0/24` + `10.0.1.0/24` + `10.0.2.0/24` + `10.0.3.0/24` summarizes to `10.0.0.0/22`. One route advertisement instead of four. Routing tables stay small. The internet still works.

*Classful is anatomy. CIDR is how the network actually breathes.*

### CompTIA exam traps

> **CompTIA exam trap:** `127.0.0.1` is **not** in any address class for assignment purposes. It looks like it would be Class A (1–126), but 127 is carved out as loopback. The Class A range stops at **126**. If a question asks "what's the highest Class A first octet," the answer is 126, not 127.

> **CompTIA exam trap:** APIPA is `169.254.0.0/16` — **not** RFC1918. RFC1918 is private but routable on internal networks. APIPA is link-local only and means *DHCP failed*. If the question says "the device has 169.254.10.5," the answer is never "this is working as designed."

> **CompTIA exam trap:** The `172.x.x.x` private range is **only 172.16.0.0 through 172.31.255.255**. `172.15.x.x` is public. `172.32.x.x` is public. CompTIA will put a public 172 address in a question and ask if it's RFC1918. The answer depends entirely on that second octet.

> **CompTIA exam trap:** Subtract 2 from your usable host count (network + broadcast). On a `/30`, that's 4 total addresses minus 2 = **2 usable**. Point-to-point links live and die by /30 — memorize it. (RFC 3021 allows /31 for P2P with zero waste, but CompTIA still expects the /30 answer unless the question explicitly says /31.)

## Helpdesk reality

- **"The internet isn't working."** First move: `ipconfig` (Windows) or `ip a` (Linux/Mac). What's the address? If `169.254.x.x` — DHCP failed, escalate or check the cable. If `0.0.0.0` — no link or no driver. If a valid private IP but no internet — check the default gateway and DNS.
- **"I can ping the router but not Google."** Layer 3 to the gateway works. DNS or the WAN link is the problem. `ping 8.8.8.8`. If that works, it's DNS. If it doesn't, the ISP or the gateway's WAN side.
- **"My printer is gone."** Probably grabbed a new DHCP lease and changed IP, or fell back to APIPA. Static-assign printers or use DHCP reservations. *Never trust a printer to keep the same IP without a reservation.*
- **Never promise** "this will work after a reboot." Reboots fix symptoms, not causes. The 169.254 will come back if DHCP is still down.
- **Escalation point:** if loopback works, the NIC has link, but no valid IP arrives — you've ruled out the client. It's a DHCP, VLAN, or upstream switching problem. Hand it to the network team with the `ipconfig /all` output attached.

## Related concepts

[[Subnet Mask]] · [[CIDR Notation]] · [[NAT]] · [[DHCP]] · [[IPv6]] · [[RFC1918]] · [[APIPA]] · [[Loopback]] · [[VLSM]] · [[Default Gateway]] · [[Broadcast Domain]] · [[Public vs Private IP]]

*Source: VIRGIL knowledge base — 2026-05-11*