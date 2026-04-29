# Geofencing

## What it is
Think of it like an invisible electric dog fence: the dog's collar triggers an alarm the moment it crosses the buried perimeter wire. Geofencing creates virtual geographic boundaries using GPS, Wi-Fi, cellular, or RFID signals, and automatically triggers security policy changes when a device or user crosses those boundaries. It's used to enforce location-based access controls without requiring manual intervention.

## Why it matters
A financial institution deploys geofencing so that its mobile banking app automatically disables high-value wire transfer functionality whenever the authenticating device is detected outside the United States. When attackers in Eastern Europe compromise stolen credentials, the geofence blocks the transaction attempt before it completes — acting as a compensating control when MFA has already been bypassed. This is a real pattern used by banks to limit fraud from credential stuffing campaigns.

## Key facts
- Geofencing is a **detective and preventive control** — it can log boundary crossings and actively block access simultaneously
- Common implementation signals: **GPS** (outdoor precision), **Wi-Fi triangulation** (indoor), **cellular tower data**, and **IP geolocation** (least precise, easily spoofed with VPN)
- IP-based geofencing is the weakest form — VPNs and Tor trivially bypass it; hardware GPS is significantly harder to spoof
- On Security+/CySA+, geofencing appears under **mobile device management (MDM)**, **context-aware authentication**, and **zero trust** policy enforcement topics
- Can be used offensively: malware has used geofencing to **remain dormant outside target regions**, evading sandbox analysis running in foreign cloud data centers

## Related concepts
[[Mobile Device Management]] [[Context-Aware Authentication]] [[Zero Trust Architecture]] [[IP Geolocation]] [[Compensating Controls]]