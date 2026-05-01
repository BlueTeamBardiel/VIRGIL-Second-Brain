---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 036
source: rewritten
---

# VLANs and Trunking
**Virtual LANs allow you to create multiple isolated networks on a single physical switch, saving space, power, and management overhead.**

---

## Overview

A [[Local Area Network|LAN]] traditionally represents all devices sharing the same [[broadcast domain]] connected through one physical switch. However, modern networks need logical separation without requiring multiple physical devices. [[VLAN|VLANs]] (Virtual Local Area Networks) solve this by partitioning a single switch into multiple isolated broadcast domains, dramatically reducing infrastructure costs while improving network flexibility and security.

---

## Key Concepts

### Broadcast Domain
**Analogy**: Think of a broadcast domain like a room full of people speaking the same language. When someone speaks, everyone in the room hears them. The walls of the room are the boundaries—sound doesn't escape.

**Definition**: A [[broadcast domain]] is a logical network segment where all connected devices receive each other's [[broadcast]] traffic. Traditionally, each physical [[network switch]] creates one broadcast domain.

### Virtual Local Area Network (VLAN)
**Analogy**: Imagine taking that one room and installing invisible soundproof dividers. Now multiple conversations happen in the same physical space, but participants can't hear across the dividers—even though they're standing next to each other.

**Definition**: A [[VLAN]] is a logical segmentation of a single physical switch that creates multiple independent [[broadcast domain|broadcast domains]]. Devices in different VLANs cannot communicate directly without a [[router]] or [[Layer 3 switch]], even if physically connected to the same switch.

| Aspect | Traditional Setup | VLAN Setup |
|--------|------------------|-----------|
| **Physical Switches** | Multiple | Single |
| **Broadcast Domains** | One per switch | Multiple per switch |
| **Power Consumption** | High | Low |
| **Management Complexity** | Per device | Per VLAN |
| **Scalability** | Limited by space/power | Highly flexible |

### VLAN Tagging and 802.1Q
**Analogy**: Like putting colored stickers on mail so the post office knows which department to deliver it to—even though it arrives at the same building.

**Definition**: [[802.1Q]] is the IEEE standard that adds a [[VLAN tag]] (a 4-byte header) to [[Ethernet]] frames. This tag contains a [[VLAN ID]] (1–4094), allowing switches to identify which VLAN a frame belongs to.

```
Ethernet Frame with 802.1Q Tag:
[Dest MAC][Src MAC][802.1Q Tag: TPID=0x8100, VLAN ID=10][Type][Payload][FCS]
                     ↑
                  VLAN 10
```

### Native VLAN
**Analogy**: The native VLAN is like a default language. If someone doesn't specify which language they're speaking, the room assumes a default language.

**Definition**: The [[native VLAN]] is the untagged VLAN on a [[trunk port]]. Frames on the native VLAN are sent without a 802.1Q tag and are assumed to belong to that VLAN upon receipt.

**Warning**: Mismatching native VLANs on trunk ports causes [[VLAN hopping]] vulnerabilities.

### Trunk Ports
**Analogy**: A trunk port is like a multi-lane highway connecting two cities. Instead of carrying cars (devices) from one city, it carries multiple "routes" (VLANs) simultaneously.

**Definition**: A [[trunk port]] is a switch interface configured to carry traffic for multiple [[VLAN|VLANs]] simultaneously. Trunk ports tag frames with VLAN IDs so receiving switches know which VLAN the traffic belongs to.

| Port Type | Purpose | VLAN Membership | Frame Tagging |
|-----------|---------|-----------------|----------------|
| **Access Port** | Connects end devices | Single VLAN | Untagged |
| **Trunk Port** | Connects switches/routers | Multiple VLANs | Tagged (802.1Q) |

### Access Ports
**Analogy**: An access port is like a front door to an apartment building—residents (devices) enter through it but don't need to identify which floor they're going to; the port already knows.

**Definition**: An [[access port]] is a switch interface assigned to a single [[VLAN]]. Devices connected to access ports don't send or receive 802.1Q tags; the switch automatically assigns incoming untagged frames to the port's configured VLAN.

```
Cisco IOS Configuration Example:

! Configure access port for VLAN 10
interface GigabitEthernet0/1
 switchport mode access
 switchport access vlan 10

! Configure trunk port
interface GigabitEthernet0/2
 switchport mode trunk
 switchport trunk allowed vlan 1,10,20,30
 switchport trunk native vlan 99
```

### Inter-VLAN Routing
**Analogy**: Two neighborhoods in the same city can't visit each other without a bridge connecting them. That bridge is the router.

**Definition**: Since devices in different [[VLAN|VLANs]] are in separate [[broadcast domain|broadcast domains]], they need a [[router]] or [[Layer 3 switch]] to communicate. This device routes traffic between VLANs using [[IP routing]].

| Device Type | Connectivity | Use Case |
|-------------|--------------|----------|
| **Layer 2 Switch** | Within VLAN only | Intra-VLAN communication |
| **Layer 3 Switch/Router** | Between VLANs | Inter-VLAN routing |

### VLAN Ranges

**Definition**: The [[VLAN ID]] space divides into functional ranges:

| Range | Name | Purpose |
|-------|------|---------|
| **1** | Default VLAN | Pre-configured, can't be deleted |
| **2–1001** | Normal VLANs | Standard production VLANs |
| **1002–1005** | Reserved | Legacy Token Ring/FDDI (unused) |
| **1006–4094** | Extended VLANs | Enterprise/Service Provider |

---

## Exam Tips

### Question Type 1: VLAN Configuration Scenarios
- *"You need to connect two switches and allow traffic for VLANs 10, 20, and 30 to pass between them. Which port type should you configure?"* → **Trunk port** with allowed VLANs 10, 20, 30
- *"A device in VLAN 10 cannot reach a device in VLAN 20, even though both are on the same switch. What's missing?"* → **Inter-VLAN routing** (a Layer 3 device)
- **Trick**: Don't confuse "same switch" with "can communicate"—VLANs are logical separation, not physical.

### Question Type 2: 802.1Q and Tagging
- *"Which standard defines VLAN tagging?"* → **802.1Q**
- *"What is added to an Ethernet frame when it enters a trunk port?"* → **VLAN ID tag** (802.1Q header)
- **Trick**: Access ports **remove** tags before sending to devices; trunk ports **add** tags.

### Question Type 3: Native VLAN Issues
- *"Two switches are connected via a trunk port. Switch A has native VLAN 1, Switch B has native VLAN 10. What happens?"* → **VLAN hopping/native VLAN mismatch** causes untagged frames to be misrouted.
- **Trick**: Native VLAN should **always** be the same on both sides of a trunk.

### Question Type 4: Port Mode Identification
- *"An interface is configured 'switchport mode access vlan 15.' What can connect here?"* → **Only one end device** (computer, printer, phone)
- *"An interface is configured 'switchport mode trunk.' What can connect here?"* → **Only another switch or router**
- **Trick**: A device cannot be both access and trunk simultaneously.

---

## Common Mistakes

### Mistake 1: Confusing Access and Trunk Ports
**Wrong**: "I'll configure all ports as trunk ports for flexibility."
**Right**: Access ports connect end devices (computers, phones), trunk ports connect network infrastructure (switches, routers).
**Impact on Exam**: Misidentifying which port type to use will fail scenario-based questions. Trunk ports on end devices cause security and performance issues. You'll lose points on troubleshooting questions.

### Mistake 2: Forgetting Inter-VLAN Routing
**Wrong**: "I created VLAN 10 and VLAN 20, so devices in each can now communicate."
**Right**: Devices in different VLANs cannot communicate unless a [[Layer 3 device]] routes between them.
**Impact on Exam**: This is tested heavily in troubleshooting scenarios. You must recognize when a [[router]] or [[Layer 3 switch]] is needed for multi-VLAN communication.

### Mistake 3: Mismatching Native VLANs
**Wrong**: "Native VLAN doesn't matter as long as the trunk is up."
**Right**: Mismatched native VLANs cause untagged frames to be assigned to the wrong VLAN, breaking communication and creating security vulnerabilities.
**Impact on Exam**: This appears in "why can't Device A reach Device B?" questions. Recognize native VLAN mismatch as a common cause of trunk issues.

### Mistake 4: Not Understanding VLAN Tag Purpose
**Wrong**: "VLAN tags are added so devices know which VLAN they're in."
**Right**: VLAN tags are added by trunk ports **between switches** so they know which VLAN the frame belongs to. End devices never see tags.
**Impact on Exam**: Questions asking "what does the VLAN tag do?" or "where are tags applied?" will trip you up if you misunderstand the scope.

### Mistake 5: Assuming All Extended VLANs Work the Same
**Wrong**: "VLAN 3000 works exactly like VLAN 50."
**Right**: Extended VLANs (1006–4094) don't support all features that normal VLANs (2–1001) do. Some require [[VLAN Trunking Protocol|VTP]] or other protocols.
**Impact on Exam**: You might see a question about VLAN limitations; extended VLANs have reduced functionality in some legacy scenarios.

---

## Related Topics
- [[Ethernet Switching]]
- [[802.1Q]] (VLAN Tagging Standard)
- [[Layer 3 Switch]] (Inter-VLAN Routing)
- [[Router]] (Inter-VLAN Routing Alternative)
- [[Broadcast Domain]]
- [[Network Segmentation]]
- [[VLAN Hopping]]
- [[Native VLAN]]
- [[Spanning Tree Protocol]] (STP)
- [[Port Security]]
- [[Access Control Lists]] (ACLs)

---

*Source: Rewritten from CompTIA Network+ N10-009 Lecture Material | [[Network+]]*