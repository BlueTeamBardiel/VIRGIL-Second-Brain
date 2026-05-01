# Wireless LAN Configuration
**Tagline:** The only CCNA GUI-based topic—master WLC physical/logical architecture and WPA2 PSK configuration to control lightweight APs managing hundreds of clients.

## Why This Chapter Matters

[[VLAN]] configuration is unique in the CCNA exam because it requires hands-on GUI knowledge rather than command-line skills. You'll translate RF fundamentals and security protocols from earlier chapters into production configurations. Understanding [[WLC]] (Wireless LAN Controller) architecture—how it manages [[LWAP|lightweight APs]], translates 802.11 frames to Ethernet, and maps SSIDs to VLANs—is essential for modern enterprise networking.

## Core Concept: The WLC as a Translator

**Simple explanation:** A [[WLC]] is like a telephone operator. Wireless clients speak "radio language" (802.11 frames), but your wired network speaks "Ethernet language." The WLC intercepts all wireless traffic, converts it, and sends it to the right VLAN—all while keeping the APs dumb and lightweight.

**Technical detail:** In a [[split-MAC architecture]], the WLC handles:
- All Layer 2 management and security
- VLAN-to-WLAN mapping (each SSID routes to a specific VLAN)
- [[CAPWAP]] tunneling (Control and Provisioning of Wireless Access Points) for AP communication
- Client roaming between APs
- QoS enforcement

This is fundamentally different from standalone APs, where each AP independently handles all wireless functions.

## 21.1: Network Topology and Initial Setup

### The Lab Network Structure

| Component | Role | VLAN Assignment |
|-----------|------|-----------------|
| **SW1** | Switch, DHCP server, NTP server, default gateway | Hosts all three VLANs |
| **WLC1** | Wireless controller (manages AP1) | .100 on all subnets |
| **AP1** | Lightweight AP (controlled by WLC1) | Connected via CAPWAP tunnel |
| **VLAN 10** | Management (AP/controller signaling) | 192.168.1.0/24 |
| **VLAN 100** | Internal SSID data | 10.0.0.0/24 |
| **VLAN 200** | Guest SSID data | 10.1.0.0/24 |

### Critical Distinction: WLC Ports vs. AP Ports

A [[WLC]] has physical ports labeled **Port 1, Port 2**, etc. (NOT Ethernet interfaces). These ports can be:
- **Access ports** (single VLAN) — rarely used
- **Trunk ports** (multiple VLANs) — standard configuration for scalability
- **LAG members** (Link Aggregation) — provides redundancy + throughput

The [[LWAP]] connects to the switch via an **access port in the management VLAN**. All traffic (control + data) initially flows through the management VLAN, then [[CAPWAP]] tunnels separate control from data.

### Switch (SW1) Configuration

#### Step 1: Create Management, Internal, and Guest VLANs

```
SW1(config)# vlan 10
SW1(config-vlan)# name Management
SW1(config-vlan)# vlan 100
SW1(config-vlan)# name Internal
SW1(config-vlan)# vlan 200
SW1(config-vlan)# name Guest
```

#### Step 2: Configure AP1 and Management Access Ports

```
SW1(config)# interface range f0/7-8
SW1(config-if-range)# switchport mode access
SW1(config-if-range)# switchport access vlan 10
SW1(config-if-range)# spanning-tree portfast
```

**Why PortFast?** Without it, STP convergence delays device startup by ~30 seconds.

#### Step 3: Configure WLC LAG (Link Aggregation)

```
SW1(config)# interface range f0/1-2
SW1(config-if-range)# channel-group 1 mode on
SW1(config-if-range)# interface port-channel 1
SW1(config-if)# switchport mode trunk
SW1(config-if)# switchport trunk allowed vlan 10,100,200
```

**Key constraint:** Cisco WLCs support **only static LAGs** (`mode on`). LACP and PAgP are not supported. LAGs are used for redundancy and increased bandwidth—if one physical link fails, traffic continues on the other.

#### Step 4: Enable Routing and Configure SVIs (Switch Virtual Interfaces)

```
SW1(config)# ip routing
SW1(config)# interface vlan 10
SW1(config-if)# ip address 192.168.1.1 255.255.255.0
SW1(config-if)# interface vlan 100
SW1(config-if)# ip address 10.0.0.1 255.255.255.0
SW1(config-if)# interface vlan 200
SW1(config-if)# ip address 10.1.0.1 255.255.255.0
```

**Why routing?** SW1 is a [[multilayer switch]]. It acts as the default gateway for all three subnets and forwards traffic between VLANs.

#### Step 5: Configure NTP and DHCP Services

```
SW1(config)# ntp master 1

! Management VLAN pool (for APs)
SW1(config)# ip dhcp pool Management
SW1(dhcp-config)# network 192.168.1.0 255.255.255.0
SW1(dhcp-config)# default-router 192.168.1.1
SW1(dhcp-config)# option 42 ip 192.168.1.1
SW1(dhcp-config)# option 43 hex <WLC-IP-in-hex>

! Internal VLAN pool (for wireless clients)
SW1(config)# ip dhcp pool Internal
SW1(dhcp-config)# network 10.0.0.0 255.255.255.0
SW1(dhcp-config)# default-router 10.0.0.1
SW1(dhcp-config)# option 42 ip 192.168.1.1

! Guest VLAN pool
SW1(config)# ip dhcp pool Guest
SW1(dhcp-config)# network 10.1.0.0 255.255.255.0
SW1(dhcp-config)# default-router 10.1.0.1
SW1(dhcp-config)# option 42 ip 192.168.1.1
```

**Critical DHCP options:**
- **Option 42:** NTP server address (tells clients where to sync time)
- **Option 43:** Cisco vendor-specific option containing **WLC IP address** (tells LWAPs how to find their controller)

Without Option 43, LWAPs cannot discover the WLC and will remain disconnected.

---

## 21.2: WLC Physical and Logical Interfaces

### Physical Ports on a WLC

A Cisco WLC has distinct physical ports:
- **Port 1, Port 2, etc.:** Management and AP connectivity
- **Service port (optional):** Out-of-band management during initial setup
- **Console port:** For initial configuration before IP connectivity

### Logical Interfaces on a WLC

Unlike a switch, a WLC has **logical interfaces** mapped to management VLANs and client VLANs:

| Interface Type | Purpose | Example |
|---|---|---|
| **Management Interface** | WLC's own IP (for GUI/SSH/Telnet access) | vlan-id 10, IP 192.168.1.100 |
| **AP-Manager Interface** | Tunnel endpoint for CAPWAP (usually same as Management) | vlan-id 10 |
| **Virtual Interface** | Loopback-like address (used for AP mobility) | 1.1.1.1 (typically) |
| **Dynamic Interface** | Maps SSIDs to client VLANs | vlan-id 100 for Internal SSID |

**Why multiple interfaces?** The management interface lets you administer the WLC. The AP-manager interface is where [[CAPWAP]] tunnels terminate. Dynamic interfaces let each SSID route clients to different VLANs—essential for guest networks and department isolation.

---

## 21.3: WLAN Definition (Cisco Terminology)

The term **WLAN** in the WLC GUI refers to a **single SSID and its configuration**, not the entire wireless network. In the lab topology:
- **WLAN 1:** "Internal" SSID → mapped to VLAN 100
- **WLAN 2:** "Guest" SSID → mapped to VLAN 200

Each WLAN has its own:
- [[BSSID|SSID name]]
- Security settings ([[WPA]] PSK, Enterprise authentication, etc.)
- [[QoS|Quality of Service]] profile
- Interface/VLAN mapping
- Access control lists

---

## 21.4: WPA2 PSK Configuration in the WLC GUI

### WPA2 (Wi-Fi Protected Access 2) Basics

**Simple analogy:** WPA2 is like a password-protected club. Everyone who knows the pre-shared key (PSK) can join, and their traffic is encrypted.

**Technical details:**
- **802.11i standard** defines WPA2
- **PSK = Pre-Shared Key:** A passphrase (8–63 characters) shared among all clients
- **CCMP (AES):** The encryption algorithm (stronger than older TKIP)
- All frames encrypted with a shared session key derived from the PSK

### WLC GUI Configuration Steps (High-Level)

1. Access WLC GUI: `https://192.168.1.100` (Management Interface IP)
2. Navigate: **Wireless > WLANs**
3. Create new WLAN → Enter SSID name → Enable status
4. Security tab → Select **WPA2 PSK**
5. Enter passphrase (8+ characters)
6. Interface/VLAN mapping → Select Dynamic Interface mapped to target VLAN
7. Apply → Reboot APs

---

## 21.5: CAPWAP Tunnel Architecture

### What Is CAPWAP?

[[CAPWAP]] = **Control and Provisioning of Wireless Access Points**

| Aspect | CAPWAP Function |
|--------|---|
| **Port** | UDP 5246 (control) + 5247 (data) |
| **Encapsulation** | Wraps 802.11 frames into IP packets |
| **Direction** | Lightweight AP ↔ WLC (bidirectional tunneling) |
| **Authentication** | DTLS (Datagram TLS) optional encryption |
| **Roaming** | Enables seamless client handoff between APs |

### CAPWAP Tunnel Flow

```
[Wireless Client] 
    ↓ (802.11 frame)
[LWAP converts to IP packet]
    ↓ (CAPWAP tunnel via Management VLAN)
[WLC decapsulates]
    ↓ (Maps SSID → VLAN)
[Forwards to Dynamic Interface]
    ↓
[Switch routes to target VLAN]
    ↓
[Wired network / Internet]
```

**Critical:** All AP-to-WLC communication initially uses the **management VLAN** (VLAN 10 in our lab). The WLC then translates this to the appropriate client VLAN based on SSID.

---

## Lab Relevance

### Cisco IOS/WLC Commands Introduced

#### Switch Configuration (IOS)
```bash
# Create VLANs
vlan <vlan-id>
name <vlan-name>

# Configure access ports
interface range <port-range>
switchport mode access
switchport access vlan <vlan-id>
spanning-tree portfast

# Configure LAG
interface range <port-range>
channel-group <number> mode on

# Configure trunk on LAG
interface port-channel <number>
switchport mode trunk
switchport trunk allowed vlan <vlan-list>

# Enable routing
ip routing

# Configure SVIs
interface vlan <vlan-id>

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 21 | [[CCNA]]*
