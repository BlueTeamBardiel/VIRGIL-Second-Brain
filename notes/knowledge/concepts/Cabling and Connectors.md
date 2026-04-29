# Cabling and Connectors

## What it is
Like the circulatory system of a building, cables and connectors are the physical pathways that carry data between devices — and just like arteries, if they're exposed or compromised, everything downstream suffers. Precisely defined: cabling and connectors are the physical-layer (OSI Layer 1) media and termination points used to transmit signals between networked devices, including copper, fiber optic, and coaxial variants.

## Why it matters
A penetration tester conducting a physical assessment discovered an unlocked telecommunications closet where an attacker had spliced into a CAT6 cable using a vampire tap, passively intercepting unencrypted traffic for weeks without triggering a single alert. This is why physical access controls, cable shielding, and encrypted protocols matter even on internal networks — Layer 1 attacks bypass every firewall you own.

## Key facts
- **CAT5e vs CAT6 vs CAT6a**: CAT6 supports 10 Gbps up to 55 meters; CAT6a extends that to 100 meters — know the distance/speed tradeoffs for exam scenarios
- **Fiber optic (single-mode vs multi-mode)**: Single-mode supports longer distances (kilometers); multi-mode is cheaper but limited to ~550 meters — fiber is nearly impossible to tap without detection
- **Coaxial cable** uses RG-6 for cable internet and is susceptible to physical interception via induction taps
- **Shielded Twisted Pair (STP)** protects against electromagnetic interference (EMI) and crosstalk — required in high-interference environments like factories or near electrical equipment
- **Plenum-rated cabling** is required in air-handling spaces (ceilings/floors) because standard PVC cable releases toxic fumes when burned — a building code and safety compliance issue

## Related concepts
[[Physical Security Controls]] [[OSI Model]] [[Network Tapping and Interception]] [[Electromagnetic Interference]] [[Site Surveys]]