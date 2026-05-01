---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 13
source: rewritten
---

# VLANs and VPNs
**Logical network segmentation that lets you divide physical infrastructure into isolated communication zones.**

---

## Overview

Networks need to be organized into isolated groups so devices can communicate internally without interfering with others—this is called a [[broadcast domain]]. Traditionally, you'd need separate physical [[switches]] for each group, wasting hardware. VLANs solve this problem by creating multiple virtual networks on a single switch, while VPNs extend secure private networks across public infrastructure. Both are critical for exam success because they show up in scenario questions about network design, security, and troubleshooting.

---

## Key Concepts

### Broadcast Domain & LAN Fundamentals

**Analogy**: A broadcast domain is like an office building where announcements made in the lobby are heard by everyone on that floor, but not the other floors. Even if you're in the same building, floors are isolated from each other's announcements.

**Definition**: A [[broadcast domain]] is a group of devices connected to the same [[switch]] that all receive each other's broadcast traffic. A [[LAN (Local Area Network)]] is this collection of devices sharing one broadcast domain.

When a device sends a broadcast frame on one LAN, *every other device on that LAN receives it*. However, if you have a separate physical switch, that creates a completely different broadcast domain—broadcasts from one switch never reach the other switch.

---

### VLAN (Virtual LAN)

**Analogy**: Instead of renting two separate office buildings to keep teams apart, you rent one building and use temporary walls to create separate floors. Same physical structure, but logically divided.

**Definition**: A [[VLAN]] is a logical partition of a single physical [[switch]] that creates multiple independent broadcast domains. You can assign switch [[ports]] to different VLANs, making devices on different VLANs unable to communicate directly without a [[router]].

**Key Benefits**:
- Consolidates hardware (fewer switches needed)
- Improves security (sensitive departments isolated)
- Increases flexibility (move devices without rewiring)
- Reduces broadcast traffic congestion

---

### VLAN Tags & Trunking

**Analogy**: Imagine a highway with multiple lanes, each lane marked with a colored stripe. The stripe tells every car which lane it belongs to. A trunk port is like a highway that carries cars from all lanes simultaneously.

**Definition**: 
- **[[VLAN Tag]]** (802.1Q): A 4-byte field added to [[Ethernet]] frames identifying which VLAN the frame belongs to
- **[[Trunk Port]]**: A switch port that carries traffic for *multiple VLANs* simultaneously
- **[[Access Port]]**: A switch port assigned to a *single VLAN* where end devices connect

| Feature | Access Port | Trunk Port |
|---------|-------------|-----------|
| **Connected to** | End devices (PCs, printers) | Other switches |
| **Carries** | One VLAN only | Multiple VLANs |
| **Tagged frames?** | No (untagged) | Yes (tagged with VLAN ID) |
| **Typical usage** | Workstation connections | Switch-to-switch links |

---

### VLAN Configuration Example

```
Switch(config)# interface FastEthernet 0/1
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 10

Switch(config)# interface FastEthernet 0/24
Switch(config-if)# switchport mode trunk
Switch(config-if)# switchport trunk allowed vlan 10,20,30
```

This assigns port 1 to VLAN 10 as an access port, and port 24 as a trunk that carries VLANs 10, 20, and 30.

---

### VPN (Virtual Private Network)

**Analogy**: A VPN is like sending a postcard inside a locked box through the public mail system. The postal workers (ISP) can see the box traveling, but can't read what's inside. Only the recipient has the key to open it.

**Definition**: A [[VPN]] creates an encrypted tunnel across an untrusted network (like the Internet) so remote devices can securely access a private network as if they were physically on-site.

**How it protects you**:
- **Encryption**: Data is scrambled in transit
- **Authentication**: Verifies both ends of connection are legitimate
- **Tunneling**: Wraps your packets inside secure containers

---

### VPN Types

| VPN Type | Use Case | Connection |
|----------|----------|-----------|
| **[[Site-to-Site VPN]]** | Connect two office buildings securely | Network-to-network |
| **[[Remote Access VPN]]** | Employee working from home | Individual device to network |
| **[[SSL/TLS VPN]]** | Web-based secure access | Browser connection |

---

## Exam Tips

### Question Type 1: VLAN Configuration & Design
- *"Which port mode allows a switch port to carry multiple VLANs?"* → **Trunk mode** (with 802.1Q tagging)
- *"You need devices in VLAN 10 to communicate with devices in VLAN 20. What do you need?"* → **A [[router]]** (or [[Layer 3 switch]]) — different VLANs cannot talk directly
- **Trick**: Students often forget that VLANs segment broadcasts but *don't automatically provide inter-VLAN communication*. You always need routing!

### Question Type 2: VPN Security
- *"Which protocol encrypts VPN traffic and operates at Layer 7?"* → **[[SSL/TLS]]**
- *"What does a VPN tunnel protect against?"* → **Eavesdropping on public networks** (not malware or viruses)
- **Trick**: VPNs encrypt data in transit but don't scan for malware. A student mistaking VPN for antivirus will fail this.

### Question Type 3: Broadcast Domain Scenarios
- *"A company has four departments on one physical switch using VLANs. How many broadcast domains exist?"* → **Four** (one per VLAN, not one per physical switch)
- **Trick**: Confusing physical switches with broadcast domains is a classic mistake.

---

## Common Mistakes

### Mistake 1: Confusing Physical Switches with Broadcast Domains
**Wrong**: "If I have one physical switch, I have one broadcast domain."
**Right**: "One physical switch can contain *multiple* broadcast domains if VLANs are configured. Each VLAN = one broadcast domain."
**Impact on Exam**: Scenario questions asking "how many broadcast domains?" will trick you into counting switches instead of VLANs.

---

### Mistake 2: Thinking VLANs Automatically Allow Inter-VLAN Communication
**Wrong**: "I configured VLAN 10 and VLAN 20, so now devices in each can ping each other."
**Right**: "Different VLANs are isolated by design. You need a [[router]] or [[Layer 3 switch]] to route traffic between VLANs."
**Impact on Exam**: You'll see questions about "why can't VLAN 10 talk to VLAN 20?" The answer is always "missing router" or "no inter-VLAN routing."

---

### Mistake 3: Thinking VPNs Prevent Malware
**Wrong**: "I'm using a VPN, so my computer is protected from viruses."
**Right**: "VPNs encrypt traffic *in transit* only. They don't scan for malware, block viruses, or replace antivirus software."
**Impact on Exam**: VPN questions test whether you understand it's a *confidentiality and authentication tool*, not a security suite.

---

### Mistake 4: Misidentifying Trunk vs. Access Ports
**Wrong**: "I'll connect all my workstations to trunk ports because they carry more data."
**Right**: "Workstations connect to access ports (one VLAN each). Trunk ports connect switches together (carry all VLANs)."
**Impact on Exam**: Configuration scenario questions will test whether you know where to assign which port mode.

---

### Mistake 5: Confusing VPN Protocols
**Wrong**: "[[IPsec]] and [[SSL/TLS]] both work at the same OSI layer, so they're interchangeable."
**Right**: "[[IPsec]] operates at Layer 3 (Network); [[SSL/TLS]] operates at Layer 4-7. They protect different parts of the stack."
**Impact on Exam**: Questions about "which VPN protocol works at the application layer?" need [[SSL/TLS]], not [[IPsec]].

---

## Related Topics
- [[Network Segmentation]]
- [[Routers and Routing]]
- [[Ethernet and 802.1Q]]
- [[Encryption Protocols]]
- [[Network Security Architecture]]
- [[Firewalls and Access Control]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]] | [[Network Architecture]]*