# IP Subnet

## What it is

A subnet is the apartment building inside the city of your network. The city (the larger IP network) is too big to manage as one unit, so you carve it into buildings, each with its own address range, its own mailroom, and its own front door. People inside the building can knock on each other's doors directly. To visit another building, you have to go outside and use the street — and the street is patrolled.

Technically, a subnet is a logically segmented portion of a larger IP network. The subnet mask is what tells a device which bits of an IP address identify the *network* (which building) and which bits identify the *host* (which apartment). Bits set to 1 in the mask = network portion. Bits set to 0 = host portion.

CIDR notation is just shorthand for the mask. Instead of writing `255.255.255.0`, you write `/24` — meaning "the first 24 bits are network." Same thing, fewer keystrokes. Like how gamers say "AWP" instead of "Arctic Warfare Police."

## Why it matters

Subnets are how you stop your network from becoming a Among Us lobby where everyone hears every emergency meeting. Every device in a subnet shares a broadcast domain — when one device shouts, everyone in the subnet listens. Without subnetting, an ARP broadcast from your printer reaches every device in the entire company. With subnets, the noise stays contained.

Subnets are also where security lives. Because traffic between subnets must pass through a router or Layer 3 switch, those chokepoints become the perfect place to enforce firewall rules and ACLs. It's the same logic as Rainbow Six Siege — you don't defend every inch of the map, you defend the doorways. Subnet boundaries are your doorways.

And subnets let you actually use your IP space efficiently. A subnet sized for 500 devices and a subnet sized for 6 devices can coexist in the same network thanks to VLSM, instead of wasting a /24 on a point-to-point link that only needs two addresses.

## Key facts

**Anatomy of a subnet**
- The **first address** is the network address — the building's name on the mailbox. Not assignable to a host.
- The **last address** is the broadcast address — the intercom that pages every apartment at once. Also not assignable.
- Total addresses minus those two = usable host addresses. Two seats at the table are always reserved.

**Common subnet sizes**
- **/24** → mask `255.255.255.0`, 256 total addresses, **254 usable**. The default Minecraft server size — comfortable for a typical office floor or VLAN.
- **/16** → 65,536 total, **65,534 usable**. Enterprise-scale. You're running a whole MMO zone in here.
- The smaller the prefix number, the bigger the subnet. /16 is way bigger than /24. Counterintuitive at first, but the number is just "how many bits are locked in for the network."

**The mask does the math**
- Subnet masks decide which bits are network vs. host. A /24 mask locks the first three octets; the last octet is yours to assign.
- Devices use the mask to answer one question: "Is this destination in my building, or do I need to go to the router?" If yes → ARP and send directly. If no → hand it to the default gateway.

**Routing between subnets**
- Subnets talk to each other via **Layer 3 routing**. Same-subnet traffic is Layer 2; cross-subnet traffic must hit a router or Layer 3 switch.
- This is the Cyberpunk 2077 net architecture in miniature — you can't just jack into another subsystem, you route through a gateway, and the gateway can absolutely refuse you.
- Routers and L3 switches enforce **firewall rules and ACLs** at these boundaries. Subnet edges = policy edges.

**Broadcast domain isolation**
- Each subnet is its own broadcast domain. A broadcast in 10.0.1.0/24 does not leak into 10.0.2.0/24. Your noisy IoT toaster stays in its own room.

**VLSM (Variable Length Subnet Masking)**
- VLSM lets you mix subnet sizes inside the same parent network. One /23 for the user VLAN, a /27 for a server pod, a /30 for a router-to-router link.
- Without VLSM, every subnet would have to be the same size — like forcing every Tarkov stash to be the same dimensions whether you're storing a screwdriver or a Slick rig.
- VLSM optimizes address utilization. Critical for IPv4, where addresses are finite and somebody's always asking for more.

## Related concepts
[[CIDR notation]]
[[Subnet mask]]
[[VLSM]]
[[Broadcast domain]]
[[Layer 3 switch]]
[[Default gateway]]
[[ARP]]
[[VLAN]]
[[Access Control List (ACL)]]
[[Private IP address ranges (RFC 1918)]]