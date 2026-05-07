# DHCP

## What it is

Joining a new Discord server and instantly getting a role, a nickname color, and access to the right channels — that's DHCP for your network. You plug in a laptop or connect to Wi-Fi, and within seconds it has an IP address, a subnet mask, a default gateway, and DNS servers. You did nothing. A server somewhere handed you the whole starter kit.

DHCP (Dynamic Host Configuration Protocol) is the service that hands out network identities automatically so humans don't have to manually configure every device. Without it, every phone, laptop, smart fridge, and console joining your network would need a sysadmin holding its hand.

The handshake is called **DORA**, and it's a four-step back-and-forth like matchmaking in Counter-Strike 2:

1. **Discover** — Client broadcasts "anyone running a DHCP server out there?" It has no IP yet, so this is a shout into the void (broadcast to 255.255.255.255).
2. **Offer** — Any DHCP server on the segment replies "yeah, I've got 10.0.0.47 available, want it?"
3. **Request** — Client formally says "I'll take 10.0.0.47 from you specifically." This is broadcast too, so other DHCP servers know they were ghosted.
4. **Acknowledge** — Server confirms the lease, locks it in, and the client starts using the address.

## Why it matters

DHCP is trust-by-default. The client takes whatever the first server offers — no authentication, no signature check, no "are you really my DHCP server?" That's the same vibe as accepting a friend request from someone with your friend's profile picture and zero mutual servers. If an attacker can answer faster or louder than the legitimate server, the client believes them.

That trust is what makes DHCP both essential and a juicy attack surface. Anyone who controls DHCP controls your default gateway and DNS — meaning they decide where your traffic goes and who resolves your domain names. That's a netrunner's dream in Cyberpunk 2077: redirect every packet through a router you own, and you can read or rewrite anything that isn't end-to-end encrypted.

## Key facts

### Protocol mechanics
- **Ports**: server listens on **UDP 67**, client listens on **UDP 68**. Two separate ports because the client doesn't have an IP yet during Discover, so directionality matters.
- **Leases, not deeds**: DHCP rents you the IP for a finite time. When the lease hits ~50%, the client tries to renew. Like a Spotify subscription that auto-renews unless something goes wrong.
- **Lease renewal is a timing window** — attackers can exploit the renewal moment to slip in a poisoned response, the same way a bait-and-switch works when your guard is down.
- **What gets handed out**: IP address, subnet mask, default gateway, DNS servers, and optionally domain name, NTP servers, TFTP boot servers, etc. (DHCP options).

### DHCP starvation attack
- The attacker floods the server with **DHCP Discover** messages, each spoofing a different fake MAC address. It's like one player buying every ticket to a concert under fake names.
- The IP pool drains. Legitimate clients joining afterward get nothing — denial of service.
- Often a **setup move**, not the finisher. Once the real server is dry, the attacker brings out the next stage…

### Rogue DHCP server attack
- The attacker spins up their own DHCP server on the LAN. New clients race to accept the first offer; if the rogue answers first, the client is configured with an **attacker-controlled gateway and DNS**.
- All outbound traffic now flows through the attacker → man-in-the-middle achieved with zero exotic exploits, just a faster reply.
- Pairs perfectly with DHCP starvation: starve the legit server, then be the only game in town.

### DHCP snooping (the defense)
- Layer 2 feature on managed switches. Each port is classified as **trusted** (uplinks toward the real DHCP server) or **untrusted** (everything else, where users plug in).
- Untrusted ports are **forbidden from sending DHCP server messages** (Offer, Ack). A laptop in a conference room can't pretend to be a DHCP server — the switch drops those frames at the port.
- Snooping builds a **binding table** of legit MAC → IP → port → VLAN mappings as it watches real DORA exchanges. Think of it as the bouncer's clipboard of who's actually on the guest list.
- That binding table feeds other defenses like Dynamic ARP Inspection and IP Source Guard — DHCP snooping is the foundation everything else stacks on top of.

### DHCPv6 and SLAAC
- IPv6 has two ways to autoconfigure: **SLAAC** (the device generates its own address from the router's advertised prefix) and **DHCPv6** (a server assigns it, like classic DHCP).
- They often coexist: SLAAC handles the address, DHCPv6 hands out the extras like DNS servers (this hybrid is called "stateless DHCPv6").
- **Stateful DHCPv6** behaves more like IPv4 DHCP — server tracks which address went to which client.
- Rogue Router Advertisements are the IPv6 equivalent threat to rogue DHCP, and **RA Guard** is the snooping-equivalent defense.

## Related concepts
[[ARP and ARP Spoofing]]
[[Dynamic ARP Inspection]]
[[IP Source Guard]]
[[DNS and DNS Spoofing]]
[[Man-in-the-Middle Attacks]]
[[SLAAC and IPv6 Autoconfiguration]]
[[Router Advertisement Guard]]
[[Default Gateway]]
[[UDP]]