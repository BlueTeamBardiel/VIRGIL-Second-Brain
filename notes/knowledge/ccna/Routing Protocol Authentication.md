# Routing Protocol Authentication

## What it is

In Among Us, the entire game breaks if anyone can claim to be the Captain and start barking orders. The crew needs a way to verify who's actually crew before trusting what they say. Routing protocol authentication is exactly that check — it's the cryptographic handshake routers perform before they'll believe each other's stories about which networks exist where.

Without it, any device that speaks the right protocol dialect can walk up to your router and say "hey, send all traffic for 8.8.8.0/24 through me." Your router, by default trusting and lonely, will say "sounds great, neighbor." With authentication, the router demands a shared secret or a cryptographic hash before it accepts a single update. No secret, no peering, no route changes.

## Why it matters

In April 2010, a Chinese ISP announced BGP routes that hijacked traffic destined for roughly **15% of the internet's IP space** for about 18 minutes. Government, military, and commercial traffic got funneled through infrastructure it had no business touching. The fix wasn't exotic — it was authentication that simply wasn't being used.

The attack pattern is the same one Aiden Pearce would run in Watch Dogs: if the system trusts anyone who shows up speaking the right language, you just learn the language and start lying. Route injection attacks let an attacker:

- **Blackhole traffic** — advertise a route, drop everything that arrives
- **Man-in-the-middle** — advertise a route, inspect traffic, forward it onward so nobody notices
- **Hijack BGP sessions** — without TCP MD5 signatures, a crafted TCP RST packet can tear down a peering session between two ISPs, causing route flaps and outages

Authentication is the cheap, boring control that turns "anyone with a packet crafter" into "someone who already stole the key."

## Key facts

### OSPF
- Three authentication modes: **null** (no auth), **plain-text password**, and **MD5 cryptographic hash**
- Plain-text mode is theater — the password rides in the clear and shows up in any Wireshark capture like a Discord message you forgot was screen-shared
- **MD5 is the preferred mode**: the password never traverses the wire, only a hash of the packet contents plus the key
- Even though MD5 is broken for collision resistance in other contexts, in OSPF it's used as a keyed integrity check, which is still acceptable for this purpose

### BGP
- Uses **TCP MD5 signatures per RFC 2385** — the authentication lives at the TCP layer, not inside BGP itself
- Every TCP segment in the BGP session carries an MD5 digest in the TCP options field
- Without it, an attacker who can guess the TCP sequence numbers can fire off a **crafted RST packet** and drop the peering session, like getting kicked from a Counter-Strike lobby by someone spoofing the admin
- The 2010 hijack of 15% of internet IP space is the canonical "this is why we authenticate" story

### RIP
- **RIPv1: zero authentication support** — it's the open-mic night of routing protocols, anyone can grab the microphone
- **RIPv2: supports MD5 authentication** — finally requires a key to participate

### EIGRP
- Uses a **key chain mechanism**: instead of one static password, you configure a chain of keys, each with a lifetime
- Supports **time-based key rotation** — key 1 is valid Monday-Sunday, key 2 takes over the next week, and so on
- Lets you rotate credentials without dropping adjacencies, the way Helldivers 2 rotates Major Orders without ending the war

### General principle
- Authentication is what stops **route injection attacks** — the entire class of "lie to the router until traffic comes to me"
- Authentication verifies the **peer**, not the **route content** — a compromised but authenticated peer can still lie. That's a different problem solved by RPKI and route filtering.

## Related concepts

[[OSPF]]
[[BGP]]
[[EIGRP]]
[[RIPv2]]
[[Route Injection Attacks]]
[[BGP Hijacking]]
[[RPKI]]
[[MD5 Hashing]]
[[TCP MD5 Signature Option (RFC 2385)]]
[[Key Chains]]
[[Man-in-the-Middle Attacks]]