# WiFi Pineapple CAIM

## What it is
Think of it as a digital talent agent that remembers every client who ever called — CAIM (Client and Access point Internet Monitor) is the WiFi Pineapple's built-in reconnaissance module that passively captures and logs all nearby wireless traffic metadata, cataloging probe requests from client devices and beacon frames from access points. It builds a persistent, searchable database of what devices are in range and what networks they're desperately advertising for.

## Why it matters
During a red team engagement, an operator deploys a WiFi Pineapple in a corporate lobby and runs CAIM for 30 minutes — the resulting logs reveal employee device MAC addresses and the exact SSIDs of their home networks, VPN concentrators, and corporate SSIDs. This intelligence directly feeds Evil Twin and karma attacks, because now the attacker knows precisely which network names to impersonate for maximum victim yield.

## Key facts
- CAIM operates **passively** by default — it does not transmit or associate, making it harder to detect than active scanning tools like airodump-ng
- Captures both **probe requests** (client devices broadcasting remembered SSIDs) and **beacon frames** (APs advertising themselves)
- Data is stored in a **SQLite database** on the Pineapple, queryable through the web UI or via SSH for offline analysis
- MAC addresses logged by CAIM can be cross-referenced with OUI databases to **fingerprint device manufacturers** and infer likely device types
- CAIM output is commonly used as the **reconnaissance phase input** before launching the PineAP suite for active deception attacks

## Related concepts
[[WiFi Pineapple PineAP]] [[Evil Twin Attack]] [[Probe Request Harvesting]] [[Karma Attack]] [[Passive Reconnaissance]]