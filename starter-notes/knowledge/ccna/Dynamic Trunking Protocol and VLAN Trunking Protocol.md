# Dynamic Trunking Protocol and VLAN Trunking Protocol
**Tagline:** Master automated trunk negotiation and VLAN database synchronization—critical for scaling switched networks without manual misconfiguration.

---

## Overview

[[DTP]] and [[VTP]] automate two critical layer 2 functions: deciding which ports become trunks, and synchronizing VLAN databases across switches. Understanding when to use them (and when to disable them) is essential for exam success and real-world stability.

---

## Core Concept: Why Automation Matters

**Simple explanation:** Imagine manually telling every switch port "you're a trunk" or "you're access." Now multiply that across 50 switches. DTP says "Hey, if both sides agree, become a trunk automatically." VTP says "If I create VLAN 50, tell all my neighbors so they know about it too."

**Real detail:** DTP negotiates trunk status based on port mode configuration. VTP synchronizes the VLAN configuration database (VLAN names, numbers, and ranges) between switches in the same management domain, reducing manual VLAN creation overhead but introducing security risks if not properly managed.

---

## [[Dynamic & VLAN Trunking Protocol]] (DTP)

### What DTP Does

DTP is a Cisco proprietary protocol that automatically negotiates whether a link becomes a trunk or remains an access port. It exchanges DTP frames (sent to multicast MAC `01:00:0c:cc:cc:cc`) to agree on trunk status.

**Why it matters:** Saves configuration time but introduces negotiation failures if port modes are mixed incorrectly.

### DTP Negotiation Matrix

| Local Port Mode | Remote Port Mode | Result | Frames Sent |
|---|---|---|---|
| **access** | access | Access | None |
| **access** | trunk | Access | None |
| **access** | dynamic desirable | Access | None |
| **access** | dynamic auto | Access | None |
| **trunk** | trunk | Trunk | Both send DTP |
| **trunk** | dynamic desirable | Trunk | Both send DTP |
| **trunk** | dynamic auto | Trunk | Both send DTP |
| **dynamic desirable** | dynamic desirable | Trunk | Both send DTP |
| **dynamic desirable** | dynamic auto | Trunk | Both send DTP |
| **dynamic auto** | dynamic auto | Access | None |

**Critical exam detail:** `dynamic auto` + `dynamic auto` = **Access** (not trunk). One side must be `desirable`.

### DTP Port Modes Explained

| Mode | Behavior | Use Case |
|---|---|---|
| **access** | Never becomes trunk; sends no DTP | Access ports; safe default |
| **trunk** | Always a trunk; sends DTP | Trunk ports; stable |
| **dynamic desirable** | Tries to negotiate trunk (sends DTP proposals) | Legacy; not recommended |
| **dynamic auto** | Waits for other side to propose trunk (listens for DTP) | Legacy; not recommended |
| **nonegotiate** | Forced trunk; sends no DTP | Trunks to non-Cisco devices |

### DTP Security Risk

DTP allows a rogue device connected to an access port configured as `dynamic desirable` or `dynamic auto` to negotiate itself into a trunk, receiving traffic from all VLANs. This is a **VLAN hopping** vector.

### Disabling DTP

**Best practice:** Disable DTP on all ports. Explicitly configure trunks and access ports.

```
! On a trunk port:
interface GigabitEthernet0/1
  switchport mode trunk
  switchport nonegotiate

! On an access port:
interface GigabitEthernet0/2
  switchport mode access
  switchport nonegotiate
```

**Why `nonegotiate`?** Prevents DTP frames from being sent, reducing control plane overhead and eliminating negotiation failures. On access ports, it's implicit (access ports don't send DTP), but explicit is clearer.

---

## [[VLAN Trunking Protocol]] (VTP)

### What VTP Does

VTP synchronizes VLAN databases across a domain of switches. When you create a VLAN on a VTP **server**, all **clients** in that domain automatically learn it. This eliminates manual VLAN creation on every switch.

**Scope:** Only VLANs 1–4094 are synchronized; VLANs 1–1005 are stored in NVRAM; extended VLANs (1006–4094) exist only in running-config.

### VTP Synchronization Mechanism

Switches in a VTP domain exchange **VTP advertisements** containing:
- **Configuration revision number** (increments each VLAN change)
- **VLAN database** (VLAN ID, name, status)
- **Management domain name** (must match to synchronize)

A switch only updates its VLAN database if the received revision number is **higher** than its local number. This prevents old configs from overwriting new ones—unless a higher revision is reintroduced.

**Sync risk:** If you bring an old switch (with revision 50) back online when current switches are at revision 5, it will revert the entire network to that old VLAN config.

### VTP Modes

| Mode | Role | Receives Ads? | Sends Ads? | Stores Config? | Use Case |
|---|---|---|---|---|---|
| **Server** | Master | Yes | Yes | Yes (NVRAM) | Primary VLAN management point (1 per domain) |
| **Client** | Replica | Yes | Yes (forwards) | No (RAM only) | Standard switch; learns VLANs from server |
| **Transparent** | Independent | No | Yes (forwards) | Yes (NVRAM) | Standalone VLANs; exists in domain but isolated |
| **Off** (VTPv3) | Disabled | No | No | Yes (NVRAM) | Newest mode; VTP disabled entirely |

**Exam detail:** A **client** receiving VTP advertisements cannot create or modify VLANs locally—it can only learn them. Attempting `vlan 100` on a client fails.

### VTP Versions

| Version | Release | Key Features | Limitation |
|---|---|---|---|
| **VTPv1** | Catalyst 5000s | Basic VLAN sync | No extended VLAN support; no hidden VLANs |
| **VTPv2** | IOS 12.x | Token Ring support; hidden VLAN digest | Incompatible with v1; all switches must be v2 |
| **VTPv3** | IOS 15.x+ | Extended VLAN (1006–4094) support; **VTP off mode**; per-instance pruning; authentication | Backward-incompatible with v1/v2 |

**Critical exam distinction:** VTPv2 and v1 cannot coexist in the same domain. If any switch is v2, all must be v2. VTPv3 can interoperate with v2 in a limited way but requires explicit mode negotiation.

### Is VTP Dangerous?

**Yes.** VTP is rarely used in modern networks because:

1. **Unintended sync:** Creating a VLAN on the server propagates to all clients immediately—if misconfigured, breaks the network globally.
2. **Revision number attacks:** An old switch with a high revision can overwrite current VLAN configs network-wide.
3. **Lack of visibility:** VLAN changes propagate invisibly; clients don't know they've synced until behavior changes.
4. **No granular control:** Can't selectively sync certain VLANs; it's all-or-nothing per domain.

**Modern approach:** Disable VTP (`vtp mode off` in VTPv3) and manually create VLANs on each switch, or use **controller-based networks** (SD-WAN, fabric controllers).

---

## Lab Relevance: Cisco IOS Commands

### DTP Configuration

```bash
! View DTP status
show dtp interface GigabitEthernet0/1

! Set port mode
interface GigabitEthernet0/1
  switchport mode access              # Forces access, no DTP
  switchport mode trunk               # Forces trunk, sends DTP
  switchport mode dynamic desirable   # Proposes trunk (sends DTP)
  switchport mode dynamic auto        # Waits for proposal (listens)
  switchport nonegotiate              # Disables DTP on this port

! Verify trunk status and encapsulation
show interfaces trunk
show interfaces GigabitEthernet0/1 trunk

! View allowed VLANs on trunk
show interfaces GigabitEthernet0/1 switchport
```

### VTP Configuration

```bash
! View VTP status and revision number
show vtp status

! Set VTP mode (VTPv3)
vtp mode off                          # Disable VTP entirely (best practice)
vtp mode server                       # Enable server mode
vtp mode client                       # Enable client mode
vtp mode transparent                  # Independent, forwards ads

! Set management domain name
vtp domain SALES                      # Must match across switches to sync

! Set VTP version (if not using v3)
vtp version 2

! Configure VTP password (optional but recommended)
vtp password MySecurePassword

! View VTP advertisements being sent/received
debug vtp events                      # Verbose logging; disable with `undebug all`
show vtp devices                      # Lists neighbors in domain

! Check VLAN database in NVRAM (server/transparent modes only)
show vlan
show vlan id 100

! Verify client received VLANs
show vlan | include VLAN              # On client, shows synced VLANs
```

### Combining DTP and VTP in Labs

```bash
! Typical trunk configuration (best practice: explicit)
interface GigabitEthernet0/1
  description Trunk to Switch2
  switchport mode trunk
  switchport trunk native vlan 1
  switchport trunk allowed vlan 1,10,20,30
  switchport nonegotiate              ! Disable DTP

! Access port (explicit)
interface GigabitEthernet0/5
  description Access to PC1
  switchport mode access
  switchport access vlan 10
  switchport nonegotiate

! VTP disabled (modern best practice)
vtp mode off
vlan 10
  name Sales
vlan 20
  name Engineering
```

---

## Exam Tips: What CCNA Tests

### Likely Exam Questions

1. **DTP negotiation matrix:** "Two switches are connected. Switch A is `dynamic auto`, Switch B is `dynamic auto`. What is the resulting port state?"
   - **Answer:** Access (not trunk). One side must be `desirable`.
   - **Trap:** Candidates assume both dynamic = automatic trunk.

2. **DTP security vulnerability:** "A rogue device connects to an access port in `dynamic desirable` mode. What can happen?"
   - **Answer:** The rogue device negotiates a trunk and receives traffic from all VLANs (VLAN hopping).
   - **Key:** Know the specific port mode that enables this.

3. **VTP revision number scenario:** "A switch with VTP revision 75 is added to a domain at revision 5. What happens?"
   - **Answer:** The new switch overwrites all VLAN configs on the domain with its v75 database (disaster).
   - **Trap:** Candidates think the domain ignores old configs.

4. **VTP mode identification:** "A switch receives VTP advertisements but cannot create VLANs locally. What mode is it in?"
   - **Answer:** **Client mode.**
   - **Key:** Only servers and transparent switches can create VLANs; clients are read-only.

5. **VTP version compatibility:** "A VTPv2 domain contains one VTPv1 switch. What happens?"
   - **Answer:** The v1 switch is ignored; it doesn't participate in sync. All other v2 switches sync normally.
   - **Trap:** Candidates think the entire domain downgrades.

6. **Extended VLANs and VTP:** "Why don't extended VLANs (1006–4094) synchronize via VTPv2?"
   - **Answer:** VTPv2 doesn't support extended VLAN range (v3 does).

7. **DTP with `nonegotiate`:** "A trunk port is set to `switchport nonegotiate`. What happens?"
   - **Answer:** The port stays

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 13 | [[CCNA]]*
