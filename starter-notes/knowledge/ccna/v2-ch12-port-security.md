# Port Security
## Protect switches from MAC flooding and DHCP exhaustion attacks by limiting MAC addresses per port

---

## Why This Matters
Port Security is your first line of defense against internal Layer 2 attacks. While external threats dominate headlines, malware-infected devices and malicious insiders can exploit switch vulnerabilities to sniff traffic, exhaust DHCP pools, or disable network segments. This chapter teaches you to lock down switch ports granularly—critical for both exam success and real-world network defense.

---

## 12.1 Port Security Fundamentals

### The Simple Explanation
Think of a switch port like a doorway to your network. By default, that doorway has no security—anyone (any MAC address) can walk through. **Port Security is like a bouncer**: you tell it "only let 1-5 people through this door," and if a 6th person shows up, the bouncer shuts the door (disables the port).

### The Detailed Reality
Port Security limits the number of unique [[MAC addresses]] a switch can learn on a single port and defines actions when that limit is exceeded. By default, switches can learn thousands of MAC addresses per port (limited only by the MAC address table size). This is a vulnerability.

---

## Attack Vectors Port Security Mitigates

### MAC Flooding Attack
**How it works:**
1. Attacker floods switch with frames containing spoofed source MAC addresses
2. Switch's MAC address table fills up (becomes full)
3. Switch can no longer learn legitimate MAC addresses of hosts
4. Switch floods all unicast frames destined for those hosts (default behavior when MAC not in table)
5. Attacker receives copies of all frames between legitimate hosts

**Impact on CIA Triad:** Compromises **confidentiality**—attacker can sniff traffic

### DHCP Exhaustion Attack
**How it works:**
1. Attacker sends countless [[DHCP]] DISCOVER messages with spoofed MAC addresses
2. DHCP server's address pool becomes exhausted
3. Legitimate devices cannot obtain IP addresses
4. Network becomes unavailable

**Note:** DHCP exhaustion often causes MAC flooding as a side effect (thousands of spoofed DISCOVER messages = thousands of unique source MACs).

---

## 12.2 Basic Port Security Configuration

### Minimum Viable Configuration

```ios
SW1(config)# interface f0/1
SW1(config-if)# switchport mode access
SW1(config-if)# switchport port-security
```

**Critical:** Port Security only works on ports explicitly set to `access` or `trunk` mode. Dynamic ports (using [[DTP]]) will reject the command.

### Verifying Port Security

```ios
SW1# show port-security interface f0/1
```

**Output shows:**
- **Port Security:** Enabled/Disabled
- **Port Status:** Secure-up, Secure-down, Shutdown
- **Violation Mode:** What happens when limit is exceeded (default: shutdown)
- **Maximum MAC Addresses:** Default is 1
- **Aging Time:** How long before learned MACs expire (default: 0 = never)
- **Aging Type:** Absolute or Inactivity

| Parameter | Default | Purpose |
|-----------|---------|---------|
| Max MAC Addresses | 1 | How many unique MACs allowed per port |
| Violation Mode | Shutdown | Action taken when exceeded |
| Aging Time | 0 minutes | How long before entries expire |
| Aging Type | Absolute | Expiration method (Absolute = time-based, Inactivity = idle-based) |

---

## 12.3 Port Security Parameters

### Maximum MAC Address Limit

The **maximum MAC addresses** setting defines the threshold. Default is **1 MAC per port**.

```ios
SW1(config-if)# switchport port-security maximum 5
```

**Practical considerations:**
- Set to **1** for single-device ports (user machines, printers)
- Set to **2-5** for ports with IP phones + computer (using daisy-chain)
- Set to **10+** for uplinks to other switches or servers with multiple virtual interfaces

### Violation Modes: What Happens When Limit is Exceeded

Port Security supports three violation modes. The **mode** determines the action when a port exceeds its MAC limit:

| Violation Mode | Behavior | Frame Loss | Recovery | Use Case |
|---|---|---|---|---|
| **shutdown** (default) | Port goes error-disabled; drops all traffic | Yes | Manual `no shutdown` or `errdisable recovery cause psecurity` | High-security environments; labs |
| **restrict** | Port remains up; drops violating frames only; generates SNMP trap | Partial | Automatic | Production networks; user ports |
| **protect** | Port remains up; drops violating frames; NO SNMP trap | Partial | Automatic | When SNMP monitoring unavailable |

**Configuration:**
```ios
SW1(config-if)# switchport port-security violation shutdown
SW1(config-if)# switchport port-security violation restrict
SW1(config-if)# switchport port-security violation protect
```

### Sticky MAC Addresses

**Problem:** If you manually configure allowed MAC addresses and a device is replaced, you must manually update the config. Tedious in large networks.

**Solution:** **Sticky MAC learning** — switch dynamically learns and "sticks" allowed MAC addresses to the running config.

```ios
SW1(config-if)# switchport port-security mac-address sticky
```

**Behavior:**
- Switch learns MAC addresses dynamically (like normal learning)
- Learned MACs are added to running-config as static entries: `switchport port-security mac-address sticky aaaa.bbbb.cccc`
- If you `write memory`, sticky MACs become persistent across reboots
- Allows flexibility without manual entry

**Common pattern:**
```ios
SW1(config-if)# switchport port-security maximum 2
SW1(config-if)# switchport port-security mac-address sticky
```

### MAC Aging

Learned MAC addresses can automatically expire, allowing MAC rotation (useful in labs or dynamic environments).

```ios
SW1(config-if)# switchport port-security aging time 10
SW1(config-if)# switchport port-security aging type absolute
SW1(config-if)# switchport port-security aging type inactivity
```

| Aging Type | Behavior |
|---|---|
| **Absolute** | MAC expires after X minutes, regardless of activity |
| **Inactivity** | MAC expires only if no frames from that MAC for X minutes |

**Example:**
```ios
! Expire MACs after 30 minutes of no activity
switchport port-security aging time 30
switchport port-security aging type inactivity
```

---

## 12.4 Static MAC Address Configuration

For maximum security, manually specify allowed MAC addresses:

```ios
SW1(config-if)# switchport port-security mac-address aaaa.bbbb.cccc
SW1(config-if)# switchport port-security mac-address aaaa.bbbb.dddd
SW1(config-if)# switchport port-security maximum 2
```

**Verification:**
```ios
SW1# show port-security interface f0/1
SW1# show port-security address
```

**Output shows:**
- Secure MAC count
- Statically configured MACs
- Dynamically learned MACs

---

## 12.5 Error-Disabled Recovery

When a port is **error-disabled** (shutdown by Port Security violation), it doesn't automatically recover. Manual or automatic recovery is required.

### Manual Recovery
```ios
SW1(config)# interface f0/1
SW1(config-if)# no shutdown
```

### Automatic Recovery
```ios
SW1(config)# errdisable recovery cause psecurity
SW1(config)# errdisable recovery interval 30
```

This automatically re-enables error-disabled ports after 30 seconds (default 300).

---

## Lab Relevance

### Core Commands You Must Know

| Task | Command | Example |
|------|---------|---------|
| Enable Port Security | `switchport port-security` | `SW1(config-if)# switchport port-security` |
| Set max MAC addresses | `switchport port-security maximum <1-6144>` | `switchport port-security maximum 3` |
| Set violation mode | `switchport port-security violation <shutdown\|restrict\|protect>` | `switchport port-security violation restrict` |
| Add static MAC | `switchport port-security mac-address <MAC>` | `switchport port-security mac-address aaaa.bbbb.cccc` |
| Enable sticky MACs | `switchport port-security mac-address sticky` | `switchport port-security mac-address sticky` |
| Set aging | `switchport port-security aging time <0-1440>` | `switchport port-security aging time 60` |
| Set aging type | `switchport port-security aging type <absolute\|inactivity>` | `switchport port-security aging type inactivity` |
| Verify settings | `show port-security interface <intf>` | `show port-security interface f0/1` |
| View all secure MACs | `show port-security address` | `show port-security address` |
| View port summary | `show port-security` | `show port-security` |
| Enable auto-recovery | `errdisable recovery cause psecurity` | `errdisable recovery cause psecurity` |
| Set recovery interval | `errdisable recovery interval <seconds>` | `errdisable recovery interval 30` |

### Lab Exercise Template
```ios
! Secure a user access port with 1 allowed MAC
interface f0/5
  switchport mode access
  switchport port-security
  switchport port-security maximum 1
  switchport port-security violation shutdown

! Secure an IP phone + PC port with sticky learning
interface f0/10
  switchport mode access
  switchport port-security
  switchport port-security maximum 2
  switchport port-security mac-address sticky
  switchport port-security violation restrict

! Secure an uplink with multiple hosts
interface g0/1
  switchport mode trunk
  switchport port-security
  switchport port-security maximum 10
  switchport port-security violation protect
```

---

## Exam Tips

### What CCNA Specifically Tests

1. **Default Port Security behavior**
   - Default max MACs: **1**
   - Default violation mode: **shutdown**
   - Port must be in **access or trunk mode** (not dynamic)
   - **Trick question:** "Why won't `switchport port-security` work?" → Answer: Port is dynamic; set mode first.

2. **Violation modes — know the differences**
   - **Shutdown:** Most secure; most disruptive. Port goes error-disabled.
   - **Restrict:** Production-friendly. Drops frames, stays up. Sends SNMP trap.
   - **Protect:** Like restrict but no SNMP notification.
   - **Exam question:** "You need to drop violating traffic but keep the port up and alert the NOC." → Answer: **restrict**

3. **Sticky MAC addresses**
   - **What it is:** Dynamic learning that gets written to config
   - **When to use:** When you want flexibility without manual MAC entry
   - **Trap:** If you enable sticky but don't `write memory`, MACs disappear on reboot.

4. **MAC Flooding vs. DHCP Exhaustion**
   - **MAC Flooding:** Fills MAC table → switch floods legitimate frames → **confidentiality breach**
   - **DHCP Exhaustion:** Spoofed DHCP DISCOVERs → pool exhausted → legitimate devices can't get IPs → **availability**
   - **Both use spoofed MACs**
   - **Exam question:** "Which attack prevents new devices from getting IP addresses?" → **DHCP exhaustion**

5. **Verification commands**
   - `show port-security` — summary of all ports
   - `show port-security interface f0/5` — detailed one-port view
   - `show port-security address` — all learned/static MACs

### Sample Exam Scenarios

**Scenario 1:**
> "A switch port is in an error-disabled state due to a Port Security violation. The administrator needs to restore traffic on this port within 30 seconds automatically. Which command is required?"

**Answer:** `errdisable recovery cause psecurity` + `errdisable recovery interval 30`

**Scenario 2:**
> "An IP phone on port F0/

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 12 | [[CCNA]]*
