# IPv4 Summary

## What it is

IPv4 is the gamertag system of the internet. Every device that wants to play needs one, it has to be unique on whatever server (network) you're joined to, and without it nobody can find you to send you anything. It's been the default identity layer of the internet since the 80s, and despite being older than most people reading this, it's still carrying the bulk of the world's traffic.

Technically: IPv4 is the fourth version of the Internet Protocol, operating at Layer 3 (Network) of the OSI model. Its job is **logical addressing** (giving every host a number) and **best-effort packet delivery** (shipping packets toward a destination without promising they'll arrive, arrive in order, or arrive only once). It's the postal layer that doesn't track your package — if reliability matters, that's TCP's problem one layer up.

Addresses are 32 bits long, written in dotted-decimal like `192.168.1.10`, which gives the protocol a hard ceiling of roughly 4.3 billion unique addresses. That sounded like a lot in 1981. It is not a lot in 2024.

## Why it matters

IPv4 is the protocol the entire modern internet was bolted on top of, which means its design flaws are now everyone's problems. It was built for a small, trusted academic network — think a LAN party with researchers who all knew each other — and then got scaled up to the planet. The result: no native authentication, no native encryption, and an address space that ran out about a decade ago. Every NAT box, every VPN tunnel, every firewall rule about spoofed source addresses exists because IPv4 doesn't handle these things itself.

If you've ever had to port-forward to host a Minecraft server for friends, you've felt IPv4's exhaustion problem firsthand — your home doesn't get a public address per device, it gets one public address that NAT juggles for everything inside.

## Key facts

### Addressing basics
- **32-bit addresses, dotted-decimal notation** — four 8-bit octets like `10.0.0.1`. Four billion total combinations sounds huge until you remember how many phones, laptops, fridges, and Ring doorbells exist.
- **~4.3 billion address ceiling** — the protocol's hard cap. We blew past it; that's why IPv6 exists and why NAT became mandatory.
- **Classful addressing (A, B, C, D, E)** — the original scheme that carved the address space into fixed-size buckets. Class D is multicast, Class E is reserved/experimental. This system was wasteful (a Class A handed out 16 million addresses to a single org) and got replaced.
- **CIDR (Classless Inter-Domain Routing)** — replaced classful allocation. Instead of fixed bucket sizes, CIDR uses **subnet masks** like `/24` to draw the network boundary anywhere you want. It's the difference between only being allowed to buy eggs in cartons of 12, 144, or 1728 versus buying any quantity you actually need.

### Private addressing and NAT
- **RFC 1918 private ranges** — `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`. These are the "LAN-only" gamertags. Anyone can use them internally, but they're **non-routable on the public internet** — public routers drop them on sight.
- **NAT (Network Address Translation)** — born from address exhaustion. It hides a whole household of devices behind one public IP, like a Discord server where outsiders only see the server name, not which member is currently typing. Your router rewrites source addresses on the way out and remembers who asked what so replies get back to the right device.

### Security gaps
- **No built-in authentication** — IPv4 packets don't prove who sent them. The source IP field is just a claim, like a username on a Twitch chat with no verification badge.
- **No built-in encryption** — packet payloads are plaintext on the wire by default. Anything in the middle (rogue Wi-Fi AP, ISP, anyone with a SPAN port) can read it.
- **IPSec is bolted on, not native** — it works, but it's an optional retrofit. IPv6 was designed with authentication and encryption baked into the spec from day one (though in practice IPSec usage on IPv6 is also optional).
- **IP spoofing** — because the source address isn't verified, an attacker can forge it. This is the engine behind reflection/amplification DDoS attacks: send a small request with a victim's IP as the "source," and the response avalanche lands on the victim. Like swatting someone by spoofing their phone number on the 911 call.
- **BCP38 (ingress/egress filtering)** — the standard mitigation for spoofing. Routers and firewalls are configured to drop packets whose source address couldn't possibly have come from the direction they arrived from. If a packet hits your edge router from inside your network claiming to be from `8.8.8.8`, that's obviously fake — drop it. BCP38 is a **router and firewall configuration concern**, not something the protocol enforces. Adoption is famously incomplete, which is why spoofed-source DDoS is still a thing.

## Related concepts
[[IPv6]] · [[NAT]] · [[CIDR and Subnetting]] · [[RFC 1918 Private Addressing]] · [[IPSec]] · [[BCP38 Ingress Egress Filtering]] · [[IP Spoofing]] · [[OSI Model Layer 3]] · [[Classful vs Classless Addressing]] · [[TCP vs UDP]]