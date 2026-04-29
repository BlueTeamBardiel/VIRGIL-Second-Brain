# Public Switched Telephone Network

## What it is
Think of it as the world's oldest internet — a global mesh of copper wires, fiber, and switching stations that evolved over 140 years to connect any phone to any other phone on Earth. The PSTN is the legacy circuit-switched telephone infrastructure operated by carriers worldwide, using dedicated physical connections (circuits) established for the duration of each call. Unlike packet-switched networks, PSTN reserves bandwidth end-to-end before a single word is spoken.

## Why it matters
War dialing attacks — popularized by the movie *WarGames* — involve automatically scanning thousands of PSTN numbers to find modems, fax machines, or PBX systems connected to corporate networks. A penetration tester using a tool like ToneLoc discovers an unlisted modem on a company's analog line that bypasses the entire perimeter firewall, giving direct access to internal systems that IT forgot existed. This is why legacy PSTN connections are a serious attack surface even in modern environments.

## Key facts
- PSTN uses **SS7 (Signaling System 7)** for call setup and routing — SS7 vulnerabilities allow attackers to intercept calls, redirect SMS messages, and track physical location globally
- **PBX (Private Branch Exchange)** systems connect corporate phone infrastructure to PSTN and are frequent targets for toll fraud, costing businesses billions annually
- **VoIP gateways** bridge PSTN and IP networks, creating a hybrid attack surface where traditional phone exploits meet network-layer attacks
- SS7 attacks have been used to defeat **SMS-based MFA**, intercepting one-time codes sent to victims' phones
- PSTN wiretapping historically required physical access; SS7 exploits enable passive interception **without touching the line**

## Related concepts
[[SS7 Protocol Vulnerabilities]] [[Voice over IP Security]] [[War Dialing]] [[PBX Security]] [[Multi-Factor Authentication Bypass]]