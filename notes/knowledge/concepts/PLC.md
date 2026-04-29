# PLC

## What it is
Think of a PLC like a extremely reliable, single-minded foreman on a factory floor — it reads sensor inputs, executes a fixed logic program, and drives physical outputs (valves, motors, conveyors) in a tight loop, ignoring everything else. A **Programmable Logic Controller** is an industrial hardened computer designed to automate electromechanical processes in manufacturing, utilities, and critical infrastructure. Unlike general-purpose computers, PLCs prioritize deterministic, real-time control over flexibility or security.

## Why it matters
Stuxnet (2010) is the textbook case: attackers compromised Siemens S7 PLCs controlling Iranian uranium centrifuges, subtly altered their speed commands while feeding false "all normal" data back to operators — physically destroying centrifuges while evading detection for months. This demonstrated that cyberattacks could cause kinetic, real-world destruction through compromised PLCs, fundamentally changing how we view critical infrastructure risk.

## Key facts
- PLCs communicate using industrial protocols like **Modbus, DNP3, and EtherNet/IP** — most of which were designed with zero authentication or encryption
- PLC logic is written in **ladder logic, function block diagram (FBD), or structured text** — not traditional code — making analysis difficult for traditional security teams
- PLCs are classified as **Operational Technology (OT)** and fall under frameworks like **ICS-CERT** advisories and **NERC CIP** compliance standards
- Default credentials and unpatched firmware are endemic; many PLCs have **lifecycles of 20+ years** with no patch mechanism
- Network segmentation via **industrial DMZs** and the **Purdue Model** are primary defensive architectures to isolate PLCs from IT networks

## Related concepts
[[SCADA]] [[Industrial Control Systems (ICS)]] [[Modbus]] [[OT Security]] [[Purdue Model]]