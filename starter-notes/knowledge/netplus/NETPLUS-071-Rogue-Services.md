---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 071
source: rewritten
---

# Rogue Services
**Unauthorized network services that mimic legitimate infrastructure to intercept, disrupt, or compromise network communications.**

---

## Overview
Rogue services are illegitimate copies of real network infrastructure devices that an attacker deploys to either steal credentials, redirect traffic, or disable legitimate services. For Network+ professionals, understanding rogue services is critical because they represent a fundamental layer 2-3 attack vector that can compromise entire network segments without requiring advanced hacking skills—just a cheap device and basic configuration knowledge.

---

## Key Concepts

### Rogue DHCP Server
**Analogy**: Imagine a fake postal worker who intercepts mail delivery requests and sends people to the wrong address. A rogue DHCP server does this with network configuration—it tricks clients into trusting false network information.

**Definition**: An unauthorized [[DHCP]] server that responds to [[DHCP Discovery]] requests and assigns IP addresses, [[subnet mask]]es, [[default gateway]]s, and other configuration data to clients on the network.

**Why This Matters**: 
- [[DHCP]] has zero built-in authentication mechanisms
- Any device listening on [[UDP 67]] can respond to client requests
- Creates duplicate IP addresses, invalid configurations, and network service interruption

**Attack Scenario**:

| Impact | Description |
|--------|-------------|
| **Duplicate IPs** | Multiple devices receive the same address, causing communication failures |
| **Wrong Gateway** | Attacker's machine becomes the default gateway, enabling man-in-the-middle attacks |
| **DNS Poisoning** | Malicious DNS servers redirect traffic to attacker-controlled sites |
| **Network Outage** | Clients cannot reach legitimate services due to misconfiguration |

**Mitigation Strategies**:

```
DHCP Snooping Configuration (Cisco Example):
---
ip dhcp snooping
ip dhcp snooping vlan 10
no ip dhcp snooping information option
interface gi0/1
 ip dhcp snooping trust
```

[[DHCP Snooping]] examines all DHCP traffic and only allows responses from switch ports designated as trusted. Untrusted ports receive only [[DHCP Discovery]] and [[DHCP Request]] frames.

**Active Directory Protection**:
[[Microsoft Active Directory]] includes DHCP authorization—only explicitly authorized DHCP servers can service clients. Unauthorized servers fail to start.

---

### Rogue Access Point
**Analogy**: A counterfeit WiFi hotspot at a coffee shop that looks like the real network but actually sends all your traffic to a hacker's laptop.

**Definition**: An unauthorized [[wireless access point]] deployed on a network to intercept [[802.11]] traffic, capture credentials, or provide attacker-controlled network access.

**Why This Matters**:
- [[Access points]] are inexpensive (under $50)
- No physical barrier prevents installation
- Wireless traffic is easily captured without network access
- Users cannot distinguish legitimate from rogue APs

**Attack Variants**:

| Type | Method | Risk Level |
|------|--------|-----------|
| **Evil Twin** | Identical SSID to legitimate network | Critical |
| **Honeypot AP** | Attractive but unmonitored network name | Critical |
| **Ad-Hoc Network** | Peer-to-peer AP created by compromised device | High |
| **PineApple/Karma** | Hardware device capturing all probe requests | Critical |

---

### Rogue Access Point Detection & Prevention

**Detection Methods**:
- Conduct wireless site surveys using [[Kismet]] or [[Airodump-ng]]
- Monitor for unexpected MAC addresses or duplicate SSIDs
- Scan for unknown devices on network segments
- Review [[access point]] inventory against authorized device lists

**Prevention Controls**:
- Implement [[MAC filtering]] on legitimate APs
- Enable [[802.1X]] port-based authentication
- Use [[WPA3]] or [[WPA2-Enterprise]] encryption
- Deploy wireless intrusion detection systems ([[WIDS]])
- Physically secure network closets and wall drops

---

## Exam Tips

### Question Type 1: Rogue DHCP Server Identification
- *"A user reports they cannot reach the company gateway. You discover multiple devices have 169.254.x.x addresses. What is the most likely cause?"* → Rogue DHCP server assigning [[APIPA]] addresses (or conflicting with legitimate DHCP)
- **Trick**: Confuse [[APIPA]] (automatic IP when no DHCP found) with actual rogue server detection. The question is asking about *why* addresses conflict, not why APIPA appears.

### Question Type 2: Mitigation Controls
- *"Which feature prevents unauthorized DHCP servers from responding on a managed switch?"* → [[DHCP Snooping]]
- **Trick**: Candidates often answer "DHCP authorization" which is an AD concept, not a switch feature. Know the difference between network-layer and OS-level controls.

### Question Type 3: Rogue AP Detection
- *"You need to identify unauthorized wireless access points. Which tool provides the most comprehensive data?"* → [[Kismet]] or wireless site survey tools showing all nearby BSSIDs and signal strength
- **Trick**: Don't confuse endpoint WiFi scanning tools with actual rogue AP detection systems. Site surveys examine *all* RF activity, not just connected networks.

### Question Type 4: Response & Remediation
- *"After discovering a rogue DHCP server, what is the next step?"* → Remove the device from network and force all clients to renew IP leases
- **Trick**: Simply removing the device isn't enough—clients retain old, invalid configurations. You must trigger [[DHCP Release]] and [[DHCP Renew]] across all endpoints.

---

## Common Mistakes

### Mistake 1: Assuming DHCP Has Built-in Security
**Wrong**: "DHCP servers authenticate before responding, so rogue servers can't operate."
**Right**: [[DHCP]] is an unauthenticated protocol. Any device sending a [[DHCP Offer]] will be accepted by clients unless network controls prevent it.
**Impact on Exam**: You'll miss questions about why DHCP snooping is necessary and what vulnerabilities it addresses.

### Mistake 2: Confusing [[APIPA]] with Rogue DHCP Detection
**Wrong**: "When I see 169.254.x.x addresses, a rogue DHCP server is active."
**Right**: 169.254.x.x ([[APIPA]]) occurs when no DHCP server responds at all. A rogue DHCP might assign *legitimate-looking* addresses that conflict with real servers.
**Impact on Exam**: You'll misdiagnose network problems and propose wrong solutions.

### Mistake 3: Overlooking Rogue APs Because You're Focused on Wired Security
**Wrong**: "I've secured DHCP, so my network is protected from rogue services."
**Right**: Rogue [[access points]] bypass wired network security entirely. They operate independently on the wireless spectrum.
**Impact on Exam**: Questions asking about complete security strategies will reveal this oversight. You need defense-in-depth across both wired and wireless.

### Mistake 4: Thinking Physical Security Alone Prevents Rogue Devices
**Wrong**: "Locking the server room prevents rogue APs."
**Right**: Rogue APs can be deployed anywhere within RF range—hallways, parking lots, adjacent buildings. Physical security for network closets doesn't address wireless threats.
**Impact on Exam**: Scenario questions about preventing rogue services require *layered* answers, not just one control.

---

## Related Topics
- [[DHCP]] Protocol and Configuration
- [[DHCP Snooping]] (Layer 2 Switch Feature)
- [[802.1X]] Port-Based Network Access Control
- [[MAC Filtering]] and [[MAC Address]]
- [[Wireless Security]] Standards ([[WPA2]], [[WPA3]])
- [[Active Directory]] DHCP Authorization
- [[Kismet]] Wireless Detection Tool
- [[Man-in-the-Middle Attack]]
- [[Network Access Control]] ([[NAC]])
- [[WIDS]] (Wireless Intrusion Detection System)

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*