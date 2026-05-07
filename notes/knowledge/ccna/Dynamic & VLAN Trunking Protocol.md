# Dynamic & VLAN Trunking Protocol

## What it is

DTP modes pair up like matchmaking in a fighting game — each port has a stance, and whether a fight (trunk) actually happens depends on what both sides bring to the lobby. Two "desirable" players? Trunk forms instantly. One "auto" sitting there waiting and nobody asking? Nothing happens. One side hardcoded to "access"? Match cancelled.

**Dynamic Trunking Protocol (DTP)** is Cisco's auto-negotiation mechanism that decides whether a switch port becomes a **trunk** (carrying multiple VLANs, tagged with 802.1Q) or an **access** port (one VLAN, untagged). Instead of forcing an admin to manually set every link, DTP lets two switches sniff each other out and agree.

**VLAN Trunking Protocol (VTP)** is the sibling that handles VLAN database synchronization. Think of it like a shared Google Doc for VLAN definitions — one switch creates VLAN 50 "Finance," and every other switch in the same VTP domain auto-updates. Convenient. Also terrifying when it breaks.

## Why it matters

DTP and VTP are convenience features that became attack surfaces. They're the network equivalent of leaving your Steam account on auto-accept-friend-request — until some rando with a spoofed switch joins your domain and rewrites your entire VLAN list.

Two of the classic Layer 2 attacks — **VLAN hopping** and **VTP poisoning** — exist because these protocols were designed when "the LAN" was assumed to be a trusted clubhouse. It isn't. Any user-facing port is a potential entry for an attacker plugging in a laptop running Yersinia or Scapy and pretending to be a switch.

If you've played Watch Dogs 2 and watched Marcus pivot through a corporate network by hijacking infrastructure, this is the boring real-world version: misconfigured trunk negotiation = free lateral movement across VLANs that were supposed to be isolated.

## Key facts

### DTP — the four modes

The modes behave like Tinder preferences for ports. Two have to swipe compatibly for a trunk to form.

- **access** — Hard "no." Never trunks, regardless of what the other side wants. The only mode you should ever see on a port a human plugs into.
- **trunk** — Hard "yes." Always trunks, no negotiation needed. Use on confirmed switch-to-switch links.
- **dynamic auto** — Passive. Will trunk *only if* the other side actively asks. Default on many older Cisco switches, which is exactly the problem.
- **dynamic desirable** — Active. Sends DTP frames trying to form a trunk. Pairs with anything except `access` or `nonegotiate`.

| Local \ Remote | access | trunk | dyn auto | dyn desirable |
|---|---|---|---|---|
| **access** | access | ❌ mismatch | access | access |
| **trunk** | ❌ mismatch | trunk | trunk | trunk |
| **dyn auto** | access | trunk | access | trunk |
| **dyn desirable** | access | trunk | trunk | trunk |

- **`switchport nonegotiate`** — disables DTP frames entirely. The "leave me alone" button. Combine with a manually set mode (`access` or `trunk`) for ports that should never be guessing.

### VLAN hopping — two flavors

**Switch spoofing:** Attacker's machine runs DTP and pretends to be a switch in `dynamic desirable` mode. If your port is left in `dynamic auto` (the historical default), it happily forms a trunk. Now the attacker sees every VLAN. Like joining a Discord server and discovering every private channel is suddenly visible because nobody set role permissions.

**Double tagging:** Attacker crafts an 802.1Q frame with *two* VLAN tags. The first switch strips the outer tag (because it matches the **native VLAN**) and forwards the frame across the trunk. The next switch sees the inner tag and delivers the frame into a VLAN the attacker should never reach. One-way attack — no return traffic — but plenty for spraying exploits or DoS.

- **Mitigation 1:** Set user ports to `switchport mode access` + `switchport nonegotiate`. No DTP, no spoofing.
- **Mitigation 2:** Set the **native VLAN** on trunks to an unused VLAN ID (not VLAN 1, not any production VLAN). Native VLAN mismatches on a trunk are themselves a hopping vector.
- **Mitigation 3:** Tag the native VLAN explicitly (`vlan dot1q tag native`) so nothing rides untagged.

### VTP — the three modes

VTP runs in a **management domain** (just a name string). All switches sharing that name sync their VLAN database via advertisements. The dangerous part is the **revision number**.

- **Server mode** — read/write. Can create, modify, delete VLANs. Changes increment the revision number and propagate.
- **Client mode** — read-only locally, but still accepts and applies updates from any server with a higher revision number.
- **Transparent mode** — the bunker. Doesn't participate in VTP sync, doesn't apply incoming VTP updates, only forwards them. Local VLAN config is independent. This is how you opt out of the chaos.

### The VTP revision number vulnerability

The revision number is a global counter — highest number wins, and switches don't authenticate where it came from beyond a weak domain-name check. Plug a switch in with the right domain name and a revision number higher than your production servers, and **your entire VLAN database gets overwritten** by whatever that rogue switch was holding. Including, potentially, an empty one. Every access port suddenly belongs to a VLAN that doesn't exist. Production goes dark.

This is the networking equivalent of a save file with a higher timestamp overwriting your 80-hour Elden Ring run because cloud sync trusted the wrong device.

- A switch's revision number resets to 0 only when its **VTP domain name changes** or it's set to **transparent mode**. Used switches pulled from a lab and reracked are a classic poisoning vector.
- **Mitigation:** Use VTP transparent mode on edge/access switches, or set a **VTP password** on the domain, or just don't use VTP — manually configure VLANs (or use VTPv3, which adds primary-server roles and stronger controls).

### Quick hardening checklist

- User ports: `switchport mode access` + `switchport nonegotiate`
- Trunk ports: explicit `switchport mode trunk` + `switchport nonegotiate`
- Native VLAN: unused ID, consistent on both ends, ideally tagged
- Unused ports: shutdown + assigned to a black-hole VLAN
- VTP: transparent mode, or VTPv3 with authentication, or off

## Related concepts

[[802.1Q VLAN tagging]]
[[Native VLAN]]
[[Switch spoofing attack]]
[[Double tagging attack]]
[[Yersinia]]
[[Layer 2 security]]
[[Port security]]
[[BPDU Guard]]
[[Private VLANs]]
[[VTPv3]]
[[Cisco IOS switchport commands]]