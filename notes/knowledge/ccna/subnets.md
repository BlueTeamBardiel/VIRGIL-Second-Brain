# Subnets

## What it is

A subnet is the networking equivalent of a private Discord server inside a larger community — everyone in that server can @mention each other directly, but to talk to someone in a *different* server, you need to go through a bridge bot. That bridge bot is a router.

Technically, a subnet is a logical slice of an IP network. Every IP address gets split into two parts: the **network portion** (which subnet you live in) and the **host portion** (which specific device you are inside that subnet). A **subnet mask** is the ruler that decides where the split happens — bits set to 1 mark network, bits set to 0 mark host.

So `192.168.1.42` with mask `255.255.255.0` means "the network is `192.168.1.x`, and you are `.42` inside it." Anyone else in `192.168.1.x` is a direct neighbor — your laptop ARPs for them and talks to them at Layer 2, no router required. Anyone in `192.168.2.x`? Different server. Route it.

## Why it matters

Subnets are how you carve a flat, dangerous network into compartments — like how Helldivers 2 separates you into mission instances instead of dumping every player onto one planet at once. Without subnets, every device shouts at every other device, broadcast traffic melts the wires, and a single compromised box can talk to everything.

Subnetting enforces the **principle of least privilege at the network layer**. The IoT cameras don't need to reach the finance servers. Put them in different subnets, and now reaching across requires a router — which means it requires an ACL, a firewall rule, something with an opinion. The boundary becomes a chokepoint where you can inspect, log, or drop traffic. Same logic as Tarkov's secure container: just because something is in your inventory doesn't mean every pocket is reachable from every other pocket.

It also lets you use private address space without burning public IPs. Three ranges are reserved for internal use and are dropped on sight by ISP routers — they literally cannot route to the public internet.

## Key facts

### The math

- **CIDR notation** stuffs the address and the mask into one value: `192.168.1.0/24` means "24 bits of network, 8 bits of host." Cleaner than writing `255.255.255.0` every time.
- **Usable hosts formula**: `2^(32 − prefix) − 2`. The `− 2` is because two addresses are always reserved.
- A **/24** gives you `2^8 − 2 = 254` usable hosts. Standard home/office LAN size.
- A **/30** gives you `2^2 − 2 = 2` usable hosts out of 4 total. Tiny by design.

### The two reserved addresses in every subnet

- **Network ID** — the first address. Identifies the subnet itself, like the name of the Discord server. In `192.168.1.0/24`, that's `192.168.1.0`. You can't assign it to a device.
- **Broadcast address** — the last address. Sending here is like @everyone in the server: every device in the subnet receives the packet. In `192.168.1.0/24`, that's `192.168.1.255`.

### Point-to-point links

- A **/30** is the classic choice for a link between two routers — exactly two usable addresses, one for each end of the wire. Anything bigger wastes IPs on a connection that will never have more than two participants. It's the duo queue of subnets.

### Private (RFC 1918) ranges — non-routable on the public internet

- **`10.0.0.0/8`** — the giant one. ~16.7 million addresses. Big enterprises and cloud VPCs love it.
- **`172.16.0.0/12`** — the awkward middle child. Covers `172.16.0.0` through `172.31.255.255`.
- **`192.168.0.0/16`** — the home router default. Your `192.168.1.1` admin page lives here.
- ISPs drop packets with these source/destination addresses on their public-facing interfaces. To reach the actual internet, your traffic gets NAT'd to a public IP at the edge — like how your Among Us lobby code only makes sense inside the lobby; outside, it's meaningless.

### Crossing the boundary

- Same subnet → direct Layer 2 delivery (ARP + switch).
- Different subnet → packet goes to your default gateway, the router decides where next. Every subnet hop is an opportunity to filter, NAT, or log.

## Related concepts

[[CIDR]] · [[ARP]] · [[default gateway]] · [[NAT]] · [[RFC 1918]] · [[VLANs]] · [[broadcast domain]] · [[routing]] · [[ACLs]] · [[principle of least privilege]]