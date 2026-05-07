# IPv4 Routing

## What it is

A package travels from a Shein warehouse in China to your apartment in Ohio. No single courier carries it the whole way — it gets handed off at sorting hubs, each one looking at the address label and deciding "what's the next hop?" Nobody knows the entire route. They just know where to pass it next.

That's IPv4 routing. A packet has a 32-bit destination IP address (four octets, like 192.168.1.42) stamped in its header. Each router it hits looks at that destination, checks its routing table, and forwards the packet to the next router closer to the goal. Hop by hop, no router has the full picture, and the packet has no idea how many handoffs it's going to take.

The router doesn't care about the whole IP address when making this decision — it cares about the **network portion**, which is determined by the subnet mask. Think of it like Uber Eats only needing the building, not the apartment number, until the very last delivery step.

## Why it matters

Every webpage you load, every Discord voice packet, every Warzone shot registration — they all ride on this hop-by-hop forwarding model. Understanding it is the difference between troubleshooting a network and just rebooting the router and praying.

It also matters because the system is built on trust. Routers forward packets without checking if the source address is real, the way a vending machine takes any coin shaped like a quarter. That trust is exactly what attackers exploit.

## Key facts

### How forwarding actually works

- **Hop-by-hop forwarding**: Each router makes an independent decision based on the destination IP. No router plans the full path — it's like a relay race where each runner only knows the next runner.
- **Routing tables**: The router's cheat sheet. Every entry says "for this destination network, send the packet to this next-hop router via this interface."
- **Longest prefix match**: When multiple routes match, the most specific one wins. If your table has entries for 10.0.0.0/8 and 10.0.5.0/24, a packet bound for 10.0.5.7 takes the /24 route. It's like Google Maps preferring the exact street address over just "Ohio."
- **Default route (0.0.0.0/0)**: The catch-all. If nothing else matches, send it here. This is the "I don't know, ask my parents" route — usually pointing at your ISP.
- **32-bit addresses, four octets**: 192.168.1.1 is just four 8-bit numbers stacked together. The subnet mask tells the router which bits are network and which are host.

### TTL — the loop killer

- **Time To Live**: An 8-bit field in the IP header that gets decremented by 1 at every hop.
- **Hits zero, packet dies**: The router drops it and fires back an **ICMP Time Exceeded** message to the sender. This is exactly how `traceroute` works — it sends packets with intentionally tiny TTL values to make each router along the path snitch on itself.
- **Why TTL exists**: Without it, a misconfigured routing loop would have packets ping-ponging forever, like two NPCs in Skyrim stuck walking into each other. TTL is the leash that guarantees every packet eventually dies.

### Attacks that abuse routing trust

- **IP spoofing**: Forging the source address in a packet header. Routers don't verify the "from" field — it's like sending a letter with someone else's return address. The reply goes to the spoofed victim, not you.
- **Smurf attack**: A spoofing classic. Attacker sends ICMP echo requests (pings) to a network's **broadcast address** with the victim's IP as the spoofed source. Every device on that network replies to the victim, turning one packet into a flood. It's the network equivalent of signing your enemy up for every pizza place's mailing list using a fake form.
- **Route poisoning**: Injecting bogus entries into routing tables so traffic flows through attacker-controlled paths. Like editing the GPS database so every car going to the bank takes a detour past the robbers' hideout.
- **BGP hijacking**: The internet-scale version. An attacker announces routes they don't own, causing chunks of global traffic to detour through their infrastructure. This has happened to entire countries' worth of traffic. It works because BGP, like IPv4 forwarding, is built on a default assumption of "everyone is telling the truth."

## Related concepts

[[Subnetting and CIDR]] · [[ICMP]] · [[BGP]] · [[OSPF]] · [[Static vs Dynamic Routing]] · [[Default Gateway]] · [[Traceroute]] · [[IP Spoofing]] · [[Smurf Attack]] · [[BGP Hijacking]] · [[uRPF (Unicast Reverse Path Forwarding)]] · [[IPv6 Routing]]