---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 068
source: rewritten
---

# VLAN Hopping
**An attacker breaks out of their assigned virtual network by impersonating a switch to access other isolated segments.**

---

## Overview
VLAN hopping is a layer 2 attack where an unauthorized user escapes the boundaries of their assigned [[VLAN]] and gains access to traffic or resources on a different VLAN that should be unreachable without [[Router|routing]]. Understanding this threat is critical for Network+ because network segmentation is a fundamental security control, and knowing how it fails helps you design and troubleshoot secure switching environments.

---

## Key Concepts

### VLAN Segmentation Design
**Analogy**: Think of VLANs like apartment buildings where each floor is separated by firewalls—Marketing lives on Floor 1, Accounting on Floor 2, and Shipping on Floor 3. Each group is isolated unless an elevator (router) connects the floors.

**Definition**: [[VLAN|VLANs]] divide a physical switch into multiple logical networks, preventing [[Layer 2]] communication between groups without [[Router|routing]] intervention.

**Common VLAN Designs**:

| Environment | VLAN Examples | Purpose |
|---|---|---|
| Enterprise Office | Marketing VLAN, Finance VLAN, Guest VLAN | Department isolation & security |
| Small Business | Staff VLAN, IoT VLAN, Guest VLAN | Resource control & guest access |
| Home Network | Main Devices, Smart Home, Security Cameras | Device trust levels & bandwidth management |

### Dynamic Trunking Protocol (DTP)
**Analogy**: Imagine a mailroom that automatically decides if an incoming person is a mail carrier (allowed to carry multiple bags) or a regular visitor (only walks through normally). DTP does this automatically for switch ports.

**Definition**: [[DTP]] is a Cisco proprietary protocol that automatically negotiates whether a switch port operates as an [[Access Port]] (single VLAN) or a [[Trunk Port]] (multiple VLANs).

**Port Modes**:
```
Access Mode   → Carries traffic for ONE VLAN only
Trunk Mode    → Carries tagged traffic for MULTIPLE VLANs
Auto Mode     → Negotiates with neighbor (VULNERABLE)
Desirable     → Actively seeks trunk status (VULNERABLE)
On Mode       → Forces trunk without negotiation
```

### Switch Spoofing Attack
**Analogy**: A guest wearing a mail carrier uniform and carrying multiple packages walks into the apartment building—the security system automatically grants them access to all floors because they "look" like maintenance staff.

**Definition**: An attacker configures their device to emulate a switch, sending [[DTP]] frames that trick the target switch into negotiating a [[Trunk Port]] connection, granting access to all VLANs.

**How It Works**:
1. Attacker connects to an access port in VLAN 10
2. Device sends DTP packets claiming to be a switch
3. Target switch in "auto" or "desirable" mode responds by creating a trunk
4. Attacker can now send/receive frames tagged with any VLAN ID
5. Attacker gains access to traffic on VLANs 20, 30, 40, etc.

**Defense**:
```
! DISABLE DTP - Force access mode explicitly
interface FastEthernet0/1
  switchport mode access
  switchport nonegotiate
  
! Trunk ports should use "on" mode only
interface FastEthernet0/24
  switchport mode trunk
  switchport nonegotiate
```

### Double Tagging (802.1Q Exploit)
**Analogy**: A hacker mails a package inside another package. Security opens the outer box (their assigned VLAN), doesn't inspect the inner box, and delivers it to the inner address (target VLAN).

**Definition**: An attacker sends frames with two stacked [[802.1Q]] VLAN tags—the outer tag matches the access VLAN, but the inner tag specifies a target VLAN, bypassing the switch's outer tag removal.

**Attack Mechanics**:
- Attacker is in VLAN 10 (access port)
- Attacker sends frame with tags: `[VLAN 10][VLAN 20][Payload]`
- Switch removes outer VLAN 10 tag
- Frame exits trunk with VLAN 20 tag intact
- Reaches destination in VLAN 20 successfully

**Why It Works**:
- Access ports remove the outer tag before forwarding to trunks
- Trunks forward frames without re-evaluating inner tags
- Native VLAN configuration can amplify this vulnerability

**Defense**:
```
! Ensure native VLAN is unused (not VLAN 1)
vlan 999
  name native-vlan-unused

interface range FastEthernet0/1-22
  switchport trunk native vlan 999
  
! Explicitly tag all frames (no untagged native VLAN)
interface FastEthernet0/24
  switchport trunk allowed vlan 10,20,30
```

---

## Exam Tips

### Question Type 1: Attack Identification
- *"A user on VLAN 10 sends DTP frames that cause their access port to become a trunk port. What is this attack called?"* → **Switch Spoofing** (also called VLAN Trunk Protocol exploitation)
- **Trick**: Don't confuse this with double tagging—switch spoofing uses DTP negotiation; double tagging uses stacked 802.1Q headers.

### Question Type 2: Defense Mechanisms
- *"Which command prevents a switch port from automatically becoming a trunk?"* → **`switchport nonegotiate`** (combined with explicit `switchport mode access` or `switchport mode trunk`)
- **Trick**: Just setting `switchport mode access` isn't enough if DTP is still enabled—you need both the mode AND nonegotiate.

### Question Type 3: Scenario-Based
- *"An attacker gains access to multiple VLANs by sending two VLAN tags in a single frame. The switch removes the outer tag. Which attack is this?"* → **Double Tagging / 802.1Q Exploit**
- **Trick**: Double tagging doesn't require DTP negotiation—it works even on properly configured ports because it exploits the tag-stripping behavior.

---

## Common Mistakes

### Mistake 1: Confusing Switch Spoofing with Double Tagging
**Wrong**: "Switch spoofing and double tagging are the same attack—both bypass VLAN boundaries."
**Right**: Switch spoofing exploits [[DTP]] to negotiate a trunk connection, while double tagging exploits the way switches strip and forward 802.1Q tags. They're different mechanisms with different defenses.
**Impact on Exam**: You'll miss questions asking "which is prevented by disabling DTP?" (answer: switch spoofing only).

### Mistake 2: Assuming All VLAN Hopping Requires a Router
**Wrong**: "VLAN hopping can't happen because there's no router between the VLANs."
**Right**: VLAN hopping bypasses the need for a router by creating a [[Layer 2]] path where one shouldn't exist.
**Impact on Exam**: Questions testing whether you understand that VLAN boundaries are a Layer 2 concept, not Layer 3.

### Mistake 3: Not Recognizing the Native VLAN Risk
**Wrong**: "The native VLAN is just a default—it doesn't affect security."
**Right**: If an attacker uses double tagging and sends an untagged frame (native VLAN), it bypasses tag-based filtering. Additionally, using VLAN 1 as native VLAN amplifies double-tagging attacks.
**Impact on Exam**: Expect questions about why best practice is to change the native VLAN to an unused VLAN number.

### Mistake 4: Thinking DTP is Inherently Bad
**Wrong**: "DTP should always be disabled on all ports."
**Right**: DTP is useful for trunk-to-trunk negotiation but dangerous on access ports. The solution is explicit port configuration (`switchport nonegotiate`), not blanket disabling.
**Impact on Exam**: Distinguish between "disable DTP" (too broad) and "force access/trunk mode explicitly" (correct answer).

---

## Related Topics
- [[VLAN]]
- [[802.1Q Tagging]]
- [[Access Port vs Trunk Port]]
- [[Dynamic Trunking Protocol]]
- [[Native VLAN]]
- [[Switch Security]]
- [[Layer 2 Attacks]]
- [[Network Segmentation]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*