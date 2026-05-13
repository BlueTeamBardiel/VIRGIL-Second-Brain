# DHCP

## What it is

You bring a new laptop home, plug it into Wi-Fi, and it just works. You didn't type an IP address. You didn't pick a gateway. You didn't tell it where DNS lives. Something handed it all of that in under a second.

That something is **DHCP** — Dynamic Host Configuration Protocol. It's the front desk of the network. A device walks in, asks "who am I?", and DHCP hands it a name tag (IP address), a map (subnet mask), the exit (default gateway), and a phone book (DNS server). The device wears the tag for a while, then either renews or gives it back.

Without DHCP, every device on every network would need a human to manually type four numbers and pray they didn't collide with someone else's four numbers. DHCP killed that job in the 1990s and nobody misses it.

The technical definition: DHCP is a client-server protocol (UDP ports 67 server / 68 client) that automatically assigns IP configuration to devices joining a network. The handshake is **DORA** — Discover, Offer, Request, Acknowledge. Client broadcasts a Discover. Server sends an Offer. Client sends a Request for that offer. Server sends the Acknowledge. Four packets, the device is on the network.

## Why it matters

Every network you'll ever touch runs DHCP. Home routers run it by default. Enterprise networks run it on dedicated Windows Servers or appliances handing out thousands of leases. When DHCP breaks, the helpdesk phone lights up — nobody can get on the network, nobody knows why, and "have you tried unplugging it" actually works because it forces a new DORA handshake.

Exam-wise, this is **Objective 220-1201 2.4** — common network configuration concepts. CompTIA tests the four DHCP vocabulary terms relentlessly: **scope, lease, reservation, exclusion**. Know them cold or lose easy points.

## In your build, in the enterprise

**Beat 1 — Technical depth.** DHCP runs over UDP. The server listens on port 67, the client on port 68. The DORA exchange uses broadcasts because the client doesn't have an IP yet — it can't unicast to anyone. The server's response carries the offered IP, subnet mask, default gateway, DNS servers, lease duration, and optionally domain name, NTP servers, and dozens of other DHCP options. Lease durations vary: 24 hours on a busy guest Wi-Fi, 8 days on a corporate LAN, 30 days on a stable home network. At 50% of the lease, the client tries to renew with the original server (T1). At 87.5%, it broadcasts to any server (T2). If the lease expires, the device drops to **APIPA** (169.254.x.x) and can't talk to anyone outside its own subnet. Seeing 169.254 on `ipconfig` means "DHCP failed, I gave up and named myself."

**Beat 2 — Feynman example via your home network.** You build a gaming rig, plug it into your router, and it picks up 192.168.1.47. Cool.

**The scope:** Your router is configured to hand out 192.168.1.100 through 192.168.1.200. That range is the **scope** — the pool of addresses available to lease. *Scope = the menu of IPs the server is allowed to serve.*

**The lease:** That 192.168.1.47 isn't yours forever. The router gave you a 24-hour lease. At hour 12, your PC quietly renews. You never notice. Reboot the router and your PC will probably get the same IP back, because the router remembers. *Lease = rented, not owned. Renewable.*

**The reservation:** You set up a Plex server on an old box and you need it at the same IP every time so port forwarding doesn't break. You go into the router, find the Plex box's MAC address, and tell DHCP "this MAC always gets 192.168.1.50." That's a **reservation** — DHCP still hands out the address, but it's locked to that specific MAC. *Reservation = static IP, but DHCP is still the one handing it out. Best of both worlds.*

**The exclusion:** Your printer is hard-coded to 192.168.1.150 in its own settings — true static, no DHCP involved. If DHCP doesn't know about it and hands 192.168.1.150 to your phone, you've got an IP conflict and the printer drops off the network. So you tell DHCP "exclude 192.168.1.150 from the scope." DHCP now refuses to lease that address to anyone. *Exclusion = a hole punched in the scope so DHCP stays out of an IP it doesn't manage.*

**Beat 3 — Bridge from home to enterprise.** Same four concepts. Different scale and different stakes.

At home: one router, one scope, maybe two reservations, lease length you'll never think about. Total devices: 30.

In the enterprise: a Windows Server (or two, in failover) running DHCP for a building. Multiple scopes — one per VLAN. The HR VLAN gets 10.20.5.0/24, the engineering VLAN gets 10.20.10.0/24, guest Wi-Fi gets 10.50.0.0/16. Each scope has its own lease duration, its own gateway, its own DNS. **Reservations** are how the file server, the printers, and the conference-room AV gear get predictable addresses without true static configuration — change the IP scheme later, you change it on the DHCP server, not on every device. **Exclusions** carve out ranges for the equipment that *is* truly static: domain controllers, network switches, the firewall. **Scope options** push DNS server addresses, NTP, and PXE boot servers to thousands of clients without anyone touching them.

The big enterprise wrinkle: **DHCP relay** (also called IP helper). DHCP discovery is broadcast — broadcasts don't cross routers. So when the engineering VLAN client broadcasts a Discover, the switch/router at the gateway is configured with `ip helper-address` pointing at the central DHCP server. The router catches the broadcast, repackages it as a unicast to the DHCP server, and forwards the response back. One DHCP server can serve a hundred VLANs this way.

**Beat 4 — The point.** Same four concepts at every scale: scope, lease, reservation, exclusion. *Get this vocabulary into your bones.* When a user calls and says "I can't get on the network," the first thing you check is whether they got a lease — `ipconfig` and look at the IP. If it's 169.254.something, DHCP failed somewhere upstream. If it's a normal address, DHCP is fine and the problem is somewhere else.

## Key facts

### The DORA handshake

| Step | Sender | Type | What happens |
|---|---|---|---|
| **D**iscover | Client | Broadcast | "Anyone got an IP for me?" |
| **O**ffer | Server | Broadcast/unicast | "I've got 192.168.1.47 with these options" |
| **R**equest | Client | Broadcast | "I'll take that one from you specifically" |
| **A**cknowledge | Server | Broadcast/unicast | "Confirmed, it's yours for X hours" |

Memorize **DORA**. CompTIA loves to ask the order.

### The four vocabulary terms

| Term | What it means | Where it lives |
|---|---|---|
| **Scope** | The pool of IPs the DHCP server is allowed to lease | Defined on the DHCP server, one per subnet/VLAN |
| **Lease** | The rental contract — IP + duration | Tracked in the DHCP server's lease database |
| **Reservation** | A specific IP locked to a specific MAC address | Configured on the DHCP server; client gets it via normal DORA |
| **Exclusion** | An IP (or range) the server refuses to lease | Configured on the DHCP server to protect static IPs |

### Reservation vs. exclusion vs. static — the distinction CompTIA tests

- **Reservation:** Device uses DHCP. DHCP gives it the same IP every time based on MAC. Change the IP plan later? Change it once on the server.
- **Exclusion:** Device doesn't use DHCP at all. The IP is configured manually on the device itself. The exclusion just tells DHCP "don't try to give this one out."
- **Static (no exclusion):** Device has a hard-coded IP and DHCP doesn't know. Asking for trouble — DHCP might lease the same IP to something else and cause a conflict.

> **CompTIA exam trap:** A reservation is *not* a static IP. The device still does DORA, still gets a lease, still renews. The server just always picks the same address for that MAC. CompTIA will offer "static IP assignment" as a wrong answer when the right answer is "reservation." If the question mentions DHCP and "always the same IP," the answer is reservation.

> **CompTIA exam trap:** APIPA (169.254.x.x) means DHCP failed. The client gave itself a link-local address. It can talk to other APIPA devices on the same segment, nothing else. If a user reports "I have an IP but no internet" and `ipconfig` shows 169.254.something — that's not really an IP, that's a failure indicator.

### DHCP options worth knowing

DHCP doesn't just hand out IPs. **Options** are extra config delivered in the same handshake:

- **Option 1:** Subnet mask
- **Option 3:** Default gateway
- **Option 6:** DNS servers
- **Option 15:** Domain name
- **Option 51:** Lease duration
- **Option 66/67:** TFTP boot server / boot file (PXE)

You won't memorize option numbers for A+. You will need to know that DHCP delivers more than just the IP — it pushes gateway and DNS, which is why "release/renew" often fixes "I can ping local stuff but the internet is broken."

### Home vs. enterprise DHCP

| Feature | Home router | Enterprise (Windows Server / appliance) |
|---|---|---|
| Scopes | One, hard-coded to LAN subnet | Many — one per VLAN |
| Failover | None — router dies, DHCP dies | DHCP failover pair, split-scope, or clustered |
| Relay | Not needed (one subnet) | `ip helper-address` on every VLAN gateway |
| Reservations | Handful, configured in web UI | Hundreds, scripted via PowerShell |
| Logging | Minimal | Full audit log, fed to SIEM |
| Integration | None | Tied to Active Directory, DNS dynamic updates, NPS for 802.1X |

### Quick troubleshooting commands

```
ipconfig /all          # see your lease, server, options
ipconfig /release      # drop the current lease
ipconfig /renew        # ask for a new one (forces DORA)
```

On Linux: `dhclient -r && dhclient` or `nmcli con down/up`.

## Helpdesk reality

- **"I can't get on the internet."** First check: `ipconfig`. If you see 169.254.x.x, it's a DHCP failure — check the cable, the switch port, the VLAN assignment, or whether the DHCP scope is exhausted. If you see a normal IP, DHCP is fine and you're chasing a different problem.
- **"My printer keeps disappearing from the network."** Printer probably has a static IP that DHCP doesn't know about, and the scope is leasing that IP to something else. Fix: either set a reservation (if the printer can do DHCP) or add an exclusion (if it must stay static).
- **"I rebooted and now nothing works."** Lease didn't renew cleanly. `ipconfig /release` then `ipconfig /renew`. Works embarrassingly often.
- **"DHCP scope is exhausted."** Too many devices, not enough addresses. Either expand the scope, shorten the lease duration so abandoned leases free up faster, or look for a rogue device hoarding addresses (BYOD guest Wi-Fi is the usual suspect).
- **Never promise** that a reservation is "the same as static." It's not. If the DHCP server is down, devices with reservations still won't renew. Truly critical infrastructure (domain controllers, the DHCP server itself) gets static IPs with exclusions, not reservations.

## Related concepts

[[DNS]] · [[VLAN]] · [[VPN]] · [[IP Addressing]] · [[Subnetting]] · [[APIPA]] · [[Default Gateway]] · [[Network Troubleshooting]]

*Source: VIRGIL knowledge base — 2026-05-10*