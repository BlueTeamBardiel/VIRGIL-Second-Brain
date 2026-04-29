# IPv6 Addressing
**Tagline:** IPv6 solves IPv4's address exhaustion crisis by providing 2^128 addresses instead of 2^32—essential for modern network engineering.

---

## Why IPv6 Matters

[[IPv4]] addresses are depleted. The [[Internet Assigned Numbers Authority|IANA]] officially declared exhaustion across all five [[Regional Internet Registries|RIRs]] (ARIN in 2015, RIPE NCC in 2019, LACNIC in 2020). IPv6's 128-bit address space (340 undecillion addresses) guarantees sufficient addressing for the foreseeable future. While IPv4 remains dominant (~55% of traffic), IPv6adoption is accelerating—Google reports ~45% of users access its services over IPv6, up from 1% a decade ago.

---

## The Address Space Crisis

### IPv4 Exhaustion (Simple Explanation)
Think of IPv4 addresses like phone numbers. When the system was designed in 1981, nobody expected billions of devices. The 32-bit limit creates only 4.3 billion addresses—insufficient for ~8 billion people plus IoT devices, servers, and redundant systems.

### The Numbers
- **IPv4:** 2^32 = 4,294,967,296 addresses
- **IPv6:** 2^128 = 340,282,366,920,938,463,463,374,607,431,768,211,456 addresses
- **Scale:** IPv6 has ~340 trillion times more addresses than grains of sand on Earth

### Why Four Times Larger Means Exponentially More Addresses
Each additional bit *doubles* the address space (not adds to it):
- 32-bit → 64-bit = 2^32 times more addresses
- 64-bit → 96-bit = 2^32 times more again
- 96-bit → 128-bit = 2^32 times more again

Total effect: Each of four 32-bit increments quadruples the space cumulatively.

### Depletion Timeline
[[ARIN]] (Americas): Exhausted 2015  
[[RIPE NCC]] (Europe/Asia): Exhausted 2019  
[[LACNIC]] (Latin America/Caribbean): Exhausted 2020  
[[APNIC]] (Asia-Pacific): Exhausted 2011  
[[AFRINIC]] (Africa): Exhausted 2020

Temporary extensions via IPv4 recycling and [[NAT]] (Network Address Translation) delay the problem but don't solve it.

---

## Hexadecimal Foundation

### Why Hexadecimal for IPv6?
IPv4 uses 32 bits displayed as four 8-bit decimal octets (e.g., `192.168.1.1`). IPv6's 128 bits would be unwieldy in decimal. Hexadecimal compresses this: one hex digit = 4 bits, so 128 bits = 32 hex digits—still compact but human-manageable.

### Conversion Fundamentals

**Key Insight:** 1 hexadecimal digit = 4 bits (a **nibble**)
- Hex digits: 0-9, A-F (16 total, matching 2^4 possibilities)

| Decimal | Binary | Hex | Decimal | Binary | Hex |
|---------|--------|-----|---------|--------|-----|
| 0 | 0000 | 0 | 8 | 1000 | 8 |
| 1 | 0001 | 1 | 9 | 1001 | 9 |
| 2 | 0010 | 2 | 10 | 1010 | A |
| 3 | 0011 | 3 | 11 | 1011 | B |
| 4 | 0100 | 4 | 12 | 1100 | C |
| 5 | 0101 | 5 | 13 | 1101 | D |
| 6 | 0110 | 6 | 14 | 1110 | E |
| 7 | 0111 | 7 | 15 | 1111 | F |

### Binary to Hexadecimal Conversion

**Example:** Convert `0b1101101100101111` to hex

1. Split into 4-bit groups: `1101 | 1011 | 0010 | 1111`
2. Convert each group to decimal: 13, 11, 2, 15
3. Convert decimal to hex: D, B, 2, F
4. **Result:** `0xDB2F`

### Hexadecimal to Binary Conversion

**Example:** Convert `0x41AE` to binary

1. Split hex digits: `4 | 1 | A | E`
2. Convert to decimal: 4, 1, 10, 14
3. Convert to binary: `0100 | 0001 | 1010 | 1110`
4. **Result:** `0b0100000110101110`

### Memorization Aid
- A = 10
- B = 11
- C = 12
- D = 13
- E = 14
- F = 15

These conversions are **essential skills**—you'll perform them constantly on the exam and in lab environments.

---

## IPv6 Address Structure

### Overview
IPv6 addresses consist of **128 bits** written as eight groups of **four hexadecimal digits** separated by colons:

```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

This represents the same concept as IPv4's dotted-decimal notation but with vastly more addressing capability and additional built-in features (multicast, link-local, etc.).

### Canonical Representation
- Eight groups of four hex digits
- Each group represents 16 bits (a **hextuple**)
- Total: 32 hex characters = 128 bits

Example breakdown:
```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
├─┬─┤├─┬─┤├─┬─┤├─┬─┤├─┬─┤├─┬─┤├─┬─┤├─┬─┤
16  16  16  16  16  16  16  16 bits each
```

### Compression Rules

**Leading Zeros:** Omit leading zeros within a group
- `0db8` → `db8`
- `0000` → `0` (must show at least one digit)
- `0370` → `370`

**Consecutive Zero Groups:** Replace with `::`
- Can use **only once** per address (ambiguity prevention)
- Used for the longest sequence of all-zero groups
- If tied, replace the leftmost sequence

**Compressed Examples:**

| Full | Compressed |
|------|-----------|
| `2001:0db8:0000:0000:0000:0000:0000:0001` | `2001:db8::1` |
| `2001:0db8:85a3:0000:0000:8a2e:0370:7334` | `2001:db8:85a3::8a2e:370:7334` |
| `0000:0000:0000:0000:0000:0000:0000:0001` | `::1` (loopback) |
| `0000:0000:0000:0000:0000:0000:0000:0000` | `::` (all zeros) |

### Prefix Length (CIDR Notation)
Like IPv4, IPv6 uses [[CIDR]] notation:
- `2001:db8::/32` = network prefix is first 32 bits
- `/48` = common regional allocation
- `/64` = common subnet size
- `/128` = single host (like /32 in IPv4)

---

## IPv6 Address Types

### Unicast
**Purpose:** One-to-one communication; packet destined for a single host.

#### Global Unicast Addresses (GUA)
- **Format:** Begins with `2000::/3` (binary: `001`)
- **Structure:** `network_prefix | subnet_id | interface_id`
  - Network prefix: typically `/48` (48 bits)
  - Subnet ID: typically 16 bits (allows 2^16 = 65,536 subnets per /48)
  - Interface ID: 64 bits (auto-configurable via [[EUI-64]])
- **Assignment:** By [[IANA]] → [[RIRs]] → ISPs → organizations
- **Example:** `2001:db8:1234:5678::/64`

#### Link-Local Addresses (LLA)
- **Format:** Begins with `fe80::/10`
- **Interface ID:** Auto-generated (EUI-64 or random)
- **Scope:** Link-local only (not routed)
- **Purpose:** Neighbor discovery, auto-configuration, essential when no global address exists
- **Auto-Assignment:** Hosts automatically generate without DHCPv6 or [[SLAAC]] (Stateless Address Auto-Configuration)
- **Example:** `fe80::1` on a router's interface
- **Use Case:** First communication mechanism; enables [[ICMPv6]] neighbor discovery

#### Unique Local Addresses (ULA)
- **Format:** Begins with `fc00::/7` (not assigned by IANA)
- **Purpose:** Like IPv4 private addresses (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16)
- **Routing:** NOT routed on public internet
- **Advantage over link-local:** Routable within your organization
- **Example:** `fd12:3456:789a::/48`

### Multicast
**Purpose:** One-to-many communication; packet sent to multiple subscribers.

- **Format:** Begins with `ff00::/8`
- **Scope bits:** Second hex digit identifies scope (1 = node-local, 2 = link-local, 5 = site-local, e = global)
- **Common addresses:**
  - `ff02::1` = all nodes on link
  - `ff02::2` = all routers on link
  - `ff02::1:ff00:0/104` = solicited-node multicast (Neighbor Discovery)
- **No broadcast in IPv6:** Multicast replaces broadcast entirely

### Anycast
**Purpose:** One-to-nearest communication; packet destined for nearest member of a group.

- **Format:** Syntactically identical to unicast (no special prefix)
- **Behavior:** Router uses routing metrics to deliver to nearest interface
- **Use Case:** DNS root server distribution, load balancing
- **Limitation:** Not commonly used in CCNA scope; primarily for infrastructure

---

## IPv6 Header (Simplified Context)

While full header analysis isn't CCNA-tested, understanding key differences from IPv4 is valuable:

| Feature | IPv4 | IPv6 |
|---------|------|------|
| Header size | 20–60 bytes (variable, options) | 40 bytes (fixed) |
| Source/dest address | 32 bits each | 128 bits each |
| Fragmentation | Router-side | Host-side only |
| TTL equivalent | TTL (Time To Live) | Hop Limit |
| Checksum | Included | Removed (lower-layer checksum suffices) |
| QoS support | Type of Service (ToS) | Traffic Class + Flow Label |

---

## Lab Relevance

### Essential Cisco IOS Commands

#### Configuring IPv6 on Interfaces

**Enable IPv6 globally:**
```
Router(config)# ipv6 unicast-routing
```

**Assign global unicast address:**
```
Router(config-if)# ipv6 address 2001:db8:1::1/64
```

**Assign link-local address (optional; auto-generated if not specified):**
```
Router(config-if)# ipv6 address fe80::1 link-local
```

**Enable address auto-configuration via SLAAC:**
```
Router(config-if)# ipv6 address autoconfig
```

**

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 20 | [[CCNA]]*