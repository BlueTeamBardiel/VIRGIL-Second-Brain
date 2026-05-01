# Domain Name System
**Tagline:** DNS translates human-readable domain names to IP addresses—master this and you control how every device finds every server on the internet.

## Why This Matters
DNS is the phonebook of the internet. Without it, users would memorize IP addresses instead of typing google.com. For CCNA, you need to understand how DNS queries work end-to-end, configure Cisco devices as DNS clients and servers, and troubleshoot resolution failures in the lab and exam.

---

## Core Concept: How DNS Works

Think of DNS like asking a receptionist for directions. You ask "Where is the marketing department?" instead of memorizing "Building 3, Floor 2, Room 207." The receptionist knows, or knows who to ask. That's DNS—a system that translates names ([[FQDN]]s) into IP addresses ([[A records]]).

### The Simple Version
A device needs to reach www.example.com. It asks a DNS server: "What's the IP for www.example.com?" The server responds with an IP address (e.g., 93.184.216.34). Done. The device connects using that IP.

### The Detailed Version
DNS uses a **hierarchical, distributed system** of servers arranged in a tree structure. When a device can't find an answer locally, it queries upstream servers in a specific order until it gets a response or runs out of options.

---

## DNS Hierarchy and Resolution Process

### The DNS Tree Structure
```
root (.)
├── com
│   ├── example
│   └── cisco
├── org
└── edu
```

**Root nameservers** sit at the top. They direct queries toward **Top-Level Domain (TLD) nameservers** (com, org, edu, etc.). TLD servers direct queries to **authoritative nameservers** that hold the actual records for specific domains.

### Name Resolution: Recursive vs. Iterative Lookups

| Lookup Type | Behavior | Who Performs |
|---|---|---|
| **Recursive** | Client asks DNS server: "Get me the answer" | Client → Resolver (ISP DNS, 8.8.8.8, etc.) |
| **Iterative** | Server responds: "I don't know, ask this server instead" | Resolver → Root, TLD, Authoritative servers |

**Real scenario:** Your PC makes a **recursive query** to your ISP's resolver. The resolver makes **iterative queries** up the DNS hierarchy, following referrals until it finds the answer, then sends it back to your PC.

---

## DNS Record Types

| Record Type | Purpose | Example |
|---|---|---|
| **A** | Maps FQDN to IPv4 address | example.com → 93.184.216.34 |
| **AAAA** | Maps FQDN to IPv6 address | example.com → 2606:2800:220:1:248:1893:25c8:1946 |
| **CNAME** | Canonical name; alias for another domain | www.example.com → example.com |
| **MX** | Mail exchange; directs email to mail servers | example.com → mail.example.com (priority 10) |
| **NS** | Nameserver; delegates authority to other servers | example.com → ns1.example.com |
| **SOA** | Start of Authority; contains zone metadata | Includes serial, refresh, retry, expire timers |
| **PTR** | Pointer; reverse lookup (IP → FQDN) | 34.216.184.93.in-addr.arpa → example.com |
| **TXT** | Text records; often used for SPF, DKIM | v=spf1 include:_spf.google.com ~all |

---

## DNS on Cisco IOS

### Cisco IOS as a DNS Client

A Cisco device can **resolve FQDNs to IP addresses** for operations like pinging a server by name or connecting to a remote device via SSH.

#### Configuration

```ios
! Define DNS servers the device queries
ip name-server 8.8.8.8
ip name-server 8.8.4.4

! Enable DNS lookup (enabled by default)
ip domain-lookup

! Set the default domain appended to unqualified names
ip domain-name example.com

! Optional: define a list of DNS search domains
ip domain-list example.com
ip domain-list cisco.com
```

#### Verification

```ios
! View current DNS configuration
show hosts

! View DNS settings
show ip name-servers

! Test DNS resolution
ping www.example.com

! Manually query DNS and display output
nslookup www.example.com

! Trace DNS resolution path
nslookup www.example.com 8.8.8.8
```

#### How It Works
When you type `ping www.example.com`, the IOS device:
1. Checks its local **DNS cache**
2. Queries the first `ip name-server` configured
3. If that fails, tries the next server in the list
4. Returns the IP or "unresolved hostname" error

**Pro tip:** On devices without internet access, disable DNS lookup with `no ip domain-lookup` to prevent timeout delays when you mistype a command.

---

### Cisco IOS as a DNS Server

A router or switch can **host DNS records** for devices on its network, acting as an authoritative nameserver or caching resolver.

#### Configuration

```ios
! Enable DNS server functionality
ip dns server

! Define A records (hostname-to-IP mappings)
ip host router1 192.168.1.1
ip host switch1 192.168.1.2
ip host pc1 192.168.1.10

! Define the domain name for the network
ip domain-name example.com

! Optional: Define multiple A records for load balancing
ip host server 10.0.0.1
ip host server 10.0.0.2
```

#### Verification

```ios
! View all configured DNS records
show hosts

! Test the server by querying it from another device
nslookup router1 192.168.1.1
```

#### Use Cases
- **Small offices** with no external DNS service
- **Lab environments** where you need deterministic name resolution
- **Redundancy**: Devices can fall back to the local router if the ISP's DNS goes down

---

## DNS Caching and TTL

### Time To Live (TTL)
Each DNS record has a **TTL value** (measured in seconds) that tells clients how long to cache the answer before querying again.

| TTL Value | Behavior |
|---|---|
| **300** | 5 minutes; used for frequently changing records |
| **3600** | 1 hour; common for stable records |
| **86400** | 24 hours; long caching for rarely changing records |

**Cisco context:** When a router caches a DNS response, it respects the TTL. After TTL expires, the next query goes to the DNS server again.

### Cache Poisoning Risk
If an attacker injects a false DNS record into the cache, clients receive the wrong IP and get redirected to a malicious site. Modern DNS uses **DNSSEC** (DNS Security Extensions) to cryptographically verify records, but basic DNS is vulnerable.

---

## Lab Relevance: Cisco IOS Commands

### DNS Client Configuration

```ios
! Set primary and secondary nameservers
Router(config)# ip name-server 8.8.8.8 8.8.4.4

! Enable domain lookup
Router(config)# ip domain-lookup

! Set domain name
Router(config)# ip domain-name example.com

! Add search domains
Router(config)# ip domain-list example.com
Router(config)# ip domain-list cisco.com
```

### DNS Server Configuration

```ios
! Enable DNS server
Router(config)# ip dns server

! Define static host-to-IP mappings
Router(config)# ip host webserver 10.0.0.5
Router(config)# ip host mailserver 10.0.0.6 10.0.0.7

! Set authoritative domain
Router(config)# ip domain-name example.com
```

### Verification Commands

```ios
! Show DNS configuration and cache
Router# show hosts

! Query a DNS server
Router# nslookup www.example.com

! Query a specific nameserver
Router# nslookup www.example.com 8.8.8.8

! Enable DNS debug (verbose output)
Router# debug ip dns

! Disable DNS debug
Router# undebug all
```

### Troubleshooting Commands

```ios
! Clear DNS cache
Router# clear ip dns cache

! Verify nameserver reachability
Router# ping 8.8.8.8

! Check DNS configuration
Router# show running-config | include dns

! Test resolution with timeout
Router# nslookup www.example.com timeout 5
```

---

## Common DNS Issues and Resolution

### Issue: "Unresolved Hostname"
**Cause:** No DNS servers configured or nameserver unreachable.  
**Fix:** Verify `show ip name-servers`, ensure nameserver IP is reachable via `ping`.

### Issue: Slow DNS Resolution
**Cause:** Nameserver latency or DNS server down.  
**Fix:** Add a secondary nameserver with `ip name-server`. Use `debug ip dns` to see query times.

### Issue: Wrong IP Resolution
**Cause:** TTL expired, cache stale, or DNS poisoning.  
**Fix:** Clear cache with `clear ip dns cache`. Verify record with `nslookup` against authoritative server.

### Issue: Device Hangs When Typing Commands
**Cause:** `ip domain-lookup` enabled and trying to resolve typos as hostnames.  
**Fix:** Disable with `no ip domain-lookup` in production environments.

---

## Exam Tips: What CCNA Tests

### What the Exam Focuses On

1. **DNS Resolution Process**
   - Understand recursive vs. iterative lookups
   - Know the hierarchy: root → TLD → authoritative
   - Be able to trace a resolution path

2. **Record Types (A, AAAA, CNAME, MX, NS, SOA, PTR)**
   - Match record types to use cases (e.g., MX for email)
   - Understand CNAME aliases and PTR reverse lookups
   - Know what SOA contains (serial, refresh, retry, expire)

3. **Cisco IOS DNS Client Configuration**
   - Configure `ip name-server` with multiple servers
   - Set `ip domain-name` and know how it affects unqualified hostname resolution
   - Verify with `show hosts` and `nslookup`

4. **Cisco IOS DNS Server Configuration**
   - Configure static hosts with `ip host`
   - Enable with `ip dns server`
   - Understand when this is useful (SOHO, lab, no external DNS)

5. **Troubleshooting DNS**
   - Interpret `show ip name-servers` output
   - Use `debug ip dns` to see queries in real time
   - Clear cache and verify specific servers

### Tricky Questions

**Q: You configure `ip domain-name example.com` on a router. A user types `ping router1`. What FQDN is actually queried?**  
**A:** `router1.example.com` — the domain name is appended to unqualified names.

**Q: A device has two `ip name-server` entries. When does it query the second?**  
**A:** When the first nameserver times out (default 3 seconds) or returns a failure, not just because the query failed.

**Q: What's the difference between `ip host` and `ip name-server`?**  
**A:** `ip host` creates static local entries (no external query). `ip name-server` points to external servers the device queries for unknown names.

**Q: You issue `nslookup example.com 8.8.8.8`. What does the second parameter do?**  
**A:** It specifies which nameserver to query (8.8.8.8) instead of using configured nameservers.

---

## Common Mistakes

### Mistake 1: Forgetting `ip dns server` is Disabled by Default
**Error:** Configuring `ip host` entries but other devices can't resolve them.  
**Fix:** Always enable `ip dns server` when setting up a local DNS server.

### Mistake 2: Confusing Domain Name with Domain List
**Error:** Setting `ip domain-name` then expecting both `ip domain-list` entries to be searched.  
**Fix:** `ip domain-name

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 3 | [[CCNA]]*
