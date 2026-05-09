# Power Resiliency

## What it is

In Fortnite, the storm closes in and you're sprinting toward the eye when your generator-loving teammate brings out a Chug Cannon, a Med-Mist, and a stack of shields — backups stacked behind backups, because one bandage isn't going to keep you breathing in the final circle. That's exactly what power resiliency does — it stacks layered electrical backups so the lights, servers, and access controls keep breathing when the main supply dies.

**Power resiliency** is the set of architectural controls (UPS, generators, PDUs, dual feeds, managed power transfer) that maintain availability of compute and facility systems during electrical disruption.

## Why it matters

When utility power drops and you have no resiliency, you don't get a graceful shutdown — you get corrupted databases, fried disks, dropped transactions, and a smoking domain controller. Availability is the "A" in CIA, and downtime is a control failure that breaks SLAs, HIPAA availability requirements, and PCI 24/7 logging mandates. Exam-wise, **Objective 3.4** lists *generators* and *uninterruptible power supplies* explicitly under resilience and recovery; CompTIA's classic trap is conflating the two — a **UPS** bridges the gap (seconds to minutes), a **generator** sustains the load (hours to days). Pick the wrong one on a scenario question and you fail the system.

## Key facts

### Uninterruptible Power Supply (UPS)

A battery-backed device that delivers immediate, short-duration power to ride through outages or hand off to a generator.

| Type | Transfer Time | Use Case |
|---|---|---|
| **Standby (Offline)** | 5–12 ms | Workstations, low-criticality |
| **Line-Interactive** | 2–4 ms | SMB servers, network gear |
| **Online (Double-Conversion)** | 0 ms | Data centers, critical loads |

- Sized in **VA** (volt-amperes) and **runtime minutes**.
- Conditions power: filters [[sags]], [[surges]], [[brownouts]], [[transients]].
- Not a long-term solution — its job is to keep you alive until the generator spins up or you shut down cleanly.

### Generator

An on-site engine (diesel, natural gas, propane) that produces power for sustained outages.

- **Start time**: typically 10–30 seconds — which is why you need the [[UPS]] in front of it.
- **Fuel** is the constraint: diesel tanks need [[fuel polishing]] and runtime planning. A generator with empty tanks is yard art.
- **Automatic Transfer Switch (ATS)** detects utility failure and cuts the load to generator power.
- Requires **monthly load testing** — untested generators fail when you actually need them. CompTIA loves this point.

### Layered Architecture

| Layer | Role | Duration |
|---|---|---|
| **Utility feed** | Primary | Indefinite (when working) |
| **UPS** | Bridge | Seconds–minutes |
| **Generator** | Sustained backup | Hours–days |
| **Dual power supplies** | Component-level redundancy | Per-device |
| **Dual utility feeds** | Distinct substations | Carrier-level redundancy |

### Supporting Components

- **[[PDU]]** (Power Distribution Unit) — rack-level distribution; managed PDUs allow remote outlet control.
- **[[Redundant Power Supplies]]** — hot-swappable, dual-corded servers fed from **A and B** rails.
- **[[Managed Power]]** — monitoring via SNMP for load, temperature, runtime estimates.
- **Grounding and bonding** — prevents [[ground loops]] and ESD damage.

### Threats Power Resiliency Mitigates

- **Blackout** — total loss of utility power.
- **Brownout** — sustained voltage drop; arguably worse than a blackout because equipment runs sick instead of off.
- **Surge / Spike** — overvoltage events from grid switching or lightning.
- **Sag** — short undervoltage event.
- **Frequency variation** — drift from 60 Hz (or 50 Hz) that destabilizes synchronous loads.

### Exam Traps

- UPS ≠ generator. UPS = **short-term battery**. Generator = **long-term fuel**.
- A surge protector is **not** a UPS — it absorbs spikes, it does not provide runtime.
- "Cold site" power readiness is a [[recovery site]] question, not a power-resiliency question — read carefully.

## Related concepts

[[Uninterruptible Power Supply]] · [[Generator]] · [[PDU]] · [[Redundant Power Supplies]] · [[High Availability]] · [[Site Resiliency]] · [[Capacity Planning]] · [[HVAC]] · [[Fault Tolerance]] · [[Business Continuity]]

---
*Source: VIRGIL knowledge base — 2026-05-08*