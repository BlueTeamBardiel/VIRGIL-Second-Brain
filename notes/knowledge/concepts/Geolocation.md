# Geolocation

## What it is
Like a detective triangulating a suspect's position from cell tower pings in a crime drama, geolocation is the process of determining a device's or user's physical location using digital signals. Precisely, it maps an IP address, GPS coordinates, Wi-Fi positioning, or cell tower data to a geographic location. It operates at multiple layers — from coarse country-level IP mapping to meter-accurate GPS fixes.

## Why it matters
A threat analyst investigating a brute-force login campaign notices all authentication attempts originate from IP ranges geolocating to a country the organization has no business relationship with — triggering an automatic geo-blocking rule that drops the traffic at the firewall perimeter. Conversely, attackers use VPNs and proxy chains to spoof geolocation data, bypassing these same controls and appearing to originate from a trusted region.

## Key facts
- **IP-based geolocation** is inherently imprecise — databases like MaxMind map IPs to approximate regions, often with city-level accuracy of ~80% but lower for residential or VPN-routed addresses
- **Geo-blocking** (geographic access control) is a defense-in-depth measure, not a primary control — it is trivially bypassed using Tor, VPNs, or compromised hosts in allowed regions
- **OPSEC failure via metadata**: photos taken on smartphones embed GPS coordinates in EXIF data, which has been used to physically locate journalists, activists, and military personnel
- **Compliance relevance**: GDPR and data sovereignty laws require knowing where data subjects are located, making geolocation a legal — not just technical — control
- **Browser Geolocation API** (HTML5) requests explicit user permission and returns GPS/Wi-Fi coordinates; if abused by malicious scripts, it can expose precise physical location without the user understanding the risk

## Related concepts
[[IP Address Tracking]] [[OSINT]] [[EXIF Metadata]] [[VPN]] [[Geo-blocking]]