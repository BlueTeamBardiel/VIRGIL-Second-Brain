# ESD

## What it is
Like a lightning bolt in miniature — a spark you can't see or feel — electrostatic discharge is the sudden flow of electricity between two objects with different electrical potentials. Precisely: ESD is an uncontrolled, instantaneous transfer of static charge that can destroy or degrade sensitive electronic components without leaving visible damage.

## Why it matters
In physical security and hardware forensics, an investigator mishandling a seized hard drive or RAM module without an anti-static wrist strap can silently destroy evidence — corrupting data on the platter or degrading NAND flash cells in ways that look like pre-existing failure rather than handler error. This same risk applies to red teams and hardware hackers implanting physical backdoors: improper ESD handling during device modification can brick the target device, tipping off defenders.

## Key facts
- ESD damage can occur from discharges as low as **100 volts** — far below the ~3,000V threshold humans can feel, meaning damage is invisible and deniable
- The **Human Body Model (HBM)** is the standard ESD test model simulating discharge from a person touching a component (~100pF capacitor, 1.5kΩ resistor)
- Anti-static controls include: **ESD wrist straps, anti-static bags (Faraday shielding), conductive foam, and grounded mats**
- ESD is a key concern in **secure hardware disposal and chain-of-custody** procedures — NIST SP 800-88 and evidence handling guidelines both address physical media protection
- **Latent ESD damage** is particularly dangerous: a component may function after discharge but fail weeks later under load, making root cause analysis extremely difficult

## Related concepts
[[Physical Security Controls]] [[Hardware Tampering]] [[Chain of Custody]] [[Faraday Cage]] [[Secure Media Disposal]]