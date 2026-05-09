# Wireless Security Settings

## What it is

In Need for Speed: Most Wanted, joining a pursuit-free safehouse means proving you belong — the cops outside can't hear what's said inside, and only drivers with the right credentials roll through the gate. That's exactly what wireless security settings do — they decide who can connect to your Wi-Fi, how their traffic is scrambled in the air, and how the access point verifies they're not a Blacklist racer in disguise.

**Wireless security settings** are the configuration parameters on a wireless network — encryption protocol, authentication method, and key/credential management — that protect confidentiality, integrity, and access control of 802.11 traffic.

## Why it matters

Wireless traffic is broadcast through the air; anyone within range with a directional antenna and `aircrack-ng` is sitting in your conference room. Misconfigured Wi-Fi enables **eavesdropping**, **evil twin** attacks, **credential theft**, and lateral movement into the wired LAN — and PCI-DSS, HIPAA, and most enterprise frameworks fail audit on a single open SSID. Exam angle: SY0-701 Objective 4.1 explicitly lists **WPA3**, **AAA/RADIUS**, **cryptographic protocols**, and **authentication protocols** as wireless security settings — CompTIA's favorite trap is mixing up **WPA3-Personal (SAE)** with **WPA3-Enterprise (802.1X)**, or asking which protocol replaced PSK's offline dictionary weakness.

## Key facts

### Encryption protocols (the air scrambler)

| Protocol | Year | Cipher | Status | Notes |
|---|---|---|---|---|
| [[WEP]] | 1999 | RC4 | Broken | Cracked in minutes; never use |
| [[WPA]] | 2003 | RC4 + TKIP | Deprecated | Stopgap for WEP hardware |
| [[WPA2]] | 2004 | AES-CCMP | Legacy-acceptable | Vulnerable to [[KRACK]] and offline PSK cracking |
| **[[WPA3]]** | 2018 | AES-GCMP-256 (Enterprise) | **Current standard** | Adds **SAE**, **PMF**, forward secrecy |

### WPA3 specifics (exam favorite)

- **[[SAE]]** (Simultaneous Authentication of Equals) — replaces the WPA2 4-way handshake PSK with a **Dragonfly** key exchange. Defeats offline dictionary attacks because each handshake requires live interaction with the AP.
- **[[PMF]]** (Protected Management Frames, 802.11w) — **mandatory** in WPA3. Stops **deauthentication attacks** that previously let attackers force clients off the network to capture handshakes.
- **Forward secrecy** — capturing today's traffic and cracking the password tomorrow no longer decrypts it.
- **[[Wi-Fi Enhanced Open]]** (OWE) — opportunistic encryption for "open" guest networks; no password, but traffic is still encrypted.

### Authentication modes

| Mode | Use case | Mechanism |
|---|---|---|
| **[[WPA3-Personal]]** | Home, small office | SAE with shared passphrase |
| **[[WPA3-Enterprise]]** | Corporate | [[802.1X]] + [[EAP]] + [[RADIUS]] |
| **[[WPS]]** | Convenience (avoid) | 8-digit PIN, brute-forceable in hours |

### 802.1X / AAA framework

Three actors: **[[Supplicant]]** (the laptop) → **[[Authenticator]]** (the AP/switch) → **[[Authentication Server]]** (RADIUS, UDP **1812** auth / **1813** accounting; TACACS+ TCP **49** for admin). The AP speaks **EAPOL** to the client and **RADIUS** to the server.

### EAP variants (know these cold)

| EAP type | Server cert | Client cert | Notes |
|---|---|---|---|
| **[[EAP-TLS]]** | Yes | **Yes** | Strongest; mutual cert auth |
| **[[EAP-TTLS]]** | Yes | No | Tunnels legacy auth inside TLS |
| **[[PEAP]]** | Yes | No | Microsoft/Cisco; tunnels MSCHAPv2 |
| **[[EAP-FAST]]** | Optional | No | Cisco; uses PAC instead of cert |

### Other settings that show up on the exam

- **[[SSID]] broadcast** — disabling it is security theater; tools see hidden SSIDs in seconds.
- **[[MAC filtering]]** — also theater; MACs are sniffable and spoofable.
- **[[Captive portal]]** — Layer 7 auth gate, common for guest networks.
- **Channel and band selection** — operational, not security, but relevant to **jamming** and **interference** attacks.
- **Transmit power** — turn it down at the perimeter to reduce parking-lot attack surface.

### Attacks these settings defend against

- [[Evil twin]] / [[Rogue AP]] — defended by 802.1X server cert validation.
- [[Deauthentication attack]] — defended by PMF.
- [[Offline dictionary attack]] on PSK — defended by SAE.
- [[KRACK]] — patched in WPA2, structurally absent in WPA3.
- [[WPS PIN brute force]] — defended by disabling WPS.

## Related concepts

[[802.1X]] · [[RADIUS]] · [[EAP-TLS]] · [[WPA3]] · [[SAE]] · [[PMF]] · [[Evil twin]] · [[Captive portal]] · [[Pre-shared key]] · [[Wi-Fi Enhanced Open]]

---
*Source: VIRGIL knowledge base — 2026-05-08*