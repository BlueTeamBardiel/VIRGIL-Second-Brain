---
tags: [knowledge, ccna, chapter-0]
created: 2026-04-30
cert: CCNA
chapter: 0
source: rewritten
---

# DHCP Config
**Setting up dynamic IP address distribution across multiple router networks with proper exclusions and inter-router connectivity**

---

## Router 1 Setup

### Entering Configuration Mode

**Analogy**: Think of it like unlocking your phone and opening the settings app—you need to get to the right place before you can change anything!

**Privileged EXEC Mode**: The elevated access level where you can run powerful commands
**Global Configuration Mode**: The master control panel where all router-wide settings live

```
enable
configure terminal
```

---

### Configuring the Primary Interface

**Analogy**: Imagine your router is a mailroom worker—it needs a name badge (IP address) and a desk to work at (activated interface) before it can start sorting mail!

**Interface FastEthernet 0/0**: The first network adapter connected to your primary LAN
**IP Address Assignment**: Giving the router a static identity on that network
**Interface Activation**: Powering up the connection so it can actually send and receive data

```
interface fastEthernet 0/0
ip address 192.168.1.1 255.255.255.0
no shutdown
exit
```

Key concepts: [[Static IP Configuration]], [[Interface Activation]], [[Subnet Masks]]

---

### Enabling DHCP on the First Network

**Analogy**: Picture a bouncer at a club with a VIP list—some seats are reserved (excluded addresses), and the bouncer gives out tickets (IP addresses) from the remaining pool to guests arriving!

**DHCP Excluded Addresses**: Reserved IPs that won't be handed out automatically (for routers, servers, printers)
**DHCP Pool**: The range of addresses available for dynamic assignment
**Network Definition**: Specifying which subnet this pool covers
**Default Gateway**: The exit point devices use to reach other networks

```
ip dhcp excluded-address 192.168.1.1 192.168.1.99
ip dhcp pool NETWORK1
network 192.168.1.0 255.255.255.0
default-router 192.168.1.1
exit
```

Related concepts: [[DHCP Server]], [[IP Address Pools]], [[Gateway Configuration]]

---

### Configuring the Inter-Router Link

**Analogy**: If Router 1 is New York and Router 2 is Boston, the second interface is the highway that connects them!

**Interface FastEthernet 0/1**: The second network adapter used exclusively for router-to-router communication
**Static IP on Inter-Router Link**: Each router needs its own address on this connecting network

```
interface fastEthernet 0/1
ip address 10.10.10.1 255.255.255.0
no shutdown
exit
```

Key concepts: [[Serial Links]], [[Point-to-Point Networks]], [[Router Interconnection]]

---

### Setting Up Static Routes

**Analogy**: You're posting a sign that says "To reach Network 2, take the highway toward Router 2's address!"

**Static Route**: A manually configured path telling the router how to reach distant networks
**Next-Hop Address**: The IP address of the next router in the path (10.10.10.2)
**Destination Network**: The remote network you want to reach (192.168.2.0/24)

```
ip route 192.168.2.0 255.255.255.0 10.10.10.2
```

Key concepts: [[Routing Tables]], [[Static Routing]], [[Inter-Router Communication]]

---

### Saving Configuration

**Analogy**: Like hitting "save" on your homework—otherwise it disappears when you close the laptop!

**Write Memory**: Persists all configuration changes to non-volatile storage so they survive a reboot

```
write memory
```

---

## Router 2 Setup

### Configuring the Inter-Router Interface

**Analogy**: Router 2 is the mirror image of Router 1—it's the Boston side of the New York-Boston highway!

```
enable
configure terminal
interface fastEthernet 0/0
ip address 10.10.10.2 255.255.255.0
no shutdown
exit
```

Key concepts: [[Reciprocal Configuration]], [[Link Establishment]]

---

### Configuring the Secondary Network Interface

**Analogy**: Now Router 2 gets its own office space on its local network, just like Router 1 did!

```
interface fastEthernet 0/1
ip address 192.168.2.1 255.255.255.0
no shutdown
exit
```

---

### Enabling DHCP on the Second Network

**Analogy**: Router 2 becomes the DHCP bouncer for its own club (Network 2), with its own VIP list and ticket booth!

```
ip dhcp excluded-address 192.168.2.1 192.168.2.99
ip dhcp pool NETWORK2
network 192.168.2.0 255.255.255.0
default-router 192.168.2.1
exit
```

---

### Setting Up Reverse Static Routes

**Analogy**: Router 2 posts its own sign: "To reach Network 1, go toward Router 1 at 10.10.10.1!"

```
ip route 192.168.1.0 255.255.255.0 10.10.10.1
```

Key concepts: [[Bidirectional Routing]], [[Symmetric Routes]]

---

### Saving Configuration

```
write memory
```

---

## Connectivity Verification

### Testing Path Between Networks

**Analogy**: Sending a test package through the mail to make sure the mail routes between both distribution centers correctly!

**Ping Command**: A diagnostic tool that sends echo requests to verify network reachability

```
ping 192.168.2.1
ping 192.168.1.1
```

| Step | Command | Expected Result |
|------|---------|-----------------|
| R1 pings R2's network | `ping 192.168.2.1` | Reply received = Success ✓ |
| R2 pings R1's network | `ping 192.168.1.1` | Reply received = Success ✓ |

Key concepts: [[ICMP]], [[Network Diagnostics]], [[Ping Command]]

---

## Exam Tips

### Question Type 1: DHCP Pool Configuration Order
- *"Which commands must you execute first when setting up DHCP on a router?"* → [[Excluded addresses]] BEFORE creating the pool
- **Trick**: Test questions sometimes present pool creation before exclusions—that's backwards! Exclusions must come first logically

### Question Type 2: Router Interface Assignment
- *"If you need R1 and R2 to communicate, what's the critical step?"* → Both routers must have IPs on the same inter-router network (10.10.10.0/24 in this case)
- **Trick**: Students forget that routers also need IPs on connecting links—they're not "magic."

### Question Type 3: Static Route Direction
- *"Router 1 has a route to 192.168.2.0. Does Router 2 automatically know how to reach 192.168.1.0?"* → **NO!** You need separate routes on each router pointing in opposite directions
- **Trick**: Routing is directional—you must configure both sides!

### Question Type 4: DHCP Exclusion Range
- *"What does excluding 192.168.1.1 to 192.168.1.99 mean?"* → Those 99 addresses will never be handed out by DHCP
- **Trick**: Exclusion ranges protect router IPs, server IPs, and printer IPs from being randomly assigned

---

## Common Mistakes

### Mistake 1: Forgetting Interface Activation

**Wrong**: Configure an IP but don't type `no shutdown`—the interface stays disabled and won't pass traffic
**Right**: Always follow IP assignment with `no shutdown` to enable the interface
**Impact on Exam**: This is a **critical failure**—it's the #1 reason new configs don't work in labs. Test questions often ask "Why can't Device A ping Device B?" Answer: Interface is down!

---

### Mistake 2: Mismatched Subnet Masks on Inter-Router Links

**Wrong**: R1 uses 255.255.255.0 on its interface while R2 uses 255.255.0.0 on its interface—they won't recognize each other
**Right**: Both sides of a link MUST use identical subnet masks for the same network
**Impact on Exam**: Exam will show a topology and ask why connectivity fails—wrong subnet mask is a classic trap answer choice

---

### Mistake 3: Creating DHCP Pool After Excluding Addresses Incorrectly

**Wrong**: Excluding 192.168.1.1 to 192.168.1.99, then creating pool for 192.168.1.100 to 192.168.1.254 (manual math = easy to mess up)
**Right**: Create exclusions for critical devices FIRST (router, important servers), then let the DHCP pool definition handle the rest automatically
**Impact on Exam**: "What range will DHCP assign?" questions trip up students who don't think through exclusions clearly

---

### Mistake 4: Forgetting Bidirectional Static Routes

**Wrong**: Configure `ip route 192.168.2.0 255.255.255.0 10.10.10.2` on R1 but forget the mirror route on R2
**Right**: Every static route needs a **return path**—R2 must know how to reach 192.168.1.0 via R1
**Impact on Exam**: One-way routes cause "asymmetric connectivity" failures—ping works one direction but not the other. This is a classic CCNA simulation scenario!

---

### Mistake 5: Saving Before Testing

**Wrong**: Type `write memory` immediately and move to the next task without verifying with `ping`
**Right**: Always test connectivity BEFORE saving to catch configuration mistakes quickly
**Impact on Exam**: In lab exams, you can't undo a bad save easily—test first, save second. Also, knowing WHAT broke is easier when you test immediately

---

## Configuration Comparison Table

| Task | Router 1 | Router 2 |
|------|----------|----------|
| **Primary Interface IP** | 192.168.1.1/24 | 192.168.2.1/24 |
| **Inter-Router IP** | 10.10.10.1/24 | 10.10.10.2/24 |
| **DHCP Excluded Range** | .1–.99 | .1–.99 |
| **DHCP Pool Network** | 192.168.1.0/24 | 192.168.2.0/24 |
| **Route to Remote Network** | 192.168.2.0 → 10.10.10.2 | 192.168.1.0 → 10.10.10.1 |
| **Default Gateway for Clients** | 192.168.1.1 | 192.168.2.1 |

---

## Related Topics
- [[DHCP Server]]
- [[Static Routing]]
- [[Interface Configuration]]
- [[IP Address Planning]]
- [[Routing Tables]]
- [[Network Segmentation]]
- [[ICMP and Ping]]
- [[Subnet Masks]]
- [[Gateway Configuration]]
- [[Bidirectional Communication]]
- [[CCNA]]
- [[Cisco CLI]]

---

*Source: CCNA 200-301 Study Notes | Rewritten from GNS3 lab configuration | [[CCNA]] | [[Routing]]* 🎓