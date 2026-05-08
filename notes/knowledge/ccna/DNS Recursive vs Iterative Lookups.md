# DNS Recursive vs Iterative Lookups

## What it is

In Metal Gear, when Solid Snake needs to reach Big Boss inside Outer Heaven, he doesn't have the map. He calls Big Boss on the Codec (frequency 120.79, ironically the man he's hunting) and gets told where to go next — one room, one objective at a time. Each contact hands him the next breadcrumb. That's exactly what an **iterative DNS lookup** does — each server points the asker one step closer instead of solving the whole thing.

A **recursive lookup** is the opposite: the client asks one resolver and that resolver does all the legwork, returning only the final answer. An **iterative lookup** is when each server queried returns either the answer or a referral to the next server down the hierarchy.

## Why it matters

If recursion breaks, clients can't resolve names — which means no web, no email, no Active Directory logins, no certificate validation. DNS resolvers that allow **open recursion** to the internet get weaponized into [[DNS amplification attacks]], turning a 60-byte query into a 4000-byte response aimed at a victim. On the CCNA, expect to identify which device performs recursion (the resolver), which performs iteration (root, TLD, authoritative), and to read the **RD flag** in a packet capture.

## Key facts

### The walk down the namespace

A typical resolution of `www.example.com` from a cold cache:

1. Client → **Recursive resolver**: "Give me www.example.com" (RD=1)
2. Resolver → **Root server** (`.`): "Where is .com?" → referral to TLD
3. Resolver → **TLD server** (`.com`): "Where is example.com?" → referral to authoritative
4. Resolver → **Authoritative server** (`example.com`): "Where is www?" → A record returned
5. Resolver → Client: final answer

The client did one query. The resolver did four. Steps 2–4 are **iterative**; step 1 is **recursive**.

### Recursive vs iterative side by side

| Property | Recursive | Iterative |
|---|---|---|
| Who does the work | The queried server | The querying client/resolver |
| Returns | Final answer (or failure) | Answer **or referral** |
| Used by | Stub resolvers → recursive resolver | Recursive resolver → root/TLD/authoritative |
| RD flag in query | 1 | 0 |
| RA flag in response | 1 (if supported) | 0 |
| Load on server | High | Low |

### The flags that decide behavior

- **RD (Recursion Desired)** — set by the client. "Please do this for me."
- **RA (Recursion Available)** — set by the server. "I'm willing to."
- If RD=1 and RA=0, the server answers iteratively (referral only) or refuses.
- Root and TLD servers always answer **iteratively**. They will not recurse for you. Ever.

### Caching and TTL

Every record carries a **TTL** (Time To Live) in seconds, set by the zone admin. The resolver caches the answer for that long, so the next client asking gets an instant reply without bothering root again.

- Typical web record TTL: **300–3600 seconds**
- Long-lived NS/MX records: **86400 seconds** (1 day)
- TTL=0 means "do not cache" (rare, used during cutovers)
- **Negative caching** (RFC 2308): NXDOMAIN responses also cached, governed by the SOA **minimum** field

Short TTLs mean fast failover but heavier query load. Long TTLs mean efficient caching but slow change propagation. This is the lever you pull before a planned migration.

### Useful commands

```
nslookup www.cisco.com 8.8.8.8
dig www.cisco.com @8.8.8.8 +trace
dig www.cisco.com @8.8.8.8 +norecurse
```

`+trace` simulates the iterative walk from root downward — the educational view.
`+norecurse` sends RD=0; useful for asking a resolver "what's in your cache right now?"

### On Cisco IOS

```
ip domain lookup
ip name-server 8.8.8.8 1.1.1.1
ip domain name example.com
```

The router is acting as a **stub resolver** — it sends recursive queries (RD=1) to its configured name servers. It does not perform iteration itself.

### Port and transport

- **UDP/53** for standard queries
- **TCP/53** for responses >512 bytes (or >4096 with EDNS0) and zone transfers
- **UDP/853** and **TCP/853** for DoT (DNS over TLS) — outside CCNA scope but worth knowing

## Related concepts

[[DNS Hierarchy]] · [[Authoritative vs Caching Servers]] · [[DNS Cache Poisoning]] · [[DNS Amplification Attack]] · [[EDNS0]] · [[A and AAAA Records]] · [[SOA Record]] · [[DHCP Option 6]]

---
*Source: VIRGIL knowledge base — 2026-05-07*