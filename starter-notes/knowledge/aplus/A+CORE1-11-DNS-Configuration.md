---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 11
source: rewritten
---

# DNS Configuration
**The internet's address book that translates human-friendly domain names into machine-readable IP addresses.**

---

## Overview

[[DNS]] (Domain Name System) is the backbone service that makes the internet usable for humans. Without it, you'd need to memorize hundreds of IP addresses just to browse the web. Instead of typing `172.217.14.206`, you type `google.com`—and DNS quietly handles the translation behind the scenes, making it one of the most critical services any A+ technician needs to understand.

---

## Key Concepts

### DNS Resolution

**Analogy**: Think of DNS like a phone directory. Instead of remembering everyone's phone number, you look up their name and the directory gives you the digits you need to call them.

**Definition**: The process by which a [[Fully Qualified Domain Name]] (FQDN) like `www.example.com` gets converted into its corresponding [[IP Address]]. Your device sends a query to a [[DNS Server]], which searches through the hierarchical database and returns the correct IP address.

**Key Points**:
- Resolution happens automatically when you enter a domain in your browser
- It's a [[DNS Query]] that travels through multiple servers
- Results are often cached locally to speed up future lookups

---

### Distributed Database Architecture

**Analogy**: Imagine the world's phone directories aren't stored in one building—they're scattered across thousands of buildings worldwide. When you need a number, your local librarian knows who to call to find it.

**Definition**: [[DNS]] isn't stored on one server. It's a [[Distributed Database]] spread across thousands of servers globally, organized hierarchically to handle billions of domain lookups efficiently.

**The Hierarchy**:

| Level | Purpose | Count | Examples |
|-------|---------|-------|----------|
| [[Root Servers]] | Direct queries to correct TLD servers | 13 clusters (1,000+ actual servers) | A through M |
| [[TLD Servers]] | Handle specific domain extensions | ~300 | `.com`, `.org`, `.edu`, `.co.uk` |
| [[Authoritative Nameservers]] | Store actual DNS records for domains | Varies | Your domain's specific records |
| [[Recursive Resolvers]] | User's ISP DNS; caches results | Millions | Your ISP's DNS |

---

### Root Servers and TLD Servers

**Analogy**: Root servers are like the main post office that directs mail to regional centers. TLD servers are those regional centers that know which local post office handles `.com` or `.org` addresses.

**Definition**: [[Root Servers]] are the 13 strategically distributed clusters (actually 1,000+ servers) that serve as the starting point for all DNS queries. They don't store domain records themselves—they tell your resolver which [[TLD Server]] (Top-Level Domain server) to contact.

**TLD Types**:

| TLD Category | Definition | Examples |
|--------------|-----------|----------|
| [[Generic TLDs (gTLDs)]] | General-purpose domains | `.com`, `.org`, `.net`, `.biz` |
| [[Sponsored TLDs (sTLDs)]] | Industry/community specific | `.edu`, `.gov`, `.mil` |
| [[Country Code TLDs (ccTLDs)]] | Geographic regions | `.uk`, `.de`, `.jp`, `.ca` |
| [[Infrastructure TLD]] | Reserved for system use | `.arpa` |

---

### DNS Record Types

**Analogy**: Each DNS record is like a different type of card in a Rolodex—some have phone numbers, some have addresses, some have special routing instructions.

**Definition**: [[DNS Records]] are individual entries that map domain names to various data types, directing traffic appropriately.

| Record Type | Purpose | Example |
|------------|---------|---------|
| [[A Record]] | Maps domain to IPv4 address | `example.com` → `93.184.216.34` |
| [[AAAA Record]] | Maps domain to IPv6 address | `example.com` → `2606:2800:220:1...` |
| [[CNAME Record]] | Alias pointing to another domain | `www.example.com` → `example.com` |
| [[MX Record]] | Directs mail to email server | `example.com` mail goes to `mail.example.com` |
| [[NS Record]] | Specifies authoritative nameservers | Delegates DNS authority |
| [[SOA Record]] | Start of Authority; zone info | Primary server, admin contact, serial |
| [[TXT Record]] | Text records for verification | SPF, DKIM, domain verification |
| [[PTR Record]] | Reverse lookup (IP to domain) | Used for email validation |

---

### DNS Query Process

**Analogy**: It's like asking a friend who asks their friend who asks their friend until someone knows the answer.

**Definition**: The [[DNS Query]] is a multi-step process where your device recursively asks multiple servers until it gets the IP address it needs.

**The 4-Step Journey**:

1. **User sends query** → `nslookup example.com`
2. **Local resolver contacts [[Root Server]]** → "Where's example.com?"
3. **Root directs to [[TLD Server]]** → "Ask the `.com` server"
4. **TLD directs to [[Authoritative Nameserver]]** → "Ask example.com's nameserver"
5. **Authoritative Nameserver replies** → "example.com is 93.184.216.34"
6. **Answer travels back down** → Cached and returned to user

---

### DNS Caching and TTL

**Analogy**: Caching is like writing down a phone number you just looked up in the directory so you don't have to look it up again next time.

**Definition**: [[DNS Caching]] stores recently resolved domain-to-IP mappings locally on your device, ISP, or intermediate servers to reduce query time. [[TTL]] (Time-To-Live) sets how long this cached data remains valid.

**TTL Impact**:
- **Low TTL (300 seconds)** = Frequent updates, slower performance
- **High TTL (86400 seconds)** = Faster lookups, slower propagation of changes
- **Typical default** = 3600 seconds (1 hour)

---

### DNS Configuration on Local Systems

**Analogy**: Your device needs a phone number for the directory itself before it can look anything up.

**Definition**: [[DNS Configuration]] refers to specifying which [[DNS Server]] your device queries when it needs domain resolution. This can happen through [[DHCP]], manual configuration, or system defaults.

**Configuration Methods**:

| Method | Where | Details |
|--------|-------|---------|
| [[DHCP]] | Automatic | ISP's DNS server assigned when connecting |
| [[Static Configuration]] | Manual | Manually enter DNS server IP addresses |
| [[IPv4 Settings]] | Windows/Linux | Set via network adapter properties |
| [[IPv6 Settings]] | Modern systems | Configure AAAA record queries |

**Common Public DNS Servers**:
```
Google: 8.8.8.8, 8.8.4.4
Cloudflare: 1.1.1.1, 1.0.0.1
OpenDNS: 208.67.222.222, 208.67.220.220
```

---

### Recursive vs. Authoritative Resolvers

**Analogy**: A recursive resolver is a librarian who keeps asking other librarians until they find your book. An authoritative server is the librarian who actually owns and knows about the books in their section.

**Definition**: [[Recursive Resolvers]] query on behalf of clients, moving down the hierarchy; [[Authoritative Nameservers]] hold the actual DNS records and answer queries with definitive answers.

| Aspect | Recursive Resolver | Authoritative Nameserver |
|--------|-------------------|-------------------------|
| **Who uses it** | End users, ISPs | Domain registrars, hosting |
| **Purpose** | Queries the full chain | Holds actual records |
| **Caches results** | Yes | No (stores authoritative data) |
| **Example** | Your ISP's DNS | `ns1.example.com` |

---

### FQDN Structure

**Analogy**: An FQDN is like a complete mailing address—you need the house number, street, city, AND state to get mail delivered correctly.

**Definition**: A [[Fully Qualified Domain Name]] is the complete domain name including all labels from root to host, formatted as `host.subdomain.domain.tld.`

**Structure Breakdown**:
```
www.mail.example.com.
│   │    │       │  │
│   │    │       │  └─ Root (implied, rarely shown)
│   │    │       └──── TLD (.com)
│   │    └──────────── Domain (example)
│   └────────────────── Subdomain (mail)
└──────────────────────Hostname (www)
```

---

## Exam Tips

### Question Type 1: DNS Record Identification
- *"A user cannot access their email. The administrator checks the DNS records and finds that the correct server was entered under the A record instead of the **__ record. What's missing?"* → **MX Record** (Mail eXchange)
- **Trick**: Test makers often mix up `A` (address), `AAAA` (IPv6 address), and `CNAME` (alias). Remember: **A = IPv4 addresses ONLY**.

### Question Type 2: Query Process
- *"Where does a DNS client query FIRST when resolving a domain name?"* → **Recursive Resolver (typically ISP DNS)**, NOT the root server directly.
- **Trick**: Candidates often answer "root server," but clients query their configured resolver first.

### Question Type 3: TTL and Propagation
- *"A company changes their DNS records but employees still see the old website. What's the likely cause?"* → **High TTL causing cached results to persist** or **DNS cache hasn't expired**.
- **Trick**: Don't blame the DNS change itself—blame the cache timing out.

### Question Type 4: Configuration Scenarios
- *"A technician manually set a device's DNS to 8.8.8.8 via static IP. After restarting, it reverts to the ISP's DNS. Which service overrides manual settings?"* → **DHCP** is assigning new settings on each lease renewal.
- **Trick**: If a device ignores manual DNS settings, check if [[DHCP]] is still enabled.

---

## Common Mistakes

### Mistake 1: Confusing DNS Records with DNS Servers

**Wrong**: "The A record is a server that resolves domains."

**Right**: An [[A Record]] is a DATA ENTRY in DNS databases that says "example.com = 93.184.216.34." A [[DNS Server]] is the computer that STORES and SERVES these records.

**Impact on Exam**: You'll get questions asking "which **record type** do you need?" vs. "which **server** handles this?" If you mix them up, you'll select the wrong answer.

---

### Mistake 2: Thinking DNS Caching Wastes Time

**Wrong**: "High TTL is bad because it keeps old data longer."

**Right**: High TTL **speeds up** resolution because the answer is cached locally. The trade-off is that DNS changes propagate **slower** globally.

**Impact on Exam**: A question might ask: "How can you ensure DNS changes take effect immediately?" The answer involves **lowering TTL before making changes**, not deleting caches.

---

### Mistake 3: Assuming Root Servers Store All Domain Records

**Wrong**: "When you type a domain, your device queries the root servers directly to get the IP address."

**Right**: Root servers DIRECT your query to the correct [[TLD Server]], which then directs you to the [[Authoritative Nameserver]]. It's a multi-hop process.

**Impact on Exam**: Questions test whether you understand the **hierarchy**. If you think root servers are the endpoint, you'll miss questions about query routing.

---

### Mistake 4: Misidentifying Who Sets DNS Configuration

**Wrong**: "The router sets the device's DNS settings."

**Right**: Either [[DHCP]] (via router/server) or **manual static configuration** sets DNS. The router passes along DHCP settings; it doesn't originate them.

**Impact on Exam**: Troubleshooting questions about "why aren't employees seeing the