# Dynamic Host Configuration Protocol
**Why this matters:** DHCP automates IP address assignment at scale—without it, you'd manually configure every device. CCNA heavily tests DHCP server/relay configuration, snooping attacks, and troubleshooting leases.

---

## Overview: What DHCP Does

Think of DHCP like a front-desk clerk at a hotel: guests (devices) arrive without a room number (IP address), check in, get assigned a room for a specific duration (lease), and must check out when done. The clerk doesn't own the rooms permanently—they're leased temporarily.

**More precisely:** [[Dynamic Host Configuration Protocol|DHCP]] is a Layer 7 application protocol that automatically assigns [[IPv4]] configuration parameters (IP address, subnet mask, default gateway, DNS servers) to devices. It eliminates manual configuration errors and enables device mobility.

---

## 4.1 The Basic Functions of DHCP

### Leasing an IP Address with DHCP

The DHCP process uses a four-step handshake called **DORA**:

| Step | Message | Direction | Purpose |
|------|---------|-----------|---------|
| **D**ISCOVER | DHCPDISCOVER | Client → Broadcast (255.255.255.255:67) | Client broadcasts "I need an IP address" |
| **O**FFER | DHCPOFFER | Server → Client (unicast to 255.255.255.255:68) | Server reserves an IP and sends lease terms |
| **R**EQUEST | DHCPREQUEST | Client → Broadcast (255.255.255.255:67) | Client confirms which server's offer it accepts |
| **A**CK | DHCPACK | Server → Client (unicast to 255.255.255.255:68) | Server confirms lease; client installs address |

**Key detail:** DHCP uses [[UDP]] port 67 (server) and port 68 (client). All early messages use broadcast because the client has no IP yet.

**Lease lifecycle:**
- **T1 (50% of lease):** Client sends DHCPREQUEST to renew with original server
- **T2 (87.5% of lease):** If T1 fails, client broadcasts DHCPREQUEST to any server
- **Lease expiration:** Client releases address and returns to DISCOVER state

**Example lease duration:** 8 days (typical), 1 hour (temporary networks), 24 hours (corporate)

### Cisco IOS as a DHCP Server

A router or Layer 3 switch can function as a [[DHCP]] server, assigning addresses from a local pool.

#### Configuration Syntax:

```ios
! Enable DHCP globally
ip dhcp ?

! Create and name a pool
ip dhcp pool POOL_NAME
 network 192.168.1.0 255.255.255.0
 default-router 192.168.1.1
 dns-server 8.8.8.8 8.8.4.4
 domain-name example.com
 lease 8  ! days

! (Optional) Exclude addresses from assignment
ip dhcp excluded-address 192.168.1.1 192.168.1.10
ip dhcp excluded-address 192.168.1.254

! Enable DHCP (enabled by default; disable with "no service dhcp")
service dhcp
```

#### Key Pool Parameters:
- **network 10.0.0.0 255.255.255.0** – Define assignable range
- **default-router 10.0.0.1** – Gateway (clients use this for routing)
- **dns-server 8.8.8.8** – Primary DNS
- **domain-name cisco.com** – Client DNS search domain
- **lease {days | {hours | minutes | infinite}}** – Address lease duration
- **netbios-name-server, wins-server** – Legacy Windows support

#### Verification Commands:

```ios
! View DHCP pool statistics
show ip dhcp pool

! View active leases
show ip dhcp binding

! View DHCP configuration
show ip dhcp server statistics

! Clear a specific binding (admin override)
clear ip dhcp binding 192.168.1.50

! Clear all bindings
clear ip dhcp binding *
```

**Example output interpretation:**
```
Pool                    : LAN_POOL
Utilization           : 45% (45/100 addresses used)
Subnet                : 10.0.0.0/24
First address         : 10.0.0.11
Last address          : 10.0.0.254
Excluded addresses    : 10.0.0.1-10.0.0.10
```

### Cisco IOS as a DHCP Client

A Cisco device can receive its own IP address from a DHCP server (common for WAN interfaces or management interfaces in lab environments).

#### Configuration:

```ios
! Configure an interface to use DHCP
interface GigabitEthernet 0/0
 ip address dhcp

! (Optional) Request specific DHCP options
ip dhcp client request domain-name
ip dhcp client request dns

! Verify DHCP client status
show ip dhcp client [interface]
```

#### Example output:
```
Interface       : GigabitEthernet 0/1
Address         : 192.168.100.45
Subnet Mask     : 255.255.255.0
Gateway         : 192.168.100.1
DNS Servers     : 8.8.8.8, 8.8.4.4
Lease expires   : May 15 2024 14:32:17 +00:00
Renewal (T1)    : May 12 2024 02:32:17 +00:00
Rebind (T2)     : May 14 2024 11:18:17 +00:00
```

---

## 4.2 DHCP Relay

**Problem:** DHCP discovery packets are broadcast; routers block broadcasts by default. If the DHCP server is on a different subnet/VLAN, clients can't reach it.

**Solution:** A **DHCP relay agent** (running on a router or L3 switch) listens for DHCPDISCOVER broadcasts on the local subnet, converts them to **unicast** packets, and forwards them to a DHCP server on a remote subnet.

### How DHCP Relay Works:

1. Client broadcasts DHCPDISCOVER on local subnet
2. Relay agent receives broadcast (configured on the relay's interface)
3. Relay agent replaces source IP with its own interface IP, destination becomes the DHCP server's IP
4. Server responds to relay agent (unicast)
5. Relay agent forwards response back to client (broadcast or unicast, depending on flags)

### Configuration:

```ios
! On the relay interface (toward clients)
interface VLAN 10
 ip address 10.0.10.1 255.255.255.0
 ip helper-address 10.0.0.100  ! DHCP server IP (can have multiple)
 ip helper-address 10.0.0.101  ! Secondary server (load balance)

! Verify relay configuration
show ip helper-address

! View relay statistics
debug ip dhcp server packet  ! (packet-level detail)
```

**Important:** `ip helper-address` also relays other UDP services by default ([[DNS]] 53, [[NTP]] 123, [[FTP]] 69). Use **ip forward-protocol** to customize.

---

## 4.3 Client OS IP Settings

### Windows IP Configuration

Windows devices query DHCP via:
```cmd
ipconfig              ! Display current configuration
ipconfig /all         ! Verbose (shows DNS, DHCP server, lease times)
ipconfig /release     ! Release current lease
ipconfig /renew       ! Request new lease
```

Static configuration: Settings → Network → IPv4 → Manual (or via netsh).

### macOS IP Configuration

```bash
ifconfig              ! Display configuration
ipconfig getifaddr en0  ! Get specific interface IP
sudo networksetup -setdhcp Ethernet  ! Enable DHCP
sudo networksetup -getinfo Ethernet   ! View settings
```

### Linux IP Configuration

```bash
ip addr show          ! Display all interfaces
ip link set eth0 up   ! Bring interface up
dhclient eth0         ! Request DHCP lease
dhclient -r eth0      ! Release lease
```

**Modern approach (systemd-networkd):**
```ini
# /etc/systemd/network/20-wired.network
[Match]
Name=eth0

[Network]
DHCP=yes
```

---

## Lab Relevance

### Essential Cisco IOS Commands for DHCP

| Task | Command | Purpose |
|------|---------|---------|
| Create pool | `ip dhcp pool NAME` | Define a DHCP scope |
| Network range | `network 10.0.0.0 255.255.255.0` | Assignable addresses |
| Gateway | `default-router 10.0.0.1` | Route via this IP |
| DNS | `dns-server 8.8.8.8 8.8.4.4` | Servers for name resolution |
| Domain | `domain-name example.com` | DNS search domain |
| Lease time | `lease 8` | Duration in days |
| Exclude | `ip dhcp excluded-address 10.0.0.1 10.0.0.10` | Don't assign these IPs |
| Enable DHCP | `service dhcp` | Start DHCP globally |
| Relay | `ip helper-address 10.0.0.100` | Forward DISCOVER to remote server |
| View pools | `show ip dhcp pool` | Statistics and config |
| View bindings | `show ip dhcp binding` | Active leases |
| Server stats | `show ip dhcp server statistics` | Message counters |
| Client config | `ip address dhcp` | Interface uses DHCP |
| Client status | `show ip dhcp client` | Display client lease info |

### Lab Topology Example:

```
[Client on VLAN 10: 10.0.10.0/24]
        ↓ DHCPDISCOVER (broadcast)
    [Router/Relay Agent]
        ↓ ip helper-address 10.0.0.100 (converted to unicast)
[DHCP Server on VLAN 1: 10.0.0.0/24]
```

---

## Exam Tips

### What CCNA Tests on DHCP:

1. **DORA sequence:** Know the exact order and which messages are broadcast vs. unicast.
   - **Trick question:** "Which DHCPDISCOVER response uses unicast?" → **None.** DHCPOFFER is unicast to 255.255.255.255:68 (limited broadcast), not to the client's new IP (client doesn't have it yet).

2. **Lease timers:** T1 at 50%, T2 at 87.5%.
   - **Example:** 8-day lease → T1 at day 4, T2 at day 7.
   - Know renewal behavior: T1 (unicast to server), T2 (broadcast if T1 fails).

3. **DHCP relay configuration:**
   - Must be on the relay agent's **interface toward clients** (not toward server).
   - Multiple `ip helper-address` commands load-balance requests.
   - **Trap:** `ip helper-address` is per-interface, not global.

4. **Configuration ordering matters:**
   - **Wrong:** `ip dhcp pool NAME` → `ip dhcp excluded-address` (excluded-address must come BEFORE pool definition)
   - **Correct:** `ip dhcp excluded-address` → `ip dhcp pool NAME` → `network` → parameters

5. **Port numbers:**
   - Server listens on [[UDP]] port **67**
   - Client listens on [[UDP]] port **68**
   - Exam may ask: "Which port does a DHCP client send requests to?" → Port 67.

6. **DHCP vs. static addressing trade-offs:**
   - DHCP: scalable, mobile-friendly, automatic
   - Static: predictable, suitable for servers and network gear
   - Exam scenario: "Which should you use for the gateway?" → Static or reserved DHCP (DHCP reservation).

7. **DHCP relay in multilayer switches:**
   - A switch with IP routing enabled can relay DHCP between VL

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 4 | [[CCNA]]*
