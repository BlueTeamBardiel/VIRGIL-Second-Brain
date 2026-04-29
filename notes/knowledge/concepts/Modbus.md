# Modbus

## What it is
Think of Modbus like a walkie-talkie protocol from 1979 that industrial machines still use to shout commands at each other — no authentication, no encryption, just raw trust. Precisely: Modbus is a serial communication protocol originally developed by Modicon, used in SCADA and industrial control systems (ICS) to enable communication between PLCs, sensors, and master controllers over RS-232, RS-485, or TCP/IP (Modbus TCP).

## Why it matters
In 2015, attackers targeting Ukrainian power grid operators sent malicious Modbus commands over compromised SCADA connections to open circuit breakers, causing blackouts affecting 230,000 people. Because Modbus TCP carries no authentication whatsoever, any device on the network that can reach port 502 can issue legitimate-looking control commands — making network segmentation and strict access control lists the primary defenses, not the protocol itself.

## Key facts
- Modbus TCP operates on **port 502** — a critical number to memorize for exam scenarios involving ICS/OT traffic analysis
- The protocol has **zero built-in authentication or encryption** — commands are accepted from any sender by default
- Modbus uses a **master/slave (client/server) architecture** where one master polls multiple slave devices for data or sends control commands
- Function codes define operations: **FC01** reads coils (digital outputs), **FC03** reads holding registers, **FC16** writes multiple registers — attackers abuse these to manipulate physical processes
- Modbus is classified as an **OT (Operational Technology)** protocol, placing it under ICS security frameworks like IEC 62443 and NERC CIP

## Related concepts
[[SCADA Security]] [[Industrial Control Systems (ICS)]] [[DNP3]] [[Network Segmentation]] [[OT/IT Convergence]]