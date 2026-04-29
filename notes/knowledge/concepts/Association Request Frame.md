# Association Request Frame

## What it is
Think of it like a job application: the client device fills out a detailed form listing its capabilities and hands it to the HR desk (the access point) asking to be formally hired onto the network. Precisely, an Association Request Frame is an IEEE 802.11 management frame sent by a client (STA) to an access point after successful authentication, requesting permission to join the BSS and establishing a logical connection to use the network. It carries the client's supported rates, SSID, RSN capabilities, and other parameters needed to negotiate the connection.

## Why it matters
In a **deauthentication/disassociation attack**, an adversary spoofs management frames to kick legitimate clients off the network, forcing them to re-authenticate and re-associate — capturing the Association Request Frame in the process to harvest SSID details, supported cipher suites, and RSN information elements that inform further attacks like downgrade or PMKID harvesting. Defending with **Management Frame Protection (802.11w)** prevents spoofed disassociation frames but does not encrypt Association Requests themselves, so SSID and capability leakage remains a passive intelligence risk.

## Key facts
- Sent **after** Open System Authentication (or SAE handshake in WPA3) but **before** the client can pass data frames
- Contains the **SSID**, **supported data rates**, **RSN Information Element** (advertised cipher suites and AKMs), and **Listen Interval**
- The AP responds with an **Association Response Frame** containing an **Association ID (AID)** — a 16-bit value unique to the session
- Transmitted in **cleartext** — even on WPA2/WPA3 networks — making capability enumeration trivial via passive sniffing
- Captured during a **PMKID attack** (Hcxdumptool/Hashcat workflow) because the PMKID can be derived from the RSN IE exchanged during association

## Related concepts
[[Deauthentication Attack]] [[Management Frame Protection (802.11w)]] [[WPA2 4-Way Handshake]] [[Beacon Frame]] [[Evil Twin Attack]]