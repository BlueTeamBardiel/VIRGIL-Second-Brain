# Location Tracking

## What it is
Like a bloodhound following a scent trail you didn't know you were leaving, location tracking is the continuous or periodic collection of a device's or person's geographic position through technical signals. Precisely: it is the process of determining and recording physical location using GPS, cell tower triangulation, Wi-Fi positioning, Bluetooth beacons, or IP geolocation — often without explicit user awareness.

## Why it matters
In 2021, a Catholic news outlet used commercially available location data purchased from a data broker to track a priest's visits to gay bars via his phone's advertising ID — no hacking required, just buying legally sold data. This illustrates why location data is treated as PII under regulations like GDPR and CCPA, and why attackers targeting individuals for physical surveillance or stalkerware campaigns prize it highly.

## Key facts
- **Four primary technical methods**: GPS (most precise, ~3m), cell tower triangulation (~300m), Wi-Fi positioning (~15m using BSSID databases), and IP geolocation (city-level only, ~50km error)
- **IMSI catchers (Stingrays)** impersonate cell towers to force phones to reveal location and identity — a law enforcement tool also used by adversaries
- **Advertising IDs** (IDFA on iOS, GAID on Android) allow third-party SDKs to build location histories without accessing GPS directly
- **Metadata in photos** (EXIF data) can embed GPS coordinates, leaking precise location when images are shared — a classic OSINT vector
- Under **CompTIA Security+**, location tracking appears under privacy controls, mobile device management (MDM), and geofencing security policies

## Related concepts
[[OSINT]] [[IMSI Catcher]] [[Mobile Device Management]] [[Geofencing]] [[Privacy Regulations]]