---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 23
source: rewritten
---

# Linux Commands Part 2
**Master network adapter configuration and IP management from the Linux command line.**

---

## Overview

When you're managing a Linux system, you'll frequently need to inspect and modify how the machine talks to the network. The [[IP command]] is your primary tool for this job—it lets you view current network settings, toggle network interfaces on and off, and reconfigure [[IP addresses]] and [[routing tables]]. For the A+ exam, understanding how to use the `ip` command is essential because technicians must troubleshoot network connectivity issues on Linux workstations.

---

## Key Concepts

### The IP Command

**Analogy**: Think of the `ip` command like the control panel for your car's dashboard—it shows you all the vital signs of your network health and lets you adjust the settings while the car is running.

**Definition**: The [[IP command]] is a powerful Linux utility that allows administrators to view, modify, and manage [[network interfaces]], [[IP addresses]], [[routing tables]], and other network configuration parameters on the fly without requiring a system reboot.

**Primary Use Cases**:
- Display current [[network configuration]]
- Enable or disable [[network interfaces]]
- Assign new [[IP addresses]]
- Inspect [[routing tables]]
- View [[MAC address]] information
- Configure both [[IPv4]] and [[IPv6]] settings

---

### Viewing IP Configuration

**Analogy**: Using `ip address show` is like reading your mail—you're reviewing all the addresses (both physical and digital) that define where your device can be reached.

**Definition**: The `ip address` command (or `ip addr`) displays detailed information about every [[network interface]] attached to your Linux system, including assigned addresses, subnet masks, and broadcast information.

```bash
ip address
# or
ip addr
```

| Command | Purpose |
|---------|---------|
| `ip address show` | Display all interfaces and their configurations |
| `ip addr show eth0` | Show config for specific interface only |
| `ip -4 addr` | Display IPv4 addresses only |
| `ip -6 addr` | Display IPv6 addresses only |

**What You'll See**:
- **Interface names** (eth0, enp05, lo, etc.)
- **IP addresses** with [[CIDR notation]]
- **Subnet masks** (e.g., /24 means 255.255.255.0)
- **Broadcast addresses** (the address for network-wide messages)
- **MAC addresses** (physical hardware identifiers)
- **IPv6 addresses** (next-gen protocol configuration)

---

### The Loopback Interface

**Analogy**: The loopback interface is like a telephone call to yourself—it's a built-in mechanism for your computer to talk to itself for testing and internal communication.

**Definition**: The [[loopback interface]] (also called `lo`) is a virtual network device that allows a Linux system to communicate with itself. It always uses the reserved [[127.0.0.0/8]] address range, with `127.0.0.1` being the standard loopback address.

| Property | Value |
|----------|-------|
| Interface Name | `lo` |
| Default IP Address | `127.0.0.1` |
| Purpose | Local testing, internal services |
| Always Present | Yes (on all Linux systems) |
| Routable to Network | No (internal only) |

**Key Point**: The loopback address is never a real network interface—it's purely for local machine diagnostics and allowing services to communicate within the same system.

---

### Physical Network Interfaces

**Analogy**: Your physical network interface is like your mailbox on the street—it's the actual hardware where real-world network traffic enters and leaves your home.

**Definition**: [[Physical network interfaces]] (like `eth0`, `enp05`, or `ens33`) are actual hardware adapters that connect your Linux machine to a real network, carrying traffic to and from other devices.

**Naming Convention**:
- **eth** = older naming (Ethernet)
- **enp** = newer naming (PCI bus, slot format)
- **ens** = newer naming (on-board index)
- **wlan** = wireless adapters

**Typical Configuration Display**:
```
enp05: flags=UP,BROADCAST,RUNNING,MULTICAST
    inet 10.211.55.20/24 brd 10.211.55.255
    inet6 fe80::1/64 scope link
    link/ether 08:00:27:6c:ab:cd (MAC address)
```

---

### Viewing Routing Tables

**Analogy**: Your routing table is like a postal service's delivery map—it tells packets exactly which path to take based on their destination address.

**Definition**: The [[routing table]] is a data structure that tells the [[kernel]] where to send network packets based on their destination [[IP address]]. You view it using the `ip route` command.

```bash
ip route
# or
ip route show
```

**What a Route Tells You**:
- **Destination network** (where is the traffic going?)
- **Next hop** (which gateway should handle it?)
- **Interface** (which network card sends it?)
- **Metric** (how "expensive" is this route?)

---

### Configuring IP Addresses

**Analogy**: Assigning an IP address is like labeling a mailbox with your street address—you're telling the network where to find you.

**Definition**: Using the `ip address add` command, you can assign new [[IP addresses]] to an interface without editing configuration files or restarting services.

```bash
# Add an IP address to an interface
ip address add 192.168.1.100/24 dev eth0

# Remove an IP address
ip address del 192.168.1.100/24 dev eth0

# Bring interface up
ip link set eth0 up

# Bring interface down
ip link set eth0 down
```

| Task | Command | Notes |
|------|---------|-------|
| Add IP | `ip addr add 192.168.1.50/24 dev eth0` | /24 = subnet mask |
| Delete IP | `ip addr del 192.168.1.50/24 dev eth0` | Removes that specific address |
| Enable Interface | `ip link set eth0 up` | Brings adapter online |
| Disable Interface | `ip link set eth0 down` | Takes adapter offline |
| Flush All IPs | `ip addr flush dev eth0` | Removes all addresses on interface |

**Critical Detail**: Changes made with the `ip` command are **temporary** and don't survive a reboot. To make permanent changes, you must edit configuration files in `/etc/network/` or use a network manager.

---

## Exam Tips

### Question Type 1: "What Command Shows Current IP Configuration?"
- *"A technician needs to view all IP addresses assigned to a Linux workstation. Which command should they use?"* → `ip address show` or `ip addr`
- *"You want to see only IPv4 addresses on a Linux system. What's the correct syntax?"* → `ip -4 addr show`
- **Trick**: Don't confuse `ip` with older commands like `ifconfig` (deprecated) or `netstat` (different purpose). The exam emphasizes modern `ip` command usage.

### Question Type 2: "Interface Management"
- *"A network adapter on a Linux machine needs to be disabled without rebooting. Which command is correct?"* → `ip link set eth0 down`
- *"You're adding a temporary IP address for testing. What command do you use?"* → `ip address add 10.50.1.5/24 dev enp0s3`
- **Trick**: Remember that `ip link set` manages interface state (up/down), while `ip address` manages addressing. They're separate commands with different purposes.

### Question Type 3: "Loopback and Special Addresses"
- *"What is the loopback address on a Linux system?"* → `127.0.0.1`
- *"A service is listening on 127.0.0.1. Can external computers connect to it?"* → No, loopback is internal only.
- **Trick**: The loopback range is `127.0.0.0/8`, not just the single address `127.0.0.1`.

### Question Type 4: "Reading Command Output"
- *"Looking at `ip address show`, you see 'inet 192.168.1.50/24'. What does the /24 represent?"* → Subnet mask (255.255.255.0)
- *"What information can you extract from the `ip addr` output that relates to hardware?"* → MAC addresses, interface names, IPv6 addresses
- **Trick**: The exam loves asking what the `/` notation means—it's [[CIDR notation]], not division.

---

## Common Mistakes

### Mistake 1: Confusing `ip` with `ifconfig`

**Wrong**: Assuming `ifconfig` is the modern standard for Linux network configuration.

**Right**: The `ip` command has replaced `ifconfig` (deprecated). All modern Linux distributions and exam questions use `ip`.

**Impact on Exam**: You might be tempted to answer with `ifconfig eth0` when the correct answer is `ip address show eth0`. CompTIA expects you to know current best practices.

---

### Mistake 2: Assuming Changes Are Permanent

**Wrong**: Running `ip address add 10.0.0.5/24 dev eth0` and believing the address survives a reboot.

**Right**: The `ip` command makes temporary changes only. Permanent configuration requires editing `/etc/network/interfaces` (Debian/Ubuntu) or `/etc/sysconfig/network-scripts/` (Red Hat/CentOS) or using NetworkManager.

**Impact on Exam**: A question might ask where changes need to be made for persistence. If you only know the `ip` command, you'll miss the "permanent configuration file" answer.

---

### Mistake 3: Mixing Up Loopback with Regular Interfaces

**Wrong**: Thinking the loopback interface (127.0.0.1) is a real connection to your network.

**Right**: Loopback is entirely virtual and local. Real network traffic uses physical adapters like eth0 or enp05.

**Impact on Exam**: A troubleshooting scenario might show loopback traffic working but external network down. You need to recognize that one doesn't affect the other.

---

### Mistake 4: Not Understanding CIDR Notation

**Wrong**: Reading `192.168.1.0/24` and thinking "24 computers can connect."

**Right**: The `/24` is [[CIDR notation]] equivalent to subnet mask `255.255.255.0`, meaning the first 24 bits define the network.

**Impact on Exam**: Subnetting questions appear on A+, and if you can't convert `/24` to `255.255.255.0` or vice versa, you'll struggle with configuration questions.

---

### Mistake 5: Forgetting the Interface Specification

**Wrong**: Running `ip address add 192.168.1.10/24` without specifying which interface.

**Right**: Always include `dev eth0` (or whichever interface) in your command: `ip address add 192.168.1.10/24 dev eth0`

**Impact on Exam**: A command scenario might ask you to identify a syntax error. Missing the `dev` parameter is a common mistake that makes a command invalid.

---

## Related Topics

- [[IP address]] - Numeric identifiers for network devices
- [[Network interfaces]] - Hardware and virtual connection points
- [[Routing]] - How packets find their way across networks
- [[CIDR notation]] - Modern way to express subnet masks
- [[IPv4 vs IPv6]] - Version differences in the IP protocol
- [[MAC address]] - Physical hardware identifier
- [[Loopback interface]] - Virtual self-communication mechanism
- [[Network configuration files]] - Permanent storage of settings
- [[ifconfig (deprecated)]] - Older command replaced by `ip`
- [[Linux system administration]] - Broader context for network management

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+ Core 2]]*