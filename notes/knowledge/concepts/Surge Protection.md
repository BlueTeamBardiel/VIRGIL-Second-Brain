# Surge Protection

## What it is
Like a pressure-relief valve on a water pipe that absorbs a sudden burst before it blows out your faucet, a surge protector absorbs sudden spikes in electrical voltage before they can fry your hardware. Precisely, surge protection refers to devices and mechanisms (MOVs, TVS diodes, or whole-building arrestors) that clamp transient overvoltages to safe levels, protecting computing equipment from damage caused by lightning strikes, power grid fluctuations, or switching events.

## Why it matters
In 2003, the Northeast blackout cascaded through interconnected grids, and when power was restored, unprotected equipment across hospitals and data centers suffered voltage spikes that destroyed NICs, storage controllers, and servers — effectively causing a physical-layer denial of service. A properly specified UPS with surge suppression rating (measured in joules) would have absorbed those transients before they reached sensitive components.

## Key facts
- Surge protection capacity is rated in **joules** — higher joule ratings absorb larger or repeated surges; a minimum of 1,000–2,000 joules is recommended for server equipment
- **MOVs (Metal Oxide Varistors)** are the core component in most consumer surge protectors; they degrade with each absorbed surge and eventually fail silently, offering no protection
- Surge protectors are distinct from **UPS (Uninterruptible Power Supplies)** — UPS provides battery backup AND surge protection; a plain power strip offers neither
- For Security+ and CySA+, surge protection falls under **environmental controls** in the physical security and operational resilience domain
- Whole-facility protection requires a **layered approach**: utility-grade arrestors at the service entrance, panel-level protection, and point-of-use devices at equipment

## Related concepts
[[Physical Security Controls]] [[Uninterruptible Power Supply]] [[Environmental Controls]] [[Business Continuity Planning]] [[Fault Tolerance]]