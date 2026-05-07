# Network Address Translation

## What it is

NAT is the bouncer at the door of your network who hands every guest a fake ID before they walk into the public party. Inside the building (your LAN), everyone uses their real name (private IP). The moment they step outside, the bouncer swaps their badge for one of the few "public" IDs the venue actually owns, writes the swap down in a notebook, and reverses it when they come back.

Technically: NAT rewrites IP addresses (and often ports) in packet headers as traffic crosses a boundary between an "inside" network and an "outside" network. It exists because the IPv4 address space ran out years ago, and RFC 1918 carved off three ranges that anyone can use internally but no ISP will route:

- `10.0.0.0/8`
- `172.16.0.0/12`
- `192.168.0.0/16`

Send a packet onto the public internet with a source of `10.0.0.1` and the first ISP router will drop it like a hot mic. NAT exists so your `10.x` traffic gets disguised as a real, routable public address before it ever leaves your edge router.

## Why it matters

Without NAT, IPv4 would have collapsed around 2005. There aren't enough public addresses for every phone, console, and smart fridge — but with NAT, an entire apartment building, office, or coffee shop can share a single public IP, the way an entire Discord server shares one invite link.

It also matters because NAT changes how connections initiate. It's like an MMO instance: outbound raids work fine (you can leave town and come back), but random strangers on the internet can't just teleport into your house unless you've explicitly set up a portal. That's why hosting a Minecraft server from your bedroom requires port forwarding — you're punching a permanent hole through the bouncer's policy.

For network engineers, NAT is also where troubleshooting gets weird. A packet captured inside the LAN and the same packet captured at the ISP uplink will have different source IPs. If you don't know the four NAT address types, you will lose hours.

## Key facts

### The four NAT address types (the part everyone confuses)

Think of it like a streamer using a fake handle. There are two perspectives (inside vs outside the network) and two identities (local vs global):

- **Inside Local** — the private IP of your internal host. Your laptop's `192.168.1.50`. The streamer's real name.
- **Inside Global** — the public IP your internal host appears as after translation. The streamer's on-camera handle.
- **Outside Local** — the external host's IP as seen from inside your network. Usually identical to Outside Global unless you're doing weirder NAT tricks.
- **Outside Global** — the actual public IP of the external server out on the internet. Netflix's real address.

NAT translation is **bidirectional and stateful** — the router keeps a table mapping the swap so return traffic gets reversed correctly. Outbound, Inside Local → Inside Global. Inbound replies, Inside Global → Inside Local.

### Static NAT

A permanent one-to-one mapping. Like reserving the same gamertag for the same player forever.

- Hard-coded: `192.168.1.10` always becomes `203.0.113.10`.
- Supports **bidirectional** traffic — outsiders can initiate connections inbound. This is how you publish a web server.
- Burns **one public IP per internal host**. Conserves nothing.
- Syntax: `ip nat inside source static [private-ip] [public-ip]`

### Dynamic NAT

A pool of public IPs handed out on a first-come-first-served basis. Like a guest Wi-Fi system that gives out temporary credentials from a stack of 10 cards.

- Bindings are **temporary one-to-one** — created on demand, torn down on timeout or session end.
- **Outbound initiation only.** Outsiders can't reach in because there's no fixed mapping until your host starts a flow.
- If the pool is exhausted, **new connections are dropped** until something frees up. Dynamic NAT does not queue.
- Three-step config: define an ACL (permitting inside-local sources), define the pool of public IPs, bind ACL to pool.

### Dynamic PAT (the one you actually use)

Port Address Translation, aka NAT overload. The standard modern deployment. This is what your home router does.

- Many private hosts → **one** public IP, distinguished by **port number**. Like an apartment building where all mail goes to one street address but the apartment number routes it to the right tenant.
- Translates **both IP and Layer 4 port**. Outbound flow from `192.168.1.50:51234` might become `203.0.113.1:60001`.
- Theoretical ceiling: ~**65,535 simultaneous translations** per public IP (the port field is 16 bits).
- Default timeouts: **TCP 86400 seconds** (24 hours), **UDP 300 seconds** (5 minutes). Tunable via `ip nat translation tcp-timeout` and `ip nat translation udp-timeout`.
- Single-interface syntax: `ip nat inside source list [ACL] interface [interface] overload`
- Pool-based syntax: define pool, then reference it with the `overload` keyword.

### Interface marking

NAT doesn't happen by accident. You must explicitly tell the router which side is which:

- `ip nat inside` on the LAN-facing interface
- `ip nat outside` on the WAN/ISP-facing interface

Forget this and NAT silently does nothing — a classic "why isn't this working" moment.

### Verification and troubleshooting

- `show ip nat translations` — the live translation table. Your notebook of swaps.
- `show ip nat statistics` — hit counts, miss counts, pool usage.
- `clear ip nat translation *` — nukes the entire table. Useful when you've changed config and stale entries are interfering.
- `debug ip nat` — verbose per-packet logging. Use briefly; this can drown a busy router.

### ACL gotcha

The access list referenced by NAT defines **which inside-local sources are eligible for translation**. A `permit` here doesn't mean "allow traffic" — it means "translate this traffic." Get the ACL wrong and either nothing gets translated or everything does, including stuff that shouldn't.

## Related concepts

[[RFC 1918 Private Addressing]]
[[IPv4 Address Exhaustion]]
[[Port Forwarding]]
[[Access Control Lists]]
[[Stateful Inspection]]
[[IPv6 and the End of NAT]]
[[CGNAT (Carrier-Grade NAT)]]
[[Hairpin NAT]]
[[Static Routing vs NAT Path]]