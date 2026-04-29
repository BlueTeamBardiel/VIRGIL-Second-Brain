# Cisco Discovery Protocol and Link Layer Discovery Protocol
**Why it matters:** Network discovery is your first step toward understanding topology—you can't manage what you can't see. CDP and LLDP let you map your network automatically and troubleshoot connectivity issues without manual documentation.

---

## Overview

[[Cisco Discovery Protocol]] (CDP) and [[Link Layer Discovery Protocol]] (LLDP) are neighbor discovery protocols that allow network devices to advertise information about themselves to directly connected neighbors. They operate at [[Layer 2]] (Data Link Layer) and are essential for network mapping, troubleshooting, and device inventory.

**Simple analogy:** Think of CDP/LLDP like devices calling out to their neighbors, saying "Hey, I'm here! Here's what I am." It's how your switch learns about the router plugged into it without any manual configuration.

---

## ## Cisco Discovery Protocol (CDP)

### What is CDP?

[[CDP]] is a Cisco proprietary protocol that allows Cisco devices to discover and share information with directly connected devices. It runs at Layer 2 and requires no network layer configuration—it works immediately after a device powers on.

**Key characteristics:**
- Proprietary to Cisco (not standardized)
- Works on most Cisco devices (routers, switches, IP phones, printers)
- Enabled by default on most Cisco IOS devices
- Uses multicast MAC address `01:00:0c:cc:cc:cc`
- Sends advertisements every 60 seconds by default
- Information is held in CDP cache for 180 seconds (3 minutes) before timing out

### What Information Does CDP Share?

Each CDP advertisement contains:
- **Device ID** — hostname of the neighboring device
- **Port ID** — the interface the advertisement came from
- **Capabilities** — what the device can do (router, switch, IP phone, etc.)
- **Platform** — hardware model (e.g., Catalyst 2960, ISR4331)
- **Software version** — IOS version running on the device
- **IP addresses** — management IP addresses configured on the device
- **Duplex mode** — half or full duplex on that interface
- **VTP domain** — VLAN Trunking Protocol domain name (if applicable)

### Viewing CDP Information

#### Viewing CDP Neighbors
The most common command to see discovered neighbors:

```
Device# show cdp neighbors
```

Output format:
```
Capability Codes: R - Router, B - Bridge, H - Host, I - IP Phone, S - Switch
Device ID    Local Intrfce    Holdtme   Capability    Platform    Port ID
Router-1     Fas 0/1          120       R             C2900       Fas 0/0
Switch-2     Fas 0/2          140       S             C3560       Fas 0/1
IP-Phone-1   Fas 0/3          150       H             CP-7941     Port 1
```

- **Device ID** — hostname of neighbor
- **Local Interface** — your interface receiving CDP advertisement
- **Holdtime** — seconds before this entry expires (counts down)
- **Capability** — type of device
- **Platform** — model number
- **Port ID** — neighbor's interface sending the advertisement

#### Detailed CDP Information

```
Device# show cdp neighbors detail
```

Provides complete information including:
- IP addresses
- Software versions
- Duplex settings
- Native VLAN information
- Management IP addresses

### Mapping a Network with CDP

CDP is valuable for network discovery without manual intervention:

1. Connect to a device
2. Run `show cdp neighbors` to see direct connections
3. SSH/Telnet to each neighbor
4. Repeat process to build network diagram

**Example workflow:**
```
Switch-Core# show cdp neighbors
Device ID: Access-Switch-1
Port: Fas 0/1

Device ID: Access-Switch-2  
Port: Fas 0/2

[Connect to Access-Switch-1]
Access-Switch-1# show cdp neighbors
Device ID: Host-PC-1
Port: Fas 0/1

[Continue until topology is mapped]
```

### Configuring and Verifying CDP

#### Enabling/Disabling CDP Globally

```
Device(config)# cdp run                    ! Enable CDP globally
Device(config)# no cdp run                 ! Disable CDP globally
```

#### Enabling/Disabling CDP on Specific Interfaces

```
Device(config)# interface FastEthernet 0/1
Device(config-if)# cdp enable              ! Enable on this interface
Device(config-if)# no cdp enable           ! Disable on this interface
```

#### Adjusting CDP Timer Values

```
Device(config)# cdp timer 45                ! Change update interval (default 60 sec)
Device(config)# cdp holdtime 120            ! Change holdtime (default 180 sec)
```

#### Verification Commands

```
Device# show cdp                           ! Shows CDP status and timers
Device# show cdp neighbors                 ! List neighbors (summary)
Device# show cdp neighbors detail          ! List neighbors (detailed)
Device# show cdp entry Router-1            ! Details on specific neighbor
Device# show cdp interface FastEthernet 0/1 ! CDP status on interface
```

---

## ## Link Layer Discovery Protocol (LLDP)

### What is LLDP?

[[LLDP]] is the standardized, vendor-neutral alternative to [[CDP]]. Defined in IEEE 802.1AB, LLDP allows devices from different manufacturers to discover each other. Many modern networks run both CDP and LLDP for maximum compatibility.

**Key characteristics:**
- IEEE 802.1AB standard (open/non-proprietary)
- Works across multi-vendor environments
- Uses multicast MAC address `01:80:c2:00:00:0e`
- Disabled by default on most Cisco devices (must enable manually)
- Sends advertisements every 30 seconds by default
- Information is held for 120 seconds (2 minutes) before timing out
- Can optionally gather additional information via **LLDP-MED** (Media Endpoint Discovery)

### LLDP vs. CDP Comparison

| Feature | CDP | LLDP |
|---------|-----|------|
| **Standard** | Cisco proprietary | IEEE 802.1AB |
| **Multicast MAC** | 01:00:0c:cc:cc:cc | 01:80:c2:00:00:0e |
| **Default State** | Enabled | Disabled |
| **Update Interval** | 60 seconds | 30 seconds |
| **Holdtime** | 180 seconds | 120 seconds |
| **Vendor Support** | Cisco devices | Multi-vendor |
| **LLDP-MED** | N/A | Optional media info |
| **VTP Domain Info** | Yes | No |
| **Power over Ethernet Info** | No | Yes (via LLDP-MED) |

### Configuring and Verifying LLDP

#### Enabling/Disabling LLDP Globally

```
Device(config)# lldp run                   ! Enable LLDP globally
Device(config)# no lldp run                ! Disable LLDP globally
```

#### Enabling/Disabling LLDP on Specific Interfaces

```
Device(config)# interface FastEthernet 0/1
Device(config-if)# lldp transmit           ! Enable LLDP transmission
Device(config-if)# lldp receive            ! Enable LLDP reception
Device(config-if)# no lldp transmit        ! Disable transmission
Device(config-if)# no lldp receive         ! Disable reception
```

**Note:** By default, LLDP transmits and receives on all interfaces once globally enabled. You can selectively disable on specific interfaces if needed.

#### Adjusting LLDP Timer Values

```
Device(config)# lldp timer 45              ! Update interval (default 30 sec)
Device(config)# lldp holdtime 240          ! Holdtime (default 120 sec)
Device(config)# lldp reinit 2              ! Delay before reinitializing (default 2 sec)
```

#### Verification Commands

```
Device# show lldp                          ! LLDP status and configuration
Device# show lldp neighbors                ! List neighbors (summary)
Device# show lldp neighbors detail         ! List neighbors (detailed)
Device# show lldp entry Switch-1           ! Details on specific neighbor
Device# show lldp interface FastEthernet 0/1 ! LLDP status on interface
Device# show lldp traffic                  ! LLDP protocol statistics
```

### Viewing LLDP Neighbor Output

**Summary format (`show lldp neighbors`):**
```
Local Intf    Chassis ID        Port ID    System Name
Fa0/1         aabb.cc00.0100    Fa0/2      Access-Switch-1
Fa0/2         aabb.cc00.0200    Fa0/1      Core-Switch-1
Fa0/24        aabb.cc00.0300    e0         IP-Phone
```

**Detailed format (`show lldp neighbors detail`):**
```
Local Intf: Fa0/1
Chassis ID: aabb.cc00.0100
System Name: Access-Switch-1
Port ID: Fa0/2
Port Description: Access Switch Port
Capabilities: B, R (Bridge, Router)
System Description: Cisco Catalyst 2960...
Management Address: 192.168.1.10
IEEE 802.1 pvid: 1
Media Attachment Unit type: Unknown
Power Draw: 15.4 Watts [PoE]
```

---

## ## Practical Differences and Use Cases

### When to Use CDP
- Pure Cisco environments (all Cisco devices)
- Need VTP domain information
- Legacy devices that don't support LLDP
- Troubleshooting Cisco-specific issues

### When to Use LLDP
- Multi-vendor networks (Cisco, Juniper, Arista, etc.)
- Need Power over Ethernet information
- Need standards compliance
- Compatibility with third-party network monitoring tools

### Best Practice: Run Both
Most production networks enable both CDP and LLDP simultaneously:
- CDP provides Cisco-specific intelligence
- LLDP ensures compatibility with non-Cisco devices
- No performance impact from running both
- Maximum visibility into network topology

---

## ## Lab Relevance

These are the exact commands you'll use in hands-on labs:

| Task | Command | Purpose |
|------|---------|---------|
| **Discover neighbors** | `show cdp neighbors` | View directly connected devices |
| **Get full details** | `show cdp neighbors detail` | Complete device information |
| **Enable CDP** | `cdp run` | Global CDP activation |
| **Disable CDP** | `no cdp run` | Global CDP deactivation |
| **Enable on interface** | `cdp enable` | Per-interface CDP control |
| **Disable on interface** | `no cdp enable` | Disable CDP on single port |
| **Set CDP timer** | `cdp timer 45` | Adjust advertisement frequency |
| **Set CDP holdtime** | `cdp holdtime 120` | Neighbor entry lifespan |
| **Check CDP status** | `show cdp` | Verify global settings |
| **Enable LLDP** | `lldp run` | Global LLDP activation |
| **Enable LLDP per-interface** | `lldp transmit` / `lldp receive` | Per-interface LLDP control |
| **View LLDP neighbors** | `show lldp neighbors [detail]` | LLDP neighbor discovery |
| **Check LLDP status** | `show lldp` | Verify LLDP configuration |
| **LLDP timers** | `lldp timer 45` / `lldp holdtime 240` | Adjust LLDP intervals |

### Common Lab Scenarios

**Scenario 1: Network Topology Discovery**
```
1. SSH to core switch
2. show cdp neighbors (identify access switches)
3. Repeat from each access switch to find end devices
4. Build network diagram from output
```

**Scenario 2: Troubleshooting Connectivity**
```
1. show cdp neighbors detail on local device
2. Verify expected neighbor appears
3. Check IP addresses and platform match expected topology
4

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 1 | [[CCNA]]*