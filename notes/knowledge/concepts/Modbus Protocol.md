# Modbus Protocol

## What it is
Think of Modbus like a walkie-talkie system in a factory — one radio (master) calls out commands, and the others (slaves) respond with no questions asked, no passwords, no verification. Modbus is a serial communication protocol developed in 1979 for PLCs (Programmable Logic Controllers) that uses a simple master/slave architecture to read and write registers on industrial devices. It operates over serial lines (RTU/ASCII) or TCP/IP networks (Modbus TCP, port 502) and was designed for reliability, not security.

## Why it matters
In the 2021 Oldsmar water treatment attack, attackers gained remote access and manipulated chemical dosing controls — systems that very likely used legacy protocols like Modbus with zero authentication. Because Modbus TCP accepts any command from any connected host on port 502, an attacker on a poorly segmented OT network can read sensor values or force actuator states without any credentials, potentially causing physical damage or public safety incidents.

## Key facts
- Modbus has **no built-in authentication, encryption, or authorization** — any device that can reach port 502 can issue commands
- Modbus TCP uses **port 502** over standard IP networks; this is the most commonly targeted variant
- Two primary data models: **Coils** (single-bit read/write) and **Registers** (16-bit values); attackers can read process states or inject false values
- Classified as an **OT (Operational Technology)** protocol — appears heavily in ICS/SCADA security contexts on CySA+ exams
- Mitigation relies on **network segmentation**, unidirectional gateways, and protocol-aware firewalls since the protocol itself cannot be patched for security

## Related concepts
[[SCADA Systems]] [[ICS Security]] [[OT Network Segmentation]] [[DNP3 Protocol]] [[Defense-in-Depth]]