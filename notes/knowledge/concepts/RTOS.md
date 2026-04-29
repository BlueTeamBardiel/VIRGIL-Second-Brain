# RTOS

## What it is
Think of a concert conductor who must cue every musician within milliseconds — miss the beat and the performance collapses. A Real-Time Operating System (RTOS) is an OS designed to process inputs and produce outputs within strict, guaranteed time windows called deadlines. Unlike general-purpose OSes that optimize for throughput, an RTOS prioritizes deterministic, predictable timing above everything else.

## Why it matters
In 2021, researchers discovered vulnerabilities in FreeRTOS (dubbed "URGENT/11" class flaws) allowing remote code execution on medical devices, industrial controllers, and smart home equipment. Because RTOS environments rarely support patching pipelines or endpoint detection agents, a compromised pacemaker controller or factory PLC can persist indefinitely — attackers gain persistent, unmonitored footholds inside critical infrastructure where traditional security tooling simply doesn't reach.

## Key facts
- RTOS software powers **safety-critical embedded systems**: medical devices, aircraft avionics, automotive ECUs, and industrial SCADA/ICS components
- They operate under **hard real-time constraints** (missed deadline = system failure) versus soft real-time (missed deadline = degraded performance only)
- Common RTOS platforms include **FreeRTOS, VxWorks, QNX, and ThreadX** — each with distinct CVE histories worth knowing
- RTOS devices frequently **lack memory protection, ASLR, or DEP**, making exploitation straightforward once network access is achieved
- Securing RTOS environments relies heavily on **network segmentation, firmware signing, and air-gapping** because traditional AV/EDR cannot run on them

## Related concepts
[[Embedded Systems Security]] [[ICS/SCADA Security]] [[Firmware Analysis]] [[Network Segmentation]] [[CVE]]