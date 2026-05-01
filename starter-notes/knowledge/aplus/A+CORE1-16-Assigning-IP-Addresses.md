---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 16
source: rewritten
---

# Assigning IP Addresses
**Master the essential parameters needed to connect any device to a network.**

---

## Overview

When you plug a device into a network, it needs more than just a power cable—it needs an identity and directions. Configuring [[IP addresses]] on network devices is foundational IT work, and the A+ exam expects you to understand not just the address itself, but all the supporting parameters that make communication possible. This knowledge separates someone who can "plug things in" from someone who can actually troubleshoot network connectivity issues.

---

## Key Concepts

### IP Address

**Analogy**: Think of an [[IP address]] like a street address on an envelope. Just as mail carriers need to know exactly which house you live in, network devices need a unique numerical identifier to send data to the correct machine. Without it, there's nowhere for the information to go.

**Definition**: An [[IP address]] is a unique numerical identifier assigned to each device on a network, allowing devices to locate and communicate with one another. Each device on the same network must have a distinct IP address to avoid conflicts.

| Aspect | Detail |
|--------|--------|
| **Format (IPv4)** | Four octets separated by dots (e.g., 192.168.1.165) |
| **Range** | 0.0.0.0 to 255.255.255.255 |
| **Uniqueness** | Must be unique within the network segment |

---

### Subnet Mask

**Analogy**: A [[subnet mask]] is like a zip code filter. Your street address tells you exactly which house, but the zip code tells the postal system which regional area to look in first. Similarly, a subnet mask tells a device which portion of an IP address represents the local network segment.

**Definition**: A [[subnet mask]] is a 32-bit value that divides an [[IP address]] into a network portion and a host portion. It enables devices to determine whether another IP address is on the same local network or requires routing through a [[gateway]].

| Component | Example | Purpose |
|-----------|---------|---------|
| **IP Address** | 192.168.1.165 | Device identifier |
| **Subnet Mask** | 255.255.255.0 | Defines network boundary |
| **Network Address** | 192.168.1.0 | Identifies the subnet itself |
| **Broadcast Address** | 192.168.1.255 | Reaches all devices on subnet |

**Key Point**: The combination of an [[IP address]] and its [[subnet mask]] together is called an **IP subnet**.

---

### Default Gateway

**Analogy**: If your local network is a neighborhood, the [[default gateway]] is the single exit sign leading to the highway. When your computer needs to send data outside the neighborhood, it looks for that exit sign (the gateway's IP address) to know where to hand off the packet.

**Definition**: A [[default gateway]] is the [[IP address]] of the local router or routing device that enables a computer to reach networks beyond its own subnet. Any traffic destined for a remote network gets forwarded to this address.

```
Typical Default Gateway Configuration:
IP Address: 192.168.1.100
Subnet Mask: 255.255.255.0
Default Gateway: 192.168.1.1  ← Usually the router
```

---

### DNS Server

**Analogy**: Your device knows IP addresses are like phone numbers—they work, but they're hard to remember. A [[DNS]] server is like a phone directory that converts human-friendly names (google.com) into the IP addresses devices actually use to connect.

**Definition**: [[DNS]] (Domain Name System) servers translate domain names into [[IP addresses]]. Devices need at least one configured [[DNS]] server address to resolve website names and hostnames into routable [[IP addresses]].

| Setting | Example | Function |
|---------|---------|----------|
| **Primary DNS** | 8.8.8.8 | Main name resolution service |
| **Secondary DNS** | 8.8.4.4 | Backup if primary fails |

---

### Additional Configuration Parameters

Beyond the core four parameters above, environments may require:

- **[[NTP]] Server**: Synchronizes device time across the network
- **VoIP Server**: Handles voice communications infrastructure  
- **DHCP Server**: Automatically assigns IP configuration (discussed separately)

---

## Exam Tips

### Question Type 1: Identifying Missing Parameters
- *"A workstation has IP 192.168.1.50 and subnet 255.255.255.0 but cannot reach the internet. What's most likely missing?"* → [[Default gateway]] address
- **Trick**: The exam loves testing whether you understand that local communication only needs IP + subnet mask, but remote communication requires a [[gateway]]

### Question Type 2: Subnet Mask Function
- *"What does a subnet mask determine?"* → Which devices are on the local subnet vs. remote networks
- **Trick**: Don't confuse "what a subnet mask looks like" with "what it does." The exam tests functional understanding

### Question Type 3: Static vs. Automatic Configuration
- *"Which method requires you to manually enter all four parameters?"* → Static [[IP address]] assignment
- **Trick**: Remember that [[DHCP]] automatically provides IP, subnet mask, [[gateway]], and often [[DNS]]—but static assignment means you're doing all the typing yourself

---

## Common Mistakes

### Mistake 1: Forgetting the Subnet Mask
**Wrong**: "I configured the IP address 192.168.1.100, so the device is ready to communicate."
**Right**: "An [[IP address]] alone is useless; you must also configure the [[subnet mask]] so the device knows its network boundaries."
**Impact on Exam**: You'll see questions asking "what's missing" in incomplete configurations. Subnet mask is frequently the forgotten parameter.

### Mistake 2: Confusing Gateway with DNS
**Wrong**: "If the [[default gateway]] is missing, DNS lookups will fail."
**Right**: "A missing [[gateway]] prevents communication outside the local subnet. A missing [[DNS]] server prevents name resolution, but the [[gateway]] is still needed to reach remote networks."
**Impact on Exam**: Troubleshooting scenarios will test whether you know which missing parameter causes which specific problem.

### Mistake 3: Assuming All Parameters Are the Same for Every Device
**Wrong**: "Every device on the network should have the same IP address and gateway."
**Right**: "Each device needs a unique [[IP address]] within the subnet, but they all share the same [[subnet mask]] and [[default gateway]] on the same local network."
**Impact on Exam**: Configuration questions will ask you to assign IPs to multiple devices—you must vary the host portion while keeping network and gateway consistent.

### Mistake 4: Not Understanding When Manual Assignment Is Necessary
**Wrong**: "Devices should always be configured manually for security."
**Right**: "[[DHCP]] provides automatic configuration for most users, but servers, printers, and network infrastructure often require static [[IP address]] assignment to ensure they're always at the same address."
**Impact on Exam**: Questions may ask which device type should be statically assigned—servers and infrastructure almost always require manual configuration.

---

## Related Topics
- [[DHCP]] (Dynamic Host Configuration Protocol)
- [[IP Addressing Schemes]]
- [[Subnetting]]
- [[Routing]]
- [[Network Troubleshooting]]
- [[IPv4 vs IPv6]]
- [[MAC Addresses]]

---

*Source: Adapted from Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]]*