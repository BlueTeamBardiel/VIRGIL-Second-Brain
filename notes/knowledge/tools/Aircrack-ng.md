---
domain: "wireless security"
tags: [wireless, wifi, password-cracking, packet-capture, penetration-testing, wpa2]
---
# Aircrack-ng

**Aircrack-ng** is an open-source [[Network Security]] suite specifically designed for auditing [[Wi-Fi]] network security, capable of performing **packet capture**, **replay attacks**, **deauthentication attacks**, and **WEP/WPA/WPA2 password cracking**. It operates against the [[IEEE 802.11]] wireless standard and is the industry-standard toolset for wireless penetration testing and security research. The suite is available on Linux, Windows, macOS, and BSD systems, though it performs best on Linux with compatible [[Network Interface Controller]] hardware supporting monitor mode and packet injection.

---

## Overview

Aircrack-ng evolved from the original Aircrack project created by Christophe Devine in 2004, later maintained and expanded by Thomas d'Otreppe de Bouvette. The "ng" suffix stands for "new generation," reflecting a significant rewrite and expansion of capabilities beyond what the original tool offered. Today it represents a complete ecosystem of individual utilities — each handling a specific phase of wireless auditing — rather than a monolithic application.

The suite was born out of a need to demonstrate and evaluate the practical weaknesses of wireless security protocols. **WEP (Wired Equivalent Privacy)** was already known to be cryptographically broken by the early 2000s, and Aircrack-ng gave security researchers a reliable, reproducible method to demonstrate that breakage to network administrators and organizations still deploying WEP infrastructure. This made it an essential tool in the shift toward WPA and eventually WPA2 adoption.

For **WPA/WPA2 networks**, Aircrack-ng operates fundamentally differently than it does against WEP. Rather than exploiting a mathematical flaw in the encryption, it captures the **4-way handshake** that occurs when a client authenticates to an access point, then performs offline dictionary or brute-force attacks against that captured handshake. This means the difficulty of cracking WPA2 comes down almost entirely to passphrase strength, and well-chosen passphrases remain computationally infeasible to crack even with modern hardware.

In a professional context, Aircrack-ng is used by penetration testers to demonstrate password weakness to clients, by network administrators auditing their own infrastructure, and by red teams simulating real-world adversaries targeting wireless networks. It is also commonly paired with tools like [[Hashcat]] for GPU-accelerated cracking after the handshake has been captured, as Aircrack-ng itself is CPU-bound. Its presence on [[Kali Linux]] and [[Parrot OS]] by default underscores its central role in the wireless security testing workflow.

The tool suite's effectiveness depends heavily on hardware compatibility. Chipsets such as the **Atheros AR9271**, **Ralink RT3070**, and **Alfa AWUS036ACH** are widely used in security testing because they reliably support monitor mode and packet injection — capabilities absent from many consumer wireless adapters. Without these capabilities, tools like `airodump-ng` and `aireplay-ng` simply cannot function.

---

## How It Works

### Tool Architecture

Aircrack-ng is not a single binary but a suite of coordinated tools:

| Tool | Function |
|---|---|
| `airmon-ng` | Enables/disables monitor mode on wireless interfaces |
| `airodump-ng` | Passive packet capture and network reconnaissance |
| `aireplay-ng` | Packet injection for replay, deauth, and other attacks |
| `aircrack-ng` | The actual key cracking engine (WEP/WPA/WPA2) |
| `airdecap-ng` | Decrypts captured WEP/WPA packets |
| `packetforge-ng` | Crafts encrypted packets for injection |
| `airbase-ng` | Creates rogue/fake access points |
| `airolib-ng` | Manages and queries precomputed PMK databases |

---

### Phase 1: Enable Monitor Mode

Before capturing any packets, the wireless interface must be placed in **monitor mode**, which allows it to passively receive all 802.11 frames in range rather than only those addressed to it.

```bash
# Check for processes that might interfere
sudo airmon-ng check kill

# Place interface wlan0 into monitor mode
sudo airmon-ng start wlan0

# Verify — the interface is now typically renamed wlan0mon
iwconfig
```

Monitor mode is distinct from **promiscuous mode** used on wired networks. On 802.11, monitor mode operates at Layer 2 and captures raw radio frames including management, control, and data frames.

---

### Phase 2: Reconnaissance with airodump-ng

With monitor mode active, `airodump-ng` scans all channels and displays visible access points and associated clients.

```bash
# Scan all channels for access points
sudo airodump-ng wlan0mon

# Lock onto a specific target network
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w capture_file wlan0mon
```

**Key flags:**
- `-c 6` — Lock to channel 6 (the target AP's channel)
- `--bssid` — Filter capture to a single access point MAC address
- `-w capture_file` — Write captured packets to files (`capture_file.cap`, `.csv`, etc.)

The output shows the **BSSID** (AP MAC), **ESSID** (network name), **channel**, **encryption type**, **cipher**, and **authentication method**, as well as a list of **stations** (clients) associated to each AP.

---

### Phase 3: Capture the WPA2 4-Way Handshake

WPA2-Personal authentication uses a **4-way handshake** to mutually verify that both the client and AP possess the **PSK (Pre-Shared Key)** without transmitting it. The handshake derives session keys using the **PBKDF2** key derivation function with **SSID as salt** and **4096 iterations of HMAC-SHA1**.

The handshake must be captured live. The fastest method is to force a client to re-authenticate using a **deauthentication attack**:

```bash
# Send deauth frames to a connected client (forces reconnect)
sudo aireplay-ng -0 5 -a AA:BB:CC:DD:EE:FF -c 11:22:33:44:55:66 wlan0mon
```

**Flags:**
- `-0 5` — Deauthentication attack, send 5 deauth frames
- `-a` — Target access point BSSID
- `-c` — Target client MAC address

When the client reconnects, `airodump-ng` will display `WPA handshake: AA:BB:CC:DD:EE:FF` in the top-right corner of its output, confirming capture.

---

### Phase 4: Crack the Handshake

```bash
# Dictionary attack against captured handshake
aircrack-ng -w /usr/share/wordlists/rockyou.txt -b AA:BB:CC:DD:EE:FF capture_file.cap

# Specify the ESSID explicitly (useful if not in capture)
aircrack-ng -w wordlist.txt -e "TargetNetwork" capture_file.cap
```

Aircrack-ng computes the **PMK (Pairwise Master Key)** for each candidate passphrase using:

```
PMK = PBKDF2(HMAC-SHA1, passphrase, SSID, 4096, 32)
```

It then derives the **PTK (Pairwise Transient Key)** and compares the resulting **MIC (Message Integrity Code)** against the one captured in the handshake. A match confirms the correct passphrase.

---

### WEP Cracking (Legacy)

WEP uses a flawed implementation of **RC4** with static IVs (Initialization Vectors). With enough IVs collected (typically 40,000–85,000), the key can be recovered statistically.

```bash
# Capture IVs with injection to speed up data collection
sudo aireplay-ng -3 -b AA:BB:CC:DD:EE:FF -h 11:22:33:44:55:66 wlan0mon

# Crack once enough IVs are captured
aircrack-ng -b AA:BB:CC:DD:EE:FF capture_file.cap
```

The PTW (Pyshkin, Tews, Weinmann) attack used by Aircrack-ng can crack a 104-bit WEP key in under a minute with sufficient IV data.

---

## Key Concepts

- **Monitor Mode**: A wireless interface operating mode that captures all 802.11 frames in range without being associated to any network; required for passive packet capture and differs from standard **managed mode** used for normal connectivity.

- **4-Way Handshake**: The WPA/WPA2 authentication mechanism between a client (**supplicant**) and access point (**authenticator**) that establishes session keys; capturing this handshake is the prerequisite for offline WPA2 cracking since it contains all material needed to verify passphrase guesses.

- **BSSID vs. ESSID**: The **BSSID** (Basic Service Set Identifier) is the MAC address of the access point radio, while the **ESSID** (Extended Service Set Identifier) is the human-readable network name; both are relevant in targeting specific networks during capture.

- **PMK (Pairwise Master Key)**: The 256-bit key derived from the WPA2 passphrase and SSID using PBKDF2; it is the fundamental secret from which all session keys are derived, and Aircrack-ng must compute this for every candidate password during cracking.

- **Deauthentication Attack (IEEE 802.11)**: An active attack exploiting the lack of authentication on 802.11 management frames; an attacker sends forged deauthentication frames bearing the AP's BSSID to force client disconnection, triggering a new authentication handshake that can be captured. This is addressed in [[WPA3]] via **Management Frame Protection (MFP)**.

- **Packet Injection**: The ability of a wireless interface to transmit arbitrary crafted 802.11 frames, required for active attacks like deauthentication and ARP replay; not all chipsets support this capability and it is hardware-dependent.

- **PMKID Attack**: An alternative to the 4-way handshake method discovered in 2018 that extracts a **PMKID** value directly from the first EAPOL frame sent by the access point, enabling offline cracking without requiring a connected client; supported in Aircrack-ng via `hcxdumptool`/`hcxtools` integration.

---

## Security Implications

### Attack Vectors Enabled

Aircrack-ng directly enables or facilitates several real-world attack vectors used by threat actors:

**Credential Theft via WPA2 Cracking**: An attacker within radio range passively captures a handshake (or forces one via deauth) and then performs offline cracking. Organizations using common words, company names, or short passphrases as Wi-Fi passwords are routinely compromised this way in red team engagements and actual intrusions.

**Evil Twin / Rogue AP**: Using `airbase-ng`, an attacker creates a fake access point mimicking a legitimate SSID. Clients associating with the rogue AP expose credentials and traffic. This is a primary vector in targeted attacks against corporate wireless networks.

**WEP Networks** (Legacy Risk): Despite WEP's deprecation, industrial control systems, legacy healthcare devices, and older embedded systems sometimes still operate on WEP networks. Aircrack-ng can crack these in under 60 seconds, representing an acute risk in those environments.

**PMKID Attack (CVE-adjacent)**: The 2018 discovery by Jens Steube (Hashcat developer) of the PMKID offline attack method demonstrated that WPA2-Personal is vulnerable even without any connected clients, significantly lowering the barrier for attacks on unoccupied networks.

### Detection Indicators

- **Deauthentication floods**: Wireless Intrusion Detection Systems ([[WIDS]]) such as those in Cisco Aironet, Meraki, or dedicated tools like **Kismet** flag bursts of deauthentication frames as indicative of active attacks.
- **Promiscuous/Monitor-mode interfaces**: Network management tools can sometimes detect neighboring interfaces in monitor mode through probe response analysis.
- **Unusual client disconnections**: Logs showing repeated client disconnections and reconnections in short windows are a behavioral indicator of deauth attacks.
- **Rogue AP detection**: Enterprise wireless controllers compare observed BSSIDs against known inventory and alert on unrecognized APs broadcasting legitimate ESSIDs.

---

## Defensive Measures

### Protocol-Level Defenses

**Deploy WPA3 (Wi-Fi Protected Access 3)**: WPA3 uses **SAE (Simultaneous Authentication of Equals)** — also known as the Dragonfly handshake — which replaces the PSK-based 4-way handshake. SAE provides **forward secrecy** and is resistant to offline dictionary attacks even if a handshake is captured, because it requires real-time interaction to verify each guess.

**Enable Management Frame Protection (802.11w / MFP)**: This standard cryptographically signs management frames including deauthentication and disassociation frames, neutralizing the deauth attack vector. In WPA3, MFP is mandatory. In WPA2, it should be explicitly enabled on all access points.

```
# Example Cisco IOS-based AP configuration
dot11 ssid CorporateWiFi
  authentication open
  authentication key-management wpa version 2
  mbssid guest-mode
  infrastructure-ssid optional
  wpa-psk ascii [REDACTED]
  management-frame-protection required
```

### Passphrase Strength

Use passphrases that defeat dictionary and brute-force attacks:
- **Minimum 20 characters** in length
- Include mixed case, digits, and symbols
- Avoid any dictionary words, company names, addresses, or phone numbers
- Consider a random character string generated by a password manager
- A 25-character random alphanumeric passphrase provides approximately 148 bits of entropy, making GPU cracking computationally infeasible

### Network Architecture

- **Segment wireless networks** using VLANs; place Wi-Fi clients in an untrusted segment requiring [[Firewall]] policy to reach internal resources
- **Deploy a Wireless Intrusion Prevention System (WIPS)**: Solutions like Cisco Adaptive wIPS, Aruba RFProtect, or open-source **Kismet** with alerting provide real-time detection of deauth attacks, rogue APs, and scanning
- **802.1X / EAP Authentication**: For enterprise environments, replace PSK with **WPA2/WPA3-Enterprise** using [[RADIUS]] and certificate-based EAP (EAP-TLS), eliminating the shared secret that Aircrack-ng targets entirely

### Monitoring and Response

```bash
# Use Kismet as a WIDS sensor
kismet --daemonize --log-prefix=/var/log/kismet/

# Alert rules in Kismet for deauth floods
# Edit kismet.conf:
# alert=DEAUTHFLOOD,5/min,10/5min
```

---

## Lab / Hands-On

### Lab Setup Requirements

- **Wireless adapter with monitor mode and injection support** (recommended: Alfa AWUS036ACH or AWUS036NHA)
- **Kali Linux** or Parrot OS VM/host
- A **separate test router** or **virtual AP** (never test against networks you don't own)
- A second wireless device to act as a client (phone or laptop)
- Wordlist: `/usr/share/wordlists/rockyou.txt` (on Kali) or download from SecLists

### Exercise 1: WPA2 Handshake Capture and Crack

```bash
# Step 1: Install/update aircrack-ng
sudo apt update && sudo apt install aircrack-ng -y

# Step 2: Identify your wireless interface
iwconfig
# Assume it's wlan0

# Step 3: Kill conflicting processes and enable monitor mode
sudo airmon-ng check kill
sudo airmon-ng start wlan0
# Interface is now wlan0mon

# Step 4: Scan for networks
sudo airodump-ng wlan0mon
# Note the BSSID and channel of your test AP — e.g