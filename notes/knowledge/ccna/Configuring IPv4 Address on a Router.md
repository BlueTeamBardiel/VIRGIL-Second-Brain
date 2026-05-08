# Configuring IPv4 Address on a Router

## What it is

In Resident Evil, picking up a key item doesn't mean you can use it. Leon can hold the Spade Key all he wants — until he stands at the right door and actually uses it, that key is dead weight in the inventory. That's exactly what configuring an IPv4 address on a router interface does — the hardware exists, the cable is plugged in, but nothing routes until you assign the address *and* activate the interface.

A router interface is the physical or virtual port where a router meets a network. Configuring IPv4 on it means assigning a 32-bit logical address that drops the interface into a specific subnet — the same subnet as the hosts it serves. That address becomes the default gateway for every device on that segment.

On Cisco gear, two steps are non-negotiable: assign the IP with `ip address`, then explicitly enable the interface with `no shutdown`. Cisco ships interfaces administratively down by default — like the typewriter ribbon sitting on the desk in the RPD save room. The mechanism is right there in front of you, but until you combine it with the typewriter, no save is happening.

## Why it matters

A router with a misconfigured interface is the network equivalent of a teammate in Rainbow Six Siege whose mic is muted — they're physically present, the game thinks they're alive, but no useful traffic flows through them. Hosts on the LAN will ARP for their gateway and get nothing back. Cross-subnet traffic dies at the doorstep.

Worse, a subtle subnet mask typo creates **split-brain routing**: the router thinks 10.0.0.50 is part of /25, the host thinks it's part of /24, and now they fundamentally disagree about who's a local neighbor and who needs routing. Packets get sent into the void with no error message, no ICMP unreachable, no log entry screaming at you. Just silent drops. It's the Among Us of network bugs — everything looks fine until you realize half your packets never arrived and nobody knows who's lying.

## Key facts

### The activation ritual
- **Interfaces are shutdown by default** on Cisco routers — opposite of switches, where access ports come up automatically. Treat every router port as locked until you `no shutdown` it.
- **Two commands minimum** to bring an interface to life: `ip address <addr> <mask>` and `no shutdown`. One without the other is a half-baked Elden Ring build — technically a character, functionally useless.
- **Layer 1 and Layer 2 must be up** for the IP config to actually move traffic. You can configure an address on a cable that's unplugged; it just won't do anything. `show ip interface brief` will show "down/down" and you'll know.

### Addressing rules
- **IPv4 addresses are 32-bit** logical identifiers, sitting at Layer 3. Logical means they're software-assigned, unlike a MAC address which is burned in.
- **Each interface must live in the same subnet as its hosts**. The router's GigabitEthernet0/0 facing 192.168.1.0/24 needs an address inside 192.168.1.0/24 — anything else and the hosts can't reach their own gateway.
- **Convention: first or last usable address**. A /24 typically uses .1 or .254 for the router. Not a rule, just the unwritten code — like how everyone in CS2 knows the AWPer holds long. Pick one and stay consistent across your whole network or your future self will hate you.

### Secondary addresses
- **One physical interface can host multiple IP addresses** using `ip address <addr> <mask> secondary`. This lets a single port serve multiple subnets riding on the same wire.
- Useful when you're migrating subnets or running two logical networks on one VLAN — like dual-wielding in a game that normally only lets you hold one weapon. Powerful, occasionally messy.

### The split-brain trap
- **Subnet mask mismatches between host and router** create disagreement about what's "local." Host with /24 thinks 192.168.1.130 is a neighbor; router with /25 thinks it's on a different subnet entirely.
- **Symptom: silent packet drops**. No errors, no warnings, just traffic that never arrives. Always verify masks on both ends — `ipconfig` / `ifconfig` on the host, `show running-config interface` on the router.

## Related concepts
[[Subnetting and CIDR Notation]]
[[Default Gateway]]
[[ARP Resolution]]
[[show ip interface brief]]
[[Router-on-a-Stick and Subinterfaces]]
[[Layer 1 and Layer 2 Troubleshooting]]
[[IPv6 Interface Configuration]]