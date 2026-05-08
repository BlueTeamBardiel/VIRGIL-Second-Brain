# IP Source Guard

## What it is

In Tetris, every piece that drops has to fit the grid — an S-block can't suddenly claim to be an I-piece, and the game refuses to place anything that doesn't match what was actually queued. That's exactly what IP Source Guard does — it checks every incoming packet against a registry of which IP address legitimately belongs on which port, and drops anything trying to claim an identity that wasn't issued to it.

**IP Source Guard (IPSG)** is a Layer 2 security feature that filters ingress traffic on untrusted access ports, permitting only frames whose source IP (and optionally source MAC) match an entry in the [[DHCP Snooping]] binding table or a static IP source binding.

## Why it matters

Without IPSG, an attacker on an access port can manually configure any IP they want — including the IP of a server, the default gateway, or another user — and send traffic as that victim. This enables [[IP spoofing]] attacks, session hijacking, and bypassing IP-based ACLs. IPSG is the third pillar of the L2 security triad and the layer that finally stops manually-assigned spoofed IPs that [[DHCP Snooping]] alone can't catch.

**Exam angle:** know the dependency chain — IPSG is useless without DHCP Snooping populating the binding table, and remember it operates on **ingress** at **untrusted access ports**.

## Key facts

### The L2 Security Triad

The three features stack and depend on each other in this order:

| Order | Feature | Protects Against | Inspects |
|-------|---------|------------------|----------|
| 1 | [[DHCP Snooping]] | Rogue DHCP servers, DHCP starvation | DHCP messages |
| 2 | [[Dynamic ARP Inspection]] (DAI) | ARP poisoning / MITM | ARP packets |
| 3 | **IP Source Guard** | Manual IP spoofing | All IP traffic |

[[DHCP Snooping]] builds the binding table. [[Dynamic ARP Inspection]] and **IP Source Guard** both consume it. Skip step one and the other two have no source of truth.

### The DHCP Snooping Binding Table

The single source of truth IPSG queries. Each entry contains:

- **MAC address**
- **IP address**
- **Lease time**
- **Binding type** (dynamic / static)
- **VLAN**
- **Interface**

### Two filtering modes

Configured per-interface with `ip verify source`:

```
! IP-only filtering (default)
Switch(config)# interface gi0/1
Switch(config-if)# ip verify source

! IP + MAC filtering (stricter)
Switch(config-if)# ip verify source port-security
```

| Mode | Command | Checks | Requires |
|------|---------|--------|----------|
| **IP-only** | `ip verify source` | Source IP matches binding | DHCP Snooping |
| **IP + MAC** | `ip verify source port-security` | Source IP **and** MAC match binding | DHCP Snooping + [[Port Security]] with DHCP option 82 |

### Static bindings

For devices with statically-configured IPs (printers, servers) that never speak DHCP, you must add manual entries or they'll be filtered:

```
Switch(config)# ip source binding 0011.2233.4455 vlan 10 192.168.1.50 interface gi0/2
```

### What gets blocked

- Host configures an IP not assigned by DHCP → **dropped**
- Host spoofs another user's IP → **dropped**
- Host spoofs the gateway IP → **dropped**
- DHCP traffic itself → **always permitted** (otherwise the host could never get a lease)

### Verification

```
Switch# show ip verify source
Switch# show ip source binding
```

### Gotchas

- Enable on **untrusted access ports only** — never on trunks or uplinks toward the DHCP server.
- No DHCP Snooping binding table = everything (except DHCP) gets dropped. Many a lab has died this way.
- Static IP hosts need explicit `ip source binding` entries or they're collateral damage.

## Related concepts

[[DHCP Snooping]] · [[Dynamic ARP Inspection]] · [[Port Security]] · [[IP spoofing]] · [[Layer 2 Security]] · [[ARP poisoning]] · [[Access Ports]]

---
*Source: VIRGIL knowledge base*