# Introduction to IP

## What it is

Every device on a network needs an address, the same way every house on a street needs a number. The mail carrier doesn't memorize who lives where — she reads the number on the mailbox. Your router does the same thing with packets.

In plain English: an IP address is a number assigned to a device so other devices can find it on a network. No address, no conversation. The network stack — the machine's voice and ears — uses these addresses to know who's talking and who's listening.

Technically: **Internet Protocol (IP)** is the Layer 3 (Network layer) addressing and routing protocol that moves packets between hosts across networks. Two versions are in production: **IPv4** (32-bit, written as four decimal octets like `192.168.1.50`) and **IPv6** (128-bit, written as eight groups of hex like `2001:0db8:85a3::8a2e:0370:7334`). Every packet that crosses your router carries a source IP and a destination IP. That's how the internet works.

## Why it matters

This is the foundation. You cannot troubleshoot a network problem, configure a router, set up a printer, or pass the A+ without knowing how IP addressing works. CompTIA tests this on **Objective 220-1201 2.6** — configuring SOHO networks — and the concepts ripple through every other networking objective: DNS (3.1), DHCP (2.4), wireless (2.3), and troubleshooting (5.7).

Career relevance: your first ticket as a helpdesk tech will involve someone whose laptop "can't get on the internet." Half the time it's an IP problem — wrong subnet, no DHCP lease, APIPA address, gateway unreachable. If you can read `ipconfig /all` and understand what you're seeing, you fix the ticket. If you can't, you escalate. Tier 1 vs. Tier 2 starts here.

## In your build, in the enterprise

**Beat 1 — Technical depth.**

IPv4 is 32 bits, giving roughly 4.3 billion addresses. We ran out years ago — that's why IPv6 (128 bits, 340 undecillion addresses) exists, and why **NAT** (Network Address Translation) keeps IPv4 alive by letting one public IP cover an entire private network.

Address ranges you must memorize:

- **Private IPv4** (RFC 1918, never routed on the public internet):
  - `10.0.0.0/8` — `10.0.0.0` to `10.255.255.255`
  - `172.16.0.0/12` — `172.16.0.0` to `172.31.255.255`
  - `192.168.0.0/16` — `192.168.0.0` to `192.168.255.255`
- **APIPA** (Automatic Private IP Addressing): `169.254.0.0/16` — assigned by the host itself when DHCP fails. *If you see a 169.254 address, the machine could not reach a DHCP server.*
- **Loopback**: `127.0.0.1` — the machine talking to itself.
- **Public**: everything else.

Every host needs four things to talk on a network: an **IP address**, a **subnet mask** (tells the host which addresses are local vs. remote — `255.255.255.0` means the first three octets define the local network), a **default gateway** (the router's IP — where packets go when the destination isn't local), and **DNS servers** (to translate names to IPs).

Addresses come from one of two sources: **static** (manually typed in, never changes) or **dynamic** (handed out by a DHCP server with a lease time).

**Beat 2 — Feynman example via the gaming PC.**

You're building a gaming PC. You plug in the Ethernet cable, Windows boots, and you're online. You never thought about an IP address. Here's what actually happened:

**DHCP handshake:** Your PC shouted "anyone got an address for me?" on the local segment. Your router answered with `192.168.1.50`, subnet mask `255.255.255.0`, gateway `192.168.1.1`, DNS `192.168.1.1`. Lease: 24 hours. *You never saw it because it took 200 milliseconds.*

**The subnet mask doing its job:** You open Steam. Steam wants to talk to `23.45.112.8` (a CDN server). Your PC checks: is that in `192.168.1.0/24`? No. *Send it to the gateway and let the router figure it out.* You ping your buddy's PC at `192.168.1.51` for a LAN game — same subnet, no gateway needed, packet goes straight across the switch.

**APIPA, the failure tell:** Router reboots mid-match. Lease expires before it comes back. Your PC tries DHCP, no answer, falls back to `169.254.74.22`. Steam disconnects. You run `ipconfig`, see the 169.254 address, and immediately know: *DHCP is down, not the internet, not my NIC.* You reboot the router, run `ipconfig /release && ipconfig /renew`, and you're back.

**Static IPs for the homelab:** You add a Proxmox box. You give it `192.168.1.10` static — outside the DHCP pool — because you want to SSH to the same address every time. *Servers get static. Clients get dynamic. That rule scales from your closet to a Fortune 500 datacenter.*

**Beat 3 — Bridge from gaming to enterprise.**

Same fundamental question — *where do addresses come from, and which devices get static vs. dynamic?* — different scale.

At home: one `/24` subnet (254 usable addresses), one router doing DHCP and NAT, one public IP from your ISP that NATs the whole house. You set static reservations on your NAS and Proxmox host through the router's web UI. Done in five minutes.

In the enterprise: dozens or hundreds of **VLANs**, each its own subnet. The user VLAN might be `10.20.0.0/22` (1,022 hosts). The server VLAN is `10.30.10.0/24`. Printers live on `10.40.0.0/24`. VoIP phones on `10.50.0.0/24`. Each VLAN has its own DHCP scope on a Windows Server or appliance, with reservations tied to MAC addresses. Servers, switches, printers, APs, and anything with a management interface gets a static IP — documented in IPAM (IP Address Management software) so two techs don't assign the same address and cause a duplicate-IP outage at 3 AM.

Public IP: at home, one. In the enterprise, a block of public IPs assigned by the ISP or ARIN, mapped via NAT/PAT to internal services, with the perimeter firewall doing the translation.

**Beat 4 — The point.**

Same question — *static or dynamic, public or private, which subnet?* — different right answers depending on scale and role. The home network and the enterprise network run the same protocol. The difference is documentation, segmentation, and the consequences of getting it wrong. Get this question into your bones — you'll ask it on every network ticket for the rest of your career.

## Key facts

### IPv4 vs IPv6

| Feature | IPv4 | IPv6 |
|---|---|---|
| Length | 32 bits | 128 bits |
| Notation | Dotted decimal (`192.168.1.1`) | Colon hex (`2001:db8::1`) |
| Address count | ~4.3 billion | ~340 undecillion |
| Header | Variable, with checksum | Fixed 40 bytes, no checksum |
| NAT | Required (we ran out) | Not needed (plenty of addresses) |
| Auto-config | DHCP or APIPA | SLAAC or DHCPv6 |
| Loopback | `127.0.0.1` | `::1` |
| Private/local | RFC 1918 ranges | `fc00::/7` (unique local), `fe80::/10` (link-local) |

IPv6 link-local (`fe80::/10`) is the IPv6 equivalent of APIPA — auto-assigned, only valid on the local segment. Every IPv6-enabled interface has one whether you configure it or not.

### The four required values on every host

| Value | What it does | Example |
|---|---|---|
| IP address | Identifies this host | `192.168.1.50` |
| Subnet mask | Defines the local network boundary | `255.255.255.0` (or `/24`) |
| Default gateway | Router IP for off-network traffic | `192.168.1.1` |
| DNS server | Resolves names to IPs | `1.1.1.1`, `8.8.8.8` |

Miss any of these and something breaks. No IP — no networking. Wrong mask — partial connectivity, weird routing. No gateway — local works, internet doesn't. No DNS — IPs work, names don't (the classic "internet is down but I can ping 8.8.8.8" ticket).

### Static vs. dynamic

| | Static | Dynamic (DHCP) |
|---|---|---|
| Assignment | Manual | Automatic from DHCP server |
| Use case | Servers, printers, switches, APs, anything you SSH/RDP/manage | Laptops, desktops, phones, IoT |
| Pro | Predictable, no DHCP dependency | Scales, no manual work |
| Con | Manual tracking, risk of duplicates | Address can change, requires DHCP infrastructure |

**DHCP reservation** is the middle ground: the device uses DHCP, but the server is configured to always hand the same MAC address the same IP. Best of both — central management plus predictable address.

### CompTIA exam traps

> **CompTIA exam trap: APIPA means no internet, not no NIC.** A 169.254.x.x address tells you the host's NIC is working and TCP/IP is loaded — it just couldn't reach a DHCP server. Don't replace the network card. Check the cable, the switch port, and the DHCP server.

> **CompTIA exam trap: Subnet mask vs. CIDR notation.** `255.255.255.0` and `/24` are the same thing. CompTIA mixes both. Memorize: `/24 = 255.255.255.0`, `/16 = 255.255.0.0`, `/8 = 255.0.0.0`.

> **CompTIA exam trap: Private addresses are not "secure."** RFC 1918 addresses just aren't routed on the public internet. They're not encrypted, not authenticated, not safer. A compromised laptop on `192.168.1.50` is just as dangerous as one on a public IP.

> **CompTIA exam trap: Default gateway must be on the same subnet as the host.** A host with IP `192.168.1.50/24` and gateway `192.168.2.1` cannot reach the gateway — they're not on the same network. The host can't even ARP for it. Classic misconfiguration.

## Helpdesk reality

- User says "the internet is down." Run `ipconfig /all` first. Look at the IP — is it 169.254? DHCP problem. Is it correct but no gateway response? Router or switch problem. Is everything correct but DNS fails? DNS server problem. *The output of `ipconfig /all` answers 80% of "internet is down" tickets in 30 seconds.*
- User says "I can get to some sites but not others." That's almost never an IP problem — that's DNS, a proxy, or a firewall rule. Don't chase IP. Run `nslookup` against the failing domain.
- "My printer disappeared." The printer was probably on DHCP, got a new lease, and now sits at a different IP. The print queue still points to the old one. Set a DHCP reservation, update the queue, never have this ticket again.
- Two devices with the same static IP — duplicate IP conflict. Both will have intermittent connectivity. Windows pops a notification; most users ignore it. Check IPAM, find the duplicate, fix it.
- Never promise "static IPs are more reliable." They're more *predictable*. They're also more prone to human error. A typo in a subnet mask takes a server offline just as fast as a DHCP outage.

## Related concepts

[[DHCP]] · [[DNS]] · [[NAT and Port Forwarding]] · [[Subnetting and CIDR]] · [[Network Cables and Connectors]] · [[Wireless Standards]] · [[ipconfig and Network Troubleshooting Commands]] · [[VLANs]] · [[Common Network Ports]]

*Source: VIRGIL knowledge base — 2026-05-10*