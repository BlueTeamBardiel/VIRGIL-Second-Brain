---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 056
source: rewritten
---

# IPv6 and SLAAC
**IPv6 devices can automatically configure their own addresses without server intervention through stateless address autoconfiguration.**

---

## Overview
IPv6 modernizes address assignment strategies from IPv4 by offering multiple configuration pathways, including traditional [[DHCPv6]] and automatic self-configuration. For Network+, understanding SLAAC and its mechanisms is critical because it represents a fundamental shift in how modern networks handle device onboarding—reducing infrastructure complexity while maintaining network stability through intelligent conflict detection.

---

## Key Concepts

### Stateless Address Autoconfiguration (SLAAC)
**Analogy**: Imagine a new student arriving at school and creating their own ID number by combining the school's building code with a unique personal identifier, then broadcasting to confirm nobody else has that exact number—no principal's office required.

**Definition**: [[SLAAC]] is a mechanism allowing [[IPv6]] devices to independently generate valid network addresses by combining [[network prefix]] information with locally-generated unique identifiers, eliminating the dependency on centralized [[DHCPv6]] infrastructure.

**Key Characteristics**:
- No server involvement needed
- No lease management or expiration
- No tracking of device pools
- Automatic network participation

---

### DHCPv6 (IPv6 DHCP)
**Analogy**: Traditional server-based approach—like a front desk receptionist assigning hotel rooms from a ledger rather than guests choosing their own room numbers.

**Definition**: [[DHCPv6]] adapts IPv4's [[DHCP]] philosophy to IPv6 environments, maintaining a centralized server that distributes addresses, while supporting [[redundancy]] for enterprise deployment and administrative control.

| Feature | SLAAC | DHCPv6 |
|---------|-------|--------|
| Server Required | No | Yes |
| Lease Time | N/A | Yes, managed |
| Configuration Scope | Address only | Address + options |
| Administrative Control | Limited | Full |
| Deployment Complexity | Simpler | More complex |

---

### Neighbor Discovery Protocol (NDP)
**Analogy**: Instead of shouting loudly ("Who has this IP?"), devices politely ask specific neighbors they know exist ("Do you have this IP?").

**Definition**: [[NDP]] replaces [[IPv4]]'s [[ARP]] (Address Resolution Protocol) by using [[multicast]] instead of [[broadcast]], enabling more efficient device communication and address conflict detection in IPv6 networks.

**Key Advantages Over ARP**:
- Uses [[multicast]] instead of [[broadcast]] (more efficient)
- Reduces network noise
- Faster convergence
- Built-in security options

---

### Duplicate Address Detection (DAD)
**Analogy**: Before moving into a house, you confirm the address isn't already claimed by someone else living there.

**Definition**: [[DAD]] is a prerequisite validation process where IPv6 devices query the network segment before finalizing a self-assigned address, ensuring no collision exists with existing hosts.

**DAD Process**:
```
Device generates candidate address
    ↓
Sends NDP Neighbor Solicitation (multicast)
    ↓
Waits for Neighbor Advertisement response
    ↓
No response = Address is safe to use
    ↓
Response received = Address conflict exists, try new address
```

---

### Link-Local Addresses
**Analogy**: Like a temporary phone number you can use immediately to call neighbors on your street, without waiting for the phone company to assign a permanent number.

**Definition**: [[Link-local addresses]] are automatically generated IPv6 addresses (starting with fe80::/10) that enable communication on the local segment before SLAAC or DHCPv6 assigns global addresses.

**Characteristics**:
- Always present on every IPv6 interface
- Non-routable beyond local segment
- Starts with fe80::/10 prefix
- Used for NDP and local communication

---

### Network Prefix Information
**Analogy**: The prefix is like your neighborhood's zip code—everyone on your block uses it, and you combine it with your house number to create your full address.

**Definition**: The [[network prefix]] (typically /64 in IPv6) is broadcast via [[Router Advertisement]] messages and combined with locally-generated interface identifiers to create the complete unicast address during SLAAC.

---

## Exam Tips

### Question Type 1: SLAAC vs. DHCPv6 Identification
- *"A network administrator wants to deploy IPv6 without managing server infrastructure. Which technology enables this?"* → SLAAC (Stateless Address Autoconfiguration)
- **Trick**: Confusing "stateless" with "no addresses"—stateless means no server state management, not missing addresses.

### Question Type 2: Protocol Functions
- *"Which IPv6 protocol performs address conflict detection?"* → DAD (Duplicate Address Detection) via NDP
- **Trick**: Remember ARP is IPv4; NDP is IPv6 (not just address resolution, but router discovery and prefix handling too).

### Question Type 3: Address Generation
- *"An IPv6 device generates fe80::1 automatically. What mechanism enabled this?"* → Link-local address generation (automatic, no configuration needed)
- **Trick**: Link-local is NOT the same as globally unique unicast—it's limited to the segment.

### Question Type 4: Efficiency Comparisons
- *"Why is NDP more efficient than ARP?"* → NDP uses multicast instead of broadcast, reducing unnecessary traffic on the network
- **Trick**: Don't say "faster"—say "more efficient" or "less network burden."

---

## Common Mistakes

### Mistake 1: Confusing SLAAC with Complete Statelessness
**Wrong**: "SLAAC means the device has no addressing configuration at all."
**Right**: "SLAAC means the device auto-generates its address without a DHCP server managing state, but still requires router advertisements for prefix information."
**Impact on Exam**: You'll misidentify when SLAAC can operate (needs [[Router Advertisement]] messages) vs. when it fails (no routers present).

---

### Mistake 2: Thinking DAD Prevents All Address Conflicts
**Wrong**: "DAD guarantees the address will never conflict."
**Right**: "DAD checks for conflicts at assignment time; it prevents initial collisions but doesn't monitor ongoing conflicts."
**Impact on Exam**: Questions about post-configuration address conflicts require different answers than DAD scope.

---

### Mistake 3: Treating NDP Identically to ARP
**Wrong**: "NDP is just IPv6's ARP with a different name."
**Right**: "NDP is broader—it handles neighbor discovery, router discovery, address autoconfiguration, and prefix advertisement, not just MAC-to-IP resolution."
**Impact on Exam**: NDP questions often test additional capabilities beyond simple address resolution.

---

### Mistake 4: Misidentifying SLAAC's Infrastructure Requirements
**Wrong**: "SLAAC requires no network infrastructure."
**Right**: "SLAAC requires [[IPv6 routers]] sending Router Advertisement messages; the 'stateless' part refers to no DHCP server tracking, not absolute independence."
**Impact on Exam**: You'll incorrectly answer scenarios where routers are absent or advertising is disabled.

---

### Mistake 5: Confusing Link-Local with Unicast Addresses
**Wrong**: "Link-local addresses are the primary addresses devices use."
**Right**: "Link-local addresses (fe80::/10) enable immediate local communication; globally unique unicast addresses (2000::/3) are assigned separately via SLAAC or DHCPv6."
**Impact on Exam**: Questions about routing and internet communication require understanding that link-local cannot be routed.

---

## Related Topics
- [[IPv6 Addressing]]
- [[DHCPv6]]
- [[Router Advertisement]]
- [[Network Prefix]]
- [[Multicast vs. Broadcast]]
- [[Link-Local Addresses]]
- [[IPv6 Global Unicast Address]]
- [[ARP]] (IPv4 comparison)

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*