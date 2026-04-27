# Dynamic ARP Inspection
**Master Layer 2 security by stopping ARP poisoning attacks before they compromise your network**

---

## 14.1 ARP and ARP-Based Attacks

### Understanding ARP: The Layer 2-3 Bridge

Think of [[ARP]] like a phone book lookup: when Device A needs to talk to Device B on the same network, it broadcasts "Who has IP 10.0.0.1?" and the device with that IP responds "I do, and my MAC is XXXX.XXXX.XXXX." Both devices record each other's mappings in their ARP tables.

**The vulnerability**: ARP has no authentication mechanism. Any device can send an unsolicited ARP reply claiming to own any IP address. There's no verification, no cryptographic signatures—just trust.

### ARP Message Structure

| Field | Purpose | Critical Detail |
|-------|---------|-----------------|
| Sender MAC | Attacker's actual MAC | Included in every ARP message |
| Sender IP | IP address being claimed | Can be spoofed freely |
| Target MAC | Destination device's MAC | Empty (0000.0000.0000) in requests |
| Target IP | IP address being queried | Identifies actual recipient in broadcast |

**Key insight**: ARP messages are encapsulated directly in [[Ethernet]] frames—they do NOT contain an IP header. The IP and MAC fields are part of the ARP message itself.

### ARP Poisoning Attack (GARP-Based)

The attacker sends unsolicited [[Gratuitous ARP|GARP]] replies to overwrite legitimate ARP table entries:

1. **Legitimate state**: PC1 knows R1's MAC, R1 knows PC1's MAC
2. **Attack phase**: Attacker floods both devices with ARP replies claiming "10.0.0.1 is at [Attacker MAC]" and "10.0.0.6 is at [Attacker MAC]"
3. **Result**: Both devices update their ARP tables to point at the attacker
4. **Impact**: Man-in-the-middle position achieved; attacker sees all traffic between PC1 and R1 (confidentiality violation per CIA triad)

**Why existing protections fail**:
- [[Port Security]]: Limits MAC addresses per port, but ARP poisoning uses a single source MAC—ineffective
- [[DHCP Snooping]]: Filters DHCP messages only, not ARP frames

---

## 14.2 Dynamic ARP Inspection (DAI)

### Conceptual Foundation

[[Dynamic ARP Inspection|DAI]] is a Cisco Layer 2 security feature that validates ARP messages before allowing them to be forwarded. It answers one simple question: "Is the sender's IP-to-MAC mapping legitimate?"

DAI doesn't work alone—it leverages the [[DHCP Snooping]] binding table (IP-to-MAC mappings of devices that obtained addresses via DHCP) as its validation source. When an ARP message arrives on an untrusted port, DAI checks: "Is this IP-MAC pair in my DHCP Snooping binding table?" If no, the frame is dropped.

### Trust Model: Trusted vs. Untrusted Ports

DAI divides switch ports into two categories:

| Port Type | Behavior | Use Case |
|-----------|----------|----------|
| **Untrusted** (default) | ARP messages validated against DHCP binding table; invalid messages dropped | End-user access ports |
| **Trusted** | ARP messages forwarded without inspection | Links to DHCP servers, other switches, routers providing legitimate network services |

**Critical detail**: A port's trust status is feature-specific. A port can be untrusted for DHCP Snooping but trusted for DAI on the same physical interface.

### Enabling DAI: Global Configuration

```
SW2(config)# ip arp inspection vlan 1
```

This single command enables DAI on VLAN 1. (Compare to [[DHCP Snooping]], which requires two commands: `ip dhcp snooping` + `ip dhcp snooping vlan X`)

**Multi-VLAN syntax**:
```
SW2(config)# ip arp inspection vlan 1-4094           ! All VLANs
SW2(config)# ip arp inspection vlan 2-5,7,9,2028     ! Specific VLANs
```

### Configuring Port Trust

```
SW2(config)# interface g0/1
SW2(config-if)# ip arp inspection trust
```

**Default state**: All ports are untrusted when DAI is enabled on a VLAN.

### Complete Configuration Example

**SW2 (Access Switch with End Users)**:
```
SW2(config)# ip dhcp snooping
SW2(config)# ip dhcp snooping vlan 1
SW2(config)# no ip dhcp snooping information option
SW2(config)# ip arp inspection vlan 1
SW2(config)# interface g0/1
SW2(config-if)# ip dhcp snooping trust
SW2(config-if)# ip arp inspection trust
SW2(config)# interface g0/2
! Defaults to untrusted for both features
```

**SW1 (Distribution Switch)**:
```
SW1(config)# ip dhcp snooping
SW1(config)# ip dhcp snooping vlan 1
SW1(config)# no ip dhcp snooping information option
SW1(config)# ip arp inspection vlan 1
SW1(config)# interface range g0/1-2
SW1(config-if-range)# ip dhcp snooping trust
SW1(config-if-range)# ip arp inspection trust
SW1(config)# interface g0/1
SW1(config-if)# ip dhcp snooping trust
```

### Verification Commands

```
SW2# show ip arp inspection
SW2# show ip arp inspection vlan 1
SW2# show ip arp inspection interfaces
SW2# show ip arp inspection statistics
```

**Expected output from `show ip arp inspection`**:

| Column | Meaning |
|--------|---------|
| Vlan | VLAN ID |
| Configuration | Enabled or Disabled |
| Operation | Active or Inactive (becomes Active only when DAI and DHCP Snooping are both enabled) |
| ACL Match | Whether an [[Access Control List|ACL]] is being used for additional filtering |
| Static ACL | Custom ACL for ARP validation |

---

## 14.3 DAI Operation and Validation

### Validation Flow (Untrusted Port)

When an ARP message arrives on an untrusted port:

1. **Extract sender IP and sender MAC** from the ARP message
2. **Query DHCP Snooping binding table**: Does this IP-MAC pair exist and match?
3. **Decision**:
   - **Match found**: Forward the ARP message normally
   - **No match**: Drop the frame (unless static ARP ACL permits it)

### Validation Flow (Trusted Port)

All ARP messages on trusted ports bypass inspection entirely and are forwarded immediately.

### Static ARP ACL (Advanced Filtering)

For devices that don't use DHCP (static IP servers, printers, routers), DAI would normally drop their ARP messages. Use a static ARP ACL to permit these devices:

```
SW2(config)# arp access-list STATIC-ARP
SW2(config-arp-acl)# permit ip host 10.0.0.50 mac host aaaa.bbbb.cccc
SW2(config-arp-acl)# exit
SW2(config)# ip arp inspection vlan 1 acl STATIC-ARP
```

This explicitly permits the server at 10.0.0.50 with MAC aaaa.bbbb.cccc to send ARP messages on VLAN 1.

---

## 14.4 DAI Limitations and Rate Limiting

### The Gratuitous ARP Problem

By default, DAI validates gratuitous ARP replies (unsolicited ARP messages) the same way it validates request-response pairs. However, legitimate devices (like [[Hot Standby Routing Protocol|HSRP]] routers) send gratuitous ARPs to notify the network of MAC changes.

**Risk**: A misconfigured device or attacker sending gratuitous ARPs with a spoofed MAC could poison tables even on a trusted port.

### DAI Rate Limiting

Limit the number of ARP messages processed per port per second to prevent DoS attacks:

```
SW2(config)# ip arp inspection rate 10
SW2(config)# interface g0/1
SW2(config-if)# ip arp inspection limit rate 10
```

If the rate is exceeded, the port transitions to an "errdisable" state (disabled) until manually re-enabled:

```
SW2# shutdown
SW2# no shutdown
```

---

## Lab Relevance

### Essential Cisco IOS Commands

| Command | Context | Purpose |
|---------|---------|---------|
| `ip arp inspection vlan <vlan-list>` | Global Config | Enable DAI on specified VLANs |
| `ip arp inspection trust` | Interface Config | Mark port as trusted (bypasses ARP validation) |
| `no ip arp inspection trust` | Interface Config | Mark port as untrusted (enforces ARP validation) |
| `arp access-list <name>` | Global Config | Create static ARP ACL for permit/deny rules |
| `permit ip host <ip> mac host <mac>` | ARP ACL Config | Permit specific IP-MAC pairs |
| `ip arp inspection vlan <vlan> acl <name>` | Global Config | Apply static ARP ACL to VLAN |
| `ip arp inspection rate <pps>` | Global Config | Set global rate limit (packets per second) |
| `ip arp inspection limit rate <pps>` | Interface Config | Set per-interface rate limit |
| `show ip arp inspection` | Exec | Display DAI status per VLAN |
| `show ip arp inspection vlan <vlan>` | Exec | Show detailed DAI status for specific VLAN |
| `show ip arp inspection interfaces` | Exec | Show trust status of all ports |
| `show ip arp inspection statistics` | Exec | Display ARP message drop counts and actions taken |
| `show arp access-list` | Exec | Display all configured ARP ACLs |

### Typical Lab Scenario

```
! Configure SW2 (access layer) for DHCP Snooping + DAI
SW2(config)# ip dhcp snooping
SW2(config)# ip dhcp snooping vlan 10
SW2(config)# ip arp inspection vlan 10
SW2(config)# no ip dhcp snooping information option

! Trust the uplink to SW1 (where DHCP server connects)
SW2(config)# interface g0/1
SW2(config-if)# ip dhcp snooping trust
SW2(config-if)# ip arp inspection trust

! Leave end-user ports (g0/2-24) untrusted (default)

! Add static entry for router with static IP
SW2(config)# arp access-list STATIC-ARP
SW2(config-arp-acl)# permit ip host 10.0.0.1 mac host 0000.0000.0001
SW2(config)# ip arp inspection vlan 10 acl STATIC-ARP

! Verify
SW2# show ip arp inspection vlan 10
SW2# show ip arp inspection interfaces
```

---

## Exam Tips

### What CCNA Specifically Tests on DAI

**Topic 5.7 Focus**: "Configure and verify Layer 2 security features"

#### Likely Exam Questions

1. **Conceptual**: "Which attack does DAI protect against?"
   - Answer: ARP poisoning / GARP-based spoofing attacks
   - Trap: Port Security alone cannot prevent this (limits MAC count, not MAC-IP validity)

2. **Configuration Recognition**: "Which command enables DAI on VLAN 5?"
   - Correct: `ip arp inspection vlan 5`
   - Wrong answers: `ip arp inspection enable vlan 5`, `ip arp inspection 5`
   - Trap: Confusing DAI syntax with DHCP

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 14 | [[CCNA]]*
