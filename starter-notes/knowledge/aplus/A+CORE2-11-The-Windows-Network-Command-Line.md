---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 11
source: rewritten
---

# The Windows Network Command Line
**Master command-line diagnostics to unlock any network mystery on Windows systems.**

---

## Overview

Network problems are everywhere—slow connections, apps that won't launch, devices that mysteriously vanish from the network. Before you can fix anything, you need visibility into *how* a Windows machine is actually configured. The [[ipconfig]] command is your diagnostic flashlight: it reveals the IP addressing scheme, [[subnet mask]], [[gateway]], [[DNS]] settings, and adapter details that make networks tick. On the A+ exam, you'll need to know how to read this output and spot configuration problems instantly.

---

## Key Concepts

### IPConfig Command

**Analogy**: Think of `ipconfig` like checking your home's address label and mail routing info. Just as you'd verify your street address, ZIP code, and which post office handles your mail, `ipconfig` shows your computer's network address, subnet boundaries, and where packets should be routed.

**Definition**: A Windows command-line utility that displays the current [[TCP/IP]] configuration of all network adapters on the local machine, including [[IPv4]] addresses, [[IPv6]] addresses, [[subnet mask]]s, [[default gateway]]s, and [[DHCP]] server information.

```
C:\> ipconfig
```

| Variant | Purpose | Example Use |
|---------|---------|-------------|
| `ipconfig` | Basic configuration display | Quick overview of active adapters |
| `ipconfig /all` | Detailed configuration with DNS, DHCP, MAC address, lease info | Complete diagnostic snapshot |
| `ipconfig /release` | Surrender current [[DHCP]] lease | Force new IP assignment |
| `ipconfig /renew` | Request fresh [[DHCP]] address | Resolve IP conflicts |

---

### Network Adapter Information

**Analogy**: Your network adapter is like your mailbox—it's the physical/logical interface where all your network "mail" arrives and departs. Just as you'd check if your mailbox is mounted properly and accessible, you'd verify your adapter is active and correctly configured.

**Definition**: The [[network interface card]] (NIC) or [[network adapter|virtual adapter]] that handles all data transmission to/from the network, whether wired ([[Ethernet]]) or wireless ([[Wi-Fi]]).

`ipconfig` reveals:
- Adapter type and name
- Physical address ([[MAC address]])
- Connection status (connected/disconnected)
- [[IPv4]] and [[IPv6]] assignments

---

### DHCP vs. Static Configuration

**Analogy**: [[DHCP]] is like a temp agency handing out random office assignments each day—your computer gets a new address each time. [[Static IP|Static addressing]] is like owning a reserved parking spot—you keep the same spot every single day.

**Definition**: [[DHCP]] (Dynamic Host Configuration Protocol) automatically assigns IP addresses; [[static IP|static configuration]] manually assigns a fixed address that never changes.

| Feature | DHCP | Static |
|---------|------|--------|
| IP Assignment | Automatic, temporary lease | Manual, permanent |
| Lease Expiry | Yes (default 8 days) | No |
| Configuration Effort | Zero | High |
| Ideal For | End-users, guests | Servers, printers |
| Troubleshooting Clarity | Less predictable | Consistent |

---

### DNS Server Configuration

**Analogy**: [[DNS]] servers are like telephone directories for the internet. Instead of memorizing IP addresses, you ask the DNS "operator" to look up "google.com," and they hand back the actual IP address where Google lives.

**Definition**: [[DNS]] (Domain Name System) servers translate human-readable hostnames (like "reddit.com") into their corresponding [[IP address|IP addresses]]. `ipconfig /all` displays which DNS servers your machine has been configured to use.

```
DNS Servers . . . . . . . . . . . : 8.8.8.8
                                     8.8.4.4
```

---

## Exam Tips

### Question Type 1: Configuration Verification
- *"A user reports their computer cannot reach any websites, but can ping the local gateway. Which `ipconfig` output would reveal the root cause?"* → Check the **DNS Servers** entry; if blank or showing `127.0.0.1` only, DNS resolution is broken.
- **Trick**: The exam might show a valid [[IPv4]] address and valid [[default gateway]] but missing or incorrect [[DNS]] entries. Students forget that connectivity ≠ name resolution.

### Question Type 2: DHCP Lease Issues
- *"After moving a laptop to a new office, it boots with IP address 169.254.x.x. What happened?"* → The [[DHCP]] server is unreachable, so Windows assigned an [[APIPA]] (Automatic Private IP Addressing) address.
- **Trick**: Know that `169.254.x.x` is the red flag for failed DHCP. The fix is `ipconfig /release` followed by `ipconfig /renew`.

### Question Type 3: Adapter Type Identification
- *"You run `ipconfig /all` and see 'Media State: Disconnected.' What should you check?"* → Physical cable connection ([[Ethernet]]) or [[Wi-Fi]] driver status; the NIC is recognized but not linked to a network.
- **Trick**: Don't confuse a disconnected adapter (hardware issue) with an adapter that's missing from `ipconfig` output entirely (driver/hardware failure).

---

## Common Mistakes

### Mistake 1: Confusing APIPA with DHCP Failure
**Wrong**: "If the IP is 169.254.x.x, the [[DHCP]] server assigned it."
**Right**: "169.254.x.x is a self-assigned [[APIPA]] address that Windows uses when [[DHCP]] is unreachable or times out."
**Impact on Exam**: You'll get questions asking why a user has this odd address. The answer is always "[[DHCP]] server unreachable," not "server worked fine."

### Mistake 2: Ignoring the /all Flag
**Wrong**: Running just `ipconfig` and thinking you have complete information for troubleshooting.
**Right**: Always use `ipconfig /all` during serious diagnostics; it exposes [[DHCP]] server IP, lease times, [[DNS]] suffixes, and adapter hardware details.
**Impact on Exam**: A question might hinge on information only visible in `/all` output—like which [[DHCP]] server issued the address.

### Mistake 3: Assuming IPv6 Means Dual Stack Works
**Wrong**: "If `ipconfig` shows both [[IPv4]] and [[IPv6]] addresses, the system has full internet access."
**Right**: [[IPv6]] and [[IPv4]] operate independently; one can fail while the other works. Most apps still use [[IPv4]].
**Impact on Exam**: Expect a scenario where [[IPv6]] shows no default gateway but [[IPv4]] is fine—this is not a critical failure in most real networks.

### Mistake 4: Not Recognizing the Default Gateway Role
**Wrong**: "The [[default gateway]] is just another network setting."
**Right**: The [[default gateway]] is the router that must exist for any traffic outside your [[subnet]] to work. No gateway = no internet.
**Impact on Exam**: A user can't reach google.com. `ipconfig` shows valid local IP, but blank **Default Gateway** field. That's your smoking gun.

---

## Related Topics
- [[IPConfig /All Flag]]
- [[DHCP]] (Dynamic Host Configuration Protocol)
- [[APIPA]] (Automatic Private IP Addressing)
- [[Default Gateway]]
- [[Subnet Mask]]
- [[DNS]] (Domain Name System)
- [[IPv4]] and [[IPv6]]
- [[MAC Address]]
- [[Network Interface Card]]
- [[TCP/IP Stack]]
- [[Ethernet]]
- [[Wi-Fi]] / [[Wireless Adapter]]
- [[Network Troubleshooting Methodology]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*