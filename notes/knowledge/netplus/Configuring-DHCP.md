# Configuring DHCP

## What it is

In **Metroid**, every time Samus enters a new area on Zebes, the map fills itself in as she walks. She doesn't carry the map of Brinstar into Norfair — each region hands her a fresh layout the moment she crosses the threshold. Boot up after a save, and the suit re-acquires its bearings: where am I, what's around me, where's the exit. That's exactly what DHCP does — when a device joins a network, a server hands it everything it needs to operate: an address, a gateway, a DNS server, a lease on how long it's allowed to stay.

In plain English: DHCP is the receptionist at the front desk. New device walks in, DHCP assigns it a desk number (IP), tells it which door leads out (default gateway), gives it the company phone book (DNS server), and stamps the badge with an expiration time (lease duration).

Technical definition: **Dynamic Host Configuration Protocol (DHCP)** is a UDP-based client/server protocol that automates IP configuration on a network. Server listens on **UDP 67**, client listens on **UDP 68**. It uses a four-message exchange — **DORA: Discover, Offer, Request, Acknowledge** — to lease an IPv4 address and supporting configuration parameters to a client. DHCPv6 exists for IPv6 but uses UDP 546/547 and a different message set.

## Why it matters

Without DHCP, every device on your network needs a human to manually assign an IP, subnet mask, gateway, and DNS server. On a 5,000-host enterprise that's a full-time job. On your home network, it's the difference between plugging in a new laptop and having internet in two seconds versus opening Network Settings and typing in numbers.

DHCP misconfiguration is one of the top three reasons a help desk ticket gets opened with "I have no internet." Exhausted scope, rogue DHCP server, DHCP relay misconfigured across VLANs — all of these dump users onto **APIPA** (169.254.x.x) and break everything.

Exam-wise: **Objective 1.4** wants you to know DHCP runs on **UDP 67/68**. **Objective 1.8** covers DHCP services (scope, reservations, exclusions, lease time, options, relay). CompTIA tests the port numbers, the DORA sequence, and what happens when DHCP fails.

## Key facts

### The DORA exchange

The four-message handshake. Memorize the order, memorize which messages are broadcast vs unicast.

| Step | Message | Direction | Transport | Notes |
|------|---------|-----------|-----------|-------|
| 1 | **Discover** | Client → Broadcast | UDP, src 0.0.0.0:68, dst 255.255.255.255:67 | Client has no IP yet, shouts into the void |
| 2 | **Offer** | Server → Client | UDP, broadcast or unicast | Server proposes a lease |
| 3 | **Request** | Client → Broadcast | UDP, broadcast | Client formally accepts one offer (others see it and withdraw) |
| 4 | **Acknowledge** | Server → Client | UDP | Lease confirmed; client configures interface |

The client broadcasts Discover because it has no address yet — it can't unicast. The Request is also broadcast so that any other DHCP server that made an Offer knows the client picked someone else and can return that address to the pool.

*If you remember nothing else, remember DORA and remember UDP 67 server / UDP 68 client. CompTIA will ask both.*

### DHCP scope components

A **scope** is the range of addresses a DHCP server is allowed to hand out on a given subnet. Configure these:

- **Address pool / range** — e.g., 192.168.1.100 – 192.168.1.200
- **Subnet mask** — handed to the client as part of the lease
- **Default gateway** (DHCP option 3) — the router the client uses to leave the subnet
- **DNS servers** (option 6) — for name resolution
- **Domain name** (option 15) — for FQDN construction
- **NTP server** (option 42) — for time sync
- **Lease duration** — how long the address is valid (default often 8 days on Windows DHCP)
- **Exclusions** — addresses inside the pool the server is NOT allowed to hand out (e.g., 192.168.1.150 is excluded because it's the printer's static IP)
- **Reservations** — specific addresses tied to specific MAC addresses (the printer always gets 192.168.1.150 because that's what's reserved for its MAC)

### Reservations vs static IPs

Two different things, often confused.

- **Static IP** = configured on the client itself. The client never asks DHCP. If the address conflicts with a DHCP lease, you have a problem.
- **Reservation** = configured on the DHCP server. The client still does DORA, but the server always hands back the same address for that MAC. Cleaner, centrally managed, no conflicts.

*Reservations are the right answer for printers, servers, IoT devices. Static IPs are for things DHCP can't reach — the DHCP server itself, default gateways, core infrastructure.*

### Lease lifecycle

The lease isn't forever. The client renews at **T1 (50% of lease)** by unicasting a Request to the original server. If that fails, it tries again at **T2 (87.5% of lease)** by broadcasting. If both fail and the lease expires, the client drops the address and starts DORA over.

### DHCP relay (IP helper)

DHCP Discover is a **broadcast**. Broadcasts don't cross routers. So if your DHCP server is on VLAN 10 and your clients are on VLAN 20, clients never reach the server.

Fix: configure a **DHCP relay agent** on the router or layer 3 switch interface facing the clients. On Cisco, that's `ip helper-address <dhcp-server-ip>`. The relay catches the broadcast, converts it to unicast, and forwards it to the DHCP server. Server responds, relay forwards the reply back to the client.

*One DHCP server can serve an entire enterprise across dozens of VLANs as long as every client-facing L3 interface has the helper address configured. Forget one VLAN, that VLAN has no internet.*

### APIPA — what happens when DHCP fails

If a Windows or Linux client sends Discover and gets no Offer, it self-assigns from **169.254.0.0/16** (Automatic Private IP Addressing). The host can talk to other APIPA hosts on the same broadcast domain — and absolutely nothing else.

> **CompTIA exam trap:** if a user reports "no internet" and `ipconfig` shows 169.254.x.x, that means DHCP failed. Could be: DHCP server down, scope exhausted, relay misconfigured, cable unplugged at L1, or a switchport in the wrong VLAN. The address itself is the diagnostic clue — don't troubleshoot DNS or the default gateway, those aren't the problem.

### Rogue DHCP servers

Anyone can plug a consumer router into a corporate switchport and start handing out 192.168.1.x leases. Now half your users have an IP from the rogue, no gateway to the real network, no internet.

Defenses:
- **DHCP snooping** on managed switches — only designated "trusted" ports can send DHCP Offer/Ack. Rogue server on an "untrusted" port gets its replies dropped.
- **Port security** to limit what plugs in.
- **VLAN segmentation** so untrusted ports can't reach the production DHCP scope.

### DHCP options (the ones CompTIA likes)

| Option | Purpose |
|--------|---------|
| 1 | Subnet mask |
| 3 | Default gateway |
| 6 | DNS servers |
| 15 | Domain name |
| 42 | NTP server |
| 51 | Lease time |
| 66 | TFTP server (used for VoIP phone provisioning) |
| 67 | Bootfile name (PXE boot) |
| 150 | TFTP server list (Cisco IP phones) |

Options 66, 67, and 150 show up constantly in VoIP and PXE scenarios. *Option 66 / 150 = "where does my IP phone download its config?" Worth knowing.*

### CompTIA exam traps

> **CompTIA exam trap:** DHCP uses **UDP**, not TCP. UDP 67 server, UDP 68 client. If an answer says "TCP 67" it's wrong on its face.

> **CompTIA exam trap:** DHCPv6 uses **UDP 546 (client) and 547 (server)**, not 67/68. Different protocol family, different ports. The exam will plant a question to see if you confused them.

> **CompTIA exam trap:** "Why is the new VLAN getting APIPA addresses?" The answer is almost always **DHCP relay / IP helper not configured on that VLAN's gateway interface**. It's not the DHCP server — the server works fine for everyone else. The router isn't forwarding broadcasts.

> **CompTIA exam trap:** Reservations are configured on the **server**. Static IPs are configured on the **client**. If a question asks how to ensure a specific server always gets the same address without configuring it locally, the answer is **reservation**, not static.

## Helpdesk reality

- User says: **"The internet is broken."** You run `ipconfig` (Windows) or `ip addr` (Linux). If you see 169.254.x.x, DHCP failed. That's a network-side problem, not a browser problem.
- User says: **"It worked yesterday and now it doesn't."** Lease may have expired and a new lease assigned a different address that's now in conflict, or the scope is exhausted. Release/renew first (`ipconfig /release` then `ipconfig /renew`). If that fails, check the DHCP server's scope utilization.
- User says: **"My printer keeps changing IP and I have to reinstall it."** The printer is getting a different DHCP lease each time. Configure a **reservation** on the DHCP server tied to the printer's MAC address. Don't tell the user to set a static IP on the printer — that creates a future conflict.
- Never promise: **"Just reboot the router and it'll be fine."** If the DHCP scope is exhausted, rebooting the router doesn't add more addresses. If a rogue DHCP server is on the network, rebooting the legit one makes it worse.
- Escalation point: if APIPA addresses show up on multiple clients across one VLAN but other VLANs are fine, it's a **DHCP relay / helper-address** problem on the L3 switch or router. Network team ticket.

## Related concepts

[[DHCP Snooping]] · [[APIPA]] · [[DNS]] · [[Subnetting]] · [[VLANs]] · [[UDP]] · [[Default Gateway]] · [[DHCP Relay]] · [[PXE Boot]] · [[IPv6 SLAAC]] · [[Broadcast Domains]] · [[Rogue DHCP Server]]

*Source: VIRGIL knowledge base — 2026-05-11*