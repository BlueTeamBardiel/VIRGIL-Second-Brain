# IPv6 And SLAAC

## What it is

In **Marvel Rivals**, when you queue up a match, the server doesn't ask you what your callsign is or wait for you to register. The moment your client connects, the lobby system hands you a slot, assigns you a team, and you're in — Spider-Man's web-zipping across the rooftops of Tokyo 2099 before you've even finished adjusting your sensitivity. No handshake ceremony. Your client tells the network it exists, the network confirms the slot is open, and the match starts. That's exactly what **SLAAC** does — a host walks onto an IPv6 network, listens for the router, builds its own address, and starts talking.

**Stateless Address Autoconfiguration (SLAAC)** is the IPv6 mechanism where a host generates its own global unicast address using the network prefix advertised by the local router, without needing a DHCP server to track it. Stateless means no server keeps a lease database. The host picks its own host portion, combines it with the router's advertised /64 prefix, and it's online.

IPv6 itself is the 128-bit replacement for the 32-bit IPv4 address space that ran out around 2011. Eight groups of four hex digits separated by colons: `2001:0db8:0000:0000:0000:0000:0000:0001` collapses to `2001:db8::1`. The `::` replaces one run of consecutive zero groups. Use it once per address or the parser can't tell where the zeros went.

## Why it matters

Every modern OS has IPv6 enabled by default and prefers it over IPv4 when both are available. If you don't understand IPv6, you're blind to half the traffic on your own network. Mobile carriers run IPv6-only cores. AWS, Azure, and GCP all charge less for IPv6 egress. Enterprise networks are dual-stack, and the exam (Objective N10-009 1.4, 1.7, 3.4) tests you on IPv6 address types, SLAAC vs DHCPv6, and the supporting DNS records (AAAA, PTR) that make any of it usable.

*Disabling IPv6 is the network engineer equivalent of turning it off and on again — it works, and it's also an admission you didn't read the docs.*

## Key facts

### IPv6 address types

| Type | Prefix | Purpose |
|---|---|---|
| Global unicast | `2000::/3` | Public, routable — like a public IPv4 |
| Unique local (ULA) | `fc00::/7` (usually `fd00::/8`) | Private, non-routable — like RFC1918 |
| Link-local | `fe80::/10` | Auto-assigned, single segment only, never routed |
| Multicast | `ff00::/8` | Replaces IPv4 broadcast — IPv6 has no broadcast |
| Loopback | `::1/128` | Localhost |
| Unspecified | `::/128` | "No address yet" |

**Link-local is mandatory.** Every IPv6 interface gets one automatically the moment IPv6 is enabled, derived from the MAC address (EUI-64) or generated randomly for privacy. Routers use link-local for neighbor discovery and as next-hop addresses.

### SLAAC — how a host gets its address

1. Interface comes up. Host generates a **link-local address** (`fe80::/10`) for itself.
2. Host runs **Duplicate Address Detection (DAD)** by sending a Neighbor Solicitation to its own tentative address. If nobody answers, the address is unique.
3. Host sends a **Router Solicitation (RS)** to the all-routers multicast `ff02::2`.
4. Router replies with a **Router Advertisement (RA)** containing the /64 prefix, default gateway info, and flags telling the host what to do next.
5. Host combines the advertised prefix with a self-generated 64-bit host ID (EUI-64 from MAC, or random per RFC 4941 privacy extensions) and runs DAD again on the full address.
6. Host is online. No server tracked any of this.

The RA flags determine the mode:

- **M off, O off** → pure SLAAC. Host self-generates address. DNS comes from RA itself (RFC 8106) or static config.
- **M off, O on** → SLAAC for the address, **stateless DHCPv6** for DNS and other options.
- **M on** → **stateful DHCPv6**. Host asks a DHCPv6 server for the address.

### DHCPv6 vs SLAAC

| Feature | SLAAC | DHCPv6 (stateful) |
|---|---|---|
| Address source | Host self-generates from RA prefix | DHCPv6 server assigns |
| Tracks who has what? | No | Yes — lease database |
| Hands out DNS? | Optionally via RDNSS in RA | Yes |
| Hands out default gateway? | Yes, via RA | **No** — gateway always comes from RA |
| Reservations possible? | No (host picks its own ID) | Yes |

> **CompTIA exam trap:** DHCPv6 does **not** provide the default gateway. The router advertisement does. Even on a stateful DHCPv6 network, you still need RAs for the default route. If the exam asks "what provides the default gateway in IPv6," the answer is the router, via RA — not DHCPv6.

### IPv4 DHCP refresher (because the exam pairs them)

- **Scope** — the pool of addresses a server can hand out.
- **Reservation** — a specific MAC always gets the same IP. Use for printers, servers, devices that need predictable addresses without static config.
- **Exclusion** — addresses inside the scope the server will *never* hand out. Use for statically-assigned devices in the subnet.
- **Lease time** — short (hours) for crowded wireless; long (8 days default on Windows) for stable wired LANs.
- **Options** — option 3 (default gateway), 6 (DNS), 15 (domain name), 42 (NTP), 66 (TFTP boot for VoIP phones and PXE).
- **Relay / IP helper** — DHCP requests are broadcasts and broadcasts don't cross routers. A relay agent (`ip helper-address` on Cisco) forwards them to a DHCP server on another subnet.

### DNS — the address book that makes any of this usable

You don't memorize `2606:4700:4700::1111` — you type `cloudflare.com`. DNS resolves names to addresses.

| Record | What it does |
|---|---|
| **A** | Hostname → IPv4 address |
| **AAAA** | Hostname → IPv6 address (read: "quad-A") |
| **CNAME** | Alias — hostname → another hostname. Cannot coexist with other records at the same name |
| **MX** | Mail exchange — where to deliver email, with priority values |
| **TXT** | Arbitrary text — SPF, DKIM, domain verification |
| **NS** | Nameserver — which servers are authoritative for this zone |
| **PTR** | Reverse lookup — IP → hostname. Lives in `in-addr.arpa` (v4) or `ip6.arpa` (v6) |
| **SOA** | Start of authority — zone metadata, serial, refresh timers |

**Zone types:** **Forward** (name→IP, normal direction). **Reverse** (IP→name, used by mail servers for anti-spam). **Primary** (read-write master). **Secondary** (read-only copy, synced via zone transfer).

**Authoritative vs non-authoritative:** Authoritative servers *own* the zone — source of truth. Non-authoritative servers answer from cache. Your ISP's resolver is non-authoritative for `google.com`; Google's nameservers are authoritative.

**Recursive vs iterative:** Recursive resolvers do all the legwork — walk from root → TLD → authoritative, return final answer (`8.8.8.8`, your home router). Iterative servers answer with the best they know ("ask this other server") and the client follows the chain. Root servers answer iteratively.

**Hosts file** — `/etc/hosts` on Unix, `C:\Windows\System32\drivers\etc\hosts` on Windows. Local override consulted *before* DNS. Useful for testing, abused by malware to hijack banking sites. *Check the hosts file when DNS lookups return weird results that don't match what nslookup shows — the OS is shortcutting around DNS entirely.*

### DNS security

- **DNSSEC** — signs DNS responses cryptographically so a resolver can verify the answer wasn't tampered with. Does **not** encrypt — anyone can still see the query. Integrity, not confidentiality.
- **DoH (DNS over HTTPS)** — port 443. DNS tunneled inside HTTPS. Encrypted, looks like normal web traffic, hard to filter.
- **DoT (DNS over TLS)** — port 853. Same idea on a dedicated port. Easier to identify and block.

> **CompTIA exam trap:** DNSSEC and DoH/DoT solve different problems. DNSSEC = "is this answer real?" (integrity). DoH/DoT = "can anyone see what I'm asking?" (confidentiality). You can run both.

### Time protocols (because nothing works without sync)

Kerberos breaks at 5 minutes of clock skew. Log correlation across servers is impossible if timestamps disagree. TLS certs fail validation.

- **NTP** — UDP 123. Hierarchical stratum model. Stratum 0 = atomic clock or GPS. Stratum 1 = directly connected to S0. Each hop adds a stratum.
- **PTP** — IEEE 1588, sub-microsecond accuracy. Finance, broadcast, industrial control. Requires hardware timestamping for full precision.
- **NTS** — authenticated NTP. Prevents an attacker from spoofing time and breaking certs or replaying old auth tokens.

### CompTIA exam traps

> **Trap:** IPv6 has no broadcast. Anything that "broadcasts" in IPv4 is multicast in IPv6. `ff02::1` = all nodes on link. `ff02::2` = all routers on link.

> **Trap:** EUI-64 takes a 48-bit MAC, splits it, inserts `fffe` in the middle, and flips the universal/local bit. The exam may show a MAC and ask for the resulting interface ID. Privacy extensions (RFC 4941) randomize this instead — default on Windows and iOS.

> **Trap:** A CNAME cannot coexist with any other record at the same name. You cannot have a CNAME and an MX on `example.com` apex. That's why "ALIAS" or "ANAME" records exist at some DNS providers.

## Helpdesk reality

- User says: *"The internet works on my phone but not my laptop."* Check if the laptop has both an IPv4 and IPv6 default route. Sometimes IPv6 gets a route via RA but IPv4 DHCP failed, and the OS prefers IPv6 — so half of sites work and half time out.
- User says: *"Some websites load and some don't."* Check DNS first. `nslookup` the broken site against `8.8.8.8` vs the local resolver. If 8.8.8.8 resolves it and the local one doesn't, it's a DNS problem, not connectivity.
- Never promise: *"IPv6 won't cause any issues, just leave it on."* It will, eventually — usually when a misconfigured RA from a rogue Windows box with Internet Connection Sharing starts handing out fake routes on your subnet.
- First-check rule: `ipconfig /all` or `ip -6 addr`. Confirm the host has a link-local, a global unicast, and a default route. Missing link-local = stack is broken. Missing global = RAs aren't arriving. Missing route = router isn't advertising itself.
- Escalation: if the client side is healthy but external IPv6 still fails, it's an upstream routing or firewall issue — network team ticket.

## Related concepts

[[IPv4 Addressing And Subnetting]] · [[DHCP]] · [[DNS Hierarchy And Resolution]] · [[Neighbor Discovery Protocol]] · [[Dual Stack And Tunneling]] · [[Multicast And Anycast]] · [[Network Time Protocol]] · [[DNS Security DNSSEC DoH DoT]] · [[Default Gateway And Routing]]

*Source: VIRGIL knowledge base — 2026-05-11*