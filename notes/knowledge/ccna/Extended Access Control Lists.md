# Extended Access Control Lists
**Tagline:** Master granular packet filtering beyond source IP—control traffic by protocol, port, and destination to implement precise security policies.

---

## Overview: Why Extended ACLs Matter

[[Standard Access Control Lists|Standard ACLs]] are a blunt instrument—they filter only on source IP address. **Extended ACLs** are a precision tool: they examine multiple packet parameters simultaneously, enabling you to enforce policies like "block TCP port 23 from subnet A to subnet B" or "permit only ICMP from host X to host Y."

### The Simple Explanation
Think of standard ACLs as a bouncer checking only "which door you're from." Extended ACLs are that bouncer now also checking "what you're carrying, where you're going, and what type of activity you want to do."

### The Technical Detail
Extended ACLs match packets based on:
- **Protocol** ([[TCP]], [[UDP]], [[ICMP]], OSPF, IP)
- **Source IP address** (any, host, or CIDR range)
- **Destination IP address** (any, host, or CIDR range)
- **Source/destination ports** (for TCP/UDP—covered later)

Like standard ACLs, extended ACLs process [[Access Control Entries|ACEs]] **top-to-bottom**, include an **implicit deny** at the end, and must be applied to an interface (inbound or outbound) to take effect.

---

## Key Concepts

### ACE Processing Order
Every packet is evaluated against each ACE sequentially. The first matching ACE determines the action (permit/deny). No subsequent ACEs are evaluated. This makes **ACE order critical**—place specific rules before general ones.

### The Implicit Deny
All extended ACLs end with an invisible `deny ip any any`. If a packet doesn't match any explicit ACE, it's dropped. This is why you must explicitly permit traffic you want to allow.

### Application Direction Matters
- **Inbound** (`ip access-group ACL in`): Filters packets arriving on the interface
- **Outbound** (`ip access-group ACL out`): Filters packets leaving the interface

**Placement strategy**: Apply extended ACLs **close to the source** (opposite of standard ACLs). Since extended ACLs are specific about which traffic to block, placing them near the source prevents unnecessary traffic from traversing the network.

---

## Extended ACL Configuration

### Numbered vs. Named ACLs

| Aspect | Numbered | Named |
|--------|----------|-------|
| **Number Range** | 100–199 or 2000–2699 | User-defined text name |
| **Config Mode** | Global config | Named ACL config (`ip access-list extended`) |
| **Editing** | Delete and reconfigure | Edit individual ACEs or delete/resequence |
| **Readability** | Lower (numbers only) | Higher (descriptive names) |
| **Best Practice** | Legacy; still supported | Preferred for modern deployments |

### Numbered Extended ACL Syntax

```
R1(config)# access-list <number> {permit | deny} <protocol> <source> <destination>
```

**Example:**
```
R1(config)# access-list 110 permit tcp host 192.168.1.1 host 8.8.8.8 eq 53
R1(config)# access-list 110 deny ip any any
```

### Named Extended ACL Syntax

```
R1(config)# ip access-list extended <name-or-number>
R1(config-ext-nacl)# [seq-num] {permit | deny} <protocol> <source> <destination>
```

**Example:**
```
R1(config)# ip access-list extended BLOCK_TELNET
R1(config-ext-nacl)# 10 deny tcp any any eq 23
R1(config-ext-nacl)# 20 permit ip any any
```

---

## Matching Parameters Deep Dive

### Protocol Argument

| Protocol Keyword | Meaning | Example Use |
|------------------|---------|-------------|
| `ip` | All IPv4 packets | Match all traffic regardless of L4 protocol |
| `tcp` | TCP payload | Filter specific TCP services (HTTP, Telnet, SSH) |
| `udp` | UDP payload | Filter DNS, DHCP, NTP |
| `icmp` | ICMP (ping, traceroute) | Allow/deny diagnostic traffic |
| `ospf` | OSPF routing protocol | Block/allow routing updates |

### Source and Destination Arguments

| Format | Meaning | Equivalent To | Use Case |
|--------|---------|---------------|----------|
| `any` | All IP addresses | 0.0.0.0 255.255.255.255 | Any source or destination |
| `host <IP>` | Single IP address | `<IP> 0.0.0.0` | Specific host |
| `<IP> <wildcard>` | Range of IPs | CIDR notation | Subnet or range |

**Critical Note:** In extended ACLs, you **must** use `host` keyword or wildcard mask to match a single IP. Bare IP addresses are invalid.

**Examples:**
- `host 10.1.1.5` → matches only 10.1.1.5
- `10.1.1.0 0.0.0.255` → matches 10.1.1.0/24 (256 addresses)
- `any` → matches all addresses

### Wildcard Mask Refresher

Wildcard masks are inverted netmasks:
- `0` = must match this bit
- `1` = don't care about this bit

| Wildcard Mask | Equivalent CIDR | Addresses Covered |
|---|---|---|
| 0.0.0.0 | /32 | 1 (single host) |
| 0.0.0.255 | /24 | 256 (/24 subnet) |
| 0.0.255.255 | /16 | 65,536 (/16 subnet) |
| 255.255.255.255 | /0 | All addresses |

---

## Common ACE Examples

| ACE | Effect |
|-----|--------|
| `permit ip any any` | Allow all IPv4 packets (typically last line) |
| `deny tcp any any eq 23` | Block Telnet (port 23) from anywhere to anywhere |
| `permit tcp host 10.1.1.5 host 8.8.8.8 eq 443` | Allow HTTPS from 10.1.1.5 to 8.8.8.8 |
| `deny icmp 192.168.1.0 0.0.0.255 any` | Block ping from 192.168.1.0/24 to all destinations |
| `permit udp any host 8.8.8.8 eq 53` | Allow DNS queries to 8.8.8.8 |
| `deny ip 10.0.0.0 0.255.255.255 172.16.0.0 0.15.255.255` | Block Class A 10.x from reaching Class B 172.16–172.31.x |

---

## Real-World Scenario: TEST1 ACL

Given this network:
- **R1 G0/0**: Connected to Engineering LAN (192.168.1.0/24)
- **R1 G0/1**: Connected to Accounting LAN (192.168.2.0/24)
- **R1 G0/2**: Connected to R2; R2 connects Server LANs A (192.168.3.0/24) and B (192.168.4.0/24)

**Requirements:**
1. Allow PC1 (192.168.1.11) to ping Server LAN A
2. Block all other ICMP from Engineering and Accounting
3. Block all UDP
4. Allow all other traffic

**Configuration:**
```
R1(config)# ip access-list extended TEST1
R1(config-ext-nacl)# 10 permit icmp host 192.168.1.11 192.168.3.0 0.0.0.255
R1(config-ext-nacl)# 20 deny icmp 192.168.1.0 0.0.0.255 any
R1(config-ext-nacl)# 30 deny icmp 192.168.2.0 0.0.0.255 any
R1(config-ext-nacl)# 40 deny udp any any
R1(config-ext-nacl)# 50 permit ip any any
R1(config-ext-nacl)# exit
R1(config)# interface g0/2
R1(config-if)# ip access-group TEST1 out
```

**Traffic Analysis:**
- PC1 ping to SRV1 (192.168.3.x): Matches line 10 → **Permitted**
- PC2 (192.168.1.17) ping to SRV1: Matches line 20 → **Denied**
- Any UDP (DNS, DHCP): Matches line 40 → **Denied**
- TCP HTTP from Engineering to Server LAN B: Reaches line 50 → **Permitted**

---

## Editing Extended ACLs

### Deleting Entire ACL
```
R1(config)# no access-list 110
```
or
```
R1(config)# no ip access-list extended MY_ACL
```

### Deleting Specific ACEs (Named ACLs Only)
```
R1(config)# ip access-list extended MY_ACL
R1(config-ext-nacl)# no 20
```
Removes sequence number 20. Remaining ACEs renumber automatically.

### Resequencing ACEs
```
R1(config)# ip access-list extended MY_ACL
R1(config-ext-nacl)# seq 15 permit tcp any any eq 80
```
Inserts new ACE at sequence 15; existing 15+ shift up.

### View ACL Details
```
R1# show access-lists 110
R1# show access-lists MY_ACL
R1# show ip access-lists extended
```

---

## Lab Relevance

### Essential IOS Commands for This Chapter

| Command | Mode | Purpose | Example |
|---------|------|---------|---------|
| `access-list <num> {permit\|deny} <proto> <src> <dst>` | Global config | Create numbered extended ACE | `access-list 110 permit tcp 10.0.0.0 0.0.0.255 any eq 80` |
| `ip access-list extended <name\|num>` | Global config | Enter named ACL config mode | `ip access-list extended BLOCK_SSH` |
| `[seq-num] {permit\|deny} <proto> <src> <dst>` | Named ACL config | Add/edit ACE in named ACL | `10 deny tcp any any eq 22` |
| `no <seq-num>` | Named ACL config | Delete specific ACE by sequence | `no 15` |
| `ip access-group <ACL> {in\|out}` | Interface config | Apply ACL to interface | `ip access-group 110 in` |
| `show access-lists [num\|name]` | Privilege exec | Display ACL contents and hit counts | `show access-lists 110` |
| `show ip access-lists` | Privilege exec | List all extended ACLs | — |
| `show running-config interface <int>` | Privilege exec | Verify ACL applied to interface | `show running-config interface g0/0` |

### Hands-On Lab Tasks
1. **Create a numbered extended ACL (100–199 range) that:**
   - Denies Telnet (TCP port 23) from 192.168.1.0/24 to any destination
   - Permits HTTP (TCP port 80) from any source to 172.16.0.0/16
   - Denies all ICMP
   - Permits all other IP traffic

2. **Create a named extended ACL called DMZFILTER that:**
   - Permits only DNS (UDP 53), HTTP (TCP 80), and HTTPS (TCP 443) into DMZ (10.0.0.0/24)
   -

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 24 | [[CCNA]]*