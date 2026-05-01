---
tags: [knowledge, ccna, chapter-11]
created: 2026-04-30
cert: CCNA
chapter: 11
source: rewritten
---

# 11. VLANs  
**This chapter explains how to split a switch into virtual domains, configure access and trunk ports, and enable routing between those domains.**

---

## Network Segmentation

### What This Chapter Covers

**Analogy**: Imagine a huge office building where everyone shares the same hallway; anyone shouting (broadcasting) reaches every floor.  
**VLAN**: A way to partition a single physical switch into multiple logical switches, each acting like its own hallway that stops unwanted shouts.

### Network Segmentation Overview

**Analogy**: Think of a city with different neighborhoods separated by roads; each neighborhood has its own local traffic.  
**Segmentation**: The practice of dividing a network into smaller, more manageable sections for security, performance, and traffic control.  
| Layer | Primary Tool | What it controls | Example |
|-------|--------------|------------------|---------|
| 2     | **VLAN**     | Broadcast domains | A local department network |
| 3     | Subnetting   | IP‑level routing  | Inter‑department routing |

### Why VLANs Are Necessary

**Analogy**: A single open office with no cubicles—every conversation is heard by everyone, causing chaos.  
**Broadcast domain**: The area in which broadcast frames are flooded; all devices in a VLAN share one.  
**Layer 2 isolation**: Without VLANs, all hosts live in the same broadcast domain, hurting security and scalability.

### Layer 3 Segmentation with Subnets

**Analogy**: Different ZIP codes allow mail to be routed to specific regions.  
**Subnet**: A range of IP addresses assigned to a specific department; traffic between subnets requires a router.  
**Router**: The device that enforces security policies between subnets.  
**Broadcast flood**: Even with subnets, a switch still floods broadcast frames across all ports.

### Layer 2 Segmentation with VLANs

**Analogy**: Each department gets its own office building; no one can enter another’s premises without permission.  
**VLAN**: Segments a switch into multiple virtual switches; each VLAN is a distinct broadcast domain.  
**Switch behavior**: Frames are forwarded only within the same VLAN unless routed.  
**CCNA rule**: One subnet per VLAN (1:1 mapping) is recommended.

---

## VLAN Configuration

### VLAN Example

**Analogy**: Assigning room numbers to each department’s office.  
| VLAN ID | Department | Subnet |
|---------|------------|--------|
| 10      | Engineering | 172.16.1.0/26 |
| 20      | HR           | 172.16.1.64/26 |
| 30      | Sales        | 172.16.1.128/26 |

### Viewing VLANs on a Switch

**Analogy**: Checking a directory that lists all employees and their office rooms.  
**CLI**: `show vlan brief` – displays the VLAN database and port membership.  
**CLI**: `show mac address-table` – shows the VLAN association for learned MAC addresses.

```text
Switch# show vlan brief
VLAN Name                             Status    Ports
---- -------------------------------- --------- -------------------------------
1    default                          active    Gi0/1, Gi0/2
10   Engineering                      active    Gi0/3, Gi0/4
20   HR                               active    Gi0/5, Gi0/6
30   Sales                            active    Gi0/7, Gi0/8
```

### VLAN Ranges

**Analogy**: The numbering system for office rooms; certain numbers are reserved for special purposes.  
| VLAN ID | Status |
|---------|--------|
| 0       | Reserved |
| 1‑1001  | Usable   |
| 1002‑1005 | Reserved for legacy tech |
| 1006‑4094 | Usable |
| 4095    | Reserved |

### Creating and Managing VLANs

**Analogy**: Adding a new room to the building.  
| Command | Purpose |
|---------|---------|
| `vlan 10` | Create VLAN 10 |
| `name Engineering` | Optional: assign a human‑readable name |
| `shutdown` | Disable VLAN 10 |
| `no shutdown` | Enable VLAN 10 |
| `no vlan 10` | Delete VLAN 10 |

```text
Switch(config)# vlan 10
Switch(config-vlan)# name Engineering
Switch(config-vlan)# no shutdown
Switch(config-vlan)# exit
```

### Access Ports

**Analogy**: A single hallway that only serves one office; employees can enter without any special keys.  
**Access port**: A port that belongs to a single VLAN and carries untagged frames.  
**CLI**:  
```text
Switch(config)# interface GigabitEthernet0/3
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 10
```
Assigning a port to a non‑existent VLAN automatically creates it.

### Trunk Ports

**Analogy**: A multi‑floor elevator that transports people (frames) between different office floors (VLANs).  
**Trunk port**: Carries traffic for multiple VLANs using tags.  
**Tagging protocol**: IEEE 802.1Q.

| Feature | Detail |
|---------|--------|
| Frame tag | 4 bytes (TPID + TCI) |
| TPID | 0x8100 (identifies 802.1Q) |
| TCI | PCP, DEI, VID (12‑bit VLAN ID) |
| Max VLANs | 4096 |

### ISL (Cisco Inter‑Switch Link)

**Analogy**: An older elevator system that wraps the entire person in a blanket (frame encapsulation).  
**ISL**: Cisco‑proprietary trunking protocol; now deprecated due to extra overhead.  

### Configuring Trunk Ports

**Analogy**: Setting up the elevator to handle specific floors.  
| Switch type | Commands |
|-------------|----------|
| ISL + 802.1Q | `switchport trunk encapsulation dot1q`<br>`switchport mode trunk` |
| 802.1Q only | `switchport mode trunk` |

**Verification**: `show interfaces trunk`

```text
Switch# show interfaces trunk
Port        Mode         Encapsulation  Status
Gi0/1       trunk        dot1q          connected
```

### Allowed VLANs on Trunks

**Analogy**: Deciding which floors an elevator can stop at.  
| Command | Effect |
|---------|--------|
| `switchport trunk allowed vlan 10,20,30` | Only VLANs 10, 20, 30 |
| `switchport trunk allowed vlan add 40` | Add VLAN 40 |
| `switchport trunk allowed vlan remove 30` | Remove VLAN 30 |
| `switchport trunk allowed vlan all` | All VLANs (1‑4094) |
| `switchport trunk allowed vlan none` | No VLANs allowed |
| `switchport trunk allowed vlan except 1-9,11-19` | All except listed ranges |

> **Trick**: Forgetting the `add` keyword replaces the whole list.

### Native VLAN

**Analogy**: The default hallway that an elevator uses when no specific floor is requested; traffic in this hallway is untagged.  
**Native VLAN**: The VLAN whose frames travel untagged on a trunk.  
**Default**: VLAN 1.  
**Change**: `switchport trunk native vlan 999` – use an unused VLAN to effectively disable the native VLAN.  
> **Important**: The native VLAN must match on both ends of the trunk.

---

## Inter‑VLAN Routing Overview

**Analogy**: Separate inter‑office corridors that allow people from different buildings (VLANs) to meet.  
**Inter‑VLAN routing**: Required to allow traffic between VLANs; methods include a dedicated router, a Router on a Stick (ROAS), or a multilayer switch.

### Router on a Stick (ROAS)

**Analogy**: A single mail carrier (router) delivering messages to each building (VLAN) using numbered letters (subinterfaces).  
| Step | Details |
|------|---------|
| Physical link | Trunk between switch and router |
| Subinterfaces | `interface GigabitEthernet0/0.10` |
| Tagging | `encapsulation dot1q 10` |
| IP | `ip address 172.16.1.1 255.255.255.192` |
| Physical interface | No IP address; only serves as trunk |
| MAC | All subinterfaces share the same MAC address |

```text
Router(config)# interface GigabitEthernet0/0
Router(config-if)# no ip address
Router(config-if)# exit
Router(config)# interface GigabitEthernet0/0.10
Router(config-subif)# encapsulation dot1q 10
Router(config-subif)# ip address 172.16.1.1 255.255.255.192
```

### Native VLAN on ROAS

**Analogy**: The mail carrier sending untagged letters for the default building.  
**Option 1**: `encapsulation dot1q vlan-id native` on the subinterface.  
**Option 2**: Assign the native VLAN’s IP address directly to the physical interface.

---

## Exam Tips

### Question Type 1: Configuration Commands  
- *"What command would you use to assign VLAN 20 to port Gi0/5?"* → `switchport access vlan 20`  
- **Trick**: Some questions will mix up `switchport access vlan` with `switchport trunk allowed vlan`; remember the former sets the access VLAN.

### Question Type 2: Trunk Verification  
- *