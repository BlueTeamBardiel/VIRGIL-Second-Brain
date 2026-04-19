# Standard Access Control Lists
**Tagline:** ACLs are the firewall rules of networking—they filter traffic based on source/destination IP addresses, allowing you to control which packets enter or leave your network.

---

## What Are Standard ACLs? (Simple Explanation First)

Imagine your router is a bouncer at a club. A **Standard ACL** is like a list that says "people from this neighborhood can come in, people from that neighborhood cannot." The bouncer (router) checks *only where people are from* (source IP address) before deciding whether to let them through.

**Why this matters:** Standard ACLs are the simplest traffic filtering mechanism in Cisco IOS. They're fast, lightweight, and perfect for basic permit/deny decisions based on source IP alone. However, their simplicity is also their limitation—they can't inspect destination addresses or ports.

---

## Core Concepts

### How Standard ACLs Work

A Standard ACL is a sequential list of rules applied to traffic. Each rule has:
- **Action**: `permit` or `deny`
- **Source IP address**: The only criterion examined
- **Wildcard mask**: Specifies which bits of the IP to match
- **Implicit deny**: Any traffic not explicitly permitted is denied (this is critical)

The router processes rules **top-to-bottom** and stops at the first match. Unmatched traffic hits the implicit deny at the end.

### Where Standard ACLs Are Applied

Standard ACLs are applied to router interfaces using the `ip access-group` command:
- **Inbound**: Filters traffic *entering* the interface before routing decisions
- **Outbound**: Filters traffic *leaving* the interface after routing decisions

⚠️ **Critical concept:** Apply Standard ACLs as close to the *destination* as possible. Since they can't filter by destination address, applying them near the source wastes bandwidth on denied traffic crossing the network.

### Wildcard Masks (Not Subnet Masks!)

This is where students stumble. A wildcard mask is the **inverse** of a subnet mask:
- Subnet mask `/24` (255.255.255.0) → Wildcard `0.0.0.255`
- Subnet mask `/16` (255.255.0.0) → Wildcard `0.0.255.255`
- **0 bit** = must match exactly
- **1 bit** = don't care (match any value)

| Wildcard Mask | Meaning |
|---|---|
| `0.0.0.0` | Match this exact IP only |
| `0.0.0.255` | Match any host in this /24 subnet |
| `255.255.255.255` | Match any IP (any keyword) |

---

## Numbered vs. Named Standard ACLs

### Numbered Standard ACLs (1–99, 1300–1399)

Numbers 1–99 and 1300–1399 are reserved for Standard ACLs in Cisco IOS.

**Syntax:**
```
access-list <number> {permit|deny} <source-ip> <wildcard-mask>
```

**Weakness:** You cannot delete individual rules—you must delete the entire ACL and recreate it.

**Example:**
```
access-list 10 permit 192.168.1.0 0.0.0.255
access-list 10 deny 192.168.1.5 0.0.0.0
access-list 10 permit any
```

### Named Standard ACLs (Modern Approach)

Named ACLs allow editing individual rules and are more readable.

**Syntax:**
```
ip access-list standard <name>
 [<sequence-number>] {permit|deny} <source-ip> <wildcard-mask>
```

**Example:**
```
ip access-list standard ALLOW_MARKETING
 10 permit 192.168.10.0 0.0.0.255
 20 permit 192.168.11.0 0.0.0.255
 30 deny any
```

**Advantage:** Edit rules by sequence number without deleting the entire list.

---

## The Implicit Deny and Explicit Permit

Every ACL ends with an **implicit deny any**. If traffic doesn't match any permit statement, it's dropped.

This means you *must* include at least one permit statement, or your ACL will block everything:

```
access-list 10 permit any     ← Without this, nothing passes
```

**Best practice:** Always end with an explicit `permit any` or `deny any` so your intent is clear in `show` outputs.

---

## Applying ACLs to Interfaces

Once created, apply the ACL using:

```
interface <interface-id>
 ip access-group <acl-number|acl-name> {in|out}
```

**Direction keywords:**
- `in` = Inbound (before routing decision)
- `out` = Outbound (after routing decision)

---

## Practical Scenarios

### Scenario 1: Block a Specific Host
```
access-list 5 deny 192.168.1.100 0.0.0.0
access-list 5 permit any
!
interface Gi0/1
 ip access-group 5 in
```

### Scenario 2: Permit Only a Subnet
```
ip access-list standard ENGINEERING
 10 permit 10.0.1.0 0.0.0.255
 20 deny any
!
interface Gi0/2
 ip access-group ENGINEERING out
```

### Scenario 3: Multiple Subnets (Careful with Wildcard Masks!)
```
ip access-list standard MULTIPLE_SITES
 10 permit 192.168.0.0 0.0.3.255      ← Covers 192.168.0–3.0/24
 20 permit 10.0.0.0 0.0.0.255
 30 deny any
```

---

## Lab Relevance

### Essential Cisco IOS Commands

| Command | Purpose | Syntax |
|---|---|---|
| Create numbered ACL | Define permit/deny rules | `access-list 1-99 {permit\|deny} <ip> <wildcard>` |
| Create named ACL | Modern approach with editing | `ip access-list standard <name>` → `permit/deny` |
| Apply to interface | Activate ACL on interface | `ip access-group <acl> {in\|out}` |
| View ACL | Display rules | `show access-lists` or `show access-list <number>` |
| View interface assignment | See which ACLs are applied | `show ip interface <interface>` |
| Remove ACL | Delete entire list | `no access-list <number>` |
| Edit named ACL | Delete specific rule | `no <sequence-number>` (in ACL config mode) |

### Lab Exercise: Basic ACL Configuration

```
! Create ACL 10 that permits only 192.168.1.0/24
access-list 10 permit 192.168.1.0 0.0.0.255
access-list 10 deny any

! Apply to Gi0/1 inbound
interface Gi0/1
 ip access-group 10 in

! Verify
show access-lists 10
show ip interface Gi0/1
```

### Lab Exercise: Named ACL with Multiple Subnets

```
ip access-list standard LAB_ACL
 10 permit 10.1.0.0 0.0.0.255
 20 permit 10.2.0.0 0.0.0.255
 30 deny 10.3.0.0 0.0.0.255
 40 permit any
!
interface Gi0/0
 ip access-group LAB_ACL out
```

---

## Exam Tips

### What CCNA Exams Test on Standard ACLs

1. **Wildcard Mask Calculation** (Very Common)
   - You'll get a subnet and must write the wildcard mask
   - Inverse of subnet mask: 255.255.255.0 → 0.0.0.255
   - Trick: Subtract subnet from 255.255.255.255

2. **ACL Direction and Placement** (Tricky)
   - Question: "You want to block traffic from 10.0.0.0/24 exiting your network. Which interface and direction?"
   - Answer: Apply on outbound interface (out) closest to the destination
   - Students often choose `in` when `out` is more efficient

3. **Implicit Deny** (Trap Answer)
   - Scenario: "An ACL with only `deny 192.168.1.0 0.0.0.255` is applied inbound. What happens to other traffic?"
   - Trap: "It's permitted by default"
   - Correct: "It hits the implicit deny and is dropped"

4. **Numbered vs. Named ACL Editing** (New in CCNA)
   - Question: "You need to add a rule to line 15 of your ACL without deleting it. Which type?"
   - Answer: Named ACL (numbered requires full deletion/recreation)

5. **ACL Number Ranges**
   - Standard ACLs: 1–99 and 1300–1399
   - Students confuse this with Extended ACL ranges (100–199, 2000–2699)

### Sample Exam Questions

**Q1:** Configure an ACL allowing only 172.16.5.0/24 to pass. What wildcard mask do you use?
- A) 255.255.255.0
- B) 0.0.0.255 ← **Correct**
- C) 0.0.255.255
- D) 255.255.255.255

**Q2:** Your ACL is applied `inbound` on Gi0/0. When is it processed?
- A) Before the routing table lookup ← **Correct**
- B) After the routing table lookup
- C) During ARP resolution
- D) During encapsulation

**Q3:** This ACL is on interface Gi0/1:
```
access-list 20 deny 10.0.1.0 0.0.0.255
interface Gi0/1
 ip access-group 20 in
```
What happens to traffic from 10.0.1.50?
- A) It's permitted
- B) It's denied ← **Correct** (matches deny, stops processing)
- C) It's queued for review
- D) It hits the explicit permit any

**Q4:** You need to edit an existing numbered ACL by removing line 15. What's the fastest way?
- A) Delete the entire ACL and recreate it
- B) Use named ACL and `no 15` ← **Correct**
- C) Use `remove access-list 1 line 15`
- D) Cannot be done without deleting

---

## Common Mistakes

### ❌ Mistake 1: Confusing Subnet Mask and Wildcard Mask

**Wrong:**
```
access-list 10 permit 192.168.1.0 255.255.255.0    ← This is a subnet mask!
```

**Correct:**
```
access-list 10 permit 192.168.1.0 0.0.0.255        ← This is the wildcard
```

**How to remember:** Wildcard is what you *don't* care about. 1 bit = wildcard (don't match), 0 bit = must match.

---

### ❌ Mistake 2: Applying Standard ACL on the Wrong Interface

**Scenario:** "Block traffic from 10.0.0.0/8 coming from Router A to Router B"

**Wrong:**
```
! Applied on Router A's outbound interface (A → B direction)
interface Gi0/0
 ip access-group 5 out    ← Wrong! Traffic already traveled
```

**Correct:**
```
! Applied on Router B's inbound interface (traffic entering B)
interface Gi0/0
 ip access-group 5 in     ← Correct! Filter at destination
```

**Why:** Standard ACLs can only see source IP. Apply them close to the destination to prevent wasting WAN bandwidth on denied traffic.

---

### ❌ Mistake 3: Forgetting the Implicit Deny

**Wrong:**
```
access-list 15 permit 192.168.1.0

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 23 | [[CCNA]]*
