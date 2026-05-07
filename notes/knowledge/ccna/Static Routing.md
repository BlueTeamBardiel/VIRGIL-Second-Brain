# Static Routing

## What it is

Static routing is the GPS equivalent of memorizing a route by hand and refusing to ever check traffic again. You tell the router: "To get to 10.0.0.0/24, send packets out this interface to that next hop." The router writes it down, believes you forever, and never asks for a second opinion.

More precisely: static routing is when a network administrator manually configures fixed paths in a router's routing table. No protocol negotiates them. No neighbor advertises them. They sit there, immobile, until a human types the command to remove them. Compare this to dynamic routing protocols (OSPF, EIGRP, RIP) where routers gossip with each other constantly to discover paths — static routing is the lone wolf who doesn't talk to anyone and just follows the orders nailed to the wall.

In Elden Ring terms: dynamic routing is summoning help and adapting to what other Tarnished are doing. Static routing is a pre-planned solo run where every step is scripted — fast and predictable until something on the path changes and your script no longer matches reality.

## Why it matters

Static routes are the security-conscious admin's love language. A Discord server with no bots, no integrations, no webhooks — nothing to exploit because nothing is listening. That's static routing's threat model. There's no RIP to poison, no OSPF adjacency to spoof, no LSA flood to weaponize. The attack surface for routing-protocol-based attacks is zero, because there is no routing protocol.

The trade-off: it does not scale. Maintaining static routes across 500 routers is the network equivalent of manually updating every contact's phone number across every device you've ever owned, every time someone moves. In a small, high-security environment — a segmented lab, a DMZ, a sensitive backend segment — the manual labor is worth the predictability. In a large enterprise, you'd quit.

Static routes also matter as a *control mechanism*. Want to force VLAN 20 to only reach VLAN 30 through a specific firewall? A static route (and the deliberate absence of others) makes that the only physically possible path. No route, no traffic. It's the bouncer model: not on the list, not getting in.

## Key facts

**Configuration and persistence**
- Static routes are configured by hand and persist until an administrator explicitly removes them — like a pinned message in a Discord channel, it stays until someone unpins it.
- They never update on their own. If the next-hop link dies, the static route still cheerfully points at the dead link unless paired with something like IP SLA tracking.
- Zero protocol overhead. No hello packets, no LSAs, no broadcasts, no neighbor negotiations — pure radio silence on the wire.

**Administrative distance (the trust score)**
- Administrative distance (AD) is how Cisco IOS ranks the trustworthiness of a route source when multiple sources claim the same destination. Lower is better — it's golf scoring.
- Directly connected interfaces: **AD 0** (the router can literally see the network out its own port; nothing is more trusted).
- Static routes: **AD 1** (you, the human, said so — second only to physical reality).
- OSPF: 110. EIGRP internal: 90. RIP: 120. Static beats all of them. If you write a static route to 10.0.0.0/24 and OSPF also learns one, the static wins — every time.

**Default static route**
- Written as `0.0.0.0/0` — a destination that matches literally everything.
- Acts as the **gateway of last resort**: if no more specific route matches, send the packet here. It's the "...send it to the ISP and pray" option.
- Common on edge routers pointing at the upstream provider, since the edge router doesn't need to know every route on the internet — it just needs to know which direction is "out."

**Security posture**
- No routing protocol = no routing protocol attacks. RIP poisoning? Not possible, RIP isn't running. OSPF spoofing via forged LSAs? Same deal.
- The remaining attack vector is the human and the device itself. If an attacker compromises the router (or the admin's credentials) they can inject or modify static routes to redirect traffic through their own box — instant man-in-the-middle, the Watch Dogs 2 ctOS hijack played at the routing layer.
- The other big risk is fat-fingering. A typo in a static route doesn't get corrected by neighbors — it just silently breaks reachability or, worse, sends traffic somewhere it shouldn't go.

**Traffic control use cases**
- Enforce inter-VLAN paths: a static route can mandate that VLAN 10 reaches VLAN 50 only via a specific Layer 3 firewall interface.
- The *absence* of a static route is itself a control. No route to a destination = no traffic to that destination. Segmentation by omission.

## Related concepts
[[Dynamic Routing]]
[[Administrative Distance]]
[[Default Gateway]]
[[OSPF]]
[[RIP]]
[[Routing Table]]
[[VLAN Segmentation]]
[[Man-in-the-Middle Attack]]
[[Route Injection]]
[[Floating Static Route]]