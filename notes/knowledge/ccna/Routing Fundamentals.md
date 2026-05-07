# Routing Fundamentals

## What it is

Routing is the GPS layer of networking. When you order DoorDash, the driver doesn't teleport to your door — they hop from the restaurant, to a main road, to your neighborhood, to your street, making decisions at each intersection. Routers are those intersections, and the routing table is the GPS telling them which exit to take.

Two scenarios decide whether a router even gets involved:

**Local delivery** — Source and destination live on the same network (same subnet). This is like passing a note to the person sitting next to you in class. Your computer checks its subnet mask, calculates that the destination IP is in the same subnet, and just wraps the packet in a frame with the destination's MAC address. The router never touches it. Done.

**Remote delivery** — Destination is on a different network. Now your computer needs an exit door: the **default gateway**. It still wraps the packet with the destination's IP, but the *frame* is addressed to the gateway's MAC. The gateway (a router) takes it from there.

The mental model that trips people up: **IPs don't change as the packet travels, but MACs change at every hop.** The IP address is the final destination on the GPS. The MAC address is just "who do I hand this to next." Like a relay race baton — the baton (packet) is the same, but the runner (MAC) changes at every handoff.

## Why it matters

Without routing, the internet is just a bunch of isolated LAN parties. Routing is what lets your packet leave your house, traverse a dozen ISPs, and land on a server in Tokyo. Every time you load TikTok, dozens of routers performed this exact decision-making in milliseconds.

It also matters for troubleshooting. If your laptop can ping its neighbor but can't reach Google, 9 times out of 10 it's a routing problem — wrong default gateway, missing route on a router, or a static route that didn't adapt when something upstream changed. Knowing whether traffic is local or remote tells you instantly whether to blame the switch, the gateway config, or the router's routing table.

## Key facts

### Local vs Remote Decision

- Source host uses its **subnet mask** to calculate whether the destination IP is in the same network. Same network → local. Different network → remote.
- **Local:** packet goes into a frame with the destination host's MAC. Router is not involved at all.
- **Remote:** packet goes into a frame with the **default gateway's MAC**. The destination IP in the packet is still the final target — only the frame is addressed to the gateway.
- The default gateway is configured as an **IP address**, not a MAC. The host uses **ARP** to translate that IP into a MAC when it's time to send. Like having someone's Discord username but needing to ping them to get their actual handle.
- Default gateway is conventionally the first usable IP in the subnet (e.g., 192.168.1.1 in 192.168.1.0/24) — purely convention, not a rule.
- Hosts get gateway info either via **DHCP** (automatic — gateway, IP, DNS, subnet mask all handed out, like auto-fill on a checkout page) or **manual config** (admin enters it by hand).

### What the Router Does When a Frame Arrives

1. Checks if the destination MAC equals the router's own interface MAC. If not — **discard**. The router isn't a snoop; if the frame wasn't addressed to it, it ignores it.
2. De-encapsulates the frame to look at the IP packet inside. Like opening the DoorDash bag to read the address label on the actual order.
3. If the destination IP is the router's own IP → process locally (someone is talking *to* the router, e.g., SSH).
4. Otherwise → look up the destination IP in the **routing table**.
5. If no match → **discard** the packet. No GPS route, no delivery.
6. If matched → de-encapsulate from the incoming frame, **encapsulate in a new frame** with the outgoing interface's MAC as source and the **next-hop's MAC** as destination. New runner, same baton.

### Routing Table Entries

Each entry contains:
- **Destination network** (e.g., 10.0.0.0/24)
- **Next hop** (IP of the next router) or **exit interface**
- **Metric** (cost — lower is better, like ping in Apex)
- **Source code** (how the route was learned)

Source codes you'll see in `show ip route`:
- **C** — Connected. Auto-learned because the router has an interface in that network. Free real estate.
- **S** — Static. An admin typed it in.
- **O** — OSPF. Learned dynamically via the OSPF routing protocol.

### Three Ways Routes Get Into the Table

- **Connected** — Plug a cable into an interface, configure an IP, and that subnet appears automatically. Like Steam auto-detecting a controller you plug in.
- **Static** — Admin manually enters it. Reliable but **does not adapt** if topology changes. Like hardcoding a teammate's IP in an old LAN game — works until they change networks, then it's broken forever.
- **Dynamic** — Learned via routing protocols (OSPF, EIGRP, BGP). Routers gossip routes to each other and adapt automatically when links die.

### Static Route Syntax

IPv4:
```
ip route <destination-network> <netmask> {<next-hop-ip> | <exit-interface>} [metric]
```

IPv6:
```
ipv6 route <destination-network/prefix-length> {<next-hop-ipv6> | <exit-interface>} [metric]
```

You can specify either the **next-hop IP** ("send it to 10.0.0.2") or the **exit interface** ("send it out GigabitEthernet0/1"). Either works; next-hop is more common because it survives interface renames.

### Default Route — The Catch-All

- Written as `0.0.0.0/0` in IPv4. Matches literally any IP address.
- Used when no more specific route matches. It's the "if all else fails, send it this way" rule — like the `default:` case in a switch statement.
- Typically has the **highest metric / lowest priority**, so it only kicks in as a last resort.
- This is how your home router works: it has one default route pointing at your ISP, because it has no idea how to reach Google or Netflix specifically — it just punts everything unknown upstream.

### Longest Prefix Match

When multiple routes in the table match a destination IP, the router picks the one with the **longest prefix** (most specific). Like Google Maps preferring "1247 Elm Street, Apt 4B" over "Elm Street" when both are technically valid — the more specific address wins.

Example: destination is 10.1.1.5.
- Route A: `10.0.0.0/8` matches.
- Route B: `10.1.0.0/16` matches.
- Route C: `10.1.1.0/24` matches.
- Winner: **Route C**. /24 is the longest prefix.

This is why default routes (0.0.0.0/0, the shortest possible prefix) lose to literally everything else.

## Related concepts

[[ARP]] · [[Subnetting and Subnet Masks]] · [[Default Gateway]] · [[OSPF]] · [[EIGRP]] · [[BGP]] · [[Static vs Dynamic Routing]] · [[DHCP]] · [[Encapsulation and De-encapsulation]] · [[MAC Addressing]] · [[IPv6 Routing]] · [[Longest Prefix Match]] · [[Routing Table]]