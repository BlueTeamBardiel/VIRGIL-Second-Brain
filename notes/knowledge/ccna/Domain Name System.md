# Domain Name System

## What it is

Saving "Beatrice ❤️" in your phone contacts so you never have to memorize +39 055 234 5678 — that's DNS. You type `youtube.com`, and somewhere behind the scenes a system swaps that human-friendly string for `142.250.80.46` so packets actually know where to go.

DNS is a hierarchical, distributed database arranged like a tree. At the top are **root nameservers** (the 13 logical roots, `a.root-servers.net` through `m`). Below them are **TLD nameservers** (`.com`, `.net`, `.io`, `.gov`). Below those are **authoritative nameservers** — the servers that actually hold the records for a specific domain like `nintendo.com`.

When your laptop asks "what's `store.nintendo.com`?", it usually does a **recursive query** to its configured DNS resolver — basically saying "you go figure it out, just bring me the answer." That resolver then performs **iterative queries**: it asks a root server, gets a referral to the `.com` TLD server, asks the TLD server, gets a referral to Nintendo's authoritative server, asks that, and finally gets the IP. It's the difference between asking a concierge to find you a restaurant (recursive) versus the concierge calling three other people who each say "not me, try them" (iterative).

## Why it matters

Without DNS, the internet collapses into a memorization contest nobody wins. But more practically: DNS is one of the highest-leverage attack surfaces on any network. Poison the cache and you can redirect a bank login to a phishing clone — the URL bar still says the right thing because the lie happened underneath.

For network engineers, DNS is also a quality-of-life feature on the gear itself. A Cisco router can resolve `ping server01.styx.local` instead of forcing you to remember `10.0.0.47`. The flip side: if DNS is misconfigured, every typo in privileged EXEC mode becomes a 15-second hostage situation while IOS tries to resolve `shwo` as a hostname. This is why `no ip domain-lookup` is the first command many engineers paste into a lab router.

## Key facts

### Record types — the inventory slots
- **A record** — FQDN → IPv4. The default loadout.
- **AAAA record** ("quad-A") — FQDN → IPv6. Same role, different ammo type.
- **CNAME** — alias pointing one name at another. Like a Discord nickname that resolves to your real username.
- **MX record** — mail exchanger. Tells the internet "send `@gmail.com` mail to *these* servers."
- **NS record** — delegates which nameservers are authoritative for a zone. The "managed by" sign.
- **SOA record** — Start of Authority. Zone metadata: serial number, refresh, retry, expire timers. The save file header.
- **PTR record** — reverse lookup: IP → FQDN. Used by mail servers to sanity-check senders.
- **TXT record** — free-form text, but in practice carries **SPF** and **DKIM** for email authentication.

### Recursive vs iterative
- **Recursive**: client says "get me the answer, I'll wait." Used between you and your resolver.
- **Iterative**: server says "not my problem, ask them." Used between resolvers and the root/TLD/authoritative chain.

### TTL — how long the answer stays cached
- TTL is in **seconds**, set by the record owner.
- **300 sec (5 min)** — records that change often, like load-balanced services swapping IPs.
- **3600 sec (1 hr)** — stable web records.
- **86400 sec (24 hr)** — rarely-touched records like `MX`. Long TTL = faster lookups but slower propagation when you change something. It's the respawn timer on cached data.

### FQDN and unqualified names
- **FQDN** = Fully Qualified Domain Name, e.g. `router1.styx.local` — the full path, no shortcuts.
- An **unqualified** name is just `router1`. With `ip domain-name styx.local` configured, IOS auto-appends `.styx.local` so `ping router1` resolves correctly. Like how Steam auto-completes friend names.

### Cisco IOS DNS client commands
- `ip domain-lookup` — enables DNS resolution. **On by default.**
- `no ip domain-lookup` — disables it. The classic fix for "I typed `shwo run` and my terminal froze for 15 seconds trying to resolve it as a hostname."
- `ip name-server 8.8.8.8 1.1.1.1` — configures DNS servers. Accepts multiple; if the first times out (**default 3 seconds**), it tries the next.
- `ip domain-name styx.local` — default suffix appended to unqualified names.
- `ip domain-list` — defines multiple search domains, tried in order. Like Spotify trying multiple sources for a track.
- `ip host server01 10.0.0.47` — creates a **static local A record**. No external query needed; the router just knows.
- `show hosts` — shows DNS cache + static entries.
- `show ip name-servers` — lists configured DNS servers.
- `nslookup youtube.com` — manual query from the device.
- `nslookup youtube.com 8.8.8.8` — second arg targets a specific nameserver (useful for "is *my* DNS lying or is everyone's?").
- `clear ip dns cache` — wipes the cache. The "have you tried turning it off and on again" of DNS.
- `debug ip dns` — verbose output, see every query in real time.
- `undebug all` — turns off all debugging before you accidentally DoS your own console.

### Cisco IOS as a DNS server
- `ip dns server` — turns the router itself into a DNS server.
- Combined with `ip host` entries, the router becomes the authoritative resolver for the local LAN. Useful for small networks where you don't want to spin up a dedicated server.

### Resolution order on IOS
1. Check **local DNS cache** first.
2. Check static `ip host` entries.
3. Query configured `ip name-server` addresses.
4. If nothing answers: `% Unrecognized host or address` (the "unresolved hostname" error).

### Security
- **DNS cache poisoning** — attacker injects forged records into a resolver's cache. Every client using that resolver now gets routed to the attacker's IP. Like someone editing the in-game waypoint marker so your whole squad pushes into an ambush.
- **DNSSEC** — adds cryptographic signatures to DNS records so resolvers can verify they weren't tampered with. Each record carries a signature chain rooted at the DNS root, so a poisoned answer fails validation.

## Related concepts
- [[DHCP]]
- [[DNSSEC]]
- [[ARP]]
- [[TCP and UDP]] (DNS uses UDP/53 for most queries, TCP/53 for large responses and zone transfers)
- [[NTP]]
- [[SPF and DKIM]]
- [[Cisco IOS CLI]]
- [[FQDN vs hostname]]
- [[DNS over HTTPS (DoH)]]
- [[Reverse DNS]]