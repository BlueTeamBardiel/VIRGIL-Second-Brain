# Routing

## What it is

Google Maps for packets. When you punch a destination address into Maps, it doesn't show you every road on Earth — it picks the next turn, then the next, then the next, until you arrive. Routers do the same thing for IP packets: they look at the destination IP, check their internal map, and shove the packet one hop closer to where it's going.

A **router** is the device making the decision. A **routing table** is its map — a database of known networks paired with the next-hop address used to reach each one. When a packet arrives, the router checks the destination IP against this table, finds the longest matching prefix, and forwards the packet out the corresponding interface.

If your laptop has no idea how to reach some random IP (which is almost always the case for anything outside your LAN), it ships the packet to its **default gateway** — the "I don't know, you figure it out" router. That gateway is usually your home router or, in an enterprise, the L3 switch upstream.

## Why it matters

Routing is the connective tissue of the internet. Break it, and Twitch stops streaming, Discord goes silent, and your Helldivers 2 lobby drops. But routing was designed in a more innocent era — most of it runs on trust, the same way early Among Us lobbies trusted everyone not to be sus. That trust is the attack surface.

Two specific consequences:

- **Whoever controls the path controls the data.** Take over the default gateway and you've got a front-row seat to every packet leaving the host — classic man-in-the-middle territory.
- **Whoever lies loudest wins.** On the global internet, BGP just believes what other routers tell it. A bad announcement can drag traffic for an entire country into the wrong network, intentionally or by fat-fingered accident.

## Key facts

### Routing tables

- Populated two ways: **static routes** (an admin types them in, like manually pinning waypoints in Elden Ring) or **dynamic routing protocols** (routers gossip with each other and update automatically).
- Each entry maps a destination network to a next-hop IP and an outgoing interface.

### Dynamic routing protocols

- **OSPF, EIGRP, RIP** — interior protocols, used inside a single organization's network.
- **BGP** — the exterior protocol that stitches together **autonomous systems** (ASes), which are the giant network blocks owned by ISPs, cloud providers, and large enterprises. BGP is what makes "the internet" a single thing instead of thousands of disconnected islands.
- **Route poisoning** — when a route fails, a router advertises it with an *infinite metric* to scream "do not use this path." Like marking a chest in Tarkov as already looted so your squad doesn't waste time on it. Prevents routing loops.

### BGP and its trust problem

- BGP is **trust-based**. If an AS announces "hey, I have the shortest path to Cloudflare," neighboring routers tend to believe it.
- **BGP hijacking**: a malicious or misconfigured AS advertises falsely shortened routes, sucking traffic toward itself. Could be nation-state interception, could be a Pakistani ISP accidentally blackholing YouTube globally (this happened, in 2008).
- **RPKI (Resource Public Key Infrastructure)** is the defense — it cryptographically validates that an AS is actually authorized to announce a given prefix. Think of it like a verified checkmark for route announcements: without the cryptographic signature, neighbors can drop the bogus advertisement.

### Default gateway attacks

- The default gateway is the single point of trust for "anything not on my local subnet." Compromise it and every outbound packet flows through attacker hardware — full **man-in-the-middle** position. TLS still protects content, but metadata, DNS queries, and any unencrypted traffic are exposed.
- **ICMP Redirect attack**: ICMP has a legitimate "hey, use this other router instead, it's a better path" message. An attacker on the same segment forges one to convince your host that the *attacker's* machine is the better gateway. The host updates its routing table and now politely hands its traffic to the attacker. Most modern OSes ignore ICMP redirects by default for this exact reason — it was too easy to weaponize.

## Related concepts

[[BGP]] · [[OSPF]] · [[RPKI]] · [[ICMP]] · [[Default Gateway]] · [[Man-in-the-Middle Attacks]] · [[Autonomous System]] · [[Static vs Dynamic Routing]] · [[ARP Spoofing]]