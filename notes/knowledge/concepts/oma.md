# oma

## What it is
Like a master key that opens every lock in a building regardless of which tenant changed their individual deadbolt, an OMA (Open Mobile Alliance) specification defines standardized protocols for device management and content delivery across mobile networks. OMA frameworks — particularly OMA DM (Device Management) and OMA CP (Client Provisioning) — allow carriers and administrators to push configuration settings directly to mobile devices over-the-air.

## Why it matters
In 2019, researchers demonstrated that OMA CP messages could be spoofed without authentication on many Android devices, allowing an attacker within GSM range to send fraudulent provisioning messages that silently rerouted a victim's email and browser traffic through an attacker-controlled proxy. Because OMA CP lacks mandatory sender authentication, carriers and handset manufacturers had to issue emergency patches — illustrating how legacy mobile standards create systemic vulnerabilities affecting millions of devices simultaneously.

## Key facts
- **OMA DM** uses a challenge-response authentication model but early implementations allowed unauthenticated or weakly authenticated sessions, enabling unauthorized device configuration
- **OMA CP spoofing** exploits the absence of mandatory USERPIN verification — attackers can craft malicious WAP Push messages with a Class 2 message type that auto-processes on vulnerable devices
- The attack vector is classified as **Physical/Adjacent** in CVSS because it requires radio proximity (GSM network or femtocell)
- OMA-related vulnerabilities are relevant to **mobile device management (MDM)** security assessments and carrier-grade penetration testing
- Mitigations include enforcing OMA DM **TLS mutual authentication**, disabling WAP Push processing on unmanaged devices, and validating provisioning message origin through carrier-side controls

## Related concepts
[[WAP Push]] [[Mobile Device Management]] [[Over-the-Air Updates]] [[SMS Spoofing]] [[BYOD Security]]