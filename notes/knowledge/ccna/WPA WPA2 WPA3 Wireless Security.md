# WPA WPA2 WPA3 Wireless Security

## What it is

In Bioshock, getting into Rapture isn't a matter of knowing the right door — it's a matter of having the right genetic key, and even then Ryan keeps tightening the rules: first a bathysphere code, then ADAM-locked gene barriers, then the "Would You Kindly" trigger that proves you really are who you claim to be. WPA generations are the same escalating bouncer at the Wi-Fi door — each version assumes the last one was already pried open by splicers.

**WPA/WPA2/WPA3** are the IEEE/Wi-Fi Alliance security suites that authenticate wireless clients and encrypt their traffic over [[802.11]] links, replacing the broken [[WEP]] standard.

## Why it matters

Wireless traffic is broadcast into the air whether you like it or not. If the encryption is weak, anyone within RF range — parking lot, next office, drone overhead — captures your handshake and cracks it offline. WEP falls in minutes, WPA-TKIP falls in hours, WPA2-PSK falls to dictionary attacks on captured 4-way handshakes, and WPA3 is the current answer. **The CCNA expects you to know which cipher pairs with which generation, and which mode (Personal vs Enterprise) belongs in which deployment.**

## Key facts

### The generations

| Standard | Year | Cipher | Integrity | Handshake | Status |
|---|---|---|---|---|---|
| [[WEP]] | 1997 | RC4 (40/104-bit) | CRC-32 | Shared key | **Dead.** Crackable in minutes. |
| [[WPA]] | 2003 | RC4 + [[TKIP]] | MIC (Michael) | 4-way | Deprecated 2012 |
| [[WPA2]] | 2004 | AES-[[CCMP]] | CCMP | 4-way | Vulnerable to [[KRACK]], offline dict attack |
| [[WPA3]] | 2018 | AES-[[GCMP]]-256 (Ent), CCMP-128 (Pers) | GCMP/CCMP | [[SAE]] (Dragonfly) | Current |

### Why WEP is dead

- **RC4 with a 24-bit IV** — IVs repeat after ~5,000 packets on a busy network.
- Tools like `aircrack-ng` recover the key from captured IVs in minutes.
- Integrity check is CRC-32, which is linear and forgeable.
- Do not deploy. Do not "leave it on for the printer." Replace the printer.

### WPA (the band-aid)

- Designed to run on **WEP-era hardware** via firmware update.
- [[TKIP]] = Temporal Key Integrity Protocol: per-packet key mixing, sequence counter, 64-bit MIC.
- Still uses RC4. Vulnerable to **Beck-Tews** and chop-chop attacks.
- Wi-Fi Alliance deprecated TKIP in 2012.

### WPA2 — the workhorse (IEEE 802.11i)

- **AES-CCMP**: AES in Counter Mode with CBC-MAC. 128-bit key, hardware-accelerated.
- Mandatory since 2006 for Wi-Fi certification.
- Two modes:
  - **WPA2-Personal (PSK)**: pre-shared key, hashed via PBKDF2 into the PMK. Vulnerable to **offline dictionary attack** on a captured 4-way handshake.
  - **WPA2-Enterprise**: [[802.1X]]/[[EAP]] authentication against a [[RADIUS]] server. Per-user credentials, per-session keys.
- **[[KRACK]]** (2017): key reinstallation attack on the 4-way handshake — patched, but the protocol design was the problem.

### WPA3 — the current answer

- **[[SAE]]** (Simultaneous Authentication of Equals), aka **Dragonfly handshake**, replaces PSK exchange.
  - Resistant to **offline dictionary attacks** — each guess requires a live interaction with the AP.
  - Provides **forward secrecy**: capturing today's traffic doesn't decrypt tomorrow's, even if the password leaks later.
- **Protected Management Frames (PMF)** mandatory — kills deauth attacks.
- **WPA3-Personal**: SAE replaces PSK.
- **WPA3-Enterprise**: 192-bit security suite (CNSA), GCMP-256, HMAC-SHA384.
- **[[OWE]]** (Opportunistic Wireless Encryption) for open networks — encrypted without authentication.
- **Wi-Fi Easy Connect (DPP)** replaces WPS.

### Personal vs Enterprise — exam angle

| | Personal | Enterprise |
|---|---|---|
| Auth | Shared password | Per-user via [[RADIUS]] |
| Key derivation | PBKDF2(passphrase) → PMK | EAP method → MSK → PMK |
| Where used | Home, small office | Corporate, campus, eduroam |
| Revocation | Change PSK, retell everyone | Disable user in AAA |
| Standards | — | [[802.1X]] + EAP-TLS / PEAP / EAP-TTLS |

### Cisco WLC config snippets

```
config wlan security wpa enable <wlan-id>
config wlan security wpa wpa2 enable <wlan-id>
config wlan security wpa wpa2 ciphers aes enable <wlan-id>
config wlan security wpa akm psk enable <wlan-id>
config wlan security wpa akm psk set-key ascii <passphrase> <wlan-id>
```

For Enterprise:

```
config wlan security wpa akm 802.1x enable <wlan-id>
config wlan radius_server auth add <wlan-id> <server-index>
```

### What to remember for the test

- **WEP = broken**, WPA = TKIP/RC4, WPA2 = AES/CCMP, WPA3 = SAE + GCMP.
- **PSK** is Personal; **802.1X/EAP/RADIUS** is Enterprise.
- WPA3 brings **forward secrecy** and **offline-dictionary resistance**.
- **PMF** is mandatory in WPA3, optional in WPA2.

## Related concepts

[[802.11]] · [[802.1X]] · [[RADIUS]] · [[EAP]] · [[TKIP]] · [[CCMP]] · [[SAE]] · [[KRACK]] · [[WEP]] · [[PMF]] · [[OWE]] · [[Wireless LAN Controller]]

---
*Source: VIRGIL knowledge base — 2026-05-07*