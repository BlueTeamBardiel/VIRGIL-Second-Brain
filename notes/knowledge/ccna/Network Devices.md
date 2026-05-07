# Network Devices

## What it is

A network is basically a Discord server for machines — a bunch of devices that joined the same space so they can share stuff (files, video calls, game state, memes). Every device that hops into that server is a **node**.

Formally: a **computer network** is a telecommunications system that lets nodes share resources. A **node** is any device connected to it — your laptop, a printer, a security camera, a switch, your PS5.

The scale of the network gets a name:
- **LAN (Local Area Network)** — limited geographic area. One office, one building, your apartment. The squad in the same Discord voice channel.
- **WAN (Wide Area Network)** — spans cities or further. Think of an MMO like Final Fantasy XIV stitching together regional data centers so a player in Tokyo can raid with someone in Frankfurt.
- **The Internet** — the global public infrastructure. Every public Discord server, every Netflix CDN, every game matchmaking service, all reachable through the same plumbing.

Inside any network, devices play roles. A **client** requests a service ("hey server, give me this YouTube video"). A **server** provides one. The catch: the same box can be both at once. Your gaming PC is a client when you're streaming Spotify, a server when your friend connects to your Minecraft world hosted on it. Roles are about what the traffic is doing, not what the hardware is.

We also split devices into two camps:
- **Endpoints** — the consumers. Phones, laptops, IoT bulbs, consoles. They *use* the network.
- **Infrastructure devices** — the ones that *build* the network. Switches, routers, firewalls. They're the netrunners and access points from Cyberpunk 2077 — invisible to most users, but everything flows through them.

## Why it matters

If you can't tell a switch from a router, you can't troubleshoot anything. "The internet is down" could mean five completely different broken pieces, each owned by a different device. Knowing which box does which job is the difference between rebooting the right thing and rebooting everything in a panic.

It also matters for security. Firewalls only work if they sit at the right chokepoint. A switch isn't going to save you from a ransomware payload — that's not its job. Putting the wrong device at the wrong layer is like equipping a shotgun for a long-range sniper duel in Call of Duty: technically a gun, completely wrong tool.

## Key facts

### Switch
- Connects devices **within** a LAN. The hub everyone in the same raid party plugs into.
- Operates at **Layer 2** (Data Link).
- Forwards **frames** based on **MAC addresses** — hardware IDs burned into every NIC.
- Typically **24–48 ports**. Built for density.
- Each switch port creates its own **collision domain** (no two devices fighting over the same wire). All ports share one **broadcast domain** by default — shout once, everyone on the switch hears it. Like an unmuted Among Us lobby.

### Router
- Connects **LANs to each other** and to external networks (including the internet). The portal between zones in Elden Ring.
- Operates at **Layer 3** (Network).
- Forwards packets based on **IP addresses**.
- Typically **2–10 ports** — far fewer than a switch, because each port faces a *different* network (e.g., one port to your 192.168.1.0/24 LAN, another to your ISP).
- May perform **NAT (Network Address Translation)** — rewriting private LAN addresses into one public IP, the way a guild leader speaks for the whole guild in cross-server chat.

### Firewall
- Filters traffic between **trusted** (your LAN) and **untrusted** (the internet) networks. The bouncer at the club door checking who gets in and who gets escorted out.
- Sits **between the LAN and the internet** — at the boundary.
- Can be a **dedicated appliance** (its own box, like a Palo Alto or Fortinet unit) or **embedded inside a router** (the typical home setup).
- Default behavior: **allows outbound** connections (your laptop reaching out to TikTok = fine), **blocks unsolicited inbound** (random IPs from Brazil knocking on your gaming PC = denied).
- A **stateful firewall** tracks connection state — it remembers "you started this conversation with Netflix 4 seconds ago," so the return traffic gets waved through. Without state, the firewall is a goldfish re-evaluating every packet from scratch.
- **Enterprise networks** put firewalls at every network boundary as standard practice.

### Ports vs Interfaces
- A **port** is the **physical connector** — the RJ-45 hole, the SFP cage. The literal thing you plug a cable into.
- An **interface** is a **logical connection point**, which can be physical *or* purely virtual (VLAN interfaces, loopbacks, tunnels). Think of port = the controller plugged into your console; interface = the in-game character that controller is currently driving. Same idea, different layer of abstraction.

### Endpoints vs Infrastructure
- **Endpoints** — what people actually use. Laptops, phones, printers, smart TVs.
- **Infrastructure** — switches, routers, firewalls. The plumbing nobody thinks about until it breaks.

## Related concepts
- [[OSI Model]]
- [[MAC Addresses]]
- [[IP Addressing]]
- [[VLANs]]
- [[NAT]]
- [[Stateful vs Stateless Firewalls]]
- [[Broadcast and Collision Domains]]
- [[Default Gateway]]
- [[DMZ]]