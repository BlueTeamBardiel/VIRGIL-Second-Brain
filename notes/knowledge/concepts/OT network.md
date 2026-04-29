# OT network

## What it is
Think of it as the nervous system of a factory floor — instead of carrying sensation to a brain, it carries commands to physical machinery like turbines, valves, and assembly robots. An Operational Technology (OT) network is an infrastructure of hardware and software that monitors and controls physical industrial processes, distinct from IT networks that handle data and business logic. OT systems prioritize availability and safety above all else, making traditional IT security trade-offs dangerous to apply directly.

## Why it matters
In 2021, an attacker accessed the water treatment facility in Oldsmar, Florida via remote access software and attempted to increase sodium hydroxide levels to 111x the safe limit — a textbook OT attack targeting a SCADA system connected to the internet. An operator noticed the cursor moving and intervened manually, but the incident exposed how legacy OT environments with minimal authentication can directly threaten human lives. This is why network segmentation between OT and IT is now a critical control, not just best practice.

## Key facts
- OT networks use protocols like **Modbus, DNP3, PROFINET, and IEC 61850** — none of which were designed with authentication or encryption in mind
- The **Purdue Reference Model** (ISA-99/IEC 62443) defines OT network zones: Field Devices → Control Systems → Supervisory (SCADA) → Enterprise IT, with a **DMZ** separating OT from IT
- **Availability trumps confidentiality** in OT: patching a running turbine controller may be impossible without shutting down production
- OT devices often run **legacy, unpatched operating systems** (e.g., Windows XP) because vendor support contracts forbid modification
- The **Stuxnet worm** (2010) remains the canonical OT attack — it specifically targeted Siemens PLCs controlling Iranian centrifuges

## Related concepts
[[SCADA systems]] [[ICS security]] [[Network segmentation]] [[Purdue Model]] [[Industrial protocols]]