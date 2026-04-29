# Default Gateway

## What it is
Think of it as the post office at the edge of your neighborhood — any letter going to an address outside your street gets handed to them first. Precisely, a default gateway is the router IP address that a host sends packets to when the destination is outside its local subnet. It's the mandatory first hop for all external traffic.

## Why it matters
In a **default gateway spoofing** (ARP poisoning) attack, an adversary broadcasts forged ARP replies claiming their MAC address corresponds to the gateway's IP, redirecting all outbound traffic through their machine for interception. This is a classic man-in-the-middle setup on local networks — tools like Ettercap and Bettercap automate this entirely. Defenders counter it with Dynamic ARP Inspection (DAI) on managed switches, which validates ARP packets against a trusted DHCP snooping binding table.

## Key facts
- The default gateway must be on the **same subnet** as the host — a host cannot reach a gateway on a foreign network directly.
- Configured via DHCP (Option 3) or set statically; DHCP is the attack surface most exploited in rogue DHCP scenarios.
- On Windows, `ipconfig` reveals the default gateway; on Linux, `ip route show default` or `netstat -rn`.
- A missing or incorrect default gateway means **local traffic works fine but internet/external routing fails** — useful diagnostic clue during incident response.
- Routers themselves use routing tables and protocols (OSPF, BGP) rather than a single default gateway — the "default gateway" concept applies specifically to **end hosts**.

## Related concepts
[[ARP Poisoning]] [[DHCP Spoofing]] [[Man-in-the-Middle Attack]] [[Dynamic ARP Inspection]] [[Subnetting]]