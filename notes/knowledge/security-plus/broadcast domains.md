# broadcast domains

## What it is
Think of a broadcast domain like a neighborhood where someone can shout from their front porch and every house hears it — but the sound doesn't cross the highway into the next neighborhood. Precisely, a broadcast domain is the logical division of a network in which any broadcast frame sent by one device is received by all other devices within that same segment. Routers terminate broadcast domains; switches (without VLANs) do not.

## Why it matters
ARP poisoning attacks exploit the fact that ARP requests are broadcasts — every device in the broadcast domain receives them, making a malicious host able to respond with a spoofed MAC address and intercept traffic. Segmenting networks into smaller broadcast domains using VLANs is a core defense, limiting an attacker's lateral visibility so a compromised host can't ARP-poison targets on a different VLAN.

## Key facts
- A **router** always separates broadcast domains; a standard Layer 2 switch keeps all ports in the same broadcast domain by default.
- **VLANs** create logical broadcast domain boundaries on a single physical switch, isolating traffic without needing separate hardware.
- Excessively large broadcast domains degrade performance and expand attack surface — both security and operational reasons exist to keep them small.
- **ARP** and **DHCP** discovery traffic are broadcast-dependent, making broadcast domain size directly relevant to these protocols' attack exposure.
- The **subnet mask** defines the IP broadcast boundary; devices in different subnets cannot receive each other's Layer 3 broadcasts without a router forwarding them.

## Related concepts
[[ARP poisoning]] [[VLANs]] [[network segmentation]] [[MAC flooding]] [[subnetting]]