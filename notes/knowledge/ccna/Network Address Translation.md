# Network Address Translation
**Tagline:** NAT allows private networks to communicate with public internet using a single public IP—essential for every organization and tested heavily on CCNA.

---

## Quick Analogy: Why NAT Matters

Imagine your office building (private network) has 100 employees but only 1 mailbox on the street (public IP). NAT is the mail clerk who writes the building's address on outgoing mail and remembers which employee should receive each reply. Without NAT, your organization would need 100 public IP addresses—expensive and wasteful. NAT solves this by translating private addresses to public ones on-the-fly.

---

## 9.1 Private IPv4 Addresses

### The Three Private Address Ranges

[[RFC 1918]] defines private address space that cannot be routed on the public internet. These ranges are "invisible" to ISPs and the wider internet:

| Class | Range | CIDR | Use Case |
|-------|-------|------|----------|
| A | 10.0.0.0 – 10.255.255.255 | 10.0.0.0/8 | Large organizations, data centers |
| B | 172.16.0.0 – 172.31.255.255 | 172.16.0.0/12 | Medium organizations, VPCs |
| C | 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 | Small offices, home networks |

**Key principle:** Private addresses are internally routable but globally non-routable. A packet with source 10.0.0.1 will be dropped at any ISP router because it violates routing rules.

### Why This Matters for NAT

Only devices using private addresses need NAT. Public addresses (registered with IANA) can communicate directly without translation. The CCNA exam tests whether you identify when NAT is *required* vs. optional.

---

## 9.2 NAT Concepts

### The NAT Process: Step-by-Step

When a private host (192.168.1.5) sends traffic destined for a public server (8.8.8.8):

1. **Inside Local → Inside Global (Outbound)**
   - Router intercepts packet with source IP 192.168.1.5 (inside local)
   - Replaces it with 203.0.113.1 (inside global/public IP)
   - Creates an entry in the NAT translation table
   - Public server receives packet appearing to originate from 203.0.113.1

2. **Inside Global → Inside Local (Inbound)**
   - Public server responds to 203.0.113.1
   - NAT device looks up translation table entry
   - Replaces destination 203.0.113.1 back to 192.168.1.5
   - Private host receives response transparently

**Critical understanding:** The translation is *bidirectional and stateful*. Without matching inbound traffic, the translation entry expires.

### Cisco NAT Terminology (Official)

| Term | Definition | Example |
|------|-----------|---------|
| **Inside Local** | Private IP address of the internal host | 192.168.1.5 |
| **Inside Global** | Public IP address assigned to the internal host (post-translation) | 203.0.113.1 |
| **Outside Local** | IP address of external host *as seen from inside network* | 8.8.8.8 (unchanged in most setups) |
| **Outside Global** | Real public IP address of external host | 8.8.8.8 (actual address on internet) |

**Exam trap:** Students confuse "inside" vs. "outside" with "private" vs. "public." Remember: **Inside = your network (internal), Outside = their network (external).** "Local" and "Global" refer to how that address is *perceived* from the perspective defined.

---

## 9.3 Types of NAT

### Static NAT (One-to-One Mapping)

**Use case:** Exposing internal servers to the internet (web servers, mail servers).

**How it works:**
- One private IP statically maps to one public IP
- Binding is permanent and configured manually
- Bi-directional: both inbound and outbound traffic translated
- No address exhaustion savings—defeats the purpose of NAT for conservation

**Configuration principle:**
```
ip nat inside source static 192.168.1.10 203.0.113.10
```

**Exam focus:** Understand that static NAT creates a 1:1 relationship. If you have 50 internal servers needing public access, you burn 50 public IPs—not scalable.

---

### Dynamic NAT (One-to-One Pool)

**Use case:** Temporary translation from a pool of public IPs; used when you have more private addresses than public, but don't need all hosts online simultaneously.

**How it works:**
1. Administrator defines pool of public IPs (e.g., 203.0.113.0/29 = 6 usable)
2. When inside host initiates outbound connection, router assigns next available public IP from pool
3. Binding is *temporary*—expires when session ends or timeout reached
4. Once public IP is exhausted, new connections are blocked

**Example scenario:**
- Office with 100 private hosts, only 5 public IPs in pool
- 5 hosts can be simultaneously active; 6th gets denied

**Key limitation:** PAT (below) solves this by allowing multiple hosts per public IP.

---

### Dynamic PAT (Port Address Translation)

**Use case:** Standard modern NAT. Multiple private addresses map to a single public IP by translating port numbers. This is what most organizations actually deploy.

**How it works:**
- All internal hosts share one (or few) public IP address
- Router translates both IP *and* port numbers
- Allows thousands of simultaneous connections on a single public IP
- Binding expires via timeout (typically 24 hours for TCP, shorter for UDP)

**Example:**
- Internal host A (192.168.1.5:54321) → Public 203.0.113.1:1000
- Internal host B (192.168.1.6:54322) → Public 203.0.113.1:1001
- External server sees TWO different "sources" (same IP, different ports)

**Translation table entry:**
```
Inside Local (Protocol, Address, Port) → Inside Global (Protocol, Address, Port)
TCP 192.168.1.5:54321 → 203.0.113.1:1000
TCP 192.168.1.6:54322 → 203.0.113.1:1001
```

**Why this matters:** Port exhaustion becomes theoretical concern only. Single public IP can handle ~65,535 simultaneous translations. In practice, you'll never hit this limit.

---

## Comparison Table: NAT Types

| Feature | Static | Dynamic | Dynamic PAT |
|---------|--------|---------|-------------|
| Private:Public ratio | 1:1 | 1:1 | Many:1 |
| IP conservation | ❌ No | ❌ No | ✅ Yes |
| Inbound initiation | ✅ Yes | ❌ No | ❌ No |
| Simultaneous connections | Unlimited | Limited by pool | ~65K per IP |
| Configuration complexity | Simple | Moderate | Moderate |
| Typical use | Web servers | Medium branch | Internet edge |

---

## Lab Relevance: Essential IOS Commands

### 1. Define Inside and Outside Interfaces

```
interface GigabitEthernet0/0
 ip nat inside

interface GigabitEthernet0/1
 ip nat outside
```

**Why this matters:** NAT only operates on interfaces marked as inside/outside. Default: no NAT processing.

### 2. Static NAT Configuration

```
ip nat inside source static 192.168.1.10 203.0.113.10
```

Creates permanent mapping. Applies immediately; no pool definition needed.

### 3. Dynamic NAT: Define Pool and ACL

```
! Step 1: Define which private addresses can use NAT
access-list 1 permit 192.168.1.0 0.0.0.255

! Step 2: Define pool of public IPs
ip nat pool POOL203 203.0.113.1 203.0.113.6 netmask 255.255.255.248

! Step 3: Bind ACL to pool
ip nat inside source list 1 pool POOL203
```

**Verification:**
```
show ip nat translations
show ip nat statistics
```

### 4. Dynamic PAT (Most Common)

```
! Define inside-local addresses allowed for PAT
access-list 1 permit 192.168.1.0 0.0.0.255

! Option A: PAT to single interface (router's outside IP)
ip nat inside source list 1 interface GigabitEthernet0/1 overload

! Option B: PAT to pool (even if pool has 1 IP)
ip nat pool PAT_POOL 203.0.113.1 203.0.113.1 netmask 255.255.255.0
ip nat inside source list 1 pool PAT_POOL overload
```

**Critical keyword:** `overload` enables PAT (port translation). Without it, dynamic NAT drops connections when pool exhausted.

### 5. Verify NAT Operations

```
! Show all active translations (translation table)
show ip nat translations

! Show detailed translation stats
show ip nat statistics

! Clear translations (useful for testing)
clear ip nat translation *

! Debug NAT processing (verbose, CPU-intensive)
debug ip nat
```

**Example output interpretation:**
```
Pro Inside global      Inside local       Outside local      Outside global
tcp 203.0.113.1:1000   192.168.1.5:54321  8.8.8.8:443       8.8.8.8:443
```

### 6. Configure NAT Timeouts (Advanced)

```
! TCP translation timeout (default 86400 seconds = 24 hours)
ip nat translation tcp-timeout 3600

! UDP translation timeout (default 300 seconds = 5 minutes)
ip nat translation udp-timeout 300

! Override timeouts for specific protocols
ip nat translation max-entries 2048
```

---

## Exam Tips: What CCNA Actually Tests

### Concept-Level Questions

1. **"A company has 50 internal servers that must accept inbound connections from the internet. Which NAT type should they implement?"**
   - **Answer:** Static NAT. Only static creates permanent, bi-directional mappings allowing external initiation.
   - **Trap:** Students choose dynamic NAT (doesn't support inbound initiation).

2. **"Which private address range is largest and used for enterprise networks?"**
   - **Answer:** 10.0.0.0/8 (16 million addresses). Class B and C are smaller.

3. **"What does the 'overload' keyword do in NAT configuration?"**
   - **Answer:** Enables PAT by allowing multiple inside-local addresses to map to the same inside-global address via port translation.
   - **Trap:** Students think it means "configure backup routes" or "load balancing."

### Configuration Scenario Questions

4. **Lab task: Configure NAT so internal network 192.168.1.0/24 can reach the internet via public IP 203.0.113.1**
   - Must define:
     - Inside interface: `ip nat inside`
     - Outside interface: `ip nat outside`
     - ACL permitting 192.168.1.0/24
     - `ip nat inside source list [ACL] interface [outside-interface] overload`
   - **Common mistake:** Forgetting to mark interfaces, forgetting overload keyword, using wrong ACL logic.

5. **Troubleshooting: "Clients can't reach external servers. NAT is configured but translations aren't occurring. What's the problem?"**
   - **Likely causes tested:**
     - Inside/outside interfaces not marked
     - ACL denying traffic that should be translated
     - Wrong direction on access-list (must permit source of inside-local traffic)
     - Dynamic NAT pool exhausted (show ip nat statistics)

### "Which statement is true?"

6. **Static NAT vs. Dynamic NAT:**
   - ✅ Static requires manual configuration; Dynamic uses pools
   - ✅ Static supports inbound initiation; Dynamic does not
   - ✅ Dynamic PA

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 9 | [[CCNA]]*