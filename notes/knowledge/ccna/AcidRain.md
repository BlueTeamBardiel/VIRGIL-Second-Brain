# AcidRain

## What it is
Imagine a janitor who, instead of mopping floors, systematically destroys every piece of equipment in a building by overwriting it with garbage — that's AcidRain. It is a destructive wiper malware targeting embedded Linux systems, specifically designed to brick modems and routers by recursively overwriting all accessible storage devices with random data, rendering them permanently inoperable.

## Why it matters
On February 24, 2022 — the exact day Russia launched its ground invasion of Ukraine — AcidRain was deployed against Viasat's KA-SAT satellite network, wiping tens of thousands of modems across Europe. This attack knocked out Ukrainian military communications and caused collateral damage to wind farms and ISPs in Germany and France, demonstrating how firmware-targeting wipers can serve as precision cyber weapons coordinated with kinetic military operations.

## Key facts
- AcidRain targets `/dev` device files directly, iterating through them to overwrite flash storage — including `/dev/mtd*` block devices common in embedded systems
- Attribution by ESET and Mandiant linked AcidRain to Sandworm (APT44), a Russian GRU-affiliated threat actor
- Unlike traditional malware, AcidRain requires no persistence mechanism — destruction is its only goal, making detection before execution critical
- The malware is an ELF binary compiled for MIPS architecture, targeting the specific CPU family used in many consumer and enterprise modems
- Recovery from AcidRain infection typically requires physical replacement of the device, as the firmware is irreparably corrupted — over 10,000 modems needed hardware swaps

## Related concepts
[[Wiper Malware]] [[Sandworm APT]] [[Firmware Attacks]] [[Supply Chain Attack]] [[ICS/SCADA Security]]