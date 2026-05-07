# Dynamic Host Configuration Protocol

## What it is

Joining a Discord server and instantly getting a role, a nickname color, and access to the right channels — without the admin manually typing your info — that's DHCP for networks. When your laptop hits the WiFi at a coffee shop, nobody walks over with a sticky note saying "your IP is 10.0.0.47, gateway is 10.0.0.1, here are the DNS servers." DHCP does that handshake in milliseconds.

Dynamic Host Configuration Protocol is a Layer 7 application protocol that automatically hands out IPv4 configuration to clients: the IP address, subnet mask, default gateway, and DNS servers. It rides on UDP — port 67 for the server, port 68 for the client.

The handshake is called **DORA**, and it's basically the matchmaking flow in any online game lobby:

- **DISCOVER** — Client broadcasts "anyone running a server?" to `255.255.255.255:67`. This is the "Looking For Group" shout in chat.
- **OFFER** — Server responds to `255.255.255.255:68` saying "I've got a slot, here's the IP I'm holding for you."
- **REQUEST** — Client broadcasts back "I'll take it" to `255.255.255.255:67`. The broadcast matters because if multiple servers offered, the others need to hear that their offers got declined and pull those IPs back into the pool.
- **ACK** — Server confirms "you're in" to `255.255.255.255:68`, and now the client can actually use the address.

## Why it matters

Static IP assignment at scale is the network admin's version of manually inviting every player to a 64-player Helldivers 2 squad. It does not work. A 500-device office, a 30,000-seat stadium WiFi, your home with 14 smart bulbs and a Roomba — all of that runs because DHCP automates the boring part.

It also matters because DHCP breaks in *fun* ways. A rogue DHCP server is the network equivalent of someone setting up a fake Among Us lobby — clients connect, get bad config, and now their traffic flows through an attacker's gateway. Understanding DORA is what lets you spot when something's wrong in a Wireshark capture instead of staring at "no internet" and crying.

## Key facts

### Lease lifecycle
- Default lease is typically **8 days**. The client doesn't own the IP — it's renting.
- **T1 = 50% of lease**: client tries to renew with the original server via unicast. Like resubscribing to Spotify before it expires — quiet, no drama.
- **T2 = 87.5% of lease**: if T1 failed, client broadcasts to *any* DHCP server. This is the panic move when your original landlord ghosted you.
- If T2 also fails and the lease expires, the client drops the IP and starts DORA from scratch.

### Cisco IOS server config
The DHCP pool is your loot table — you define what gets handed out:

- `service dhcp` — globally enables the DHCP service on the device. Without this, none of the pool config does anything.
- `ip dhcp pool POOLNAME` — enters pool config mode.
- `network 192.168.1.0 /24` — defines the assignable range.
- `default-router 192.168.1.1` — the gateway clients will use.
- `dns-server 8.8.8.8 1.1.1.1` — DNS resolvers.
- `domain-name styx.local` — DNS search suffix.
- `lease 7` or `lease 0 12` or `lease infinite` — duration in days, hours, minutes, or never-expires.
- `ip dhcp excluded-address 192.168.1.1 192.168.1.10` — carves out addresses (your servers, printers, the gateway itself) so DHCP won't hand them to a random laptop.

### Cisco verification
- `show ip dhcp pool` — pool stats: how many leased, how many free.
- `show ip dhcp binding` — the active "who has what" table. Like checking the player list in a lobby.
- `show ip dhcp server statistics` — message counters (DISCOVERs received, ACKs sent, etc.).
- `clear ip dhcp binding *` — nukes all bindings, or specify one IP to clear just that lease.

### Cisco client side
- `ip address dhcp` — configures an interface to grab its address via DHCP instead of being statically set.
- `show ip dhcp client` — displays lease info from the client's perspective.

### DHCP relay (the cross-subnet problem)
DHCPDISCOVER is a broadcast. Routers don't forward broadcasts. So if your DHCP server lives on `10.0.0.0/24` but clients live on `192.168.1.0/24`, DORA dies at the router — like trying to invite someone to your Minecraft realm when they're on a different platform with no crossplay.

The relay agent fixes this:
- `ip helper-address 10.0.0.5` — configured on the router interface **facing the clients**, not the server. This is the part everyone gets backwards on exams.
- The relay catches the broadcast, rewrites the source IP to its own interface IP (so the server knows which subnet to pull from), and unicasts it to the configured server.
- Stack multiple `ip helper-address` lines to send to multiple servers — crude load balancing / redundancy.
- By default, `ip helper-address` also forwards a handful of other UDP services: **DNS (53), NTP (123), TFTP (69)**, and a few others. This is "helpful" until it isn't.
- `ip forward-protocol udp PORT` — customize exactly which UDP ports get relayed when the defaults are too broad or too narrow.

### Client-side commands across OSes

**Windows:**
- `ipconfig` — basic IP info.
- `ipconfig /all` — verbose, shows DHCP server, lease obtained, lease expires.
- `ipconfig /release` — drops the lease.
- `ipconfig /renew` — restarts DORA.

**macOS:**
- `ifconfig` — interface details (still works even though Linux deprecated it).

**Linux:**
- `ip addr show` — modern interface listing.
- `dhclient` — request a lease.
- `dhclient -r` — release the lease.

## Related concepts
- [[DHCP Snooping]]
- [[DHCP Spoofing Attacks]]
- [[Rogue DHCP Server]]
- [[APIPA / Link-Local Addressing]]
- [[DHCPv6 and SLAAC]]
- [[UDP]]
- [[Broadcast Domains]]
- [[DNS]]
- [[Default Gateway]]
- [[Subnet Mask]]
- [[ip helper-address]]