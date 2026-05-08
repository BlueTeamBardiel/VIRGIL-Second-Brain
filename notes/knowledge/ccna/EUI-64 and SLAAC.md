# EUI-64 and SLAAC

## What it is

In Street Fighter, when you pick Ryu, you don't fill out a form to get your hadoken — the move is derived from who you are. Your character identity already encodes your moveset. That's exactly what **EUI-64** does — it derives the host portion of an IPv6 address from the MAC address the NIC was born with, no server required.

**SLAAC** (Stateless Address Autoconfiguration) is the IPv6 mechanism by which a host learns a network prefix from a router and self-generates the remaining 64 bits to form a complete unicast address — without contacting a DHCP server.

## Why it matters

SLAAC is how IPv6 networks scale without per-host state. No DHCP lease table, no scope exhaustion, no server to fail. The flip side: classic EUI-64 leaks the MAC address into every packet you send, which is a privacy disaster — track a laptop across continents by the lower 64 bits. RFC 4941 privacy extensions exist because someone realized advertising your hardware serial number to the entire internet was, in fact, bad. **CCNA exam angle:** know the EUI-64 construction steps cold, recognize `ff:fe` in the middle of an interface ID, and know SLAAC vs. DHCPv6 trade-offs.

## Key facts

### The SLAAC flow

1. Host comes up, generates a [[link-local address]] (`fe80::/10` + interface ID) and runs [[DAD]] (Duplicate Address Detection).
2. Host sends an [[ICMPv6]] **Router Solicitation** (RS) to `ff02::2` (all-routers multicast).
3. Router replies with a **Router Advertisement** (RA) to `ff02::1`, carrying the **prefix** (typically `/64`), prefix lifetime, default gateway, and flags.
4. Host concatenates **prefix (64 bits) + interface ID (64 bits)** = full GUA.
5. Host runs DAD again on the new address.

RAs are also sent unsolicited every ~200 seconds by default.

### EUI-64 construction (the `ff:fe` trick)

Given MAC `00:1A:2B:3C:4D:5E`:

| Step | Result |
|------|--------|
| Split MAC in half | `00:1A:2B` \| `3C:4D:5E` |
| Insert `FF:FE` in the middle | `00:1A:2B:FF:FE:3C:4D:5E` |
| Flip the **U/L bit** (7th bit of 1st byte) | `02:1A:2B:FF:FE:3C:4D:5E` |
| Format as IPv6 interface ID | `021A:2BFF:FE3C:4D5E` |

The U/L bit flip: `00` (binary `00000000`) → `02` (binary `00000010`). The 7th bit being `0` in MAC means "universally administered"; in EUI-64 the convention inverts, so it becomes `1`. Yes, this is dumb. Yes, it's the standard.

With prefix `2001:db8:abcd:1::/64`, the full address is:
`2001:db8:abcd:1:21a:2bff:fe3c:4d5e`

If you see `ff:fe` parked in the middle of an interface ID, you're looking at EUI-64.

### RA flags that matter

| Flag | Meaning |
|------|---------|
| **A** (Autonomous) | Use this prefix for SLAAC |
| **M** (Managed) | Use [[DHCPv6]] for the address |
| **O** (Other config) | Use DHCPv6 only for DNS/other options (stateless DHCPv6) |

| M | O | Mode |
|---|---|------|
| 0 | 0 | Pure SLAAC |
| 0 | 1 | SLAAC + stateless DHCPv6 (address from SLAAC, DNS from DHCPv6) |
| 1 | x | Stateful DHCPv6 |

### Privacy extensions (RFC 4941 / 8981)

Modern OSes don't use EUI-64 by default. They generate a **random** 64-bit interface ID, rotate it periodically (often daily), and keep a stable address for inbound connections plus a temporary one for outbound. This breaks tracking by hardware address.

Windows since Vista, macOS, iOS, Android, and most Linux distros default to randomized IIDs. Cisco IOS still uses EUI-64.

### Cisco CLI

```
interface GigabitEthernet0/0
 ipv6 address 2001:db8:abcd:1::/64 eui-64
 ipv6 nd ra interval 200
 no ipv6 nd ra suppress
```

To force DHCPv6 instead of SLAAC on the segment:

```
interface GigabitEthernet0/0
 ipv6 nd managed-config-flag
 ipv6 nd prefix 2001:db8:abcd:1::/64 no-autoconfig
```

Verification:

```
show ipv6 interface GigabitEthernet0/0
show ipv6 neighbors
debug ipv6 nd
```

### SLAAC vs. DHCPv6

| | **SLAAC** | **DHCPv6** |
|---|---|---|
| State on server | None | Per-client lease |
| Address source | Self-generated | Server-assigned |
| DNS delivery | RA (RDNSS option) or stateless DHCPv6 | Native |
| Tracking/audit | Hard (no central log) | Easy |
| Android support | Yes | Historically no (still spotty) |
| Default gateway | Always from RA | Always from RA (never DHCPv6) |

Note the last row: **DHCPv6 never gives you a default gateway.** You need RAs running regardless. This trips people up.

## Related concepts

[[ICMPv6]] · [[NDP]] · [[Router Advertisement]] · [[DAD]] · [[Link-local address]] · [[DHCPv6]] · [[IPv6 addressing]] · [[Solicited-node multicast]]

---
*Source: VIRGIL knowledge base — 2026-05-07*