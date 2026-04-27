# Router and Switch Interfaces
**Master the physical layer: configure speed, duplex, and interface properties that determine whether your network actually works**

## Why This Chapter Matters

Interfaces are the literal connection points between devices. A misconfigured interface—wrong speed, wrong duplex setting, or missing description—can cripple network connectivity in ways that are deceptively hard to troubleshoot. This chapter teaches you to configure, verify, and troubleshoot the physical foundation of every network.

---

## Core Concepts

### Interface Basics: The Simple Version First

Think of a network interface like a telephone jack. You need to:
1. Plug it in (physical connection)
2. Set the volume level (speed)
3. Decide if both people talk at once or take turns (duplex)
4. Label it so you remember which room it's in (description)

**The detailed version:** A network interface is the hardware and software combination that connects a device to the network. Every interface has configurable properties that determine how fast data flows through it and whether data can flow in both directions simultaneously.

---

## Interface Configuration Fundamentals

### Interface Identification

Interfaces are named in the format: `TYPE SLOT/PORT`

**Common interface types:**
- `Ethernet 0/0` – Fast Ethernet (100 Mbps)
- `GigabitEthernet 0/0` – Gigabit Ethernet (1000 Mbps)
- `Serial 0/0` – Serial WAN interface (legacy)
- `FastEthernet 0/1` – 100 Mbps interface

On modern devices, [[Cisco IOS]] assumes `Ethernet` means the first available speed type.

### Interface Descriptions

A **description** is a human-readable label for an interface, crucial for real-world network documentation.

**Simple analogy:** It's like labeling cables in a data center. When you see a port labeled "Link to Toronto office" instead of just "Gi0/0," troubleshooting becomes 10× faster.

**Why descriptions matter:**
- Reduces human error when making changes
- Documents the purpose of each interface
- Identifies connected devices/locations at a glance
- Required in most production environments

### Speed Configuration

**Speed** determines how fast data travels through an interface.

| Speed Type | Mbps | Modern Status |
|---|---|---|
| Ethernet | 10 | Obsolete |
| Fast Ethernet | 100 | Legacy |
| Gigabit Ethernet | 1,000 | Standard |
| 10 Gigabit Ethernet | 10,000 | High-speed |

Speed must match between connected devices. A gigabit interface connecting to a Fast Ethernet interface will negotiate down to 100 Mbps (or cause errors if [[Autonegotiation]] fails).

### Duplex Configuration

**Duplex** describes whether data can flow in both directions simultaneously.

**Simple analogy:** Think of a one-lane road that traffic can flow both ways, versus a two-lane highway where traffic flows in both directions simultaneously.

| Duplex Mode | Data Flow | Collision Risk | Use Case |
|---|---|---|---|
| Half-duplex | One direction at a time | High | Old shared media (hub-based networks) |
| Full-duplex | Both directions simultaneously | None | Modern point-to-point links |

**Full-duplex** is the standard for modern networks because devices communicate point-to-point over dedicated links (not shared hubs). When both devices can transmit simultaneously, there's no collision possibility.

**Half-duplex** was common when network segments were shared (hubs). If two devices transmitted at the same time, their signals would collide and both would have to retransmit. This mechanism is handled by [[CSMA/CD]] (Carrier Sense Multiple Access with Collision Detection) at Layer 2.

---

## Autonegotiation Explained

### How Autonegotiation Works

[[Autonegotiation]] is an automatic negotiation process where two connected interfaces exchange information about their capabilities and agree on the best speed and duplex settings.

**The process:**
1. Each interface advertises its supported speeds (10, 100, 1000, etc.)
2. Each interface advertises its supported duplex modes (half, full)
3. Devices agree on the fastest speed both support
4. Devices agree on full-duplex if both support it

**Autonegotiation is enabled by default** on most modern Cisco equipment.

### Why Autonegotiation Can Fail

Autonegotiation relies on both devices sending special control frames ([[Fast Link Pulse]] on older interfaces, [[Next Page]] messages on newer ones). If:
- One device has autonegotiation disabled
- One device doesn't support a particular speed
- Cable quality is poor

...then autonegotiation fails and the device reverts to default speeds (often 10 Mbps half-duplex on older equipment).

### Manual Speed and Duplex Configuration

While autonegotiation is usually reliable, enterprise networks often manually configure speed and duplex for predictability and to prevent negotiation failures.

**Commands:**

```
Router(config-if)# speed 1000
Router(config-if)# duplex full
Router(config-if)# no speed auto
Router(config-if)# no duplex auto
```

**Best practice:** Manually set speed AND duplex to matching values on both ends of a link, or let autonegotiation handle both. Never mix manual and auto (e.g., manual speed 1000 with auto duplex)—this causes duplex mismatches.

---

## Interface Errors and Troubleshooting

### Speed Mismatches

A **speed mismatch** occurs when connected interfaces operate at different speeds.

**Symptoms:**
- Intermittent connectivity
- Slow throughput
- Packet loss on that link
- Devices can communicate but at reduced speed

**Example mismatch scenarios:**

| Device A | Device B | Result | Data Rate |
|---|---|---|---|
| Manual: 1000 full | Auto: negotiates 100 | Mismatch | 100 Mbps |
| Auto: supports 1000 | Manual: 100 | Negotiates down | 100 Mbps |
| Auto disabled, defaults to 10 | Auto: 1000 | Severe mismatch | 10 Mbps |

**Troubleshooting:**
```
Router# show interfaces gigabitethernet 0/0
GigabitEthernet0/0 is up, line protocol is up
  Hardware is iGbE, address is cafe.babe.0001
  Internet address is 192.168.1.1 255.255.255.0
  MTU 1500 bytes, BW 1000000 Kbit/sec    ← Shows 1000 Mbps negotiated
  Encapsulation ARPA, loopback not set
  Keepalive set (10 sec)
  Full-duplex, 1000Mb/s
```

Look at the last line: if it shows `100Mb/s` and you expected 1000, you have a speed mismatch.

### Duplex Mismatches

A **duplex mismatch** occurs when one interface operates in full-duplex and the other in half-duplex.

**Why this is dangerous:**

- **Half-duplex device** expects to detect collisions and retransmit
- **Full-duplex device** assumes no collisions and never retransmits failed frames
- Result: **late collisions** and frame loss on the half-duplex side

**Symptoms of duplex mismatch:**
- One direction of communication works fine
- Other direction has packet loss and retransmissions
- Asymmetric performance (PC → Server works, Server → PC fails)
- Increasing collision and CRC error counters on half-duplex side
- Appears random and difficult to diagnose

**Example:**
```
Switch(config-if)# duplex full    ← Set to full-duplex
Router(config-if)# duplex half    ← Set to half-duplex
```

Now traffic from Switch → Router flows fine. But Router → Switch traffic experiences collisions because the Router's half-duplex logic expects collisions that never come (the Switch doesn't look for them).

**Verification:**
```
Switch# show interfaces fastethernet 0/1 | include duplex
Full-duplex, 100Mb/s

Router# show interfaces fastethernet 0/0 | include duplex
Half-duplex, 100Mb/s
```

Clear mismatch. Fix by setting both to `duplex full` or letting autonegotiation handle it.

---

## Lab Relevance: Essential Cisco IOS Commands

### Interface Navigation

```
Router# configure terminal
Router(config)# interface gigabitethernet 0/0
Router(config-if)# 
```

Enter interface configuration mode.

### Assigning Description

```
Router(config-if)# description Link to Core Switch
```

Adds a human-readable label to the interface.

### Configuring Speed

```
Router(config-if)# speed 1000
Router(config-if)# speed 100
Router(config-if)# speed auto
```

Set interface speed explicitly or enable autonegotiation.

### Configuring Duplex

```
Router(config-if)# duplex full
Router(config-if)# duplex half
Router(config-if)# duplex auto
```

Set duplex mode or enable autonegotiation.

### Disabling Autonegotiation

```
Router(config-if)# no speed auto
Router(config-if)# no duplex auto
```

Disable automatic negotiation for manual control.

### Enabling/Disabling Interface

```
Router(config-if)# no shutdown
Router(config-if)# shutdown
```

Bring interface up or down. **Default is `shutdown`** (disabled) on most Cisco devices.

### Verifying Interface Status

```
Router# show interfaces gigabitethernet 0/0
Router# show interfaces brief
Router# show interfaces status
Router# show interfaces description
```

Display detailed interface information, summary view, administrative status, or descriptions only.

### Clearing Interface Statistics

```
Router# clear counters
Router# clear counters gigabitethernet 0/0
```

Reset error counters to troubleshoot baseline.

---

## Exam Tips: What CCNA Tests

### Specific Tricky Questions

1. **Duplex mismatch asymmetry:** The exam will ask which direction of traffic fails in a duplex mismatch (always the half-duplex → full-duplex direction). Know why: the half-duplex device waits for collision signals that never arrive.

2. **Autonegotiation failure defaults:** When autonegotiation fails on older equipment, it defaults to 10 Mbps half-duplex—a critical fact for troubleshooting scenarios.

3. **Manual vs. auto mixing:** The exam tests whether you know that mixing manual speed with auto duplex (or vice versa) causes mismatch problems. **Never do this.**

4. **Speed negotiation down:** When interfaces with different max speeds autonegotiate (e.g., 1000 and 100), they negotiate **down** to the slowest speed both support (100 Mbps in this case).

5. **Interface names on different platforms:** Cisco uses different naming conventions (e.g., `Ethernet 0/0` vs `Gi0/0` vs `Fa0/1`). The exam may show commands on unfamiliar platform names to test whether you understand the concept, not just memorization.

6. **Show command interpretation:** Be ready to read `show interfaces` output and identify:
   - Whether the interface is up/down
   - Current speed and duplex
   - Error counts indicating problems
   - Description content

### Common Exam Scenario

*A network technician manually configures one end of a link to `speed 1000` and `duplex full`, but the other end is left on autonegotiation. What happens?*

**Correct answer:** The autonegotiation side will advertise its capabilities, but since one side isn't listening, both sides may negotiate to different speeds or duplex modes, OR they may lock into a working speed (usually 100 Mbps full-duplex on modern equipment) through a fallback mechanism.

---

## Common Mistakes

### Mistake 1: Assuming "up" Means Working

```
Router# show interfaces gigabitethernet 0/0
GigabitEthernet0/0 is up, line protocol is up
```

**Don't assume this means the interface is correctly configured.** "Up, up

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 8 | [[CCNA]]*
