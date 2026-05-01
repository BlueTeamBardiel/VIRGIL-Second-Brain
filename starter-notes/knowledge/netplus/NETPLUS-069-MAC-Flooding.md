---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 069
source: rewritten
---

# MAC Flooding

**A layer 2 attack that overwhelms a switch's memory by filling its MAC address table with bogus entries, forcing the switch into a fail-open state.**

---

## Overview

[[MAC flooding]] is a deliberate attack against [[Ethernet]] [[switches]] where an attacker sends thousands of fake [[MAC addresses]] to exhaust the switch's internal memory. This matters for Network+ because it's a fundamental [[layer 2]] vulnerability that can turn a normally intelligent switch into a dumb hub, exposing all traffic on a [[VLAN]]. Understanding this attack helps you recognize when network behavior becomes abnormal and why MAC filtering alone isn't sufficient security.

---

## Key Concepts

### MAC Address Basics
**Analogy**: Think of a MAC address like a house address on a street—it's the physical location identifier, whereas an IP address is like a person's name. Your switch needs the house address to deliver mail locally.

**Definition**: A [[Media Access Control (MAC) address]] is the 48-bit hardware identifier burned into every [[network interface card (NIC)]]. It's displayed in hexadecimal format using six octets separated by colons (e.g., `8C:2D:AA:4B:98:A7`).

| Component | Length | Purpose |
|-----------|--------|---------|
| [[OUI]] (Organizationally Unique Identifier) | 3 bytes | Manufacturer code |
| NIC-specific value | 3 bytes | Device serial number |

---

### MAC Address Table (CAM Table)
**Analogy**: Imagine a postal worker with a notebook recording which neighbor lives on which side of a street. The switch does exactly this with MAC addresses and ports.

**Definition**: The [[Content Addressable Memory (CAM) table]] is where the [[switch]] records which [[MAC addresses]] it has seen and which physical [[ports]] they're associated with. This table has a finite size—typically 8,000 to 16,000 entries.

**Storage Location**: Burned into the device's [[read-only memory (ROM)]]

---

### MAC Flooding Attack Mechanism
**Analogy**: Like someone mailing thousands of letters to random house numbers until the postal worker's address book overflows and becomes useless.

**Definition**: An attacker uses tools to generate and send massive numbers of [[Ethernet frames]] with forged source [[MAC addresses]]. Each frame causes the switch to add a new entry to its CAM table. Once the table fills completely, the switch must handle new frames—and this is where the vulnerability activates.

**Attack Flow**:
```
Attacker generates frames with spoofed MACs
    ↓
Switch updates CAM table for each new address
    ↓
CAM table fills to capacity
    ↓
Switch enters fail-open state
    ↓
Unknown destination frames flood all ports (except source)
    ↓
All traffic becomes visible to attacker
```

---

### Fail-Open State
**Analogy**: A security guard who, after their clipboard is full, just opens all doors instead of checking credentials.

**Definition**: When a [[switch]] cannot find a destination [[MAC address]] in its exhausted CAM table, it defaults to [[flooding]] the frame to every port on the [[VLAN]] (except the incoming port). This transforms the switch into a [[hub]]—a completely transparent device—temporarily defeating [[VLAN]] segmentation.

| Normal Behavior | Flooded State |
|-----------------|---------------|
| Known MAC → forward to specific port | Unknown MAC → forward to all ports |
| Intelligent forwarding | Broadcast-like behavior |
| Traffic isolation maintained | All traffic visible everywhere |

---

### Traffic Sniffer Advantage
**Analogy**: Normally the mailman only delivers to your house; during a flood, all mail goes everywhere, and you can read your neighbor's letters.

**Definition**: Once the switch floods traffic, an attacker with a [[packet sniffer]] can capture sensitive data ([[credentials]], [[PII]], unencrypted communications) from other devices on the same physical segment, even if they're on different logical [[VLANs]].

---

## Exam Tips

### Question Type 1: Attack Identification
- *"A network administrator notices all devices on a switch are receiving traffic destined for other machines. What type of attack most likely caused this?"* → **MAC flooding**
  - **Trick**: Don't confuse with [[ARP spoofing]] (layer 3/2.5) or [[VLAN hopping]]—MAC flooding is specifically about exhausting the CAM table

### Question Type 2: Mitigation Recognition
- *"Which feature prevents MAC flooding attacks?"* → **[[Port Security]]** (MAC address limits per port) or **[[Dynamic ARP Inspection (DAI)]]**
  - **Trick**: MAC filtering alone won't stop this—you need rate limiting or address limits

### Question Type 3: Symptom Recognition
- *"Users report seeing network traffic from other departments. What's the most likely cause?"* → MAC flooding → Layer 2 segmentation compromised → implement [[port security]]
  - **Trick**: Symptoms sound like a [[VLAN]] leak, but the cause is CAM table exhaustion

---

## Common Mistakes

### Mistake 1: Confusing MAC Flooding with VLAN Hopping
**Wrong**: "MAC flooding breaks VLAN isolation the same way VLAN hopping does."
**Right**: MAC flooding overwhelms the switch's memory; [[VLAN hopping]] exploits tagging protocols. Both result in cross-VLAN traffic, but the mechanisms are completely different.
**Impact on Exam**: You might select the wrong mitigation—[[port security]] stops MAC flooding; [[VLAN]] trunk port hardening stops hopping.

### Mistake 2: Thinking the Attack Requires Special Hardware
**Wrong**: "You need expensive network equipment to flood a switch."
**Right**: Any laptop can run a MAC flooding tool (like `macof` or similar). The attacker just needs access to a [[switch port]].
**Impact on Exam**: Questions emphasizing physical access matter—MAC flooding is an insider threat that doesn't require remote access.

### Mistake 3: Assuming Switches Always Protect CAM Tables
**Wrong**: "Modern switches have protection built in by default."
**Right**: [[Port security]] must be **manually configured**; it's not enabled by default on most enterprise switches.
**Impact on Exam**: Questions ask what "should be configured"—the answer is manual [[port security]] with sticky MAC learning or maximum MAC limits.

---

## Mitigation Strategies

### Port Security (Primary Defense)
```
Cisco IOS Example:
interface gi0/1
  switchport mode access
  switchport port-security
  switchport port-security maximum 2
  switchport port-security mac-address sticky
  switchport port-security violation shutdown
```

**How it works**: Limits the number of unique [[MAC addresses]] per port. If exceeded, the port shuts down or enters restricted mode.

### Rate Limiting / Storm Control
**Definition**: Monitors the rate of frames with unknown destination [[MAC addresses]] and drops excess frames before CAM table saturation occurs.

---

## Related Topics
- [[Ethernet Switching]]
- [[CAM Table (Content Addressable Memory)]]
- [[Port Security]]
- [[VLAN Hopping]]
- [[ARP Spoofing]]
- [[Dynamic ARP Inspection (DAI)]]
- [[Layer 2 Attacks]]
- [[Network Segmentation]]
- [[Packet Sniffing]]

---

*Source: CompTIA Network+ N10-009 Study Materials | [[Network+]]*