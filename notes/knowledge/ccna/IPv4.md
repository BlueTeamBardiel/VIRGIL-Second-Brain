# IPv4

## What it is

In Sonic, every Chaos Emerald, every gold ring, every Badnik has a fixed location on the Zone map — without coordinates, Sonic can't dash to them and the level engine can't render them. That's exactly what IPv4 does — it gives every device on the internet a unique numeric coordinate so traffic knows where to go. IPv4 (Internet Protocol version 4) has been the default addressing system since the 80s, back when "the internet" was a few thousand academics, not eight billion phones.

Technically, IPv4 is a Layer 3 protocol that defines three things: how packets are **addressed** (who's sending, who's receiving), how they're **routed** (which path they take across networks), and how they're **delivered** (best-effort, no guarantees — like Sonic launching off a spring with no promise he'll land on the platform).

An IPv4 address is a **32-bit number**, usually written as four decimal octets separated by dots: `192.168.1.10`. Each octet is 8 bits, ranging 0–255. That 32-bit space gives roughly **4.3 billion** (2³²) possible addresses — which sounded infinite in 1981 and sounds laughable now.

## Why it matters

IPv4 is the protocol the entire public internet still mostly runs on, but it was designed with the trust level of a LAN party in someone's basement — everyone there is a friend, nobody's going to lie about who they are. That assumption aged poorly.

Two things make IPv4 a daily concern:

1. **The address space is exhausted.** IANA handed out the last `/8` blocks to regional registries back in 2011. New allocations are scraps. This is why NAT, CGNAT, and IPv6 exist — same energy as a Helldivers 2 lobby that's full and you're stuck in queue.
2. **Security was bolted on, not built in.** IPv4 has no authentication and no encryption native to the protocol. Anyone can claim to be anyone, and packets travel in plaintext unless something higher up (TLS, IPsec, WireGuard) wraps them.

## Key facts

### Addressing and notation

- **32-bit addresses, four octets**: `10.0.0.5` is really `00001010.00000000.00000000.00000101`. Humans get the dotted-decimal version because reading binary at 3am is suffering.
- **~4.3 billion total addresses** — fewer than there are smartphones on Earth. The pool is dry.
- **CIDR replaced classful addressing.** The old Class A/B/C system was like Pokémon evolution tiers — fixed, rigid, and wasteful. CIDR (Classless Inter-Domain Routing) lets you slice the address space at any bit boundary using `/n` notation.
- **`/24` = 256 addresses, 254 usable hosts** (one for the network ID, one for broadcast). `192.168.1.0/24` covers `192.168.1.0` through `192.168.1.255`.
- **Misconfigured subnet masks are a classic foot-gun.** Setting `/16` instead of `/24` is like leaving your Discord server on @everyone-can-invite — suddenly the "internal" range overlaps with stuff it shouldn't, and devices end up exposed or unable to route.

### RFC 1918 private ranges

These are the address blocks reserved for internal use — your home Wi-Fi, your office LAN, your homelab. Like the private channels in a Discord server: they exist, but only people inside the server can see them.

- **`10.0.0.0/8`** — the big one, 16.7M addresses
- **`172.16.0.0/12`** — the awkward middle child, 1M addresses
- **`192.168.0.0/16`** — the home-router default, 65K addresses
- These should **never** appear as source IPs on the public internet. If they do, ISPs and edge routers should drop them. When they don't, weird things happen.

### Header field: TTL

- **TTL (Time to Live)** is an 8-bit field that decrements by 1 at every router hop. When it hits 0, the packet dies and the router sends back an ICMP "Time Exceeded" message.
- Originally meant to prevent routing loops from creating infinite packets — same logic as a respawn timer in Apex preventing you from ghost-running forever.
- **Traceroute** abuses this on purpose: send packets with TTL=1, 2, 3... and collect each "Time Exceeded" reply to map the path.
- **Attackers manipulate TTL** to evade detection or bypass firewalls — crafting a packet with a TTL that dies just past an IDS but before the target, so the IDS sees the traffic but the target never does. Classic insertion/evasion trick.

### Security weaknesses

- **No built-in authentication.** The source IP field is just... whatever the sender wrote. The protocol takes their word for it.
- **IP spoofing** — forging the source IP in the packet header. Like spoofing caller ID, except the entire internet was built on caller ID.
- **Amplification DDoS** weaponizes spoofing: attacker sends a small query to an open DNS/NTP/Memcached server with the **victim's IP** as the source. The server's huge response gets reflected at the victim. The attacker uses 1 KB to deliver 50 KB of pain — the same ratio as throwing one grenade in Rainbow Six Siege and detonating six reinforced walls.
- **Ingress filtering (BCP38)** is the defense: ISPs drop outbound packets whose source IP doesn't belong to their customer's allocated range. If every ISP did this, spoofing would mostly die. Many don't.
- **No native encryption.** Anything sniffing the wire sees the full payload unless an upper layer encrypted it first.
- **IPsec was retrofitted** as an optional add-on to provide authentication and encryption at the IP layer. "Optional" is doing a lot of work in that sentence — most IPv4 traffic doesn't use it. (IPv6 was originally designed to require it, though that requirement was later relaxed too.)

## Related concepts

- [[IPv6]]
- [[NAT]] and [[CGNAT]]
- [[Subnetting]] and [[CIDR]]
- [[IPsec]]
- [[BCP38 / Ingress Filtering]]
- [[DDoS Amplification Attacks]]
- [[ICMP]] and [[Traceroute]]
- [[ARP]]
- [[TCP]] / [[UDP]]
- [[Firewall Evasion Techniques]]