---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 021
source: rewritten
---

# IPv4 Addressing
**The foundational system for assigning unique identifiers to every networked device using a 32-bit numbering scheme.**

---

## Overview
[[IPv4]] (Internet Protocol version 4) is the addressing framework that enables devices to find and communicate with each other across networks. Every device participating in [[IP]] communication requires its own distinct address, similar to how houses need street addresses for mail delivery. Understanding IPv4 addressing structure, [[subnetting]], and configuration is essential for the Network+ exam because it forms the backbone of nearly every modern network infrastructure decision.

---

## Key Concepts

### IPv4 Address Structure
**Analogy**: Think of an IPv4 address like a postal code system—the first digits narrow down the region (network), while the final digits identify the specific location (host).

**Definition**: An [[IPv4 address]] is a 32-bit identifier expressed as four decimal numbers (octets) separated by periods, ranging from 0 to 255 in each octet. The format is `XXX.XXX.XXX.XXX`.

| Component | Range | Purpose |
|-----------|-------|---------|
| Octet 1 | 0-255 | First segment of address |
| Octet 2 | 0-255 | Second segment of address |
| Octet 3 | 0-255 | Third segment of address |
| Octet 4 | 0-255 | Host identifier (typically) |

**Example**: `192.168.1.100`

---

### Subnet Mask
**Analogy**: A [[subnet mask]] works like a stencil that reveals which portion of the address identifies the network versus which portion identifies individual devices on that network.

**Definition**: A 32-bit value (also expressed in four octets) that determines the boundary between the [[network]] portion and [[host]] portion of an [[IPv4 address]]. The mask uses consecutive 1-bits (representing network) followed by consecutive 0-bits (representing hosts).

| Subnet Mask | CIDR Notation | Usable Hosts |
|-------------|---------------|--------------|
| 255.255.255.0 | /24 | 254 |
| 255.255.255.128 | /25 | 126 |
| 255.255.255.192 | /26 | 62 |
| 255.255.0.0 | /16 | 65,534 |

**How It Works**:
```
IP Address:    192.168.1.100
Subnet Mask:   255.255.255.0
               (binary: 1s for network, 0s for host)
Network ID:    192.168.1.0
Broadcast:     192.168.1.255
Host Range:    192.168.1.1 - 192.168.1.254
```

The subnet mask operates locally on your device—it's never transmitted across the network. It tells your device which other addresses are on your local [[subnet]] versus which require routing.

---

### Default Gateway
**Analogy**: A [[default gateway]] is like the exit ramp off your neighborhood street—it's the single point through which all traffic heading "outside" must pass.

**Definition**: The [[IPv4 address]] of a router interface on your local [[subnet]] that serves as the forwarding point for all traffic destined outside your network. Your device consults the gateway whenever it determines a destination is not local.

| Component | Example Value | Purpose |
|-----------|---------------|---------|
| Device IP | 192.168.1.100 | Your host address |
| Subnet Mask | 255.255.255.0 | Defines local boundary |
| Default Gateway | 192.168.1.1 | Exit point for non-local traffic |

**Configuration Example**:
```
IP Address:       192.168.1.100
Subnet Mask:      255.255.255.0
Default Gateway:  192.168.1.1 (the router)
```

When your device needs to send data to 10.0.0.50, it recognizes this is outside the 192.168.1.0/24 network, so it forwards the packet to 192.168.1.1 (the gateway) for routing.

---

### Loopback Address
**Analogy**: A [[loopback address]] is like talking to yourself—it's a way to test if your device's networking stack is functioning without needing external hardware.

**Definition**: A special reserved address range (`127.0.0.0/8`, with `127.0.0.1` being the standard) that routes traffic back to the originating device for diagnostic purposes. Packets sent to loopback never leave your device's network interface.

**Use Cases**:
- Testing network stack functionality
- Local service accessibility (e.g., `127.0.0.1:8080`)
- Troubleshooting network layer issues

---

## Exam Tips

### Question Type 1: Identifying Network and Host Portions
- *"Given IP address 172.16.5.130 with subnet mask 255.255.255.192, what is the network address?"* → Convert the mask to binary (last octet: 192 = 11000000), apply it to the IP. Network = 172.16.5.128
- **Trick**: Test-takers often forget that the last octet calculation requires binary conversion. Practice octet-by-octet analysis.

### Question Type 2: Default Gateway Selection
- *"A device has IP 10.0.5.50/24. Which address can serve as its default gateway?"* → Any address in 10.0.5.0 - 10.0.5.255 except network (10.0.5.0) and broadcast (10.0.5.255). Common answer: 10.0.5.1
- **Trick**: The gateway MUST be on the same local subnet as your device—many wrong answers place it on a different network entirely.

### Question Type 3: Loopback Testing
- *"A technician pings 127.0.0.1 and receives a reply, but cannot ping the gateway. What does this indicate?"* → The local network stack is functional, but external connectivity is broken (gateway unreachable, network card down, or routing misconfiguration).
- **Trick**: Understanding loopback proves layer 1-3 health; absence of loopback response suggests catastrophic stack failure.

---

## Common Mistakes

### Mistake 1: Confusing Subnet Mask as a Transmitted Value
**Wrong**: "The subnet mask is sent to the destination device so it knows how to route the packet back."

**Right**: The [[subnet mask]] is a local calculation tool only. It stays on your device and helps determine which IPs are directly reachable. Remote routers make forwarding decisions based on their own routing tables, not your mask.

**Impact on Exam**: Questions about what data is transmitted on the wire—the mask never appears in actual packet headers.

---

### Mistake 2: Assigning Broadcast or Network Address to Hosts
**Wrong**: "I can configure a device with IP address 192.168.1.0 or 192.168.1.255 on a /24 network."

**Right**: In a /24 network (255.255.255.0), the .0 address is reserved for the network ID and .255 is the broadcast address. Valid host range is .1 through .254.

**Impact on Exam**: Sizing subnets and identifying valid host ranges—you'll lose points if you miscalculate usable addresses.

---

### Mistake 3: Assuming Default Gateway Can Be Any Device
**Wrong**: "The default gateway can be any router on the internet."

**Right**: The default gateway must be a router interface on your local [[subnet]]. It's the only device that can reach you with a unicast frame (your physical network). Remote routers are unreachable without first going through your local gateway.

**Impact on Exam**: Configuration and troubleshooting scenarios where you must validate that gateway addresses exist on the same segment.

---

### Mistake 4: Misinterpreting Loopback Failures
**Wrong**: "If 127.0.0.1 fails to respond, the entire network is down."

**Right**: A failed loopback indicates a local network stack failure on that specific device only. It doesn't tell you anything about external network connectivity or other devices.

**Impact on Exam**: Distinguishing local layer 3 issues from WAN connectivity problems.

---

## Related Topics
- [[Subnetting]]
- [[CIDR Notation]]
- [[Network Classes]]
- [[Private IP Ranges]]
- [[IPv6 Addressing]]
- [[Routing]]
- [[ARP (Address Resolution Protocol)]]
- [[DHCP]]
- [[Static vs Dynamic IP Configuration]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*