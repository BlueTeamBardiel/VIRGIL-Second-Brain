---  
tags: [knowledge, ccna, chapter-6]  
created: 2026-04-30  
cert: CCNA  
chapter: 6  
source: rewritten  
---  

# 6. IPv4 Addressing  
**A lively walk through every facet of IPv4 addressing, from the bite-sized dots to the router’s heart.**  

---  

## What an IPv4 Address Is  

### IPv4 Address Structure  

**Analogy**: Think of an IPv4 address as a library card: it has four numbered sections that together give a unique identity to every book (or device).  

**IPv4 Address**: A [[32‑bit]] logical identifier used at [[Layer 3]] (Network layer) to distinguish hosts and networks. It appears as four 8‑bit octets written in dotted‑decimal notation (e.g., `192.168.1.10`). Each octet can range from `0` to `255` (`00000000` to `11111111` in binary).  

---  

## Network vs Host Portion  

### Identifying the Subnet and the Device  

**Analogy**: Imagine a multi‑story apartment building: the building number is the network, while the unit number is the host.  

**Network Portion**: The part of the address that specifies the entire building (subnet). All devices in the same subnet share this part.  

**Host Portion**: The part that distinguishes each apartment (device) within that building. It must be unique inside the subnet.  

Both parts are determined by the [[subnet mask]] or [[prefix length]] (`/X`).  

| Example | Address | Network | Host |
|---|---|---|---|
| `192.168.1.10/24` | 192.168.1.10 | 192.168.1.0 | .10 |

---  

## Prefix Length & Subnet Mask  

### How Bits Become Networks  

**Analogy**: Picture a long ribbon cut into a headband (network bits) and a tail (host bits). The length of the headband is the prefix length.  

**Prefix Length (/X)**: Number of leading `1` bits in the subnet mask that define the network.  

**Subnet Mask**: A 32‑bit value with contiguous `1`s followed by `0`s.  
- `1` bits represent the network portion.  
- `0` bits represent the host portion.  

| Prefix | Subnet Mask |
|---|---|
| `/8` | `255.0.0.0` |
| `/16` | `255.255.0.0` |
| `/24` | `255.255.255.0` |

*Invalid masks* like `255.0.255.0` break the contiguous rule and cannot be used.  

---  

## Network, Broadcast, and Usable Addresses  

### The Boundary Lines of a Subnet  

**Analogy**: In a classroom, the front row is the “network address,” the last row is the “broadcast address,” and all the seats in between are the usable seats for students.  

**Network Address**: All host bits are `0`. It identifies the subnet itself and cannot be assigned to a host.  

**Broadcast Address**: All host bits are `1`. It sends data to every host in the subnet and also cannot be assigned.  

**Usable Host Addresses**: All addresses strictly between the network and broadcast addresses.  

**Formula**: `Usable hosts = 2^host_bits – 2`  

| Prefix | Network | Broadcast | Usable Range | Usable Count |
|---|---|---|---|---|
| `/24` | `192.168.1.0` | `192.168.1.255` | `192.168.1.1`‑`192.168.1.254` | 254 |

---  

## First & Last Usable Address  

### Where Devices Prefer to Sit  

**Analogy**: The router often takes the front seat (first usable address) because it’s the easiest spot to reach the rest of the building.  

**First Usable Address**: Network address + 1.  

**Last Usable Address**: Broadcast address – 1.  

Typical practice: assign the router’s interface the first usable address of its subnet.  

---  

## Maximum Hosts by Prefix  

### How Many Guests Fit in the Building  

| Prefix | Host Bits | Max Hosts |
|---|---|---|
| `/8` | 24 | `2^24 – 2 = 16,777,214` |
| `/16` | 16 | `2^16 – 2 = 65,534` |
| `/24` | 8 | `2^8 – 2 = 254` |
| `/30` | 2 | `2^2 – 2 = 2` (point‑to‑point links) |

---  

## IPv4 Address Classes (Legacy)  

### The Old School “Letter” System  

**Analogy**: Think of a mailing system that used first letters to determine the destination region, though modern mail now uses ZIP codes (CIDR).  

| Class | First Bits | First Octet Range | Default Prefix | Typical Use |
|---|---|---|---|---|
| A | `0` | `1–126` | `/8` | Very large networks |
| B | `10` | `128–191` | `/16` | Medium networks |
| C | `110` | `192–223` | `/24` | Small networks |
| D | `1110` | `224–239` | — | Multicast |
| E | `1111` | `240–255` | — | Experimental |

*Special Ranges*  
- `0.0.0.0/8` – Reserved for special use.  
- `127.0.0.0/8` – Loopback addresses (e.g., `127.0.0.1`).  

Classful addressing is obsolete; modern networks use [[CIDR]] (Classless Inter-Domain Routing).  

---  

## Router Interfaces & IPv4  

### Why Routers Talk Layer 3  

**Analogy**: A router is like a post office that must know which building each letter is heading to; it cannot forward every letter indiscriminately (no broadcast forwarding).  

- Routers operate at [[Layer 3]].  
- Each router interface belongs to a distinct subnet.  
- Interfaces are **shutdown** by default; you must enable them with `no shutdown`.  
- Routers do **not forward broadcast packets**.  

---  

## Router Interface Configuration (Cisco IOS)  

### Setting Up the Post Office  

**Pre‑Verification**  

```text
show ip interface brief
```

Shows interface name, IP, method, status, and protocol. Interfaces start as **administratively down**.  

**Configuring Interfaces**  

```text
enable
configure terminal
interface g0/0
 ip address 192.168.1.1 255.255.255.0
 no shutdown
interface g0/1
 ip address 192.168.2.1 255.255.255.0
 no shutdown
```

- `interface g0/0` → enters interface configuration mode.  
- `ip address` assigns the IPv4 address and netmask.  
- `no shutdown` brings the interface up.  
- You can switch between interfaces without leaving config mode.  

---  

## Interface Status Meanings  

**Analogy**: A gate can be physically open or closed, and the guard can be on duty or off duty. Both must be ready for traffic.  

| Status | Meaning |
|---|---|
| `up` | Physical link present |
| `down` | No physical link |
| `administratively down` | Manually disabled |

| Protocol | Meaning |
|---|---|
| `up` | Layer 2 functioning |
| `down` | Layer 2 failure |

Both status and protocol must show `up/up` for the interface to carry data.  

---  

## Final Verification  

**Check the Work**  

```text
show ip interface brief
```

Confirms IP addresses and interface states (netmask not displayed). For full details:  

```text
show ip interface g0/0
```

Displays IP address, prefix, broadcast (`255.255.255.255` local broadcast), MTU (default 1500 bytes).  

---  

## Saving Configuration  

**Analogy**: Like saving a document before closing the computer; otherwise, all changes vanish on reboot.  

```text
write
write memory
copy running-config startup-config
```

Any of these commands will persist the running configuration to startup.  

---  

## IPv4 Header (High‑Yield)  

### The Envelope That Travels the Network  

| Field | Description |
|---|---|
| **Size** | 20–60 bytes, 14 fields |
| **Version** | `4` (IPv4) |
| **IHL** | Header length in 4‑byte words (minimum 5 → 20 bytes) |
| **DSCP / ECN** | Quality‑of‑service tags |
| **Total Length** | Header + payload size |
| **Identification / Flags / Fragment Offset** | Fragmentation control |
| **TTL** | Time‑to‑live; decremented each hop, packet discarded at 0 |
| **Protocol** | Payload type: `ICMP` = 1, `TCP` = 6, `UDP` = 17, `OSPF` = 89 |
| **Header Checksum** | Error‑checking for header only |
| **Source / Destination IP** | Addresses of sender and receiver |
| **Options** | Rarely used, can add special instructions |

---  

## Binary & Number Systems (Exam‑Critical)  

**Analogy**: Think of binary as a series of lights that are either on (`1`) or off (`0`).  

- Decimal = base 10.  
- Binary = base 2.  
- 8‑bit max value = `255`.  

Binary place values:  
`128 64 32 16 8 4 2 1`  

Example conversion:  
`10001111` = `128 + 8 + 4 + 2 + 1 = 143`.  

---  

## Subnet Quick Mental Math  

**Analogy**: Calculating the front and back doors of a building—add or subtract `1` to find the usable seats.  

- Network address = host bits all `0`.  
- Broadcast address = host bits all `1`.  

---  

## Exam Tips  

### Question Type 1: Subnetting  
- *“What is the first usable host address for `10.0.0.0/8`?”* → `10.0.0.1`  
- **Trick**: Don’t forget that the network address ends in `.0` and the broadcast ends in `.255`.  

### Question Type 2: Router Configuration  
- *“Which command will enable an interface?”* → `no shutdown`  
- **Trick**: `shutdown` and `no shutdown` are opposites; a common typo is to type `shut` instead of `shutdown`.  

---  

## Common Mistakes  

### Mistake 1: Mixing Network and Host Bits  
- **Wrong**: Assuming the first octet of `192.168.1.0/24` is the host portion.  
- **Right**: In `/24`, the first three octets are the network; only the last octet is the host.  
- **Impact on Exam**: Mis‑calculating usable hosts or selecting wrong addresses leads to failed configuration questions.  

---  

## Related Topics  

- [[CIDR]]  
- [[OSPF]]  

---  

*Source: CCNA 200‑301 Study Notes | [[CCNA]]*