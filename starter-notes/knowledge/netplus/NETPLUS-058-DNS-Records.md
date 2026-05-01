---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 058
source: rewritten
---

# DNS Records
**DNS stores multiple record types that enable name resolution, security validation, and host aliasing across networks.**

---

## Overview
Inside every [[DNS]] server's configuration database lives a collection of instructions called [[Resource Records]]. These records function like a digital phonebook—each entry tells the DNS system how to respond to different types of queries. For Network+ certification, you must understand which record types solve which problems: some map hostnames to IP addresses, others validate DNSSEC signatures, and still others create shortcuts through aliases.

---

## Key Concepts

### SOA (Start of Authority) Record
**Analogy**: Think of an SOA record as the "title page" of a book—it introduces the entire zone and provides metadata about what follows.
**Definition**: The [[SOA Record]] is the first entry in a DNS zone file. It contains zone ownership information, the primary nameserver responsible for the zone, contact details, and timing parameters like [[Serial Number]], [[Refresh Interval]], [[Retry Interval]], and [[Expiration Time]].

| Field | Purpose |
|-------|---------|
| Primary Nameserver | Master server for this zone |
| Responsible Party Email | Administrator contact |
| Serial Number | Version tracking for zone updates |
| Refresh Interval | How often secondaries check for updates |
| Retry Interval | How long to wait before retrying failed transfer |
| Expiration Time | How long data remains valid |

### A Record (Address Record)
**Analogy**: An A record is like a house address label—it connects a name (like "home") to a specific location (IP address).
**Definition**: The [[A Record]] maps a [[Fully Qualified Domain Name]] (FQDN) to its [[IPv4]] address. When a DNS client queries "www.example.com," the A record provides the 32-bit IPv4 address (e.g., 192.168.1.10) associated with that hostname.

**Example**:
```
www.example.com    IN    A    192.168.1.100
mail.example.com   IN    A    192.168.1.50
```

### AAAA Record (Quad-A Record)
**Analogy**: An AAAA record is the modern upgrade to the A record—same job, but handles the newer, longer IP address format.
**Definition**: The [[AAAA Record]] performs identical functionality to the [[A Record]], but maps FQDNs to [[IPv6]] addresses instead. Since IPv6 addresses are 128 bits (written in hexadecimal), the record name reflects the four times larger address space.

**Example**:
```
www.example.com    IN    AAAA    2001:0db8:85a3::8a2e:0370:7334
```

### CNAME Record (Canonical Name)
**Analogy**: A CNAME is like a nickname or alias—the real person has one legal name, but they answer to multiple names.
**Definition**: The [[CNAME Record]] creates an alias pointing to another hostname (the [[Canonical Name]]). Unlike A records, CNAMEs don't directly resolve to IP addresses; instead, they redirect DNS queries to another domain name, which then resolves through its own A record.

**Example**:
```
ftp.example.com    IN    CNAME    www.example.com
www.example.com    IN    A        192.168.1.100
```
*Result: ftp.example.com resolves to 192.168.1.100 indirectly*

### MX Record (Mail Exchange)
**Analogy**: An MX record is like a "forward your mail to this address" note—it tells the email system where to deliver messages for a domain.
**Definition**: The [[MX Record]] specifies which server handles email for a particular domain. It includes a [[Priority Value]] (lower numbers = higher priority) so multiple mail servers can be ranked for [[Mail Routing]].

**Example**:
```
example.com    IN    MX    10    mail1.example.com
example.com    IN    MX    20    mail2.example.com
```

### TXT Record
**Analogy**: A TXT record is like a sticky note attached to a domain—it holds arbitrary text data that other systems can read and use for verification.
**Definition**: The [[TXT Record]] stores text-based information associated with a domain. Common uses include [[SPF]] (Sender Policy Framework), [[DKIM]] (DomainKeys Identified Mail), and [[DMARC]] for email authentication.

**Example**:
```
example.com    IN    TXT    "v=spf1 include:_spf.google.com ~all"
```

### NS Record (Name Server)
**Analogy**: An NS record is like a "contact your lawyer, not me" response—it points queries to the authoritative server responsible for a zone.
**Definition**: The [[NS Record]] delegates authority for a DNS zone to a specific [[Nameserver]]. It tells the DNS hierarchy which server holds the actual [[Zone File]] for a particular domain.

| Record Type | Purpose |
|-------------|---------|
| [[NS]] at zone apex | Delegates zone to primary/secondary servers |
| [[NS]] for subdomain | Creates zone delegation (delegation point) |

### PTR Record (Pointer Record)
**Analogy**: A PTR record is the reverse lookup—instead of "what IP belongs to this name," it asks "what name belongs to this IP?"
**Definition**: The [[PTR Record]] enables [[Reverse DNS Lookup]], mapping an IP address back to a hostname. It's essential for [[Email Authentication]] and [[Server Identification]].

**Example**:
```
100.1.168.192.in-addr.arpa    IN    PTR    www.example.com
```

### SRV Record (Service Record)
**Analogy**: An SRV record is like a business directory—it lists not just a service location, but also the port number and priority.
**Definition**: The [[SRV Record]] identifies the host, port, and priority for specific network services (like [[LDAP]], [[SIP]], or [[Kerberos]]). The format is `_service._protocol.name`.

**Example**:
```
_ldap._tcp.example.com    IN    SRV    10    60    389    ldap.example.com
```

---

## Exam Tips

### Question Type 1: Record Type Identification
- *"An administrator needs email traffic for example.com to reach mail.company.com with a secondary fallback. Which records are needed?"* → [[MX Record]] for mail routing + additional MX for priority ordering
- **Trick**: Confusing MX records with A records—MX points to mail servers, not the final destination

### Question Type 2: Reverse Lookup
- *"A mail server receives a connection from 192.168.1.50. It performs a reverse DNS lookup. Which record type is queried?"* → [[PTR Record]]
- **Trick**: Assuming PTR records automatically exist—they must be manually configured on the reverse zone

### Question Type 3: Service Discovery
- *"A VoIP system needs to automatically locate SIP servers in a domain. Which record provides this?"* → [[SRV Record]]
- **Trick**: Thinking [[DNS A records]] alone can specify port numbers—SRV records are required for service + port discovery

### Question Type 4: Zone Delegation
- *"A parent domain points subzone.example.com to a different nameserver. Which record accomplishes this?"* → [[NS Record]] in the parent zone
- **Trick**: Confusing NS records at the zone apex with NS records for delegation points

---

## Common Mistakes

### Mistake 1: Confusing CNAME with A Records
**Wrong**: "I'll create a CNAME record for a hostname to point directly to an IP address like 192.168.1.100"
**Right**: CNAMEs point to other hostnames, not IP addresses. Create A records for the canonical name, then point CNAMEs to that A record's hostname.
**Impact on Exam**: You'll encounter scenarios requiring proper CNAME+A chaining; answering incorrectly shows fundamental DNS misunderstanding.

### Mistake 2: Assuming All Records Are Automatically Created
**Wrong**: "After deploying a DNS server, all common records (SOA, NS, A, PTR) will be automatically populated"
**Right**: Only the SOA and NS records are created with a new zone. A records require manual creation or [[Dynamic DNS]], and PTR records require separate reverse zone configuration.
**Impact on Exam**: Troubleshooting questions hinge on knowing which records must be manually configured.

### Mistake 3: Mixing Up IPv4 and IPv6 Record Names
**Wrong**: "AAAA records are for IPv6, but they're called AAAA because they come after A records alphabetically"
**Right**: AAAA is named for the IPv6 address size (128 bits = 4× the size of 32-bit IPv4), hence four A's.
**Impact on Exam**: This is a detail question—if asked why AAAA is named that way, the size explanation is correct.

### Mistake 4: Forgetting MX Priority Values
**Wrong**: "Just list all mail servers in MX records; the DNS server will load-balance them equally"
**Right**: MX records include priority numbers; lower values are attempted first. Without proper priority setup, mail routing fails unpredictably.
**Impact on Exam**: You'll see questions about mail server failover—the priority value determines the sequence.

### Mistake 5: Overlooking TXT Record Security Uses
**Wrong**: "TXT records are just for arbitrary comments and metadata"
**Right**: TXT records implement [[SPF]], [[DKIM]], and [[DMARC]]—critical for email authentication and preventing spoofing.
**Impact on Exam**: Email security questions test whether you know TXT records protect against email spoofing.

---

## Related Topics
- [[DNS Query Types (Recursive vs. Iterative)]]
- [[DNS Zone Transfer and AXFR]]
- [[DNSSEC and RRSIG Records]]
- [[Dynamic DNS (DDNS)]]
- [[DNS Caching and TTL]]
- [[DNS Troubleshooting Tools (nslookup, dig, host)]]
- [[Email Authentication (SPF, DKIM, DMARC)]]
- [[Reverse DNS and PTR Records]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*