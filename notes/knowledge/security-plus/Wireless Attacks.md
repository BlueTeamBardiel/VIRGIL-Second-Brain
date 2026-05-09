# Wireless Attacks

## What it is

In Subnautica, you're scanning the seabed when the radio chirps with a distress signal — but it's bait. The Degasi crew learned the hard way that a friendly-sounding broadcast in deep water can lead you straight into a Reaper Leviathan's jaws. That's exactly what wireless attacks do — they exploit the fact that radio signals travel invisibly through open space, and anyone within range can listen, lie, or lure.

**Wireless attacks** are exploits targeting the confidentiality, integrity, or availability of [[802.11]], [[Bluetooth]], [[RFID]], or [[NFC]] communications by abusing the broadcast nature of radio frequency transmission.

## Why it matters

Wireless is the soft underbelly of most enterprise networks: physical access controls mean nothing when the attacker is sitting in the parking lot with a directional antenna. A successful [[Evil Twin]] attack harvests credentials, an [[Authentication]]-frame [[Deauthentication Attack]] knocks payment terminals offline during peak hours, and a rogue access point creates an unmonitored backdoor that bypasses every firewall you own.

**Exam angle:** Objective 2.4 lists wireless attacks under network attacks. CompTIA's favorite trap is the **Evil Twin vs. Rogue AP** distinction — they are not synonyms. Another classic: confusing **deauthentication** (a [[DoS]] technique) with **disassociation**, and missing that both exploit unprotected [[Management Frames]] in pre-[[802.11w]] networks.

## Key facts

### Core wireless attack types

| Attack | Mechanism | Primary Goal |
|---|---|---|
| [[Rogue Access Point]] | Unauthorized AP plugged into corporate LAN | Backdoor / bypass perimeter |
| [[Evil Twin]] | Attacker AP mimics legitimate [[SSID]] | Credential theft, [[MITM]] |
| [[Deauthentication Attack]] | Forged 802.11 deauth frames | DoS; force re-association to evil twin |
| [[Disassociation Attack]] | Forged disassociation frames | DoS variant |
| [[Jamming]] | RF noise floods the channel | Pure availability denial |
| [[RFID Cloning]] | Read and replay badge data | Physical access bypass |
| [[NFC Attack]] | Relay or skim short-range comms | Payment fraud, badge clone |
| [[Bluejacking]] | Unsolicited messages over Bluetooth | Nuisance / social engineering |
| [[Bluesnarfing]] | Unauthorized data theft via Bluetooth | Data exfiltration |
| [[Bluebugging]] | Full remote control of Bluetooth device | Surveillance, command exec |
| [[KRACK]] | Key Reinstallation Attack on [[WPA2]] 4-way handshake | Decrypt traffic |
| [[Initialization Vector]] (IV) attack | Exploits weak IVs in [[WEP]] | Key recovery |

### Rogue AP vs. Evil Twin (the classic trap)

- **Rogue AP**: an *unauthorized* AP attached to your network. May be malicious or just an employee's personal router. The threat is **internal connectivity bypass**.
- **Evil Twin**: an AP that **impersonates a legitimate SSID** to lure clients. The threat is **client-side credential and traffic capture**. Often paired with a deauth attack to force victims off the real AP.

### Attack enablers

- **[[Probe Requests]]**: clients shout the names of remembered networks. Tools like [[Wifi Pineapple]] auto-respond as whatever SSID is requested.
- **Unprotected management frames**: pre-[[802.11w]] (Protected Management Frames / PMF), deauth and disassoc frames are unauthenticated. Anyone can forge them.
- **Weak protocols**: [[WEP]] (broken), [[WPA]] with TKIP (broken), [[WPS]] PIN (brute-forceable in hours).

### Defenses (know these for the exam)

| Defense | What it stops |
|---|---|
| [[WPA3]] with [[SAE]] (Simultaneous Authentication of Equals) | Offline dictionary attacks, KRACK |
| [[802.11w]] / Protected Management Frames | Deauth and disassociation attacks |
| [[802.1X]] / [[EAP]]-TLS with [[RADIUS]] | Rogue clients, credential reuse |
| [[Wireless Intrusion Prevention System]] (WIPS) | Rogue APs, evil twins, jamming detection |
| Disabling [[WPS]] | PIN brute force |
| [[Site Survey]] and signal containment | Parking-lot eavesdroppers |
| MAC randomization on clients | Probe-request tracking |

### Memorize the Bluetooth trio

- **Bluejacking** = sending (annoyance)
- **Bluesnarfing** = stealing (data theft)
- **Bluebugging** = controlling (full compromise)

Alphabetical severity. Convenient.

## Related concepts

[[WPA3]] · [[802.1X]] · [[EAP]] · [[RADIUS]] · [[WIPS]] · [[SSID]] · [[KRACK]] · [[Wardriving]] · [[Wifi Pineapple]] · [[Management Frames]] · [[MITM]] · [[Captive Portal]]

---
*Source: VIRGIL knowledge base — 2026-05-08*