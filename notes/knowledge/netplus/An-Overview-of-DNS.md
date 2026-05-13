# An Overview of DNS

## What it is

In **Overwatch**, when you queue for a match, you don't tell Blizzard's matchmaker the IP address of the server in Virginia. You click "Find Match." Somewhere behind the scenes, the client asks a name service: *where do I send this player?* The matchmaker resolves your region, your role, your latency profile, and hands back a server endpoint. You never see the IP. You just see Hanamura loading. That's exactly what DNS does — it turns names humans remember into addresses machines need.

**DNS (Domain Name System)** is the distributed, hierarchical naming service that resolves human-readable domain names (like `playoverwatch.com`) into IP addresses (like `137.221.106.34`). It runs on **UDP port 53** for standard queries and **TCP port 53** for zone transfers and responses larger than 512 bytes. It is the address book in your head — without it, you can dial numbers, but you can't call anyone by name.

The Internet has roughly 350 million registered domain names. No human is typing IPv6 addresses into a browser. DNS is the layer that makes the whole system usable.

## Why it matters

DNS failures look like total Internet outages to users. "The Internet is down" is, 9 times out of 10, "DNS isn't resolving." When a major DNS provider goes down — Dyn in 2016, Facebook's own DNS in 2021 — billions of users see broken websites even though the underlying servers are fine. The packets have nowhere to go because nobody can look up the address.

For Network+ (Objective 1.4), you must know DNS runs on port 53, know it's primarily UDP but uses TCP for zone transfers, and recognize it in scenarios where name resolution is broken but raw IP connectivity works. CompTIA loves the troubleshooting scenario: "user can ping 8.8.8.8 but can't load google.com" — that's DNS, every time.

Career-wise: every helpdesk ticket about "the Internet is slow" or "I can't reach the file server" eventually routes through DNS troubleshooting. Knowing how to read an `nslookup` or `dig` output is the difference between a 30-second fix and a two-hour escalation.

## Key facts

### How DNS resolution actually works

When you type `playoverwatch.com` into a browser:

1. **Client checks its local cache.** Already resolved it five minutes ago? Done.
2. **Client asks its configured DNS resolver** (usually pushed by [[DHCP]] — often the router, or 8.8.8.8, or 1.1.1.1).
3. **Resolver checks its cache.** If hit, return.
4. **Resolver queries a root server** (`.`). Root says "ask the `.com` TLD server."
5. **Resolver queries the `.com` TLD server.** TLD says "ask Blizzard's authoritative nameserver."
6. **Resolver queries Blizzard's authoritative server.** Authoritative returns the A record: `137.221.106.34`.
7. **Resolver caches the answer** for the TTL (time-to-live) duration and returns it to the client.

This is **recursive resolution from the client's perspective** and **iterative resolution from the resolver's perspective**. The client asks one question and gets one answer. The resolver does the legwork.

### DNS record types (know these cold)

| Record | Purpose |
|--------|---------|
| **A** | Hostname → IPv4 address |
| **AAAA** | Hostname → IPv6 address ("quad-A") |
| **CNAME** | Canonical name — alias pointing to another hostname |
| **MX** | Mail exchanger — where to send email for this domain |
| **NS** | Nameserver — which servers are authoritative for this zone |
| **PTR** | Pointer — reverse lookup, IP → hostname |
| **SOA** | Start of Authority — zone metadata (serial, refresh, expire) |
| **TXT** | Arbitrary text — SPF, DKIM, domain verification |
| **SRV** | Service record — protocol, port, target (used by SIP, LDAP, AD) |

### DNS transport — UDP vs TCP

DNS is fundamentally a **UDP** protocol. Queries are small (under 512 bytes), responses are small, and speed beats reliability. The client asks, gets an answer in one packet, done. If a query times out, the client just retries. This is the same logic as [[UDP]] voice traffic in Overwatch — if a packet drops, oh well, ask again. Fast and loss-tolerant.

**DNS uses TCP when:**
- The response exceeds 512 bytes (common with DNSSEC signatures, large TXT records)
- A **zone transfer** occurs between primary and secondary nameservers (AXFR/IXFR) — these need reliability and ordering, which is [[TCP]]'s job
- The query uses **DNS over TLS (DoT)** on port 853 or **DNS over HTTPS (DoH)** on port 443

### Traffic types — how DNS fits in

DNS queries are almost always **unicast**: one client, one resolver, one answer. But the broader concept of traffic types is on the exam, and DNS touches several:

| Type | What it is | Example |
|------|-----------|---------|
| **Unicast** | One sender, one receiver | Your DNS query to 8.8.8.8 |
| **Broadcast** | One sender, every host on the subnet | ARP requests, DHCP DISCOVER |
| **Multicast** | One sender, a group of subscribed receivers | mDNS (`.local` on 224.0.0.251), routing protocols |
| **Anycast** | One destination address, many physical servers; routing sends you to the nearest | 8.8.8.8, 1.1.1.1, root DNS servers |

**Anycast is the killer feature of modern DNS.** When you query 1.1.1.1, you are not hitting one server in California. Cloudflare announces 1.1.1.1 from hundreds of data centers worldwide. BGP routing delivers your packet to whichever instance is topologically closest. *That's why public DNS feels instant — you're not crossing an ocean to resolve a name.*

### Caching and TTL

Every DNS record has a **TTL** measured in seconds. When the resolver answers your query, you cache it for that duration. Short TTLs (60–300s) let admins move services quickly. Long TTLs (24h+) reduce resolver load but make changes propagate slowly.

When admins are about to migrate a service, the standard play is: **drop the TTL to 60 seconds 24 hours before the cutover**, do the migration, watch traffic shift within a minute, then raise the TTL back up. Forget this step and your old server gets traffic for a full day after you thought you migrated.

### DNS security additions

- **DNSSEC** — cryptographically signs records so resolvers can verify they haven't been tampered with. Defends against **DNS cache poisoning** (where an attacker injects forged records into a resolver's cache). Doesn't encrypt — just authenticates.
- **DoT (DNS over TLS)** — port 853. Encrypts queries so your ISP can't see what you're resolving.
- **DoH (DNS over HTTPS)** — port 443. Same goal, tunneled inside HTTPS so it's indistinguishable from web traffic.

DNSSEC is not DoH. DoH is not DNSSEC. DNSSEC = authenticity. DoH/DoT = confidentiality. *A signed record can still be eavesdropped; an encrypted query can still return a forged answer if DNSSEC isn't validating it.*

### Related protocols on the exam

DNS sits in a constellation of name/address/control protocols. Know them as a family:

- **[[ICMP]]** (no port — it's its own L3 protocol number 1) — used by `ping` and `traceroute`. When `ping google.com` works but the browser doesn't load, that's DNS working (resolved the name) but HTTP failing. When `ping google.com` fails but `ping 8.8.8.8` works, that's DNS broken.
- **[[GRE]]** (protocol 47) — tunneling protocol that encapsulates one network protocol inside another. No ports, since it's a L3 protocol. Common for site-to-site VPNs.
- **[[IPSec]]** — secures IP traffic at L3. Uses **AH (Authentication Header, protocol 51)** for integrity, **ESP (Encapsulating Security Payload, protocol 50)** for encryption + integrity, and **IKE (Internet Key Exchange, UDP 500)** for negotiating the security association. AH alone doesn't encrypt — easy exam trap.
- **IP types** — public, private (RFC 1918: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16), APIPA (169.254.0.0/16), loopback (127.0.0.1).

### CompTIA exam traps

> **CompTIA exam trap:** DNS port is **53** for both UDP and TCP. The protocol is the same, the transport differs by use case. If the answer choices list "UDP 53 only" and "TCP 53 only," neither is fully correct — DNS uses both. Look for "UDP and TCP 53" or read the scenario for the cue (zone transfer = TCP, normal query = UDP).

> **CompTIA exam trap:** **CNAME cannot coexist with other records at the same name.** If `mail.example.com` has a CNAME, it cannot also have an MX or A record. This is a frequent zone-file gotcha. Also: CNAMEs cannot point to an IP — only to another hostname.

> **CompTIA exam trap:** **AH (protocol 51) authenticates but does not encrypt.** **ESP (protocol 50) encrypts and authenticates.** If a question asks which IPSec component provides confidentiality, the answer is ESP, never AH.

> **CompTIA exam trap:** **Anycast vs Multicast.** Anycast: one address, many servers, routed to nearest — used by public DNS resolvers. Multicast: one address, a group of subscribers, all receive the same packet — used by routing protocols and mDNS. They are not interchangeable.

## Helpdesk reality

- **"The Internet is down."** First check: can they ping `8.8.8.8`? If yes, Internet is fine — it's DNS. Run `nslookup google.com`. If that fails, check the DNS server config (`ipconfig /all` on Windows, `cat /etc/resolv.conf` on Linux). Nine times out of ten, the DHCP lease handed them a bad resolver, or their VPN clobbered the DNS settings.
- **"I can reach the file server by IP but not by name."** Classic DNS problem. Either the internal DNS server is down, the host record was never created, or their machine is querying an external resolver that doesn't know about your internal zone. Flush the cache: `ipconfig /flushdns`.
- **"The website worked yesterday, doesn't work today."** Could be DNS propagation after a migration. Check the TTL on the record. If someone moved the service and didn't pre-lower the TTL, you're waiting out the old cache.
- **Never promise a DNS change is "instant."** Even with a 60-second TTL, ISP resolvers and client caches lie. Tell users 15 minutes minimum, an hour to be safe, 24 hours for global propagation.
- **Escalation point:** if `nslookup` against your DNS server fails but the server is up, and a packet capture shows queries leaving the client but no responses returning, it's a network-team ticket. Could be a firewall blocking port 53, could be the resolver itself broken, could be a routing issue. Not a desktop problem anymore.

## Related concepts

[[DHCP]] · [[TCP]] · [[UDP]] · [[ICMP]] · [[GRE]] · [[IPSec]] · [[Anycast]] · [[Multicast]] · [[Unicast]] · [[Broadcast]] · [[Public vs Private IP Addressing]] · [[DNSSEC]] · [[Common Ports and Protocols]]

*Source: VIRGIL knowledge base — 2026-05-11*