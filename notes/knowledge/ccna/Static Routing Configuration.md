# Static Routing Configuration

## What it is

Static routing is the GPS equivalent of writing turn-by-turn directions on a sticky note and taping it to your dashboard. The route works perfectly — until the road closes. Then you're still following the sticky note into a ditch because it has no idea anything changed.

A static route is a manually defined entry in a router's routing table. You, the admin, tell the router: "To reach this destination network, send the packets out this interface" or "to this next-hop IP." The router obeys, forever, until you change it. It does not learn, it does not adapt, it does not negotiate with neighbors.

On Cisco IOS, the configuration is a single line:

```
ip route [destination network] [subnet mask] [next-hop IP or exit interface]
```

Example: `ip route 10.0.0.0 255.255.255.0 192.168.1.1` says "anything for the 10.0.0.0/24 network, hand it off to 192.168.1.1."

There's also a special variant — the **default static route** — written as:

```
ip route 0.0.0.0 0.0.0.0 [next-hop]
```

The `0.0.0.0/0` destination is the routing equivalent of "everything else." Any packet whose destination doesn't match a more specific entry gets shoved out this default path. It's the catch-all upload chute.

## Why it matters

Static routes are like crafting a Mercer Smartlock pick in Watch Dogs 2 — you build it once for a specific job, and it just works. No background processes, no chatter with other devices, no CPU spent recalculating paths every time something hiccups. For a small office with one internet connection, that's exactly what you want.

But in a network with multiple paths, redundancy needs, or anything that changes — static routes are the wrong tool. If the next-hop dies, the static route doesn't care. It still points at a corpse. Dynamic routing protocols like OSPF and BGP handle that automatically by gossiping with neighbors and recalculating paths when topology shifts. Static routes are deaf to all of it.

The other thing worth knowing: static routes are trusted *hard*. With an Administrative Distance of 1, they outrank almost every dynamic protocol on the router. If you misconfigure one, the router believes you over OSPF, over EIGRP, over almost anything. That trust is a footgun if the management plane isn't locked down — anyone with config access can inject a route and silently redirect traffic. There's no built-in authentication on the route itself; the only protection is who's allowed to log into the router in the first place.

## Key facts

- **Manual entries**: Static routes are hand-configured and live in the routing table until you remove them. Like a hardcoded waypoint in Elden Rings's map — it doesn't move when the world does.
- **No topology awareness**: A link goes down, the route still points at it. No failover, no recalculation.
- **Cisco IOS syntax**: `ip route [destination] [mask] [next-hop IP | exit interface]`. One line, one route.
- **Administrative Distance = 1**: The router's trust ranking. Lower = more trusted. AD 1 means static routes beat OSPF (110), BGP external (20), and nearly everything else. Only directly connected routes (AD 0) outrank them.
- **Zero protocol overhead**: No hello packets, no LSAs, no neighbor relationships. The router uses zero bandwidth maintaining static routes — they just sit there like a saved Discord pin.
- **Default static route**: `ip route 0.0.0.0 0.0.0.0 [gateway]` — the "send everything else this way" rule. Essential for stub routers pointing at an ISP.
- **No authentication**: The route itself has no cryptographic protection. Whoever can configure the router can inject routes.
- **Management plane is the perimeter**: SSH access controls, AAA, ACLs on VTY lines — these are what actually protect static routes from being tampered with. Lock the door, because there's no lock on the route.
- **Best fit — small networks with a single exit**: One way out, no decisions to make. Static is faster and simpler than running OSPF for nothing.
- **Best fit — stub networks**: A stub is a network with only one path in or out (think a dead-end branch office). There's literally nothing to dynamically calculate.
- **Contrast with dynamic protocols**: OSPF and BGP exchange routing info with neighbors and recompute paths when the topology changes. Static routing does neither.

## Related concepts

[[Dynamic Routing Protocols]]
[[OSPF]]
[[BGP]]
[[Administrative Distance]]
[[Default Gateway]]
[[Routing Table]]
[[Stub Networks]]
[[Router Management Plane Security]]
[[AAA on Network Devices]]
[[Floating Static Routes]]