# SCADA

## What it is
Think of SCADA like the nervous system of a power plant — sensors scattered across miles of pipeline send readings back to a central brain that decides when to open valves or trip breakers. Formally, Supervisory Control and Data Acquisition (SCADA) is an industrial control system (ICS) architecture that collects real-time data from remote sensors and actuators, then allows operators to monitor and control physical processes — power grids, water treatment, oil pipelines — from a central location.

## Why it matters
In 2021, an attacker gained remote access to the Oldsmar, Florida water treatment facility's SCADA system and briefly increased sodium hydroxide levels to 111x the safe limit — a near-miss that required only an alert operator catching the change manually. This attack exposed a critical truth: SCADA systems were designed decades ago for reliability and availability, not security, leaving them exposed when connected to modern IP networks.

## Key facts
- SCADA communicates using legacy industrial protocols like **Modbus**, **DNP3**, and **OPC**, which have no built-in authentication or encryption
- The **Purdue Model** (ISA/IEC 62443) defines a security reference architecture for ICS/SCADA networks using hierarchical zones to separate corporate IT from operational technology (OT)
- SCADA systems prioritize **Availability** over Confidentiality and Integrity — the CIA triad is intentionally inverted for OT environments
- **Air-gapping** (physically isolating SCADA networks) was the traditional defense, but Stuxnet proved even air-gapped systems can be compromised via USB-delivered malware
- Security+ exam expects you to know SCADA falls under **ICS/OT security**, distinct from traditional IT, with longer patch cycles and 24/7 uptime requirements making patching extremely difficult

## Related concepts
[[Industrial Control Systems]] [[Modbus Protocol]] [[Purdue Model]] [[Air Gap]] [[Stuxnet]]