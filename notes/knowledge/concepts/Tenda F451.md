# Tenda F451

## What it is
Like a cheap padlock sold at a dollar store with the key pattern stamped on the outside, the Tenda F451 is a budget consumer-grade ADSL2+ modem/router that ships with hardcoded credentials and known unpatched vulnerabilities baked into its firmware. It is a SOHO (Small Office/Home Office) networking device manufactured by Tenda Technology that has been publicly identified as containing multiple critical security flaws including remote code execution vulnerabilities.

## Why it matters
In IoT botnet campaigns like Mirai and its derivatives, devices exactly like the Tenda F451 are primary targets — attackers scan for Telnet/HTTP management interfaces using default credentials (admin/admin) and conscript them into DDoS botnets within minutes of internet exposure. A compromised F451 can serve as a pivot point into a home or small business network, enabling traffic interception, DNS hijacking, and lateral movement to connected endpoints.

## Key facts
- Contains hardcoded default credentials (`admin`/`admin`) that many users never change, creating a persistent authentication bypass condition
- Remote Code Execution (RCE) vulnerabilities have been documented in its web management interface via crafted HTTP POST requests — no authentication required in some CVEs
- Firmware update mechanisms are absent or non-functional in many deployed units, leaving discovered vulnerabilities permanently unpatched
- Runs a stripped Linux-based OS with BusyBox, common across low-cost routers and exploitable with shared toolchains
- Classified as an embedded system with an exposed attack surface: Telnet (port 23), HTTP (port 80), and sometimes TR-069 (port 7547)

## Related concepts
[[Default Credentials]] [[SOHO Router Vulnerabilities]] [[Mirai Botnet]] [[Remote Code Execution]] [[Firmware Analysis]]