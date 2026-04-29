# IP Geolocation

## What it is
Like reading a postmark on an envelope to guess where a letter was mailed from, IP geolocation maps an IP address to an approximate physical location (country, city, ISP) by cross-referencing databases of registered address blocks. It doesn't pinpoint a device precisely — it identifies where the IP block is *registered*, which may differ significantly from where the user actually sits.

## Why it matters
A SOC analyst investigating a login attempt notices that an employee's account authenticated from Lagos at 2 AM, then from Chicago four minutes later — a physical impossibility called an *impossible travel* alert. IP geolocation data fed into a SIEM triggers this anomaly detection, flagging the credential as likely compromised. Attackers counter this by routing traffic through VPNs or Tor exit nodes in the target's home country to bypass geolocation-based controls.

## Key facts
- IP geolocation accuracy degrades at each level: country (~95% accurate), city (~60-80%), street address (unreliable without additional data)
- Geolocation databases (MaxMind, IP2Location) rely on WHOIS/ARIN registration data, BGP routing tables, and crowd-sourced probes — not GPS
- VPNs, proxies, and Tor exit nodes all substitute the user's real IP with an infrastructure IP, defeating geolocation-based defenses
- Geolocation is used in **geo-blocking** (restricting access by country) and **geo-fencing** (alerting on access outside defined regions) — both appear in access control policy questions
- On Security+/CySA+, IP geolocation commonly appears in the context of **threat intelligence enrichment** and **SIEM correlation rules**, not as a standalone authentication mechanism

## Related concepts
[[Threat Intelligence]] [[SIEM Correlation Rules]] [[Impossible Travel Detection]] [[VPN and Proxy Evasion]] [[Access Control Policies]]