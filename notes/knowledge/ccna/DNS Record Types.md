# DNS Record Types

## What it is

In Battlefield, when you spawn you pick a target: a squadmate, a vehicle, a fixed point on the map, a Forward Spawn Beacon. Each spawn point is a different *kind* of marker — squadmate is a moving infantry slot, the beacon is a fixed coordinate, the vehicle is a transport, the HQ is the fallback. Same lookup ("where do I go?"), different record types describing different destinations. That's exactly what **DNS record types** do — they tell a resolver what kind of answer it's getting back: a host, an alias, a mail server, an authority.

A **DNS resource record (RR)** is a typed entry in a zone file that maps a name to a value, with a TTL governing how long resolvers may cache it.

## Why it matters

Misconfigured records break the internet visibly: a missing **MX** kills inbound mail, a stale **A** record routes users to a decommissioned host, a wrong **PTR** trips spam filters, and a missing **CAA** lets any CA issue certs for your domain. On the CCNA you are expected to recognize each type by purpose and identify which record answers a given query — especially A vs AAAA vs CNAME vs MX vs PTR.

## Key facts

### The records you must know

| Type | Purpose | Example value |
|------|---------|---------------|
| **A** | Hostname → IPv4 address | `192.0.2.10` |
| **AAAA** | Hostname → IPv6 address | `2001:db8::10` |
| **CNAME** | Alias → canonical hostname | `www → app.example.com.` |
| **MX** | Mail exchanger with priority | `10 mail.example.com.` |
| **NS** | Delegates a zone to a nameserver | `ns1.example.com.` |
| **PTR** | IP → hostname (reverse) | `10.2.0.192.in-addr.arpa → host.example.com.` |
| **SOA** | Start of Authority — zone metadata | serial, refresh, retry, expire, minimum TTL |
| **TXT** | Free-form text — used for SPF/DKIM/DMARC | `"v=spf1 ip4:192.0.2.0/24 -all"` |
| **CAA** | Authorizes which CAs may issue certs | `0 issue "letsencrypt.org"` |

### A and AAAA — the workhorses

[[A record]] resolves to a 32-bit [[IPv4]] address. [[AAAA record]] (called "quad-A") resolves to a 128-bit [[IPv6]] address. The name AAAA is literal: four times the bits of an A record. A host can have both — the resolver picks based on protocol stack and [[Happy Eyeballs]] preference.

```
dig +short example.com A
dig +short example.com AAAA
```

### CNAME — the alias

[[CNAME record]] points one name at another name, not an address. The resolver follows the chain until it hits an A/AAAA. Two hard rules:

- A CNAME **cannot coexist** with any other record at the same name (this is why you cannot put a CNAME at the zone apex — the apex must hold SOA and NS).
- Chained CNAMEs work but cost extra lookups. Keep chains short.

### MX — mail routing with priority

[[MX record]] names the mail server(s) for a domain, each with a **preference value** (lower = preferred). Sender tries the lowest first; ties are load-balanced.

```
example.com.   IN  MX  10 mail1.example.com.
example.com.   IN  MX  20 mail2.example.com.
```

The MX target must be a hostname with an A/AAAA — never an IP, never a CNAME.

### NS — delegation

[[NS record]] declares which nameservers are authoritative for a zone. They appear both at the parent (delegating) and the child (authoritative) zone. This is how the [[DNS hierarchy]] is stitched together from root → TLD → your zone.

### PTR — reverse lookup

[[PTR record]] maps an IP back to a name, living in the special `in-addr.arpa` (IPv4) or `ip6.arpa` (IPv6) zones. The IPv4 octets are reversed:

```
dig -x 192.0.2.10
; equivalent to:
dig 10.2.0.192.in-addr.arpa PTR
```

Mail servers check PTR records to detect spam. No PTR, no delivery — at least not to anyone strict.

### SOA — the zone's birth certificate

Every zone has exactly one [[SOA record]]. It carries:

| Field | Meaning |
|-------|---------|
| MNAME | Primary master nameserver |
| RNAME | Admin email (with `.` instead of `@`) |
| Serial | Version number — secondaries compare this to decide if they need to transfer |
| Refresh | How often secondaries poll |
| Retry | Wait after a failed poll |
| Expire | When secondaries give up serving stale data |
| Minimum | Negative-cache TTL (NXDOMAIN cache time) |

Bump the serial or your secondaries will not update. This is the most common self-inflicted DNS wound.

### TXT — the junk drawer that runs email security

[[TXT record]] holds arbitrary strings. Modern internet abuses this for:

- **[[SPF]]** — `"v=spf1 ip4:192.0.2.0/24 -all"` — which IPs may send mail as you.
- **[[DKIM]]** — public key for verifying signed mail headers.
- **[[DMARC]]** — `_dmarc.example.com TXT "v=DMARC1; p=reject; rua=..."` — what to do when SPF/DKIM fail.

### CAA — the bouncer for certificates

[[CAA record]] tells public CAs which of them are allowed to issue certificates for your domain. Without it, any CA in your browser's trust store can issue for you — which is how mis-issuance incidents happen.

```
example.com.   IN  CAA  0 issue "letsencrypt.org"
example.com.   IN  CAA  0 iodef "mailto:security@example.com"
```

### Quick query reference

```
dig example.com           # default A
dig example.com AAAA
dig example.com MX
dig example.com NS
dig example.com TXT
dig example.com SOA
dig example.com CAA
dig -x 192.0.2.10         # PTR
nslookup -type=mx example.com
```

## Related concepts

[[DNS]] · [[DNS hierarchy]] · [[Recursive resolver]] · [[Authoritative nameserver]] · [[TTL]] · [[Zone transfer]] · [[AXFR]] · [[IPv4]] · [[IPv6]] · [[SPF]] · [[DKIM]] · [[DMARC]] · [[Happy Eyeballs]]

---
*Source: VIRGIL knowledge base — 2026-05-07*