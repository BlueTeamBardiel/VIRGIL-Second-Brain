# Securing Wireless and Mobile

## What it is

In Forza, you tune a car for a specific track — adjusting tire pressure, gear ratios, and aero downforce so the vehicle survives the corners at Maple Valley instead of understeering into a wall. That's exactly what securing wireless and mobile does — you tune the radios, authentication, and device controls for the environment they actually operate in, because the default setup loses the race.

Securing wireless and mobile is the application of cryptographic protocols, authentication frameworks, network architectures, and endpoint controls to protect 802.11 networks and portable computing devices from unauthorized access, eavesdropping, and data leakage.

## Why it matters

Wireless is the perimeter that walks out the door. A misconfigured WPA2-PSK with a weak passphrase becomes an offline cracking exercise; a rogue access point hands attackers a man-in-the-middle seat; a lost phone with no MDM policy becomes the breach. SY0-701 Objective 4.1 requires candidates to know **WPA3**, **AAA/RADIUS/802.1X**, **EAP variants**, and mobile deployment models — the trap CompTIA loves is asking which EAP method requires certificates on both sides ([[EAP-TLS]]) versus only the server ([[PEAP]] / [[EAP-TTLS]]).

## Key facts

### Wireless encryption protocols

| Protocol | Cipher | Key Exchange | Status |
|----------|--------|--------------|--------|
| [[WEP]] | RC4 | Static key | Broken — do not use |
| [[WPA]] | RC4 + TKIP | PSK | Deprecated |
| [[WPA2]] | AES-CCMP | PSK or 802.1X | Acceptable, vulnerable to KRACK |
| [[WPA3]] | AES-GCMP-256 | [[SAE]] (Simultaneous Authentication of Equals) | Current standard |

**WPA3** replaces the WPA2 four-way handshake with **SAE**, a Dragonfly key exchange that resists offline dictionary attacks and provides **forward secrecy**. **Management Frame Protection (MFP)** is mandatory in WPA3.

### Authentication architectures

- **[[WPA3-Personal]]** — SAE with a passphrase, suitable for SOHO.
- **[[WPA3-Enterprise]]** — uses [[802.1X]] with a [[RADIUS]] server (UDP **1812** auth, **1813** accounting). 192-bit mode required for CNSA compliance.
- **[[AAA framework]]** — Authentication, Authorization, Accounting. RADIUS or [[TACACS+]] (TCP **49**, encrypts the entire payload, Cisco-flavored).

### EAP methods (memorize the certificate requirements)

| Method | Server Cert | Client Cert | Notes |
|--------|-------------|-------------|-------|
| [[EAP-TLS]] | Required | **Required** | Strongest; mutual cert auth |
| [[EAP-TTLS]] | Required | No | Tunnel, then inner auth |
| [[PEAP]] | Required | No | TLS tunnel + MSCHAPv2 inside |
| [[EAP-FAST]] | Optional (PAC) | No | Cisco; uses Protected Access Credential |

### Wireless attacks

- **[[Evil twin]]** — rogue AP cloning the legitimate SSID.
- **[[Rogue access point]]** — unauthorized AP plugged into the corporate LAN.
- **[[Deauthentication attack]]** — forged 802.11 deauth frames; mitigated by **MFP**.
- **[[KRACK]]** — Key Reinstallation Attack against WPA2 four-way handshake.
- **[[Disassociation]]** and **jamming** — Layer 1/2 denial of service.
- **[[WPS]] PIN brute force** — disable WPS.

### Mobile deployment models

| Model | Who owns | Who controls | Use case |
|-------|----------|--------------|----------|
| [[BYOD]] | Employee | Shared | Cheap, messy |
| [[CYOD]] | Employer | Employer | Choose from approved list |
| [[COPE]] | Employer | Employer + personal use | Common enterprise |
| [[COBO]] | Employer | Employer only | High security |

### Mobile security controls

- **[[MDM]]** / **[[UEM]]** — enforce passcode, encryption, [[remote wipe]], app allow/deny lists.
- **[[Containerization]]** — separate work and personal data partitions.
- **[[Geofencing]]** and **[[geolocation]]** — policy triggers based on location.
- **[[Full device encryption]]** — required by most compliance regimes.
- **[[Jailbreaking]]** / **[[rooting]]** detection — flag devices with broken sandboxing.
- **[[Sideloading]]** — installing apps outside official stores; usually blocked.

### Site survey and design

- **[[Site survey]]** — measure RF coverage and interference before deployment.
- **[[Heat map]]** — visual signal-strength overlay on a floor plan.
- **Channel selection** — 2.4 GHz uses non-overlapping **1, 6, 11**; 5 GHz and 6 GHz (Wi-Fi 6E) have many more.

## Related concepts

[[802.1X]] · [[RADIUS]] · [[WPA3]] · [[EAP-TLS]] · [[Evil twin]] · [[MDM]] · [[BYOD]] · [[SAE]] · [[Site survey]] · [[Containerization]]

---
*Source: VIRGIL knowledge base — 2026-05-08*