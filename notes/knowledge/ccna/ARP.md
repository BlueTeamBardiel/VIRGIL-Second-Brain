# ARP

## What it is

In Red Dead Redemption 2, Arthur rides into Valentine and shouts "I'm looking for a man named Tommy!" — and only the actual Tommy turns around to answer. That's exactly what ARP — the Address Resolution Protocol — does. You know the name. You need to know which face in the saloon belongs to it.

More technically: ARP is the glue between Layer 3 and Layer 2. Your computer knows the destination IP address (32 bits, IPv4), but the network card can only actually deliver frames to a MAC address (48 bits, burned into the NIC). ARP is how the box figures out "what hardware address do I slap on this Ethernet frame so it reaches 10.0.0.5?"

ARP rides directly on Ethernet frames. No TCP, no UDP, no IP header — it's a link-layer protocol that skips the transport stack entirely. It's also stateless: each request and reply stands alone, with no session, no handshake, no memory of who asked what. It's the same reason any drifter in Saint Denis can claim to be Tommy and walk off with your money — nobody checks ID, and that's the design flaw every attacker salivates over.

## Why it matters

Every single packet your machine sends to a device on the local segment depends on ARP working correctly. Open Netflix, send a Discord message, ping your router — ARP resolved the MAC first. It's invisible until it breaks, and when it breaks (or gets weaponized), your traffic silently walks into someone else's hands.

ARP poisoning is the bread-and-butter move for any local-network man-in-the-middle attack. It's the digital equivalent of a Among Us imposter swapping name tags — the network still routes traffic "correctly," but "correctly" now means "to the attacker." No alarms, no warnings, no broken connections. Just a quiet detour through someone's laptop running Wireshark.

## Key facts

### How it works

- **Request is a broadcast, reply is unicast.** The "who has 10.0.0.5?" question goes to `ff:ff:ff:ff:ff:ff` — every device on the segment hears it, like a global chat ping in an MMO. Only the device that owns the IP answers, and it answers directly to the asker.
- **Stateless protocol.** No handshake, no session tracking. Your OS will accept an ARP reply even if it never asked a question — like trusting a Tinder match you never swiped on.
- **Cache lifetime is roughly 1 hour.** Once resolved, the IP→MAC mapping is stored so your machine isn't broadcasting every five seconds. The OS can refresh entries early or purge them on demand (e.g., `arp -d` on most systems).
- **No transport layer.** ARP sits directly on top of Ethernet (EtherType `0x0806`). It can't cross routers — it's local-segment only, like proximity chat in Helldivers 2.

### Gratuitous ARP

- An **unsolicited reply** — a device announces its own IP/MAC mapping without anyone asking. Like walking into a Discord voice channel and immediately announcing your gamertag.
- Two legit uses: **detecting duplicate IPs** (if someone replies "hey, that's MY IP," you've got a conflict) and **updating neighbors' caches** when an interface comes up or a failover happens.

### ARP spoofing / cache poisoning

- Attacker sends forged ARP replies claiming "I'm 10.0.0.1" (the gateway). Victims update their caches and start sending gateway-bound traffic to the attacker's MAC instead. Classic Watch Dogs side-mission energy.
- **Subverts routing decisions** at Layer 2 — the IP routing table is fine, but the MAC the frame gets addressed to is wrong, so the frame physically goes to the wrong NIC.
- Enables **traffic hijacking** (read/modify packets in flight), **MITM** (sit between victim and gateway), and **denial of service** (poison with a nonexistent MAC, traffic blackholes).
- Works because ARP is stateless and trusting — there's no authentication on replies. It's the protocol equivalent of accepting friend requests from anyone.

### Defenses

- **Static ARP entries.** Manually pin the gateway's MAC on critical hosts. Bulletproof but doesn't scale — fine for a homelab, brutal for a 5,000-seat office.
- **Dynamic ARP Inspection (DAI).** A switch feature that validates ARP packets against a trusted database (usually built from DHCP snooping). Forged replies get dropped at the port before they ever reach a victim. The bouncer at the door checking IDs.
- **VLAN isolation / segmentation.** ARP can't cross VLAN boundaries, so shrinking the broadcast domain shrinks the attack surface. Smaller lobby, fewer potential griefers.
- **Port security and 802.1X** layered on top to make sure rogue devices can't even plug in to start poisoning.

## Related concepts

[[Ethernet]] · [[MAC address]] · [[IPv4]] · [[Broadcast domain]] · [[VLAN]] · [[DHCP snooping]] · [[Dynamic ARP Inspection]] · [[Man-in-the-Middle attack]] · [[NDP (IPv6 Neighbor Discovery)]] · [[Gratuitous ARP]] · [[Port security]]