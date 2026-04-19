# Quality of Service (QoS)
**Why it matters:** Networks have limited bandwidth. QoS lets you prioritize voice and video traffic so real-time communications don't degrade when the network gets congested—without QoS, a video call drops while someone downloads a file.

---

## Overview: The Problem QoS Solves

Think of network bandwidth like a highway. During rush hour, if everyone treats their trip equally, emergency vehicles get stuck in traffic too. QoS is the traffic system that lets ambulances and police cars use dedicated lanes so they get through faster.

**The reality:** Some traffic is time-sensitive (voice calls, video conferences) and breaks apart when delayed or lost. Other traffic (email, file downloads) tolerates delays fine. When congestion happens, QoS ensures voice/video get the highway's fast lane while bulk data uses the local roads.

---

## 10.1: IP Telephony (VoIP)

### The Shift from POTS to IP Phones

**Traditional world:** Companies ran two separate networks—phone cables to the [[PSTN]] (Public Switched Telephone Network) and Ethernet cables for computers. This meant running two cables to every desk.

**Modern world:** [[VoIP]] (Voice over IP) phones are just special computers that send voice as IP packets over the same Ethernet network as everything else. Cost savings + advanced features (voicemail-to-email, call routing software integration) made companies switch.

**The infrastructure problem:** Two devices per desk now needed one switch port each. Solution: IP phones include a tiny 3-port internal switch—one port to the main switch, one to the PC, one to the phone's internals.

---

### 10.1.1 Voice VLANs

**The concept (simple version):** Put voice traffic and data traffic in separate VLANs so QoS policies can identify and prioritize each type independently.

**The technical detail:** Normally, an [[access port]] belongs to exactly one VLAN. But voice VLAN is a special exception:
- **Data traffic** → Sent untagged in the access VLAN (e.g., VLAN 10)
- **Voice traffic** → Sent tagged with 802.1Q in the voice VLAN (e.g., VLAN 20)

This separation enables QoS to say: "Any frame with voice VLAN tag gets high priority."

| Aspect | Data Traffic | Voice Traffic |
|--------|-------------|---------------|
| VLAN | 10 (Access VLAN) | 20 (Voice VLAN) |
| Tagging | Untagged (native) | Tagged (802.1Q) |
| Sensitivity | Tolerates delay | Real-time, needs low latency |
| Typical subnet | 192.168.10.0/24 | 192.168.20.0/24 |

**Configuration Example:**
```
SW1(config)# interface range f0/1-3
SW1(config-if-range)# switchport mode access
SW1(config-if-range)# switchport access vlan 10
SW1(config-if-range)# switchport voice vlan 20
SW1(config-if-range)# do show interfaces f0/1 switchport
```

**Key observation:** The `show interfaces f0/1 switchport` output shows:
- `Administrative Mode: static access` ← Still considered an access port
- `Access Mode VLAN: 10 (VLAN0010)`
- `Voice VLAN: 20 (VLAN0020)` ← Dual VLAN membership

---

### 10.1.2 Power over Ethernet (PoE)

**The concept (simple version):** Instead of running separate power cables to IP phones, send electricity through the same Ethernet cable that carries data. The switch becomes a power supply.

**How it works physically:** Power (low frequency) and data (high frequency) use different frequency ranges on the same twisted pair, so they don't interfere. One pair carries data; another pair carries power.

| Role | Device | Function |
|------|--------|----------|
| [[PSE]] (Power Sourcing Equipment) | Network switch | Supplies power over Ethernet cable |
| [[PD]] (Powered Device) | IP phone, IP camera, WAP, badge reader | Receives power over Ethernet cable |

**Benefits:**
- No separate power cables to each desk
- Fewer wall outlets needed
- Devices can be placed anywhere (ceiling-mounted cameras, hallway WAPs)
- Lower installation cost

**Power Safety: The PoE Handshake**

A PSE cannot blindly send power—it could damage non-PoE devices or send too much power to a device. The process is:

1. **Detection** → PSE applies low voltage to test if device supports PoE
2. **Classification** → PSE measures the device's power class and allocates watts accordingly
3. **Startup** → PSE supplies appropriate voltage to boot the device
4. **Normal operation** → PSE delivers steady power and monitors current for safety

**PoE Standards (Power Classes):**

| Class | Power Budget | Typical Use |
|-------|--------------|------------|
| Class 1 | 3.84W | Badge readers, simple sensors |
| Class 2 | 6.49W | Door locks, access points |
| Class 3 | 15.4W | IP phones (most common) |
| Class 4 | 30W | High-power IP phones, some cameras |
| Class 5 | 45W | PTZ cameras, high-power devices |

**Monitoring PoE Status:**

```
SW1# show power inline
Available:124.0(w) Used:30.8(w) Remaining:93.2(w)

Interface Admin Oper   Power   Device           Class Max
                       (Watts)
--------- ------ ------ ------- --------------- ----- ----
Fa0/1     auto   on     15.4    IP Phone        3     30
Fa0/2     auto   on     15.4    IP Phone        3     30
Fa0/3     auto   off    0.0     (none)          —     —
```

**Command to enable PoE on a port:**
```
SW1(config)# interface f0/1
SW1(config-if)# power inline auto
```

The `auto` keyword means the switch auto-detects if the device is PoE-capable. Other options: `on` (always send power) or `off` (no power).

---

## 10.2: Quality of Service (QoS) Fundamentals

**The core problem:** When links become congested, which packets get dropped or delayed? Without QoS, it's random (FIFO—first-in-first-out). With QoS, you control it.

**QoS is not about creating bandwidth**—it's about intelligently managing the bandwidth you have during congestion.

### QoS Components: Classification, Marking, Queuing, Policing, Shaping

These are the five "tools" in your QoS toolkit, collectively called **Per-Hop Behavior (PHB)**:

#### 1. **Classification** – Identifying Traffic

**Purpose:** Recognize which packets belong to which traffic type.

**Method:** Inspect packet headers for:
- Source/destination IP address
- Source/destination port (80 for HTTP, 443 for HTTPS, etc.)
- Protocol (IP, TCP, UDP)
- DSCP marking (explained below)
- VLAN ID (e.g., voice VLAN 20 = voice traffic)

**Example:** "All packets from the 192.168.20.0/24 subnet (our voice VLAN) are voice traffic."

#### 2. **Marking** – Tagging Packets with Priority

**Purpose:** Add priority information to packets so downstream devices know how to treat them.

**Methods:**

| Method | Field | Bits | Range | Purpose |
|--------|-------|------|-------|---------|
| [[ToS]] (Type of Service) | IP Header | 8 | 0–255 | Old way, rarely used |
| [[DSCP]] (Differentiated Services Code Point) | ToS field (upper 6 bits) | 6 | 0–63 | Standard marking; defines priority level |
| [[CoS]] (Class of Service) | 802.1Q tag (in VLAN header) | 3 | 0–7 | Switch port priority |

**DSCP Values (Most Common):**

| DSCP Name | DSCP Value | Use Case |
|-----------|-----------|----------|
| BE (Best Effort) | 0 | Normal data traffic |
| CS1 | 8 | Low-priority data |
| AF11 | 10 | Assured Forwarding, lowest |
| AF21 | 18 | Assured Forwarding, medium |
| AF31 | 26 | Assured Forwarding, high |
| EF (Expedited Forwarding) | 46 | Voice/video (highest priority) |
| CS6 | 48 | Control traffic |

**Key concept:** DSCP EF (46) = "This is voice—treat it with high priority." DSCP BE (0) = "This is bulk data—drop me if needed."

#### 3. **Queuing** – Choosing Which Packets to Forward First

**Purpose:** When the outgoing link is full, which packet leaves next—the voice packet or the email download?

**Without QoS:** FIFO (First-In-First-Out) queue—whichever arrived first goes first.

**With QoS:** Multiple queues with different priorities.

**Common Queueing Disciplines:**

| Method | How It Works | Best For |
|--------|-------------|----------|
| **FIFO** | First packet in = first packet out | No prioritization |
| **PQ** (Priority Queueing) | High-priority queue always empties before low-priority queue | Voice always goes before data |
| **WFQ** (Weighted Fair Queuing) | Each traffic class gets a percentage of bandwidth (voice 40%, data 60%) | Fair resource distribution |
| **CBWFQ** (Class-Based WFQ) | Admin defines traffic classes and allocates bandwidth to each | Most flexible; real deployments use this |

**Real example:** Suppose F0/1 is congested. The switch has:
- Queue 1 (High): Voice packets (DSCP 46) → Empties first
- Queue 2 (Medium): Important data (DSCP 18) → Empties second
- Queue 3 (Low): Best effort (DSCP 0) → Empties last (may drop packets)

#### 4. **Policing** – Enforcing Rate Limits

**Purpose:** Ensure no single traffic type consumes more than its fair share, even if it's marked as high-priority.

**How it works:** If a traffic class exceeds its configured rate, the policer drops packets (or remarksmarxes them to a lower priority).

**Example:** "VoIP is marked as high-priority, but if any single IP phone uses more than 128 kbps, drop the excess packets."

**Policer actions on violating packets:**
- **Drop** → Delete the packet (harsh but effective)
- **Remark** → Change DSCP to a lower value (downgrade priority)

#### 5. **Shaping** – Smoothing Traffic Bursts

**Purpose:** Buffer excess packets instead of dropping them, releasing them at a controlled rate.

**Key difference from policing:**
- **Policing:** Drops packets that exceed the rate
- **Shaping:** Queues packets and releases them at the allowed rate (introduces delay instead of loss)

**When to use:**
- **Policing:** On ingress (incoming traffic); enforce hard limits
- **Shaping:** On egress (outgoing traffic); smooth bursty traffic

**Example:** "If this link can only handle 2 Mbps, queue any packets exceeding 2 Mbps and send them at exactly 2 Mbps instead of dropping them."

---

## QoS Policy Workflow

```
[Packet arrives] 
    ↓
[1. Classification] → "This is voice" (DSCP should be 46)
    ↓
[2. Marking] → Mark DSCP 46 if not already marked
    ↓
[3. Policing] → If voice > 128 kbps, drop excess
    ↓
[4. Queuing] → Put in high-priority queue
    ↓
[5.

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 10 | [[CCNA]]*
