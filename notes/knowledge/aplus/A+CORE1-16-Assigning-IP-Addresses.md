# Assigning IP Addresses

## What it is

Every device on a network needs an address. No address, no conversation. The router doesn't know where to send the packet, the packet dies, your game disconnects, your Zoom freezes, the user calls the helpdesk.

An **IP address** is the network identity of a device — the equivalent of a street address for a house. The **subnet mask** tells the device which other addresses are on the same street (local) versus across town (remote). The **default gateway** is the address of the router that handles everything not local — the on-ramp to the rest of the world.

Technically: an IP address is a logical Layer 3 identifier in the TCP/IP stack. IPv4 is 32 bits, written as four octets (192.168.1.50). IPv6 is 128 bits, written as eight hex groups (2001:db8::1). The subnet mask (or CIDR prefix) defines the network/host boundary. The gateway is the next-hop router for any destination outside the local subnet.

Devices get addresses one of three ways: **statically** (you typed it in), **dynamically** (DHCP handed it out), or **APIPA** (DHCP failed and the device assigned itself a 169.254.x.x address as a last resort). That last one is almost always bad news.

## Why it matters

IP addressing is the foundation of every network conversation. A tech who can't read an `ipconfig` output and immediately spot what's wrong is a tech who can't troubleshoot networks. CompTIA tests this hard — Objective 220-1201 2.6 explicitly calls out IPv4 public/private, IPv6, APIPA, static vs dynamic, subnet mask, and gateway.

In your career, the first thing you'll do for any "internet is broken" ticket is check the IP config. Got a real address? Got a gateway? Can you ping the gateway? That sequence resolves a huge percentage of tickets before you escalate to anyone.

## In your build, in the enterprise

**Beat 1 — the technical layer.**

IPv4 has three private ranges defined by RFC 1918, and you will memorize these because the exam tests them and the job demands them:

| Range | CIDR | Typical use |
|---|---|---|
| 10.0.0.0 – 10.255.255.255 | /8 | Large enterprise |
| 172.16.0.0 – 172.31.255.255 | /12 | Mid-size networks |
| 192.168.0.0 – 192.168.255.255 | /16 | Home routers, small office |

Anything outside these ranges (and not reserved) is a public address — globally routable on the internet. Your home router has one public IP from your ISP and translates the dozens of private addresses inside your house through it via NAT.

**APIPA** is 169.254.0.0/16. When a device is set to DHCP and the DHCP server doesn't answer, Windows (and most modern OSes) self-assign from this range so the NIC at least has *something*. APIPA addresses can talk to other APIPA devices on the same switch, but there's no gateway, no DNS, no internet. Seeing 169.254 in `ipconfig` means "DHCP failed."

**IPv6** is 128 bits, eliminates the address shortage, and is already running on your phone and laptop right now whether you noticed or not. Link-local addresses start with `fe80::` — IPv6's equivalent of APIPA, but always present, always functional, used for neighbor discovery.

**Beat 2 — Feynman, your gaming PC.**

You finish the build, boot Windows, plug in the Ethernet, and load Steam. Behind the scenes:

**DHCP discovery:** Your NIC shouts `DHCPDISCOVER` onto the LAN as a broadcast. Your router answers with `DHCPOFFER` — "here's 192.168.1.50, mask 255.255.255.0, gateway 192.168.1.1, DNS 1.1.1.1, lease 24 hours." Your PC says `DHCPREQUEST`, the router says `DHCPACK`, and you're online. *Four-step handshake. DORA. Discover, Offer, Request, Acknowledge.*

**Subnet mask in action:** You try to ping your roommate's PC at 192.168.1.51. Your machine ANDs both addresses against the mask 255.255.255.0, sees both end up at 192.168.1.0, concludes "same network," and sends the packet directly via switch. *Mask answers one question: is this local or remote?*

**Gateway in action:** Now you load `steampowered.com` — that resolves to a public IP nowhere near 192.168.1.x. The mask says "remote." Your PC hands the packet to 192.168.1.1, the router NATs it, and sends it out the WAN port. *Gateway is the door out of the LAN.*

**The kicker:** You unplug Ethernet, the lease expires, you plug back in but the router is rebooting. `ipconfig` shows 169.254.88.12. No internet. *APIPA isn't a feature you use — it's a symptom you diagnose.* Check the router, check the cable, check that DHCP is actually running.

**Beat 3 — bridge to the enterprise.**

Same fundamental question — "how does this device get an address?" — different right answer depending on context.

**Your gaming PC:** DHCP from the home router. You never think about it. The router runs DHCP, DNS forwarding, and NAT all in one little plastic box. Lease times are 24 hours, the IP might change after a reboot, you don't care.

**Your homelab server:** You want it static — or more precisely, you want a **DHCP reservation**. The MAC address of the server is bound to a specific IP in the router's DHCP table, so the server gets the same address every time without you typing it into the server itself. Best of both worlds: central management, predictable address.

**Your office workstation:** DHCP from a Windows Server or a dedicated appliance. The DHCP scope is 10.20.30.100–10.20.30.250, lease 8 days, options push gateway, DNS (the domain controllers), WINS if you're unlucky enough to still run it, and the domain search suffix. You will never touch this config as a Tier 1 tech, but you'll read it constantly while troubleshooting.

**The data center:** Servers, switches, routers, printers, and anything that hosts services get **static** IPs — typed into the device, documented in IPAM (IP Address Management) software, and never given out by DHCP. Why? Because if your DNS server changes IP every Tuesday, nothing on the network can resolve names, and the whole environment falls over. Infrastructure must be predictable.

**Beat 4 — the point.**

Same fundamental question, different workloads, different right answers. *Workstations and laptops get DHCP. Servers and infrastructure get static. Endpoints that need a known address but mobile config get a DHCP reservation.* Get this triage into your bones — when you walk into any new environment, you'll know within five minutes how addresses are assigned and what's broken when they're not.

## Key facts

### IPv4 essentials

- 32-bit address, four octets (0–255 each)
- Written as dotted decimal: 192.168.1.50
- Subnet mask defines network vs host portion
- Address + mask + gateway = the minimum to talk past the LAN

### Private vs public

| Type | Use | Example |
|---|---|---|
| Public | Routable on the internet, assigned by ISP/registrar | 8.8.8.8, 140.82.121.4 |
| Private (RFC 1918) | Internal only, NAT'd to public | 192.168.1.50 |
| Loopback | The device itself | 127.0.0.1 |
| APIPA | DHCP failure self-assignment | 169.254.5.22 |

### Subnet mask cheat sheet

| Mask | CIDR | Hosts |
|---|---|---|
| 255.0.0.0 | /8 | ~16.7M |
| 255.255.0.0 | /16 | ~65K |
| 255.255.255.0 | /24 | 254 |
| 255.255.255.128 | /25 | 126 |
| 255.255.255.192 | /26 | 62 |
| 255.255.255.224 | /27 | 30 |
| 255.255.255.240 | /28 | 14 |

The /24 (255.255.255.0) is the home-and-small-office default. Memorize it cold.

### Static vs dynamic vs APIPA

| Method | How | When to use |
|---|---|---|
| Static | Manually configured in OS/device | Servers, printers, infrastructure, network gear |
| Dynamic (DHCP) | Server hands out address, mask, gateway, DNS | Workstations, laptops, phones, IoT |
| Reservation | DHCP server bound to MAC, same IP every time | Network printers, NAS, devices needing both |
| APIPA | OS self-assigns 169.254.x.x | Never on purpose — it's a failure indicator |

### IPv6 quick hits

- 128-bit address, eight groups of four hex digits
- Full: `2001:0db8:0000:0000:0000:0000:0000:0001`
- Compressed (drop leading zeros, `::` for one run of zeros): `2001:db8::1`
- `fe80::/10` — link-local, every IPv6 interface has one, like APIPA but functional
- `::1` — loopback (IPv6 equivalent of 127.0.0.1)
- No NAT in IPv6 — every device can have a globally routable address (firewall still required)
- No broadcast — uses multicast instead

### Default gateway

- The address of the router on your local subnet
- Usually `.1` or `.254` of the subnet by convention (not a rule)
- Without a gateway, traffic stays local — you can ping the LAN but not the internet
- A wrong gateway is one of the most common static-config mistakes

### CompTIA exam traps

> **CompTIA exam trap:** APIPA is 169.254.0.0/16, NOT a private RFC 1918 range. The exam will list 169.254.x.x alongside 10.x, 172.16–31.x, and 192.168.x and ask which is private. APIPA is *self-assigned* — different category.

> **CompTIA exam trap:** "Static" doesn't mean "permanent" — it means manually configured in the device. A DHCP reservation is dynamic assignment with a fixed result, not a static address. Read the question carefully.

> **CompTIA exam trap:** Loopback is 127.0.0.1 in IPv4, `::1` in IPv6. The exam loves to slip a `127.x.x.x` answer into a private-address question. Loopback is its own category.

> **CompTIA exam trap:** A device with an APIPA address can communicate with other APIPA devices on the same Layer 2 segment, but cannot reach the internet, the gateway, or DNS. The exam wants you to know APIPA = "DHCP broken, isolate the cause."

## Helpdesk reality

- **"My internet is down."** → First move: `ipconfig /all`. Got a real address with a gateway? Ping the gateway. No address or 169.254? DHCP failed — check cable, check router, try `ipconfig /release` and `/renew`.
- **"I can reach the printer but not the internet."** → Subnet mask or gateway wrong. They're talking to the LAN fine; the door out is broken. Check the gateway field.
- **"I can browse by IP but not by name."** → Not an IP problem, that's DNS. Different ticket. But you found it in 30 seconds because you checked the IP config first.
- **"The new server can't be reached."** → Did someone hand it a static IP that overlaps with something else on the network? IP conflicts cause intermittent, weird, hard-to-reproduce failures. Check the DHCP scope and IPAM.
- **Never promise a static IP to an end user without checking your IPAM and DHCP scope.** Handing out an address inside the active DHCP range guarantees a future conflict. That's tomorrow's ticket with your name on it.

## Related concepts

[[DHCP]] · [[DNS]] · [[NAT]] · [[Subnetting]] · [[IPv6 Addressing]] · [[Default Gateway and Routing]] · [[ipconfig and Network Troubleshooting Commands]] · [[SOHO Router Configuration]]

*Source: VIRGIL knowledge base — 2026-05-10*