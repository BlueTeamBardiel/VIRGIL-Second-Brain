# DHCP Snooping
**Protect networks from rogue DHCP servers that intercept client traffic via man-in-the-middle attacks**

---

## Why This Chapter Matters

[[DHCP]] is ubiquitous in modern networks, but it's also a prime attack surface. Without proper Layer 2 security controls, attackers can deploy rogue DHCP servers to redirect client traffic through malicious devices. DHCP Snooping is your first line of defense—it's a critical CCNA exam topic (5.7) and essential for real-world network security.

---

## Core Concept: DHCP Snooping Explained Simply

**Simple Version:** DHCP Snooping is a switch feature that acts as a bouncer at the door. It examines [[DHCP]] messages coming in and only allows legitimate DHCP server responses on specific "trusted" ports. Messages from client devices on regular ("untrusted") ports are inspected for suspicious activity.

**Detailed Version:** DHCP Snooping examines every [[DHCP]] message passing through the switch and applies filtering rules based on port trust status. Only ports explicitly configured as trusted allow server-to-client messages ([[DHCP]] OFFER, ACK, NAK). All other ports (untrusted by default) have their messages filtered—client messages pass through, but server messages are dropped unless they're from trusted ports.

---

## DHCP-Based Attacks

### DHCP Poisoning (Rogue DHCP Server Attack)

An attacker configures a rogue (spurious) DHCP server on the network segment that responds to [[DHCP]] DISCOVER messages **faster than the legitimate server**. The rogue server:

1. Leases valid IP addresses to clients
2. **Assigns itself as the default gateway** instead of the legitimate router
3. Intercepts all client traffic, acting as a man-in-the-middle (MITM)
4. Can eavesdrop on, modify, or drop client communications

**Why it works:** [[DHCP]] clients accept the first OFFER message received. When the rogue server is on the same LAN segment as clients, it has lower latency than DHCP servers on remote segments.

**Comparison to other attacks:**
| Attack Type | Mechanism | Mitigation |
|---|---|---|
| [[DHCP]] Poisoning | Rogue DHCP server intercepts traffic | [[DHCP]] Snooping |
| [[DHCP]] Exhaustion | Attacker floods DISCOVER messages, exhausts address pool | [[Port Security]] |
| [[ARP]] Poisoning | Attacker sends fake ARP replies | Dynamic [[ARP]] Inspection (DAI) |

**Port Security does NOT protect** against DHCP poisoning because the rogue server uses a single MAC address, and Port Security only limits the *number* of MAC addresses per port.

---

## DHCP Message Types

DHCP Snooping filters messages differently depending on whether they're sent by clients or servers.

### Client-to-Server Messages
- **DISCOVER** — Client broadcasts looking for DHCP servers
- **REQUEST** — Client requests a specific IP address from an offered lease
- **DECLINE** — Client rejects a leased IP (already in use)
- **RELEASE** — Client voluntarily gives back its IP address

### Server-to-Client Messages
- **OFFER** — Server offers an IP address lease
- **ACK** — Server confirms the lease
- **NAK** (Negative Acknowledgment) — Server rejects client's REQUEST

**Critical for filtering:** [[DHCP]] Snooping **drops server messages received on untrusted ports** and **allows client messages on all ports**.

---

## How DHCP Snooping Works

### Trusted vs. Untrusted Ports

| Port Type | Default Status | Allows Client Messages | Allows Server Messages |
|---|---|---|---|
| **Untrusted** | All ports by default | ✓ Yes (filtered by rules) | ✗ No (DROPPED) |
| **Trusted** | Must be configured manually | ✓ Yes | ✓ Yes |

**Port classification strategy:**
- **Trusted ports:** Uplinks to DHCP servers, trunk links to other switches (where legitimate DHCP servers might be), management ports
- **Untrusted ports:** Access ports toward end-user devices

### Filtering Rules on Untrusted Ports

When a [[DHCP]] message arrives on an untrusted port, DHCP Snooping applies these rules:

1. **Server messages (OFFER, ACK, NAK) are immediately dropped** — Prevents rogue servers
2. **Client messages (DISCOVER, REQUEST, DECLINE, RELEASE) are inspected:**
   - Source MAC must match the [[DHCP]] client hardware address field
   - Messages with mismatched MAC addresses are dropped
   - Valid client messages are forwarded normally

**Example:** A rogue server on an untrusted port sends an OFFER message → [[DHCP]] Snooping drops it before clients see it.

---

## Configuring DHCP Snooping

### Step 1: Enable DHCP Snooping Globally

```
SW1(config)# ip dhcp snooping
```

**Note:** This command alone is insufficient; DHCP Snooping remains inactive until activated on specific VLANs.

### Step 2: Activate DHCP Snooping on VLANs

```
SW1(config)# ip dhcp snooping vlan 1
```

**Multiple VLANs syntax:**
```
! All VLANs (1-4094)
SW1(config)# ip dhcp snooping vlan 1-4094

! Specific VLANs with mixed notation
SW1(config)# ip dhcp snooping vlan 1,3-5,7,9-11
```

### Step 3: Configure Trusted Ports

```
SW1(config)# interface g0/1
SW1(config-if)# ip dhcp snooping trust
```

**Repeat for all ports that connect to:**
- DHCP servers
- Uplinks to other switches (trunk ports)
- Access points serving clients with DHCP

### Step 4: (Optional) Disable DHCP Information Option

```
SW1(config)# no ip dhcp snooping information option
```

**What this does:** Prevents [[DHCP]] Snooping from inserting Option 82 information into [[DHCP]] messages. Option 82 adds switch port information for [[DHCP]] relay agents—some DHCP servers reject messages with unknown Option 82 data. Use this command if you don't have a [[DHCP]] relay or if your server rejects Option 82.

---

## Verification Commands

### Check DHCP Snooping Status

```
SW1# show ip dhcp snooping
```

**Sample output:**
```
Switch DHCP snooping is enabled
DHCP snooping is configured on following VLANs:
1
DHCP snooping is operational on following VLANs:
1
```

**Interpretation:** 
- "Configured" = activated with `ip dhcp snooping vlan` command
- "Operational" = the VLAN itself is active on the switch

If a VLAN shows "configured" but not "operational," the VLAN is disabled on the switch.

### Check Port Trust Status

```
SW1# show ip dhcp snooping interface
```

**Sample output:**
```
Interface           Trusted         Rate limit (pps)
Gi0/1               true            unlimited
Gi0/2               false           0
Gi0/3               false           0
```

### View DHCP Snooping Binding Database

```
SW1# show ip dhcp snooping binding
```

**Sample output:**
```
MacAddress      IpAddress       Lease(sec)      Type    VLAN    Interface
00:11:22:33:44:55   192.168.1.100   86350       dhcp    1       Gi0/2
00:aa:bb:cc:dd:ee   192.168.1.101   86400       dhcp    1       Gi0/3
```

**This database tracks:** Client MAC → IP address mappings learned from legitimate [[DHCP]] servers.

---

## Lab Relevance: Cisco IOS Commands

### Configuration Commands

| Command | Mode | Purpose |
|---|---|---|
| `ip dhcp snooping` | Global config | Enable [[DHCP]] Snooping globally |
| `ip dhcp snooping vlan <vlans>` | Global config | Activate on specific VLAN(s) |
| `ip dhcp snooping trust` | Interface config | Mark port as trusted |
| `no ip dhcp snooping information option` | Global config | Disable Option 82 insertion |

### Verification Commands

| Command | Purpose |
|---|---|
| `show ip dhcp snooping` | Display global [[DHCP]] Snooping status |
| `show ip dhcp snooping interface` | Display port trust status and rate limits |
| `show ip dhcp snooping binding` | Display learned DHCP client bindings |
| `show ip dhcp snooping statistics` | Display filtered message counts |

### Example Lab Configuration

```
SW1(config)# ip dhcp snooping
SW1(config)# ip dhcp snooping vlan 1
SW1(config)# no ip dhcp snooping information option
SW1(config)# interface g0/1
SW1(config-if)# ip dhcp snooping trust
SW1(config-if)# exit
SW1(config)# interface range g0/2-3
SW1(config-if-range)# no ip dhcp snooping trust
SW1(config-if-range)# exit
SW1# show ip dhcp snooping
SW1# show ip dhcp snooping interface
SW1# show ip dhcp snooping binding
```

---

## Exam Tips

### What the CCNA Exam Tests

1. **Identifying rogue DHCP servers** — Scenario: "A user is unable to reach servers on the internet. Their gateway is 192.168.1.254, but the legitimate gateway is 192.168.1.1. What attack likely occurred?" Answer: [[DHCP]] poisoning.

2. **Trusted vs. untrusted port logic** — "Which port should you configure as trusted: the port connecting to the DHCP server or the port connecting to user devices?" Answer: The port to the DHCP server.

3. **When DHCP Snooping filters messages** — "Which DHCP message types are dropped on untrusted ports?" Answer: Server messages (OFFER, ACK, NAK).

4. **Configuration requirements** — "You enabled `ip dhcp snooping` but [[DHCP]] Snooping still isn't working. What command did you forget?" Answer: `ip dhcp snooping vlan <vlan-number>`.

5. **DHCP message types** — "Is DECLINE a client or server message?" Answer: Client message.

6. **Option 82 troubleshooting** — Scenario: "After enabling [[DHCP]] Snooping, clients stop receiving leases. The DHCP server logs show 'unknown Option 82 received.' What should you do?" Answer: Issue `no ip dhcp snooping information option` on the switch.

7. **Interaction with other Layer 2 security** — "Which feature mitigates [[DHCP]] exhaustion: [[DHCP]] Snooping or [[Port Security]]?" Answer: [[Port Security]] (limits MAC addresses per port).

### Tricky Exam Questions

- **"Which Layer 2 security feature prevents both DHCP poisoning and DHCP exhaustion?"** Answer: Neither—[[DHCP]] Snooping stops poisoning, [[Port Security]] stops exhaustion. You need both.
- **"Can DHCP Snooping see non-DHCP traffic?"** Answer: No. [[DHCP]] Snooping only inspects UDP port 67/68 messages; all other traffic passes through unfiltered.
- **"Why must you enable [[DHCP]] Snooping twice?"** Answer: `ip dhcp snooping` enables the feature globally, but `ip dhcp snooping vlan` activates it per VLAN (allows granular control).

---

## Common Mistakes

### Mistake 1: Enabling DHCP Snooping Globally But Not on VLANs

```

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 13 | [[CCNA]]*
