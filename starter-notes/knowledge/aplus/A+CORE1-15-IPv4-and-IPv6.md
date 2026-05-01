---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 15
source: rewritten
---

# IPv4 and IPv6
**Master the two internet addressing systems that power modern networks—one dominant today, one built for tomorrow.**

---

## Overview

Every device connecting to a network needs a unique identifier, just like every house needs a street address. [[IPv4]] and [[IPv6]] are the two primary protocols that assign and manage these digital addresses across the internet. For the A+ exam, you absolutely must understand how to configure both systems, recognize their formats, and know when each one applies—because network connectivity questions appear on both 220-1201 and 220-1202.

---

## Key Concepts

### IPv4 Addressing

**Analogy**: Think of [[IPv4]] like a four-digit house address system. Each segment tells the postal service where to deliver the mail—except instead of streets and neighborhoods, we're routing data packets to the right computer.

**Definition**: [[IPv4]] is a 32-bit addressing scheme that represents network locations using four decimal numbers (0–255 each), separated by periods in **dotted decimal notation**. Each number is called an [[octet]] because it represents 8 bits of data. The total address uses 4 octets × 8 bits = 32 bits.

**Binary Representation**:
```
Decimal:  192.168.1.100
Binary:   11000000.10101000.00000001.01100100
```

**Key Property**: Each octet ranges from **0 to 255** (2^8 - 1 = 256 possible values per segment).

| Aspect | Details |
|--------|---------|
| **Total Bits** | 32 |
| **Total Bytes** | 4 |
| **Octets per Address** | 4 |
| **Range per Octet** | 0–255 |
| **Format** | Dotted decimal (192.168.1.1) |
| **Example Address** | 8.8.8.8 (Google DNS) |

---

### IPv6 Addressing

**Analogy**: If [[IPv4]] is a four-part house address, [[IPv6]] is like giving every grain of sand on Earth its own unique street address. It's massive, future-proof, and written in a completely different notation system.

**Definition**: [[IPv6]] is a 128-bit addressing scheme that uses hexadecimal notation (0–9, A–F) and colons to separate 16-bit segments. It was designed to solve the [[IPv4 address exhaustion]] problem and provide nearly unlimited addresses for the growing internet.

**Hexadecimal Representation**:
```
IPv6 Address: 2001:0db8:85a3:0000:0000:8a2e:0370:7334
Shortened:    2001:db8:85a3::8a2e:370:7334
```

| Aspect | Details |
|--------|---------|
| **Total Bits** | 128 |
| **Total Bytes** | 16 |
| **Segments** | 8 (each 16 bits) |
| **Notation** | Hexadecimal + colons |
| **Address Count** | ~340 undecillion (340 × 10^36) |
| **Example** | fe80::1 (link-local) |

---

### Comparison: IPv4 vs IPv6

| Feature | [[IPv4]] | [[IPv6]] |
|---------|----------|----------|
| **Bit Length** | 32 bits | 128 bits |
| **Format** | Dotted decimal (4 octets) | Hexadecimal (8 segments) |
| **Unique Addresses** | ~4.3 billion | 340 undecillion |
| **Address Exhaustion** | Occurred around 2011 | Never (theoretically) |
| **Configuration** | Still dominant | Growing adoption |
| **Broadcast** | Supported | Removed |
| **Complexity** | Simpler to read | More complex notation |

---

### Octets and Bit Grouping

**Analogy**: An [[octet]] is like a single byte in a filing cabinet—8 drawers stacked together. Each drawer (bit) is either open (1) or closed (0), and together they create a number from 0–255.

**Definition**: An [[octet]] is a group of 8 bits that represents a single decimal value in an [[IPv4]] address. Each of the four octets can independently range from 0 to 255.

```
Example: 192.168.1.50
         ↓   ↓    ↓  ↓
      Octet1 Octet2 Octet3 Octet4
```

---

### Address Classes (Legacy, Still Testable)

**Analogy**: Imagine postal zones sized for different purposes—small towns get one zone type, cities get another. That's how [[IPv4]] address classes divide the address space.

| Class | Range | First Octet | Purpose |
|-------|-------|-------------|---------|
| **A** | 1.0.0.0 – 126.255.255.255 | 1–126 | Large networks |
| **B** | 128.0.0.0 – 191.255.255.255 | 128–191 | Medium networks |
| **C** | 192.0.0.0 – 223.255.255.255 | 192–223 | Small networks |
| **D** | 224.0.0.0 – 239.255.255.255 | 224–239 | Multicast |
| **E** | 240.0.0.0 – 255.255.255.255 | 240–255 | Reserved/Experimental |

---

### Subnet Masks and Network Identification

**Analogy**: A [[subnet mask]] is like a stencil that separates the "neighborhood" (network) from the "house number" (host). It tells routers which part of the address identifies the network and which part identifies individual devices.

**Definition**: A [[subnet mask]] is a 32-bit value that uses binary 1s (network portion) and 0s (host portion) to divide an IP address into network and host sections.

```
IP Address:      192.168.1.100
Subnet Mask:     255.255.255.0
Network Address: 192.168.1.0
Broadcast:       192.168.1.255
Usable Host Range: 192.168.1.1 – 192.168.1.254
```

**CIDR Notation**: A shorthand that specifies how many bits belong to the network (written as /24 = 24 network bits).

---

### Private vs. Public IPv4 Addresses

**Analogy**: Private addresses are like internal office phone extensions—they work perfectly within your building but don't route to the outside world. Public addresses are your main office number that anyone can call from anywhere.

**Definition**: [[Private IPv4 addresses]] are reserved ranges that never route on the public internet and can be reused by any organization. [[Public IPv4 addresses]] are globally unique and route across the internet.

| Type | Ranges |
|------|--------|
| **Private Class A** | 10.0.0.0 – 10.255.255.255 |
| **Private Class B** | 172.16.0.0 – 172.31.255.255 |
| **Private Class C** | 192.168.0.0 – 192.168.255.255 |
| **Loopback (Private)** | 127.0.0.0 – 127.255.255.255 |
| **Link-Local (Private)** | 169.254.0.0 – 169.254.255.255 |

---

### DHCP Configuration

**Analogy**: [[DHCP]] is like a hotel front desk automatically assigning rooms to guests instead of guests choosing their own—it hands out temporary addresses from a pool and manages them automatically.

**Definition**: [[Dynamic Host Configuration Protocol]] automatically assigns IPv4 addresses to devices on a network, along with subnet mask, default gateway, and DNS information. Addresses are typically leased for a set time period.

**Manual IPv4 Configuration** requires:
- IP Address
- Subnet Mask
- Default Gateway
- DNS Server(s)

---

### IPv6 Advantages and Features

**Analogy**: [[IPv6]] is like upgrading from a small-town phone book (IPv4) to a planetary-scale directory that never runs out of numbers and has built-in security locks on every entry.

**Definition**: [[IPv6]] solves IPv4's limitations by offering massive address space, simplified routing, built-in [[IPSec]] security, and auto-configuration capabilities.

**IPv6 Address Types**:

| Type | Purpose | Example |
|------|---------|---------|
| **Unicast** | One device to one device | 2001:db8::1 |
| **Multicast** | One device to multiple devices | ff00::1 |
| **Anycast** | To nearest device in group | — |
| **Link-Local** | Communication on local network only | fe80::1 |
| **Global Unicast** | Routable on internet | 2001:db8::/32 |

---

## Exam Tips

### Question Type 1: IPv4 Address Format and Calculation
- *"What is the maximum value for a single octet in an IPv4 address?"* → **255** (8 bits = 2^8 - 1)
- *"Convert the decimal 192 to binary as it appears in an IPv4 address."* → **11000000**
- **Trick**: Don't confuse 255 with 256—test makers love this. Octets are 0–255, not 1–256.

### Question Type 2: Private vs. Public Address Identification
- *"Which address range is reserved for private networks?"* → **10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16**
- *"Is 172.31.100.5 a private address?"* → **Yes** (within 172.16–172.31 range)
- **Trick**: 172.15.x.x is public; 172.16.x.x is private. Off-by-one errors are common.

### Question Type 3: IPv6 Format Recognition
- *"Which is valid IPv6 notation?"* → **2001:db8::1** or **fe80::1** (colons, hexadecimal, 8 segments)
- *"IPv6 uses how many bits?"* → **128 bits**
- **Trick**: IPv6 addresses look completely alien to IPv4—don't assume you can read them at first glance.

### Question Type 4: DHCP vs. Static Configuration
- *"A client receives an IP address automatically. What protocol is this?"* → **DHCP**
- *"Which must be manually configured: IP address, subnet mask, gateway, or DHCP server?"* → **All except DHCP server** (DHCP assigns the rest)
- **Trick**: Static = manual input; DHCP = automatic. The question will hint which one by describing "automatic" or "manual" configuration.

### Question Type 5: Subnet Mask Interpretation
- *"What does a /24 subnet mask mean?"* → **24 network bits, 8 host bits** (255.255.255.0)
- *"How many usable host addresses in a /24 network?"* → **254** (2^8 - 2, excluding network and broadcast)
- **Trick**: Don't forget to subtract 2 (network address and broadcast address are unusable for hosts).

---

## Common Mistakes

### Mistake 1: Confusing Octets with Bits
**Wrong**: "An octet is 10 bits, so IPv4 has 40 bits total."
**Right**: An octet is exactly 8 bits; IPv4 is 4 octets = 32 bits total.
**Impact on Exam**: You'll fail subnet mask questions and CIDR notation if you misunderstand bit groupings.

---

### Mistake 2: Including Network and Broadcast in Usable Hosts
**Wrong**: "A /24 network has 256 usable host addresses