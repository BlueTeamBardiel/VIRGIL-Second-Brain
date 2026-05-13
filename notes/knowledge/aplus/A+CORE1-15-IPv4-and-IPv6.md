# IPv4 and IPv6

## What it is

Every device on a network needs an address, the same way every house on a street needs a number. Without it, the mailman has no idea where to deliver. IP addresses are how packets find their destination across the nervous system of the internet.

**IPv4** is the original — 32 bits, written as four numbers 0–255 separated by dots: `192.168.1.50`. About 4.3 billion possible addresses, which sounded infinite in 1981 and ran out around 2011.

**IPv6** is the replacement — 128 bits, written as eight groups of four hex characters: `2001:0db8:85a3::8a2e:0370:7334`. About 340 undecillion addresses. Enough to assign one to every grain of sand on Earth.

Both still run in parallel on basically every modern network. This is called **dual-stack**, and it's been "temporary" for fifteen years.

## Why it matters

Objective 220-1201 2.6 puts IP addressing inside SOHO configuration, but addressing shows up everywhere — troubleshooting, wireless setup, printer install, VPN config, every networking ticket you'll ever close. If you can't read an IP and tell whether it's public, private, link-local, or self-assigned, you can't troubleshoot a network problem.

The exam loves to show you an address and ask "what does this tell you?" `169.254` → DHCP failed. `10.` → private network. `fe80::` → IPv6 link-local works but routing isn't. The address itself is the diagnostic.

## In your build, in the enterprise

### Beat 1 — The technical layer

An IPv4 address has two parts: **network portion** and **host portion**. The **subnet mask** tells you where the line is. `255.255.255.0` (`/24`) means the first 24 bits are network, the last 8 are host — 254 usable addresses. `255.255.0.0` (`/16`) gives 65,534 hosts. The mask is the ruler that tells your machine which addresses are local versus remote.

The **default gateway** is the router's address on your subnet — the door out. No gateway, no internet. Wrong gateway, no internet.

**Public addresses** are everything outside the private/reserved ranges. Your ISP gives you one public IPv4, and **NAT** translates between your private LAN and that single public address. NAT is why IPv4 hasn't fully died.

**APIPA** — `169.254.0.0/16`. When DHCP fails, Windows assigns itself a link-local address so the stack has *something*. It can't reach the internet. It's the OS saying "I tried, no DHCP answered."

**IPv6** drops NAT entirely — every device gets a public-routable address. Link-local addresses start with `fe80::` and are auto-generated; global addresses come from your ISP's prefix. The `::` shorthand collapses consecutive zero groups. **Static** means you typed it in. **Dynamic** means DHCP (or SLAAC for IPv6) handed it out.

### Beat 2 — Your homelab, Saturday afternoon

You're standing up a homelab on your gaming rig. Proxmox host, three VMs: Plex, Pi-hole, Minecraft for the group.

**The router hands out 192.168.1.x.** Your gaming PC grabs `.47` from DHCP. Plex grabs `.48`. Pi-hole `.49`. Minecraft `.50`. Everyone's happy until the router reboots overnight, leases shuffle, and now your friends' Minecraft bookmark points at the Pi-hole. *Dynamic addressing is fine until something needs to be findable.*

**Fix it with reservations.** In the router's DHCP settings, you bind the Minecraft VM's MAC to `192.168.1.50` permanently. Same for Plex and Pi-hole. Your gaming PC stays dynamic. *DHCP reservation is static addressing without configuring the client. Best of both worlds.*

**Then port forwarding** so friends outside can hit the Minecraft server. Router's WAN side has your ISP-issued public IP. You forward TCP 25565 to `192.168.1.50:25565`. *NAT is the bouncer — it knows which private address asked for what, and only lets the right replies back in.*

**Three weeks later your buddy's connection breaks.** ISP rotated your public IP overnight. Welcome to **CGNAT** and dynamic public IPs — the reason DDNS exists, and the reason businesses pay for static public IPs.

### Beat 3 — Same question, the enterprise

Same fundamental question: *who gets which address, and how do we keep it predictable?* Different scale.

At home: one /24, one DHCP scope, three reservations. At the office: dozens of VLANs, each with its own subnet — `10.10.10.0/24` for users, `10.10.20.0/24` for VoIP, `10.10.30.0/24` for printers, `10.10.99.0/24` for management. Each VLAN has its own DHCP scope on Windows Server or the firewall. Servers get static addresses documented in **IPAM** (IP Address Management) — a database that tracks every address, owner, and purpose. Spreadsheets become tragedies fast at scale.

Public addressing also changes. Home: one ISP-assigned dynamic IPv4. Enterprise: a block of static publics (a /29 or /28) routed to the firewall, with specific addresses dedicated to mail servers, VPN concentrators, and reverse-proxied web apps. Many large networks run dual-stack with proper /48 or /56 IPv6 prefixes.

### Beat 4 — The point

Same question — *who gets what address, who hands it out, who tracks it* — every network you touch. Only the scale and the consequences change. When a ticket says "I can't reach the file server," your first three thoughts are: what's my IP, what's my mask, what's my gateway. That's the job.

## Key facts

### IPv4 address ranges

| Range | Type | Use |
|---|---|---|
| `10.0.0.0/8` | Private (RFC 1918) | Enterprise LANs |
| `172.16.0.0/12` | Private (RFC 1918) | Mid-size networks, Docker |
| `192.168.0.0/16` | Private (RFC 1918) | SOHO, home routers |
| `169.254.0.0/16` | APIPA / link-local | DHCP failed |
| `127.0.0.0/8` | Loopback | `localhost` (`127.0.0.1`) |
| `224.0.0.0/4` | Multicast | One-to-many delivery |
| Everything else | Public | Routable on the internet |

### Common subnet masks

| CIDR | Dotted decimal | Usable hosts |
|---|---|---|
| `/16` | `255.255.0.0` | 65,534 |
| `/24` | `255.255.255.0` | 254 |
| `/25` | `255.255.255.128` | 126 |
| `/26` | `255.255.255.192` | 62 |
| `/27` | `255.255.255.224` | 30 |
| `/30` | `255.255.255.252` | 2 (point-to-point) |

### IPv6 quick reference

| Prefix | Type | Purpose |
|---|---|---|
| `fe80::/10` | Link-local | Auto-generated, single segment only |
| `fc00::/7` | Unique local (ULA) | IPv6's "private" range |
| `2000::/3` | Global unicast | Public, routable |
| `ff00::/8` | Multicast | Replaces IPv4 broadcast |
| `::1` | Loopback | IPv6 `localhost` |

IPv6 has no broadcast — multicast and **neighbor discovery** (NDP) replace ARP. **SLAAC** lets a device generate its own global address from the router's advertised prefix, no DHCP needed. DHCPv6 still exists for central control.

### Static vs dynamic — when to use which

| Scenario | Address type |
|---|---|
| User laptop, phone, printer | Dynamic (DHCP) |
| Server, NAS | Static or DHCP reservation |
| Router, switch, firewall management | Static |
| Anything with a port forward pointing at it | Static or reservation |
| Public-facing web/mail server | Static public |

### CompTIA exam traps

> **CompTIA exam trap:** `169.254.x.x` does NOT mean "no network." Layer 1 and 2 are fine; layer 3 (DHCP) failed. Check the DHCP server, the path to it, and whether DHCP is enabled on that VLAN.

> **CompTIA exam trap:** APIPA addresses can talk to OTHER APIPA devices on the same segment — they're link-local valid. Two Windows machines on a dead-DHCP network can still ping each other on `169.254.x.x`. Useful diagnostic.

> **CompTIA exam trap:** Subnet mask mismatch is silent and brutal. If your PC has `/24` and the gateway has `/25`, you'll reach some hosts and not others with no error. The exam will hand you two configs and ask why a host is unreachable. Read the masks first.

> **CompTIA exam trap:** IPv6 link-local (`fe80::`) is always present on every interface — even ones with no global address. Seeing `fe80::` only means the interface is up, not that IPv6 routing works.

> **CompTIA exam trap:** `127.0.0.1` is loopback, not a real network address. Pinging it only proves the TCP/IP stack is installed. It tells you nothing about the NIC, cable, or network.

## Helpdesk reality

- **"I can't get on the internet."** First move: `ipconfig` (or `ip a` on Linux). Read the IP, mask, gateway. APIPA → DHCP problem. Wrong subnet → static config got fat-fingered. No gateway → router unreachable.
- **"It worked yesterday."** Lease may have expired with DHCP not responding. `ipconfig /release` and `/renew` after confirming the cable is in.
- **"Why does my printer have a weird address?"** Someone set it static years ago and nobody documented it. This is why IPAM exists. Add it to the tool before you close the ticket.
- **"Should I use IPv6?"** On corporate, follow what the network team deployed. On your own homelab, dual-stack is fine. Disabling IPv6 on Windows breaks things — Microsoft assumes it's on. Leave it alone unless a runbook says otherwise.
- **Never promise a user their IP "won't change."** Unless it's a reservation or static, it will. Set the expectation honestly.

## Related concepts

[[DHCP and DNS]] · [[NAT and Port Forwarding]] · [[Subnetting and CIDR]] · [[Common Network Ports]] · [[ipconfig and ping]] · [[SOHO Router Configuration]] · [[VLANs]] · [[Wireless Network Configuration]]

*Source: VIRGIL knowledge base — 2026-05-10*