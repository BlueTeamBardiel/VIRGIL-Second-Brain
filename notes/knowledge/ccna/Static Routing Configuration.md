# Static Routing Configuration

## What it is
Like hand-painting every street sign in a city yourself instead of letting GPS recalculate automatically — static routing means an administrator manually defines every path a packet must take through a network. Unlike dynamic routing protocols (OSPF, BGP) that adapt to topology changes, static routes are fixed entries in a router's routing table that never update unless an admin explicitly changes them.

## Why it matters
In a network segmentation defense scenario, static routes are deliberately used to ensure traffic between a DMZ and an internal corporate network must pass through a specific firewall or IDS choke point — preventing attackers from discovering alternative paths. Conversely, an attacker with admin access to a router can inject a malicious static route to redirect traffic to a rogue host for interception (a route poisoning variant), completely bypassing security controls without touching firewall rules.

## Key facts
- Static routes are configured with the `ip route [destination network] [subnet mask] [next-hop IP or exit interface]` syntax on Cisco IOS devices
- They have an **Administrative Distance (AD) of 1** — trusted above almost all dynamic routing protocols, making rogue static routes extremely dangerous if injected
- Static routes create **no routing protocol overhead**, making them preferred on small networks or stub networks with a single exit point
- A **default static route** (`0.0.0.0 0.0.0.0`) acts as a "route of last resort," forwarding all unmatched traffic to a gateway — commonly exploited if misconfigured
- Unlike dynamic protocols, static routes have **no built-in authentication**, so access control to the router's management plane is the only protection

## Related concepts
[[Network Segmentation]] [[Default Gateway]] [[Routing Protocol Security]]