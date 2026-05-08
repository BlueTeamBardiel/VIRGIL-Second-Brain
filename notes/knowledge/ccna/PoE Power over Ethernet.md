# PoE Power over Ethernet

## What it is

In **Red Dead Redemption 2**, Arthur's horse carries everything — the rifles, the ammo, the pelts, the provisions — all on one animal walking down one trail. No second packhorse trotting behind hauling bullets separately. That's PoE: one Ethernet cable carries data *and* DC power to the device, no wall wart required.

**Power over Ethernet (PoE)** is an [[IEEE 802.3]] standard that delivers DC electrical power over the same twisted-pair copper cabling used for Ethernet data, eliminating the need for a separate power source at the powered device.

## Why it matters

You can't put a wall outlet on the ceiling next to every wireless [[Access Point]], every IP phone on every desk, or every security camera in a parking lot — and even if you could, an electrician costs more than a switch port. PoE collapses two installs into one cable run. When the **power budget** runs out, the switch starts denying power to ports and your shiny new APs come up dark — silently, often, until someone notices the WiFi map has holes.

Exam angle: know the wattage tiers, who's PSE vs PD, and the `power inline` modes cold.

## Key facts

### Roles

- **PSE — Power Sourcing Equipment**: the device supplying power. Usually a [[Cisco Catalyst]] switch with PoE-capable ports, or a [[PoE Injector]] (midspan).
- **PD — Powered Device**: the device receiving power. APs, IP phones, cameras, IoT sensors, badge readers.

### PoE standards

| Standard | Name | PSE Output | PD Available | Pairs Used |
|---|---|---|---|---|
| **802.3af** (2003) | PoE | 15.4 W | 12.95 W | 2 pairs |
| **802.3at** (2009) | PoE+ | 30 W | 25.5 W | 2 pairs |
| **802.3bt Type 3** (2018) | PoE++ / 4PPoE | 60 W | 51 W | 4 pairs |
| **802.3bt Type 4** (2018) | PoE++ / 4PPoE | 100 W | 71.3 W | 4 pairs |

The delta between PSE output and PD available is voltage drop across the cable run. Physics charges rent.

### Cisco proprietary predecessor

- **Cisco Inline Power (ILP)** predates 802.3af — 7 W per port. You'll see it on ancient kit. Don't deploy it; do recognize it.

### Power detection

The PSE detects a PD before energizing the line — it doesn't dump 48V into a random laptop. Detection uses a low-voltage signature (a 25kΩ resistance check). [[LLDP]] or [[CDP]] then negotiates the actual power class so the PSE allocates the right budget.

### Power budget

Each switch has a finite **PoE power budget** determined by its power supply. A 48-port switch with a 370W budget cannot run 48 ports at 30W (1440W). You either:

1. Buy a bigger PSU.
2. Mix high- and low-draw devices.
3. Watch ports get denied power in the order they request it.

### CLI — interface configuration

```
Switch(config)# interface gi1/0/1
Switch(config-if)# power inline ?
  auto       Automatically detect and power inline devices
  consumption Configure the inline device consumption
  never      Never apply inline power
  police     Enable policing of real-time power consumption
  static     Pre-allocate power for a port
```

| Mode | Behavior |
|---|---|
| **auto** (default) | Detect PD, negotiate class, allocate from budget. Standard behavior. |
| **static** | Reserve max power for the port whether a PD is connected or not. Guarantees power for critical PDs. Wastes budget if unused. |
| **never** | Disable PoE on this port entirely. For ports facing PCs or untrusted devices. |
| **police** | Cut power if PD draws more than negotiated. Without this, an over-drawing PD just keeps drinking. |

Set a maximum manually:
```
Switch(config-if)# power inline auto max 15400
```
(value in milliwatts — 15400 = 15.4W cap)

### Verification

```
Switch# show power inline
Switch# show power inline gi1/0/1 detail
Switch# show power inline police
```

`show power inline` output you should recognize:

```
Module   Available     Used     Remaining
         (Watts)       (Watts)  (Watts)
------   ---------     -------  ---------
1        370.0         62.5     307.5

Interface Admin  Oper       Power   Device              Class Max
                            (Watts)
--------- ------ ---------- ------- ------------------- ----- ----
Gi1/0/1   auto   on         15.4    IP Phone 7965       3     15.4
Gi1/0/2   auto   off        0.0     n/a                 n/a   30.0
Gi1/0/3   never  off        0.0     n/a                 n/a   0.0
```

### Budget-exceeded behavior

When a new PD requests power and the budget can't cover it:
- The port stays **operational for data** but **off for power**.
- Syslog logs `%ILPOWER-3-CONTROLLER_PORT_ERR: Controller port error, Interface Gi1/0/X: Power given, but Power Controller does not report Power Good`.
- Existing powered ports are *not* preempted — first-come, first-served. New PDs lose.

Mitigation: prioritize critical ports with `power inline static`, or add a redundant power supply (RPS) / upgrade the PSU.

### Pin usage trivia

- **Alternative A**: power on data pairs (1/2, 3/6) — common on switches.
- **Alternative B**: power on spare pairs (4/5, 7/8) — common on midspan injectors.
- **4-pair (802.3bt)**: all four pairs carry power. Required for >30W.

## Related concepts

[[IEEE 802.3]] · [[Access Layer]] · [[Cisco Catalyst]] · [[LLDP]] · [[CDP]] · [[Access Point]] · [[VoIP]] · [[PoE Injector]] · [[Power Supply Redundancy]] · [[Cisco UPOE]]

---
*Source: VIRGIL knowledge base*