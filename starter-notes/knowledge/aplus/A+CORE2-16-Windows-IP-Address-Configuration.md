---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 16
source: rewritten
---

# Windows IP Address Configuration
**Master the three ways your computer gets an address: automatic, manual, or emergency fallback.**

---

## Overview

Every device you connect to a network needs an identity—an [[IP Address]]—just like every house needs a street address for mail delivery. Windows machines can obtain these addresses through three different mechanisms, and understanding which one your system is using (and when) is critical for A+ troubleshooting. This topic covers how modern operating systems achieve network connectivity with minimal user intervention, and what happens when that automation fails.

---

## Key Concepts

### Dynamic Host Configuration Protocol (DHCP)

**Analogy**: Think of DHCP like a hotel check-in desk. When you arrive, the clerk automatically assigns you a room number, tells you where the elevator is, and when you need to check out. You don't have to negotiate or remember details—it just happens. If you leave and come back later, you might get a different room, and that's perfectly fine.

**Definition**: [[DHCP]] is a network service that automatically assigns [[IP Address|IP addresses]] and other critical network configuration parameters ([[Subnet Mask]], [[Default Gateway]], [[DNS]] servers) to devices when they connect to a network. The DHCP server leases these addresses for a limited time period.

| Feature | DHCP |
|---------|------|
| **Configuration** | Automatic |
| **User Input** | None required |
| **Address Permanence** | Temporary (leased) |
| **Default on Most Systems** | Yes |
| **Common in** | Home networks, coffee shops, corporate offices |

**Why it matters**: This is the *default* behavior on virtually every modern operating system. A+ techs need to know how to verify DHCP is working and troubleshoot when it fails.

---

### Static IP Address Configuration

**Analogy**: A static IP is like owning a house with a permanent address. No matter how many times you come and go, your address never changes. The postal service always knows exactly where to find you.

**Definition**: A [[Static IP Address]] is manually configured network settings that remain constant every time the device boots. The administrator must manually specify the [[IP Address]], [[Subnet Mask]], and [[Default Gateway]].

| Aspect | Static | DHCP |
|--------|--------|------|
| **Setup Method** | Manual entry | Automatic assignment |
| **Consistency** | Always the same | May change with lease renewal |
| **Best For** | Servers, printers, network devices | Workstations, mobile devices |
| **Configuration Complexity** | Higher | Lower |

**Where you'll configure it**:

```
Windows: Settings → Network & Internet → Change Adapter Options 
         → Right-click NIC → Properties → IPv4 Properties
         
OR via Command Line:
netsh interface ipv4 set address name="Ethernet" static 192.168.1.100 255.255.255.0 192.168.1.1
```

---

### APIPA (Automatic Private IP Addressing)

**Analogy**: APIPA is your computer's emergency backup plan. When the hotel desk is closed and you can't check in, you just pick an empty room yourself and leave yourself a note on the door. You can communicate with others who did the same thing in nearby rooms, but you can't call the front desk or contact people outside the building.

**Definition**: [[APIPA]] (also called [[Link-Local Address|link-local addressing]]) is an automatic fallback mechanism that assigns an IP address in the range **169.254.1.0 to 169.254.254.255** when a device cannot reach a [[DHCP]] server and no static address is configured.

**Critical limitation**: APIPA addresses can only communicate on the *local network segment*. They cannot route across the internet or to other subnets—they're isolated by design.

**Recognizing APIPA in the wild**:

```
ipconfig /all

Example output showing APIPA assignment:
   IPv4 Address . . . . . . . . . . : 169.254.44.87
   Subnet Mask . . . . . . . . . . : 255.255.0.0
   Default Gateway . . . . . . . . : (blank)
   → This is APIPA. Something went wrong.
```

| IP Range | Subnet Mask | Usability | Scope |
|----------|-------------|-----------|-------|
| 169.254.1.0 – 169.254.254.255 | 255.255.0.0 | Local only | Same network segment only |
| 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 | Varies | Local or routable | Depends on configuration |

---

### DHCP Address Reservation

**Analogy**: A reservation is like calling the hotel in advance and asking them to always hold room 215 for you. It's automatic (you don't have to manually assign it), but it's permanent (you always get the same room).

**Definition**: [[DHCP Reservation]] is a feature where the DHCP server is configured to always issue the same IP address to a specific device (identified by its [[MAC Address]]), even though the address is technically being assigned dynamically.

**Why use it**: You get the convenience of DHCP (no manual configuration on the device) while maintaining a consistent, known address (useful for servers, printers, or network equipment).

**Setup location**: Administered on the DHCP server itself, not on the client device.

---

### Required Parameters for Static Configuration

When manually assigning an address, you *must* provide three values:

| Parameter | Example | Purpose |
|-----------|---------|---------|
| **IP Address** | 192.168.1.50 | Identifies the device on the network |
| **Subnet Mask** | 255.255.255.0 | Defines which devices are on "this" network vs. remote networks |
| **Default Gateway** | 192.168.1.1 | Router address; where packets go when destined for other networks |

Optional but important:
- [[DNS]] servers (for hostname resolution)
- [[WINS]] servers (legacy name resolution in older Windows environments)

---

## Exam Tips

### Question Type 1: Identifying Configuration Problems

- *"A user plugs in their laptop at a new office and cannot access network resources. Running* `ipconfig` *shows the IP 169.254.88.12. What happened?"* → DHCP server is unreachable or offline; device fell back to APIPA.
  - **Trick**: Answers mentioning a "network cable problem" might be partially correct, but the real issue is specifically the absence of a DHCP server or DHCP service failure.

- *"You need a print server to always have the IP address 192.168.1.200. Which configuration method is best?"* → Static IP configuration OR DHCP reservation (both valid; reservation is often preferred if DHCP server supports it).
  - **Trick**: Don't assume you *must* use static configuration; DHCP reservation is equally valid and more manageable long-term.

### Question Type 2: Address Range Recognition

- *"Which IP range indicates an APIPA address has been assigned?"* → 169.254.x.x
  - **Trick**: Memorize this range cold. Questions may show multiple addresses and ask you to identify which is APIPA. Common wrong answer: 169.253.x.x or 169.255.x.x (off by one).

### Question Type 3: Command-Line Verification

- *"You need to verify a Windows workstation's current IP configuration. Which command provides the most complete output?"* → `ipconfig /all`
  - **Trick**: `ipconfig` alone shows less detail; `/all` is required to see DNS servers, DHCP lease information, and MAC addresses.

---

## Common Mistakes

### Mistake 1: Confusing APIPA with Network Failure

**Wrong**: "My device has an APIPA address, so the network card is broken."
**Right**: "My device has an APIPA address, which means it couldn't find a DHCP server—the card is fine, but the server or DHCP service is down."
**Impact on Exam**: You might incorrectly diagnose a hardware problem when the issue is actually a service or server configuration problem. Always test connectivity *between* local devices first; if two APIPA machines can ping each other, the card is working.

---

### Mistake 2: Thinking DHCP Reservation Requires Manual Client Configuration

**Wrong**: "To use a DHCP reservation, I have to manually configure the static IP on the device itself."
**Right**: "The device requests DHCP normally; the server reserves a specific address just for that MAC address. The device remains configured for DHCP."
**Impact on Exam**: Questions may ask the *best* way to give a printer a permanent address without administrative overhead. Reservation is the answer, not manual static configuration.

---

### Mistake 3: Forgetting the Three Required Static Parameters

**Wrong**: Configuring only an IP address and subnet mask, omitting the default gateway.
**Right**: Always provide IP address, subnet mask, AND default gateway.
**Impact on Exam**: A device might appear to have connectivity on its local segment but fail to reach remote networks. Questions may show incomplete configurations and ask why a device can't reach a distant server.

---

### Mistake 4: Assuming DHCP is Always On

**Wrong**: "Every Windows machine uses DHCP—that's the only way to get an address."
**Right**: "DHCP is the default, but administrators can and do configure static addresses on servers and critical infrastructure."
**Impact on Exam**: Troubleshooting scenarios may involve a server or IoT device that *requires* a specific static address. Knowing when and why to use static configuration is essential.

---

## Related Topics

- [[DHCP Server Configuration and Scopes]]
- [[IP Address Classes and Private Ranges]]
- [[Subnet Mask and Network Segmentation]]
- [[Default Gateway and Routing Basics]]
- [[DNS and Name Resolution]]
- [[MAC Address (Media Access Control)]]
- [[ipconfig Command and Network Diagnostics]]
- [[Network Interface Card (NIC) Configuration]]
- [[IPv4 vs. IPv6 Configuration]]
- [[Windows Network Settings GUI]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[CompTIA A+]] | [[A+ Core 2]]*