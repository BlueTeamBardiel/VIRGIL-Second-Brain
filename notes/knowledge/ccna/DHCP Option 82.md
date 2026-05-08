# DHCP Option 82

## What it is

In Valorant, when you ping an enemy spotted on A-site, the ping carries metadata — *who* called it, *where* on the map, *which* round. Your team doesn't just get "enemy spotted"; they get a tagged location stamp. **DHCP Option 82** does the same thing — the relay agent stamps each DHCP request with "this came from switch X, port Y, VLAN Z" before forwarding it to the server.

Technically: **Option 82** is the **DHCP Relay Agent Information Option** (RFC 3046), inserted by an intermediary device (Layer 3 switch, router, or [[DHCP Snooping]]-enabled switch) into client DHCPDISCOVER/REQUEST messages, providing the server with circuit and remote ID context.

## Why it matters

Without Option 82, the DHCP server only sees the client MAC and the relay's giaddr — it has no idea which physical port that client lives on. With Option 82, the server can hand out port-specific addresses, enforce per-port pool policies, or log exactly where a rogue client appeared. The catch: enable [[DHCP Snooping]] and many switches insert Option 82 by default — if your upstream DHCP server isn't Option 82-aware, it drops the packet because giaddr is 0.0.0.0 but Option 82 is present. Clients silently fail to get addresses. Exam-favorite gotcha.

## Key facts

### Sub-options inside Option 82

| Sub-option | Name | Contents |
|---|---|---|
| 1 | **Circuit ID** | Ingress interface, VLAN, module/port |
| 2 | **Remote ID** | Identifier of the relay agent (often MAC) |

### Who inserts it

- **[[DHCP Relay]] agents** (`ip helper-address` routers) — standard relay behavior.
- **[[DHCP Snooping]]** switches — insert Option 82 even on Layer 2 hops.

### The default-conflict problem

When [[DHCP Snooping]] is enabled on a Layer 2 switch:
- Switch inserts Option 82.
- giaddr stays **0.0.0.0** (Layer 2, no relay hop).
- Cisco IOS DHCP servers and many others see this combination as invalid → **drop**.

Two fixes — pick one:

```
! Option A: tell snooping to trust packets with Option 82 from giaddr=0
ip dhcp relay information trust-all

! Option B: stop inserting Option 82 entirely
no ip dhcp snooping information option
```

### Useful commands

```
! Global enable
ip dhcp snooping
ip dhcp snooping vlan 10,20

! Disable Option 82 insertion (the exam answer)
no ip dhcp snooping information option

! Per-interface — trust uplinks toward DHCP server
interface gi1/0/24
 ip dhcp snooping trust

! Verify
show ip dhcp snooping
show ip dhcp snooping binding
```

### Behavior summary

- **Inserted** going *toward* the server (client → server direction).
- **Stripped** coming back (server → client) before frame leaves the relay/snooping device.
- Server may **echo** Option 82 in DHCPOFFER/ACK; relay uses it to identify egress port.

## Related concepts

[[DHCP Snooping]] · [[DHCP Relay]] · [[ip helper-address]] · [[Dynamic ARP Inspection]] · [[IP Source Guard]] · [[Rogue DHCP Server]]

---
*Source: VIRGIL knowledge base — 2026-05-07*