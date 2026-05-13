# DNS Records

## What it is

In **Breath of the Wild**, when you stand on a tower and pull out the Sheikah Slate, the map fills in — but the place names come later. You see a shape on the horizon and the Slate tells you: that's Hateno Village. That's Death Mountain. That's the Akkala Tower. The shape is the coordinates. The name is what your brain actually remembers. Without the Slate doing the translation, you're just memorizing latitude and longitude in a world where everyone else is saying "meet me at Kakariko."

That's exactly what DNS records do. The internet runs on IP addresses — `142.250.80.46` — but humans say `google.com`. DNS records are the entries in a distributed database that map names humans use to addresses machines route on, plus a pile of other metadata: which server handles your mail, which server signs your zone, which IPv6 address serves the same name.

Technically: a **DNS record** (also called a **resource record**, or RR) is a single entry in a DNS zone file. Each record has a **name**, a **type** (A, AAAA, MX, etc.), a **class** (almost always IN for internet), a **TTL** (time-to-live, in seconds), and **record data** (the value). DNS itself runs on **port 53** — UDP for queries, TCP for zone transfers and responses larger than 512 bytes (and increasingly for DoT/DoH variants).

## Why it matters

DNS is the address book in your head. Break it and the network looks broken even though every cable is fine, every router is up, every host is reachable by IP. "The internet is down" almost always means "DNS is down." Net+ tests DNS heavily because it's the single most common service-layer failure in the field, and because [[Objective 1.4]] expects you to know the protocol, and [[Objective 1.6]] (DNS in network services) expects you to know the record types cold.

In production, DNS is also a security surface. **DNS poisoning**, **DNS tunneling**, and **typosquatting** all exploit the fact that users and machines trust whatever the resolver returns. Knowing what each record type does is the difference between fixing a mail outage in five minutes and spending three hours wondering why outbound mail works but inbound doesn't.

## Key facts

### The record types you must know

| Type | Name | Purpose |
|------|------|---------|
| **A** | Address | Maps hostname → IPv4 address |
| **AAAA** | Quad-A | Maps hostname → IPv6 address |
| **CNAME** | Canonical Name | Alias one hostname to another hostname |
| **MX** | Mail Exchange | Which server handles mail for this domain |
| **NS** | Name Server | Which DNS servers are authoritative for this zone |
| **PTR** | Pointer | Reverse lookup — IP → hostname |
| **SOA** | Start of Authority | Zone metadata: primary NS, admin email, serial, TTLs |
| **TXT** | Text | Arbitrary text — used for SPF, DKIM, domain verification |
| **SRV** | Service | Locates services (SIP, LDAP, AD) by name and port |
| **CAA** | Cert Authority Authorization | Which CAs are allowed to issue certs for this domain |

Memorize this table. CompTIA will test it directly.

### A and AAAA — the bread and butter

**A records** map a name to an IPv4 address. One name can have multiple A records (round-robin load balancing — the resolver gets a list and picks one). **AAAA records** do the same thing for IPv6. Same name, different record type. A host with dual-stack networking will have both.

*Reality check: if `ping hostname` resolves but `ping hostname -6` fails, the AAAA record is missing or the host isn't reachable on v6. This is increasingly common as IPv6 deploys unevenly.*

### CNAME — the alias

A **CNAME** points one name at another name, not at an IP. `www.example.com` CNAME `example.com` means "ask again for example.com and use whatever you get."

> **CompTIA exam trap:** A CNAME record cannot coexist with any other record for the same name. You cannot have both a CNAME and an MX record on `example.com` itself. This is why the apex (root) of a domain typically uses an A record and `www` uses the CNAME. Also: CNAMEs cannot point to IP addresses — only to other hostnames.

### MX — mail routing

**MX records** tell the world which server accepts mail for a domain. Each MX record has a **priority** (lower = preferred) and a **hostname** (which must itself resolve to an A or AAAA — no CNAMEs). Multiple MX records provide failover.

```
example.com.   IN   MX   10  mail1.example.com.
example.com.   IN   MX   20  mail2.example.com.
```

Sender tries priority 10 first. If it's down, falls back to 20.

### PTR — reverse DNS

**PTR records** map IP → name, the opposite of an A record. They live in a special reverse zone (`in-addr.arpa` for v4, `ip6.arpa` for v6). Mail servers check PTR records to fight spam — if your outbound mail server's IP doesn't have a matching PTR, your mail gets junked.

*I learned this the hard way running a homelab mailserver: forward DNS perfect, mail rejected by Gmail because no PTR. The ISP has to set it for you — you can't set PTR on an IP you don't own.*

### SOA and NS — zone authority

**NS records** list the authoritative name servers for a zone. **SOA** is the single record at the top of every zone with:

- **Primary NS** — the master server
- **Admin email** — with the `@` replaced by a `.` (because `@` already means "this zone")
- **Serial number** — incremented on every change; secondaries compare serials to know when to pull updates
- **Refresh / Retry / Expire / Minimum TTL** — timing for zone transfers and negative caching

### TXT — the junk drawer that runs email security

TXT records hold arbitrary text. Modern internet leans on them hard:

- **SPF** — lists which IPs are allowed to send mail for your domain
- **DKIM** — public key used to verify mail signatures
- **DMARC** — policy telling receivers what to do with mail that fails SPF/DKIM
- **Domain verification** — Google, Microsoft, etc. make you add a TXT record to prove you own the domain

> **CompTIA exam trap:** SPF used to have its own record type (`SPF`). It's deprecated. SPF lives in a TXT record now. If an answer choice says "SPF record type," it's a trap unless the question is asking what's deprecated.

### SRV — service location

**SRV records** specify the hostname AND port for a service. Format: `_service._proto.name`. Active Directory uses SRV records heavily — domain-joined machines find domain controllers by querying `_ldap._tcp.dc._msdcs.example.com`. SIP phones find their registrar via `_sip._udp.example.com`.

### CAA — who can issue certs

**CAA records** restrict which certificate authorities can issue TLS certs for your domain. If you put a CAA record saying "only Let's Encrypt," DigiCert is supposed to refuse to issue. Prevents an attacker from social-engineering a different CA into issuing a rogue cert.

### TTL — the caching knob

Every record has a **TTL** in seconds — how long resolvers may cache it before re-querying. Low TTL (60–300s) = fast propagation, more query load. High TTL (3600–86400s) = less query load, slow propagation. Standard move: lower the TTL 24 hours *before* a planned change so the world has flushed its cache by the time you flip the record.

*Reality check: if you change a record and "it's not updating," 95% of the time it's a cached old value somewhere — your local resolver, the client's stub resolver, the browser's internal cache. `ipconfig /flushdns` on Windows, `sudo dscacheutil -flushcache` on macOS, restart `systemd-resolved` on Linux.*

### DNSSEC — signed records

**DNSSEC** adds cryptographic signatures to DNS responses. Adds record types: **RRSIG** (signature), **DNSKEY** (the public key), **DS** (delegation signer in the parent zone), **NSEC/NSEC3** (proves a name doesn't exist). DNSSEC validates that the record you got is the record the zone owner published — it does NOT encrypt the query. For encryption, see **DoT** (DNS over TLS, port 853) and **DoH** (DNS over HTTPS, port 443).

### CompTIA exam traps

> **CompTIA exam trap:** DNS uses **UDP/53** for normal queries. It uses **TCP/53** for zone transfers (AXFR/IXFR between primary and secondary servers) and for any response too large for a single UDP packet. Both ports must be open on firewalls between authoritative servers. A firewall that only allows UDP/53 will silently break zone transfers.

> **CompTIA exam trap:** Forward lookup = name → IP. Reverse lookup = IP → name. Forward uses A/AAAA. Reverse uses PTR. CompTIA loves to swap these in answer choices.

> **CompTIA exam trap:** The "@" symbol in a zone file means "this zone's apex." So `@ IN A 1.2.3.4` sets the A record for the bare domain (`example.com`), not for any subdomain.

## Helpdesk reality

- User says: **"The internet is down."** First check: can they ping `8.8.8.8`? If yes, DNS is broken. If no, it's a real connectivity issue. This one test cuts your troubleshooting time in half.
- User says: **"This website won't load but I can get to Google."** Their resolver may be returning stale or poisoned results for that specific domain. Try `nslookup` or `dig` against a different resolver (1.1.1.1, 8.8.8.8). If results differ, it's a DNS problem, not a connectivity problem.
- User says: **"I changed the DNS record an hour ago and it's still not working."** TTL hasn't expired. Flush the local cache. Check what TTL was set on the old record — if it was 86400, you're waiting up to 24 hours.
- Never promise: **"DNS changes are instant."** They never are. The honest answer is "your local cache should update in [TTL] seconds, but external resolvers may take longer."
- Escalation point: if `dig +trace` shows the authoritative server returning the wrong record, it's not a caching problem — it's an admin problem. The zone owner has to fix it. If the authoritative is correct but your resolver disagrees, escalate to whoever runs your recursive resolver.

## Related concepts

[[DNS Server Roles]] · [[DNS Poisoning]] · [[DNSSEC]] · [[DoH and DoT]] · [[DHCP]] · [[Active Directory]] · [[SMTP and Mail Flow]] · [[Subnetting]] · [[IPv6 Addressing]] · [[Network Troubleshooting Methodology]] · [[nslookup and dig]] · [[Reverse DNS]] · [[TTL and Caching]]

*Source: VIRGIL knowledge base — 2026-05-11*