---
tags: [knowledge, ccna, chapter-0]
created: 2026-04-30
cert: CCNA
chapter: 0
source: rewritten
---

# VLAN + DTP + VTP Lab
**Master trunk negotiation, VLAN distribution, and access port assignment across a three-switch network topology.**

---

## Trunk Configuration & DTP Negotiation

### Setting Up Trunk Links with DTP Disabled

**Analogy**: Imagine three buildings connected by highways. You want to guarantee those highways are always open for traffic between all buildings, so you paint "HIGHWAY" on them permanently rather than letting construction crews debate whether they should be highways or not. That's what we're doing here—locking in trunk mode instead of letting [[DTP]] negotiate.

**[[DTP]] (Dynamic Trunking Protocol)**: A Cisco protocol that automatically negotiates whether a link should operate as a [[trunk]] or access port; disabling it prevents unwanted mode changes and security risks.

**[[Trunk]]**: A link carrying traffic from multiple [[VLANs]] simultaneously using [[802.1Q]] tagging.

**`switchport nonegotiate`**: Forces the port into its configured mode without attempting [[DTP]] negotiation—the gold standard for production networks.

| Switch | Interface(s) | Configuration |
|--------|--------------|----------------|
| SW1 | Gi0/1 | Trunk + Nonegotiate |
| SW2 | Gi0/1–2 | Trunk + Nonegotiate |
| SW3 | Gi0/1 | Trunk + Nonegotiate |

```
SW1(config-if)# switchport mode trunk
SW1(config-if)# switchport nonegotiate

SW2(config-if-range)# switchport mode trunk
SW2(config-if-range)# switchport nonegotiate

SW3(config-if)# switchport mode trunk
SW3(config-if)# switchport nonegotiate
```

---

## VTP Configuration & VLAN Distribution

### Step 1: Designate VTP Server and Distribute VLANs

**Analogy**: Think of VTP like a company memo system—the server writes the memo (creates VLANs), the clients automatically receive and apply it, and the transparent mode employee reads it but doesn't file it or follow it.

**[[VTP]] (VLAN Trunking Protocol)**: A Layer 2 messaging protocol that automatically synchronizes [[VLAN]] databases across switches in the same domain, reducing manual configuration.

**VTP Server**: The authoritative source for [[VLAN]] creation and modification; changes here propagate to clients automatically.

**VTP Domain**: A logical grouping of switches that share [[VLAN]] information via [[VTP]].

| Component | Purpose |
|-----------|---------|
| VTP Server | Creates and modifies VLANs; increments revision number |
| VTP Client | Receives VLAN updates; cannot create VLANs |
| VTP Transparent | Forwards VTP frames but ignores them; local VLANs only |

```
SW1(config)# vtp domain CCNA
SW1(config)# vlan 10
SW1(config-vlan)# exit
SW1(config)# vlan 20
SW1(config-vlan)# exit
SW1(config)# vlan 30
SW1(config-vlan)# exit
```

**Verification on SW2 and SW3**:
```
show vtp status
show vlan brief
```

Both switches automatically receive VLANs 10, 20, and 30 from SW1 (the server).

---

### Step 2: Convert SW2 to Transparent Mode & Add Local VLAN

**Analogy**: SW2 becomes like a neutral country—it passes messages between neighbors but refuses to adopt their policies, maintaining its own independent VLAN rules.

**Transparent Mode**: The switch ignores incoming [[VTP]] updates and forwards them but maintains its own independent [[VLAN]] database.

```
SW2(config)# vtp mode transparent
SW2(config)# vlan 40
SW2(config-vlan)# exit
```

**Verification on SW1 and SW3**:
```
show vlan brief
```

VLAN 40 does **NOT** appear on SW1 or SW3—it exists only on SW2. This proves transparent mode isolation.

---

### Step 3: Set SW3 as VTP Client

**Analogy**: SW3 becomes an obedient worker who cannot create tasks—only the boss (SW1/server) can create tasks, and SW3 receives and executes them.

**VTP Client**: A switch that receives and implements [[VLAN]] updates from the server but cannot create, modify, or delete [[VLANs]].

```
SW3(config)# vtp mode client
SW3(config)# vlan 50
% VTP VLAN configuration not allowed when device is in client mode.
```

Attempting to create VLAN 50 on SW3 fails—only SW1 can create VLANs that propagate to clients.

---

## Access Port Configuration

### Assigning VLANs to End Devices

**Analogy**: If trunks are highways carrying all traffic, access ports are driveway entrances—each one leads to exactly one neighborhood (VLAN), so devices plug into their assigned VLAN membership.

**[[Access Port]]**: A port configured for a single [[VLAN]], with no [[802.1Q]] tagging on outgoing frames.

**`switchport access vlan [X]`**: Assigns the port to VLAN X; only untagged traffic on that VLAN uses this port.

| Switch | Port(s) | VLAN | Purpose |
|--------|---------|------|---------|
| SW1 | Fa0/1–2 | 10 | Access devices in VLAN 10 |
| SW1 | Fa0/3 | 20 | Access devices in VLAN 20 |
| SW2 | Fa0/1–2 | 40 | Access devices in VLAN 40 |
| SW3 | Fa0/1 | 10 | Access devices in VLAN 10 |
| SW3 | Fa0/2–3 | 30 | Access devices in VLAN 30 |
| SW3 | Fa0/4 | 20 | Access devices in VLAN 20 |

**SW1 Configuration**:
```
SW1(config)# interface range f0/1–2
SW1(config-if-range)# switchport mode access
SW1(config-if-range)# switchport access vlan 10
SW1(config-if-range)# exit

SW1(config)# interface f0/3
SW1(config-if)# switchport mode access
SW1(config-if)# switchport access vlan 20
```

**SW2 Configuration**:
```
SW2(config)# interface range f0/1–2
SW2(config-if-range)# switchport mode access
SW2(config-if-range)# switchport access vlan 40
```

**SW3 Configuration**:
```
SW3(config)# interface f0/1
SW3(config-if)# switchport mode access
SW3(config-if)# switchport access vlan 10
SW3(config-if)# exit

SW3(config)# interface range f0/2–3
SW3(config-if-range)# switchport mode access
SW3(config-if-range)# switchport access vlan 30
SW3(config-if-range)# exit

SW3(config)# interface f0/4
SW3(config-if)# switchport mode access
SW3(config-if)# switchport access vlan 20
```

---

## Exam Tips

### Question Type 1: VTP Mode Behavior
- *"Which VTP mode allows local VLAN creation but prevents VLAN updates from propagating?"* → **Transparent mode**
- **Trick**: Candidates confuse client mode (no local VLANs) with transparent mode (local VLANs allowed). Transparent mode forwards [[VTP]] frames but ignores them.

### Question Type 2: Trunk Negotiation Security
- *"Why is `switchport nonegotiate` recommended in production networks?"* → Prevents [[DTP]] attacks, eliminates negotiation delays, and guarantees trunk status.
- **Trick**: The exam assumes you know [[DTP]] can be exploited; always manually set trunk mode + nonegotiate.

### Question Type 3: VLAN Propagation
- *"You create VLAN 99 on SW2 (transparent mode). Why doesn't it appear on SW1 and SW3?"* → Transparent mode maintains independent VLAN database and doesn't propagate via [[VTP]].
- **Trick**: Students forget that transparent mode is a "firewall" for [[VTP]]—it receives and forwards messages but doesn't apply them.

### Question Type 4: Client Mode Restrictions
- *"A switch in VTP client mode attempts to create VLAN 50. What happens?"* → The command is rejected with a VTP client mode error.
- **Trick**: Clients are **read-only** for [[VLAN]] management; only the server can create VLANs that propagate.

---

## Common Mistakes

### Mistake 1: Forgetting to Disable DTP
**Wrong**: Configuring `switchport mode trunk` without `switchport nonegotiate`, then wondering why trunks flap or fail to negotiate.
**Right**: Always pair trunk mode with `switchport nonegotiate` to lock in the configuration.
**Impact on Exam**: You'll lose points on trunk stability questions, and the exam assumes you understand production-grade security practices.

### Mistake 2: Confusing VTP Client and Transparent Modes
**Wrong**: Assuming transparent mode is "off" and clients cannot create VLANs while transparent can.
**Right**: Transparent mode creates independent local VLANs without propagating; client mode creates nothing and only receives updates from the server.
**Impact on Exam**: This is a high-frequency mistake—the exam directly tests this distinction with scenario questions.

### Mistake 3: Assuming Access Ports Need VLAN Tagging
**Wrong**: Configuring `switchport trunk allowed vlan 10,20,30` on an access port.
**Right**: Access ports use `switchport access vlan [X]` (singular VLAN, no tagging).
**Impact on Exam**: You'll fail connectivity scenarios if you accidentally trunk an access port.

### Mistake 4: Misconfiguring VTP Domain Name
**Wrong**: Using different domain names on different switches (e.g., SW1 uses "CCNA", SW2 uses "CCNP").
**Right**: All switches in the same [[VTP]] domain must have identical domain names.
**Impact on Exam**: If domain names don't match, [[VTP]] never synchronizes—you'll diagnose a "broken" lab when the real issue is a typo.

### Mistake 5: Forgetting to Verify with `show` Commands
**Wrong**: Configuring trunks and access ports, then submitting without verifying with `show vlan brief`, `show vtp status`, or `show interfaces trunk`.
**Right**: Always verify configuration matches intent using display commands.
**Impact on Exam**: Simulation questions require you to prove the lab works—guessing without verification results in zero points.

---

## Related Topics
- [[DTP (Dynamic Trunking Protocol)]]
- [[VTP (VLAN Trunking Protocol)]]
- [[802.1Q Tagging]]
- [[Trunk Ports]]
- [[Access Ports]]
- [[VLAN Security Best Practices]]
- [[Switch Configuration Fundamentals]]

---

*Source: CCNA 200-301 Study Notes | [[CCNA]]*